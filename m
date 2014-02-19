From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 19 Feb 2014 15:07:39 +0800
Subject: [PATCH 1/4] ARM: dts: Add Freescale SAI ALSA SoC Digital Audio
 Interface node for VF610.
In-Reply-To: <1392788323-6092-2-git-send-email-Li.Xiubo@freescale.com>
References: <1392788323-6092-1-git-send-email-Li.Xiubo@freescale.com>
 <1392788323-6092-2-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <20140219070737.GF3010@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 01:38:40PM +0800, Xiubo Li wrote:
> This patch adds the SAI's edma mux Tx and Rx support.
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>

'ARM: dts: vf610: ...' for patch prefix.

Shawn

> ---
>  arch/arm/boot/dts/vf610.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
> index 91a7757..f08df47 100644
> --- a/arch/arm/boot/dts/vf610.dtsi
> +++ b/arch/arm/boot/dts/vf610.dtsi
> @@ -169,6 +169,9 @@
>  				interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clks VF610_CLK_SAI2>;
>  				clock-names = "sai";
> +				dma-names = "tx", "rx";
> +				dmas = <&edma0 0 21>,
> +					<&edma0 0 20>;
>  				status = "disabled";
>  			};
>  
> -- 
> 1.8.4
> 
> 
