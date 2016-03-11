From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 11 Mar 2016 09:01:09 +0100
Subject: [PATCH v3 6/6] arm64: dts: r8a7795: Add SYSC PM domains
In-Reply-To: <20160310233411.GC7423@verge.net.au>
References: <1457551135-22078-1-git-send-email-geert+renesas@glider.be>
 <1457551135-22078-7-git-send-email-geert+renesas@glider.be>
 <20160310233411.GC7423@verge.net.au>
Message-ID: <CAMuHMdWH96S6W_h+zYqos6r2-kr6qf_3yo_PvDUc1zfJTzwfdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Fri, Mar 11, 2016 at 12:34 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Mar 09, 2016 at 08:18:55PM +0100, Geert Uytterhoeven wrote:
>> Add a device node for the System Controller.
>> Hook up the Cortex-A57 CPU cores and the Cortex-A57 and Cortex A53 L2
>> caches/SCUs to their respective PM domains.
>> Hook up all devices that are part of the CPG/MSSR Clock Domain to the
>> SYSC "always-on" PM Domain.
>
> [snip]
>
>> +             sysc: system-controller at e6180000 {
>> +                     compatible = "renesas,r8a7795-sysc";
>> +                     reg = <0 0xe6180000 0 0x0400>;
>
> In table 9.2 of v0.51e of the documentation I see some registers
> beyond the 0x400 range above. Perhaps it could be enlarged accordingly?

No, these registers do not apply to R-Car H3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
