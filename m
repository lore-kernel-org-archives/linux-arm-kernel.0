From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 6 Dec 2013 14:56:59 +0100
Subject: [PATCH v2 0/3] pinctrl: Qualcomm 8x74 pinctrl driver
In-Reply-To: <1386295805-13708-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1386295805-13708-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <CACRpkdaYPSJbL80tbFaNP9aTFc+_AKsT=rd-yxc0R6K-M_Tz9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 6, 2013 at 3:10 AM, Bjorn Andersson
<bjorn.andersson@sonymobile.com> wrote:

> This series adds a pinctrl, pinmux, pinconf and gpiolib driver for the
> Qualcomm TLMM block found in recent Qualcomm SoCs (8x60 and newer).
> It designed with both v2 and v3 of the block in mind and comes with initial
> definitions for the 8x74 SoCs.
> This should be filled in with more data and definitions for more SoCs.
>
> Regards,
> Bjorn
>
> v2
> --
> * Replaced subnode dt parsing with generic pinctrl function
> * Installing irq_handler as chained irq handler
> * Added call to handle_bad_irq() when no irqs are pending in irq handler
> * Creating irq mapping at probe() and cleaned up the code accordingly
> * Replaced pinctrl_add_gpio_range with gpiochip_add_pin_range
> * Other minor updates based on review comments

I can't see any problem with these patches, and they only use standard
bindings, so I've applied all three so we get some linux-next rotation
and build coverage. Any remaining problems can certainly be fixed
with incremental patches.

Thanks!
Linus Walleij
