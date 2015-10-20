From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 20 Oct 2015 09:20:32 +0900
Subject: [PATCH 7/7] ARM: EXYNOS: Remove code for restart and poweroff for
 exynos SoCs
In-Reply-To: <CAGOxZ50nH1UtRrA4nJTvYdsiydNWUvY413gY0q7tRaDFaX_T1Q@mail.gmail.com>
References: <1445234635-3950-1-git-send-email-alim.akhtar@samsung.com>
 <1445234635-3950-8-git-send-email-alim.akhtar@samsung.com>
 <562494F8.6070003@samsung.com> <5624BE39.7020605@osg.samsung.com>
 <CAJKOXPcvKeDNwof5eyD5XjzUiZrHoyShD8gOPGo7uUxEyypQbw@mail.gmail.com>
 <CAGOxZ50nH1UtRrA4nJTvYdsiydNWUvY413gY0q7tRaDFaX_T1Q@mail.gmail.com>
Message-ID: <562588D0.4030404@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.10.2015 01:06, Alim Akhtar wrote:
>>>
>>>> Previously this code was always compiled in for ARCH_EXYNOS. Now it is
>>>> not so I am thinking about selecting necessary drivers from main exynos
>>>> Kconfig symbol. That could be tricky though, because "select" should be
>>>> used only for non-visible symbols.
>>>>
>>>> Any ideas how to solve that?
>>>>
>>>
>>> Is true that select should only be used for non-visible symbols but there
>>> are others user visible symbols that are selected by ARCH_EXYNOS such as
>>> EXYNOS_THERMAL. So I think selecting the regmap syscon reset stuff there
>>> is a sensible option.
>>
>> Selecting from defconfig is not sufficient... since I do not have
>> other idea than selecting then ovak, but Alim please check it whether
>> it does not create circular dependencies on various configs.
>>
> I checked in multi_v7_defconfig SYSCON_RESET is already enabled by
> default. so I doubt we are going to run into any circular
> dependencies, will check again..thanks.

The circular dependency does not happen when some defconfig selects it.
Instead it could happen when some other Kconfig symbol selects such (and
there are more dependencies).

So what I am saying here, after adding "select SYSCON_RESET" in
mach-exynos/Kconfig, please build configs:
1. allyes
2. allmod,
3. multi_v7,
4. (and of course) exynos.

Best regards,
Krzysztof
