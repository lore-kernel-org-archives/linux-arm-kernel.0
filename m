From: yangyingliang@huawei.com (Yang Yingliang)
Date: Wed, 16 Sep 2015 19:07:44 +0800
Subject: [RFC PATCH v3 1/3] genirq: introduce CONFIG_GENERIC_IRQ_MIGRATION
In-Reply-To: <alpine.DEB.2.11.1509161011371.3951@nanos>
References: <1442375907-11496-1-git-send-email-yangyingliang@huawei.com>
 <1442375907-11496-2-git-send-email-yangyingliang@huawei.com>
 <alpine.DEB.2.11.1509161011371.3951@nanos>
Message-ID: <55F94D80.2070304@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/9/16 16:13, Thomas Gleixner wrote:
> On Wed, 16 Sep 2015, Yang Yingliang wrote:
>> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
>> index 78c0621..4133070 100644
>> --- a/arch/arc/Kconfig
>> +++ b/arch/arc/Kconfig
>> @@ -20,6 +20,7 @@ config ARC
>>   	# for now, we don't need GENERIC_IRQ_PROBE, CONFIG_GENERIC_IRQ_CHIP
>>   	select GENERIC_IRQ_SHOW
>>   	select GENERIC_PENDING_IRQ if SMP
>> +	select GENERIC_IRQ_MIGRATION if SMP
>
> What's the point of this?
>
>> --- a/kernel/irq/Kconfig
>> +++ b/kernel/irq/Kconfig
>> @@ -30,6 +30,10 @@ config GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
>>   config GENERIC_PENDING_IRQ
>>   	bool
>
> +	select GENERIC_IRQ_MIGRATION
>
> Will do it automatically without touching any of the arch Kconfig
> files.

Your way is better, I will use this method.

Thanks,
Yang
>
> Thanks,
>
> 	tglx
>
> .
>
