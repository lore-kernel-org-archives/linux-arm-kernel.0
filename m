From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 18 Jul 2014 09:44:35 +0900
Subject: [PATCH v7 0/6] cpufreq: use generic cpufreq drivers for exynos
 platforms
In-Reply-To: <CAJuA9aiVFFZiN7_xBg6iQEX-LJKLMmHKvPhmdmOduouQzBtQJw@mail.gmail.com>
References: <1405345118-4269-1-git-send-email-thomas.ab@samsung.com>
 <CAJuA9ahWbL8v2nS6wuDosn-bi+pga57KUe5wQN14Mot_-RTc6w@mail.gmail.com>
 <CAJuA9aiVFFZiN7_xBg6iQEX-LJKLMmHKvPhmdmOduouQzBtQJw@mail.gmail.com>
Message-ID: <53C86DF3.1040303@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 07/17/2014 02:58 PM, Thomas Abraham wrote:
> Hi Mike,
> 
> On Tue, Jul 15, 2014 at 9:20 AM, Thomas Abraham <ta.omasab@gmail.com> wrote:
>> Hi Tomasz,
>>
>> On Mon, Jul 14, 2014 at 7:08 PM, Thomas Abraham <thomas.ab@samsung.com> wrote:
>>> Changes since v6:
>>> - Fixes suggested by Amit Daniel <amit.daniel@samsung.com>.
>>>
>>> This patch series removes the use of Exynos4210 and Exynos5250 specific cpufreq
>>> drivers and enables the use of cpufreq-cpu0 driver for these platforms. This
>>> series also enabled cpufreq support for Exynos5420 using arm_big_little cpufreq
>>> driver.
>>>
>>> Thomas Abraham (6):
>>>   clk: samsung: add infrastructure to register cpu clocks
>>>   clk: samsung: register exynos5420 apll/kpll configuration data
>>>   clk: exynos: use cpu-clock provider type to represent arm clock
>>>   ARM: dts: Exynos: add cpu nodes, opp and cpu clock configuration data
>>>   ARM: Exynos: switch to using generic cpufreq driver for exynos4210/5250
>>>   cpufreq: exynos: remove exynos4210/5250 specific cpufreq driver support
>>
>> In this series, support for Exynos5420 has been included. If there are
>> any more changes required, could you please let me know.
> 
> This patch series migrates exynos cpufreq support to use generic
> cpufreq drivers. For this, cpu clock blocks are encapsulated into a
> cpu clock type and cpufreq driver operates the cpu clock type.
> 
> We had discussed in the [1] about using coordinated clocks. This
> series is not using the concept of coordinated clocks but the code in
> this series can be migrated to use coordinated clocks when it is
> available.
> 
> Is it okay to consider this series for v3.17-rc1. I will update this
> code to use coordinated clocks when it is available. This series helps
> with cpufreq support for newer Exynos SoCs such as Exynos5420/3250.
> 
> [1] http://www.spinics.net/lists/cpufreq/msg10042.html
> 

I tested this patchset with Exynos3250 cpufreq patchset[1] on Exynos3250 SoC.
 [1] https://lkml.org/lkml/2014/6/18/126

Tested-by: Chanwoo Choi <cw00.choi@samsung.com>

Best Regards,
Chanwoo Choi
