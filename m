From: andy.green@linaro.org (Andy Green)
Date: Fri, 29 Jun 2012 21:59:02 +0800
Subject: [PATCH 2/3] OMAP2+ devices add mac address allocation register api
In-Reply-To: <20120629135559.GH4202@atomide.com>
References: <20120629054404.11091.31289.stgit@build.warmcat.com>
 <4FED7E6A.4090207@linaro.org> <20120629120325.GD4202@atomide.com>
 <201206291345.49878.arnd@arndb.de> <20120629135559.GH4202@atomide.com>
Message-ID: <4FEDB4A6.7040609@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/29/12 21:55, the mail apparently from Tony Lindgren included:
> * Arnd Bergmann <arnd@arndb.de> [120629 06:50]:
>> On Friday 29 June 2012, Tony Lindgren wrote:
>>> * Andy Green <andy.green@linaro.org> [120629 03:12]:
>>>>> 2. Is this really how we want to pass the board generated mac addresses
>>>>>     and other dynamically generated data to the drivers that are device
>>>>>     tree based?
>>>>
>>>> The issue is that both these busses have an async probe, in the case
>>>> of USB stack the maintainer was not interested last year in adding
>>>> platform data.  Maybe it changed but that's my understanding.
>>>
>>> OK, I'd like to hear Arnds comments on the #2 above too as this is
>>> a more generic issue.
>>
>> In case we have a device tree, we should just be using the USB binding
>> to find the specific device node, and add the property there. Then
>> the device driver can use of_get_mac_address() on the usb device itself.
>
> But would you generate the mac address then in the bootloader already?

I'm pretty sure correct answer does not introduce more dependencies on 
bootloader code.

>> I'm not sure what it takes to add the link for the device node in the
>> usb probing code, but my feeling is that it's not too hard.
>>
>> Right now, USB is probed entirely without DT, so the patch is about
>> the best we can do.
>
> Right, but that still assumes a static mac from the bootloader unless
> we do a generic driver as below? Or do you have some other ideas?

What happens without this patch is randomized MAC address assigned by 
Linux in smsc Ethernet case.

-Andy


-- 
Andy Green | TI Landing Team Leader
Linaro.org ? Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  - 
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
