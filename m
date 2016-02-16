From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 16 Feb 2016 08:15:40 +0100
Subject: [PATCH/RFC v2 01/11] PM / Domains: Add DT bindings for the R-Car
 System Controller
In-Reply-To: <1720075.YOPnCQ3mE1@avalon>
References: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
 <1455571020-18968-2-git-send-email-geert+renesas@glider.be>
 <1720075.YOPnCQ3mE1@avalon>
Message-ID: <CAMuHMdXJYjde1cqWyqzDL9Cgb-3cWSvJmrG61H6Jf6EOu0-=Fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Tue, Feb 16, 2016 at 12:08 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/renesas,sysc-rcar.txt
>> @@ -0,0 +1,87 @@
>> +DT bindings for the Renesas R-Car System Controller
>> +
>> +== System Controller Node ==
>> +
>> +The R-Car System Controller provides power management for the CPU cores and
>> +various coprocessors.
>> +
>> +Required properties:
>> +  - compatible: Must contain one or more of the following:
>> +      - "renesas,r8a7779-sysc" (R-Car H1)
>> +      - "renesas,r8a7790-sysc" (R-Car H2)
>> +      - "renesas,r8a7791-sysc" (R-Car M2-W)
>> +      - "renesas,r8a7792-sysc" (R-Car V2H)
>> +      - "renesas,r8a7793-sysc" (R-Car M2-N)
>> +      - "renesas,r8a7794-sysc" (R-Car E2)
>> +      - "renesas,r8a7795-sysc" (R-Car H3)
>> +      - "renesas,rcar-gen2-sysc" (Generic R-Car Gen2)
>> +      - "renesas,rcar-gen3-sysc" (Generic R-Car Gen3)
>> +    When compatible with the generic version, nodes must list the
>> SoC-specific
>> +    version corresponding to the platform first, followed by the generic
>> +    version.
>> +  - reg: Address start and address range for the device.

You're quoting the description of the "reg" property for the SYSC device node...

> This isn't correct. I'll refrain from saying we abuse the reg property, as
> using the first cell as a power domain number should be fine (the second cell
> feels a bit more of an abuse to me though, but I won't complain too much), but
> the bindings document should describe what the reg cells contain.

... while the two cell format is for the PM domain nodes, not for the
SYSC device
node. Please check the other "reg" description.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
