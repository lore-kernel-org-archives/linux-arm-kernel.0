From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Tue, 7 Jul 2015 21:18:19 +0000
Subject: [PATCH V3 1/1] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <alpine.DEB.2.11.1507072313300.3916@nanos>
References: <1436302724-45086-1-git-send-email-shenwei.wang@freescale.com>
 <alpine.DEB.2.11.1507072313300.3916@nanos>
Message-ID: <BL2PR03MB370D19CA9F0DF3896E7A84E83920@BL2PR03MB370.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx at linutronix.de]
> Sent: 2015?7?7? 16:15
> To: Wang Shenwei-B38339
> Cc: shawn.guo at linaro.org; jason at lakedaemon.net;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH V3 1/1] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
> sources
> 
> On Tue, 7 Jul 2015, Shenwei Wang wrote:
> > IMX7D contains a new version of GPC IP block (GPCv2). It has two major
> > functions: power management and wakeup source management.
> > This patch adds a new irqchip driver to manage the interrupt wakeup
> > sources and power management on IMX7D.
> > When the system is in WFI (wait for interrupt) mode, this GPC block
> > will be the first block on the platform to be activated and signaled.
> > Under normal wait mode during cpu idle, the system can be woke up by
> > any enabled interrupts. Under standby or suspend mode, the system can
> > only be woke up by the pre-defined wakeup sources.
> >
> > GPCv2 also provides low power mode control for Cortex-A7 and Cortex-M4
> > domains. And it can support WAIT, STOP, and DSM(Deep Sleep Mode) modes.
> > After configuring the GPCv2 module, the platform can enter into a
> > selected mode either automatically triggered by ARM WFI instruction or
> > manually by software. The current driver has implemented the "STANDBY"
> > and "SUSPEND_MEM" states.
> >
> > Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
> > ---
> > Change Log:
> > Patch V3:
> > 	Added the assemble codes (suspend-imx7.S) for SUSPEND_MEM state.
> > 	Supported the SUSPEND_MEM power mode.
> 
> This wants to be split in separate patches:
>      - suspend code
>      - irqchip code
> 
That's fine. Any suggestion on where to put the suspend codes? Under mach-imx?

Thanks,
Shenwei

> Thanks,
> 
> 	tglx
