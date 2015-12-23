From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 23 Dec 2015 13:03:17 -0300
Subject: [PATCH 5/6] ARM: LG Optimus Black (P970) codename sniper support,
 with basic features
In-Reply-To: <1450868319-20513-6-git-send-email-contact@paulk.fr>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-6-git-send-email-contact@paulk.fr>
Message-ID: <CABxcv=moAUEPo8sq5KhuLZChrQtwjF1aBeNvV1i8HvUnwDXMZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Paul,

[snip]

> +
> +&omap3_pmx_core {
> +       pinctrl-names = "default";
> +
> +       uart3_pins: pinmux_uart3_pins {
> +               pinctrl-single,pins = <
> +                       0x16e (PIN_INPUT | MUX_MODE0)           /* uart3_rx_irrx */
> +                       0x170 (PIN_OUTPUT | MUX_MODE0)          /* uart3_tx_irtx */
> +               >;

Could you please use the IOPAD mux macros from
include/dt-bindings/pinctrl/omap.h instead?

We just did a massive cleanup on the OMAP DTS to use them instead of
an offset from the padconf registers.

Best regards,
Javier
