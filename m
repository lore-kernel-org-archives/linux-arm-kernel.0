From: vw@iommu.org (Wan Zongshun)
Date: Tue, 12 Jul 2016 15:04:42 +0800
Subject: [PATCH v2 02/10] irqchip: add irqchip driver for nuc900
In-Reply-To: <1761342.TGgYi16yul@wuerfel>
References: <1468135649-19980-1-git-send-email-vw@iommu.org>
 <1468135649-19980-3-git-send-email-vw@iommu.org> <1761342.TGgYi16yul@wuerfel>
Message-ID: <5784968A.7080007@iommu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016?07?11? 23:46, Arnd Bergmann wrote:
> On Sunday, July 10, 2016 3:27:22 PM CEST Wan Zongshun wrote:
>> +
>> +#if !defined(CONFIG_SOC_NUC900)
>>   #define NR_IRQS                (IRQ_ADC+1)
>> +#else
>> +#define NR_IRQS                62
>> +#endif
>>
>
> The Kconfig symbols are a bit confusing here: CONFIG_SOC_NUC900
> controls the compilation of the soc_device driver, but I guess
> what you actually mean here is CONFIG_SOC_NUC970, which is the
> support for the actual chip.
>
> Maybe rename the former to something less confusing and change
> this to CONFIG_SOC_NUC970?

You are right, it should _NUC970. Many thanks!

>
> Ideally, this should just go away once we use SPARSE_IRQ.

This platform also can use SPARSE_IRQ? this just a simple irq map and no 
more irq number in this Soc.

>
> 	Arnd
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
