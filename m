From: alim.akhtar@gmail.com (Alim Akhtar)
Date: Wed, 18 Jan 2017 22:43:30 +0900
Subject: [PATCH 3/3] arm64: dts: exynos: Use macros for pinctrl
 configuration on Exynos7
In-Reply-To: <1484718141-28785-4-git-send-email-pankaj.dubey@samsung.com>
References: <CGME20170118054013epcas5p3b20dca776ee350f4ba863db24d3dea67@epcas5p3.samsung.com>
 <1484718141-28785-1-git-send-email-pankaj.dubey@samsung.com>
 <1484718141-28785-4-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <CAGOxZ51eLRdJBh74N2AEgu0pNFh4WfrRP0VMbhxgZzpx6dsfuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 18, 2017 at 2:42 PM, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
> Usage of DTS macros instead of hard-coded numbers makes code easier to
> read.  One does not have to remember which value means pull-up/down or
> specific driver strength.
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
Looks good.
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  arch/arm64/boot/dts/exynos/exynos7-espresso.dts |   4 +-
>  arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi | 302 ++++++++++++------------
>  2 files changed, 154 insertions(+), 152 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> index c528dd5..1b2db9f0 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> @@ -328,8 +328,8 @@
>  &pinctrl_alive {
>         pmic_irq: pmic-irq {
>                 samsung,pins = "gpa0-2";
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <3>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV3>;
>         };
>  };
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
> index 7ebb939..8f58850 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
> @@ -12,6 +12,8 @@
>   * published by the Free Software Foundation.
>  */
>
> +#include <dt-bindings/pinctrl/samsung.h>
> +
>  &pinctrl_alive {
>         gpa0: gpa0 {
>                 gpio-controller;
> @@ -187,163 +189,163 @@
>
>         hs_i2c10_bus: hs-i2c10-bus {
>                 samsung,pins = "gpb0-1", "gpb0-0";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
>         hs_i2c11_bus: hs-i2c11-bus {
>                 samsung,pins = "gpb0-3", "gpb0-2";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
>         hs_i2c2_bus: hs-i2c2-bus {
>                 samsung,pins = "gpd0-3", "gpd0-2";
> -               samsung,pin-function = <3>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
>         uart0_data: uart0-data {
>                 samsung,pins = "gpd0-0", "gpd0-1";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <0>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
>         uart0_fctl: uart0-fctl {
>                 samsung,pins = "gpd0-2", "gpd0-3";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <0>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
>         uart2_data: uart2-data {
>                 samsung,pins = "gpd1-4", "gpd1-5";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <0>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
>         hs_i2c3_bus: hs-i2c3-bus {
>                 samsung,pins = "gpd1-3", "gpd1-2";
> -               samsung,pin-function = <3>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
>         uart1_data: uart1-data {
>                 samsung,pins = "gpd1-0", "gpd1-1";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <0>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
>         uart1_fctl: uart1-fctl {
>                 samsung,pins = "gpd1-2", "gpd1-3";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <0>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
>         hs_i2c0_bus: hs-i2c0-bus {
>                 samsung,pins = "gpd2-1", "gpd2-0";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
>         hs_i2c1_bus: hs-i2c1-bus {
>                 samsung,pins = "gpd2-3", "gpd2-2";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
>         hs_i2c9_bus: hs-i2c9-bus {
>                 samsung,pins = "gpd2-7", "gpd2-6";
> -               samsung,pin-function = <3>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
>         pwm0_out: pwm0-out {
>                 samsung,pins = "gpd2-4";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <0>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
>         pwm1_out: pwm1-out {
>                 samsung,pins = "gpd2-5";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <0>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
>         pwm2_out: pwm2-out {
>                 samsung,pins = "gpd2-6";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <0>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
>         pwm3_out: pwm3-out {
>                 samsung,pins = "gpd2-7";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <0>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
>         hs_i2c8_bus: hs-i2c8-bus {
>                 samsung,pins = "gpd5-3", "gpd5-2";
> -               samsung,pin-function = <3>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
>         uart3_data: uart3-data {
>                 samsung,pins = "gpd5-0", "gpd5-1";
> -               samsung,pin-function = <3>;
> -               samsung,pin-pud = <0>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
>         spi2_bus: spi2-bus {
>                 samsung,pins = "gpd5-0", "gpd5-1", "gpd5-2", "gpd5-3";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
>         spi1_bus: spi1-bus {
>                 samsung,pins = "gpd6-2", "gpd6-3", "gpd6-4", "gpd6-5";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
>         spi0_bus: spi0-bus {
>                 samsung,pins = "gpd8-0", "gpd8-1", "gpd6-0", "gpd6-1";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
>         hs_i2c4_bus: hs-i2c4-bus {
>                 samsung,pins = "gpg3-1", "gpg3-0";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
>         hs_i2c5_bus: hs-i2c5-bus {
>                 samsung,pins = "gpg3-3", "gpg3-2";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>  };
>
> @@ -358,9 +360,9 @@
>
>         hs_i2c6_bus: hs-i2c6-bus {
>                 samsung,pins = "gpj0-1", "gpj0-0";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>  };
>
> @@ -375,9 +377,9 @@
>
>         hs_i2c7_bus: hs-i2c7-bus {
>                 samsung,pins = "gpj1-1", "gpj1-0";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>  };
>
> @@ -392,9 +394,9 @@
>
>         spi3_bus: spi3-bus {
>                 samsung,pins = "gpg4-0", "gpg4-1", "gpg4-2", "gpg4-3";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>  };
>
> @@ -409,9 +411,9 @@
>
>         spi4_bus: spi4-bus {
>                 samsung,pins = "gpv7-0", "gpv7-1", "gpv7-2", "gpv7-3";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>  };
>
> @@ -426,37 +428,37 @@
>
>         sd2_clk: sd2-clk {
>                 samsung,pins = "gpr4-0";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <0>;
> -               samsung,pin-drv = <3>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
>         };
>
>         sd2_cmd: sd2-cmd {
>                 samsung,pins = "gpr4-1";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <0>;
> -               samsung,pin-drv = <3>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
>         };
>
>         sd2_cd: sd2-cd {
>                 samsung,pins = "gpr4-2";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <3>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
>         };
>
>         sd2_bus1: sd2-bus-width1 {
>                 samsung,pins = "gpr4-3";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <3>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
>         };
>
>         sd2_bus4: sd2-bus-width4 {
>                 samsung,pins = "gpr4-4", "gpr4-5", "gpr4-6";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <3>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
>         };
>  };
>
> @@ -495,107 +497,107 @@
>
>         sd0_clk: sd0-clk {
>                 samsung,pins = "gpr0-0";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <0>;
> -               samsung,pin-drv = <4>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV2>;
>         };
>
>         sd0_cmd: sd0-cmd {
>                 samsung,pins = "gpr0-1";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <4>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV2>;
>         };
>
>         sd0_ds: sd0-ds {
>                 samsung,pins = "gpr0-2";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <1>;
> -               samsung,pin-drv = <4>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +               samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV2>;
>         };
>
>         sd0_qrdy: sd0-qrdy {
>                 samsung,pins = "gpr0-3";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <1>;
> -               samsung,pin-drv = <4>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +               samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV2>;
>         };
>
>         sd0_bus1: sd0-bus-width1 {
>                 samsung,pins = "gpr1-0";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <4>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV2>;
>         };
>
>         sd0_bus4: sd0-bus-width4 {
>                 samsung,pins = "gpr1-1", "gpr1-2", "gpr1-3";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <4>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV2>;
>         };
>
>         sd0_bus8: sd0-bus-width8 {
>                 samsung,pins = "gpr1-4", "gpr1-5", "gpr1-6", "gpr1-7";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <4>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV2>;
>         };
>
>         sd1_clk: sd1-clk {
>                 samsung,pins = "gpr2-0";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <0>;
> -               samsung,pin-drv = <2>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV3>;
>         };
>
>         sd1_cmd: sd1-cmd {
>                 samsung,pins = "gpr2-1";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <0>;
> -               samsung,pin-drv = <2>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV3>;
>         };
>
>         sd1_ds: sd1-ds {
>                 samsung,pins = "gpr2-2";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <1>;
> -               samsung,pin-drv = <6>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +               samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV4>;
>         };
>
>         sd1_qrdy: sd1-qrdy {
>                 samsung,pins = "gpr2-3";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <1>;
> -               samsung,pin-drv = <6>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +               samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV4>;
>         };
>
>         sd1_int: sd1-int {
>                 samsung,pins = "gpr2-4";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <1>;
> -               samsung,pin-drv = <6>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +               samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV4>;
>         };
>
>         sd1_bus1: sd1-bus-width1 {
>                 samsung,pins = "gpr3-0";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <2>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV3>;
>         };
>
>         sd1_bus4: sd1-bus-width4 {
>                 samsung,pins = "gpr3-1", "gpr3-2", "gpr3-3";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <2>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV3>;
>         };
>
>         sd1_bus8: sd1-bus-width8 {
>                 samsung,pins = "gpr3-4", "gpr3-5", "gpr3-6", "gpr3-7";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <2>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV3>;
>         };
>  };
>
> @@ -682,22 +684,22 @@
>
>         spi5_bus: spi5-bus {
>                 samsung,pins = "gpf2-0", "gpf2-1", "gpf2-2", "gpf2-3";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
>         ufs_refclk_out: ufs-refclk-out {
>                 samsung,pins = "gpg2-4";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <0>;
> -               samsung,pin-drv = <2>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV2>;
>         };
>
>         ufs_rst_n: ufs-rst-n {
>                 samsung,pins = "gph1-5";
> -               samsung,pin-function = <2>;
> -               samsung,pin-pud = <3>;
> -               samsung,pin-drv = <0>;
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>  };
> --
> 2.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Regards,
Alim
