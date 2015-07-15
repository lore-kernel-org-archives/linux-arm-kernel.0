From: dianders@chromium.org (Doug Anderson)
Date: Wed, 15 Jul 2015 14:28:29 -0700
Subject: [PATCH 3/4] ARM: dts: rockchip: add veyron-jerry board
In-Reply-To: <1436574562-16308-4-git-send-email-heiko@sntech.de>
References: <1436574562-16308-1-git-send-email-heiko@sntech.de>
 <1436574562-16308-4-git-send-email-heiko@sntech.de>
Message-ID: <CAD=FV=WwFgjzbk9xF5TU_ie6UnHQMyrZ176D4+jJTWWOoaKC2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Fri, Jul 10, 2015 at 5:29 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> +&rk808 {
> +       dvs-gpios = <&gpio7 12 GPIO_ACTIVE_HIGH>,
> +                   <&gpio7 15 GPIO_ACTIVE_HIGH>;

dvs-gpios never made it upstream.  ...which actually means that
upstream is probably ramping its CPU/GPU lines a bit too fast and
overshooting.  Eventually we should figure out how to fix that, but
for now we should remove dvs-gpios since it's not in the bindings.


> +&i2c4 {
> +       status = "okay";
> +
> +       /*
> +        * Trackpad pin control is shared between Elan and Synaptics devices
> +        * so we have to pull it up to the bus level.
> +        */
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&i2c4_xfer &trackpad_int>;
> +
> +       trackpad at 15 {
> +               /*
> +                * Remove the inherited pinctrl settings to avoid clashing
> +                * with bus-wide ones.
> +                */
> +               /delete-property/pinctrl-names;
> +               /delete-property/pinctrl-0;

Eventually this would be nice to solve, but doesn't seem like it
should block this patch.


After removing dvs-gpios, you can add my Reviewed-by tag.


-Doug
