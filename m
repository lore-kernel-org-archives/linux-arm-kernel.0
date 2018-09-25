From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 25 Sep 2018 17:46:49 +0200
Subject: [PATCH 2/5] arm: dts: mt7623: update subsystem clock controller
 device nodes
In-Reply-To: <6cc820db27996d8fd3094df10abbba1a2008907a.1536141302.git.ryder.lee@mediatek.com>
References: <84011aa94dd7be9239b7a2f944dd30fc70568fbb.1536141302.git.ryder.lee@mediatek.com>
 <6cc820db27996d8fd3094df10abbba1a2008907a.1536141302.git.ryder.lee@mediatek.com>
Message-ID: <64b5187f-8a4d-b94e-8a3b-f1e19538697a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/09/2018 12:22, Ryder Lee wrote:
> Update MT7623 subsystem clock controllers, inlcuding mmsys, imgsys,
> vdecsys, g3dsys and bdpsys.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Applied to v4.19-next/dts32

> ---
>  arch/arm/boot/dts/mt7623.dtsi | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> index 8c43bd0..b7ccf8b 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -692,6 +692,39 @@
>  		status = "disabled";
>  	};
>  
> +	g3dsys: syscon at 13000000 {
> +		compatible = "mediatek,mt7623-g3dsys",
> +			     "mediatek,mt2701-g3dsys",
> +			     "syscon";
> +		reg = <0 0x13000000 0 0x200>;
> +		#clock-cells = <1>;
> +		#reset-cells = <1>;
> +	};
> +
> +	mmsys: syscon at 14000000 {
> +		compatible = "mediatek,mt7623-mmsys",
> +			     "mediatek,mt2701-mmsys",
> +			     "syscon";
> +		reg = <0 0x14000000 0 0x1000>;
> +		#clock-cells = <1>;
> +	};
> +
> +	imgsys: syscon at 15000000 {
> +		compatible = "mediatek,mt7623-imgsys",
> +			     "mediatek,mt2701-imgsys",
> +			     "syscon";
> +		reg = <0 0x15000000 0 0x1000>;
> +		#clock-cells = <1>;
> +	};
> +
> +	vdecsys: syscon at 16000000 {
> +		compatible = "mediatek,mt7623-vdecsys",
> +			     "mediatek,mt2701-vdecsys",
> +			     "syscon";
> +		reg = <0 0x16000000 0 0x1000>;
> +		#clock-cells = <1>;
> +	};
> +
>  	hifsys: syscon at 1a000000 {
>  		compatible = "mediatek,mt7623-hifsys",
>  			     "mediatek,mt2701-hifsys",
> @@ -946,6 +979,14 @@
>  		power-domains = <&scpsys MT2701_POWER_DOMAIN_ETH>;
>  		status = "disabled";
>  	};
> +
> +	bdpsys: syscon at 1c000000 {
> +		compatible = "mediatek,mt7623-bdpsys",
> +			     "mediatek,mt2701-bdpsys",
> +			     "syscon";
> +		reg = <0 0x1c000000 0 0x1000>;
> +		#clock-cells = <1>;
> +	};
>  };
>  
>  &pio {
> 
