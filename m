From: zhangfei.gao@linaro.org (zhangfei)
Date: Thu, 29 Aug 2013 09:54:16 +0800
Subject: [PATCH v7 08/11] ARM: hi3xxx: add smp support
In-Reply-To: <20130828171907.GD8607@quad.lixom.net>
References: <1376965873-14431-1-git-send-email-haojian.zhuang@linaro.org>
 <1376965873-14431-9-git-send-email-haojian.zhuang@linaro.org>
 <20130828021211.GF22852@quad.lixom.net>
 <CAMj5BkjJXeYd4Gh2+DKiJo60ftTSf0vnAiApH86+-zdsoVqXog@mail.gmail.com>
 <20130828171907.GD8607@quad.lixom.net>
Message-ID: <521EA9C8.7060607@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-08-29 01:19 AM, Olof Johansson wrote:
> On Wed, Aug 28, 2013 at 07:53:03PM +0800, zhangfei gao wrote:
>> Thanks Olof, will update with your comments.
>>
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>>>> index 3be60c8..4cc5c57 100644
>>>> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>>>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>>>> @@ -8,3 +8,50 @@ Required root node properties:
>>>>   Hi4511 Board
>>>>   Required root node properties:
>>>>        - compatible = "hisilicon,hi3620-hi4511";
>>>> +
>>>> +
>>>> +Hisilicon sctrl resiter
>>>
>>> Resiter seems like odd naming here.
>>>
>>>> +
>>>> +Required properties:
>>>> +- compatible : "hisilicon,sctrl"
>>>> +- reg : Address and size of sysctrl.
>>>
>>> sysctrl or sctrl? sysctrl isn't really too long, might as well use that.
>>>
>>>> +
>>>> +Optional properties:
>>>> +- smp_reg : offset in sysctrl for notifying slave cpu booting
>>>> +             cpu 1, reg;
>>>> +             cpu 2, reg + 0x4;
>>>> +             cpu 3, reg + 0x8;
>>>> +             If reg value is not zero, cpun exit wfi and go
>>>> +- resume_reg : offset in sysctrl for notifying cpu0 when resume
>>>> +- reset_reg : offset in sysctrl for system reset
>>>
>>> Underscores are usually not used in properties, you use dashes instead.
>>>
>>> Anyway, I suggest defining those as the different cells in a regular 'reg'
>>> property instead.
>>
>> Will update with
>>
>> Required properties:
>> - compatible : "hisilicon,sysctrl"
>> - reg : Register address and size
>>
>> Optional properties:
>> - smp-off : offset in sysctrl for notifying slave cpu booting
>>                  cpu 1, reg;
>>                  cpu 2, reg + 0x4;
>>                  cpu 3, reg + 0x8;
>>                  If reg value is not zero, cpun exit wfi and go
>> - resume-off : offset in sysctrl for notifying cpu0 when resume
>> - reboot-off : offset in sysctrl for system reboot
>
> Unabbreviated "offset" would be better than "off" here.

:(
Have updated with off in Haojian's v9, since find such vector in 
/Document/devicetree
Do I need update to offset?
Will update to offset if there are newer version.

>
> Do you even need this in the device tree? Do you have different implementations
> of this IP that has the same programming model but just with a couple of
> different offsets?

Yes, they are different offsets value in hi3716 and hi3620.
Same implementation, only different offset value in different soc.

Thanks
