From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 24 Jan 2014 17:19:41 +0800
Subject: [PATCH 18/20] clocksource / acpi: Add macro
 CLOCKSOURCE_ACPI_DECLARE
In-Reply-To: <3140612.0s75qS6VKb@wuerfel>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <52DCE790.6080809@linaro.org>
 <20140122114616.GB15591@e106331-lin.cambridge.arm.com>
 <3140612.0s75qS6VKb@wuerfel>
Message-ID: <52E2302D.5040001@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014?01?22? 22:56, Arnd Bergmann wrote:
> On Wednesday 22 January 2014 11:46:16 Mark Rutland wrote:
>> On Mon, Jan 20, 2014 at 09:08:32AM +0000, Hanjun Guo wrote:
>>> On 2014-1-17 22:21, Arnd Bergmann wrote:
>>>> On Friday 17 January 2014, Hanjun Guo wrote:
>>>>> From: Amit Daniel Kachhap <amit.daniel@samsung.com>
>>>>>
>>>>> This macro does the same job as CLOCKSOURCE_OF_DECLARE. The device
>>>>> name from the ACPI timer table is matched with all the registered
>>>>> timer controllers and matching initialisation routine is invoked.
>>>> I wouldn't anticipate this infrastructure to be required. Shouldn't all
>>>> ARMv8 machines have an architected timer?
>>> I not sure of this, could anyone can give some guidance? if only arch
>>> timer is available for ARM64, this will make thing very simple.
>> All ARMv8 systems should have an architected timer.
>>
>> However, they may also have other timers (e.g. global timers for use
>> when CPUs are in low power states and their local architected timers
>> aren't active).
> But all other timers could be regular platform drivers I suppose. No
> need for special infrastructure for those.

One more information, acpi_early_init() is run before timekeeping_init()
now, and that patch was merged into 3.14-rc1. So we can initialize
timers for scanning the DSDT table, and it also means that timer defined
in DSDT can be initialized early enough.

Thanks
Hanjun
