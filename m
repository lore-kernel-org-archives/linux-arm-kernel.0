From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 7 Sep 2015 23:11:06 +0800
Subject: [PATCH v8 2/2] ARM: imx: support suspend states on imx7D
In-Reply-To: <1438378439-11569-3-git-send-email-shenwei.wang@freescale.com>
References: <1438378439-11569-1-git-send-email-shenwei.wang@freescale.com>
 <1438378439-11569-3-git-send-email-shenwei.wang@freescale.com>
Message-ID: <20150907151106.GA30723@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 04:33:59PM -0500, Shenwei Wang wrote:
> IMX7D contains a new version of GPC IP block (GPCv2). It has two
> major functions: power management and wakeup source management.
> 
> GPCv2 provides low power mode control for Cortex-A7 and Cortex-M4
> domains. And it can support WAIT, STOP, and DSM(Deep Sleep Mode) modes.
> After configuring the GPCv2 module, the platform can enter into a
> selected mode either automatically triggered by ARM WFI instruction or
> manually by software. The system will exit the low power states
> by the predefined wakeup sources which are managed by the gpcv2
> irqchip driver.
> 
> This patch adds a new suspend driver to manage the power states on IMX7D.
> It currently supports "SUSPEND_STANDBY" and "SUSPEND_MEM" states.
> 
> Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
> Signed-off-by: Anson Huang <b20788@freescale.com>

Please stop sending patches to my Linaro mailbox, and use
shawnguo at kernel.org instead.  You should already get that if you ever
run ./scripts/get_maintainer.pl on the patch.  Also please always copy
kernel at pengutronix.de for i.MX platform patches like this.

> ---
>  arch/arm/mach-imx/Kconfig        |   1 +
>  arch/arm/mach-imx/Makefile       |   2 +
>  arch/arm/mach-imx/common.h       |   4 +
>  arch/arm/mach-imx/pm-imx7.c      | 917 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-imx/suspend-imx7.S | 529 ++++++++++++++++++++++
>  5 files changed, 1453 insertions(+)

1453 lines addition to kernel only for i.MX7D suspend support.  Yes,
this is the way we support suspend on i.MX6, but that's enough, and
we have to stop this somewhere.  I would ask you to take Sudeep's
comment and adopt PSCI for i.MX7D power management.

Shawn

[1] https://lkml.org/lkml/2015/8/26/554
