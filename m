From: horms@verge.net.au (Simon Horman)
Date: Mon, 27 Oct 2014 09:27:48 +0900
Subject: [PATCH 2/2] ARM: shmobile: r8a7778: Add SoC-specific TMU
 compatible property
In-Reply-To: <1414150563-6645-2-git-send-email-geert+renesas@glider.be>
References: <1414150563-6645-1-git-send-email-geert+renesas@glider.be>
 <1414150563-6645-2-git-send-email-geert+renesas@glider.be>
Message-ID: <20141027002747.GL25692@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 01:36:03PM +0200, Geert Uytterhoeven wrote:
> The TMU timers used the generic compatible property only.
> Add the SoC-specific one, to make it future proof.

Thanks, I have queued this up.

> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/boot/dts/r8a7778.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
> index 1e80e4c694828e15..96297f67fda8e632 100644
> --- a/arch/arm/boot/dts/r8a7778.dtsi
> +++ b/arch/arm/boot/dts/r8a7778.dtsi
> @@ -163,7 +163,7 @@
>  	};
>  
>  	tmu0: timer at ffd80000 {
> -		compatible = "renesas,tmu";
> +		compatible = "renesas,tmu-r8a7778", "renesas,tmu";
>  		reg = <0xffd80000 0x30>;
>  		interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>,
>  			     <0 33 IRQ_TYPE_LEVEL_HIGH>,
> @@ -175,7 +175,7 @@
>  	};
>  
>  	tmu1: timer at ffd81000 {
> -		compatible = "renesas,tmu";
> +		compatible = "renesas,tmu-r8a7778", "renesas,tmu";
>  		reg = <0xffd81000 0x30>;
>  		interrupts = <0 36 IRQ_TYPE_LEVEL_HIGH>,
>  			     <0 37 IRQ_TYPE_LEVEL_HIGH>,
> @@ -187,7 +187,7 @@
>  	};
>  
>  	tmu2: timer at ffd82000 {
> -		compatible = "renesas,tmu";
> +		compatible = "renesas,tmu-r8a7778", "renesas,tmu";
>  		reg = <0xffd82000 0x30>;
>  		interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>,
>  			     <0 41 IRQ_TYPE_LEVEL_HIGH>,
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
