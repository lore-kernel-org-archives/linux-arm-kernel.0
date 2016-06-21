From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 21 Jun 2016 13:39:45 +0200
Subject: [PATCH v6 2/4] power: reset: add reboot mode driver
In-Reply-To: <57691E92.5090205@rock-chips.com>
References: <1458646525-491-1-git-send-email-andy.yan@rock-chips.com>
 <1458646642-591-1-git-send-email-andy.yan@rock-chips.com>
 <CAJKOXPcKzGTAicbsXK-cC9WQT0vBhpSG_q2GCn37+72x2hdhsQ@mail.gmail.com>
 <57691E92.5090205@rock-chips.com>
Message-ID: <57692781.4070506@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2016 01:01 PM, Andy Yan wrote:

(...)

>>> +MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com");
>>> +MODULE_DESCRIPTION("System reboot mode driver");
>>> +MODULE_LICENSE("GPL v2");
>>> diff --git a/drivers/power/reset/reboot-mode.h
>>> b/drivers/power/reset/reboot-mode.h
>>> new file mode 100644
>>> index 0000000..44ed34f
>>> --- /dev/null
>>> +++ b/drivers/power/reset/reboot-mode.h
>>> @@ -0,0 +1,6 @@
>>> +#ifndef __REBOOT_MODE_H__
>>> +#define __REBOOT_MODE_H__
>>> +
>>> +int reboot_mode_register(struct device *dev, int (*write)(int));
>> Documentation would be appreciated. Although it is local header but
>> you decoupled them and you are exporting the function.
> 
>    You want this driver being a module in V9, so you may also want
>  I document this function when a exporting it. Where I should write the
>  documentation, and would you please give me some example?

Follow kernel-doc (kernel-doc-nano-HOWTO.txt). There is an example. Put
the documentation of functions next to them in source file (not header).

Best regards,
Krzysztof
