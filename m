From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 01 Feb 2018 08:47:13 +0800
Subject: About testing A64 DE2 patches
In-Reply-To: <8853283d-0efa-c151-257f-86ee54f4a86a@orpaltech.com>
References: <41ed8d45-d8a1-303b-dd1f-ad6686a60ba5@orpaltech.com>
 <250579B6-D23B-4E40-8678-1E3F30FA0A16@aosc.io>
 <8853283d-0efa-c151-257f-86ee54f4a86a@orpaltech.com>
Message-ID: <D5C6CA19-6A9A-4D6E-BF4B-0F420BDFD160@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?2?1? GMT+08:00 ??5:11:17, Sergey Suloev <ssuloev@orpaltech.com> ??:
>On 01/31/2018 08:47 PM, Icenowy Zheng wrote:
>>
>> ? 2018?2?1? GMT+08:00 ??1:42:01, Sergey Suloev
><ssuloev@orpaltech.com> ??:
>>> Hi, kernel people,
>>>
>>> I am testing A64 DE2 patches from the list below, series v4, with my
>>> NanoPi A64 and 4.15
>>>
>>>
>https://patchwork.kernel.org/project/linux-arm-kernel/list/?submitter=173461&page=1
>>>
>>> and I'm getting the following issue regarding SRAM:
>>>
>>> sunxi-de2-clks 1000000.clock: Error couldn't map SRAM to device
>> Could you check whether it's finally probed?
>>
>> DE2 clock may be probed before SRAM controller, so
>> the probe might be deferred. When SRAM controller is ready
>> it will retry.
>>
>>> Here is my full dmesg https://pastebin.com/SQvDfJF0
>>>
>>> Thanks
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>no it is not probed , because there is no special return code from the 
>function

But it receives special return code from sunxi_sram_claim.
 
>
>if (ccu->sram_needed) {
>+ ret = sunxi_sram_claim(&pdev->dev);
>+ if (ret) {
>+ dev_err(&pdev->dev,
>+ "Error couldn't map SRAM to device\n");
>+ return ret;
>+ }
>+ }
