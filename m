From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 19 Mar 2013 15:35:33 +0100
Subject: [PATCH 2/2] cpuidle / calxeda: remove redundant Kconfig option
In-Reply-To: <51485876.307@gmail.com>
References: <1363080476-26555-1-git-send-email-daniel.lezcano@linaro.org>
 <1363080476-26555-2-git-send-email-daniel.lezcano@linaro.org>
 <51485876.307@gmail.com>
Message-ID: <514877B5.6080200@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2013 01:22 PM, Rob Herring wrote:
> On 03/12/2013 04:27 AM, Daniel Lezcano wrote:
>> When the CPU_IDLE and the ARCH_HIGHBANK options are set it is
>> pointless to define a new option CPU_IDLE_CALXEDA because it
>> is redundant.
>>
>> The Makefile drivers directory contains a condition to compile
>> the cpuidle drivers:
>>
>> obj-$(CONFIG_CPU_IDLE)          += cpuidle/
>>
>> Hence, if CPU_IDLE is not set we won't enter this directory.
>>
>> This patch removes the useless Kconfig option and replaces the
>> condition in the Makefile by CONFIG_ARCH_HIGHBANK.
> 
> If I have multiple platforms including highbank compiled in, but want to
> disable cpuidle just for highbank, then you can't disable it at compile
> time.

Could you elaborate a bit ? Is it today possible to have multiple
platforms in a single kernel ?

> Also, with my PSCI support patches for highbank, it is no longer
> dependent on ARCH_HIGHBANK which gives us better compile test coverage.




>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/cpuidle/Kconfig  |   10 ----------
>>  drivers/cpuidle/Makefile |    2 +-
>>  2 files changed, 1 insertion(+), 11 deletions(-)
>>
>> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
>> index c4cc27e..234ae65 100644
>> --- a/drivers/cpuidle/Kconfig
>> +++ b/drivers/cpuidle/Kconfig
>> @@ -30,13 +30,3 @@ config CPU_IDLE_GOV_MENU
>>  
>>  config ARCH_NEEDS_CPU_IDLE_COUPLED
>>  	def_bool n
>> -
>> -if CPU_IDLE
>> -
>> -config CPU_IDLE_CALXEDA
>> -	bool "CPU Idle Driver for Calxeda processors"
>> -	depends on ARCH_HIGHBANK
>> -	help
>> -	  Select this to enable cpuidle on Calxeda processors.
>> -
>> -endif
>> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
>> index 0d8bd55..d1aba71 100644
>> --- a/drivers/cpuidle/Makefile
>> +++ b/drivers/cpuidle/Makefile
>> @@ -5,5 +5,5 @@
>>  obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
>>  obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
>>  
>> -obj-$(CONFIG_CPU_IDLE_CALXEDA) += cpuidle-calxeda.o
>> +obj-$(CONFIG_ARCH_HIGHBANK) += cpuidle-calxeda.o
>>  obj-$(CONFIG_ARCH_KIRKWOOD) += cpuidle-kirkwood.o
>>
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
