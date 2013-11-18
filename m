From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 18 Nov 2013 10:02:35 +0800
Subject: [RFC 9/9] ARM: DTS: imx5* imx6*, use imx50-ssi
In-Reply-To: <1384530584-31273-10-git-send-email-mpa@pengutronix.de>
References: <1384530584-31273-1-git-send-email-mpa@pengutronix.de>
 <1384530584-31273-10-git-send-email-mpa@pengutronix.de>
Message-ID: <20131118020233.GN11014@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 04:49:44PM +0100, Markus Pargmann wrote:
> imx50-ssi and imx21-ssi are different IPs. imx50-ssi supports online
> reconfiguration and needs this for correct interaction with SDMA. Move
> from imx21-ssi to imx50-ssi for all imx5/imx6 SoCs.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx51.dtsi   | 6 +++---
>  arch/arm/boot/dts/imx53.dtsi   | 6 +++---
>  arch/arm/boot/dts/imx6qdl.dtsi | 6 +++---
>  arch/arm/boot/dts/imx6sl.dtsi  | 6 +++---
>  4 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> index 54cee65..22d4dbe 100644
> --- a/arch/arm/boot/dts/imx51.dtsi
> +++ b/arch/arm/boot/dts/imx51.dtsi
> @@ -150,7 +150,7 @@
>  				};
>  
>  				ssi2: ssi at 70014000 {
> -					compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
> +					compatible = "fsl,imx51-ssi", "fsl,imx50-ssi";

Instead of replacing "fsl,imx21-ssi" with "fsl,imx50-ssi", we may want
to just add "fsl,imx50-ssi" in the middle to maintain the compatible
history.  Note, it only works with the change I suggested on
of_device_id table order.  The bonus point of doing so is that we will
not have git bisect issue to worry about with merging this patch and
others in the series via different tree.

Shawn

>  					reg = <0x70014000 0x4000>;
>  					interrupts = <30>;
>  					clocks = <&clks 49>;
> @@ -427,7 +427,7 @@
>  			};
>  
>  			ssi1: ssi at 83fcc000 {
> -				compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
> +				compatible = "fsl,imx51-ssi", "fsl,imx50-ssi";
>  				reg = <0x83fcc000 0x4000>;
>  				interrupts = <29>;
>  				clocks = <&clks 48>;
> @@ -479,7 +479,7 @@
>  			};
>  
>  			ssi3: ssi at 83fe8000 {
> -				compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
> +				compatible = "fsl,imx51-ssi", "fsl,imx50-ssi";
>  				reg = <0x83fe8000 0x4000>;
>  				interrupts = <96>;
>  				clocks = <&clks 50>;
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index 4307e80..f1077f2 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -149,7 +149,7 @@
>  				};
>  
>  				ssi2: ssi at 50014000 {
> -					compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
> +					compatible = "fsl,imx53-ssi", "fsl,imx50-ssi";
>  					reg = <0x50014000 0x4000>;
>  					interrupts = <30>;
>  					clocks = <&clks 49>;
> @@ -1049,7 +1049,7 @@
>  			};
>  
>  			ssi1: ssi at 63fcc000 {
> -				compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
> +				compatible = "fsl,imx53-ssi", "fsl,imx50-ssi";
>  				reg = <0x63fcc000 0x4000>;
>  				interrupts = <29>;
>  				clocks = <&clks 48>;
> @@ -1076,7 +1076,7 @@
>  			};
>  
>  			ssi3: ssi at 63fe8000 {
> -				compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
> +				compatible = "fsl,imx53-ssi", "fsl,imx50-ssi";
>  				reg = <0x63fe8000 0x4000>;
>  				interrupts = <96>;
>  				clocks = <&clks 50>;
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index ccd55c2..30d455e 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -201,7 +201,7 @@
>  				};
>  
>  				ssi1: ssi at 02028000 {
> -					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
> +					compatible = "fsl,imx6q-ssi","fsl,imx50-ssi";
>  					reg = <0x02028000 0x4000>;
>  					interrupts = <0 46 0x04>;
>  					clocks = <&clks 178>;
> @@ -214,7 +214,7 @@
>  				};
>  
>  				ssi2: ssi at 0202c000 {
> -					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
> +					compatible = "fsl,imx6q-ssi","fsl,imx50-ssi";
>  					reg = <0x0202c000 0x4000>;
>  					interrupts = <0 47 0x04>;
>  					clocks = <&clks 179>;
> @@ -227,7 +227,7 @@
>  				};
>  
>  				ssi3: ssi at 02030000 {
> -					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
> +					compatible = "fsl,imx6q-ssi","fsl,imx50-ssi";
>  					reg = <0x02030000 0x4000>;
>  					interrupts = <0 48 0x04>;
>  					clocks = <&clks 180>;
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index c46651e..1b19319 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -191,7 +191,7 @@
>  				};
>  
>  				ssi1: ssi at 02028000 {
> -					compatible = "fsl,imx6sl-ssi","fsl,imx21-ssi";
> +					compatible = "fsl,imx6sl-ssi","fsl,imx50-ssi";
>  					reg = <0x02028000 0x4000>;
>  					interrupts = <0 46 0x04>;
>  					clocks = <&clks IMX6SL_CLK_SSI1>;
> @@ -203,7 +203,7 @@
>  				};
>  
>  				ssi2: ssi at 0202c000 {
> -					compatible = "fsl,imx6sl-ssi","fsl,imx21-ssi";
> +					compatible = "fsl,imx6sl-ssi","fsl,imx50-ssi";
>  					reg = <0x0202c000 0x4000>;
>  					interrupts = <0 47 0x04>;
>  					clocks = <&clks IMX6SL_CLK_SSI2>;
> @@ -215,7 +215,7 @@
>  				};
>  
>  				ssi3: ssi at 02030000 {
> -					compatible = "fsl,imx6sl-ssi","fsl,imx21-ssi";
> +					compatible = "fsl,imx6sl-ssi","fsl,imx50-ssi";
>  					reg = <0x02030000 0x4000>;
>  					interrupts = <0 48 0x04>;
>  					clocks = <&clks IMX6SL_CLK_SSI3>;
> -- 
> 1.8.4.2
> 
