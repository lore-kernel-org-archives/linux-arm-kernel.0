From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Aug 2015 11:26:49 +0200
Subject: [PATCH v2] gpio: Allow hogged gpios to be requested
In-Reply-To: <1438680424-698-1-git-send-email-mpa@pengutronix.de>
References: <1438680424-698-1-git-send-email-mpa@pengutronix.de>
Message-ID: <CACRpkdZAjWf3Echvz6Z2hTOF8Bqs=OqLKUTYc04r9vzFo727jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 4, 2015 at 11:27 AM, Markus Pargmann <mpa@pengutronix.de> wrote:

> It can be useful to claim hogged gpios later, for example from
> userspace. This allows to set defaults for GPIOs using the hogging
> mechanism and override the setup later from userspace or a kernel driver.
>
> This patch adds a check for hogged gpios to allow requesting them. If
> the gpio is not hogged but marked as requested, it still fails with
> -EBUSY.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

To me it feels like a new DT property "gpio-inital-value" or so
need to be defined in addition to the hogging bindings, and that
one just sets the GPIO up without setting the FLAG_IS_HOGGED.

The mechanism needs to be available to non-DT as well
of course, but it could be a first usecase.

So instead of:

line_b {
           gpio-initval;
           gpios = <6 0>;
           output-low;
};

Note: no line-name. And it shouldn't be allowed: we don't
know who will use this in the end.

Yours,
Linus Walleij
