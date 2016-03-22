From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 21 Mar 2016 20:55:52 -0500
Subject: [PATCH 2/2] serial: amba-pl011: complete support to ZTE uart
In-Reply-To: <CABymUCNKOgdLBLr2fZ4KhwmG+R4Zm-LHnfDppV-yiwUjRH4Nyg@mail.gmail.com>
References: <1457920282-14823-1-git-send-email-jun.nie@linaro.org>
 <1457920282-14823-2-git-send-email-jun.nie@linaro.org>
 <56F05C16.1030805@codeaurora.org>
 <CABymUCNKOgdLBLr2fZ4KhwmG+R4Zm-LHnfDppV-yiwUjRH4Nyg@mail.gmail.com>
Message-ID: <56F0A628.2080607@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jun Nie wrote:
> 2016-03-22 4:39 GMT+08:00 Timur Tabi <timur@codeaurora.org>:
>> Jun Nie wrote:
>>>
>>> @@ -2570,9 +2608,17 @@ static int pl011_uart_plat_probe(struct
>>> platform_device *pdev)
>>>          if (!uap)
>>>                  return -ENOMEM;
>>>
>>> +       uap->clk = devm_clk_get(&pdev->dev, NULL);
>>> +       if (IS_ERR(uap->clk))
>>> +               return PTR_ERR(uap->clk);
>>> +
>>
>>
>> I don't this is supposed to be part of your patch, and it breaks my ACPI
>> platform anyway.  Where did it come from?
>>
> Is it OK to move to device tree part, I mean if (pdev->dev.of_node)
> clause? It is part of my patch, I am not aware ACPI requirement on
> this.

But this is not restricted to the ZTE platform.  Your patch says, 
"compete support to ZTE uart" (maybe you should reword that to "add 
support for ZTE UARTs").  However, this change affects ALL platforms. 
If you move it to the device tree part, it will affect ALL device tree 
platforms.  That's not "adding ZTE support".

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
