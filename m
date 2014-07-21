From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 21 Jul 2014 05:51:02 -0700
Subject: [PATCH v5 0/7] kernel: Add support for restart handler call chain
In-Reply-To: <20140721123056.GF12817@arm.com>
References: <1405668856-13738-1-git-send-email-linux@roeck-us.net>
 <20140721123056.GF12817@arm.com>
Message-ID: <53CD0CB6.1050803@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 07/21/2014 05:30 AM, Catalin Marinas wrote:
> On Fri, Jul 18, 2014 at 08:34:09AM +0100, Guenter Roeck wrote:
>> Patch 1 of this series implements the restart handler function. Patches 2 and 3
>> implement calling the restart handler chain from arm and arm64 restart code.
>>
>> Patch 4 modifies the restart-poweroff driver to no longer call arm_pm_restart
>> directly but machine_restart. This is done to avoid calling arm_pm_restart
>> from more than one place. The change makes the driver architecture independent,
>> so it would be possible to drop the arm dependency from its Kconfig entry.
>>
>> Patch 5 and 6 convert existing restart handlers in the watchdog subsystem
>> to use the restart handler. Patch 7 unexports arm_pm_restart to ensure
>> that no one gets the idea to implement a restart handler as module.
>
> For the current patches:
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>
> Do you plan to convert more of the power/drivers/reset/ code?
>

Once this series has been accepted, I at least wanted to give it a try.

> BTW, is it worth doing something similar for pm_power_off (there is
> generic code calling it directly, so slightly more complicated than
> pm_restart)?

I have not thought about it yet.

A quick glance suggests it is much more widely used than the reset handler.
It looks like the original idea, like with machine_restart, was to have
one function per architecture, but it seems that is widely abused.

Looks pretty messy to me. Maybe after this one is done, if there is interest
and, more importantly, the need to do something about it.

Thanks,
Guenter
