From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Feb 2018 14:52:45 +0100
Subject: [PATCH 5/6] ARM: dts: stm32: add joystick support on
 stm32746g-eval
In-Reply-To: <1518100057-23234-6-git-send-email-amelie.delaunay@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
 <1518100057-23234-6-git-send-email-amelie.delaunay@st.com>
Message-ID: <CACRpkdbaFpLNdxZThVTO5V4y8wzekVpXoFJ_6EOOsKCD_h59cA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Amelie,

thanks for your patch.

On Thu, Feb 8, 2018 at 3:27 PM, Amelie Delaunay <amelie.delaunay@st.com> wrote:

> The joystick on stm32746g-eval uses gpios on MFX gpio expander.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
(...)
> +       joystick {
> +               compatible = "gpio-keys";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               button at 1 {
> +                       label = "JoySel";
> +                       linux,code = <KEY_ENTER>;
> +                       gpios = <&mfxgpio 0 (GPIO_ACTIVE_LOW | GPIO_IN_PUSH_PULL | GPIO_PULL_UP)>;
> +               };

As I think this should not all be handled by GPIO, the joystick on
gpio-keys needs a pin control handle pointing back to pin control
states on the respective pins in the pin control/GPIO driver,
where it can set up these properties.

For the individual lines the pushing and pulling flags should be
removed.

Yours,
Linus Walleij
