From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Feb 2018 14:54:31 +0100
Subject: [PATCH 4/6] ARM: dts: stm32: add MFX support on I2C1 on
 stm32746g-eval
In-Reply-To: <1518100057-23234-5-git-send-email-amelie.delaunay@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
 <1518100057-23234-5-git-send-email-amelie.delaunay@st.com>
Message-ID: <CACRpkdZFrRXEBW6KnqZ=h_7BxYn-RaAzhP4ovwC_DQSbAGZCVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 8, 2018 at 3:27 PM, Amelie Delaunay <amelie.delaunay@st.com> wrote:

> MFX is used as gpio expander on stm32746g-eval.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

(...)
> +       mfx: mfx at 42 {
> +               compatible = "st,mfx";
> +               reg = <0x42>;
> +               interrupts = <8 1>;
> +               interrupt-parent = <&gpioi>;
> +               interrupt-controller;
> +               #interrupt-cells = <1>;
> +
> +               mfxgpio: mfx_gpio {
> +                       compatible = "st,mfx-gpio";
> +                       interrupts = <0>;
> +                       interrupt-parent = <&mfx>;
> +                       gpio-controller;
> +                       #gpio-cells = <2>;

So I think this node should contain some pin config states
that can  be referenced by the drivers to set up push/pull
etc. Probably it can use just standard pin config properties
like sx150x.

Yours,
Linus Walleij
