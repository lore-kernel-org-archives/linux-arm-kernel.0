From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 10 Mar 2015 22:42:54 +0100
Subject: [PATCH] clk: provide clk_is_match() dummy for non-common clk
In-Reply-To: <8682755.oK0Ae34OOP@wuerfel>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-2-git-send-email-shawn.guo@linaro.org>
 <20150225172757.421.43718@quantum> <8682755.oK0Ae34OOP@wuerfel>
Message-ID: <CAMuHMdWvaO-qEohYX=DNybR1=1d4me=FHO8Rj-eEn2OgAKaPgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 8, 2015 at 10:05 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> ARM randconfig build tests found a new error for configurations
> with COMMON_CLK disabled but HAS_CLK selected by the platform:
>
> ERROR: "clk_is_match" [sound/soc/fsl/snd-soc-fsl-spdif.ko] undefined!
>
> This moves the declaration around, so this case is covered
> by the existing static inline helper function.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: c69e182e51d89 ("clk: introduce clk_is_match")

FYI, this also happens for sh/allmodconfig
http://kisskb.ellerman.id.au/kisskb/buildresult/12379884/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
