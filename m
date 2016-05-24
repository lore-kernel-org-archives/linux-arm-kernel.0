From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 24 May 2016 11:35:20 +0200
Subject: [PATCH v2 1/2] pinctrl: Add Oxford Semiconductor OXNAS pinctrl
 and gpio driver
In-Reply-To: <1462952062-5316-2-git-send-email-narmstrong@baylibre.com>
References: <1462952062-5316-1-git-send-email-narmstrong@baylibre.com>
 <1462952062-5316-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <CACRpkdZPMqRNn9rmcC4HYVKrdS7cxBD7O7oE4YPrP7L-0_Wakg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 9:34 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:

> Add pinctrl and gpio control support to Oxford Semiconductor OXNAS SoC Family.
> This version supports the ARM926EJ-S based OX810SE SoC with 34 IO pins.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

I tried implementing a .get_direction() callback for the Oxnas GPIO
(this is good to have, for debugfs and for the new userspace ABI).

However:

> +/* GPIO Registers */
> +#define INPUT_VALUE    0x00
> +#define IRQ_PENDING    0x0c
> +#define OUTPUT_SET     0x14
> +#define OUTPUT_CLEAR   0x18
> +#define OUTPUT_EN_SET  0x1c
> +#define OUTPUT_EN_CLEAR        0x20
> +#define RE_IRQ_ENABLE  0x28
> +#define FE_IRQ_ENABLE  0x2c

No pure OUTPUT_EN register to read the direction from?
Or is it one of the undocumented ones?

Could you take a stab at implementing .get_direction() and
send a patch?

Yours,
Linus Walleij
