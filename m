From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Feb 2018 14:34:19 +0100
Subject: [PATCH v2 2/3] gpiolib-of: Support 'reserved-gpio-ranges' property
In-Reply-To: <20180126011400.2191-3-sboyd@codeaurora.org>
References: <20180126011400.2191-1-sboyd@codeaurora.org>
 <20180126011400.2191-3-sboyd@codeaurora.org>
Message-ID: <CACRpkda2_nt24pweyQTtB_9gypDJTK1NHRm1LjsinEaK-G8F_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

nice work!

On Fri, Jan 26, 2018 at 2:13 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> For now, we plumb this into the gpiochip irq APIs so that
> GPIO/pinctrl drivers can use the gpiochip_irqchip_irq_valid() to
> test validity of GPIOs.

But is that the right thing to do, given that we just took the
trouble to define a DT binding that is explicitly about
any GPIO, not just IRQ capable ones?

I am worries that the *irq* infix etc on these functions
will be a bit confusing.

Is it a lot of work to make it just generic and maybe bake it
into the gpio_chip so as to refuse already in
gpiod_request_commit() in gpiolib already?

Yours,
Linus Walleij
