From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 7 Jul 2015 23:15:07 +0200 (CEST)
Subject: [PATCH V3 1/1] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <1436302724-45086-1-git-send-email-shenwei.wang@freescale.com>
References: <1436302724-45086-1-git-send-email-shenwei.wang@freescale.com>
Message-ID: <alpine.DEB.2.11.1507072313300.3916@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 7 Jul 2015, Shenwei Wang wrote:
> IMX7D contains a new version of GPC IP block (GPCv2). It has two
> major functions: power management and wakeup source management.
> This patch adds a new irqchip driver to manage the interrupt wakeup
> sources and power management on IMX7D.
> When the system is in WFI (wait for interrupt) mode, this GPC block
> will be the first block on the platform to be activated and signaled.
> Under normal wait mode during cpu idle, the system can be woke up
> by any enabled interrupts. Under standby or suspend mode, the system
> can only be woke up by the pre-defined wakeup sources.
> 
> GPCv2 also provides low power mode control for Cortex-A7 and Cortex-M4
> domains. And it can support WAIT, STOP, and DSM(Deep Sleep Mode) modes.
> After configuring the GPCv2 module, the platform can enter into a
> selected mode either automatically triggered by ARM WFI instruction or
> manually by software. The current driver has implemented the
> "STANDBY" and "SUSPEND_MEM" states.
> 
> Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
> ---
> Change Log:
> Patch V3:
> 	Added the assemble codes (suspend-imx7.S) for SUSPEND_MEM state.
> 	Supported the SUSPEND_MEM power mode.

This wants to be split in separate patches:
     - suspend code
     - irqchip code

Thanks,

	tglx
