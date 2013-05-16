From: skannan@codeaurora.org (Saravana Kannan)
Date: Thu, 16 May 2013 12:23:12 -0700
Subject: [PATCH v2 1/2] clk: Disable unused clocks after deferred probing
 is done
In-Reply-To: <CAPDyKFqyvfuttH=rGLxBCemgRMq4N3fVktom+RB2wm72NruaDA@mail.gmail.com>
References: <1368124502-18830-1-git-send-email-skannan@codeaurora.org>
 <519461BB.3010209@codeaurora.org>
 <CAPDyKFqyvfuttH=rGLxBCemgRMq4N3fVktom+RB2wm72NruaDA@mail.gmail.com>
Message-ID: <51953220.6060207@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2013 05:55 AM, Ulf Hansson wrote:
> On 16 May 2013 06:34, Saravana Kannan <skannan@codeaurora.org> wrote:
>> On 05/09/2013 11:35 AM, Saravana Kannan wrote:
>>>
>>> With deferred probing, late_initcall() is too soon to declare a clock as
>>> unused. Wait for deferred probing to finish before declaring a clock as
>>> unused. Since deferred probing is done in late_initcall(), do the unused
>>> check to late_initcall_sync.
>>>
>>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>>> ---
>>>    drivers/clk/clk.c |    2 +-
>>>    1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>>> index fe4055f..5ecb64c 100644
>>> --- a/drivers/clk/clk.c
>>> +++ b/drivers/clk/clk.c
>>> @@ -534,7 +534,7 @@ static int clk_disable_unused(void)
>>>
>>>          return 0;
>>>    }
>>> -late_initcall(clk_disable_unused);
>>> +late_initcall_sync(clk_disable_unused);
>
> Without giving this too much thinking... Will boot time be affected
> with this change?
>

No, we are just reordering the steps.

-Saravana


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
