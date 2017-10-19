From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 19 Oct 2017 18:48:50 +0200
Subject: [PATCH v3 01/10] arm: dts: mt2701: add pwm backlight device node
In-Reply-To: <144f5d526d15cbf3ada220765c609eb2b59c240a.1506908511.git.ryder.lee@mediatek.com>
References: <cover.1506908511.git.ryder.lee@mediatek.com>
 <144f5d526d15cbf3ada220765c609eb2b59c240a.1506908511.git.ryder.lee@mediatek.com>
Message-ID: <54df408d-62b8-63dd-05af-68daa455b62c@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/02/2017 03:54 AM, Ryder Lee wrote:
> From: Weiqing Kong <weiqing.kong@mediatek.com>
> 
> This patch adds the device node for MT2701 pwm backlight.
> 
> Signed-off-by: Weiqing Kong <weiqing.kong@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  arch/arm/boot/dts/mt2701.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)

Pushed to v4.14-next/dts32

Thanks!

> 
> diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
> index afe12e5..3c85879 100644
> --- a/arch/arm/boot/dts/mt2701.dtsi
> +++ b/arch/arm/boot/dts/mt2701.dtsi
> @@ -530,6 +530,15 @@
>  		#clock-cells = <1>;
>  	};
>  
> +	bls: pwm at 1400a000 {
> +		compatible = "mediatek,mt2701-disp-pwm";
> +		reg = <0 0x1400a000 0 0x1000>;
> +		#pwm-cells = <2>;
> +		clocks = <&mmsys CLK_MM_MDP_BLS_26M>, <&mmsys CLK_MM_DISP_BLS>;
> +		clock-names = "main", "mm";
> +		status = "disabled";
> +	};
> +
>  	larb0: larb at 14010000 {
>  		compatible = "mediatek,mt2701-smi-larb";
>  		reg = <0 0x14010000 0 0x1000>;
> 
