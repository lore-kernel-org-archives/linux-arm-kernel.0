From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Dec 2012 09:24:06 +0100
Subject: [RFC] gpiolib: introduce descriptor-based GPIO interface
In-Reply-To: <1985305.LiOKDTFPq4@percival>
References: <1354779918-4028-1-git-send-email-acourbot@nvidia.com>
 <1354779918-4028-2-git-send-email-acourbot@nvidia.com>
 <20121206144259.136693E0950@localhost>
 <1985305.LiOKDTFPq4@percival>
Message-ID: <CACRpkdYvsSqMrwY9UPLkDLat=tCn4+4t0nB37RmsM0-EGW-bJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 7, 2012 at 3:06 AM, Alex Courbot <acourbot@nvidia.com> wrote:
> On Thursday 06 December 2012 22:42:59 Grant Likely wrote:
>> how about "gpio_chip_hwnum()" to somewhat match irqdomain convention?
>
> Sure, matching existing interfaces is better. "git grep hwnum" does not seem
> to reveal much related to irqdomain though?

I think Grant is referring to the similarity with hwirq. Check:
include/linux/irqdomain.h

For example GPIO drivers using irqdomain often look up the
trigging local GPIO pin offset from the irqdomain descriptor
passed with the interrupt like this:

static void foo_gpio_irq_unmask(struct irq_data *d)
    int offset = d->hwirq;
    (...)

Maybe "hwgpio" is an even better choice for the name of this.

Yours,
Linus Walleij
