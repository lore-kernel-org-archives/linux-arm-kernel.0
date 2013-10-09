From: gang.chen@asianux.com (Chen Gang)
Date: Wed, 09 Oct 2013 08:18:41 +0800
Subject: [PATCH 2/2] ARM: include: asm: use 'int' instead of 'unsigned
 long' for normal register variables within atomic.h
In-Reply-To: <20131008174945.GJ21189@mudshark.cambridge.arm.com>
References: <20131002104158.GD28311@mudshark.cambridge.arm.com>
 <524C3981.20307@asianux.com> <524D416B.5090709@asianux.com>
 <20131003163200.GE7408@mudshark.cambridge.arm.com>
 <524E8FBC.2080200@asianux.com>
 <20131004153742.GR24303@mudshark.cambridge.arm.com>
 <20131004154208.GS24303@mudshark.cambridge.arm.com>
 <524F5566.4010204@asianux.com>
 <20131008103331.GE17148@mudshark.cambridge.arm.com>
 <5253EC8A.2030305@asianux.com>
 <20131008174945.GJ21189@mudshark.cambridge.arm.com>
Message-ID: <5254A0E1.9090703@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/2013 01:49 AM, Will Deacon wrote:
> On Tue, Oct 08, 2013 at 12:29:14PM +0100, Chen Gang wrote:
>> Hmm... for atomic_set_mask(), "drivers/gpu/drm/i915/i915_irq.c" also
>> uses it (it is about Intel Graphics).
> 
> I don't think we care too much about the Intel graphics driver on ARM at the
> moment.
> 
>> For some architectures (e.g. frv, mn10300, mr32r, blackfin, and of cause
>> s390), still use atomic_[set/clear]_mask().
> 
> We don't care about those either.
> 
>> And they are inline functions in atomic.h, individual kernel modules may
>> use them (which source code is not merged into kernel). Can we skip
>> these individual modules? (I guess we can, but need think of carefully).
> 
> or those. If somebody starts complaining, then we can add things back.
> 

OK, thanks. For s390, it need use 'unsigned int' instead of 'unsigned
long' (which already acked by related maintainers).

So at least, we can use "unsigned int" instead of "unsigned long" for
our arm64. :-)

I will send related patch for arm64 (also re-send related patch for s390).

Thanks.

>>>> And also, excuse me, I am not quite familiar with "exclusive monitor",
>>>> could you please provide more details about it?
>>>
>>> You'll need to take a look at the ARM ARM, in particular the section about
>>> `Synchronisation and Semaphores'.
>>>
>>
>> Do you mean "ARM ARM" is a book name? (at least, I really need read more
>> things to familiar with ARM)
> 
> Yes, the hilariouly titled "ARM Architecture Reference Manual". You can find
> it on arm.com, but you have to register:
> 
> ARMv7: https://silver.arm.com/download/download.tm?pv=1299246
> ARMv8 (beta): https://silver.arm.com/download/download.tm?pv=1448511
> 

Thank you very much for your information.

> Enjoy!
> 
> Will
> 
> 

Thanks.
-- 
Chen Gang
