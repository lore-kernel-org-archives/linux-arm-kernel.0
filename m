From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Fri, 16 May 2014 10:37:27 +0530
Subject: [PATCH v5 1/5] ARM: EXYNOS: Add generic cpu power control
 functions for all exynos based SoCs
In-Reply-To: <53752D8C.3030708@gmail.com>
References: <1399307221-8659-1-git-send-email-a.kesavan@samsung.com>
 <1399307221-8659-2-git-send-email-a.kesavan@samsung.com>
 <019b01cf6e52$75e1a710$61a4f530$@samsung.com>
 <CAM4voamSNYZ_hsjF3eZhqZ=FF__39tFgi5FeXRcUhRbYYzu0LQ@mail.gmail.com>
 <53752D8C.3030708@gmail.com>
Message-ID: <CAM4voam1UiX+WaxScTdhb4bW+_1nCcsztFEkx4MyWFOBBjV6XQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Fri, May 16, 2014 at 2:41 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Abhilash,
>
> On 13.05.2014 12:12, Abhilash Kesavan wrote:
>> On Tue, May 13, 2014 at 7:54 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>
> [snip]
>
>>>> diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-
>>>> pmu.h
>>>> index 4f6a256..0bdfcbc 100644
>>>> --- a/arch/arm/mach-exynos/regs-pmu.h
>>>> +++ b/arch/arm/mach-exynos/regs-pmu.h
>>>> @@ -121,6 +121,12 @@
>>>>
>>>>  #define S5P_CHECK_SLEEP                              0x00000BAD
>>>>
>>>> +#define EXYNOS_ARM_CORE0_CONFIGURATION               S5P_PMUREG(0x2000)
>>>
>>> This can be put in order of address.
>> OK, will fix.
>>>
>>>> +#define EXYNOS_ARM_CORE_CONFIGURATION(_nr)   \
>>>> +                     (EXYNOS_ARM_CORE0_CONFIGURATION + (0x80 * (_nr)))
>>>> +#define EXYNOS_ARM_CORE_STATUS(_nr)          \
>>>> +                     (EXYNOS_ARM_CORE_CONFIGURATION(_nr) + 0x4)
>
> My patches posted quite a while ago [1] to fix DT CPU topology already
> add these, remove S5P_ARM_CORE1* and fix corresponding usage in
> hotplug.c and platsmp.c.
>
> [1] http://thread.gmane.org/gmane.linux.kernel.samsung-soc/29573
>
> So I think you should rebase on top of them or at least on top of
> patches 1 and 2 from that series, as 3 and 4 should be dropped.

Patch 2 of your series does not apply on kgene's for-next or
linux-next. Are you planning on re-sending this ?

Regards,
Abhilash
>
> Best regards,
> Tomasz
