From: tsoni@codeaurora.org (Trilok Soni)
Date: Thu, 05 Apr 2012 15:05:02 +0530
Subject: [PATCH 2/9] ARM: OMAP2+: SmartReflex: move the driver specific
 macros in include/linux/power
In-Reply-To: <CAORVsuVt5uj5NAsqsce+7f=xMXC9-nck5cPUCOEC8QP3VkxYyA@mail.gmail.com>
References: <1332173578-27422-1-git-send-email-j-pihet@ti.com>
 <1332173578-27422-3-git-send-email-j-pihet@ti.com>
 <4F7C9C89.9080605@codeaurora.org> <4F7CA3E1.2050809@ti.com>
 <4F7D4165.2060101@codeaurora.org>
 <CAORVsuVt5uj5NAsqsce+7f=xMXC9-nck5cPUCOEC8QP3VkxYyA@mail.gmail.com>
Message-ID: <4F7D6746.9020504@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

>
> The initial motivation is to provide a generic framework for this type
> of drivers, by cleaning up the current OMAP code and by providing as
> much generic code as possible.
>
> Cf. the patch sets I submitted before this very one:
> - the SR code clean-up [1], which is needed to make the code ready for
> the integration of new features,
> - the SR class support [2], which is needed for new SR classes to be
> implemented.
>
>  From the maintainer point of view it made more sense to move the code
> before cleaning it up and so it should happen before [1] and [2].
> The result is that [1] and [2] will need to be rebased when the move
> is accepted and merged in.
>
> [1] http://marc.info/?l=linux-omap&m=133055488908132&w=2
> [2] http://marc.info/?l=linux-omap&m=133163445926544&w=2

I am going through your patches and including some wiki pages. I 
understand the SR can be connected in two ways - intelligent and dumb :)
For intelligent I mean you just configure SR and it will and program 
PMIC, whereas in dumb scenarios application processor gets the 
notification and then it goes and writes into PMIC based on some 
floor/ceiling values. In the first case not much of apps. s/w but in the 
later case whole lot.

>
>>>
>>> Where will you put that otherwise?
>>
>>
>> Couple of suggestions:
>>
>> drivers/platform/omap/avs?
>> drivers/misc/omap/avs?
>>
>> I prefer first one.
> Those paths are for OMAP specific code and not for a generic framework.
>
>>>
>>> IIRC, David Brownell was referring to the rule of three for such case.
>>> Meaning that it worth having a generic fmwk when at least three
>>> different drivers are doing the same kind of things.
>
> Do OMAP v1 and OMAP v2 implementations count as 2 drivers? ;-)
> More seriously, the OMAP code for SmartReflex is far from complete in
> mainline. There is a plan to provide the following features:
> - OMAP v1 IP,
> - OMAP v2 IP,
> - class 1.5,
> - class 3,
> - class 3.5,
> - and more support for the upcoming chipsets.

I don't understand much of these versions right now, but hopefully after 
going through all these docs. My only contention point is to not create 
any directory into the drivers/power, unless it is generic fwk and then 
build up "client" drivers on top of it. Meanwhile we could move this 
driver into above options as I have suggested.

---Trilok Soni

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
