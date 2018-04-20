From: robh@kernel.org (Rob Herring)
Date: Fri, 20 Apr 2018 13:50:27 -0500
Subject: [PATCH 4/9] ARM: dts: bcm2837: Add Raspberry Pi 3 B+
In-Reply-To: <656517811.10338.1524223449795@email.1und1.de>
References: <1523640478-4448-1-git-send-email-stefan.wahren@i2se.com>
 <1523640478-4448-5-git-send-email-stefan.wahren@i2se.com>
 <20180416204331.ft4ehpe5statsw4u@rob-hp-laptop>
 <60625d11-c521-b004-d64c-f72c9c6aac83@i2se.com> <87muy1253i.fsf@anholt.net>
 <656517811.10338.1524223449795@email.1und1.de>
Message-ID: <CAL_JsqKtNP_e2HRB2p03cJGedH2QVXc8+MZYVRNBZrRxVhhzXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2018 at 6:24 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Hi Rob,
>
>> Eric Anholt <eric@anholt.net> hat am 17. April 2018 um 18:02 geschrieben:
>>
>>
>> Stefan Wahren <stefan.wahren@i2se.com> writes:
>>
>> > Hi Rob,
>> >
>> > Am 16.04.2018 um 22:43 schrieb Rob Herring:
>> >> On Fri, Apr 13, 2018 at 07:27:53PM +0200, Stefan Wahren wrote:
>> >>> The Raspberry Pi 3 B+ has the following major differences compared
>> >>> to the model 3 B:
>> >>> * Microchip LAN7515 (Gigabit Ethernet)
>> >>> * Cypress CYW43455 (802.11n/ac and BT 4.2)
>> >>>
>> >>> We need to add the USB LAN chip so the bootloader can add the MAC address.
>> >>> This is necessary because there ain't a EEPROM or a valid OTP.
>> >>>
>> >>> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
>> >>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> >>> ---
>> >>>   arch/arm/boot/dts/Makefile                 |   1 +
>> >>>   arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts | 108 +++++++++++++++++++++++++++++
>> >>>   arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi |  27 ++++++++
>> >>>   3 files changed, 136 insertions(+)
>> >>>   create mode 100644 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
>> >>>   create mode 100644 arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi
>> >>>
>> >>> ...
>> >>> diff --git a/arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi b/arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi
>> >>> new file mode 100644
>> >>> index 0000000..169203c
>> >>> --- /dev/null
>> >>> +++ b/arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi
>> >> Why the separate file? This can be shared?
>> >
>> > this comes from the assumption the RPi 3 B+ won't be the only RPi board
>> > with a LAN7515. Should i fold it in the dts file as long as we don't
>> > have a second board?
>>
>> I think it's great as is -- our other network chips are hooked up this
>> way and it makes 3b+ match all the others.  Also, while I have no
>> specific knowledge, it seems likely that this would get reused.
>
> sorry for my impatience, but what's your opinion?

It's fine as-is.

Rob
