From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 06 Nov 2015 09:18:17 +0900
Subject: [PATCH v3 0/7] samsung: pmu: split up SoC specific PMU data
In-Reply-To: <563AE8C3.9000001@samsung.com>
References: <1445864143-25695-1-git-send-email-pankaj.dubey@samsung.com>
 <5638168A.8060500@samsung.com> <563AE8C3.9000001@samsung.com>
Message-ID: <563BF1C9.102@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.11.2015 14:27, Pankaj Dubey wrote:
> Hi Krzysztof,
> 
> On Tuesday 03 November 2015 07:36 AM, Krzysztof Kozlowski wrote:
>> On 26.10.2015 21:55, Pankaj Dubey wrote:
>>> This patch series is a part of continuation work from following series
>>> [1] and [2].
>>>
>>> 1: exynos: Move pmu driver to driver/soc folder and add exynos7 support
>>>     http://www.spinics.net/lists/linux-samsung-soc/msg39797.html from
>>> Amit Daniel Kacchap
>>> 2: soc: samsung: pmu: split up SoC specific PMU data
>>>     https://lkml.org/lkml/2015/1/7/12 from me
>>>
>>
>> +Cc Bartlomiej,
>>
>> There were some concerns for previous versions of this patchset. I
>> cannot find all of them (e.g. Bartlomiej's are not present on lkml.org
>> anymore) so I am not sure if they were addressed properly.
>>
> 
> Yes. If I recall correctly he has following main concerns:
> 1: To convert exynos-pmu to a proper platform driver before moving out
> of arch/arm/mach-exynos. This is already addressed.
> 
> 2: Do we really need common driver for both ARM and ARM64? I feel yes,
> as at least I can see that driver's basic structure will be reused. As
> in case of PMU driver most of lines of code is data part (register
> offset and its values in different mode), that part will be kept in
> separate file e.g. exynos7-pmu.c or exynosXXXX-pmu.c.
> There has been already one attempt of submission for exynos7 PMU driver at:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/305418.html
> 
> 
> 3: He had a concern that in case of ARM64 build most of ARM related code
> will be present in binary which will be dead code, that can be addressed
> by excluding ARM based SoC exynosXXXX-pmu.c file in Makefile.
> It has been taken care in v3 7/7 patch in drivers/soc/samsung/Makefile.
> 

Sounds reasonable to me. Maybe someone will have other comments but for
me it's okay. When sending next version, please CC linux-pm mailing list
and arm-soc maintainers (Arnd, Olof, Kevin).

Best regards,
Krzysztof
