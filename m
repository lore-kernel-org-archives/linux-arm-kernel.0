From: jkridner@beagleboard.org (Jason Kridner)
Date: Fri, 27 Sep 2013 23:13:50 -0400
Subject: [PATCH v4 1/4] ARM: dts: am335x-bone: add CD for mmc1
In-Reply-To: <1379010935-25943-2-git-send-email-koen@dominion.thruhere.net>
References: <1379010935-25943-1-git-send-email-koen@dominion.thruhere.net>
 <1379010935-25943-2-git-send-email-koen@dominion.thruhere.net>
Message-ID: <CA+T6QPk=Z+u2eo63-2T4dZcyaZ=yL=+rBck5r5y14MiQK_w00w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 2:35 PM, Koen Kooi <koen@dominion.thruhere.net> wrote:
> From: Alexander Holler <holler@ahsoftware.de>
>
> This enables the use of MMC cards even when no card was inserted at boot.
>
> Signed-off-by: Alexander Holler <holler@ahsoftware.de>
> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>

Acked-by: Jason Kridner <jdk@ti.com>

> ---
>  arch/arm/boot/dts/am335x-bone-common.dtsi | 14 ++++++++++++++
>  arch/arm/boot/dts/am335x-bone.dts         |  1 -
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
> index 2f66ded..0d95d54 100644
> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> @@ -107,6 +107,12 @@
>                                 0x14c (PIN_INPUT_PULLDOWN | MUX_MODE7)
>                         >;
>                 };
> +
> +               mmc1_pins: pinmux_mmc1_pins {
> +                       pinctrl-single,pins = <
> +                               0x160 (PIN_INPUT | MUX_MODE7) /* GPIO0_6 */
> +                       >;
> +               };
>         };
>
>         ocp {
> @@ -260,3 +266,11 @@
>         pinctrl-0 = <&davinci_mdio_default>;
>         pinctrl-1 = <&davinci_mdio_sleep>;
>  };
> +
> +&mmc1 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mmc1_pins>;
> +       cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
> +       cd-inverted;
> +};
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> index d5f43fe..0d63348 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -17,6 +17,5 @@
>  };
>
>  &mmc1 {
> -       status = "okay";
>         vmmc-supply = <&ldo3_reg>;
>  };
> --
> 1.8.2.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
