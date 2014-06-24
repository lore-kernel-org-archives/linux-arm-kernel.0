From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 24 Jun 2014 14:33:14 +0100
Subject: [PATCH 3/4] ARM: DTS: use new compatible string as per the
 documentation
In-Reply-To: <1403612356-23685-4-git-send-email-ch.naveen@samsung.com>
References: <1403612356-23685-1-git-send-email-ch.naveen@samsung.com>
 <1403612356-23685-4-git-send-email-ch.naveen@samsung.com>
Message-ID: <20140624133314.GJ5856@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 01:19:15PM +0100, Naveen Krishna Chatradhi wrote:
> As Murata is the Manufactures the NTC thermistors. The vendor
> name in the compatibility is preposed to change to "murata, ncpXXX"
> 
> This patch uses the new compatibility string in exynos4412 based
> Trats2 board.
> 
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> 1. Updates the thermistor node in Exynos4412 based Trats2 dts
>    using the new DT bindings for NTC thermistors updated with vendor-prefix
> 
>  arch/arm/boot/dts/exynos4412-trats2.dts |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
> index 11967f4..d35755a 100644
> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
> @@ -771,7 +771,7 @@
>  	};
>  
>  	thermistor-ap at 0 {
> -		compatible = "ntc,ncp15wb473";
> +		compatible = "murata,ncp15wb473";

So the previous patch woul have broken this board?

Mark.

>  		pullup-uv = <1800000>;	 /* VCC_1.8V_AP */
>  		pullup-ohm = <100000>;	 /* 100K */
>  		pulldown-ohm = <100000>; /* 100K */
> @@ -779,7 +779,7 @@
>  	};
>  
>  	thermistor-battery at 1 {
> -		compatible = "ntc,ncp15wb473";
> +		compatible = "murata,ncp15wb473";
>  		pullup-uv = <1800000>;	 /* VCC_1.8V_AP */
>  		pullup-ohm = <100000>;	 /* 100K */
>  		pulldown-ohm = <100000>; /* 100K */
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
