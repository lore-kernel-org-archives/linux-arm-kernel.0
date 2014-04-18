From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 18 Apr 2014 15:40:44 +0800
Subject: [PATCH v3 02/13] ARM: append ARCH_MULTI_V7_LPAE
In-Reply-To: <5350D1D0.2070906@free-electrons.com>
References: <1397801156-25682-1-git-send-email-haojian.zhuang@linaro.org>
 <1397801156-25682-3-git-send-email-haojian.zhuang@linaro.org>
 <5350CC9B.2090102@free-electrons.com>
 <CAD6h2NR=4-hs7mURUPojLFY+r1t5HyysRG_oRsWhz8HVr_vYog@mail.gmail.com>
 <5350D1D0.2070906@free-electrons.com>
Message-ID: <CAD6h2NQVAKvACysNvrA=7R0BC=X3XWugq9emkYeguARe8=3RNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 April 2014 15:18, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> On 18/04/2014 09:08, Haojian Zhuang wrote:
>> On 18 April 2014 14:56, Gregory CLEMENT
>> <gregory.clement@free-electrons.com> wrote:
>>> Hi Haojian,
>>>
>>> On 18/04/2014 08:05, Haojian Zhuang wrote:
>>>> Add new ARCH_MULTI_V7_LPAE config. It will select ARM_LPAE only both
>>>> ARCH_MULTI_V6 & ARCH_MULTI_V7 is disabled.
>>>>
>>>> ARCH_MULTI_V7 means non-LPAE platform.
>>>>
>>>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>>>> ---
>>>>  arch/arm/Kconfig               | 9 ++++++++-
>>>>  arch/arm/mach-berlin/Kconfig   | 2 +-
>>>>  arch/arm/mach-highbank/Kconfig | 2 +-
>>>>  arch/arm/mach-mvebu/Kconfig    | 6 +++---
>>>>  arch/arm/mach-omap2/Kconfig    | 4 ++--
>>>>  arch/arm/mach-qcom/Kconfig     | 2 +-
>>>>  arch/arm/mach-shmobile/Kconfig | 2 +-
>>>>  arch/arm/mach-tegra/Kconfig    | 2 +-
>>>>  arch/arm/mach-vexpress/Kconfig | 2 +-
>>>>  9 files changed, 19 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>>> index ab438cb..9a2214e 100644
>>>> --- a/arch/arm/Kconfig
>>>> +++ b/arch/arm/Kconfig
>>>> @@ -918,12 +918,19 @@ config ARCH_MULTI_V6
>>>>       select CPU_V6K
>>>>
>>>>  config ARCH_MULTI_V7
>>>> -     bool "ARMv7 based platforms (Cortex-A, PJ4, Scorpion, Krait)"
>>>> +     bool "ARMv7 non-LPAE based platforms (Cortex-A5/A8/A9, PJ4, Scorpion)"
>>> Actually some PJ4B are also non LPAE capable
>>>
>>>
>>>>       default y
>>>>       select ARCH_MULTI_V6_V7
>>>>       select CPU_V7
>>>>       select HAVE_SMP
>>>>
>>>> +config ARCH_MULTI_V7_LPAE
>>>> +     bool "ARMv7 LPAE based platforms (Cortex-A7/A12/A15/A17, Brahma-B15, PJ4B, Krait)"
>>> Only Armada XP is LPAE capable, and and the CPU is not a "simple" PJ4B
>>> but a PJ4B-MP
>>
>> Do you mind that I append CPU_PJ4B_MP?
>
> Currently we make no difference in the code between PJ4B and PJ4B-MP.
> Moreover the ARCH_MULTI_V7_LPAE vs ARCH_MULTI_V7 si done by SoC not by
> CPU.
>
> Maybe I missed something, what is your proposal?
>

Since they're same between PJ4B & PJ4B-MP, I shouldn't append a new PJ4B_MP.

I'll only use both ARCH_MULTI_V7 & ARCH_MULTI_V7_LPAE as the
precondition on ARMADA_XP. I'll keep ARCH_MULTI_V7 as the precondition
on other armada chips in mach-berlin directory.

So when multi_v7_lpae_defconfig is appended, only ARMADA_XP is built
from mach-berlin directory. Is it OK?

Regards
Haojian
