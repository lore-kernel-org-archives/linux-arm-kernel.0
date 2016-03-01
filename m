From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Tue, 1 Mar 2016 20:35:25 +0300
Subject: [PATCH v4 2/4] ACPI: enable ACPI_SPCR_TABLE on ARM64
In-Reply-To: <56D5B4E8.1050309@hurleysoftware.com>
References: <1456747355-15692-1-git-send-email-aleksey.makarov@linaro.org>
 <1456747355-15692-3-git-send-email-aleksey.makarov@linaro.org>
 <56D5B4E8.1050309@hurleysoftware.com>
Message-ID: <56D5D2DD.30105@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/01/2016 06:27 PM, Peter Hurley wrote:
> On 02/29/2016 04:02 AM, Aleksey Makarov wrote:
>> SBBR mentions SPCR as a mandatory ACPI table.
>> So enable it for ARM64
> 
> Why is this opt-in per-arch?

It could depend only on CONFIG_ACPI.
I will do that in the next version, thank you

>> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
>> ---
>>  arch/arm64/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 9dc5209..544af2e 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -3,6 +3,7 @@ config ARM64
>>  	select ACPI_CCA_REQUIRED if ACPI
>>  	select ACPI_GENERIC_GSI if ACPI
>>  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>> +	select ACPI_SPCR_TABLE if ACPI
>>  	select ARCH_HAS_DEVMEM_IS_ALLOWED
>>  	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>>  	select ARCH_HAS_ELF_RANDOMIZE
>>
> 
