From: punit.agrawal@arm.com (Punit Agrawal)
Date: Thu, 06 Nov 2014 12:20:34 +0000
Subject: [PATCHv3 1/5] arm64: Add support for hooks to handle undefined
 instructions
In-Reply-To: <20141105112750.GD32700@e104818-lin.cambridge.arm.com> (Catalin
 Marinas's message of "Wed, 5 Nov 2014 11:27:50 +0000")
References: <1414435207-30240-1-git-send-email-punit.agrawal@arm.com>
 <1414435207-30240-2-git-send-email-punit.agrawal@arm.com>
 <20141105112750.GD32700@e104818-lin.cambridge.arm.com>
Message-ID: <9hhvbmsed0t.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Mon, Oct 27, 2014 at 06:40:02PM +0000, Punit Agrawal wrote:
>> --- a/arch/arm64/include/asm/insn.h
>> +++ b/arch/arm64/include/asm/insn.h
>> @@ -354,6 +354,8 @@ bool aarch64_insn_hotpatch_safe(u32 old_insn, u32 new_insn);
>>  int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
>>  int aarch64_insn_patch_text_sync(void *addrs[], u32 insns[], int cnt);
>>  int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
>> +
>> +bool aarch32_insn_is_wide_instruction(u32 insn);
>
> Nitpick: too wide function name ;). Maybe aarch32_insn_is_wide().

Agreed. I'll change it to aarch32_insn_is_wide(). Please shout if you
can think of a better name.

>
> Otherwise the patch looks fine.
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks.

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
