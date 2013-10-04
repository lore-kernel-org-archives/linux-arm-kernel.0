From: jg1.han@samsung.com (Jingoo Han)
Date: Fri, 04 Oct 2013 11:20:32 +0900
Subject: [PATCH v2 1/5] ARM: dts: Add fimd display-timings for
 exynos5250-snow
In-Reply-To: <1380839303-4834-2-git-send-email-seanpaul@chromium.org>
References: <1380670860-17621-1-git-send-email-seanpaul@chromium.org>
 <1380839303-4834-1-git-send-email-seanpaul@chromium.org>
 <1380839303-4834-2-git-send-email-seanpaul@chromium.org>
Message-ID: <000401cec0a8$4d53a850$e7faf8f0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, October 04, 2013 7:28 AM, Sean Paul wrote:
> 
> This patch adds the internal panel timings to the exynos5250-snow board
> dts file.
> 
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> ---
> 
> v2: No difference
> 
>  arch/arm/boot/dts/exynos5250-snow.dts | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
> index fd711e2..2a0f0de 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -186,6 +186,23 @@
>  		samsung,vbus-gpio = <&gpx1 1 0>;
>  	};
> 
> +	fimd: fimd at 14400000 {
> +		display-timings {

How about adding 'status = "okay"' as below? 

	fimd: fimd at 14400000 {
		status = "okay";
		display-timings {

status of fimd node was disabled by exynos5.dtsi 

./arch/arm/boot/dts/exynos5.dtsi
fimd at 14400000 {
		status = "disabled";

Best regards,
Jingoo Han
