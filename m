From: horms@verge.net.au (Simon Horman)
Date: Fri, 11 Dec 2015 13:04:06 +0900
Subject: [PATCH] ARM: shmobile: r8a779x: use SoC-specific usb-dac
 compatibility strings
In-Reply-To: <1449802778-11777-1-git-send-email-horms+renesas@verge.net.au>
References: <1449802778-11777-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20151211040406.GB13336@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 11:59:38AM +0900, Simon Horman wrote:
> Use recently SoC-specific compatibility strings in r8a779[01] device trees.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> Based on renesas-devel-20151211-v4.4-rc4

Bother, there is a typo in the subject.
I plan to fix that either when merging or reposting the patch
depending on what other feedback I get.

> ---
>  arch/arm/boot/dts/r8a7790.dtsi | 4 ++--
>  arch/arm/boot/dts/r8a7791.dtsi | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index 9f3036b80c0e..c6f083c9345d 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -386,7 +386,7 @@
>  	};
>  
>  	usb_dmac0: dma-controller at e65a0000 {
> -		compatible = "renesas,usb-dmac";
> +		compatible = "renesas,r8a7790-usb-dmac", "renesas,usb-dmac";
>  		reg = <0 0xe65a0000 0 0x100>;
>  		interrupts = <0 109 IRQ_TYPE_LEVEL_HIGH
>  			      0 109 IRQ_TYPE_LEVEL_HIGH>;
> @@ -398,7 +398,7 @@
>  	};
>  
>  	usb_dmac1: dma-controller at e65b0000 {
> -		compatible = "renesas,usb-dmac";
> +		compatible = "renesas,r8a7790-usb-dmac", "renesas,usb-dmac";
>  		reg = <0 0xe65b0000 0 0x100>;
>  		interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH
>  			      0 110 IRQ_TYPE_LEVEL_HIGH>;
> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index 36559cb0eb6b..ae1dda181624 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -375,7 +375,7 @@
>  	};
>  
>  	usb_dmac0: dma-controller at e65a0000 {
> -		compatible = "renesas,usb-dmac";
> +		compatible = "renesas,r8a7791-usb-dmac", "renesas,usb-dmac";
>  		reg = <0 0xe65a0000 0 0x100>;
>  		interrupts = <0 109 IRQ_TYPE_LEVEL_HIGH
>  			      0 109 IRQ_TYPE_LEVEL_HIGH>;
> @@ -387,7 +387,7 @@
>  	};
>  
>  	usb_dmac1: dma-controller at e65b0000 {
> -		compatible = "renesas,usb-dmac";
> +		compatible = "renesas,r8a7791-usb-dmac", "renesas,usb-dmac";
>  		reg = <0 0xe65b0000 0 0x100>;
>  		interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH
>  			      0 110 IRQ_TYPE_LEVEL_HIGH>;
> -- 
> 2.1.4
> 
