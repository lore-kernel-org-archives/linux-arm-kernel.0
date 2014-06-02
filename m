From: ml.lawnick@gmx.de (Michael Lawnick)
Date: Mon, 02 Jun 2014 16:29:45 +0200
Subject: [PATCH] i2c: Make I2C ID tables non-mandatory for DT'ed and/or
 ACPI'ed devices
In-Reply-To: <CACRpkdZvyfA0aaJe3YuevXfA2pTZLRPZ3mQpitL6qD7=qE0Xyg@mail.gmail.com>
References: <1401452797-29521-1-git-send-email-lee.jones@linaro.org>	<1401452797-29521-2-git-send-email-lee.jones@linaro.org>	<20140530123656.GC2742@katana>	<20140530133405.GB29731@lee--X1>	<20140530174800.GA4917@katana>	<20140530192516.GA4319@lee--X1>	<20140531134805.GA3287@katana>
 <CACRpkdZvyfA0aaJe3YuevXfA2pTZLRPZ3mQpitL6qD7=qE0Xyg@mail.gmail.com>
Message-ID: <538C8A59.2070907@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 02.06.2014 14:16, schrieb Linus Walleij:
> On Sat, May 31, 2014 at 3:48 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>>
>>> Right, I read the function which provides the functionality, but my
>>> point is; I don't think my patch changes the semantics in a way which
>>> would adversely affect this option.  If you think that it does, can you
>>> specify how please?
>>
>> Currently, if a driver would be DT only and does not provide a seperate
>> i2c_device_id table, then the driver is unusable with method 4. I don't
>> like to have some drivers being capable of it and some not.
>>
>>> Does the sysfs method create a i2c_device_id table?  If not, how does
>>> it probe successfully pre-patch?
>>
>> The sysfs method creates a device. Its name is matched against
>> i2c_device_ids only since it does not have a node pointer for DT to be
>> matched against.
>
> Is this really so useful on embedded systems?
>
> I was under the impression that this method was something used
> on say PC desktops with temperature monitors and EEPROMs
> on some I2C link on the PCB, usage entirely optional and fun
> for userspace hacks.
>
We use it for dynamic instantiating whole subsystems with multiplexers, 
sensors, controllers in an embedded system. The device list is taken 
from an I2C eeprom which gets read on hotplug.

KR
Michael
