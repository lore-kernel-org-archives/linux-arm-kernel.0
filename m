From: j-keerthy@ti.com (Keerthy)
Date: Fri, 13 Apr 2018 11:46:04 +0530
Subject: [PATCH 08/14] ARM: OMAP2: Add functions to save and restore
 pinctrl context.
In-Reply-To: <20180412141639.GV5700@atomide.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
 <1523505239-16229-9-git-send-email-j-keerthy@ti.com>
 <20180412141639.GV5700@atomide.com>
Message-ID: <26b80d50-efe1-196a-85b0-4ab22f9bda1c@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 12 April 2018 07:46 PM, Tony Lindgren wrote:
> Hi,
> 
> * Keerthy <j-keerthy@ti.com> [180412 03:56]:
>> From: Russ Dill <Russ.Dill@gmail.com>
>>
>> This adds a pair of context save/restore functions to save/restore the
>> state of a set of pinctrl registers. This simplifies some of the AM33XX
>> PM code as some of the pinctrl registers are lost when the per power
>> domain loses power. The pincrtl code can perform the necessary
>> save/restore.
> 
> So where's the patch adding callers to this code?

This series was to get all the additional save/restores needed for the
rtc+ddr mode. Caller patch is in the main patch that implements that
mode that i will be posting once the ground is set.

Based on enable_off_mode being set this function was called only for
rtc+ddr mode.

> 
> If this cannot be done from regular driver suspend/resume calls,
> this probably should be done from cpu_pm notifiers CPU_PM_ENTER and
> CPU_PM_EXIT. We should also do the same for GPIO BTW.

I will look into that. Thanks for suggestion.

> 
> BTW, the subject line is wrong here, it should be "pinctrl" :)

Oops yes that should be pinctrl.

> 
> Regards,
> 
> Tony
> 
