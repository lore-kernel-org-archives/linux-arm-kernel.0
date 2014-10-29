From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Oct 2014 11:28:04 +0800
Subject: [RFC V2] arm/arm64:add CONFIG_HAVE_ARCH_BITREVERSE to support
 rbit instruction
In-Reply-To: <1414392371.8884.2.camel@perches.com>
References: <35FD53F367049845BC99AC72306C23D103E010D18254@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18257@CNBJMBX05.corpusers.net>
 <1414392371.8884.2.camel@perches.com>
Message-ID: <CAL_JsqJYBoG+nrr7R3UWz1wrZ--Xjw5X31RkpCrTWMJAePBgRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 2:46 PM, Joe Perches <joe@perches.com> wrote:
> On Mon, 2014-10-27 at 14:37 +0800, Wang, Yalin wrote:
>> this change add CONFIG_HAVE_ARCH_BITREVERSE config option,
>> so that we can use arm/arm64 rbit instruction to do bitrev operation
>> by hardware.

I don't see the original patch in my inbox, so replying here.

>>
>> Signed-off-by: Yalin Wang <yalin.wang@sonymobile.com>
>> ---
>>  arch/arm/Kconfig                |  1 +
>>  arch/arm/include/asm/bitrev.h   | 21 +++++++++++++++++++++
>>  arch/arm64/Kconfig              |  1 +
>>  arch/arm64/include/asm/bitrev.h | 21 +++++++++++++++++++++
>>  include/linux/bitrev.h          |  9 +++++++++
>>  lib/Kconfig                     |  9 +++++++++
>>  lib/bitrev.c                    |  2 ++
>>  7 files changed, 64 insertions(+)
>>  create mode 100644 arch/arm/include/asm/bitrev.h
>>  create mode 100644 arch/arm64/include/asm/bitrev.h
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 89c4b5c..426cbcc 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -16,6 +16,7 @@ config ARM
>>       select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNALIGNED_ACCESS
>>       select GENERIC_ALLOCATOR
>>       select GENERIC_ATOMIC64 if (CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI)
>> +     select HAVE_ARCH_BITREVERSE if (CPU_V7M || CPU_V7)
>>       select GENERIC_CLOCKEVENTS_BROADCAST if SMP
>>       select GENERIC_IDLE_POLL_SETUP
>>       select GENERIC_IRQ_PROBE

[...]

>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 9532f8d..263c28c 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -36,6 +36,7 @@ config ARM64
>>       select HARDIRQS_SW_RESEND
>>       select HAVE_ARCH_AUDITSYSCALL
>>       select HAVE_ARCH_JUMP_LABEL
>> +     select HAVE_ARCH_BITREVERSE
>>       select HAVE_ARCH_KGDB
>>       select HAVE_ARCH_TRACEHOOK
>>       select HAVE_BPF_JIT

The kconfig lists should be sorted.

Rob
