From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 18 Aug 2016 15:52:00 +0100
Subject: [PATCH 4/8] arm64: insn: Add helpers for adrp offsets
In-Reply-To: <57B5CA91.1070206@arm.com>
References: <1471525832-21209-1-git-send-email-suzuki.poulose@arm.com>
 <1471525832-21209-5-git-send-email-suzuki.poulose@arm.com>
 <57B5CA91.1070206@arm.com>
Message-ID: <2e1e2f56-dc0a-3227-0af9-eea48cc9e7af@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/08/16 15:47, Marc Zyngier wrote:
> Hi Suzuki,
>
> On 18/08/16 14:10, Suzuki K Poulose wrote:
>> Adds helpers for decoding/encoding the PC relative addresses for adrp.
>> This will be used for handling dynamic patching of 'adrp' instructions
>> in alternative code patching.
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>  arch/arm64/include/asm/insn.h |  4 ++++
>>  arch/arm64/kernel/insn.c      | 13 +++++++++++++
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
>> index 1dbaa90..dffb0364 100644
>> --- a/arch/arm64/include/asm/insn.h
>> +++ b/arch/arm64/include/asm/insn.h
>> @@ -247,6 +247,7 @@ static __always_inline u32 aarch64_insn_get_##abbr##_value(void) \
>>  { return (val); }
>>
>>  __AARCH64_INSN_FUNCS(adr_adrp,	0x1F000000, 0x10000000)
>> +__AARCH64_INSN_FUNCS(adrp,	0x9F000000, 0x90000000)
>
> I'm a bit bothered by this one. We end-up with both
> aarch64_insn_is_adr_adrp() *and* aarch64_insn_is_adrp() (and their
> respective getters).

You're right. It doesn't look good.  

> How about dropping adr_adrp, and explicitly having adr and adrp? There
> is only two users in the tree, so that should be easy to address.

Sounds good, will update if for v2.

Cheers
Suzuki
