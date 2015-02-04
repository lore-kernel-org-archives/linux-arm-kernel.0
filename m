From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 04 Feb 2015 15:36:07 -0800
Subject: [PATCH v4 2/5] clk: iproc: add initial common clock support
In-Reply-To: <54D2AC47.8080201@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
 <1422988390-24369-1-git-send-email-rjui@broadcom.com>
 <1422988390-24369-3-git-send-email-rjui@broadcom.com>
 <54D2A7B7.6020007@codeaurora.org> <54D2AC47.8080201@broadcom.com>
Message-ID: <54D2ACE7.2040305@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/15 15:33, Ray Jui wrote:
>
> On 2/4/2015 3:13 PM, Stephen Boyd wrote:
>> On 02/03/15 10:33, Ray Jui wrote:
>>> +/*
>>> + * Get the clock rate based on name
>>> + */
>>> +static unsigned long __get_rate(const char *clk_name)
>>> +{
>>> +	struct clk *clk;
>>> +
>>> +	clk = __clk_lookup(clk_name);
>>> +	if (!clk) {
>>> +		pr_err("%s: unable to find clock by name: %s\n", __func__,
>>> +				clk_name);
>>> +		return 0;
>>> +	}
>>> +
>>> +	return clk_get_rate(clk);
>>> +}
>>> +
>> This looks like something we should be providing in the core framework.
>> Care to make it into an of_clk_get_parent_rate() API?
>>
> I would love to! Note __get_rate here is really getting the clock rate
> with a name provided. Can you be more specific on what you want? If I'm
> not mistaken, what you really want is this?
>
> unsigned long of_clk_get_parent_rate(struct device_node *np, int index);

Yes that looks good.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
