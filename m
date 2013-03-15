From: avinashphilip@ti.com (Philip, Avinash)
Date: Fri, 15 Mar 2013 04:57:54 +0000
Subject: [PATCH 2/3] ARM: davinci: da850: Enable EHRPWM TBCLK from
 CFG_CHIP1
In-Reply-To: <5141CA40.9010005@ti.com>
References: <1363257453-24747-1-git-send-email-avinashphilip@ti.com>
 <1363257453-24747-3-git-send-email-avinashphilip@ti.com>
 <5141CA40.9010005@ti.com>
Message-ID: <518397C60809E147AF5323E0420B992E3EA97355@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 18:31:52, Nori, Sekhar wrote:
> On 3/14/2013 4:07 PM, Philip Avinash wrote:
> > da850 platforms require TBCLK synchronization in CFG_CHIP1 register for
> > TBCLK enable in EHRPWM modules. Enabling of TBCLK is done only if EHRPWM
> > DT node status is set to "okay" DT blob.
> > Also adds macro definitions for DA8XX_EHRPWM_TBCLKSYNC and
> > DA8XX_CFGCHIP1_REG.
> 
> So there is actually a TBCLK in DA850 - it's just not modeled as a clock
> similar to the way it is done on AM335x? If yes, then instead of adding
> a dummy clock node and doing the TBCLK enable as part of init, why not
> model TBCLK in clock tree even on DA850?


TBCLK enabling should done from platform specific way. In DA850 it is done at
CFGCHIP1 register. Unfortunately Davinci clock frame work will support only
clock nodes inside PLLC and PSC modules. Handling of CFGCHP1 require
modifications in clock frame work.

Hence handling it as part of initialization.

Thanks
Avinash

> 
> Thanks,
> Sekhar
> 
