From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 31 Oct 2013 13:56:34 +0800
Subject: [PATCH] ARM: dts: Add initial support for cm-fx6.
In-Reply-To: <1383048703-2101-1-git-send-email-valentin@compulab.co.il>
References: <1383048703-2101-1-git-send-email-valentin@compulab.co.il>
Message-ID: <20131031055631.GA23549@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 02:11:43PM +0200, Valentin Raevsky wrote:
> Add initial support for cm-fx6 module.
> 
> cm-fx6 is a module based on mx6q SoC with the following features:
> - Up to 4GB of DDR3
> - 1 LCD/DVI output port
> - 1 HDMI output port
> - 2 LVDS LCD ports
> - Gigabit Ethernet
> - Analog Audio
> - CAN
> - SATA
> - NAND
> - PCIE
> 
> This patch allows to boot up the module, configures the serial console,
> the Ethernet adapter and the heartbeat led.
> 
> cm-fx6 is embedded inside the Utilite computer.
> 
> Signed-off-by: Valentin Raevsky <valentin@compulab.co.il>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
> 
> Shawn, can this still be applied for 3.13 ?

Sorry, it's late for 3.13.  Applied for 3.14 with a small fix-up below.

> 
>  arch/arm/boot/dts/Makefile         |    1 +
>  arch/arm/boot/dts/imx6q-cm-fx6.dts |   53 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6q-cm-fx6.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 641b3c9..87ca7ca 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -131,6 +131,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
>  	imx6q-sabrelite.dtb \
>  	imx6q-sabresd.dtb \
>  	imx6q-sbc6x.dtb \
> +	imx6q-cm-fx6.dtb \

If you look at the list, you can find that they are sorted
alphabetically.  I just moved it around to maintain the order.

Shawn

>  	imx6sl-evk.dtb \
>  	vf610-twr.dtb
>  dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb \
