From: eric@anholt.net (Eric Anholt)
Date: Sat, 24 Sep 2016 10:01:26 +0300
Subject: [PATCH 2/3] gpio: Add a driver for the Raspberry Pi's firmware
 GPIO calls.
In-Reply-To: <CACRpkdbJoM-RbcuoC=7xJyrT3v7p2n9HiidRp1GUw=o43_Fkwg@mail.gmail.com>
References: <20160919161314.25858-1-eric@anholt.net>
 <20160919161314.25858-2-eric@anholt.net>
 <CACRpkda6HpJp97FUAh6yvo-BhiDbAXxzQS9U6uT+jvg6hiB8ag@mail.gmail.com>
 <87mviy92qw.fsf@eliezer.anholt.net>
 <CACRpkdbJoM-RbcuoC=7xJyrT3v7p2n9HiidRp1GUw=o43_Fkwg@mail.gmail.com>
Message-ID: <87lgyh6at5.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> On Fri, Sep 23, 2016 at 3:15 PM, Eric Anholt <eric@anholt.net> wrote:
>> Linus Walleij <linus.walleij@linaro.org> writes:
>>>> diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
>>>> index 3fb357193f09..671ccd00aea2 100644
>>>> --- a/include/soc/bcm2835/raspberrypi-firmware.h
>>>> +++ b/include/soc/bcm2835/raspberrypi-firmware.h
>>>> @@ -73,11 +73,13 @@ enum rpi_firmware_property_tag {
>>>>         RPI_FIRMWARE_GET_DISPMANX_RESOURCE_MEM_HANDLE =       0x00030014,
>>>>         RPI_FIRMWARE_GET_EDID_BLOCK =                         0x00030020,
>>>>         RPI_FIRMWARE_GET_DOMAIN_STATE =                       0x00030030,
>>>> +       RPI_FIRMWARE_GET_GPIO_STATE =                         0x00030041,
>>>>         RPI_FIRMWARE_SET_CLOCK_STATE =                        0x00038001,
>>>>         RPI_FIRMWARE_SET_CLOCK_RATE =                         0x00038002,
>>>>         RPI_FIRMWARE_SET_VOLTAGE =                            0x00038003,
>>>>         RPI_FIRMWARE_SET_TURBO =                              0x00038009,
>>>>         RPI_FIRMWARE_SET_DOMAIN_STATE =                       0x00038030,
>>>> +       RPI_FIRMWARE_SET_GPIO_STATE =                         0x00038041,
>>>
>>> Can you please merge this orthogonally into the rpi tree to ARM SoC?
>>
>> This driver would appear in the rpi downstream tree once we settle the
>> driver here.  Or are you asking me to delay this series until I can get
>> them to pull just a patch extending the set of packets?
>
> Sorry I am not familiar with your development model. I don't know
> about any RPI downstream tree... What I mean is that the patch to
> include/soc/bcm2835/raspberrypi-firmware.h should be merged by
> whoever is maintaining that file, it is not a GPIO file.
>
> If I get an ACK from the maintainer I can take it into the GPIO
> tree.

Oh, people often say "the rpi tree" to mean downstream (currently 4.4).
The maintainer of that file upstream is me, and I was hoping you could
merge through your tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160924/7d45838e/attachment.sig>
