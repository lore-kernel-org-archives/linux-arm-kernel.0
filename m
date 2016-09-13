From: eric@anholt.net (Eric Anholt)
Date: Mon, 12 Sep 2016 23:09:30 -0700
Subject: [PATCH 1/8] ARM: dts: bcm283x: Define standard pinctrl groups in
 the gpio node.
In-Reply-To: <7f432ebf-78d9-9089-f79d-d0584de89887@destevenson.freeserve.co.uk>
References: <1473244289-20728-1-git-send-email-kraxel@redhat.com>
 <1473244289-20728-2-git-send-email-kraxel@redhat.com>
 <1628308726.55593.220fafc0-57d9-4317-a72d-0875dfb2d658.open-xchange@email.1und1.de>
 <1473411924.6698.85.camel@redhat.com> <8737l893d2.fsf@eliezer.anholt.net>
 <7f432ebf-78d9-9089-f79d-d0584de89887@destevenson.freeserve.co.uk>
Message-ID: <87bmzse3fp.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave Stevenson <linux-rpi-kernel@destevenson.freeserve.co.uk> writes:

> On 09/09/16 22:20, Eric Anholt wrote:
>> e<#secure method=pgpmime mode=sign>
>> Gerd Hoffmann <kraxel@redhat.com> writes:
>>
>>>    Hi,
>>>
>>>> According to this page [1] the pinctrl group for parallel display interface is
>>>> missing. Is it intended?
>>>>
>>>> [1] - http://elinux.org/RPi_BCM2835_GPIOs
>>> Just an oversight I guess.  Eric?
>>>
>>> Does this look correct?
>>>
>>> +                       dpi_gpio4: dpi_gpio4 {
>>> +                               brcm,pins = <4 5 6 7 8 9 10 11 12 13
>>> +                                            14 15 16 17 18 19 20 21
>>> +                                            22 23 24 25 26 27>;
>>> +                               brcm,function = <BCM2835_FSEL_ALT2>;
>>> +                       };
>> For DPI, you also need pins 0-3 in there for clock and syncs.
>>
>> That set of data pins would be for a 24-bit mode, which is what we
>> should be using for the Adafruit kippah + 7" panel combo.
> The Kippah is only 18bit, RGB666.
> https://www.adafruit.com/products/2454
> "The pins used are GPIO 2 through 21 inclusive. That means you don't get 
> the UART RX/TX pins (no console cable) and you don't get the standard 
> user I2C pins, the EEPROM I2C pins, or hardware SPI pins. You do get to 
> use pins #22, #23, #24, #25, #26 and #27, and the USB ports are fine to 
> use too."

I was confused because my pinctrl was set up for 18, but the panel
driver for it is set up for 24.  It looks like 18 is right, so I should
probably correct the panel driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160912/a143f3d2/attachment.sig>
