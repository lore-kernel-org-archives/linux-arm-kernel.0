From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 16 Oct 2015 15:51:17 +0800
Subject: [linux-sunxi] [PATCH] dts: sun6i: yones toptech bs1078 v2: Add
 AXP221 support to dts
In-Reply-To: <1444367188-15234-1-git-send-email-lyu@micile.com>
References: <1444367188-15234-1-git-send-email-lyu@micile.com>
Message-ID: <CAGb2v67RXS+B8MbGU9RNywhKwsVPwMqqOAj8j91ESot3G_oZTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 9, 2015 at 1:06 PM, Lawrence Yu <lyu@micile.com> wrote:
> From: lyu <lyu@micile.com>
>
> Enable the axp221 PMIC chip in the dts file.
> Allows board to power off correctly from the poweroff command
>
> Tested on Contixo Q102 Tablet which uses the yones toptech bs1078 v2 pcb.
> ---
>  .../dts/sun6i-a31s-yones-toptech-bs1078-v2.dts     | 86 ++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts b/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
> index b199020..57bc315 100644
> --- a/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
> +++ b/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
> @@ -113,6 +113,92 @@
>         allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
>  };
>
> +&p2wi {
> +       status = "okay";
> +
> +       axp221: pmic at 68 {
> +               compatible = "x-powers,axp221";
> +               reg = <0x68>;
> +               interrupt-parent = <&nmi_intc>;
> +               interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +               interrupt-controller;
> +               #interrupt-cells = <1>;
> +               dcdc1-supply = <&vcc_3v0>;
> +               dcdc5-supply = <&vcc_dram>;
> +
> +               regulators {

We now have axp22x.dtsi in sunxi-next. Can you incorporate that instead?

See sun6i-a31-hummingbird.dts for an example.

Thanks!

ChenYu
