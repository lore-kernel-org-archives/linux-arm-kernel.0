From: jg1.han@samsung.com (Jingoo Han)
Date: Sat, 11 May 2013 14:07:29 +0900
Subject: [PATCH] ARM: exynos: dts: Fixed vbus-gpios
In-Reply-To: <1368034636-15865-1-git-send-email-dianders@chromium.org>
References: <1368034636-15865-1-git-send-email-dianders@chromium.org>
Message-ID: <002501ce4e05$6fe4c630$4fae5290$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, May 09, 2013 2:37 AM, Doug Anderson wrote:
> 
> The 'samsung,vbus-gpio' was submitted before pinmux landed for
> exynos5250 and uses the old-style gpio specifier.  Fix the two
> exynos5250 boards that use it.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  arch/arm/boot/dts/exynos5250-smdk5250.dts | 2 +-
>  arch/arm/boot/dts/exynos5250-snow.dts     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index 26d856b..3e0c792 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -214,7 +214,7 @@
>  	};
> 
>  	usb at 12110000 {
> -		samsung,vbus-gpio = <&gpx2 6 1 3 3>;
> +		samsung,vbus-gpio = <&gpx2 6 0>;
>  	};
> 
>  	dp-controller {
> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
> index bf4744b..d449feb 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -183,7 +183,7 @@
>  	};
> 
>  	usb at 12110000 {
> -		samsung,vbus-gpio = <&gpx1 1 1 3 3>;
> +		samsung,vbus-gpio = <&gpx1 1 0>;
>  	};
> 
>  	fixed-rate-clocks {
> --
> 1.8.2.1
