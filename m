From: horms@verge.net.au (Simon Horman)
Date: Thu, 11 May 2017 16:53:24 +0200
Subject: [PATCH v3 2/3] arm64: dts: r8a7795: salvator-x: Add support for
 R-Car H3 ES2.0
In-Reply-To: <1494503934-23367-3-git-send-email-geert+renesas@glider.be>
References: <1494503934-23367-1-git-send-email-geert+renesas@glider.be>
 <1494503934-23367-3-git-send-email-geert+renesas@glider.be>
Message-ID: <20170511145324.GC21895@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 11, 2017 at 01:58:53PM +0200, Geert Uytterhoeven wrote:
> Split off support for Salvator-X boards with the ES1.x revision of the
> R-Car H3 SoC into a separate file.  The main r8a7795-salvator-x.dts file
> now corresponds to Salvator-X with R-Car H3 ES2.0 or later.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - Rebase on top of common Salvator-X board support extraction,
> 
> v2:
>   - Use a separate file for ES1.x instead of for ES2.0, so
>     r8a7795-salvator-x.dts always corresponds to the board with the
>     latest SoC revision,
>   - Add a dash between SoC part number and revision, for compatibility
>     with the BSP,
>   - Enhance the hardware description from basic support to everything
>     already supported on ES1.x.
> ---
>  arch/arm64/boot/dts/renesas/Makefile                                  | 1 +
>  .../renesas/{r8a7795-salvator-x.dts => r8a7795-es1-salvator-x.dts}    | 0
>  arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts                    | 4 ++--
>  3 files changed, 3 insertions(+), 2 deletions(-)
>  copy arch/arm64/boot/dts/renesas/{r8a7795-salvator-x.dts => r8a7795-es1-salvator-x.dts} (100%)
> 
> diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
> index 1618e0a3c81d48bd..b6c723d8f6875f2d 100644
> --- a/arch/arm64/boot/dts/renesas/Makefile
> +++ b/arch/arm64/boot/dts/renesas/Makefile
> @@ -1,4 +1,5 @@
>  dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-salvator-x.dtb r8a7795-h3ulcb.dtb
> +dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-es1-salvator-x.dtb

Probably this was already discussed but I wonder if there is any value
in a CONFIG_ARCH_R8A7795_ES1 Kconfig symbol to allow more fine grained
control over what is compiled into the kernel.

>  dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-salvator-x.dtb r8a7796-m3ulcb.dtb
>  
>  always		:= $(dtb-y)
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts
> similarity index 100%
> copy from arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> copy to arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> index be5b2e966ea1700e..fc26909dfa47b61f 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> @@ -11,11 +11,11 @@
>  #define CPG_AUDIO_CLK_I		R8A7795_CLK_S0D4
>  
>  /dts-v1/;
> -#include "r8a7795-es1.dtsi"
> +#include "r8a7795.dtsi"
>  #include "salvator-x.dtsi"
>  
>  / {
> -	model = "Renesas Salvator-X board based on r8a7795 ES1.x";
> +	model = "Renesas Salvator-X board based on r8a7795 ES2.0+";
>  	compatible = "renesas,salvator-x", "renesas,r8a7795";
>  
>  	memory at 48000000 {
> -- 
> 2.7.4
> 
