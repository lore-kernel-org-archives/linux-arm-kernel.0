From: dirk.behme@googlemail.com (Dirk Behme)
Date: Sun, 06 Dec 2009 10:11:31 +0100
Subject: [RFC PATCH 0/2] Race in vfp_notifier()
In-Reply-To: <1250008803.30628.7.camel@pc1117.cambridge.arm.com>
References: <20090422171355.19555.89735.stgit@pc1117.cambridge.arm.com>	
	<4A819B36.3010809@googlemail.com>
	<1250008803.30628.7.camel@pc1117.cambridge.arm.com>
Message-ID: <4B1B7543.909@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> On Tue, 2009-08-11 at 18:24 +0200, Dirk Behme wrote:
>> Catalin Marinas wrote:
>>> Hi,
>>>
>>> We've been hitting this bug probably for more than a year but I only
>>> recently got time to investigate. The second patch has a short
>>> description of what's going on and the proposed fix. My fix requires
>>> something like cmpxchg which wasn't available for ARM (though patches
>>> were posted in the past).
>>>
>>> If you have any better solution, please let me know.
>>>
>>> Thanks.
>>>
>>>
>>> Catalin Marinas (2):
>>>       Fix a race in the vfp_notifier() function on SMP systems
>>>       Add cmpxchg support for ARMv6+ SMP systems
>>>
>>>
>>>  arch/arm/include/asm/system.h |   48 +++++++++++++++++++++++++++++++++++++++++
>>>  arch/arm/kernel/traps.c       |    8 +++++++
>>>  arch/arm/vfp/vfpmodule.c      |   25 +++++++++++++++++++--
>>>  3 files changed, 78 insertions(+), 3 deletions(-)
>> What's the recent status of this patch series?
>>
>> It looks like the recent version of
>>
>> Add cmpxchg support for ARMv6+ SMP systems
>> http://lkml.indiana.edu/hypermail/linux/kernel/0906.0/01049.html
>> -> [ARM] Add cmpxchg support for ARMv6+ systems (v5)
>>
>> is applied to 2.6.30-rc8, but what's about
>>
>> Fix a race in the vfp_notifier() function on SMP systems
>> http://article.gmane.org/gmane.linux.ports.arm.kernel/56631
> 
> I haven't received an ack yet (and I also forgot to repost). But it is
> in the same category with the ASID roll-over patch and Russell doesn't
> currently have a working SMP system to check these.

I'd like to ping on this again ;)

Would be nice to get something like this merged.

For reference:

http://article.gmane.org/gmane.linux.ports.arm.kernel/56631
http://www.linux-arm.org/git?p=linux-2.6.git;a=commit;h=0f69b76d17642205990f0d6a3da2a9fbe86edd90

Russell: Any comments?

Many thanks and best regards

Dirk
