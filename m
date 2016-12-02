From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Fri, 02 Dec 2016 22:32:07 +0800
Subject: [PATCH v2 2/3] ARM: dts: sunxi: add support for Orange Pi Zero
 board
In-Reply-To: <efb30303-b9bb-7a7c-4478-af485991dd86@redhat.com>
References: <20161121162421.800-1-icenowy@aosc.xyz>
 <20161121162421.800-2-icenowy@aosc.xyz> <5373671480239408@web31m.yandex.ru>
 <cdfd3c65-d473-badb-ea6a-035f7ab79217@arm.com>
 <20161201093619.gs6lmoxtlptp2jr6@lukather>
 <11498641480688550@web2g.yandex.ru>
 <efb30303-b9bb-7a7c-4478-af485991dd86@redhat.com>
Message-ID: <11535601480689127@web2g.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



02.12.2016, 22:30, "Hans de Goede" <hdegoede@redhat.com>:
> Hi,
>
> On 02-12-16 15:22, Icenowy Zheng wrote:
>> ?01.12.2016, 17:36, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
>>> ?On Mon, Nov 28, 2016 at 12:29:07AM +0000, Andr? Przywara wrote:
>>>> ??> Something more interesting happened.
>>>> ??>
>>>> ??> Xunlong made a add-on board for Orange Pi Zero, which exposes the
>>>> ??> two USB Controllers exported at expansion bus as USB Type-A
>>>> ??> connectors.
>>>> ??>
>>>> ??> Also it exposes a analog A/V jack and a microphone.
>>>> ??>
>>>> ??> Should I enable {e,o}hci{2.3} in the device tree?
>>>>
>>>> ??Actually we should do this regardless of this extension board. The USB
>>>> ??pins are not multiplexed and are exposed on user accessible pins (just
>>>> ??not soldered, but that's a detail), so I think they qualify for DT
>>>> ??enablement. And even if a user can't use them, it doesn't hurt to have
>>>> ??them (since they are not multiplexed).
>>>
>>> ?My main concern about this is that we'll leave regulators enabled by
>>> ?default, for a minority of users. And that minority will prevent to do
>>> ?a proper power management when the times come since we'll have to keep
>>> ?that behaviour forever.
>>
>> ?I think these users can add a 'fdt set /xxx/xxx status "disabled" ' .
>
> I don't think that will be necessary I'm pretty sure these extra usb
> ports do not have a regulator for the Vbus, they just hook directly
> to the 5V rail, can someone with a schematic check ?

We seems to have still no schematics for the add-on board.

But something is sure is that there's no any regulator-related pins
on the add-on pinout. There's only USB DM and DP pins.

So the Vbus must be directly connected to +5V.

>
> Regards,
>
> Hans
