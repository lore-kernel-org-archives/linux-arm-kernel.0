From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 9 Nov 2015 23:57:31 -0500
Subject: [PATCH V3 2/4] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <20151109182514.GA10896@rob-hp-laptop>
References: <1446958380-23298-1-git-send-email-okaya@codeaurora.org>
 <1446958380-23298-3-git-send-email-okaya@codeaurora.org>
 <563ED8DF.6090307@codeaurora.org> <56400230.8030303@codeaurora.org>
 <20151109182514.GA10896@rob-hp-laptop>
Message-ID: <5641793B.6050902@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/9/2015 1:25 PM, Rob Herring wrote:
> On Sun, Nov 08, 2015 at 09:17:20PM -0500, Sinan Kaya wrote:
>> On 11/8/2015 12:08 AM, Timur Tabi wrote:
>>
>> On 11/8/2015 12:08 AM, Timur Tabi wrote:
>>> Sinan Kaya wrote:
>>>> +    val = val & ~(MAX_BUS_REQ_LEN_MASK << MAX_BUS_WR_REQ_BIT_POS);
>>>> +    val = val | (mgmtdev->max_write_request << MAX_BUS_WR_REQ_BIT_POS);
>>>> +    val = val & ~(MAX_BUS_REQ_LEN_MASK);
>>>> +    val = val | (mgmtdev->max_read_request);
>>>
>>> val &= ~MAX_BUS_REQ_LEN_MASK << MAX_BUS_WR_REQ_BIT_POS;
>>> val |= mgmtdev->max_write_request << MAX_BUS_WR_REQ_BIT_POS;
>>> val &= ~MAX_BUS_REQ_LEN_MASK;
>>> val |= mgmtdev->max_read_request;
>>>
>>>> +static const struct of_device_id hidma_mgmt_match[] = {
>>>> +    { .compatible = "qcom,hidma-mgmt", },
>>>> +    { .compatible = "qcom,hidma-mgmt-1.0", },
>>>> +    { .compatible = "qcom,hidma-mgmt-1.1", },
>>>> +    {},
>>>> +};
>>>
>>> I thought Rob said that he did NOT want to use version numbers in
>>> compatible strings.  And what's the difference between these three
>>> versions anyway?
>>>
>>
>> This was already discussed here.
>>
>> https://lkml.org/lkml/2015/11/2/689
>>
>> The agreement was to use
>
> The suggestion...
>
>> compatible = "qcom,hidma-mgmt-1.1", "qcom,hidma-mgmt-1.0",
>> "qcom,hidma-mgmt";
>
> I don't really want to see 3 generic-ish strings.
>
>> I'll be adding code for v1.1 specifically in the future.
>
> Please drop "qcom,hidma-mgmt" altogether. It is already meaningless.
> Then add the 1.1 compatible when you add the code for it. Hopefully you
> all can decide on part number(s) by then.
>
> Rob
>

OK. I'll only have "qcom,hidma-mgmt-1.0" for now.


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
