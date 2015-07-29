From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 28 Jul 2015 18:04:48 -0700
Subject: [PATCH v6 04/13] clk: qcom: gdsc: Manage clocks with !CONFIG_PM
In-Reply-To: <55B0A764.6010708@codeaurora.org>
References: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org>
 <1437549069-29655-5-git-send-email-rnayak@codeaurora.org>
 <55B03D65.8040207@codeaurora.org> <55B0A764.6010708@codeaurora.org>
Message-ID: <55B826B0.2090705@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2015 01:35 AM, Rajendra Nayak wrote:
> []..
>
>>> +
>>> +#ifndef CONFIG_PM
>>> +static void enable_clock(struct device *dev, const char *con_id)
>>> +{
>>> +    struct clk *clk;
>>> +
>>> +    clk = clk_get(dev, con_id);
>>> +    if (!IS_ERR(clk)) {
>>> +        clk_prepare_enable(clk);
>>> +        clk_put(clk);
>>> +    }
>>> +}
>>> +
>>> +static void disable_clock(struct device *dev, const char *con_id)
>>> +{
>>> +    struct clk *clk;
>>> +
>>> +    clk = clk_get(dev, con_id);
>>> +    if (!IS_ERR(clk)) {
>>> +        clk_disable_unprepare(clk);
>>> +        clk_put(clk);
>>> +    }
>>> +}
>>
>> Is there a reason why this whole patch isn't generic code? I recall some
>> discussion but I forgot now and there isn't any mention of why this
>> isn't generic code in the commit text.
>
> If by generic code, you mean using PM clocks, then this thread should
> give some context..
> http://www.spinics.net/lists/arm-kernel/msg414072.html

Sorry, I read the thread and I tried to understand what was going on but 
I'm still lost. Can you clarify further in the commit text somehow?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
