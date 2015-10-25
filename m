From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 25 Oct 2015 18:34:04 +0100
Subject: Build regressions/improvements in v4.3-rc7
In-Reply-To: <CAMuHMdX9X8SRCA4K++LvRz1sK3Ewyj5wKbvrdAy06L6v2XTduA@mail.gmail.com>
References: <1445767971-22415-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdX9X8SRCA4K++LvRz1sK3Ewyj5wKbvrdAy06L6v2XTduA@mail.gmail.com>
Message-ID: <CAMuHMdUeLdnxRKi7DT036uoZdH6uzBKipm-rv6Ch=0qCJsU_Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 25, 2015 at 11:18 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Sun, Oct 25, 2015 at 11:12 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> JFYI, when comparing v4.3-rc7[1] to v4.3-rc6[3], the summaries are:
>>   - build errors: +12/-4
>
>   + /home/kisskb/slave/src/arch/arm/kernel/devtree.c: error: implicit declaration of function 'early_init_dt_scan_nodes' [-Werror=implicit-function-declaration]:  => 244:2
>   + /home/kisskb/slave/src/arch/arm/kernel/devtree.c: error: implicit declaration of function 'early_init_dt_verify' [-Werror=implicit-function-declaration]:  => 215:2
>   + /home/kisskb/slave/src/arch/arm/kernel/devtree.c: error: implicit declaration of function 'of_flat_dt_match_machine' [-Werror=implicit-function-declaration]:  => 218:2
>   + /home/kisskb/slave/src/arch/arm/kernel/devtree.c: error: implicit declaration of function 'of_get_flat_dt_prop' [-Werror=implicit-function-declaration]:  => 229:3
>   + /home/kisskb/slave/src/arch/arm/kernel/devtree.c: error: implicit declaration of function 'of_get_flat_dt_root' [-Werror=implicit-function-declaration]:  => 228:3

> arm-randconfig (all seen and reported before)

CONFIG_OF=y with CONFIG_USE_OF=n, which used to be an impossibe
combination on ARM. Patch sent.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
