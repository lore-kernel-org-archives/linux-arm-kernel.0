From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 22 Mar 2012 15:45:23 +0800
Subject: [PATCH] ARM: dts: imx6q: add anatop regulators
In-Reply-To: <1332214139-6833-1-git-send-email-paul.liu@linaro.org>
References: <1332214139-6833-1-git-send-email-paul.liu@linaro.org>
Message-ID: <20120322074520.GD2213@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 20, 2012 at 11:28:59AM +0800, Ying-Chun Liu (PaulLiu) wrote:
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
> 
> Add anatop regulators to imx6q.dtsi for all imx6q platforms.
> 
I would expect all those regulator device nodes be sorted by
register offset, and for the devices sharing the same register they
can be sorted by anatop-vol-bit-shift.

I'm looking at the IMX6DQRM Rev. C, and commenting the differences
I'm seeing from the document below.

> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/boot/dts/imx6q.dtsi |   86 ++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 86 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index 263e8f3..dd41514 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -346,6 +346,92 @@
>  				compatible = "fsl,imx6q-anatop";
>  				reg = <0x020c8000 0x1000>;
>  				interrupts = <0 49 0x04 0 54 0x04 0 127 0x04>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				regulator-vddpu at 140 {
> +					compatible = "fsl,anatop-regulator";
> +					regulator-name = "vddpu";
> +					regulator-min-microvolt = <725000>;
> +					regulator-max-microvolt = <1300000>;
> +					regulator-always-on;
> +					reg = <0x140>;
> +					anatop-vol-bit-shift = <9>;
> +					anatop-vol-bit-width = <5>;
> +					anatop-min-bit-val = <1>;
> +					anatop-min-voltage = <725000>;
> +					anatop-max-voltage = <1300000>;

1.450V

> +				};
> +
> +				regulator-vddcore at 140 {
> +					compatible = "fsl,anatop-regulator";
> +					regulator-name = "cpu";
> +					regulator-min-microvolt = <725000>;
> +					regulator-max-microvolt = <1300000>;
> +					regulator-always-on;
> +					reg = <0x140>;
> +					anatop-vol-bit-shift = <0>;
> +					anatop-vol-bit-width = <5>;
> +					anatop-min-bit-val = <1>;
> +					anatop-min-voltage = <725000>;
> +					anatop-max-voltage = <1300000>;

Ditto

> +				};
> +
> +				regulator-vddsoc at 140 {
> +					compatible = "fsl,anatop-regulator";
> +					regulator-name = "vddsoc";
> +					regulator-min-microvolt = <725000>;
> +					regulator-max-microvolt = <1300000>;
> +					regulator-always-on;
> +					reg = <0x140>;
> +					anatop-vol-bit-shift = <18>;
> +					anatop-vol-bit-width = <5>;
> +					anatop-min-bit-val = <1>;
> +					anatop-min-voltage = <725000>;
> +					anatop-max-voltage = <1300000>;

Ditto

> +				};
> +
> +				regulator-2p5 at 130 {
> +					compatible = "fsl,anatop-regulator";
> +					regulator-name = "vdd2p5";
> +					regulator-min-microvolt = <2000000>;
> +					regulator-max-microvolt = <2775000>;
> +					regulator-always-on;
> +					reg = <0x130>;
> +					anatop-vol-bit-shift = <8>;
> +					anatop-vol-bit-width = <5>;
> +					anatop-min-bit-val = <0>;
> +					anatop-min-voltage = <2000000>;
> +					anatop-max-voltage = <2775000>;

2.75V

> +				};
> +
> +				regulator-1p1 at 110 {
> +					compatible = "fsl,anatop-regulator";
> +					regulator-name = "vdd1p1";
> +					regulator-min-microvolt = <800000>;
> +					regulator-max-microvolt = <1400000>;
> +					regulator-always-on;
> +					reg = <0x110>;
> +					anatop-vol-bit-shift = <8>;
> +					anatop-vol-bit-width = <5>;
> +					anatop-min-bit-val = <4>;
> +					anatop-min-voltage = <800000>;
> +					anatop-max-voltage = <1400000>;

1.375V

> +				};
> +
> +				regulator-3p0 at 120 {
> +					compatible = "fsl,anatop-regulator";
> +					regulator-name = "vdd3p0";
> +					regulator-min-microvolt = <2800000>;
> +					regulator-max-microvolt = <3150000>;
> +					regulator-always-on;
> +					reg = <0x120>;
> +					anatop-vol-bit-shift = <8>;
> +					anatop-vol-bit-width = <5>;
> +					anatop-min-bit-val = <7>;

0

> +					anatop-min-voltage = <2800000>;

2.625V

> +					anatop-max-voltage = <3150000>;

3.4V

> +				};
>  			};
>  
>  			usbphy at 020c9000 { /* USBPHY1 */
> -- 
> 1.7.9.1
> 

-- 
Regards,
Shawn
