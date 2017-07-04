From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 4 Jul 2017 18:44:48 +0200
Subject: [PATCH 0/9] ARM: renesas: Use SMP jump stub SRAM region from DT
In-Reply-To: <1499182903-31339-1-git-send-email-geert+renesas@glider.be>
References: <1499182903-31339-1-git-send-email-geert+renesas@glider.be>
Message-ID: <CAMuHMdUFkaxoJCX5F3FH3vy=Sh50y02a3hF9HR3tkw-XwtiG2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 4, 2017 at 5:41 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> The R-Car Gen2 platform code for CPU core bringup needs to copy a jump
> stub to on-SoC SRAM.  Currently it uses a hardcoded address pointing to
> ICRAM1.
>
> This patch series adds support to specify this region from DT.  It
> consists of 3 parts:
>   - DT binding documentation for reserving SRAM for the jump stub,
>   - A platform code update to retrieve the information from DT, if
>     present (of course backwards-compatibility with old DTBs is
>     preserved),
>   - DT updates to reserve an SRAM region in DT on all R-Car Gen2 and
>     RZ/G1 SoCs.
>
> The DT patches in this series depend on "[PATCH 0/7] ARM: dts: renesas:
> Add Inter Connect RAM".
>
> Note that the current jump stub in Linux is 12 bytes long.  The patches
> reserve 16 bytes of SRAM.  Should this be increased?  The mapping
> granularity is PAGE_SIZE anyway.
>
> Thanks for your comments!
>
> Geert Uytterhoeven (9):
>   dt-bindings: sram: Document renesas,smp-sram
>   ARM: shmobile: rcar-gen2: Obtain jump stub region from DT
>   ARM: dts: r8a7743: Reserve SRAM for the SMP jump stub
>   ARM: dts: r8a7745: Reserve SRAM for the SMP jump stub
>   ARM: dts: r8a7790: Reserve SRAM for the SMP jump stub
>   ARM: dts: r8a7791: Reserve SRAM for the SMP jump stub
>   ARM: dts: r8a7792: Reserve SRAM for the SMP jump stub
>   ARM: dts: r8a7793: Reserve SRAM for the SMP jump stub
>   ARM: dts: r8a7794: Reserve SRAM for the SMP jump stub

Forgot to mention: this has been tested on r8a7790/lager, r8a7791/koelsch,
r8a7792/blanche, r8a7793/gose, and r8a7794/alt (r8a7794 needs an
unrelated fix to enable SMP).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
