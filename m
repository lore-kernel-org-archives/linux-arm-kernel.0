From: sricharan@codeaurora.org (Sricharan R)
Date: Thu, 26 Mar 2015 14:06:01 +0530
Subject: [PATCH 2/6] i2c: qup: Add V2 tags support
In-Reply-To: <1427355110.7093.1.camel@mm-sol.com>
References: <1426268992-19298-1-git-send-email-sricharan@codeaurora.org>	
 <1426268992-19298-3-git-send-email-sricharan@codeaurora.org>	
 <1427286263.25053.18.camel@mm-sol.com> <55139CD4.5040100@codeaurora.org>
 <1427355110.7093.1.camel@mm-sol.com>
Message-ID: <5513C4F1.4080602@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Ivan,

On 03/26/2015 01:01 PM, Ivan T. Ivanov wrote:
> Hi Sricharan,
>
> On Thu, 2015-03-26 at 11:14 +0530, Sricharan R wrote:
>>
>>>> +       if (msg->flags & I2C_M_RD)
>>>> +               qup->rx_tag_len = (qup->blocks << 1);
>>>
>>> here again.
>>>
>> hmm, why not shift ?
>
> Because it makes reading code harder and because compiler
>   is smart enough to choose appropriate instruction for
> underling CPU architecture.
>
ok.
>>>> +       else
>>>> +               qup->rx_tag_len = 0;
>>>> +}
>>>> +
>>>> +static u32 qup_i2c_xfer_data(struct qup_i2c_dev *qup, int len,
>>>> +                                                               u8 *buf, int last)
>>>> +{
>>>
>>> I think that xfer is too vague in this case, prefer write or send.
>>>
>> ok. Will change it to send.
>>>> +       static u32 val, idx;
>>>
>>> static? please fix.
>>    That was intentional. Using to pack tag and data in to one word across
>>    two calls. So preserving val, idx across calls.
>
> Sorry this is no go! Reorganize the code, please.
>
Ok, will change this function.

Regards,
  Sricharan
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of Code Aurora Forum, hosted by The Linux Foundation
