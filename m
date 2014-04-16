From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 16 Apr 2014 10:10:15 +0200
Subject: [PATCH v8 1/3] ARM: EXYNOS: initial board support for exynos5260
 SoC
In-Reply-To: <CAK9yfHztqGWhUJ=PNc7L-epu48PkEM6=v6JFDZ1n52NBeOUB8w@mail.gmail.com>
References: <1397620738-14431-1-git-send-email-rahul.sharma@samsung.com>	<1397620738-14431-2-git-send-email-rahul.sharma@samsung.com>	<534E3803.5010404@gmail.com>
 <CAK9yfHztqGWhUJ=PNc7L-epu48PkEM6=v6JFDZ1n52NBeOUB8w@mail.gmail.com>
Message-ID: <534E3AE7.10907@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16.04.2014 10:08, Sachin Kamat wrote:
> Hi Tomasz,
>
> On 16 April 2014 13:27, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> Hi Rahul,
>>
>>
>> On 16.04.2014 05:58, Rahul Sharma wrote:
>>>
>>> From: Pankaj Dubey <pankaj.dubey@samsung.com>
>>>
>>> This patch add basic arch side support for exynos5260 SoC.
>>>
>>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>>> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
>>> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
>>> ---
>>>    arch/arm/mach-exynos/Kconfig |    5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
>>> index fc8bf18..bf4ed87 100644
>>> --- a/arch/arm/mach-exynos/Kconfig
>>> +++ b/arch/arm/mach-exynos/Kconfig
>>> @@ -84,6 +84,11 @@ config SOC_EXYNOS5250
>>>          help
>>>            Enable EXYNOS5250 SoC support
>>>
>>> +config SOC_EXYNOS5260
>>> +       bool "SAMSUNG EXYNOS5260"
>>> +       default y
>>> +       depends on ARCH_EXYNOS5
>>> +
>>>    config SOC_EXYNOS5420
>>>          bool "SAMSUNG EXYNOS5420"
>>>          default y
>>>
>>
>> Is this patch necessary now? After Sachin's consolidation series there are
>> no per SoC entries anymore.
>
> Kukjin still wanted individual SoCs to be selectable. Please refer [1].
>
> [1] http://www.spinics.net/lists/devicetree/msg27040.html

I don't think any valid reason was presented there. Features in code 
should not be selected using #ifdef CONFIG_ anymore, so I don't really 
see any reason to not proceed with this consolidation. Olof, Arnd?

Best regards,
Tomasz
