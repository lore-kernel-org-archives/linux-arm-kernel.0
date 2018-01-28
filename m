From: timur@codeaurora.org (Timur Tabi)
Date: Sun, 28 Jan 2018 17:29:59 -0600
Subject: [PATCH] pinctrl: msm: allow the gpio base to be configurable
In-Reply-To: <20180128232310.GA12728@builder>
References: <1516915209-28295-1-git-send-email-timur@codeaurora.org>
 <20180128232310.GA12728@builder>
Message-ID: <042b6cea-38f7-a660-0059-5f24fc7db9eb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/28/18 5:23 PM, Bjorn Andersson wrote:
> What platform has multiple TLMMs?
> 
> [..]

An upcoming one.

>> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
>> index b7b6849625ec..4dc76e15bd14 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
>> @@ -901,7 +901,7 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
>>   		return -EINVAL;
>>   
>>   	chip = &pctrl->chip;
>> -	chip->base = 0;

> My bad, this should have been -1.

Perhaps, but it's been 0 for a very long time, so I don't want to break 
any existing platforms by suddenly relocating all GPIOs across all 
Qualcomm platforms.

What do you think about my other idea?

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
