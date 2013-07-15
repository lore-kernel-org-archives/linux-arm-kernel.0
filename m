From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 15 Jul 2013 23:16:21 +0200
Subject: [PATCH 01/22] ARM i.MX25: devicetree: add compatible property
 for imxfb support.
In-Reply-To: <1373900227-341-2-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
 <1373900227-341-2-git-send-email-denis@eukrea.com>
Message-ID: <20130715211621.GA10995@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 04:56:46PM +0200, Denis Carikli wrote:
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  arch/arm/boot/dts/imx25.dtsi |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
> index bcd3171..6a1633d 100644
> --- a/arch/arm/boot/dts/imx25.dtsi
> +++ b/arch/arm/boot/dts/imx25.dtsi
> @@ -394,6 +394,7 @@
>  			};
>  
>  			lcdc at 53fbc000 {
> +				compatible = "fsl,imx21-lcdif";

The driver matches "fsl,imx21-fb", not "fsl,imx21-lcdif". Also please
add a i.MX25 specific compatible so that we have the chance to match the
specific SoC version in the driver.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
