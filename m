From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 9 Aug 2012 09:04:53 +0200
Subject: [PATCH] ARM: dts: imx: Move SDMA firmware to SoC dtsi file
In-Reply-To: <1344436087-5612-1-git-send-email-festevam@gmail.com>
References: <1344436087-5612-1-git-send-email-festevam@gmail.com>
Message-ID: <20120809070453.GS1451@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2012 at 11:28:07AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Instead of adding sdma-ram-script-name into each board dts file, move 
> it to the SoC dtsi file instead.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

It's good to have a sane default for it. A board could still overwrite
the property should it have to.

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
>  arch/arm/boot/dts/imx51-babbage.dts |    4 ----
>  arch/arm/boot/dts/imx51.dtsi        |    1 +
>  arch/arm/boot/dts/imx53-ard.dts     |    6 ------
>  arch/arm/boot/dts/imx53-evk.dts     |    4 ----
>  arch/arm/boot/dts/imx53-qsb.dts     |    4 ----
>  arch/arm/boot/dts/imx53-smd.dts     |    4 ----
>  arch/arm/boot/dts/imx53.dtsi        |    1 +
>  7 files changed, 2 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
> index de065b5..46d4c93 100644
> --- a/arch/arm/boot/dts/imx51-babbage.dts
> +++ b/arch/arm/boot/dts/imx51-babbage.dts
> @@ -189,10 +189,6 @@
>  		};
>  
>  		aips at 80000000 {	/* aips-2 */
> -			sdma at 83fb0000 {
> -				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx51.bin";
> -			};
> -
>  			i2c at 83fc4000 { /* I2C2 */
>  				status = "okay";
>  
> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> index aaa0c0a..0bb5958 100644
> --- a/arch/arm/boot/dts/imx51.dtsi
> +++ b/arch/arm/boot/dts/imx51.dtsi
> @@ -219,6 +219,7 @@
>  				compatible = "fsl,imx51-sdma", "fsl,imx35-sdma";
>  				reg = <0x83fb0000 0x4000>;
>  				interrupts = <6>;
> +				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx51.bin";
>  			};
>  
>  			cspi at 83fc0000 {
> diff --git a/arch/arm/boot/dts/imx53-ard.dts b/arch/arm/boot/dts/imx53-ard.dts
> index 5b8eafc..dbe0353 100644
> --- a/arch/arm/boot/dts/imx53-ard.dts
> +++ b/arch/arm/boot/dts/imx53-ard.dts
> @@ -44,12 +44,6 @@
>  				status = "okay";
>  			};
>  		};
> -
> -		aips at 60000000 {	/* AIPS2 */
> -			sdma at 63fb0000 {
> -				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx53.bin";
> -			};
> -		};
>  	};
>  
>  	eim-cs1 at f4000000 {
> diff --git a/arch/arm/boot/dts/imx53-evk.dts b/arch/arm/boot/dts/imx53-evk.dts
> index 9c79803..8e72f68 100644
> --- a/arch/arm/boot/dts/imx53-evk.dts
> +++ b/arch/arm/boot/dts/imx53-evk.dts
> @@ -77,10 +77,6 @@
>  		};
>  
>  		aips at 60000000 {	/* AIPS2 */
> -			sdma at 63fb0000 {
> -				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx53.bin";
> -			};
> -
>  			i2c at 63fc4000 { /* I2C2 */
>  				status = "okay";
>  
> diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
> index 2d803a9..7153aa0 100644
> --- a/arch/arm/boot/dts/imx53-qsb.dts
> +++ b/arch/arm/boot/dts/imx53-qsb.dts
> @@ -56,10 +56,6 @@
>  		};
>  
>  		aips at 60000000 {	/* AIPS2 */
> -			sdma at 63fb0000 {
> -				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx53.bin";
> -			};
> -
>  			i2c at 63fc4000 { /* I2C2 */
>  				status = "okay";
>  
> diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
> index 0809102..9baef00 100644
> --- a/arch/arm/boot/dts/imx53-smd.dts
> +++ b/arch/arm/boot/dts/imx53-smd.dts
> @@ -96,10 +96,6 @@
>  		};
>  
>  		aips at 60000000 {	/* AIPS2 */
> -			sdma at 63fb0000 {
> -				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx53.bin";
> -			};
> -
>  			i2c at 63fc4000 { /* I2C2 */
>  				status = "okay";
>  
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index dc00c62..81abfad 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -277,6 +277,7 @@
>  				compatible = "fsl,imx53-sdma", "fsl,imx35-sdma";
>  				reg = <0x63fb0000 0x4000>;
>  				interrupts = <6>;
> +				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx53.bin";
>  			};
>  
>  			cspi at 63fc0000 {
> -- 
> 1.7.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
