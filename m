From: dave.long@linaro.org (David Long)
Date: Mon, 03 Feb 2014 21:07:24 -0500
Subject: [PATCH v5 07/16] ARM: Remove use of struct kprobe from generic
 probes code
In-Reply-To: <1391439425.3509.16.camel@linaro1.home>
References: <1390507559-4697-1-git-send-email-dave.long@linaro.org>
 <1390507559-4697-8-git-send-email-dave.long@linaro.org>
 <1391439425.3509.16.camel@linaro1.home>
Message-ID: <52F04B5C.5060301@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/14 09:57, Jon Medhurst (Tixy) wrote:
> On Thu, 2014-01-23 at 15:05 -0500, David Long wrote:
>> From: "David A. Long" <dave.long@linaro.org>
>>
>> Change the generic ARM probes code to pass in the opcode and architecture-specific
>> structure separately instead of using struct kprobe, so we do not pollute
>> code being used only for uprobes or other non-kprobes instruction
>> interpretation.
>>
>> Signed-off-by: David A. Long <dave.long@linaro.org>
>> ---
>
> One minor nit-pick...
>
> [...]
>> diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
>> index c7ee290..cea707a 100644
>> --- a/arch/arm/kernel/kprobes-thumb.c
>> +++ b/arch/arm/kernel/kprobes-thumb.c
> [...]
>> @@ -593,7 +590,7 @@ t16_emulate_pop_pc(struct kprobe *p, struct pt_regs *regs)
>>   	bx_write_pc(pc, regs);
>>   }
>>
>> -static enum kprobe_insn __kprobes
>> +enum kprobe_insn __kprobes
>>   t16_decode_pop(kprobe_opcode_t insn, struct arch_specific_insn *asi,
>>   		struct decode_header *d)
>>   {
>
> The above removal of 'static' appears to be an unneeded accidental
> change?
>

Yes, that got lost during editing.  The change has been made.

-dl
