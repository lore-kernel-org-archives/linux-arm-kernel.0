From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 16 Jan 2018 12:02:47 +0530
Subject: [PATCH v5 02/44] clk: davinci: New driver for davinci PLL clocks
In-Reply-To: <d8171267-dc49-e573-ca69-c2b77b44a119@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-3-git-send-email-david@lechnology.com>
 <7fc8bd35-0416-216d-8e1e-53a0ec6e8790@ti.com>
 <d8171267-dc49-e573-ca69-c2b77b44a119@lechnology.com>
Message-ID: <f0a09394-aa44-4a0a-5d5d-ac0d9f8bcb4e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 13 January 2018 07:43 AM, David Lechner wrote:
> On 01/12/2018 03:21 AM, Sekhar Nori wrote:
>> On Monday 08 January 2018 07:47 AM, David Lechner wrote:
>>> +static unsigned long davinci_pll_clk_recalc(struct clk_hw *hw,
>>> +??????????????????????? unsigned long parent_rate)
>>> +{
>>> +??? struct davinci_pll_clk *pll = to_davinci_pll_clk(hw);
>>> +??? unsigned long rate = parent_rate;
>>> +??? u32 prediv, mult, postdiv;
>>> +
>>> +??? prediv = readl(pll->base + PREDIV) & PREDIV_RATIO_MASK;
>>> +??? mult = readl(pll->base + PLLM) & PLLM_MASK;
>>> +??? postdiv = readl(pll->base + POSTDIV) & POSTDIV_RATIO_MASK;
>>
>> Shouldn't we check if the pre and post dividers are enabled before using
>> them?
> 
> I dug into this and the answer is no. The enable bit acts like a gate, not
> a bypass, so it does not affect the rate calculation.

Alright, thanks for checking this.

Regards,
Sekhar
