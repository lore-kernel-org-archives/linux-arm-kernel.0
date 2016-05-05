From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Thu, 5 May 2016 23:47:23 +0200
Subject: [PATCH] ARM: BCM5301X: Add DT for Luxul XAP-1510
In-Reply-To: <CACna6ryWGsOwBhhauJTROi2BPbmgGn_4oYnKc-L8-3Joy+5M7g@mail.gmail.com>
References: <1462296501-5209-1-git-send-email-dhaab@luxul.com>
 <572A453E.6010000@gmail.com>
 <CACna6ryWGsOwBhhauJTROi2BPbmgGn_4oYnKc-L8-3Joy+5M7g@mail.gmail.com>
Message-ID: <572BBF6B.8030207@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/2016 12:36 AM, Rafa? Mi?ecki wrote:
> On 4 May 2016 at 20:53, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> On 03/05/16 10:28, Dan Haab wrote:
>>> Luxul XAP-1510 is an AP device based on BCM4708 SoC. It uses flash
>>> memory connected to the SPI controller.
>>
>> Looks fine, except one nit:
>>
>>> diff --git a/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts b/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
>>> new file mode 100644
>>> index 0000000..f4460b5
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
>>> @@ -0,0 +1,67 @@
>>> +/*
>>> + * Broadcom BCM470X / BCM5301X ARM platform code.
>>> + * DTS for Luxul XAP-1510
>>> + *
>>> + * Copyright 2015 Luxul Inc.
>>> + *
>>> + * Licensed under the GNU/GPL. See COPYING for details.
>>
>> The ARM SoC maintainer have been asking to utilize a license which is
>> also BSD compatible, so something along the lines of this one:
>>
>> arch/arm/boot/dts/bcm911360k.dts
>>
>> Do you mind respining the patch to include that kind of license header?
> 
> I wasn't aware of this neither. Shall we re-license existing DTS files
> as well? I'm fine with changing them to BSD compatible.
> 
> I'm a bit confused by using BSD license only. Kernel is licensed under
> GNU GPL version 2 and if there are some BSD compatible modules, they
> use dual licensing model (BSD/GPL). Shouldn't we use BSD/GPL in DTS
> files as well then?
> 

As far as I understand the License part you can take code which is
licensed under BSD license and use it in GPL code because you can comply
with the BSD license and also handle it in a way to be GPL compliant at
the same time. You can also make a change to BSD code and license this
change under the GPL, then the complete code (the old one + your change)
is now GPL.

Are the device tree files licensed under BSD license to make it easier
to integrate them into a proprietary boot loader or what is the purpose?

Hauke
