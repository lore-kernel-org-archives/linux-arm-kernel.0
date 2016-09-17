From: alim.akhtar@gmail.com (Alim Akhtar)
Date: Sat, 17 Sep 2016 23:00:00 +0530
Subject: [PATCH 06/10] ARM: dts: exynos: Fix invalid GIC interrupt flags
 in exynos5
In-Reply-To: <1474054971-16831-7-git-send-email-krzk@kernel.org>
References: <1474054971-16831-1-git-send-email-krzk@kernel.org>
 <1474054971-16831-7-git-send-email-krzk@kernel.org>
Message-ID: <CAGOxZ52Aqp+_fcOMJuB2ouHzOMzX4s_mP1jDrgYYtNAx+rDXJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 17, 2016 at 1:12 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Interrupt of type IRQ_TYPE_NONE is not allowed for GIC interrupts and
> generates an error:
>         genirq: Setting trigger mode 0 for irq 16 failed (gic_set_type+0x0/0x68)
>
> The GIC requires shared interrupts to be edge rising or level high.
> Platform declares support for both.  Choose level high everywhere.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reported-by: Alban Browaeys <alban.browaeys@gmail.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

Tested in exynos5800, so

Tested-by: Alim Akhtar <alim.akhtar@samsung.com>

>  arch/arm/boot/dts/exynos5.dtsi | 60 ++++++++++++++++++++++++++++++------------
>  1 file changed, 43 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
> index 8f06609879f5..d9b1607db5ad 100644
> --- a/arch/arm/boot/dts/exynos5.dtsi
> +++ b/arch/arm/boot/dts/exynos5.dtsi
> @@ -13,6 +13,7 @@
>   * published by the Free Software Foundation.
>   */
>
> +#include <dt-bindings/interrupt-controller/irq.h>
>  #include "exynos-syscon-restart.dtsi"
>
>  / {
> @@ -53,14 +54,38 @@
>                         interrupt-controller;
>                         samsung,combiner-nr = <32>;
>                         reg = <0x10440000 0x1000>;
> -                       interrupts =    <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
> -                                       <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
> -                                       <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
> -                                       <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>,
> -                                       <0 16 0>, <0 17 0>, <0 18 0>, <0 19 0>,
> -                                       <0 20 0>, <0 21 0>, <0 22 0>, <0 23 0>,
> -                                       <0 24 0>, <0 25 0>, <0 26 0>, <0 27 0>,
> -                                       <0 28 0>, <0 29 0>, <0 30 0>, <0 31 0>;
> +                       interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 1 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 2 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 3 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 4 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 5 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 6 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 7 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 8 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 9 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 10 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 11 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 12 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 13 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 14 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 15 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 16 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 17 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 18 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 19 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 20 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 21 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 22 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 23 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 24 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 25 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 26 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 27 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 28 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 29 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 30 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 31 IRQ_TYPE_LEVEL_HIGH>;
>                 };
>
>                 gic: interrupt-controller at 10481000 {
> @@ -82,31 +107,31 @@
>                 serial_0: serial at 12C00000 {
>                         compatible = "samsung,exynos4210-uart";
>                         reg = <0x12C00000 0x100>;
> -                       interrupts = <0 51 0>;
> +                       interrupts = <0 51 IRQ_TYPE_LEVEL_HIGH>;
>                 };
>
>                 serial_1: serial at 12C10000 {
>                         compatible = "samsung,exynos4210-uart";
>                         reg = <0x12C10000 0x100>;
> -                       interrupts = <0 52 0>;
> +                       interrupts = <0 52 IRQ_TYPE_LEVEL_HIGH>;
>                 };
>
>                 serial_2: serial at 12C20000 {
>                         compatible = "samsung,exynos4210-uart";
>                         reg = <0x12C20000 0x100>;
> -                       interrupts = <0 53 0>;
> +                       interrupts = <0 53 IRQ_TYPE_LEVEL_HIGH>;
>                 };
>
>                 serial_3: serial at 12C30000 {
>                         compatible = "samsung,exynos4210-uart";
>                         reg = <0x12C30000 0x100>;
> -                       interrupts = <0 54 0>;
> +                       interrupts = <0 54 IRQ_TYPE_LEVEL_HIGH>;
>                 };
>
>                 i2c_0: i2c at 12C60000 {
>                         compatible = "samsung,s3c2440-i2c";
>                         reg = <0x12C60000 0x100>;
> -                       interrupts = <0 56 0>;
> +                       interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         samsung,sysreg-phandle = <&sysreg_system_controller>;
> @@ -116,7 +141,7 @@
>                 i2c_1: i2c at 12C70000 {
>                         compatible = "samsung,s3c2440-i2c";
>                         reg = <0x12C70000 0x100>;
> -                       interrupts = <0 57 0>;
> +                       interrupts = <0 57 IRQ_TYPE_LEVEL_HIGH>;
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         samsung,sysreg-phandle = <&sysreg_system_controller>;
> @@ -126,7 +151,7 @@
>                 i2c_2: i2c at 12C80000 {
>                         compatible = "samsung,s3c2440-i2c";
>                         reg = <0x12C80000 0x100>;
> -                       interrupts = <0 58 0>;
> +                       interrupts = <0 58 IRQ_TYPE_LEVEL_HIGH>;
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         samsung,sysreg-phandle = <&sysreg_system_controller>;
> @@ -136,7 +161,7 @@
>                 i2c_3: i2c at 12C90000 {
>                         compatible = "samsung,s3c2440-i2c";
>                         reg = <0x12C90000 0x100>;
> -                       interrupts = <0 59 0>;
> +                       interrupts = <0 59 IRQ_TYPE_LEVEL_HIGH>;
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         samsung,sysreg-phandle = <&sysreg_system_controller>;
> @@ -153,7 +178,8 @@
>                 rtc: rtc at 101E0000 {
>                         compatible = "samsung,s3c6410-rtc";
>                         reg = <0x101E0000 0x100>;
> -                       interrupts = <0 43 0>, <0 44 0>;
> +                       interrupts = <0 43 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 44 IRQ_TYPE_LEVEL_HIGH>;
>                         status = "disabled";
>                 };
>
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Alim
