From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Mon, 10 Sep 2012 16:07:39 +0200
Subject: [PATCH 1/1] ARM: dts: OMAP3: Add gpio-twl4030 properties for Overo
In-Reply-To: <504DEDB4.1070804@ti.com>
References: <1347282996-31190-1-git-send-email-florian.vaussard@epfl.ch>
 <1347282996-31190-2-git-send-email-florian.vaussard@epfl.ch>
 <504DEA4E.7080109@ti.com> <504DEC36.4020704@epfl.ch>
 <504DEDB4.1070804@ti.com>
Message-ID: <504DF42B.1060307@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>
>>> BTW, I'm just wondering. Cannot we use overo without tobi?
>>>
>>> In that case, the model and compatible should probably be used as well:
>>>
>>>      model = "TI OMAP3 Gumstix Overo";
>>>      compatible = "ti,omap3-overo", "ti,omap3";
>>
>> No, it cannot. The Overo needs to be plugged into an expansion board, at
>> least to get the power. Hence the absence of model and compatible in
>> omap3-overo.dtsi.
>
> OK, cool. I was wondering because we already have a board-overo.c in the
> kernel, and there is no mention of tobi.

In board-overo.c, the various features of each expansion board are
configured using CONFIG_* options, which is not possible when booting
with a device tree.

Regards,
Florian
