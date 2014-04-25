From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Fri, 25 Apr 2014 13:37:01 -0700
Subject: [RFC PATCH v3] ARM: uprobes need icache flush after xol write
In-Reply-To: <535AC2B5.7070205@linaro.org>
References: <20140416152946.GA13564@redhat.com>
 <20140416.114740.1805744923904673839.davem@davemloft.net>
 <20140416202243.GI24070@n2100.arm.linux.org.uk>
 <20140416.171354.2030799647571837439.davem@davemloft.net>
 <535AC2B5.7070205@linaro.org>
Message-ID: <CAA3XUr3tRgBPTKx6cqNaBRMRVOeowBVp9Bb_TYmZFWhO7wR=ig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 April 2014 13:16, David Long <dave.long@linaro.org> wrote:
> On 04/16/14 17:13, David Miller wrote:
>>
>> From: Russell King - ARM Linux <linux@arm.linux.org.uk>
>> Date: Wed, 16 Apr 2014 21:22:43 +0100
>>
>>> I'm thinking that both flush_icache_alias() and flush_pfn_alias() want
>>> at least a preemption disabled around each so that we don't end up with
>>> two threads being preempted here.
>>
>>
>> Yes, you would need to disable preemption to keep another thread of
>> control from potentially using the same flush slot.
>>
>
> Sorry for the delay in replying.
>
> I guess the above potential problem is largely independent of the uprobes
> caching issue.
>
> I spent a while reading up on ARM cache operations and MMFR3 register
> contents.  I don't pretend to understand all the details but, based on what
> I do, it looks to me like Victor's v3 patch addresses all the issues that we
> think it needs to.  I also see now why the dcache_flush_page() is needed
> rather than a call to the lower-level clean_dcache_line() function.
>
> Victor, maybe you could remove the "#ifdef CONFIG_SMP"s from it and send it
> out as an official (non-RFC) uprobes patch?  It would be really nice to get
> this into V3.15, if at all possible.

I'll send it by the end of today (PST).

Thanks,
Victor

> -dl
>
