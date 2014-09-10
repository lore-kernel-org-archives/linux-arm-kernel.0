From: riku.voipio@linaro.org (Riku Voipio)
Date: Wed, 10 Sep 2014 16:45:07 +0300
Subject: [PATCH] Enable gcov support on the ARM architecture
In-Reply-To: <7440624.dBfm8VFYff@wuerfel>
References: <1410181174-14977-1-git-send-email-riku.voipio@linaro.org>
 <7440624.dBfm8VFYff@wuerfel>
Message-ID: <CAAqcGHmKzgGbc93w_Vm=WSp-5eYvdMSVBCoa43=C1wuQwSaKaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 September 2014 16:25, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 08 September 2014 15:59:34 Riku Voipio wrote:
>> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
>> index 38ddd9f..979c4e9 100644
>> --- a/arch/arm/kernel/Makefile
>> +++ b/arch/arm/kernel/Makefile
>> @@ -5,6 +5,8 @@
>>  CPPFLAGS_vmlinux.lds := -DTEXT_OFFSET=$(TEXT_OFFSET)
>>  AFLAGS_head.o        := -DTEXT_OFFSET=$(TEXT_OFFSET)
>>
>> +GCOV_PROFILE := n
>> +
>>  ifdef CONFIG_FUNCTION_TRACER
>>  CFLAGS_REMOVE_ftrace.o = -pg
>>  CFLAGS_REMOVE_insn.o = -pg

> This part doesn't look right: you don't want to disable profiling for
> the entire directory, only for the parts on which it cannot be used.

You are right. I can just remove that hunk and I can both boot and
record coverage info from arch/arm/kernel. Any other comments, or
should I just resubmit without arch/arm/kernel bits?

Riku
