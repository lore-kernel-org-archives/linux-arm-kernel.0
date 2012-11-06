From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Tue, 6 Nov 2012 13:06:21 +0000
Subject: [PATCH 3/8] ARM: OMAP: AM33xx hwmod: Add parent-child
 relationship for PWM subsystem
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EC049D9@DBDE01.ent.ti.com>
References: <1352106749-9437-1-git-send-email-avinashphilip@ti.com>
 <1352106749-9437-4-git-send-email-avinashphilip@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EC049D9@DBDE01.ent.ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EB64313@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2012 at 15:39:11, Bedia, Vaibhav wrote:
> On Mon, Nov 05, 2012 at 14:42:24, Philip, Avinash wrote:
> [...]
> 
> > +
> > +static struct omap_hwmod_ocp_if am33xx_epwmss0__ecap0 = {
> > +	.master		= &am33xx_epwmss0_hwmod,
> > +	.slave		= &am33xx_ecap0_hwmod,
> > +	.clk		= "l4ls_gclk",
> > +	.addr		= am33xx_ecap0_addr_space,
> > +	.user		= OCP_USER_MPU,
> > +};
> 
> Noticed this in another patch which is quite similar so commenting here
> again. Is the user field required if you are just creating a parent-child
> relationship here?
> 

I think user field is not related to parent-child nodes, it defines the initiator to interact with hwmod

Copy-pasted from "arch/arm/plat-omap/include/plat/omap_hwmod.h"

"indicate the initiators that use this interface to interact with the 
hwmod"

And in this case, its MPU is the initiator to interact with this interface.


Thanks,
Vaibhav
> Regards,
> Vaibhav 
> 
> 
