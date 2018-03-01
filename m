From: sboyd@kernel.org (Stephen Boyd)
Date: Thu, 01 Mar 2018 13:49:56 -0800
Subject: [PATCH v2 2/3] gpiolib-of: Support 'reserved-gpio-ranges' property
In-Reply-To: <CACRpkda2_nt24pweyQTtB_9gypDJTK1NHRm1LjsinEaK-G8F_Q@mail.gmail.com>
References: <20180126011400.2191-1-sboyd@codeaurora.org>
 <20180126011400.2191-3-sboyd@codeaurora.org>
 <CACRpkda2_nt24pweyQTtB_9gypDJTK1NHRm1LjsinEaK-G8F_Q@mail.gmail.com>
Message-ID: <151994099669.240031.102662015980326125@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Linus Walleij (2018-02-07 05:34:19)
> Hi Stephen,
> 
> nice work!
> 
> On Fri, Jan 26, 2018 at 2:13 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> 
> > For now, we plumb this into the gpiochip irq APIs so that
> > GPIO/pinctrl drivers can use the gpiochip_irqchip_irq_valid() to
> > test validity of GPIOs.
> 
> But is that the right thing to do, given that we just took the
> trouble to define a DT binding that is explicitly about
> any GPIO, not just IRQ capable ones?
> 
> I am worries that the *irq* infix etc on these functions
> will be a bit confusing.
> 
> Is it a lot of work to make it just generic and maybe bake it
> into the gpio_chip so as to refuse already in
> gpiod_request_commit() in gpiolib already?

I don't think that it will be too much work to tweak the code to treat
these as gpios instead of irq lines. It may end up duplicating a bit of code
that the irq line stuff is already doing, but I'll take a stab at it and
see how bad it comes out.
