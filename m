From: ml.lawnick@gmx.de (Michael Lawnick)
Date: Thu, 12 Jun 2014 11:28:45 +0200
Subject: [PATCH] i2c: Make I2C ID tables non-mandatory for DT'ed and/or
 ACPI'ed devices
In-Reply-To: <CACRpkda3bL=y3Dmkf59LT97Liep=XEzgE3P-YngLeD_w1qcAzQ@mail.gmail.com>
References: <1401452797-29521-1-git-send-email-lee.jones@linaro.org>	<1401452797-29521-2-git-send-email-lee.jones@linaro.org>	<20140530123656.GC2742@katana>	<20140530133405.GB29731@lee--X1>	<20140530174800.GA4917@katana>	<20140530192516.GA4319@lee--X1>	<20140531134805.GA3287@katana>	<CACRpkdZvyfA0aaJe3YuevXfA2pTZLRPZ3mQpitL6qD7=qE0Xyg@mail.gmail.com>	<538C8A59.2070907@gmx.de>	<CACRpkdbo9_xo6j7JBcjiuk6eYkqyaeMYLFsH3VczxotOmVRh1Q@mail.gmail.com>	<538EB81B.3090807@gmx.de>
 <CACRpkda3bL=y3Dmkf59LT97Liep=XEzgE3P-YngLeD_w1qcAzQ@mail.gmail.com>
Message-ID: <539972CD.1010004@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 12.06.2014 09:55, schrieb Linus Walleij:
> On Wed, Jun 4, 2014 at 8:09 AM, Michael Lawnick <ml.lawnick@gmx.de> wrote:
>> Am 03.06.2014 13:18, schrieb Linus Walleij:
>>> On Mon, Jun 2, 2014 at 4:29 PM, Michael Lawnick <ml.lawnick@gmx.de> wrote:
>>>>
>>>> Am 02.06.2014 14:16, schrieb Linus Walleij:
>>>
>>>
>>>>> Is this really so useful on embedded systems?
>>>>>
>>>>> I was under the impression that this method was something used
>>>>> on say PC desktops with temperature monitors and EEPROMs
>>>>> on some I2C link on the PCB, usage entirely optional and fun
>>>>> for userspace hacks.
>>>>>
>>>> We use it for dynamic instantiating whole subsystems with multiplexers,
>>>> sensors, controllers in an embedded system. The device list is taken from
>>>> an
>>>> I2C eeprom which gets read on hotplug.
>>>
>>>
>>> Does this mean that you have stored the names (strings) that are used
>>> by the Linux kernel for identifying the devices into your EEPROM?
>>>
>>> That means that you have made the kernel-internal device driver names
>>> an ABI which is unfortunate :-/
>>>
>>> This is one of the reasons to why we insist on device tree: OS neutral
>>> hardware description.
>>
>> The eeprom contains a device tree that is dynamically merged.
>
> That is a kind of way of saying "yes we made the kernel-internal
> driver named an ABI" I guess?

Sorry, I fear I don't get you. Could you please rephrase?
Of course it might be that I'm missing some fundamental idea of device 
tree. The mechanism we use started with K2.6 where device tree usage on 
MIPS wasn't that intensive. Anyway the original idea of removing 
i2c_table now moved towards non-mandatory usage.

-- 
KR
Michael
