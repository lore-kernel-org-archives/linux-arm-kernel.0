From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Tue, 8 Sep 2015 15:01:07 +0000
Subject: [PATCH v8 2/2] ARM: imx: support suspend states on imx7D
In-Reply-To: <20150907151106.GA30723@tiger>
References: <1438378439-11569-1-git-send-email-shenwei.wang@freescale.com>
 <1438378439-11569-3-git-send-email-shenwei.wang@freescale.com>
 <20150907151106.GA30723@tiger>
Message-ID: <CY1PR0301MB084344B059A4178B09E949DF83530@CY1PR0301MB0843.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> > This patch adds a new suspend driver to manage the power states on IMX7D.
> > It currently supports "SUSPEND_STANDBY" and "SUSPEND_MEM" states.
> >
> > Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
> > Signed-off-by: Anson Huang <b20788@freescale.com>
> 
> Please stop sending patches to my Linaro mailbox, and use
> shawnguo at kernel.org instead.  You should already get that if you ever
> run ./scripts/get_maintainer.pl on the patch.  Also please always copy
> kernel at pengutronix.de for i.MX platform patches like this.

Noted.

> > ---
> >  arch/arm/mach-imx/Kconfig        |   1 +
> >  arch/arm/mach-imx/Makefile       |   2 +
> >  arch/arm/mach-imx/common.h       |   4 +
> >  arch/arm/mach-imx/pm-imx7.c      | 917
> +++++++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-imx/suspend-imx7.S | 529 ++++++++++++++++++++++
> >  5 files changed, 1453 insertions(+)
> 
> 1453 lines addition to kernel only for i.MX7D suspend support.  Yes, this is the
> way we support suspend on i.MX6, but that's enough, and we have to stop this
> somewhere.  I would ask you to take Sudeep's comment and adopt PSCI for
> i.MX7D power management.

According to PSCI spec, a supervisory software must be implemented under either
HVC(EL2) or SMC(EL3) privilege level. I agree that, with this idea, we could finally move 
these 1453 lines of codes from kernel into a platform specific firmware. The problem
is we don't have the firmware so far, and we haven't even had a plan to enable the
hypervisor or secure software on this platform. Because low power consumption is
the key feature of this i.MX7D platform, please continue to consider the current 
implementation and get this feature supported first. 

Thanks,
Shenwei

 
> Shawn
> 
> [1] https://lkml.org/lkml/2015/8/26/554
