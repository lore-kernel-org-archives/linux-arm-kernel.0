From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 28 Mar 2014 11:12:37 +0800
Subject: [PATCH v3 08/10] ARM: sun7i/sun4i: dt: Add AXP209 support to
 various boards
In-Reply-To: <1395955764-18103-9-git-send-email-carlo@caione.org>
References: <1395955764-18103-1-git-send-email-carlo@caione.org>
 <1395955764-18103-9-git-send-email-carlo@caione.org>
Message-ID: <CAGb2v67a6kVMe9vxBYrQQtucVqpyvUby1Hyt3RBina8sKj9HOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 5:29 AM, Carlo Caione <carlo@caione.org> wrote:
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
>  arch/arm/boot/dts/sun4i-a10-a1000.dts           | 13 +++++++++++++
>  arch/arm/boot/dts/sun4i-a10-cubieboard.dts      | 13 +++++++++++++
>  arch/arm/boot/dts/sun4i-a10-hackberry.dts       | 19 +++++++++++++++++++
>  arch/arm/boot/dts/sun4i-a10-inet97fv2.dts       | 13 +++++++++++++
>  arch/arm/boot/dts/sun4i-a10-mini-xplus.dts      | 19 +++++++++++++++++++
>  arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts  | 19 +++++++++++++++++++
>  arch/arm/boot/dts/sun4i-a10-pcduino.dts         | 13 +++++++++++++
>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 14 ++++++++++++++
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 15 +++++++++++++++
>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 14 ++++++++++++++
>  10 files changed, 152 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> index fa746aea..cf18c4d 100644
> --- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> @@ -88,6 +88,19 @@
>                         pinctrl-names = "default";
>                         pinctrl-0 = <&i2c0_pins_a>;
>                         status = "okay";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       axp: axp20x at 34 {

Hi,

Sorry for spotting this just now. I suggest you change it to

                          axp209: pmic at 34 {

or

                          axp209_pmic at 34 {

to match the ePAPR policy that node names should be generic and
describe functionality. The latter is what some DTs use.

> +                               reg = <0x34>;
> +                               interrupts = <0>;
> +
> +                               compatible = "x-powers,axp209";
> +                               interrupt-controller;
> +                               #interrupt-cells = <1>;
> +
> +                               /include/ "x-powers-axp209.dtsi"
> +                       };
>                 };
>         };
>

[...]

Same for all the other files.

Thanks for working on this!


ChenYu
