From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 27 Apr 2012 09:35:04 +0200
Subject: [PATCH v3 4/4] mmc: sdhci-imx-esdhc: convert to use pinctrl
 subsystem
In-Reply-To: <1335451227-27709-4-git-send-email-b29396@freescale.com>
References: <1335451227-27709-1-git-send-email-b29396@freescale.com>
 <1335451227-27709-4-git-send-email-b29396@freescale.com>
Message-ID: <20120427073504.GS17184@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 10:40:27PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> This driver is shared between many platforms. Currently only imx6q has
> pinctrl support, to avoid breaking other platforms that do not have pinctrl
> support to run this driver, enable pinctrl dummy state for them before
> they also convert to pinctrl subsystem.
> 
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> ---
> This patch depends on:
> pinctrl: add pinctrl_provide_dummies interface for platforms to use
> http://www.spinics.net/lists/arm-kernel/msg171538.html
> 
> ChangeLog v2->v3:
>  * patch name updated.
>    v1 name is ARM: imx6q: switch to use pinctrl driver
>  * using pinctrl dummy state to avoid breaking other platforms to use this
>    driver.
> 
> ChangeLog v1->v2:
>  * using updated binding
> ---
>  arch/arm/boot/dts/imx6q-arm2.dts               |    4 +++
>  arch/arm/boot/dts/imx6q.dtsi                   |   32 ++++++++++++++++++++++++
>  arch/arm/mach-imx/Kconfig                      |    2 +
>  arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c |    2 +
>  arch/arm/mach-imx/mach-cpuimx51.c              |    2 +
>  arch/arm/mach-imx/mach-cpuimx51sd.c            |    2 +
>  arch/arm/mach-imx/mach-eukrea_cpuimx25.c       |    2 +
>  arch/arm/mach-imx/mach-mx25_3ds.c              |    2 +
>  arch/arm/mach-imx/mach-mx35_3ds.c              |    2 +
>  arch/arm/mach-imx/mach-mx51_3ds.c              |    2 +
>  arch/arm/mach-imx/mach-mx51_babbage.c          |    2 +
>  arch/arm/mach-imx/mach-mx51_efikamx.c          |    2 +
>  arch/arm/mach-imx/mach-mx51_efikasb.c          |    2 +
>  arch/arm/mach-imx/mach-mx53_ard.c              |    2 +
>  arch/arm/mach-imx/mach-mx53_evk.c              |    2 +
>  arch/arm/mach-imx/mach-mx53_loco.c             |    2 +
>  arch/arm/mach-imx/mach-mx53_smd.c              |    2 +
>  arch/arm/mach-imx/mach-pcm043.c                |    2 +
>  arch/arm/mach-imx/mach-vpr200.c                |    2 +

Here you are patching only the boards which happen to use the esdhc
controller, so we need to patch other boards when another driver gains
pinctrl. Let's add the provide_dummies call to the SoCs instead which
do not have pinctrl yet.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
