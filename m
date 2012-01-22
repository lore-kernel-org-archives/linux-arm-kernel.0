From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 22 Jan 2012 18:32:37 -0500
Subject: [PATCH] arm: fix build failure in code for mach-bcmring/dma.c
In-Reply-To: <20120122211723.GB12326@n2100.arm.linux.org.uk>
References: <1327266579-21951-1-git-send-email-paul.gortmaker@windriver.com>
 <20120122211723.GB12326@n2100.arm.linux.org.uk>
Message-ID: <4F1C9C95.2060600@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-01-22 04:17 PM, Russell King - ARM Linux wrote:
> On Sun, Jan 22, 2012 at 04:09:39PM -0500, Paul Gortmaker wrote:
>> Upstream commit 99d1717dd7fecf2b10195b0d864323b952b4eba0
>>
>>        "ARM: Add init_consistent_dma_size()"
>>
>> essentially did this:
>>
>> -#define CONSISTENT_BASE                (CONSISTENT_END - CONSISTENT_DMA_SIZE)
>> +unsigned long consistent_base = CONSISTENT_END - DEFAULT_CONSISTENT_DMA_SIZE;
>>
>> but the bcmring code was still using the old CONSISTENT_BASE
>> macro.  Update it to now use the dynamic variable that reflects
>> the ability to resize early at boot.  To do so involves putting
>> the variable alongside of init_consistent_dma_size in dma-mapping.h
> 
> Oh god, what are the bcmring people doing with this variable?

    [snip original BCM code]
 
> So really, this code is broken.  It needs to be fixed, rather than fixing
> the core ARM code to allow this brokenness to persist.

I can't argue with that; if the build regression happens 
to shine a light on bigger issues, then the appropriate people
are on the CC (I hope).  It is beyond me to figure out what
the original code's intent was - but at least they will now
know when it broke and why...

Thanks,
Paul.
