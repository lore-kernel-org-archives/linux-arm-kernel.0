From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 25 Jun 2015 14:50:47 +0900
Subject: [PATCH-v3 2/3] mfd: 88pm800: Allow configuration of interrupt
 clear method
In-Reply-To: <558B9549.5010705@linaro.org>
References: <1435137673-1629-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1435137673-1629-3-git-send-email-vaibhav.hiremath@linaro.org>
 <CAJKOXPdqTnkB6Lw4fsJ-=o4=QcYcAtZK0zgOM9aqgesTU=Dw+A@mail.gmail.com>
 <558B90F7.80700@linaro.org> <558B9272.6090100@samsung.com>
 <558B9549.5010705@linaro.org>
Message-ID: <558B96B7.3030501@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.06.2015 14:44, Vaibhav Hiremath wrote:
> 
> 
> On Thursday 25 June 2015 11:02 AM, Krzysztof Kozlowski wrote:
>> On 25.06.2015 14:26, Vaibhav Hiremath wrote:
>>>
>>>
>>> On Thursday 25 June 2015 05:33 AM, Krzysztof Kozlowski wrote:
>>>> 2015-06-24 18:21 GMT+09:00 Vaibhav Hiremath
>>>> <vaibhav.hiremath@linaro.org>:
>>>>> As per the spec, bit 1 (INT_CLEAR_MODE) of reg addr 0xe
>>>>> (page 0) controls the method of clearing interrupt
>>>>> status of 88pm800 family of devices;
>>>>>
>>>>>     0: clear on read
>>>>>     1: clear on write
>>>>>
>>>>> This patch allows to configure this field, through DT.
>>>>>
>>>>> Also, as suggested by "Lee Jones" renaming DT property and variable
>>>>> field to appropriate name.
>>>>>
>>>>> Signed-off-by: Zhao Ye <zhaoy@marvell.com>
>>>>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>>>>
>>>> It does not look like a property of the board. Instead it looks like a
>>>> runtime configuration so it should not be part of DT bindings.
>>>>
>>>
>>> Why do you say that?
>>>
>>> It is very well feature of 88PM860 device, where you can control irq
>>> clear operation (either read/write).
>>>
>>>
>>> Thanks,
>>> Vaibhav
>>>
>>>> I understand that previously this was configured by platform data and
>>>> now you want to move everything to DT. But this does not belong to
>>>> DT...
>>>>
>>>
>>> Thats not completely true.
>>> I think DT is the right place for this configuration.
>>
>> DT and its bindings describe the specific board or device. Let me quote:
>> <<The "Open Firmware Device Tree", or simply Device Tree (DT), is a data
>> structure and language for describing hardware.  More specifically, it
>> is a description of hardware that is readable by an operating system...>>
>>
>> Whether you clear interrupts by writing or reading is configured during
>> runtime and it is completely independent to wiring. Each board with
>> 88pm800 would allow both methods. So this is not a property of hardware
>> in the terms of open firmware. This is a runtime configuration.
>>
> 
> Yes,
> Fair enough...
> 
> I see very little value in runtime configuration, why not just do it
> only way (either read or write)?
> I would prefer to just set it by default (during init), to clear irq on
> write.

Hard-coding a default value, if board files are not present, looks OK to me.

Best regards,
Krzysztof
