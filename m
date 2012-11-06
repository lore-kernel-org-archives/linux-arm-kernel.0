From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Tue, 6 Nov 2012 10:09:14 +0000
Subject: [PATCH 08/15] ARM: OMAP2+: hwmod: Fix the omap_hwmod_addr_space
 for CPGMAC0
In-Reply-To: <5098D889.60909@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-9-git-send-email-vaibhav.bedia@ti.com>
 <509543E8.60209@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EC00B9B@DBDE01.ent.ti.com>
 <5098D889.60909@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC049E4@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2012 at 14:59:45, Hiremath, Vaibhav wrote:
[...]
> > 
> > Ok I checked this one. The change I made was indirectly fixing another
> > issue with the AM33xx hwmod data. am33xx_cpgmac0_addr_space[] has two
> > entries and the SYSC register is part of the second entry. The function
> > _find_mpu_rt_addr_space in omap_hwmod.c looks for the first entry with
> > the flag ADDR_TYPE_RT flag. The change I made indirectly made the second
> > entry in am33xx_cpgmac0_addr_space[] become the first memory space with
> > the ADDR_TYPE_RT flag. Due to this the hwmod code wrote to the correct
> > SYSC address of CPGMAC0 and the IP went to standby during bootup. 
> > After changing the order of the entries in am33xx_cpgmac0_addr_space[]
> > things work fine.
> > 
> 
> Good catch.
> 
> Just a side note on this, driver expects the addresses in this order
> only, first SS and then WR.
> 

Sorry I didn't understand your comment. For HWMOD code to work as expected,
we need to change the order. Are you saying that I should not be doing this
because the driver will get affected?

Regards,
Vaibhav
