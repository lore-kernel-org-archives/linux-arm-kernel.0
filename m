From: cyril@ti.com (Cyril Chemparathy)
Date: Tue, 11 Sep 2012 12:59:39 -0400
Subject: [PATCH] ARM: avoid undef on ARCH_HAS_READ_CURRENT_TIMER
In-Reply-To: <20120911162522.GE32234@mudshark.cambridge.arm.com>
References: <1347380341-28145-1-git-send-email-cyril@ti.com>
 <20120911162522.GE32234@mudshark.cambridge.arm.com>
Message-ID: <504F6DFB.5030208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/11/2012 12:25 PM, Will Deacon wrote:
> On Tue, Sep 11, 2012 at 05:19:00PM +0100, Cyril Chemparathy wrote:
>> With the inclusion of asm-generic/timex.h, the ARM arch timer implementation
>> breaks on build.  This is because asm/arch_timer.h now defines
>> ARCH_HAS_READ_CURRENT_TIMER, only to have this macro undefined by the
>> subsequent inclusion of asm-generic/timex.h.
>>
>> This patch fixes the problem in asm/timex.h by including asm-generic/timex.h
>> early, and by defining get_cycles even earlier.
>>
>> This patch has been tested against linux-next-20120910, both with and without
>> arch timer support.
>
> Is this still a problem with 7530/1 ("delay: add registration mechanism for
> delay timer sources") applied?
>
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7530/1
>

Excellent.

This conflicts with linux-next-20120910, and needs an added include of 
<asm/delay.h> in timex.h.  With that in place, it works for me.

-- 
Thanks
- Cyril
