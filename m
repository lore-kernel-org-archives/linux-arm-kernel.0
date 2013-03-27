From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Wed, 27 Mar 2013 19:43:40 +0100
Subject: [PATCH v2 10/11] ARM i.MX53: Add LDB device to device tree
In-Reply-To: <1364405445-5271-11-git-send-email-p.zabel@pengutronix.de>
References: <1364405445-5271-1-git-send-email-p.zabel@pengutronix.de>
 <1364405445-5271-11-git-send-email-p.zabel@pengutronix.de>
Message-ID: <51533DDC.2030401@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/03/13 18:30, Philipp Zabel wrote:
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>   arch/arm/boot/dts/imx53.dtsi | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index b07bbdcc..30aed40 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -511,6 +511,33 @@
>   				reg = <0x53fa8000 0xc>;
>   			};
>   
> +			ldb: ldb at 53fa8008 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx53-ldb";
> +				reg = <0x53fa8008 0x4>;
> +				gpr = <&gpr>;
> +				clocks = <&clks 122>, <&clks 120>,
> +					 <&clks 115>, <&clks 116>,
> +					 <&clks 123>, <&clks 85>;
> +				clock-names = "di0_pll", "di1_pll",
> +					      "di0_sel", "di1_sel",
> +					      "di0", "di1";
> +				status = "disabled";
> +
> +				lvds-channel at 0 {
> +					reg = <0>;
> +					crtcs = <&ipu 0>;
> +					status = "disabled";
> +				};
> +
> +				lvds-channel at 1 {
> +					reg = <1>;
> +					crtcs = <&ipu 1>;
> +					status = "disabled";
> +				};
> +			};
> +
>   			pwm1: pwm at 53fb4000 {
>   				#pwm-cells = <2>;
>   				compatible = "fsl,imx53-pwm", "fsl,imx27-pwm";
Maybe pinctrl entries should also be added?

Regards,

Martin
