From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 6 Dec 2016 20:33:45 +0530
Subject: [PATCH v3 1/2] ARM: dts: da850-lcdk: add the dumb-vga-dac node
In-Reply-To: <CAMpxmJUDyZmokJsf=RdP1DwzA_4Xc+Oh3SuSg_OenQOO5mqLvw@mail.gmail.com>
References: <1480420624-23544-1-git-send-email-bgolaszewski@baylibre.com>
 <1480420624-23544-2-git-send-email-bgolaszewski@baylibre.com>
 <a2159347-1cd7-18b1-626a-fe6a272ba85c@ti.com>
 <CAMpxmJUDyZmokJsf=RdP1DwzA_4Xc+Oh3SuSg_OenQOO5mqLvw@mail.gmail.com>
Message-ID: <e6d7870b-e9fd-242f-0e74-5bae2d2b27f1@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 December 2016 06:32 PM, Bartosz Golaszewski wrote:
> 2016-12-05 13:49 GMT+01:00 Tomi Valkeinen <tomi.valkeinen@ti.com>:
>> On 29/11/16 13:57, Bartosz Golaszewski wrote:
>>> Add the dumb-vga-dac node to the board DT together with corresponding
>>> ports and vga connector. This allows to retrieve the edid info from
>>> the display automatically.
>>>
>>
>> It's a bit difficult to follow this as there's been so many patches
>> going around. But I take the above is the LCDC node in the base da850
>> dtsi file? In that case, what is the display_in supposed to present?
>> It's the first node in the "display chain", so it has no input.
>>
>> Also, don't touch da850.dtsi here, just add the "ports" node in the
>> da850-lcdk.dts file.
>>
>> If the da850.dtsi has not been merged yet, I'd change the name of the
>> lcdc node to something else than "display". It's rather vague. If it's
>> named "lcdc", reading da850-lcdk.dts becomes much easier, as you'll
>> refer to "lcdc".
>>
> 
> The node is already in Sekhar's branch.

The node name should be 'display' as thats the ePAPR 1.1 generic name
recommendation. The label is also set to 'display' though and that can
be changed to lcdc.

A pre-patch to fix that before we modify the node further is welcome.

Thanks,
Sekhar
