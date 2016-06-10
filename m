From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 10 Jun 2016 09:52:07 +0200
Subject: [PATCH/RFC v3 01/22] reset: Add renesas,rst DT bindings
In-Reply-To: <10393056.BKo7UTPXFi@avalon>
References: <1464808880-343-1-git-send-email-geert+renesas@glider.be>
 <1464808880-343-2-git-send-email-geert+renesas@glider.be>
 <10393056.BKo7UTPXFi@avalon>
Message-ID: <CAMuHMdVVCwhVBzPTRVzU6MFbP_sfQPu_dGx1Ef2urNMD+Eda_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Thu, Jun 2, 2016 at 11:47 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/renesas,rst.txt
>> @@ -0,0 +1,35 @@
>> +DT bindings for the Renesas R-Car Reset Controller
>> +
>> +The R-Car Reset Controller provides reset control, and implements the
>> following
>> +functions:
>> +  - Latching of the levels on mode pins when PRESET# is negated,
>> +  - Mode monitoring register,
>> +  - Reset control of peripheral devices (on R-Car Gen1),
>> +  - Watchdog timer (on R-Car Gen1).
>> +  - Register-based reset control and boot address registers for the various
>> CPU
>> +    cores (on R-Car Gen2/Gen3),
>> +
>> +
>> +Required properties:
>> +  - compatible: Should be
>> +               - "renesas,<soctype>-reset-wdt" for R-Car Gen1,
>> +               - "renesas,<soctype>-rst" for R-Car Gen2/Gen3.
>> +             Examples with soctypes are:
>> +               - "renesas,r8a7778-reset-wdt" (R-Car M1A)
>> +               - "renesas,r8a7779-reset-wdt" (R-Car H1)
>> +               - "renesas,r8a7790-rst" (R-Car H2)
>> +               - "renesas,r8a7791-rst" (R-Car M2-W)
>> +               - "renesas,r8a7792-rst" (R-Car V2H
>> +               - "renesas,r8a7793-rst" (R-Car M2-N)
>> +               - "renesas,r8a7794-rst" (R-Car E2)
>> +               - "renesas,r8a7795-rst" (R-Car H3)
>> +               - "renesas,r8a7796-rst" (R-Car M3-W)
>
> Any specific reason for such a large indentation ? (I know this is really
> nitpicking)

To align the two paragraphs and lists.

> Apart from that, it's just a bit of a shame we can't have generic compatible
> strings, but that would require additional DT properties to describe the reset
> controller features, and I assume that's not a path we want to take.

The reset controller is one of the few blocks that really differs
between members
of the same family, due to the relationship with the various CPU cores.

> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
