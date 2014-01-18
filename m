From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 18 Jan 2014 16:38:42 +0800
Subject: [PATCH v5] ARM: DTS: imx5* imx6*, use imx51-ssi
In-Reply-To: <1389949662-11172-1-git-send-email-mpa@pengutronix.de>
References: <1389949662-11172-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20140118083840.GD3430@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 10:07:42AM +0100, Markus Pargmann wrote:
> imx51-ssi and imx21-ssi are different IPs. imx51-ssi supports online
> reconfiguration and needs this for correct interaction with SDMA. This
> patch adds imx51-ssi before each imx21-ssi for all imx5/imx6 SoCs.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
> Hi Shawn,
> 
> This is the patch including the two added compatibles in imx50.dtsi for
> fsl,imx51-ssi. That is the only change in v5.
> 
> Regards,
> 
> Markus
> 
> 
>  arch/arm/boot/dts/imx50.dtsi   |  6 +++++-
>  arch/arm/boot/dts/imx53.dtsi   | 10 +++++++---
>  arch/arm/boot/dts/imx6qdl.dtsi | 12 +++++++++---
>  arch/arm/boot/dts/imx6sl.dtsi  | 12 +++++++++---
>  4 files changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
> index 01c0499..47df15f 100644
> --- a/arch/arm/boot/dts/imx50.dtsi
> +++ b/arch/arm/boot/dts/imx50.dtsi
> @@ -140,7 +140,9 @@
>  				};
>  
>  				ssi2: ssi at 50014000 {
> -					compatible = "fsl,imx50-ssi", "fsl,imx21-ssi";
> +					compatible = "fsl,imx50-ssi",
> +							"fsl,imx51-ssi",
> +							"fsl,imx21-ssi";
>  					reg = <0x50014000 0x4000>;
>  					interrupts = <30>;
>  					clocks = <&clks IMX5_CLK_SSI2_IPG_GATE>;
> @@ -446,6 +448,8 @@
>  
>  			ssi1: ssi at 63fcc000 {
>  				compatible = "fsl,imx50-ssi", "fsl,imx21-ssi";

This line should removed then.  I fixed it up and applied the patch.

Shawn

> +				compatible = "fsl,imx50-ssi", "fsl,imx51-ssi",
> +							"fsl,imx21-ssi";
>  				reg = <0x63fcc000 0x4000>;
>  				interrupts = <29>;
>  				clocks = <&clks IMX5_CLK_SSI1_IPG_GATE>;
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index 4dbde25..73e103b 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -171,7 +171,9 @@
>  				};
>  
>  				ssi2: ssi at 50014000 {
> -					compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
> +					compatible = "fsl,imx53-ssi",
> +							"fsl,imx51-ssi",
> +							"fsl,imx21-ssi";
>  					reg = <0x50014000 0x4000>;
>  					interrupts = <30>;
>  					clocks = <&clks IMX5_CLK_SSI2_IPG_GATE>;
> @@ -590,7 +592,8 @@
>  			};
>  
>  			ssi1: ssi at 63fcc000 {
> -				compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
> +				compatible = "fsl,imx53-ssi", "fsl,imx51-ssi",
> +						"fsl,imx21-ssi";
>  				reg = <0x63fcc000 0x4000>;
>  				interrupts = <29>;
>  				clocks = <&clks IMX5_CLK_SSI1_IPG_GATE>;
> @@ -617,7 +620,8 @@
>  			};
>  
>  			ssi3: ssi at 63fe8000 {
> -				compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
> +				compatible = "fsl,imx53-ssi", "fsl,imx51-ssi",
> +						"fsl,imx21-ssi";
>  				reg = <0x63fe8000 0x4000>;
>  				interrupts = <96>;
>  				clocks = <&clks IMX5_CLK_SSI3_IPG_GATE>;
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 8a86502..cf7956e 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -247,7 +247,9 @@
>  				};
>  
>  				ssi1: ssi at 02028000 {
> -					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
> +					compatible = "fsl,imx6q-ssi",
> +							"fsl,imx51-ssi",
> +							"fsl,imx21-ssi";
>  					reg = <0x02028000 0x4000>;
>  					interrupts = <0 46 IRQ_TYPE_LEVEL_HIGH>;
>  					clocks = <&clks 178>;
> @@ -260,7 +262,9 @@
>  				};
>  
>  				ssi2: ssi at 0202c000 {
> -					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
> +					compatible = "fsl,imx6q-ssi",
> +							"fsl,imx51-ssi",
> +							"fsl,imx21-ssi";
>  					reg = <0x0202c000 0x4000>;
>  					interrupts = <0 47 IRQ_TYPE_LEVEL_HIGH>;
>  					clocks = <&clks 179>;
> @@ -273,7 +277,9 @@
>  				};
>  
>  				ssi3: ssi at 02030000 {
> -					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
> +					compatible = "fsl,imx6q-ssi",
> +							"fsl,imx51-ssi",
> +							"fsl,imx21-ssi";
>  					reg = <0x02030000 0x4000>;
>  					interrupts = <0 48 IRQ_TYPE_LEVEL_HIGH>;
>  					clocks = <&clks 180>;
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index a449c4f..95bb37b 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -226,7 +226,9 @@
>  				};
>  
>  				ssi1: ssi at 02028000 {
> -					compatible = "fsl,imx6sl-ssi","fsl,imx21-ssi";
> +					compatible = "fsl,imx6sl-ssi",
> +							"fsl,imx51-ssi",
> +							"fsl,imx21-ssi";
>  					reg = <0x02028000 0x4000>;
>  					interrupts = <0 46 IRQ_TYPE_LEVEL_HIGH>;
>  					clocks = <&clks IMX6SL_CLK_SSI1>;
> @@ -238,7 +240,9 @@
>  				};
>  
>  				ssi2: ssi at 0202c000 {
> -					compatible = "fsl,imx6sl-ssi","fsl,imx21-ssi";
> +					compatible = "fsl,imx6sl-ssi",
> +							"fsl,imx51-ssi",
> +							"fsl,imx21-ssi";
>  					reg = <0x0202c000 0x4000>;
>  					interrupts = <0 47 IRQ_TYPE_LEVEL_HIGH>;
>  					clocks = <&clks IMX6SL_CLK_SSI2>;
> @@ -250,7 +254,9 @@
>  				};
>  
>  				ssi3: ssi at 02030000 {
> -					compatible = "fsl,imx6sl-ssi","fsl,imx21-ssi";
> +					compatible = "fsl,imx6sl-ssi",
> +							"fsl,imx51-ssi",
> +							"fsl,imx21-ssi";
>  					reg = <0x02030000 0x4000>;
>  					interrupts = <0 48 IRQ_TYPE_LEVEL_HIGH>;
>  					clocks = <&clks IMX6SL_CLK_SSI3>;
> -- 
> 1.8.5.2
> 
