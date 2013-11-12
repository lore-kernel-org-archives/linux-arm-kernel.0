From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 11 Nov 2013 18:35:56 -0800
Subject: [PATCH v2] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <20131111074633.GG14892@pengutronix.de>
References: <1383951632-6090-1-git-send-email-sboyd@codeaurora.org>
 <20131111074633.GG14892@pengutronix.de>
Message-ID: <5281940C.3040705@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/13 23:46, Uwe Kleine-K?nig wrote:
> Hello,
>
> On Fri, Nov 08, 2013 at 03:00:32PM -0800, Stephen Boyd wrote:
>> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
>> index bd454b0..38621729 100644
>> --- a/arch/arm/lib/Makefile
>> +++ b/arch/arm/lib/Makefile
>> @@ -15,6 +15,12 @@ lib-y		:= backtrace.o changebit.o csumipv6.o csumpartial.o   \
>>  		   io-readsb.o io-writesb.o io-readsl.o io-writesl.o  \
>>  		   call_with_stack.o
>>  
>> +lib-$(CONFIG_CPU_V7) += div-v7.o
> CPU_V7M could make use of that, too.
> (If you follow Nico's advice to use runtime patching I cannot test it
> for you on v7-M though as my machine has to use an XIP kernel.)
>

It already is runtime patching so I suspect you won't be able to test it
anyway. I suppose we need another config like MIGHT_HAVE_IDIV or
something that both v7 and v7M select?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
