From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 19 Mar 2013 23:03:20 +0100
Subject: [PATCH 2/2] cpuidle / calxeda: remove redundant Kconfig option
In-Reply-To: <514880AF.7010404@gmail.com>
References: <1363080476-26555-1-git-send-email-daniel.lezcano@linaro.org>
 <1363080476-26555-2-git-send-email-daniel.lezcano@linaro.org>
 <51485876.307@gmail.com> <514877B5.6080200@linaro.org>
 <514880AF.7010404@gmail.com>
Message-ID: <5148E0A8.70208@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2013 04:13 PM, Rob Herring wrote:
> On 03/19/2013 09:35 AM, Daniel Lezcano wrote:
>> On 03/19/2013 01:22 PM, Rob Herring wrote:
>>> On 03/12/2013 04:27 AM, Daniel Lezcano wrote:
>>>> When the CPU_IDLE and the ARCH_HIGHBANK options are set it is
>>>> pointless to define a new option CPU_IDLE_CALXEDA because it
>>>> is redundant.
>>>>
>>>> The Makefile drivers directory contains a condition to compile
>>>> the cpuidle drivers:
>>>>
>>>> obj-$(CONFIG_CPU_IDLE)          += cpuidle/
>>>>
>>>> Hence, if CPU_IDLE is not set we won't enter this directory.
>>>>
>>>> This patch removes the useless Kconfig option and replaces the
>>>> condition in the Makefile by CONFIG_ARCH_HIGHBANK.
>>>
>>> If I have multiple platforms including highbank compiled in, but want to
>>> disable cpuidle just for highbank, then you can't disable it at compile
>>> time.
>>
>> Could you elaborate a bit ? Is it today possible to have multiple
>> platforms in a single kernel ?
> 
> You've heard of single zImage, right? Vexpress, mvebu, highbank, imx,
> omap2+, socfpga, vt8500 off the top of my head as of 3.8.

Yes, I have heard of single zImage but I am not aware of the status.

IIUC, the approach would be the same as cpufreq, right ?

I am not sure the cpuidle drivers are ready for that.

We can keep the current Makefile but I am in favor of removing this
Kconfig option for now, unify as much as possible all the drivers,
create a common driver for all and then address the single zImage for
all these drivers at the same time.



-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
