From: matt@genesi-usa.com (Matt Sealey)
Date: Thu, 23 Aug 2012 13:04:04 -0500
Subject: [PATCH 1/2] imx6q: Configure the pwm node for pinmux support
In-Reply-To: <1345735959-12964-2-git-send-email-hachimi.samir@gmail.com>
References: <1345735959-12964-2-git-send-email-hachimi.samir@gmail.com>
Message-ID: <CAKGA1bk86r_0rZQ20S1Zii7UGuhGFSq5GLzcBpPJfyvoEAPfaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2012 at 10:32 AM,  <hachimi.samir@gmail.com> wrote:
> From: Samir Hachimi <hachimi.samir@gmail.com>
>
>  Add the pinmux support for pwm.
>  Several pin can be set to PwmO for the same Pwm. This configuration set all
>  of them when enabled.
>
> Signed-off-by: Samir Hachimi <shachimi@adeneo-embedded.com>
> ---
>  arch/arm/boot/dts/imx6q.dtsi |   42 ++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 42 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index fd57079..c913b99 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -248,23 +248,35 @@
>                         };
>
>                         pwm at 02080000 { /* PWM1 */
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&pinctrl_pwm1_1>;
>                                 reg = <0x02080000 0x4000>;
>                                 interrupts = <0 83 0x04>;
> +                               status = "disabled";
>                         };
>
>                         pwm at 02084000 { /* PWM2 */
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&pinctrl_pwm2_1>;
>                                 reg = <0x02084000 0x4000>;
>                                 interrupts = <0 84 0x04>;
> +                               status = "disabled";
>                         };
>
>                         pwm at 02088000 { /* PWM3 */
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&pinctrl_pwm3_1>;
>                                 reg = <0x02088000 0x4000>;
>                                 interrupts = <0 85 0x04>;
> +                               status = "disabled";
>                         };
>
>                         pwm at 0208c000 { /* PWM4 */
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&pinctrl_pwm4_1>;
>                                 reg = <0x0208c000 0x4000>;
>                                 interrupts = <0 86 0x04>;
> +                               status = "disabled";
>                         };
>
>                         flexcan at 02090000 { /* CAN1 */
> @@ -559,6 +571,36 @@
>                                         };
>                                 };
>
> +                               pwm1 {
> +                                       pinctrl_pwm1_1: pwm1grp-1 {
> +                                               fsl,pins = <1543 0x80000000     /* MX6Q_PAD_SD1_DAT3__PWM1_PWMO */
> +                                                           574 0x80000000      /* MX6Q_PAD_DISPO_DAT8__PWM1_PWMO */
> +                                                           971 0x80000000>;    /* MX6Q_PAD_GPIO_9__PWM1_PWMO */
> +                                       };
> +                               };
> +
> +                               pwm2 {
> +                                       pinctrl_pwm2_1: pwm2grp-1 {
> +                                               fsl,pins = <1557 0x80000000     /* MX6Q_PAD_SD1_DAT2__PWM2_PWMO */
> +                                                           582 0x80000000      /* MX6Q_PAD_DISP0_DAT9__PWM2_PWMO */
> +                                                           963 0x80000000>;    /* MX6Q_PAD_GPIO_1__PWM2_PWMO */
> +                                       };
> +                               };
> +
> +                               pwm3 {
> +                                       pinctrl_pwm3_1: pwm3grp-1 {
> +                                               fsl,pins = <1471 0x80000000     /* MX6Q_PAD_SD4_DAT1__PWM3_PWMO */
> +                                                           1526 0x80000000>;   /* MX6Q_PAD_SD1_DAT1__PWM3_PWMO */
> +                                       };
> +                               };
> +
> +                               pwm4 {
> +                                       pinctrl_pwm4_1: pwm4grp-1 {
> +                                               fsl,pins = <1479 0x80000000     /* MX6Q_PAD_SD4_DAT2__PWM4_PWMO */
> +                                                           1550 0x80000000>;   /* MX6Q_PAD_SD1_CMD__PWM4_PWMO */
> +                                       };
> +                               };
> +
>                                 usdhc3 {
>                                         pinctrl_usdhc3_1: usdhc3grp-1 {
>                                                 fsl,pins = <1273 0x17059        /* MX6Q_PAD_SD3_CMD__USDHC3_CMD */
> --
> 1.7.1

Surely you only specify the pinmux for the pad you want to use, not
every combination.

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
