From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 03 Feb 2015 13:14:24 +0900
Subject: [PATCH] ARM: dts: Fix CLK_MOUT_CAMn parent clocks assignment for
 Trats2
In-Reply-To: <1421430016-32248-1-git-send-email-s.nawrocki@samsung.com>
References: <1421430016-32248-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <06fa01d03f67$e5044cb0$af0ce610$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> In order to get exact 24MHz clock frequency value for the camera
> sensor and avoid rounding errors the parent clock must be CLK_XUSBXTI,
> not CLK_MOUT_MPLL_USER_T.  Currently the sensor's master clock
> frequency is too high and the sensor doesn't work properly.
> 
> This fixes commit 0357a4438d531ef3cf529e80ffcd208eb8e35f55
> ("ARM: dts: Specify default clocks for Exynos4 camera devices").
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412-trats2.dts |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
> index 29231b4..9ae62c2 100644
> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
> @@ -721,8 +721,8 @@
>  		status = "okay";
>  		assigned-clocks = <&clock CLK_MOUT_CAM0>,
>  				  <&clock CLK_MOUT_CAM1>;
> -		assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>,
> -					 <&clock CLK_MOUT_MPLL_USER_T>;
> +		assigned-clock-parents = <&clock CLK_XUSBXTI>,
> +					 <&clock CLK_XUSBXTI>;
> 
>  		fimc_0: fimc at 11800000 {
>  			status = "okay";
> --

Applied, thanks.

- Kukjin
