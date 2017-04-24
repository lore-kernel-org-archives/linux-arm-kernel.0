From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Apr 2017 14:37:52 +0200
Subject: [PATCH 3/4] pinctrl: stm32: Implement .get_direction gpio_chip
 callback
In-Reply-To: <1491577811-26989-4-git-send-email-alexandre.torgue@st.com>
References: <1491577811-26989-1-git-send-email-alexandre.torgue@st.com>
 <1491577811-26989-4-git-send-email-alexandre.torgue@st.com>
Message-ID: <CACRpkdZG-yxMCzBqP2s37QThP7tgWKgd3pVgZGgceB+ihZs3nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 7, 2017 at 5:10 PM, Alexandre TORGUE
<alexandre.torgue@st.com> wrote:

> Add .get_direction() gpiochip callback in STM32 pinctrl driver.
>
> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

(...)
> +#include <linux/gpio.h>

No this is wrong, drivers should never include this file.
It is a deprecated consumer header.

> +       if ((alt == 0) && (mode == 0))
> +               ret = GPIOF_DIR_IN;
> +       else if ((alt == 0) && (mode == 1))
> +               ret = GPIOF_DIR_OUT;

Just return 0 or 1, that is the driver-internal API.

Yours,
Linus Walleij
