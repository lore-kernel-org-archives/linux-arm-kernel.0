From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 28 Sep 2015 10:56:49 +0200
Subject: [PATCH RESEND] ARM: dts: Move display-timings node from fimd to dp
In-Reply-To: <1442494120-463-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1442494120-463-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <CAAObsKDqpBnggX7sHCgQ5d7ZxYumh_ga8kbLQc4bQ=N+M6BoCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin and Krzysztof,

could you take a look at this?

Thanks,

Tomeu

On 17 September 2015 at 14:48, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> From: Sean Paul <seanpaul@chromium.org>
>
> This patch moves the display-timings node from fimd to dp to reflect the
> device tree bindings change.
>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> [tomeu.vizoso at collabora.com: Rebased]
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>
> ---
>
> Hi,
>
> looks like a long time ago the bindings were changed and the DTs for
> these boards weren't updated.
>
> I have retaken Sean's forgotten patch and rebased it, but I have only
> tested on an Arndale that exynos-drm doesn't complain about missing
> timings.
>
> Regards,
>
> Tomeu
> ---
>  arch/arm/boot/dts/exynos5250-arndale.dts  |  8 ++++----
>  arch/arm/boot/dts/exynos5250-smdk5250.dts | 16 ++++++++--------
>  arch/arm/boot/dts/exynos5420-smdk5420.dts |  7 ++++---
>  3 files changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
> index db3f65f3eb45..c000532c1444 100644
> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
> @@ -129,10 +129,6 @@
>         samsung,color-depth = <1>;
>         samsung,link-rate = <0x0a>;
>         samsung,lane-count = <4>;
> -};
> -
> -&fimd {
> -       status = "okay";
>
>         display-timings {
>                 native-mode = <&timing0>;
> @@ -152,6 +148,10 @@
>         };
>  };
>
> +&fimd {
> +       status = "okay";
> +};
> +
>  &hdmi {
>         hpd-gpio = <&gpx3 7 GPIO_ACTIVE_LOW>;
>         vdd_osc-supply = <&ldo10_reg>;
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index c625e71217aa..0f5dcd418af8 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -89,14 +89,6 @@
>         pinctrl-names = "default";
>         pinctrl-0 = <&dp_hpd>;
>         status = "okay";
> -};
> -
> -&ehci {
> -       samsung,vbus-gpio = <&gpx2 6 GPIO_ACTIVE_HIGH>;
> -};
> -
> -&fimd {
> -       status = "okay";
>
>         display-timings {
>                 native-mode = <&timing0>;
> @@ -116,6 +108,14 @@
>         };
>  };
>
> +&ehci {
> +       samsung,vbus-gpio = <&gpx2 6 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&fimd {
> +       status = "okay";
> +};
> +
>  &hdmi {
>         hpd-gpio = <&gpx3 7 GPIO_ACTIVE_HIGH>;
>  };
> diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> index 98871f972c8a..7520d52f4e22 100644
> --- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> @@ -98,10 +98,7 @@
>         samsung,link-rate = <0x0a>;
>         samsung,lane-count = <4>;
>         status = "okay";
> -};
>
> -&fimd {
> -       status = "okay";
>         display-timings {
>                 native-mode = <&timing0>;
>                 timing0: timing at 0 {
> @@ -118,6 +115,10 @@
>         };
>  };
>
> +&fimd {
> +       status = "okay";
> +};
> +
>  &hdmi {
>         status = "okay";
>         hpd-gpio = <&gpx3 7 0>;
> --
> 2.4.3
>
