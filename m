From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 25 Jun 2015 10:56:15 +0530
Subject: [PATCH-v3 2/3] mfd: 88pm800: Allow configuration of interrupt
 clear method
In-Reply-To: <CAJKOXPdqTnkB6Lw4fsJ-=o4=QcYcAtZK0zgOM9aqgesTU=Dw+A@mail.gmail.com>
References: <1435137673-1629-1-git-send-email-vaibhav.hiremath@linaro.org>	<1435137673-1629-3-git-send-email-vaibhav.hiremath@linaro.org>
 <CAJKOXPdqTnkB6Lw4fsJ-=o4=QcYcAtZK0zgOM9aqgesTU=Dw+A@mail.gmail.com>
Message-ID: <558B90F7.80700@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 25 June 2015 05:33 AM, Krzysztof Kozlowski wrote:
> 2015-06-24 18:21 GMT+09:00 Vaibhav Hiremath <vaibhav.hiremath@linaro.org>:
>> As per the spec, bit 1 (INT_CLEAR_MODE) of reg addr 0xe
>> (page 0) controls the method of clearing interrupt
>> status of 88pm800 family of devices;
>>
>>    0: clear on read
>>    1: clear on write
>>
>> This patch allows to configure this field, through DT.
>>
>> Also, as suggested by "Lee Jones" renaming DT property and variable
>> field to appropriate name.
>>
>> Signed-off-by: Zhao Ye <zhaoy@marvell.com>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>
> It does not look like a property of the board. Instead it looks like a
> runtime configuration so it should not be part of DT bindings.
>

Why do you say that?

It is very well feature of 88PM860 device, where you can control irq
clear operation (either read/write).


Thanks,
Vaibhav

> I understand that previously this was configured by platform data and
> now you want to move everything to DT. But this does not belong to
> DT...
>

Thats not completely true.
I think DT is the right place for this configuration.

Thanks,
Vaibhav
