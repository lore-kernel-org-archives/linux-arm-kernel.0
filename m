From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 21 Aug 2016 19:58:40 +0100
Subject: [PATCH v7 3/3] arm: dts: mt2701: Add auxadc node.
In-Reply-To: <1471504297-26947-4-git-send-email-zhiyong.tao@mediatek.com>
References: <1471504297-26947-1-git-send-email-zhiyong.tao@mediatek.com>
 <1471504297-26947-4-git-send-email-zhiyong.tao@mediatek.com>
Message-ID: <c238236c-2445-7802-6f2e-2f4776778c36@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/08/16 08:11, Zhiyong Tao wrote:
> The commit adds auxadc nodes to the Mediatek MT2701 dtsi file.
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> ---
> This patch dependents on "Add clock support for Mediatek MT2701"[1].
> Please accept this patch together with [1].
> [1]http://lists.infradead.org/pipermail/linux-mediatek/2016-August/006620.html
Guessing this is working it's way ultimately through arm-soc.  Patches
1 and 2 are now heading through the iio / staging-iio route and should be
merging in the next merge window if nothing odd happens.

Thanks,

Jonathan
> ---
>  arch/arm/boot/dts/mt2701.dtsi |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
> index 7eab6f4..8e6a18c 100644
> --- a/arch/arm/boot/dts/mt2701.dtsi
> +++ b/arch/arm/boot/dts/mt2701.dtsi
> @@ -175,6 +175,15 @@
>  		      <0 0x10216000 0 0x2000>;
>  	};
>  
> +	auxadc: adc at 11001000 {
> +		compatible = "mediatek,mt2701-auxadc";
> +		reg = <0 0x11001000 0 0x1000>;
> +		clocks = <&pericfg CLK_PERI_AUXADC>;
> +		clock-names = "main";
> +		#io-channel-cells = <1>;
> +		status = "disabled";
> +	};
> +
>  	uart0: serial at 11002000 {
>  		compatible = "mediatek,mt2701-uart",
>  			     "mediatek,mt6577-uart";
> 
