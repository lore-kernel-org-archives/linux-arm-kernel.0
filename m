From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 8 Dec 2015 19:41:39 +0200
Subject: [4.4-rc][PATCH v2] ARM: dts: am4372: fix clock source for arm twd
 and global timers
In-Reply-To: <5660843E.3000801@ti.com>
References: <1448898998-32749-1-git-send-email-grygorii.strashko@ti.com>
 <20151203163551.GQ23396@atomide.com> <5660843E.3000801@ti.com>
Message-ID: <56671653.4030002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony, Felipe, Tero,
On 12/03/2015 08:04 PM, Grygorii Strashko wrote:
> On 12/03/2015 06:35 PM, Tony Lindgren wrote:
>> * Grygorii Strashko <grygorii.strashko@ti.com> [151130 07:58]:
>>> ARM TWD and Global timer are clocked by PERIPHCLK which is MPU_CLK/2.
>>> But now they are clocked by dpll_mpu_m2_ck == MPU_CLK and, as result.
>>> Timekeeping core misbehaves. For example, execution of command
>>> "sleep 5" will take 10 sec instead of 5.
>>>
>>> Hence, fix it by adding mpu_periphclk ("fixed-factor-clock") and use
>>> it for clocking ARM TWD and Global timer (same way as on OMAP4).
>>>
>>> Cc: Tony Lindgren <tony@atomide.com>
>>> Cc: Felipe Balbi <balbi@ti.com>
>>> Cc: Tero Kristo <t-kristo@ti.com>
>>> Fixes:commit 8cbd4c2f6a99 ("arm: boot: dts: am4372: add ARM timers and SCU nodes")
>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>
>> Is this fix alone enough or do you still need to disable other the ARM
>> timers in the board specific dts file?
>>
>
> This one is independent and it's required for -rc, because ARM TWD timer will be selected
> now for am43xx even if http://www.spinics.net/lists/arm-kernel/msg459649.html
> is not merged yet ;) in case of omap2plus_defconfig build.
>
>

Are there any comments objection?
Could this patch be merged as part of -rc cycle?

-- 
regards,
-grygorii
