From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 28 Jul 2011 16:15:39 +0800
Subject: cpu_suspend does not flush the L2 cache
In-Reply-To: <20110725200820.GE14955@n2100.arm.linux.org.uk>
References: <74C67D49A66F0848B6F4548360B2EDB58DED35BC42@HQMAIL04.nvidia.com>
	<20110725200820.GE14955@n2100.arm.linux.org.uk>
Message-ID: <CAGsJ_4xSyiJOBf_sBw7eKZY3B+un-zO0tYUKtW5FDkWoBhgLjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/26 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Mon, Jul 25, 2011 at 11:49:43AM -0700, Scott Williams wrote:
>> In 2.6.39, CPU suspend/resumes crashes if an outer cache controller
>> (like a PL310) is configured and enabled. cpu_suspend only flushes
>> the L1 cache.
>
> Correct. ?cpu_suspend is been a _consolidation_ effort across the various
> implementations. ?Only one implementation deals with the L2 cache issues
> at present.
>
> A bunch of patches have gone in during this merge window to continue
> that consolidation effort and improve the cpu_suspend interfaces.
> Eventually the L2 cache issues will be dealt with in core code.
>
> So at the moment, platforms are expected to deal with this in their own
> suspend finisher code.

So one possible way is that platforms clean and flush L2 cache while
suspending, then disable L2.
After resuming from wake-up entry, platforms reinitilized L2 by some
hardware setting and l2x_init.

>
> FYI, I have no platforms at present with L2 cache and are capable of
> suspend. ?I'm still waiting on TI for some prototype code for OMAP4
> suspend support... until that time, I am unable to progress it further
> unless I try to address these issues blind.

On SiRFprimaII, we have tried the suspend/resume when L2 is on. i'd
like to give a platform example.
Finally, L2 cache suspend/resume can be in core code.
>

-barry
