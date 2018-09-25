From: ylhuajnu@outlook.com (Yao Lihua)
Date: Tue, 25 Sep 2018 03:10:10 +0000
Subject: [PATCH v5 01/27] arm64: cpufeature: Set SYSREG_GIC_CPUIF as a
 boot system feature
In-Reply-To: <86h8iix2rk.wl-marc.zyngier@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-2-git-send-email-julien.thierry@arm.com>
 <86h8iix2rk.wl-marc.zyngier@arm.com>
Message-ID: <MWHPR0601MB3707D7CF3B55BF40EEEA0D52C4160@MWHPR0601MB3707.namprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc, Julien?


On 09/21/2018 11:56 PM, Marc Zyngier wrote:
> On Tue, 28 Aug 2018 16:51:11 +0100,
> Julien Thierry <julien.thierry@arm.com> wrote:
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm64/kernel/cpufeature.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index e238b79..1e433ac 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -1039,7 +1039,7 @@ static void cpu_has_fwb(const struct arm64_cpu_capabilities *__unused)
>>  	{
>>  		.desc = "GIC system register CPU interface",
>>  		.capability = ARM64_HAS_SYSREG_GIC_CPUIF,
>> -		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>> +		.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
>>  		.matches = has_useable_gicv3_cpuif,
>>  		.sys_reg = SYS_ID_AA64PFR0_EL1,
>>  		.field_pos = ID_AA64PFR0_GIC_SHIFT,
>> -- 
>> 1.9.1
>>
> This definitely deserves a commit message, such as:
>
> "We do not support systems where some CPUs have an operational GICv3
>  CPU interface, and some don't. Let's make this requirement obvious by
>  flagging the GICv3 capability as being strict."
May I ask if it is possible to implement psedue-NMI on a arm64 SoC with GIC-400?
>
> Thanks,
>
> 	M.
>
Best Regards,
Lihua
