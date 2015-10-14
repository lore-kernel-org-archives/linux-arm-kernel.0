From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 14 Oct 2015 15:26:37 +0200
Subject: [PATCH v7 9/9] arm64: dts: mt8173: Add subsystem clock controller
 device nodes
In-Reply-To: <1439200228-318-10-git-send-email-jamesjj.liao@mediatek.com>
References: <1439200228-318-1-git-send-email-jamesjj.liao@mediatek.com>
 <1439200228-318-10-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <561E580D.4090706@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/08/15 11:50, James Liao wrote:
> This patch adds device nodes providing subsystem clocks on MT8173,
> includes mmsys, imgsys, vdecsys, vencsys and vencltsys.
>
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> ---

Applied, thanks.

>   arch/arm64/boot/dts/mediatek/mt8173.dtsi | 37 ++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index a2f63e4..32c85cc 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -102,6 +102,13 @@
>   		clock-output-names = "clk32k";
>   	};
>
> +	cpum_ck: oscillator at 2 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <0>;
> +		clock-output-names = "cpum_ck";
> +	};
> +
>   	timer {
>   		compatible = "arm,armv8-timer";
>   		interrupt-parent = <&gic>;
> @@ -227,6 +234,36 @@
>   			clocks = <&uart_clk>;
>   			status = "disabled";
>   		};
> +
> +		mmsys: clock-controller at 14000000 {
> +			compatible = "mediatek,mt8173-mmsys", "syscon";
> +			reg = <0 0x14000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		imgsys: clock-controller at 15000000 {
> +			compatible = "mediatek,mt8173-imgsys", "syscon";
> +			reg = <0 0x15000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		vdecsys: clock-controller at 16000000 {
> +			compatible = "mediatek,mt8173-vdecsys", "syscon";
> +			reg = <0 0x16000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		vencsys: clock-controller at 18000000 {
> +			compatible = "mediatek,mt8173-vencsys", "syscon";
> +			reg = <0 0x18000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		vencltsys: clock-controller at 19000000 {
> +			compatible = "mediatek,mt8173-vencltsys", "syscon";
> +			reg = <0 0x19000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
>   	};
>   };
>
>
