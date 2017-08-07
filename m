From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 7 Aug 2017 20:26:21 +0300
Subject: [PATCH v2 0/2] OMAP3+/4+ PRM: fix of_irq_get() result checks
In-Reply-To: <CAHp75Vfg9k5e=9O=Be=irKE88U-zKLM3WdQit6BZVBKZR2SVCA@mail.gmail.com>
References: <20170806151420.104225294@cogentembedded.com>
 <CAHp75VfdGkac6PUMSJLydR9GcZ8UAmqRR6zq2xNhYL8mMe3iUg@mail.gmail.com>
 <CAHp75Vfg9k5e=9O=Be=irKE88U-zKLM3WdQit6BZVBKZR2SVCA@mail.gmail.com>
Message-ID: <4a63fd34-2822-e887-e485-c24568981448@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2017 10:38 PM, Andy Shevchenko wrote:

>>> Hello!
>>>
>>> Here's the set of 2 patches against the 'omap-for-v4.13/fixes' branch of Tony
>>> Lingren's 'linux-omap.git' repo.  I'm  fixing of_irq_get() DT API result
>>> checks.
>>>
>>> [1/2] ARM: OMAP3+: PRM: fix of_irq_get() result check
>>> [2/2] ARM: OMAP4+: PRM: fix of_irq_get() result checks
>>
>> What IRQ domain did you consider? In case of STRICT the mapping will
>> be 1:1 and 0 is _valid_ IRQ number for hwirq.
>> 0 in Linux kernel IRQ numbering often means NO_IRQ. But there might be
>> exceptions.
>>
>> So, it would be nice to see if there is a problem on certain platform
>> if the patch is not applied, or is it problem on OF IRQ code, or
>> wrong interpratation of 0?
> 
> Okay, I have looked into OF code and it seems always allocating

    Heh, I was going to send you down the of_irq_get()'s call chains -- it 
became obvious to me that 0 is a "bad IRQ" indication from looking at 
irq_create_fwspec_mapping()...

> descriptors where numbering starts from 1 (see hint variable deep in
> the code).

    In kernel/irq/irqdomain.c::irq_domain_alloc_descs(), you mean?
I haven't plunged so deep. :-) But it's hardly an OF code, IIRC...

> This series is a good fix.

    Thank you (especially for spending your Sunday time)! :-)

MBR, Sergei
