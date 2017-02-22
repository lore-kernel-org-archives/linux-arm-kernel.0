From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 Feb 2017 16:49:49 +0100
Subject: [PATCH] pinctrl: qcom: add get_direction function
In-Reply-To: <8652c018-4051-5c77-3126-2d41d150518a@codeaurora.org>
References: <1486768860-18237-1-git-send-email-timur@codeaurora.org>
 <8652c018-4051-5c77-3126-2d41d150518a@codeaurora.org>
Message-ID: <CACRpkdaoHTZa+XjEBAMtO2dS1jevi5h-QYe90SrZDuJghQSyYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 11, 2017 at 12:25 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 02/10/2017 03:21 PM, Timur Tabi wrote:

>> +     return val & BIT(g->oe_bit) ? 0 : 1;
>
> Maybe we can use the macros GPIOF_DIR_IN and GPIOF_DIR_OUT here instead?

Actually no. The GPIOF* #defines are for the consumer side of GPIO,
not the driver side. We actually just use 0/1 in drivers.

So I merged this v1 version.

Yours,
Linus Walleij
