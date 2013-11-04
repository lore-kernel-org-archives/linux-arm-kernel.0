From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 4 Nov 2013 14:13:49 +0100
Subject: [PATCHv9][ 4/6] pinctrl: pinctrl-imx: add imx25 pinctrl driver
In-Reply-To: <1383210928-18906-4-git-send-email-denis@eukrea.com>
References: <1383210928-18906-1-git-send-email-denis@eukrea.com>
 <1383210928-18906-4-git-send-email-denis@eukrea.com>
Message-ID: <20131104131349.GH17135@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 10:15:26AM +0100, Denis Carikli wrote:
> This is mostly cut and paste from the imx35 pinctrl driver.
> The data was generated using sed and awk on
>   arch/arm/plat-mxc/include/mach/iomux-mx25.h.
> 
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: devicetree at vger.kernel.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Eric B?nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> ChangeLog v8->v9:
> - Whitespace cleanup betwen the CC: and Signed-off-by.
> - Kconfig: rebased to make it apply on the new HEAD.
> ---
>  .../bindings/pinctrl/fsl,imx25-pinctrl.txt         |   33 ++
>  arch/arm/boot/dts/imx25-pinfunc.h                  |  513 ++++++++++++++++++++
>  arch/arm/boot/dts/imx25.dtsi                       |    1 +
>  arch/arm/mach-imx/Kconfig                          |    2 +
>  drivers/pinctrl/Kconfig                            |    8 +
>  drivers/pinctrl/Makefile                           |    1 +
>  drivers/pinctrl/pinctrl-imx25.c                    |  351 ++++++++++++++
>  7 files changed, 909 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx25-pinctrl.txt
>  create mode 100644 arch/arm/boot/dts/imx25-pinfunc.h
>  create mode 100644 drivers/pinctrl/pinctrl-imx25.c
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx25-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx25-pinctrl.txt
> new file mode 100644
> index 0000000..64906ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx25-pinctrl.txt
> @@ -0,0 +1,33 @@
> +* Freescale IMX25 IOMUX Controller
> +
> +Please refer to fsl,imx-pinctrl.txt in this directory for common binding part
> +and usage.
> +
> +Required properties:
> +- compatible: "fsl,imx25-iomuxc"
> +- fsl,pins: two integers array, represents a group of pins mux and config
> +  setting. The format is fsl,pins = <PIN_FUNC_ID CONFIG>, PIN_FUNC_ID is a
> +  pin working on a specific function, CONFIG is the pad setting value like
> +  pull-up for this pin. Please refer to imx25 datasheet for the valid pad
> +  config settings.

This description is wrong. We have a correct description of fsl,pins in
Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt already,
so we should probably refer to it instead of describing it again here.
This is wrong in all
Documentation/devicetree/bindings/pinctrl/fsl,imx?*-pinctrl.txt files in
the tree currently.

Otherwise:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
