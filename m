From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 24 Apr 2013 10:36:18 +0100
Subject: [PATCH v3 03/32] arm64: KVM: HYP mode idmap support
In-Reply-To: <20130423225733.GA20569@gmail.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-4-git-send-email-marc.zyngier@arm.com>
 <20130423225733.GA20569@gmail.com>
Message-ID: <5177A792.9030001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/04/13 23:57, Christoffer Dall wrote:
> 
> 
> On Mon, Apr 8, 2013 at 9:17 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> Add the necessary infrastructure for identity-mapped HYP page
>> tables. Idmap-ed code must be in the ".hyp.idmap.text" linker
>> section.
>>
>> The rest of the HYP ends up in ".hyp.text".
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm64/kernel/vmlinux.lds.S | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>> index 3fae2be..855d43d 100644
>> --- a/arch/arm64/kernel/vmlinux.lds.S
>> +++ b/arch/arm64/kernel/vmlinux.lds.S
>> @@ -17,6 +17,15 @@ ENTRY(stext)
>>
>>  jiffies = jiffies_64;
>>
>> +#define HYPERVISOR_TEXT                                        \
>> +       . = ALIGN(2048);                                \
> 
> why align to 2048?  Comment?

Vectors require a 2kB alignment. I'll add a comment to that effect.

> are you changing this to the same idea as for the 32-bit code to reduce the kernel size?

The mechanism is exactly the same indeed. Only the alignment
requirements are (massively) different.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
