From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 15 Jul 2013 23:26:13 +0200
Subject: [PATCH 10/22] arm/dts: Add support for the cpuimx25 board from
 Eukrea and its baseboard.
In-Reply-To: <1373900227-341-11-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
 <1373900227-341-11-git-send-email-denis@eukrea.com>
Message-ID: <20130715212613.GD10995@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 04:56:55PM +0200, Denis Carikli wrote:
> Only the following devices/functionalities were added:
>  * Main UART
>  * Memory node
>  * NAND
>  * i2c and its pcf8563
>  * Ethernet
>  * LCD controller
>  * Sound
>  * ESDHC
> 
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt     |    4 ++
>  arch/arm/boot/dts/eukrea_cpuimx25.dts             |   48 +++++++++++++++++
>  arch/arm/boot/dts/eukrea_mbimxsd25-baseboard.dtsi |   59 +++++++++++++++++++++
>  3 files changed, 111 insertions(+)
>  create mode 100644 arch/arm/boot/dts/eukrea_cpuimx25.dts
>  create mode 100644 arch/arm/boot/dts/eukrea_mbimxsd25-baseboard.dtsi
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
> index e935d7d..2c19348 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.txt
> +++ b/Documentation/devicetree/bindings/arm/fsl.txt
> @@ -9,6 +9,10 @@ i.MX25 Product Development Kit
>  Required root node properties:
>      - compatible = "fsl,imx25-pdk", "fsl,imx25";
>  
> +i.MX25 Eukrea CPUIMX25 Board.
> +Required root node properties:
> +    - compatible = "fsl,eukrea_cpuimx25", "fsl,imx25";
> +
>  i.MX27 Product Development Kit
>  Required root node properties:
>      - compatible = "fsl,imx27-pdk", "fsl,imx27";
> diff --git a/arch/arm/boot/dts/eukrea_cpuimx25.dts b/arch/arm/boot/dts/eukrea_cpuimx25.dts

Currently all i.MX (and most other SoCs aswell) dts files start with the
SoC prefix, so this file should be named imx25-eukrea-cpuimx25.dts.

> +/dts-v1/;
> +#include "imx25.dtsi"
> +#include "eukrea_mbimxsd25-baseboard.dtsi"

Same here.

> +
> +/ {
> +	model = "Eukrea CPUIMX25";
> +	compatible = "fsl,eukrea_cpuimx25", "fsl,imx25";

As Fabio mentioned in another patch: eukrea,cpuimx25

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
