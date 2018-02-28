From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 28 Feb 2018 14:11:13 +0100
Subject: [PATCH] soc: rockchip: power-domain: remove PM clocks
In-Reply-To: <CAAFQd5CpA_M821cMDtiEiWxw_rL--hQy6T6imz_c+fSi3gH9zw@mail.gmail.com>
References: <20180228111113.13639-1-jeffy.chen@rock-chips.com>
 <CAMuHMdWLL9CxmxSLsqs1QX0dDHVhp4NrW4Me2EZaZE_bJ330bA@mail.gmail.com>
 <CAAFQd5CLXUwH6jTq9ZOpbYt9-Xx-+Kgj-Nk+KujS=Y=qLByc9Q@mail.gmail.com>
 <CAMuHMdWdVdregCRh17Jfa92csBruZvLzAK+M8uajif0BSJTcaw@mail.gmail.com>
 <CAAFQd5CpA_M821cMDtiEiWxw_rL--hQy6T6imz_c+fSi3gH9zw@mail.gmail.com>
Message-ID: <CAMuHMdVVDiuv7bpdC0X95Xy9dSK_TfjW5RvSekVym9Q02798Fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Wed, Feb 28, 2018 at 1:49 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> On Wed, Feb 28, 2018 at 9:32 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Wed, Feb 28, 2018 at 1:29 PM, Tomasz Figa <tfiga@chromium.org> wrote:
>>> Also, how about systems where runtime PM is disabled? I think that's
>>> one of the reasons we control the clocks explicitly in the drivers
>>> anyway.
>>
>> On many platforms, Runtime PM is always enabled.
>
> Can we make such assumption? If so, could we just make an explicit
> "select PM_RUNTIME" in Kconfig of the SoC?

Note that the PM_RUNTIME symbol was removed in commit 464ed18ebdb6236f
("PM: Eliminate CONFIG_PM_RUNTIME"), in favor of plain PM.

The following already select PM unconditionally:
  - ARCH_OMAP2PLUS_TYPICAL
  - ARCH_RENESAS (except EMEV2)
  - ARCH_TEGRA
  - ARCH_VEXPRESS

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
