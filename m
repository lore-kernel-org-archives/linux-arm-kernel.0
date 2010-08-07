From: kmpark@infradead.org (Kyungmin Park)
Date: Sat, 7 Aug 2010 11:30:34 +0900
Subject: [PATCH 1/3] ARM: S5PC210: Use the correct GPIO base addresses
In-Reply-To: <00b401cb356d$13071610$39154230$%kim@samsung.com>
References: <20100806042343.GA19431@july>
	<00b401cb356d$13071610$39154230$%kim@samsung.com>
Message-ID: <AANLkTi=CyZN2Y7joLWmoqaGs51BrxQbwMZSXvTmhJYUm@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 6, 2010 at 10:41 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Kyungmin Park wrote:
>>
>> From: Kyungmin Park <kyungmin.park@samsung.com>
>>
>> The S5PC210 has three GPIO base addresses.
>>
>> Part1 Base Address=0x11400000
>> Part2 Base Address=0x11000000
>> Part3 Base Address=0x03860000
>>
> Yes, maybe missed.
>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> ?arch/arm/mach-s5pv310/include/mach/map.h | ? ?4 +++-
>> ?1 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-s5pv310/include/mach/map.h b/arch/arm/mach-
>> s5pv310/include/mach/map.h
>> index 87697c9..7eb2a7a 100644
>> --- a/arch/arm/mach-s5pv310/include/mach/map.h
>> +++ b/arch/arm/mach-s5pv310/include/mach/map.h
>> @@ -39,8 +39,10 @@
>> ?#define S5PV310_PA_GIC_DIST ? ? ? ? ?(0x10501000)
>> ?#define S5PV310_PA_L2CC ? ? ? ? ? ? ? ? ? ? ?(0x10502000)
>>
>> -#define S5PV310_PA_GPIO ? ? ? ? ? ? ? ? ? ? ?(0x11000000)
>> +#define S5PV310_PA_GPIO ? ? ? ? ? ? ? ? ? ? ?(0x11400000)
>
> S5PV310_PA_GPIO1 is better...

No problem.
>
>> ?#define S5P_PA_GPIO ? ? ? ? ? ? ? ? ?S5PV310_PA_GPIO
>
>> +#define S5PV310_PA_GPIO2 ? ? ? ? ? ? (0x11000000)
>> +#define S5PV310_PA_GPIO3 ? ? ? ? ? ? (0x03860000)
>
>>
>> ?#define S5PV310_PA_UART ? ? ? ? ? ? ? ? ? ? ?(0x13800000)
>>
>> --
>
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
