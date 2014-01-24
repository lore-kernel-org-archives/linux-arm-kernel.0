From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 24 Jan 2014 08:46:32 +0800
Subject: [PATCH 18/20] clocksource / acpi: Add macro
 CLOCKSOURCE_ACPI_DECLARE
In-Reply-To: <20140122114616.GB15591@e106331-lin.cambridge.arm.com>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-19-git-send-email-hanjun.guo@linaro.org>
 <201401171521.35940.arnd@arndb.de> <52DCE790.6080809@linaro.org>
 <20140122114616.GB15591@e106331-lin.cambridge.arm.com>
Message-ID: <52E1B7E8.30300@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014?01?22? 19:46, Mark Rutland wrote:
> On Mon, Jan 20, 2014 at 09:08:32AM +0000, Hanjun Guo wrote:
>> On 2014-1-17 22:21, Arnd Bergmann wrote:
>>> On Friday 17 January 2014, Hanjun Guo wrote:
>>>> From: Amit Daniel Kachhap <amit.daniel@samsung.com>
>>>>
>>>> This macro does the same job as CLOCKSOURCE_OF_DECLARE. The device
>>>> name from the ACPI timer table is matched with all the registered
>>>> timer controllers and matching initialisation routine is invoked.
>>> I wouldn't anticipate this infrastructure to be required. Shouldn't all
>>> ARMv8 machines have an architected timer?
>> I not sure of this, could anyone can give some guidance? if only arch
>> timer is available for ARM64, this will make thing very simple.
> All ARMv8 systems should have an architected timer.

Thanks for the clarification :)

>
> However, they may also have other timers (e.g. global timers for use
> when CPUs are in low power states and their local architected timers
> aren't active).

Only arch timer (generic timer) is defined as a table in ACPI 5.0
spec at now, so other timers will not described as table and will
described as device object in DSDT table, so do you think we need
this framework or not?

Thanks
Hanjun
