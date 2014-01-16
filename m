From: olof@lixom.net (Olof Johansson)
Date: Thu, 16 Jan 2014 13:52:17 -0800
Subject: How to support SDIO wifi/bt in DT
In-Reply-To: <74872027.r5ouCtzAgs@wuerfel>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
 <3215037.8HVCjAeS8g@wuerfel>
 <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
 <74872027.r5ouCtzAgs@wuerfel>
Message-ID: <CAOesGMg1mkb=Jw0fbeJo5oRGoTnW2XJ2=xZrJeJY66=7sxb5LA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 1:46 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 16 January 2014 09:15:17 Olof Johansson wrote:
>>
>> > b) We need to add a way to attach a device_node to an sdio_func,
>> > so that a function driver can find additional DT properties.
>> > This part should be relatively simple once (a) is done and
>> > should only need a little code but no new binding. The code
>> > would be similar to what we do for amba, i2c or spi devices.
>>
>> This isn't actually needed for this functionality, but might be needed
>> for other things...
>>
>
> There is at least one sdio driver (cw1200) that needs to get
> a MAC address from DT and has the same kind of hack that
> you mention to work around it at the moment (actually worse,
> it's not even using auxdata). The MAC address is certainly
> a property of the device, not the host. This is of course
> the same problem that we have on various development boards
> with USB ethernet controllers lacking an EEPROM.

Yeah, definitely overlap with the on-board usb ethernet adapters where
the vendor hasn't bothered with an eeprom.

> Getting the device to probe in the first place is more important,
> and this is a much simpler problem though.

Yes, agreed -- both needs solving but they're separate issues.


-Olof
