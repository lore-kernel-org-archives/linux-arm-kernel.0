From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 26 Apr 2012 10:16:37 +0200
Subject: [PATCH 1/2] ARM: imx6q-sabrelite.dts: Add SPI NOR support
In-Reply-To: <1335310537-11219-1-git-send-email-festevam@gmail.com>
References: <1335310537-11219-1-git-send-email-festevam@gmail.com>
Message-ID: <20120426081637.GD17184@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 08:35:36PM -0300, Fabio Estevam wrote:
> mx6qsabrelite has a sst25vf016b SPI NOR flash connected to eCSPI1.
> 
> Add support for it.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Shawn, are you ok with this? If yes I would take this into my queue

Sascha

> ---
>  arch/arm/boot/dts/imx6q-sabrelite.dts |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> index 4663a4e..35be687 100644
> --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> @@ -22,6 +22,23 @@
>  	};
>  
>  	soc {
> +		aips-bus at 02000000 { /* AIPS1 */
> +			spba-bus at 02000000 {
> +				ecspi at 02008000 { /* eCSPI1 */
> +					fsl,spi-num-chipselects = <1>;
> +					cs-gpios = <&gpio3 19 0>;
> +					status = "okay";
> +
> +					flash: m25p80 at 0 {
> +						compatible = "sst,sst25vf016b";
> +						spi-max-frequency = <20000000>;
> +						reg = <0>;
> +					};
> +				};
> +			};
> +
> +		};
> +
>  		aips-bus at 02100000 { /* AIPS2 */
>  			enet at 02188000 {
>  				phy-mode = "rgmii";
> -- 
> 1.7.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
