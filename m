From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Sat, 17 Jul 2010 12:43:42 +0900
Subject: [PATCH v2 2/5] ARM: S5P: Added default pll values for APLL
	800/1000MHz
In-Reply-To: <012f01cb24e1$85628920$90279b60$%kim@samsung.com>
References: <1279267277-6804-1-git-send-email-myungjoo.ham@samsung.com>
	<1279267277-6804-2-git-send-email-myungjoo.ham@samsung.com>
	<1279267277-6804-3-git-send-email-myungjoo.ham@samsung.com>
	<012f01cb24e1$85628920$90279b60$%kim@samsung.com>
Message-ID: <AANLkTil5v3ypu0hZdzVmFCG7MsjQzTKPNgMtJQ-M6MHj@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 16, 2010 at 9:22 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> MyungJoo Ham wrote:
>>
>> CPUFREQ of S5PV210 uses different APLL settings and we provide
>> such values for CPUFREQ at pll.h. We have been using differently
>> between EVT0 and EVT1 machines. Although this version of kernel
>> assumes that the CPU is EVT1, users may use code for EVT0 later.
>>
>> Note that at 1GHz of ARMCLK, APLL should be 1GHz and for other lower
>> ARMCLK, APLL should be 800MHz.
>>
>> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> ?arch/arm/plat-s5p/include/plat/pll.h | ? ?8 ++++++++
>> ?1 files changed, 8 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-s5p/include/plat/pll.h
> b/arch/arm/plat-s5p/include/plat/pll.h
>> index 7db3227..3112aba 100644
>> --- a/arch/arm/plat-s5p/include/plat/pll.h
>> +++ b/arch/arm/plat-s5p/include/plat/pll.h
>> @@ -21,6 +21,14 @@
>>
>> ?#include <asm/div64.h>
>>
>> +#ifdef CONFIG_CPU_S5PC110_EVT0_ERRATA
>
> Actually, EVT0 is not real chip and not for mass production.
> So don't use in here.

That was my point in a thread few days ago when I suggested we
be careful while pushing code upstream.
Rather than flood mainline Samsung support with any hardware
we can get our hands on, we need to strategically select
SoCs (& their versions) and machines so that we have maximum
overlap of features and, equally important, _users_ of that code.
That will help us concentrate our efforts on support needed by most
of the users and devices.
