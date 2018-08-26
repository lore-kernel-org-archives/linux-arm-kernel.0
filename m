From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Aug 2018 00:46:25 +0200
Subject: [PATCH 1/2] gpio: ftgpio: Support optional silicon clock
In-Reply-To: <20180826190445.GB7359@lunn.ch>
References: <20180826110321.17723-1-linus.walleij@linaro.org>
 <20180826190445.GB7359@lunn.ch>
Message-ID: <CACRpkdYeyNzZ2XM=Rj4igKF7t+TLk3veteRXeO4D4XYLaSN4FQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 26, 2018 at 9:04 PM Andrew Lunn <andrew@lunn.ch> wrote:

> > +     g->clk = devm_clk_get(dev, NULL);
> > +     if (!IS_ERR(g->clk)) {
> > +             ret = clk_prepare_enable(g->clk);
> > +             if (ret)
> > +                     return ret;
> > +     }
>
> Hi Linus
>
> Is there any chance devm_clk_get() could return -EPROBE_DIFFERED?

Not practically but I was convinced to move the bulk of clocks out of
CLK_OF_DECLARE_DRIVER so I guess theoretically it could happen.
So I guess I should re-spin with that as explict bailout condition.

Yours,
Linus Walleij
