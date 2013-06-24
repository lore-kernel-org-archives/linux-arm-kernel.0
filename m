From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 24 Jun 2013 15:45:52 -0700
Subject: [PATCHv2 3/6] sched_clock: Make ARM's sched_clock generic for
 all architectures
In-Reply-To: <51C49072.1060700@linaro.org>
References: <1370155183-31421-1-git-send-email-sboyd@codeaurora.org>
 <1370155183-31421-4-git-send-email-sboyd@codeaurora.org>
 <201306211745.57528.arnd@arndb.de> <20130621170523.GA14575@codeaurora.org>
 <51C49072.1060700@linaro.org>
Message-ID: <51C8CC20.3010700@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/13 10:42, John Stultz wrote:
> On 06/21/2013 10:05 AM, Stephen Boyd wrote:
>> On 06/21, Arnd Bergmann wrote:
>>> This causes build failures when doing a simple merge with the arm-soc
>>> tree:
>>>
>>> ==> build/clps711x_defconfig/faillog <==
>>> /git/arm-soc/arch/arm/mach-clps711x/common.c:37:29: fatal error:
>>> asm/sched_clock.h: No such file or directory
>>>   #include <asm/sched_clock.h>
>>>                               ^
>>> ==> build/imx_v6_v7_defconfig/faillog <==
>>> /git/arm-soc/drivers/clocksource/vf_pit_timer.c:15:29: fatal error:
>>> asm/sched_clock.h: No such file or directory
>>>   #include <asm/sched_clock.h>
>>>
>>> How about adding back a temporary arch/arm/include/asm/sched_clock.h
>>> that only contains "#include <linux/sched_clock.h>" so we can change
>>> those two files after the merge and still get a bisectible history?
>>>
>> Sounds fine. John can you add this patch on top?
>
> Thanks. I've queued this and will send it on to Thomas here shortly.

Thanks John. Can you send this off to the tip tree? I think we'll need
to merge tip/timers into arm-soc so I can send the rest of my "kill ARM
local timer API" series through and this patch helps make that more
palatable.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
