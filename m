From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 21 Jul 2011 14:43:10 +0900
Subject: [PATCH v3 1/6] ARM: EXYNOS4: Increase NR_IRQS for devices with
	more IRQs
In-Reply-To: <06c801cc46ff$29855330$7c8ff990$%kim@samsung.com>
References: <1309421729-11172-1-git-send-email-myungjoo.ham@samsung.com>
	<1309421729-11172-2-git-send-email-myungjoo.ham@samsung.com>
	<06c801cc46ff$29855330$7c8ff990$%kim@samsung.com>
Message-ID: <CAJ0PZbRez4KN+ZPvRsiWTQ8+aYTzpbRyKCQEACwGQcYqQUd_vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2011 at 2:04 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> MyungJoo Ham wrote:
>>
>> MAX8997/17042, which are used by Exynos4-NURI, use additional IRQ
>> numbers after GPIO's IRQs. The patch creates some room for those
>> devices.
>>
>> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> ?arch/arm/mach-exynos4/include/mach/irqs.h | ? ?2 +-
>> ?1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos4/include/mach/irqs.h b/arch/arm/mach-
>> exynos4/include/mach/irqs.h
>> index 31f6bed..51b5db5 100644
>> --- a/arch/arm/mach-exynos4/include/mach/irqs.h
>> +++ b/arch/arm/mach-exynos4/include/mach/irqs.h
>> @@ -154,6 +154,6 @@
>> ?#define IRQ_GPIO_END ? ? ? ? (S5P_GPIOINT_BASE + S5P_GPIOINT_COUNT)
>>
>> ?/* Set the default NR_IRQS */
>> -#define NR_IRQS ? ? ? ? ? ? ? ? ? ? ?(IRQ_GPIO_END)
>> +#define NR_IRQS ? ? ? ? ? ? ? ? ? ? ?(IRQ_GPIO_END + 64)
>
> I applied but basically, we have to avoid using hard coded value like 64 on
> this. The NR_IRQS depends on CPU not board but this change is needed for
> supporting some specific board and if you need more interrupt numbers, will
> you increase it? It is not good way.
>
> We need to fix this up next time.
>
> Thanks.

OK.. Then, what about using "CONFIG_SPARSE_IRQ" and
"irq_alloc_descs()" at board files?

As long as NR_IRQS is large enough to cover all combiners
(IRQ_GPIO_END is large enough in that sense), it appears to be fine
for us (and tested to be ok).


Thank you.
- MyungJoo

>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>



-- 
MyungJoo Ham (???), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
