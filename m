From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 28 Jul 2010 16:25:16 +0900
Subject: S5PC110 should be used the correct VIC number
In-Reply-To: <009d01cb2e1a$29605e80$7c211b80$%kim@samsung.com>
References: <AANLkTikh7mt30gEQU0_Wr7n-jZrG0iUmd1Hw17Ni7UNQ@mail.gmail.com>
	<009d01cb2e1a$29605e80$7c211b80$%kim@samsung.com>
Message-ID: <AANLkTinC_68244EXf2jcEQN8zur8Dff5AcVjA+UTiNPX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 28, 2010 at 3:00 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Kyungmin Park wrote:
>>
>> Hi Ben,
>>
>> Can you post the VIC patch from correct VIC number from vic code at
>> suspend & resume?
>> If not, it has to modify it after release. or can you fix it as below.
>>
> Yeah, you're right.
>
> Already reported by Ben Dooks...but missed that.
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/016872.html

I think ben's patch solves all of problems.

Russell, can you pull it from ben's tree?

Thank you,
Kyungmin Park
>
> Anyway we need updated for ARCH_S5P6442 which has 3 VICs as well as
> ARCH_S5PV210.
>
>> diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
>> index 0a34c81..0ac3d81 100644
>> --- a/arch/arm/common/Kconfig
>> +++ b/arch/arm/common/Kconfig
>> @@ -6,6 +6,7 @@ config ARM_VIC
>>
>> ?config ARM_VIC_NR
>> ? ? ? ? int
>> + ? ? ? default 4 if ARCH_S5PV210
>> ? ? ? ? default 2
>> ? ? ? ? depends on ARM_VIC
>> ? ? ? ? help
>>
>> I hope anyone should be included at this rc window.
>>
> Could you please submit for this?...so I think, Russell can send it to
> upstream before 35 stable.
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
