From: b32955@freescale.com (Huang Shijie)
Date: Tue, 10 Apr 2012 18:30:52 +0800
Subject: Bug in v7_coherent_kern_range() ?
In-Reply-To: <20120410092214.GA2620@mudshark.cambridge.arm.com>
References: <4F77C9A6.6080601@freescale.com>
 <20120402111240.GG19011@mudshark.cambridge.arm.com>
 <4F7E646D.6000302@freescale.com>
 <20120410092214.GA2620@mudshark.cambridge.arm.com>
Message-ID: <4F840BDC.5060307@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi will:
> On Fri, Apr 06, 2012 at 04:35:09AM +0100, Huang Shijie wrote:
>>> http://lists.arm.linux.org.uk/lurker/message/20111107.173344.f738392e.en.html
>> I tested this patch.  It fixed this bug. This bug did not occur any more.
>> But my system still hung at futex. I think the futex issue is another
>> bug.(will this patch affect the futex?)
> If you're on an SMP system, can you check that you have df77abca ("ARM:
> 7099/1: futex: preserve oldval in SMP __futex_atomic_op") applied?
>

already applied.
thanks.

The futex codes (/kernel/futex.c and arch/arm/include/asm/futex.h) are 
the latest.
I guess there is a bug in the futex code in SMP system.

Best Regards
Huang Shijie


>> So :
>> Tested-by: Huang Shijie<b32955@freescale.com>
> Ok, thanks. It looks that has briefly revived the discussion over there at
> least.
>
> Will
>
