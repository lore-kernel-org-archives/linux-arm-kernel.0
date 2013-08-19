From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 19 Aug 2013 22:24:49 +0800
Subject: [PATCH] ARM: imx27.dtsi: fix CSPI PER clock id
In-Reply-To: <1376635535-10325-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1376635535-10325-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20130819142447.GB28297@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 16, 2013 at 08:45:35AM +0200, Gwenhael Goavec-Merou wrote:
> CSPI PER clock is per2clk (per2_gate id 60) instead of cspiX_ipg_gate.
> 
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>

Sascha,

Does it look right to you?

Shawn

> ---
>  arch/arm/boot/dts/imx27.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> index 0695264..f71d233 100644
> --- a/arch/arm/boot/dts/imx27.dtsi
> +++ b/arch/arm/boot/dts/imx27.dtsi
> @@ -152,7 +152,7 @@
>  				compatible = "fsl,imx27-cspi";
>  				reg = <0x1000e000 0x1000>;
>  				interrupts = <16>;
> -				clocks = <&clks 53>, <&clks 53>;
> +				clocks = <&clks 53>, <&clks 60>;
>  				clock-names = "ipg", "per";
>  				status = "disabled";
>  			};
> @@ -163,7 +163,7 @@
>  				compatible = "fsl,imx27-cspi";
>  				reg = <0x1000f000 0x1000>;
>  				interrupts = <15>;
> -				clocks = <&clks 52>, <&clks 52>;
> +				clocks = <&clks 52>, <&clks 60>;
>  				clock-names = "ipg", "per";
>  				status = "disabled";
>  			};
> @@ -266,7 +266,7 @@
>  				compatible = "fsl,imx27-cspi";
>  				reg = <0x10017000 0x1000>;
>  				interrupts = <6>;
> -				clocks = <&clks 51>, <&clks 51>;
> +				clocks = <&clks 51>, <&clks 60>;
>  				clock-names = "ipg", "per";
>  				status = "disabled";
>  			};
> -- 
> 1.8.1.5
> 
