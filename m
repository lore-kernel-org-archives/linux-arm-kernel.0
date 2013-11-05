From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 5 Nov 2013 15:56:02 +0100
Subject: [PATCHv11][ 4/7] pinctrl: pinctrl-imx: add imx25 pinctrl driver
In-Reply-To: <1383662354-22417-4-git-send-email-denis@eukrea.com>
References: <1383662354-22417-1-git-send-email-denis@eukrea.com>
 <1383662354-22417-4-git-send-email-denis@eukrea.com>
Message-ID: <20131105145602.GF15098@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 03:39:11PM +0100, Denis Carikli wrote:
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
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> ChangeLog v9->v10:
> - Added a imx25-pingrp.h header.
> - Removed backslash-newline at end of imx25-pingrp.h
> 
> ChangeLog v8->v9:
> - Whitespace cleanup betwen the CC: and Signed-off-by.
> - Kconfig: rebased to make it apply on the new HEAD.
> ---
>  .../bindings/pinctrl/fsl,imx25-pinctrl.txt         |   25 +
>  arch/arm/boot/dts/imx25-pinfunc.h                  |  494 ++++++++++++++++++++
>  arch/arm/boot/dts/imx25-pingrp.h                   |   79 ++++
>  arch/arm/boot/dts/imx25.dtsi                       |    1 +
>  drivers/pinctrl/Kconfig                            |    9 +
>  drivers/pinctrl/Makefile                           |    1 +
>  drivers/pinctrl/pinctrl-imx25.c                    |  351 ++++++++++++++
>  7 files changed, 960 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx25-pinctrl.txt
>  create mode 100644 arch/arm/boot/dts/imx25-pinfunc.h
>  create mode 100644 arch/arm/boot/dts/imx25-pingrp.h
>  create mode 100644 drivers/pinctrl/pinctrl-imx25.c
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx25-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx25-pinctrl.txt
> new file mode 100644
> index 0000000..1d6dae2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx25-pinctrl.txt
> @@ -0,0 +1,25 @@
> +* Freescale IMX25 IOMUX Controller
> +
> +Please refer to fsl,imx-pinctrl.txt in this directory for common binding part
> +and usage.
> +
> +CONFIG bits definition:
> +PAD_CTL_DRIVE_VOLAGAGE_18	(1 << 13)
> +PAD_CTL_DRIVE_VOLAGAGE_33	(0 << 13)
> +PAD_CTL_HYS			(1 << 8)
> +PAD_CTL_PKE			(1 << 7)
> +PAD_CTL_PUE			(1 << 6)
> +PAD_CTL_PUS_100K_DOWN		(0 << 4)
> +PAD_CTL_PUS_47K_UP		(1 << 4)
> +PAD_CTL_PUS_100K_UP		(2 << 4)
> +PAD_CTL_PUS_22K_UP		(3 << 4)
> +PAD_CTL_ODE_CMOS		(0 << 3)
> +PAD_CTL_ODE_OPENDRAIN		(1 << 3)
> +PAD_CTL_DSE_NOMINAL		(0 << 1)
> +PAD_CTL_DSE_HIGH		(1 << 1)
> +PAD_CTL_DSE_MAX			(2 << 1)
> +PAD_CTL_SRE_FAST		(1 << 0)
> +PAD_CTL_SRE_SLOW		(0 << 0)

You removed the group control registers in v11? Are these config bits
used for other pinctl registers? Especially "DRIVE_VOLTAGE" seems to be
only for those registers you removed.

Regards

Markus Pargmann

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
