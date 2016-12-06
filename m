From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 6 Dec 2016 16:06:40 +0100
Subject: [PATCH v3 1/2] ARM: dts: da850-lcdk: add the dumb-vga-dac node
In-Reply-To: <e6d7870b-e9fd-242f-0e74-5bae2d2b27f1@ti.com>
References: <1480420624-23544-1-git-send-email-bgolaszewski@baylibre.com>
 <1480420624-23544-2-git-send-email-bgolaszewski@baylibre.com>
 <a2159347-1cd7-18b1-626a-fe6a272ba85c@ti.com>
 <CAMpxmJUDyZmokJsf=RdP1DwzA_4Xc+Oh3SuSg_OenQOO5mqLvw@mail.gmail.com>
 <e6d7870b-e9fd-242f-0e74-5bae2d2b27f1@ti.com>
Message-ID: <CAMpxmJWM0CDD550+hW6cjcuKxs8Kg7O707tVfAjwXuAeoT2SpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-12-06 16:03 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
> On Tuesday 06 December 2016 06:32 PM, Bartosz Golaszewski wrote:
>> 2016-12-05 13:49 GMT+01:00 Tomi Valkeinen <tomi.valkeinen@ti.com>:
>>> On 29/11/16 13:57, Bartosz Golaszewski wrote:
>>>> Add the dumb-vga-dac node to the board DT together with corresponding
>>>> ports and vga connector. This allows to retrieve the edid info from
>>>> the display automatically.
>>>>
>>>
>>> It's a bit difficult to follow this as there's been so many patches
>>> going around. But I take the above is the LCDC node in the base da850
>>> dtsi file? In that case, what is the display_in supposed to present?
>>> It's the first node in the "display chain", so it has no input.
>>>
>>> Also, don't touch da850.dtsi here, just add the "ports" node in the
>>> da850-lcdk.dts file.
>>>
>>> If the da850.dtsi has not been merged yet, I'd change the name of the
>>> lcdc node to something else than "display". It's rather vague. If it's
>>> named "lcdc", reading da850-lcdk.dts becomes much easier, as you'll
>>> refer to "lcdc".
>>>
>>
>> The node is already in Sekhar's branch.
>
> The node name should be 'display' as thats the ePAPR 1.1 generic name
> recommendation. The label is also set to 'display' though and that can
> be changed to lcdc.
>
> A pre-patch to fix that before we modify the node further is welcome.
>
> Thanks,
> Sekhar

I'll include this in v5 together with the change requested by Laurent.

Thanks,
Bartosz
