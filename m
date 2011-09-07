From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Wed, 7 Sep 2011 11:01:33 +0530
Subject: [PATCH v6 00/25] gpio/omap: driver cleanup and fixes
In-Reply-To: <87bouxz21m.fsf@ti.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<87bouxz21m.fsf@ti.com>
Message-ID: <CAC83ZvLMXknFVjJsBAQHub=SRJ5hU9GWbLzAEHcT+vRgAPrOnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 7, 2011 at 4:55 AM, Kevin Hilman <khilman@ti.com> wrote:
> Hi Tarun,
>
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> This series is continuation of cleanup of OMAP GPIO driver and fixes.
>> The cleanup include getting rid of cpu_is_* checks wherever possible,
>> use of gpio_bank list instead of static array, use of unique platform
>> specific value associated data member to OMAP platforms to avoid
>> cpu_is_* checks. The series also include PM runtime support.*
>
> I tested this series on top of v3.1-rc4 using a 3430/n900 platform.
>
> During suspend the PER powerdomain does not hit the targetted power
> state. ?Also, in idle PER never hits retention.
>
> As with previous versions of this series, it appears to be related to
> debounce clocks being left enabled. ?On my n900, I removed debounce from
> all the GPIO keys pads and PER was then able to hit retention during
> suspend and idle.
In this series the debounce clock is turned off and it should have worked.

>
> Please be sure to test on a platform that is using debounce, or modify
> the board file for one of the platforms your testing so that at least
> one of the GPIOs has debounce enabled so you are verifying the debounce
> clock gating during suspend and idle.
Yes, I will setup a system for testing debounce clock gating.

>
> Thanks,
>
> Kevin
>
>
>
>
