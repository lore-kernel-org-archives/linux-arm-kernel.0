From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Mon, 14 Jul 2014 20:23:13 +0200
Subject: [PATCH 1/1] ARM: dts: zynq: Add Parallella device tree
In-Reply-To: <CAOesGMjMEiQkrCfYyc6y+s9kst74jAjTghbYvxUJ+9KvPGXj1Q@mail.gmail.com>
References: <1404075022-28745-1-git-send-email-afaerber@suse.de>	<1404075022-28745-2-git-send-email-afaerber@suse.de>	<CAOesGMhKY1Lb+o8AbtFXS5c7SLg2uGt4-oosdro2FMj_+bB6Tw@mail.gmail.com>	<61d660b7-17a9-4817-ba34-40a5c1674d28@BY2FFO11FD032.protection.gbl>
 <CAOesGMjMEiQkrCfYyc6y+s9kst74jAjTghbYvxUJ+9KvPGXj1Q@mail.gmail.com>
Message-ID: <53C42011.5070708@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 14.07.2014 20:12, schrieb Olof Johansson:
> On Tue, Jul 8, 2014 at 4:18 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>> On 06/30/2014 07:15 AM, Olof Johansson wrote:
>>> Hi,
>>>
>>> On Sun, Jun 29, 2014 at 1:50 PM, Andreas F?rber <afaerber@suse.de> wrote:
>>>> This allows to boot the Adapteva Parallella board to serial console.
>>>>
>>>> Cc: Andreas Olofsson <andreas@adapteva.com>
>>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>>>
>>> Nice and clean DTS, just a couple of comments below.
>>>
>>>> diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
>>>> new file mode 100644
>>>> index 0000000..98df66c
>>>> --- /dev/null
>>>> +++ b/arch/arm/boot/dts/zynq-parallella.dts
>>>> @@ -0,0 +1,63 @@
>>>> +/*
>>>> + * Copyright (c) 2014 SUSE LINUX Products GmbH
>>>> + *
>>>> + * Derived from zynq-zed.dts:
>>>> + *
>>>> + *  Copyright (C) 2011 Xilinx
>>>> + *  Copyright (C) 2012 National Instruments Corp.
>>>> + *  Copyright (C) 2013 Xilinx
>>>> + *
>>>> + * This software is licensed under the terms of the GNU General Public
>>>> + * License version 2, as published by the Free Software Foundation, and
>>>> + * may be copied, distributed, and modified under those terms.
>>>> + *
>>>> + * This program is distributed in the hope that it will be useful,
>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>> + * GNU General Public License for more details.
>>>> + */
>>>> +/dts-v1/;
>>>> +/include/ "zynq-7000.dtsi"
>>>> +
>>>> +/ {
>>>> +       model = "Parallella Board";
> 
> You might want to have this say "Adapteva Parallella Board" instead
> (just noticed).
> 
>>>> +       compatible = "xlnx,zynq-7000";
>>>
>>> This should have a more specific compatible as the first one. Probably
>>> something like:
>>>    compatible = "adapteva,parallella", "xlnx,zynq-7000";
>>
>> We were using these compatible properties but later there is no reason
>> to create them because they will be unused.
>> It is easy to add it when you need it which is not this case.
> 
> No, please add it from day one, otherwise everybody needs to update
> their device tree, some will miss doing it, etc, etc. It's a simple
> and trivial thing to do, and no reason to leave it o ut.

OK, I have that prepared already, including the appropriate documentation.

>>>> +
>>>> +       memory {
>>>> +               device_type = "memory";
>>>> +               reg = <0 0x20000000>;
>>>
>>> Does the bootloader update this entry, or is it truly static? If it's
>>> updated then it's become recent habit to leave the memory size empty
>>> in the static file.
>>
>> Depends on your bootloader. I think it is good to have it here.
>> Also this file can be used by u-boot for example and u-boot can be configured
>> from it that's why I think that make sense to keep this here.
> 
> Ok. It's become commonplace to leave memory empty for the machines
> where it's guaranteed that the bootloader will have updated it, to
> avoid having stale or incorrect values in the static tree. I'm not
> going to be strict about it, but it's something to consider.

Will update then, thanks.

Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
