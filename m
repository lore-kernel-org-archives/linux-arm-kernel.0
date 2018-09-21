From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 21 Sep 2018 13:12:06 +0200
Subject: [PATCHv3 5/7] ARM: dts: exynos5422: use wp-gpio method to detect
 sd-card
In-Reply-To: <20180920175826.1284-6-linux.amoon@gmail.com>
References: <20180920175826.1284-1-linux.amoon@gmail.com>
 <20180920175826.1284-6-linux.amoon@gmail.com>
Message-ID: <CAJKOXPdUVjG1xR-q-K98RQpqsWzw-emEv2_3x3CoS+XK8cye2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Sep 2018 at 19:59, Anand Moon <linux.amoon@gmail.com> wrote:
>
> add the Write Protect GPIO property for sdcard, to fix
> the warning message during boot time.
> of_get_named_gpiod_flags: can't parse 'wp-gpios' property of node '/soc/mmc at 12220000[0]'
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> New patch to this series.
> If we keep the wp-gpio GPIO_ACTIVE_LOW sdcard boot into RO mode.
> ---
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> index 03fe02ceae66..475c38bbc99e 100644
> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> @@ -370,6 +370,7 @@
>         cap-sd-highspeed;
>         max-frequency = <200000000>;
>         cd-gpios = <&gpc2 2 GPIO_ACTIVE_LOW>;
> +       wp-gpios = <&gpc4 0 GPIO_ACTIVE_HIGH>;

Two issues here:
1. You need also proper pinctrl setting.
2. On schematics the WP is not connected... so how do you know that it
is active high? How did you test it? How do you want to test it on
microSD?

Best regards,
Krzysztof

>         vmmc-supply = <&ldo19_reg>;
>         vqmmc-supply = <&ldo13_reg>;
>         sd-uhs-sdr50;
> --
> 2.17.1
>
