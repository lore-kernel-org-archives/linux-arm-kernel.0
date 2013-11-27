From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Nov 2013 08:41:17 +0100
Subject: STOP THE MADNESS
In-Reply-To: <CAL_JsqK-=btaXtFeg6BNpOqYKUHDBxzTHU5x+AOSe4hvyM4CRg@mail.gmail.com>
References: <20131126163031.GC16735@n2100.arm.linux.org.uk>
 <CAL_Jsq+AYEN2GQxgkN5a+eJsC-80n9y6Y9JngpZN7FzbLGdENw@mail.gmail.com>
 <CACRpkdY9MTUDtDxRKRHCXch98cNiMS-dumQvaTH7gp1OCVUx6w@mail.gmail.com>
 <CAL_JsqK-=btaXtFeg6BNpOqYKUHDBxzTHU5x+AOSe4hvyM4CRg@mail.gmail.com>
Message-ID: <CACRpkdb=iRGOEtwJhYygfXYuTZ-5hNUdAgL7dXaDBsfkUaPeeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 4:54 AM, Rob Herring <robherring2@gmail.com> wrote:
> On Tue, Nov 26, 2013 at 4:09 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> A pointer to an "ideal" GPIO chip + irq_chip driver would be highly
>> appreciated ...
>
> I'm not sure if one exists. Shouldn't be too hard to find if anything
> uses generic chip and irq domains together. I had done some work to
> address generic chip issues with irq domains and pl061 support[1], but
> Grant was never really happy with it and I never got back to looking
> at it. I think the conclusion was we don't want to add irqdomains into
> generic chip as my series did, but we need to at least make them
> coexist.

Hm I also had the idea of embedding a struct irq_chip into the
struct gpio_chip (w/some config symbol like
GPIOLIB_PROVIDE_IRQCHIP) and use that for all GPIO drivers
doing IRQchips. Embedding a generic chip could be the way
forward.

Yours,
Linus Walleij
