From: tomeu@tomeuvizoso.net (Tomeu Vizoso)
Date: Tue, 12 Aug 2014 15:06:20 +0200
Subject: [PATCH 1/2] ARM: dts: Enable PMIC interrupts on ODROID
In-Reply-To: <1405500606-5752-1-git-send-email-drake@endlessm.com>
References: <1405500606-5752-1-git-send-email-drake@endlessm.com>
Message-ID: <CAAObsKAokjDmpVy5cm_iFD52bCq+3jYeGDWzACsmh-JKktyjDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested on an Odroid-U2:

Tested-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

Thanks,

Tomeu


On 16 July 2014 10:50, Daniel Drake <drake@endlessm.com> wrote:
> The ODROID kernel shows that the PMIC interrupt line is hooked up
> to pin GPX3-2.
>
> This is needed for the max77686-irq driver to create the PMIC IRQ
> domain, which is needed by max77686-rtc.
>
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> ---
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> index 6d6d23c..cb6f55f 100644
> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> @@ -148,6 +148,10 @@
>
>                 max77686: pmic at 09 {
>                         compatible = "maxim,max77686";
> +                       interrupt-parent = <&gpx3>;
> +                       interrupts = <2 0>;
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&max77686_irq>;
>                         reg = <0x09>;
>                         #clock-cells = <1>;
>
> @@ -368,4 +372,11 @@
>                 samsung,pins = "gpx1-3";
>                 samsung,pin-pud = <0>;
>         };
> +
> +       max77686_irq: max77686-irq {
> +               samsung,pins = "gpx3-2";
> +               samsung,pin-function = <0>;
> +               samsung,pin-pud = <0>;
> +               samsung,pin-drv = <0>;
> +       };
>  };
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
