From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 7 Feb 2013 11:01:29 +0100
Subject: [PATCH 02/14] mfd: ab8500: provide a irq_set_type() function
In-Reply-To: <CAF2Aj3iO+6j+T5C0X2Hh6TsvT4yaJ2cai6cC9DaiRAwL9n-dVw@mail.gmail.com>
References: <1360093715-6348-1-git-send-email-linus.walleij@stericsson.com>
 <1360093715-6348-3-git-send-email-linus.walleij@stericsson.com>
 <5112F043.6040700@wwwdotorg.org>
 <CAF2Aj3iO+6j+T5C0X2Hh6TsvT4yaJ2cai6cC9DaiRAwL9n-dVw@mail.gmail.com>
Message-ID: <CACRpkdb1W8HWV+ZTcA5EyjT8pEnnLUaB4rsiyCLpJiff-0=5-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 7, 2013 at 10:08 AM, Lee Jones <lee.jones@linaro.org> wrote:

> Great spot/idea. But then this won't work at all until I can write a fixup.
>
> Will you allow me to write a follow-up patch please?

For me a sequel is OK, especially given that this thing doesn't make
things any worse than they are already, but actually checking supported
types will not be trivial, because...

>> > +static int ab8500_irq_set_type(struct irq_data *data, unsigned int
>> > type)
>> > +{
>> > +     return 0;
>> > +}

This applies to *ALL* AB8500 IRQs, and some of them actually support
rising/falling, apart from the GPIO ones, so it's not enough to just handle
the GPIO IRQs here.

Yours,
Linus Walleij
