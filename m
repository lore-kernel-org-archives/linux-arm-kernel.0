From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 14 Apr 2016 17:50:20 +0100
Subject: [PATCH v3 5/7] arm64: cpufeature: Track 32bit EL0 support
In-Reply-To: <20160414164305.GH4584@arm.com>
References: <1459445255-15653-1-git-send-email-suzuki.poulose@arm.com>
 <1459445255-15653-6-git-send-email-suzuki.poulose@arm.com>
 <20160414164305.GH4584@arm.com>
Message-ID: <570FCA4C.4020208@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/04/16 17:43, Will Deacon wrote:
> On Thu, Mar 31, 2016 at 06:27:33PM +0100, Suzuki K Poulose wrote:
>> Add cpu_hwcap bit for keeping track of the support for 32bit EL0.
>>

>>   	return id_aa64mmfr0_mixed_endian_el0(read_system_reg(SYS_ID_AA64MMFR0_EL1));
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index cfc0cfd..739314b 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -733,6 +733,15 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>>   		.capability = ARM64_HAS_VIRT_HOST_EXTN,
>>   		.matches = runs_at_el2,
>>   	},
>> +	{
>> +		.desc = "32bit EL0 Support",
>
> Nit: missing hyphen (32-bit).

OK, can change it.

Suzuki
