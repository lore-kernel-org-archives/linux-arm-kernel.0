From: k.kozlowski.k@gmail.com (=?UTF-8?Q?Krzysztof_Koz=C5=82owski?=)
Date: Tue, 30 Jun 2015 09:30:45 +0900
Subject: [PATCH-V5 4/4] mfd: devicetree: bindings: Add new 88pm800 mfd
 binding
In-Reply-To: <1435591877-18214-5-git-send-email-vaibhav.hiremath@linaro.org>
References: <1435591877-18214-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1435591877-18214-5-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <CAJKOXPfijVCgudEZXX+53zAaHiXsbL-eM4RHmP35cwgvxHr_XA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-06-30 0:31 GMT+09:00 Vaibhav Hiremath <vaibhav.hiremath@linaro.org>:
> With addition of DT support to 88pm800 mfd driver, this patch
> adds new DT binding documentation along with respective properties.
>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>

Looks okay,

> ---
>  Documentation/devicetree/bindings/mfd/88pm800.txt | 53 +++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/88pm800.txt
>
> diff --git a/Documentation/devicetree/bindings/mfd/88pm800.txt b/Documentation/devicetree/bindings/mfd/88pm800.txt
> new file mode 100644
> index 0000000..dec842f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/88pm800.txt
> @@ -0,0 +1,53 @@
> +* Marvell 88PM80x Power Management IC
> +
> +Required parent device properties:
> +- compatible           : "marvell,88pm800", "marvell,88pm805", "marvell,88pm860"
> +- reg                  : the I2C slave address for the 88pm80x family chip
> +- interrupts           : IRQ line for the 88pm80x family chip
> +- interrupt-controller : describes the 88pm80x family chip as an interrupt
> +                         controller
> +- #interrupt-cells     : should be 1.
> +                         The cell is the 88pm80x local IRQ number
> +
> +88pm80x family of devices consists of varied group of sub-devices:
> +
> +Device                 Supply Names     Description
> +------                 ------------     -----------
> +88pm80x-onkey          :               : On key
> +88pm80x-rtc            :               : RTC
> +88pm80x-regulator      :               : Regulators
> +
> +Example:
> +
> +       pmic: 88pm800 at 30 {
> +               compatible = "marvell,88pm800";
> +               reg = <0x30>;
> +               interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
> +               interrupt-parent = <&gic>;
> +               interrupt-controller;
> +               #interrupt-cells = <1>;
> +
> +               regulators {
> +                       compatible = "marvell,88pm80x-regulator";
> +
> +                       buck1a: BUCK1A {
> +                               regulator-name = "BUCK1A";
> +                               regulator-min-microvolt = <600000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                       };
> +
> +                       ldo1: LDO1 {
> +                               regulator-name = "LDO1";
> +                               regulator-min-microvolt = <1700000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                       };
> +               };
> +
> +               rtc {
> +                       compatible = "marvell,88pm80x-rtc";
> +               };
> +       };
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
