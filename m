From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Mon, 17 Jun 2013 21:11:56 -0500
Subject: [PATCH 0/2] Fix potential merge conflict for dw_apb_timer_of
In-Reply-To: <51BFABE8.5090504@linaro.org>
References: <1371514129-22801-1-git-send-email-dinguyen@altera.com>
 <51BFABE8.5090504@linaro.org>
Message-ID: <51BFC1EC.50408@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

On 06/17/2013 07:38 PM, John Stultz wrote:
> On 06/17/2013 05:08 PM, dinguyen at altera.com wrote:
>> From: Dinh Nguyen <dinguyen@altera.com>
>>
>> Hi Arnd/Olof,
>>
>> Because of the following patch series that is currently in
>> arm-soc/for-next:
>>
>> 10021488997317d1121505a7ac659124c058efed clocksource: dw_apb_timer_of:
>> use clocksource_of_init
>> 1b4eca0f634be2a99f2baa6c29dfd183590ead3f clocksource: dw_apb_timer_of:
>> select DW_APB_TIMER
>> a8b447f2bbbba737ff4478f498d7f83c75a9461b clocksource: dw_apb_timer_of:
>> add clock-handling
>> a1198f83407ae3421f3f58355a0f296d5ea6249c clocksource: dw_apb_timer_of:
>> enable the use the clocksource as sched clock
>>
>> there will be a merge conflict with:
>>
>> 55a68c23e0a675b2b8ac2656fd6edbf98b78e4c6 dw_apb_timer_of.c: Remove
>> parts that were picoxcell-specific
>>
>> that is currently in John Stultz's tree fortglx/3.11/time.
> 
> :( That one is also in Thomas' tip/timers/core already.
> 
> 
>> The following 2 patches will eliminate the need for the patch in John
>> Stultz's tree. If there is to be merge of the 2 trees, then the
>> patch:
>>
>> dw_apb_timer_of.c: Remove parts that were picoxcell-specific
>>
>> can be removed from John's tree to avoid a merge-conflict.
>>
>> Based on arm-soc/for-next:
>>
>> PATCH[1/2] - Rename "dw-apb-timer-osc" and "dw-apb-timer-sp" bindings
>> to just
>> "dw-apb-timer"
>> PATCH[2/2] - Fix user/system reporting by fixing read_sched_clock()
> 
> Pavel/Jamie: Can you take a look at these too and make sure these cover
> what you were doing.
> 
> 
> So Dinh, just to get this right, you're wanting me to revert  "Remove
> parts that were picoxcell-specific" and apply your two changes to my tree?

Yes, revert the "Remove parts that were picoxcell-specific". My 2
patches were not based on your tree, so I don't think they can be
applied there. It was based on the arm-soc with the 4 patches in it.

> 
> The other 4 patches above are then fine to go in via arm-soc? Or do I
> need to merge those in too?

The 4 patches are fine in arm-soc. But I'll let Arnd, Olof and yourself
decide on what's best. I just know that Pavel's patch will conflict with
the 4 that are in arm-soc.

Dinh
> 
> thanks
> -john
> 
