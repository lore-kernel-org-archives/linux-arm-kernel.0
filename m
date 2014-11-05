From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 5 Nov 2014 09:25:54 +0100
Subject: [GIT PULL] Renesas ARM Based SoC Clocks Updates for v3.19
In-Reply-To: <20141105040416.GH32470@verge.net.au>
References: <cover.1414558424.git.horms+renesas@verge.net.au>
 <20141104223054.GB5908@quad.lixom.net>
 <20141105040416.GH32470@verge.net.au>
Message-ID: <CAMuHMdVV865rCCPTusL3+L=dAGA9O7870ys0Y+BsLgSAhCqKbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Simon,

On Wed, Nov 5, 2014 at 5:04 AM, Simon Horman <horms@verge.net.au> wrote:
>> > Renesas ARM Based SoC Clocks Updates for v3.19
>> >
>> > * Add missing INTCA clock for irqpin module on r8a7740
>> >
>> > ----------------------------------------------------------------
>> > Geert Uytterhoeven (1):
>> >       ARM: shmobile: r8a7740 legacy: Add missing INTCA clock for irqpin module
>>
>> Hi,
>>
>> I'm trying to categorize this patch and it's hard. Is it a fix for a
>> bug? Support for new firmware that doesn't enable this clock? How does
>> the breakage show itself, and in what circumstances? Essentially, the
>> patch description doesn't describe why it's needed and what it fixes.
>>
>> Which means I don't know where to merge it to.
>
> I believe that this fixes a problem that doesn't manifest.
>
> It ensures that the clock required for the irqpin controller is available.
> But as it is in practice the boot loader appears to make the clock
> available and its been working due to that for several years. And I'm not
> aware of anyone for whom it is not working without this patch.

That was the first part.

There's a second part (which I indeed forgot to mention in the commit
message, sorry for that). If the system doesn't know about the clock,
it cannot disable it when the affected devices are not used (system suspend,
or runtime PM), thus wasting power.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
