From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 15 May 2015 19:03:34 +0100
Subject: [PATCH 1/2] ARM: simplify timer initialisation and remove
 arm_timer.h inclusion
In-Reply-To: <554239D5.4080301@arm.com>
References: <1430390662-18246-1-git-send-email-sudeep.holla@arm.com>
 <1430390662-18246-2-git-send-email-sudeep.holla@arm.com>
 <CAL_JsqK8pPLCkrVFHaWr-RhOkPzaF+D_kZ5h9BahvN7CoYZO0w@mail.gmail.com>
 <554239D5.4080301@arm.com>
Message-ID: <555634F6.9060008@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 30/04/15 15:19, Sudeep Holla wrote:
>
>
> On 30/04/15 15:09, Rob Herring wrote:
>> On Thu, Apr 30, 2015 at 5:44 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>> The header asm/hardware/arm_timer.h is included in various machine
>>> specific files to access TIMER_CTRL and initialise to a known state.
>>> However that's not required as the clock{source,event} driver timer-sp
>>> initialises all the timer being used.
>>
>> I believe the idea is not to initialize the timers being used, but the
>> ones not being used and perhaps left running by the bootloader. Cases
>> where the interrupt is shared could cause a problem.
>>

Russell, can you confirm if that's the case ?

>
> Ah OK, makes sense. I will wait for Russell to confirm. The main idea
> was to keep the header file having offsets local to driver/clocksource
> and avoid sharing it in include/linux but looks like that's not possible.
>

Since we need this driver on ARM64, we might have to end up sharing the
header file with offsets if required for ARM platforms(though it would
be good to avoid it if there's any better alternative solution than that)

Regards,
Sudeep
