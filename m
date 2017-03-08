From: Alan.Hayward@arm.com (Alan Hayward)
Date: Wed, 8 Mar 2017 12:30:25 +0000
Subject: [PATCH] arm64/sve: Reserve HWCAP and ELF note numbers for SVE
In-Reply-To: <20170308121948.GA3750@e103592.cambridge.arm.com>
References: <1488550406-11204-1-git-send-email-Dave.Martin@arm.com>
 <20170306152447.GD22810@e104818-lin.cambridge.arm.com>
 <20170308121948.GA3750@e103592.cambridge.arm.com>
Message-ID: <0EAA1F02-82C3-48FB-BAA4-D84DBD2DDD62@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 8 Mar 2017, at 12:20, Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Mon, Mar 06, 2017 at 03:24:47PM +0000, Catalin Marinas wrote:
>> On Fri, Mar 03, 2017 at 02:13:26PM +0000, Dave P Martin wrote:
>>> --- a/include/uapi/linux/elf.h
>>> +++ b/include/uapi/linux/elf.h
>>> @@ -414,6 +414,7 @@ typedef struct elf64_shdr {
>>> #define NT_ARM_HW_BREAK0x402/* ARM hardware breakpoint registers */
>>> #define NT_ARM_HW_WATCH0x403/* ARM hardware watchpoint registers */
>>> #define NT_ARM_SYSTEM_CALL0x404/* ARM system call number */
>>> +/* 0x405 reserved for SVE */
>>
>> Just a nitpick: given that this is generic file, even if it's in the
>> ARM-specific section, it might be worth adding "ARM" to the comment:
>> "reserved for ARM SVE" (not needed for hwcap).
>
> Will do.
>
>> Depending on the SVE merging timescales, this patch may go in together
>> with the rest ;).
>
> I need to respin this, because HWCAP_CPUID and HWCAP_ASIMDRDM went in
> first (my bad, should have seen those in flight) -- since we are only
> at -rc1 those could be renumbered, but it's probably not worth the
> associated risks.
>
> In any case, NT_ARM_SVE was the more important reservation.
>
> Yao, Alan, does gdb make any use of HWCAP_SVE?

It exists in binutils, but neither binutils nor gdb make use of it yet.

>
> Cheers
> ---Dave

IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
