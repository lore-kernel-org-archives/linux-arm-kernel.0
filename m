From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 30 Mar 2017 18:57:30 +0200
Subject: [PATCH v2 5/7] pinctrl: aramda-37xx: Add irqchip support
In-Reply-To: <CACRpkdYA9xq3TmW-=0+cxdeBcq6v3HAFf3f5E-FAvUpGZqns3g@mail.gmail.com>
 (Linus Walleij's message of "Wed, 29 Mar 2017 04:18:19 +0200")
References: <cover.26288667a039bc9f8e62dec2fd6342ded4014d12.1490120798.git-series.gregory.clement@free-electrons.com>
 <0e60fccd7913b83ee53d2921ce8f297927e8b6f3.1490120798.git-series.gregory.clement@free-electrons.com>
 <CACRpkdYv6WDWM60dRMaYfEt50M8N-yLYk2TRguNi78aQtt6X9A@mail.gmail.com>
 <87vaqtadry.fsf@free-electrons.com>
 <CACRpkdY0DzMGiRTWeS23iCY3Vja9dnXJVaMqOnhJRpBLowfYTA@mail.gmail.com>
 <87mvc5a3hh.fsf@free-electrons.com>
 <CACRpkdYA9xq3TmW-=0+cxdeBcq6v3HAFf3f5E-FAvUpGZqns3g@mail.gmail.com>
Message-ID: <874lya8zyd.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,
 
 On mer., mars 29 2017, Linus Walleij <linus.walleij@linaro.org> wrote:

>>> It has irq_create_mapping(gpiochip->irqdomain, offset); that get
>>> called for every IRQ, and that will eventually call irq_of_parse_and_map()
>>> if the IRQs are defined in the device tree. (IIRC)
>>
>> When I followed the functions called I never find a call to
>> irq_of_parse_and_map(), the closer things related to device tree I found
>> was:
>> "virq = irq_domain_alloc_descs(-1, 1, hwirq, of_node_to_nid(of_node),
>> NULL);"
>> http://elixir.free-electrons.com/source/kernel/irq/irqdomain.c?v=4.11-rc4#L507
>
> I don't know if I'm rambling or what. I'm pretty sure it gets called, maybe
> even earlier, like when the DT is parsed for the platform. We have so many
> drivers not seemingly needing this, but if your driver needs it, all others
> may need to be fixed too.
>
> Can you put a print in irq_of_parse_and_map() and see what happens?

So if I don't call it explicitly in my driver, then  this function is
never called for the gpio.

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
