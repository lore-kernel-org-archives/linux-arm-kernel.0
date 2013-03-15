From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Fri, 15 Mar 2013 21:15:34 +0530
Subject: [PATCH v2 3/4] ARM: dts: Add adc to exynos5250 device tree file
In-Reply-To: <1363207202-10858-4-git-send-email-dianders@chromium.org>
References: <1363129994-10438-1-git-send-email-dianders@chromium.org>
 <1363207202-10858-1-git-send-email-dianders@chromium.org>
 <1363207202-10858-4-git-send-email-dianders@chromium.org>
Message-ID: <CAHfPSqAy5RytMO-jGC9+veNuPw+Qj0K7sV+zQv01xKEm0M9=pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 March 2013 02:10, Doug Anderson <dianders@chromium.org> wrote:
> Add the device tree entry for the device-tree enabled ADC driver that
> recently landed in the iio tree.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>

I've not used the "clock" binding yet, Will test with that and give a tag.
> ---
> Changes in v2: None
>
>  arch/arm/boot/dts/exynos5250.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 3acf594..1642062 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -69,6 +69,17 @@
>                              <0 28 0>, <0 29 0>, <0 30 0>, <0 31 0>;
>         };
>
> +       adc: adc at 12D10000 {
> +               compatible = "samsung,exynos-adc-v1";
> +               reg = <0x12D10000 0x100>, <0x10040718 0x4>;
> +               interrupts = <0 106 0>;
> +               #io-channel-cells = <1>;
> +               io-channel-ranges;
> +
> +               clocks = <&clock 303>;
> +               clock-names = "adc";
> +       };
> +
>         watchdog {
>                 compatible = "samsung,s3c2410-wdt";
>                 reg = <0x101D0000 0x100>;
> --
> 1.8.1.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



--
Shine bright,
(: Nav :)
