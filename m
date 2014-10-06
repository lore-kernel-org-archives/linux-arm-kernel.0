From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 6 Oct 2014 10:56:51 +0200
Subject: [PATCH] [RFC] ARM: shmobile: Add early debugging support using
 SCIF(A)
In-Reply-To: <20141006060347.GB1266@katana>
References: <1412276563-21473-1-git-send-email-geert+renesas@glider.be>
 <2257006.dpJJ6zLgnP@avalon> <20141006060347.GB1266@katana>
Message-ID: <CAMuHMdXRcuq+hcyjeRDgFqKo2n7JSR5tTfz6wstTXnm2ohKdtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Mon, Oct 6, 2014 at 8:03 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> >   - While the serial console on r8a7790 was switched from SCIF0 to
>> >     SCIFA0 recently, I believe r8a7990 still needs to use SCIF0 instead
>> >     of SCIFA0, as that's what the bootloader has configured.
>>
>> Good point. Wolfram, any opinion about this ?
>
> IMO we should only use SCIFA if it uses the same wires as SCIF. This
> is the case for Lager (7790). Dunno about other boards.

I agree with your statement about using the same wires.
However, having the ability to pinmux both SCIF0 and SCIFA0 to the same
wires is not a board property, but an SoC property, right?

Nevertheless, for DEBUG_LL, this is early debug output, so it should use the
exact same settings as the bootloader, which has configured SCIF0, and
(b) has setup pinmux for SCIF0. Pinmux setup for SCIFA0 only kicks in when
the real SCIFA1 is initialized later.

Please correct me if I'm wrong.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
