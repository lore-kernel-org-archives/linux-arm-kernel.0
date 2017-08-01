From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 1 Aug 2017 13:54:37 +0200
Subject: [PATCH V4 RESEND 4/6] pinctrl: imx: remove gpio_request_enable
 and gpio_disable_free
In-Reply-To: <1500990116-3620-5-git-send-email-aisheng.dong@nxp.com>
References: <1500990116-3620-1-git-send-email-aisheng.dong@nxp.com>
 <1500990116-3620-5-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CACRpkdafhTMsYiY6yxcnXG0T3LeG5jw8_tp64G1a808G_63A9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 3:41 PM, Dong Aisheng <aisheng.dong@nxp.com> wrote:

> gpio_request_enable/disable_free actually are not quite necessary as
> standard IMX pinctrl binding already sets GPIO mux from device tree,
> e.g. VF610_PAD_PTB20__GPIO_42 or MX7D_PAD_SD2_CD_B__GPIO5_IO9
> No need to do it again in gpio_request_enable.
>
> And according to Stefan:
> "For all GPIO I checked in upstream device trees we assign a pinctrl
> to the same node, so in all cases gpio_request_enable/disable is really
> unnecessary."
>
> So it should be safe to simply remove it.
>
> Note that this changes semantics for Vybrid, e.g.
> "The two functions have been introduced for Vybrid (through
> SHARE_MUX_CONF_REG) and mux pins as GPIOs automatically when a GPIO
> gets requested. The automatic mux is optional by the pinmux/gpio
> subsystem semantics, and other NXP devices do not use it, instead an
> explicit pinctrl node is added in the device tree to mux GPIOs where
> required. Hence this change aligns Vybrid to other NXP (i.MX) devices.
>
> Note that all upstream device tree assign proper pinctrl properties
> where GPIOs are used so no change is necessary for device trees."
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fugang Duan <fugang.duan@nxp.com>
> Cc: Bai Ping <ping.bai@nxp.com>
> Acked-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Patch applied.

Yours,
Linus Walleij
