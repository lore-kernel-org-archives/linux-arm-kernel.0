From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 03 Apr 2014 19:01:46 +0800
Subject: [PATCH] arm64: Fix duplicated Kconfig entries again
In-Reply-To: <CAKohpok5KCmR4UYG1ZkGL2TcXqqO7dPJnwGg49ahU-ceL1+wxA@mail.gmail.com>
References: <1395738060-18489-1-git-send-email-hanjun.guo@linaro.org>	<5334078A.9010408@arm.com>	<53341ADF.2050904@linaro.org>	<2765234.k5FCzWzCDz@vostro.rjw.lan>	<533D1D5E.20208@linaro.org>	<CAOh2x=nYWjB+Org6eNjQAT93ZX2DRHNYSJWgWTo8vS2AmdrAbA@mail.gmail.com>	<20140403085120.GB17022@arm.com>	<533D2980.6000903@linaro.org>
 <CAKohpok5KCmR4UYG1ZkGL2TcXqqO7dPJnwGg49ahU-ceL1+wxA@mail.gmail.com>
Message-ID: <533D3F9A.5070001@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-4-3 17:38, Viresh Kumar wrote:
> On 3 April 2014 14:57, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> Great, thanks Viresh to let me know this.
>> Actually I also sent a patch named "arm64: Fix duplicated Kconfig entries
>> again" about one week ago :)
>>
>> https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg612363.html
>>
>> And I think there is still a problem after commit 62d1a3ba - multi-entries
>> for source "kernel/power/Kconfig", so how about the following fix?
> 
> I didn't notice that :)
> 
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index e6e4d37..6085dca 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -317,14 +317,8 @@ config ARCH_SUSPEND_POSSIBLE
>>  config ARM64_CPU_SUSPEND
>>         def_bool PM_SLEEP
>>
>> -endmenu
>> -
>> -menu "CPU Power Management"
>> -
>>  source "drivers/cpuidle/Kconfig"
>>
>> -source "kernel/power/Kconfig"
>> -
>>  source "drivers/cpufreq/Kconfig"
>>
>>  endmenu
>>
>> If it makes sense, I will send out a patch for it.
> 
> We actually need to menu options here,
> menu "Power management options"
> menu "CPU Power Management"
> 
> And so probably you just need to do this:
>> -source "kernel/power/Kconfig"
>> -
> 
> from CPU Power Management options..

Ok, will send out a patch later.

Thanks
Hanjun
