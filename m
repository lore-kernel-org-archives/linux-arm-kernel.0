From: m-karicheri2@ti.com (Karicheri, Muralidharan)
Date: Fri, 16 May 2014 14:36:37 +0000
Subject: [PATCH v1 1/5] ARM: keystone: add pcie related options
In-Reply-To: <004e01cf709d$a48b4240$eda1c6c0$%han@samsung.com>
References: <1400169692-9677-1-git-send-email-m-karicheri2@ti.com>
 <1400169692-9677-2-git-send-email-m-karicheri2@ti.com>
 <004e01cf709d$a48b4240$eda1c6c0$%han@samsung.com>
Message-ID: <3E54258959B69E4282D79E01AB1F32B7047413F8@DFLE11.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
>From: Jingoo Han [mailto:jg1.han at samsung.com]
>Sent: Thursday, May 15, 2014 8:28 PM
>To: Karicheri, Muralidharan
>Cc: linux-kernel at vger.kernel.org; linux-pci at vger.kernel.org; linux-arm-
>kernel at lists.infradead.org; Shilimkar, Santosh; 'Russell King'; 'Jingoo Han'
>Subject: Re: [PATCH v1 1/5] ARM: keystone: add pcie related options
>
>On Friday, May 16, 2014 1:01 AM, Murali Karicheri wrote:
>>
>> Add pcie related options by default for keystone architecture
>>
>> CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> CC: Russell King <linux@arm.linux.org.uk>
>>
>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>> ---
>>  arch/arm/mach-keystone/Kconfig |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/mach-keystone/Kconfig
>> b/arch/arm/mach-keystone/Kconfig index f50bc93..f87844d 100644
>> --- a/arch/arm/mach-keystone/Kconfig
>> +++ b/arch/arm/mach-keystone/Kconfig
>> @@ -8,6 +8,8 @@ config ARCH_KEYSTONE
>>  	select COMMON_CLK_KEYSTONE
>>  	select ARCH_SUPPORTS_BIG_ENDIAN
>>  	select ZONE_DMA if ARM_LPAE
>> +	select MIGHT_HAVE_PCI
>> +	select ARCH_SUPPORTS_MSI
>
>Please, don't select ARCH_SUPPORTS_MSI, because this kconfig option was already
>removed in v3.12 by the commit ebd97be635
>('PCI: remove ARCH_SUPPORTS_MSI kconfig option'). So. there is NO need to select
>'ARCH_SUPPORTS_MSI'.
>

Will do. Thanks.

>Best regards,
>Jingoo Han
>
>>  	help
>>  	  Support for boards based on the Texas Instruments Keystone family of
>>  	  SoCs.
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci"
>> in the body of a message to majordomo at vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
