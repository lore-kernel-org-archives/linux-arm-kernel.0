From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 25 Aug 2016 17:13:15 +0200
Subject: [PATCH 2/2] ARM: dts: sun8i: enable UART1 for iNet D978 Rev2 board
In-Reply-To: <438381472136802@web24g.yandex.ru>
References: <20160823064451.25997-1-icenowy@aosc.xyz>
 <20160823064451.25997-3-icenowy@aosc.xyz> <20160824193600.GS8103@lukather>
 <43951472083107@web23m.yandex.ru>
 <CAGb2v66tFENk8QBw7D1+bwFN-zWaE2SGDrNyc-zdbJSRzENk4Q@mail.gmail.com>
 <97321472108244@web8m.yandex.ru> <20160825080334.GD7776@lukather>
 <116041472134355@web12g.yandex.ru>
 <6580ba1b-f542-58d4-9f0a-fdd8e9b86092@redhat.com>
 <438381472136802@web24g.yandex.ru>
Message-ID: <235ab6d3-7b9c-631e-80e1-c8e2de868eb0@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

On 25-08-16 16:53, Icenowy Zheng wrote:
>
>
> 25.08.2016, 22:18, "Hans de Goede" <hdegoede@redhat.com>:
>> Hi,
>>
>> On 25-08-16 16:12, Icenowy Zheng wrote:
>>>  25.08.2016, 16:03, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
>>>>  Hi,
>>>>
>>>>  On Thu, Aug 25, 2016 at 02:57:24PM +0800, Icenowy Zheng wrote:
>>>>>   >>>> diff --git a/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts b/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
>>>>>   >>>> index 78823d8..3ac22d4 100644
>>>>>   >>>> --- a/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
>>>>>   >>>> +++ b/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
>>>>>   >>>> @@ -48,6 +48,10 @@
>>>>>   >>>> model = "INet-D978 Rev 02";
>>>>>   >>>> compatible = "primux,inet-d978-rev2", "allwinner,sun8i-a33";
>>>>>   >>>>
>>>>>   >>>> + aliases {
>>>>>   >>>> + serial1 = &uart1;
>>>>>   >>>> + };
>>>>>   >>>> +
>>>>>   >>>
>>>>>   >>> Is there any other UART in the system?
>>>>>   >>
>>>>>   >> serial0 is defined in sun8i-reference-design-tablet.dtsi, as r_uart.
>>>>>   >
>>>>>   > If your board does not have r_uart pads, then the right thing to do
>>>>>   > would be to disable it. You can then have uart1 as serial0.
>>>>>
>>>>>   I don't know it. The RX/TX is wired on PF2/PF4 on the board (UART0 muxed with
>>>>>   MMC)
>>>>
>>>>  Then you don't support it and you need to disable it.
>>>>
>>>>>   But many codes will require a ttyS0 as console... So I think the
>>>>>   bluetooth should be located at ttyS1...
>>>>
>>>>  Most of them would use /dev/console anyway. What do you have in mind?
>>>
>>>  As a general configuration, /dev/ttyS0 will be indicated as the default console=
>>>  value... (Otherwise more boards will fail)
>>>
>>>  Or maybe we can specify uart0 as serial0, and leave it as disabled? (Thus if the
>>>  debug port is needed, we can easily apply a overlay with &mmc0 status as disabled,
>>>  and &uart0 status as okay)
>>>
>>>  On all my A33 boards, the official boot0, u-boot all uses uart0 as debugging port.
>>
>> If no uart is available (and being muxed with the mmc counts as not being available)
>> then you should not have any serial alias in the dts.
>>
>> In u-boot you need to use:
>>
>> # CONFIG_REQUIRE_SERIAL_CONSOLE is not set
>>
>> In the defconfig in this case, otherwise u-boot is going to be unhappy about
>> not having a serial console.
>
> It's not the problem.
>
> Can I have no ttyS0 and just make bluetooth ttyS1?

Ah, yes having a serial1 alias should do that I believe and I agree that it
is probably better to not use ttyS0 for the bluetooth uart.

Regards,

Hans
