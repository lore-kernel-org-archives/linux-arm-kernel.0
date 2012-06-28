From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 28 Jun 2012 17:08:25 +0200
Subject: RF231 transceiver on at91sam9g20ek board
In-Reply-To: <201206281430.21916.arnd@arndb.de>
References: <CAJmB2rDxv45OP4otn7rmQcpzCvLujKm0j9_OqNW6PoyHuarTLw@mail.gmail.com>
 <201206221834.41869.arnd@arndb.de>
 <CAJmB2rBcRuNe0QfEGoJN1rQnRnr33gyE=nLt3Az=mGEWuR7mCg@mail.gmail.com>
 <201206281430.21916.arnd@arndb.de>
Message-ID: <4FEC7369.3050003@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2012 04:30 PM, Arnd Bergmann :
> On Thursday 28 June 2012, Alexander Smirnov wrote:
>>>
>>> It might not be the problem you are faced with but note that at91
>>> is moving towards probing all devices using the device tree, so
>>> starting with linux-3.4 you should be defining the device in the
>>> at91sam9g20ek.dts file for your board and use the generic
>>> board-dt.c file. The platform_data gets replaced with
>>> calls to of_get_gpio() in that case.
>>
>> Thank you for the reply!
>>
>> Are you going to add SPI section to the device tree in the nearest
>> future or I can do it by myself and send you the patch? The reason is
>> that this week I merged at86rf230 driver to the 'net-next' tree, but
>> it won't work without platform data.
> 
> Jean-Christophe or Nicolas might now what the status is for atmel-spi.
> It seems like it would be trivial to just add the compatible string in
> the atmel-spi driver, which would let us probe all of its child devices
> using DT.

Dear Alexander,

There has been an attempt to move the spi-atmel.c driver to device tree.
You can check the status of the discussion in by searching the message
subjects:

[PATCH 1/4 v4] of_spi: add generic binding support to specify cs gpio
[PATCH 1/4 v5] of_spi: add generic binding support to specify cs gpio

I guess that you can take these patches as examples for moving to device
tree on your AT91 based board (beware you should set pin muxing in your
bootloader).

There is a "work in progress" snapshot of this work in at91 git tree/branch:
git://github.com/at91linux/linux-at91.git   ghnew/j/for-3.5-wip

commit: 5f31f2573e7e9369500118e1b8fd026392fc0982
commit: 93fd57e73502656a139879518b397711cc305c6a

Best regards,
-- 
Nicolas Ferre
