From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 18 Sep 2015 22:15:24 +0800
Subject: [PATCH v8 2/2] ARM: imx: support suspend states on imx7D
In-Reply-To: <CY1PR0301MB084344B059A4178B09E949DF83530@CY1PR0301MB0843.namprd03.prod.outlook.com>
References: <1438378439-11569-1-git-send-email-shenwei.wang@freescale.com>
 <1438378439-11569-3-git-send-email-shenwei.wang@freescale.com>
 <20150907151106.GA30723@tiger>
 <CY1PR0301MB084344B059A4178B09E949DF83530@CY1PR0301MB0843.namprd03.prod.outlook.com>
Message-ID: <20150918141524.GC3770@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 08, 2015 at 03:01:07PM +0000, Shenwei Wang wrote:
> > >  arch/arm/mach-imx/Kconfig        |   1 +
> > >  arch/arm/mach-imx/Makefile       |   2 +
> > >  arch/arm/mach-imx/common.h       |   4 +
> > >  arch/arm/mach-imx/pm-imx7.c      | 917
> > +++++++++++++++++++++++++++++++++++++++
> > >  arch/arm/mach-imx/suspend-imx7.S | 529 ++++++++++++++++++++++
> > >  5 files changed, 1453 insertions(+)
> > 
> > 1453 lines addition to kernel only for i.MX7D suspend support.  Yes, this is the
> > way we support suspend on i.MX6, but that's enough, and we have to stop this
> > somewhere.  I would ask you to take Sudeep's comment and adopt PSCI for
> > i.MX7D power management.
> 
> According to PSCI spec, a supervisory software must be implemented under either
> HVC(EL2) or SMC(EL3) privilege level. I agree that, with this idea, we could finally move 
> these 1453 lines of codes from kernel into a platform specific firmware. The problem
> is we don't have the firmware so far, and we haven't even had a plan to enable the
> hypervisor or secure software on this platform. Because low power consumption is
> the key feature of this i.MX7D platform, please continue to consider the current 
> implementation and get this feature supported first. 

Can't U-Boot be considered as a firmware to implement PSCI?  I have seen
an initial ARMv7 PSCI core support for U-Boot added by Marc Zyngier.

Shawn

[1] http://lists.denx.de/pipermail/u-boot/2013-December/168655.html
