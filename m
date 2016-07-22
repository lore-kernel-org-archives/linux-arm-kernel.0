From: mcuos.com@gmail.com (Wan ZongShun)
Date: Fri, 22 Jul 2016 10:37:10 +0800
Subject: [PATCH 4/6] irqchip: add irqchip driver for nuc900
In-Reply-To: <7701071.Nr6sCmDkjL@wuerfel>
References: <1466851042-22239-1-git-send-email-vw@iommu.org>
 <8706947.5rzUDVsB2F@wuerfel> <57806E9F.3020407@iommu.org>
 <7701071.Nr6sCmDkjL@wuerfel>
Message-ID: <CAKT61h9Ohimoc8FVDvR3KL6PNy3tk_Hxkp+fNdNUjvNoyJuApQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
>> but I will remove the Macros related to nuc970 and avoid nuc970
>> interrupt using those Macro.
>>
>> But I still need hack this irqs.h like below, since here NR_IRQS defined
>> and it is need for nuc970 irqchip driver.
>>
>> #if !defined(CONFIG_SOC_NUC900)
>> #define NR_IRQS         (IRQ_ADC+1)
>> #else
>> #define NR_IRQS         62
>> #endif
>
> Have you considered using CONFIG_SPARSE_IRQ? That would avoid the need
> for setting NR_IRQS entirely, but may also require more work elsewhere.

Sure, I will refer to your previous nuc900 series patches for SPARSE
IRQ, now I am waiting for rc1 release, and will send v3 patches.

>
>         Arnd



-- 
---
Vincent Wan(Zongshun)
www.mcuos.com
