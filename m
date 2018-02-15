From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 15 Feb 2018 11:08:09 +0100
Subject: [PATCH] ARM: shmobile: stout: enable R-Car Gen2 regulator quirk
In-Reply-To: <ae3206a3-4735-87c8-9688-3acdbf06cc36@gmail.com>
References: <20180213232812.31408-1-marek.vasut+renesas@gmail.com>
 <20180214055800.od5yhgo753522yah@katana>
 <CAMuHMdU3opUTcOY-UeH4ArB+50_drPhGSoxP-m85p9V36fvTHg@mail.gmail.com>
 <ae3206a3-4735-87c8-9688-3acdbf06cc36@gmail.com>
Message-ID: <CAMuHMdU4_wVcKwjB1ZQzfgp8vCDs92F1o+v4UyZ0bsRDfJD1vQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Thu, Feb 15, 2018 at 10:44 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> On 02/14/2018 09:09 AM, Geert Uytterhoeven wrote:
>> On Wed, Feb 14, 2018 at 6:58 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>>>> - * The r8a7790/lager and r8a7791/koelsch development boards have da9063 and
>>>> - * da9210 regulators.  Both regulators have their interrupt request lines tied
>>>> - * to the same interrupt pin (IRQ2) on the SoC.
>>>> + * The r8a7790/lager,stout and r8a7791/koelsch development boards have da9063
>>>> + * and da9210 regulators.  Both regulators have their interrupt request lines
>>>> + * tied to the same interrupt pin (IRQ2) on the SoC.
>>>
>>> I think listing the boards here doesn't scale well. Gose is already
>>> missing. How about rephrasing the paragraph to something like "Some Gen2
>>> development boards have..."?
>>
>> +1
>>
>>>>   *
>>>>   * After cold boot or da9063-induced restart, both the da9063 and da9210 seem
>>>>   * to assert their interrupt request lines.  Hence as soon as one driver
>>>> @@ -118,6 +118,7 @@ static int __init rcar_gen2_regulator_quirk(void)
>>>>
>>>>       if (!of_machine_is_compatible("renesas,koelsch") &&
>>>>           !of_machine_is_compatible("renesas,lager") &&
>>>> +         !of_machine_is_compatible("renesas,stout") &&
>>>>           !of_machine_is_compatible("renesas,gose"))
>>>>               return -ENODEV;
>>
>> Have we reached critical mass to start using array-based matching with
>> of_device_compatible_match()?
>
> We're matching on machine , not device , here . I guess our device node
> would be / ?

Correct, cfr. the implementation of of_machine_is_compatible().

BTW, several PPC platforms use of_device_compatible_match(of_root, ...),
but I believe of_root is not guaranteed to be set up.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
