From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 18 Jan 2018 13:23:08 +0530
Subject: [PATCH v5 11/44] clk: davinci: Add platform information for TI
 DA830 PSC
In-Reply-To: <72abb187-1c84-f307-d4f8-be5403787bac@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-12-git-send-email-david@lechnology.com>
 <91fe16dc-907e-6dbb-c8db-c27561132093@ti.com>
 <4dd36ca7-e41d-58d8-ec8c-787978307943@lechnology.com>
 <86581de6-a982-7a7b-9a83-22c869417211@ti.com>
 <72abb187-1c84-f307-d4f8-be5403787bac@lechnology.com>
Message-ID: <9be7d712-33ae-3e5b-beeb-a14faa51e777@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 January 2018 11:02 PM, David Lechner wrote:
>>>>> +??? clk_register_clkdev(clk_data->clks[3], "gpio", NULL);
>>>>
>>>> This is pretty bad (and no fault of yours) - having a con_id but no
>>>> device name. Can you please make a pre-series which passes NULL con_id
>>>> in gpio-davinci.c?
>>>
>>> I'll give it a try. This is complicated by the fact that the con_id has
>>> made it's way into the device tree bindings. However, I think we can
>>> safely deprecate clock-names = "gpio" in the device tree bindings since
>>> we can make the driver ignore that property to preserve backwards
>>> compatibility.
> 
> Agreed.
> 
>> I don't think this breaks DT-backward compatibility. Passing a NULL
>> con_id in driver should find the clock for that device even if DT entry
>> has clock-names present. As far as I can read clk_find().
>>
>> The less intrusive alternate is to add the GPIO device name in the table
>> here, while keeping the con_id and keeping the driver untouched. The
>> advantage of that is lesser number of dependent patches for this series
>> to go in.
>>
>> Later once CCF conversion has been there in the kernel for one full
>> release and no regressions, these other clean-ups can be done.
> 
> I like this approach.

One downside is that we will have to have clock-names = "gpio" in da850
device-tree too. Since its already present in keystone already, I don't
think adding one more is such a big issue.

Thanks,
Sekhar
