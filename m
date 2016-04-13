From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 12 Apr 2016 19:11:27 -0500
Subject: [PATCH v4 14/16] arm64: dts: hikey: Add hi655x pmic dts node
In-Reply-To: <1460505352-13157-15-git-send-email-guodong.xu@linaro.org>
References: <1460505352-13157-1-git-send-email-guodong.xu@linaro.org>
 <1460505352-13157-15-git-send-email-guodong.xu@linaro.org>
Message-ID: <CAL_Jsq+4kHUBvSLheV-hfmPFic_D+3Xz7oXOKnUSqnWOt71Peg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2016 at 6:55 PM, Guodong Xu <guodong.xu@linaro.org> wrote:
> From: Chen Feng <puck.chen@hisilicon.com>
>
> Add the mfd hi655x dts node and regulator support on hi6220 platform.
>
> Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
> Signed-off-by: Fei Wang <w.f@huawei.com>
> Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> Reviewed-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

I did not provide a Reviewed-by. You cannot add people's Reviewed-by
just because they provided a review. It is only when the review is
finished that the reviewer will give it.

That being said, it looks fine now and you can add it.

> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 87 +++++++++++++++++++++++++-
>  1 file changed, 86 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> index b7c41f8..cc1148d 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> @@ -6,9 +6,9 @@
>   */
>
>  /dts-v1/;
> -
>  #include "hi6220.dtsi"
>  #include "hikey-pinctrl.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
>
>  / {
>         model = "HiKey Development Board";
> @@ -107,6 +107,91 @@
>                         default-state = "off";
>                 };
>         };
> +
> +       pmic: pmic at f8000000 {
> +               compatible = "hisilicon,hi655x-pmic";
> +               reg = <0x0 0xf8000000 0x0 0x1000>;
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +               pmic-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
> +
> +               regulators {
> +                       ldo2: LDO2 {
> +                               regulator-name = "LDO2_2V8";
> +                               regulator-min-microvolt = <2500000>;
> +                               regulator-max-microvolt = <3200000>;
> +                               regulator-enable-ramp-delay = <120>;
> +                       };
> +
> +                       ldo7: LDO7 {
> +                               regulator-name = "LDO7_SDIO";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-enable-ramp-delay = <120>;
> +                       };
> +
> +                       ldo10: LDO10 {
> +                               regulator-name = "LDO10_2V85";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <3000000>;
> +                               regulator-enable-ramp-delay = <360>;
> +                       };
> +
> +                       ldo13: LDO13 {
> +                               regulator-name = "LDO13_1V8";
> +                               regulator-min-microvolt = <1600000>;
> +                               regulator-max-microvolt = <1950000>;
> +                               regulator-enable-ramp-delay = <120>;
> +                       };
> +
> +                       ldo14: LDO14 {
> +                               regulator-name = "LDO14_2V8";
> +                               regulator-min-microvolt = <2500000>;
> +                               regulator-max-microvolt = <3200000>;
> +                               regulator-enable-ramp-delay = <120>;
> +                       };
> +
> +                       ldo15: LDO15 {
> +                               regulator-name = "LDO15_1V8";
> +                               regulator-min-microvolt = <1600000>;
> +                               regulator-max-microvolt = <1950000>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                               regulator-enable-ramp-delay = <120>;
> +                       };
> +
> +                       ldo17: LDO17 {
> +                               regulator-name = "LDO17_2V5";
> +                               regulator-min-microvolt = <2500000>;
> +                               regulator-max-microvolt = <3200000>;
> +                               regulator-enable-ramp-delay = <120>;
> +                       };
> +
> +                       ldo19: LDO19 {
> +                               regulator-name = "LDO19_3V0";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <3000000>;
> +                               regulator-enable-ramp-delay = <360>;
> +                       };
> +
> +                       ldo21: LDO21 {
> +                               regulator-name = "LDO21_1V8";
> +                               regulator-min-microvolt = <1650000>;
> +                               regulator-max-microvolt = <2000000>;
> +                               regulator-always-on;
> +                               regulator-enable-ramp-delay = <120>;
> +                       };
> +
> +                       ldo22: LDO22 {
> +                               regulator-name = "LDO22_1V2";
> +                               regulator-min-microvolt = <900000>;
> +                               regulator-max-microvolt = <1200000>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                               regulator-enable-ramp-delay = <120>;
> +                       };
> +               };
> +       };
>  };
>
>  &uart2 {
> --
> 1.9.1
>
