From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 25 Aug 2014 11:29:44 -0600
Subject: [PATCH] ARM: tegra: Move AHB Kconfig to drivers/amba
In-Reply-To: <53D7C9EE.60503@wwwdotorg.org>
References: <1406643934-16301-1-git-send-email-thierry.reding@gmail.com>
 <53D7C9EE.60503@wwwdotorg.org>
Message-ID: <53FB7288.9050002@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2014 10:21 AM, Stephen Warren wrote:
> On 07/29/2014 08:25 AM, Thierry Reding wrote:
>> From: Thierry Reding <treding@nvidia.com>
>>
>> This will allow the Kconfig option to be shared among 32-bit and 64-bit
>> ARM.
>
> This seems fine to me. I'd expect to apply it for 3.18, provided I get
> an ack from Russell as drivers/amba maintainer (hence CCing him without
> trimming the quote).

Russell,

Are you OK with this patch? If so, if you could ack it so I can apply 
it, that would be great.

Thanks.

>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>> ---
>>   arch/arm/mach-tegra/Kconfig |  8 --------
>>   drivers/amba/Kconfig        | 11 +++++++++++
>>   2 files changed, 11 insertions(+), 8 deletions(-)
>>   create mode 100644 drivers/amba/Kconfig
>>
>> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
>> index 052fba07a3cb..fae2eb2f52ea 100644
>> --- a/arch/arm/mach-tegra/Kconfig
>> +++ b/arch/arm/mach-tegra/Kconfig
>> @@ -64,12 +64,4 @@ config ARCH_TEGRA_124_SOC
>>         Support for NVIDIA Tegra T124 processor family, based on the
>>         ARM CortexA15MP CPU
>>
>> -config TEGRA_AHB
>> -    bool "Enable AHB driver for NVIDIA Tegra SoCs"
>> -    default y
>> -    help
>> -      Adds AHB configuration functionality for NVIDIA Tegra SoCs,
>> -      which controls AHB bus master arbitration and some
>> -      performance parameters(priority, prefech size).
>> -
>>   endif
>> diff --git a/drivers/amba/Kconfig b/drivers/amba/Kconfig
>> new file mode 100644
>> index 000000000000..3f7350a03708
>> --- /dev/null
>> +++ b/drivers/amba/Kconfig
>> @@ -0,0 +1,11 @@
>> +if ARM_AMBA
>> +
>> +config TEGRA_AHB
>> +    bool "Enable AHB driver for NVIDIA Tegra SoCs"
>> +    default y if ARCH_TEGRA
>> +    help
>> +      Adds AHB configuration functionality for NVIDIA Tegra SoCs,
>> +      which controls AHB bus master arbitration and some performance
>> +      parameters (priority, prefetch size).
>> +
>> +endif
>>
>
