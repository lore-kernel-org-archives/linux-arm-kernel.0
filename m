From: mars.cheng@mediatek.com (Mars Cheng)
Date: Wed, 21 Jun 2017 11:01:32 +0800
Subject: [PATCH] arm64: dts: Delete unused dummy clocks
In-Reply-To: <20170620102854.9346-1-matthias.bgg@gmail.com>
References: <20170620102854.9346-1-matthias.bgg@gmail.com>
Message-ID: <1498014092.810.3.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias

On Tue, 2017-06-20 at 12:28 +0200, Matthias Brugger wrote:
> After adding the clock subsystem to the SOC, the dummy
> clocks clk26m and clk32k are not longer needed. Delete them.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt6797.dtsi | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> index 3512c8e6dc65..09d46befa86b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> @@ -102,20 +102,6 @@
>  		};
>  	};
>  
> -	clk26m: oscillator at 0 {
> -		compatible = "fixed-clock";
> -		#clock-cells = <0>;
> -		clock-frequency = <26000000>;
> -		clock-output-names = "clk26m";
> -	};

clk26m is referenced by drivers/clk/mediatek/clk-mt6797.c:
static const char * const axi_parents[] = {
	"clk26m",
	"syspll_d7",
	"ulposc_axi_ck_mux",
};

Please just delete clk32k which is dummy, and keep clk26m. Or might get
PLL wrongly.

Thanks.

> -
> -	clk32k: oscillator at 1 {
> -		compatible = "fixed-clock";
> -		#clock-cells = <0>;
> -		clock-frequency = <32000>;
> -		clock-output-names = "clk32k";
> -	};
> -
>  	timer {
>  		compatible = "arm,armv8-timer";
>  		interrupt-parent = <&gic>;
