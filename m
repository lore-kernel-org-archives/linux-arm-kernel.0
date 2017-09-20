From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 20 Sep 2017 19:58:34 +0900
Subject: [PATCH] arm64: relax assembly code alignment from 16 byte to 4
 byte
In-Reply-To: <20170907164651.3bmhdkbnxvj3pz7g@armageddon.cambridge.arm.com>
References: <1504173383-8367-1-git-send-email-yamada.masahiro@socionext.com>
 <20170907164651.3bmhdkbnxvj3pz7g@armageddon.cambridge.arm.com>
Message-ID: <CAK7LNAQYDgY-4Bu9-RRLAj8hvKFXx2ctXFf058W4uQLoqpTQeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,


2017-09-08 1:46 GMT+09:00 Catalin Marinas <catalin.marinas@arm.com>:
> On Thu, Aug 31, 2017 at 06:56:23PM +0900, Masahiro Yamada wrote:
>> Aarch64 instructions must be word aligned.  The current 16 byte
>> alignment is more than enough.  Relax it into 4 byte alignment.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>> I do not know why arm64 Linux requires 16 byte alignment.
>>
>> I dug git-history of arch/arm64/include/asm/linkage.h
>> and the only commit I see is:
>>
>>   commit aeed41a9371ee02257b608eb06a9058507a7d0f4
>>   Author: Marc Zyngier <Marc.Zyngier@arm.com>
>>   Date:   Fri Oct 19 17:33:27 2012 +0100
>>
>>       arm64: fix alignment padding in assembly code
>>
>> It just opt out of the asm-generic variant to remove 0x90.
>> So, the amount of alignment might not be not optimized yet.
>>
>> Please correct me if I am missing something.
>
> Not sure why we ended up with 4. Possibly because we forgot the power of
> 2 difference for arm/arm64.
>
> Queued for 4.14. Thanks.


I still do not see this patch in linux-next.

Where was it queued?





-- 
Best Regards
Masahiro Yamada
