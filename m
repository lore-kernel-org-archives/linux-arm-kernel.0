From: jg1.han@samsung.com (Jingoo Han)
Date: Fri, 04 Oct 2013 11:24:35 +0900
Subject: [PATCH v2 2/5] ARM: dts: Add dp-controller node to exynos5250-snow
In-Reply-To: <1380839303-4834-3-git-send-email-seanpaul@chromium.org>
References: <1380670860-17621-1-git-send-email-seanpaul@chromium.org>
 <1380839303-4834-1-git-send-email-seanpaul@chromium.org>
 <1380839303-4834-3-git-send-email-seanpaul@chromium.org>
Message-ID: <000501cec0a8$de4b5240$9ae1f6c0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, October 04, 2013 7:28 AM, Sean Paul wrote:
> 
> This patch adds the dp-controller node to the exynos5250-snow board dts
> file.
> 
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> ---
> 
> v2: Added dp-controller address to node (rebased on linux-next)
> 
>  arch/arm/boot/dts/exynos5250-snow.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
> index 2a0f0de..f1cf68e 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -186,6 +186,18 @@
>  		samsung,vbus-gpio = <&gpx1 1 0>;
>  	};
> 
> +	dp-controller at 145B0000 {
> +		samsung,color-space = <0>;
> +		samsung,dynamic-range = <0>;
> +		samsung,ycbcr-coeff = <0>;
> +		samsung,color-depth = <1>;
> +		samsung,link-rate = <0x0a>;
> +		samsung,lane-count = <2>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&dp_hpd>;

How about adding 'status = "okay" as below?

		pinctrl-names = "default";
		pinctrl-0 = <&dp_hpd>;
		status = "okay";

status of dp node was disabled by exynos5.dtsi.

./arch/arm/boot/dts/exynos5.dtsi
dp-controller at 145B0000 {
	status = "disabled";

Best regards,
Jingoo Han
