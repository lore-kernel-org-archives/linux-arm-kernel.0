From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 25 Oct 2015 11:18:53 +0100
Subject: Build regressions/improvements in v4.3-rc7
In-Reply-To: <1445767971-22415-1-git-send-email-geert@linux-m68k.org>
References: <1445767971-22415-1-git-send-email-geert@linux-m68k.org>
Message-ID: <CAMuHMdX9X8SRCA4K++LvRz1sK3Ewyj5wKbvrdAy06L6v2XTduA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 25, 2015 at 11:12 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.3-rc7[1] to v4.3-rc6[3], the summaries are:
>   - build errors: +12/-4

  + /home/kisskb/slave/src/arch/arm/kernel/devtree.c: error: implicit
declaration of function 'early_init_dt_scan_nodes'
[-Werror=implicit-function-declaration]:  => 244:2
  + /home/kisskb/slave/src/arch/arm/kernel/devtree.c: error: implicit
declaration of function 'early_init_dt_verify'
[-Werror=implicit-function-declaration]:  => 215:2
  + /home/kisskb/slave/src/arch/arm/kernel/devtree.c: error: implicit
declaration of function 'of_flat_dt_match_machine'
[-Werror=implicit-function-declaration]:  => 218:2
  + /home/kisskb/slave/src/arch/arm/kernel/devtree.c: error: implicit
declaration of function 'of_get_flat_dt_prop'
[-Werror=implicit-function-declaration]:  => 229:3
  + /home/kisskb/slave/src/arch/arm/kernel/devtree.c: error: implicit
declaration of function 'of_get_flat_dt_root'
[-Werror=implicit-function-declaration]:  => 228:3
  + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error:
'L_PTE_DIRTY' undeclared (first use in this function):  => 39:2
  + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error:
'L_PTE_MT_WRITEBACK' undeclared (first use in this function):  => 39:2
  + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error:
'L_PTE_PRESENT' undeclared (first use in this function):  => 39:2
  + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_XN'
undeclared (first use in this function):  => 39:2
  + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error:
'L_PTE_YOUNG' undeclared (first use in this function):  => 39:2

arm-randconfig (all seen and reported before)

> [1] http://kisskb.ellerman.id.au/kisskb/head/9511/ (256 out of 254 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/9487/ (255 out of 254 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
