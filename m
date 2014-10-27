From: horms@verge.net.au (Simon Horman)
Date: Mon, 27 Oct 2014 09:27:38 +0900
Subject: [PATCH 1/2] ARM: shmobile: r8a73a4: Add SoC-specific CMT
 compatible property
In-Reply-To: <1414150563-6645-1-git-send-email-geert+renesas@glider.be>
References: <1414150563-6645-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20141027002738.GK25692@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 01:36:02PM +0200, Geert Uytterhoeven wrote:
> The CMT1 timer used the generic compatible property only.
> Add the SoC-specific one, which is already documented, to make it future
> proof.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up.

> ---
>  arch/arm/boot/dts/r8a73a4.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
> index 80939671b0342006..b5ead845c6c32f24 100644
> --- a/arch/arm/boot/dts/r8a73a4.dtsi
> +++ b/arch/arm/boot/dts/r8a73a4.dtsi
> @@ -114,7 +114,7 @@
>  	};
>  
>  	cmt1: timer at e6130000 {
> -		compatible = "renesas,cmt-48-gen2";
> +		compatible = "renesas,cmt-48-r8a73a4", "renesas,cmt-48-gen2";
>  		reg = <0 0xe6130000 0 0x1004>;
>  		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>;
>  
> -- 
> 1.9.1
> 
