From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Thu, 30 Jul 2015 01:39:02 -0000
Subject: [PATCH v6 04/13] clk: qcom: gdsc: Manage clocks with !CONFIG_PM
In-Reply-To: <20150730001357.GF3159@codeaurora.org>
References: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org>
 <1437549069-29655-5-git-send-email-rnayak@codeaurora.org>
 <55B03D65.8040207@codeaurora.org> <55B0A764.6010708@codeaurora.org>
 <55B826B0.2090705@codeaurora.org> <55B85870.7060900@codeaurora.org>
 <20150730001357.GF3159@codeaurora.org>
Message-ID: <6e298dc64bccec3aabe4914fd7835129.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 07/29, Rajendra Nayak wrote:
>>
>> On 07/29/2015 06:34 AM, Stephen Boyd wrote:
>> >
>> >Sorry, I read the thread and I tried to understand what was going on
>> but
>> >I'm still lost. Can you clarify further in the commit text somehow?
>>
>> So I can add this in the commit text, if it seems fine
>>
>> "The use of pm_clk_add_notifier() isn't appropriate here since we need
>> to only manage clocks with valid power domain associations done via
>> DT, instead of what pm_clk_add_notifier() does, which is manage clocks
>> for all on SoC/off SoC devices associating all of them to a dummy
>> power domain instead"
>>
>
> Yes that's good, thanks. But I still wonder why the code isn't
> generic so that we don't have lots of drivers duplicating the
> same logic. I guess we can consolidate another day.

Yes, the code is quite generic and probably needs to be some
place so it can be resued across drivers. For now I don;t
see anyone else needing it, maybe sh mobile might plan to use
something like it at a later time which is when we should probably
consolidate.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
