From: john.stultz@linaro.org (John Stultz)
Date: Mon, 17 Jun 2013 17:38:00 -0700
Subject: [PATCH 0/2] Fix potential merge conflict for dw_apb_timer_of
In-Reply-To: <1371514129-22801-1-git-send-email-dinguyen@altera.com>
References: <1371514129-22801-1-git-send-email-dinguyen@altera.com>
Message-ID: <51BFABE8.5090504@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17/2013 05:08 PM, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
>
> Hi Arnd/Olof,
>
> Because of the following patch series that is currently in arm-soc/for-next:
>
> 10021488997317d1121505a7ac659124c058efed clocksource: dw_apb_timer_of: use clocksource_of_init
> 1b4eca0f634be2a99f2baa6c29dfd183590ead3f clocksource: dw_apb_timer_of: select DW_APB_TIMER
> a8b447f2bbbba737ff4478f498d7f83c75a9461b clocksource: dw_apb_timer_of: add clock-handling
> a1198f83407ae3421f3f58355a0f296d5ea6249c clocksource: dw_apb_timer_of: enable the use the clocksource as sched clock
>
> there will be a merge conflict with:
>
> 55a68c23e0a675b2b8ac2656fd6edbf98b78e4c6 dw_apb_timer_of.c: Remove parts that were picoxcell-specific
>
> that is currently in John Stultz's tree fortglx/3.11/time.

:( That one is also in Thomas' tip/timers/core already.


> The following 2 patches will eliminate the need for the patch in John
> Stultz's tree. If there is to be merge of the 2 trees, then the
> patch:
>
> dw_apb_timer_of.c: Remove parts that were picoxcell-specific
>
> can be removed from John's tree to avoid a merge-conflict.
>
> Based on arm-soc/for-next:
>
> PATCH[1/2] - Rename "dw-apb-timer-osc" and "dw-apb-timer-sp" bindings to just
> "dw-apb-timer"
> PATCH[2/2] - Fix user/system reporting by fixing read_sched_clock()

Pavel/Jamie: Can you take a look at these too and make sure these cover what you were doing.


So Dinh, just to get this right, you're wanting me to revert  "Remove parts that were picoxcell-specific" and apply your two changes to my tree?

The other 4 patches above are then fine to go in via arm-soc? Or do I need to merge those in too?

thanks
-john
