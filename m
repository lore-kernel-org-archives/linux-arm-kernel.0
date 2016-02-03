From: james.morse@arm.com (James Morse)
Date: Wed, 03 Feb 2016 15:31:00 +0000
Subject: [PATCH v1 2/5] arm64: add ARMv8.2 id_aa64mmfr2 boiler plate
In-Reply-To: <56B1EEC5.9020506@arm.com>
References: <1454432611-21333-1-git-send-email-james.morse@arm.com>
 <1454432611-21333-3-git-send-email-james.morse@arm.com>
 <56B1EEC5.9020506@arm.com>
Message-ID: <56B21D34.8060106@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

On 03/02/16 12:12, Suzuki K. Poulose wrote:
> On 02/02/16 17:03, James Morse wrote:
>> ARMv8.2 adds a new feature register id_aa64mmfr2. This patch adds the
>> cpu feature boiler plate used by the actual features in later patches.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
> 
> 
>>   #define SYS_CNTFRQ_EL0            sys_reg(3, 3, 14, 0, 0)
>>   #define SYS_CTR_EL0            sys_reg(3, 3, 0, 0, 1)
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index a84febc40db2..a4f665f95f9f 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -123,6 +123,10 @@ static struct arm64_ftr_bits ftr_id_aa64mmfr1[] = {
>>       ARM64_FTR_END,
>>   };
>>
>> +static struct arm64_ftr_bits ftr_id_aa64mmfr2[] = {
>> +    ARM64_FTR_END,
> 
> It will be good to see all the defined fields in id_aa64mmfr2 added here in
> this patch. You could also move the definition of UA0 field from the next patch
> to here.

Okay, what are the rules for unsupported features?

UAO support isn't added until a later patch, I assumed it was best to add the
definition as part of that patch.

> 
> Otherwise looks good.
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks,

James
