From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 30 Jun 2016 15:09:46 +0200
Subject: [PATCH] ARM: shmobile: don't call platform_can_secondary_boot on
 UP
In-Reply-To: <20160630122529.4031024-1-arnd@arndb.de>
References: <20160630122529.4031024-1-arnd@arndb.de>
Message-ID: <CAMuHMdWJOVs_pzDHWVHN8=mguUPETbq2m8LAG_N6mUFk+UA_og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Jun 30, 2016 at 2:25 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> For rcar-gen2, we build the SMP files even for UP configurations,
> and that just broke:
>
> arch/arm/mach-shmobile/built-in.o: In function `shmobile_smp_init_fallback_ops':
> pm-rcar-gen2.c:(.init.text+0x40c): undefined reference to `platform_can_secondary_boot'
>
> This adds an compile-time check before the call to platform_can_secondary_boot,
> turning the function into an empty stub for UP configurations.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: c21af444eace ("ARM: shmobile: smp: Add function to prioritize DT SMP")

Crap, I think I took the shortcut of only compile-testing
arch/arm/mach-shmobile,
not link-testing the whole kernel, with CONFIG_SMP=n...

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
