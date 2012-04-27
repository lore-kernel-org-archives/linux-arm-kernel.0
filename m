From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Apr 2012 22:29:33 +0200
Subject: [PATCH 2/2] ARM: VIC: use the domain mapping function to assign
 handlers
In-Reply-To: <20120427190020.EDB813E0B4D@localhost>
References: <1334763054-19340-1-git-send-email-linus.walleij@stericsson.com>
 <20120427190020.EDB813E0B4D@localhost>
Message-ID: <CACRpkdYai+eFybnTM7Mh6o7pwt+vwebzHsudwaoCwtn-VPcxxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 9:00 PM, Grant Likely <grant.likely@secretlab.ca> wrote:

>> +static struct irq_domain_ops vic_irqdomain_ops = {
>> + ? ? .map = vic_irqdomain_map,
>> + ? ? .xlate = irq_domain_xlate_onetwocell,
>> +};
>
> It looks like this patch also needs to update the
> irq_domain_add_legacy() call to use this ops structure instead of
> irq_domain_simple_ops.

I goofed up when I split the patch, that change is in 1/2, which is thus
not bisectable :-/

But the end result is working and looking as it should.

Do you want me to re-split, or can we live with this?

Yours,
Linus Walleij
