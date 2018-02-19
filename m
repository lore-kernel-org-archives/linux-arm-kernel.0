From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 19 Feb 2018 15:03:36 +0100
Subject: Build regressions/improvements in v4.16-rc2
In-Reply-To: <1519048647-18732-1-git-send-email-geert@linux-m68k.org>
References: <1519048647-18732-1-git-send-email-geert@linux-m68k.org>
Message-ID: <CAMuHMdWs9r4F7FnuHvQGX1L9g91MCepSHroRDhj1tB9E70d5gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 19, 2018 at 2:57 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.16-rc2[1] to v4.16-rc1[3], the summaries are:
>   - build errors: +5/-2

  + /home/kisskb/slave/src/arch/arm64/kernel/head.S: Error: junk at
end of line, first unrecognized character is `U':  => 677
  + /home/kisskb/slave/src/arch/arm64/kernel/head.S: Error: missing ')':  => 677
  + /home/kisskb/slave/src/arch/arm64/kernel/head.S: Error: unexpected
characters following instruction at operand 2 -- `movk
x1,:abs_g0_nc:0xff00ffffffUL':  => 677
  + /home/kisskb/slave/src/arch/arm64/kernel/head.S: Error: unexpected
characters following instruction at operand 2 -- `movz
x1,:abs_g1_s:0xff00ffffffUL':  => 677

arm64-allnoconfig
arm64-allmodconfig
arm64-defconfig
(patch available)

  + error: hotplug-cpu.c: undefined reference to
`timed_topology_update':  => .text+0x410), .text+0x138)

ppc64le/pseries_le_defconfig+NO_NUMA

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
