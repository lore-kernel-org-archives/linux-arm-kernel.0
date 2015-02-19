From: zlim.lnx@gmail.com (Z Lim)
Date: Thu, 19 Feb 2015 11:33:51 -0800
Subject: [PATCH] arm64: insn: fix compare-and-branch encodings
In-Reply-To: <54E4B8EC.7090709@arm.com>
References: <369053df4298c754061e47068834bd9640b0841b.1424273599.git.robin.murphy@arm.com>
 <54E4B8EC.7090709@arm.com>
Message-ID: <CABg9mctwRkCwbBJRSGXy1NYJkQXnLDmE-DpFLd3AjfygJx1dCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 18, 2015 at 8:08 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> Oops, missed some CCs...
>
> On 18/02/15 15:40, Robin Murphy wrote:
>>
>> Fix cbz/cbnz having the mask offset by a bit, and add encodings for
>> tbz/tbnz so that all branch forms are represented.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> Acked-by: Will Deacon <will.deacon@arm.com>
>> ---
>>   arch/arm64/include/asm/insn.h | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
>> index e2ff32a..d2f4942 100644
>> --- a/arch/arm64/include/asm/insn.h
>> +++ b/arch/arm64/include/asm/insn.h
>> @@ -264,8 +264,10 @@ __AARCH64_INSN_FUNCS(ands, 0x7F200000, 0x6A000000)
>>   __AARCH64_INSN_FUNCS(bics,    0x7F200000, 0x6A200000)
>>   __AARCH64_INSN_FUNCS(b,               0xFC000000, 0x14000000)
>>   __AARCH64_INSN_FUNCS(bl,      0xFC000000, 0x94000000)
>> -__AARCH64_INSN_FUNCS(cbz,      0xFE000000, 0x34000000)
>> -__AARCH64_INSN_FUNCS(cbnz,     0xFE000000, 0x35000000)
>> +__AARCH64_INSN_FUNCS(cbz,      0x7F000000, 0x34000000)
>> +__AARCH64_INSN_FUNCS(cbnz,     0x7F000000, 0x35000000)
>> +__AARCH64_INSN_FUNCS(tbz,      0x7F000000, 0x36000000)
>> +__AARCH64_INSN_FUNCS(tbnz,     0x7F000000, 0x37000000)
>>   __AARCH64_INSN_FUNCS(bcond,   0xFF000010, 0x54000000)
>>   __AARCH64_INSN_FUNCS(svc,     0xFFE0001F, 0xD4000001)
>>   __AARCH64_INSN_FUNCS(hvc,     0xFFE0001F, 0xD4000002)
>>

Looks good to me, as described in ARMv8 ARM.

Acked-by: Zi Shen Lim <zlim.lnx@gmail.com>
