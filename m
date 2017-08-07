From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 7 Aug 2017 20:04:41 +0300
Subject: [PATCH v2 0/2] OMAP3+/4+ PRM: fix of_irq_get() result checks
In-Reply-To: <CAHp75VfdGkac6PUMSJLydR9GcZ8UAmqRR6zq2xNhYL8mMe3iUg@mail.gmail.com>
References: <20170806151420.104225294@cogentembedded.com>
 <CAHp75VfdGkac6PUMSJLydR9GcZ8UAmqRR6zq2xNhYL8mMe3iUg@mail.gmail.com>
Message-ID: <8deff01d-2e0c-d511-0557-7712c0358dcc@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2017 09:57 PM, Andy Shevchenko wrote:

>> Here's the set of 2 patches against the 'omap-for-v4.13/fixes' branch of Tony
>> Lingren's 'linux-omap.git' repo.  I'm  fixing of_irq_get() DT API result
>> checks.
>>
>> [1/2] ARM: OMAP3+: PRM: fix of_irq_get() result check
>> [2/2] ARM: OMAP4+: PRM: fix of_irq_get() result checks
> 
> What IRQ domain did you consider? In case of STRICT the mapping will
> be 1:1 and 0 is _valid_ IRQ number for hwirq.

    of_irq_get() returns virtual IRQ #'s, no? And for those 0 is considered 
non-valid by Linus (I personally don't agree with that).

> 0 in Linux kernel IRQ numbering often means NO_IRQ.

    NO_IRQ was "considered harmful" AFAIK. :-)

> But there might be exceptions.

> So, it would be nice to see if there is a problem on certain platform
> if the patch is not applied, or is it problem on OF IRQ code, or
> wrong interpratation of 0?

    of_irq_get() is certainly problematic with its returning both 0 and 
negative error # on failure. I tried to fix that back in 2016 but that patch 
got shot down:

http://marc.info/?t=146447243300002&r=1

    I've now audited all the call sites of of_irq_get() and that resulted in a 
number of fixes.

MBR, Sergei
