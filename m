From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 13 Sep 2015 11:03:51 +0200
Subject: Build regressions/improvements in v4.3-rc1
In-Reply-To: <1442134868-17607-1-git-send-email-geert@linux-m68k.org>
References: <1442134868-17607-1-git-send-email-geert@linux-m68k.org>
Message-ID: <CAMuHMdV31w=aDD-=uUPOqW71xLpOnH1jWeQpH=6x=vxNSo94FQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 13, 2015 at 11:01 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.3-rc1[1] compared to v4.2[2].
>
> Summarized:
>   - build errors: +15/-6

> [1] http://kisskb.ellerman.id.au/kisskb/head/9353/ (all 254 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/head/9309/ (all 254 configs)

>   + /home/kisskb/slave/src/arch/arm/kernel/devtree.c: error: implicit declaration of function 'early_init_dt_scan_nodes' [-Werror=implicit-function-declaration]:  => 244:2
>   + /home/kisskb/slave/src/arch/arm/kernel/devtree.c: error: implicit declaration of function 'early_init_dt_verify' [-Werror=implicit-function-declaration]:  => 215:2
>   + /home/kisskb/slave/src/arch/arm/kernel/devtree.c: error: implicit declaration of function 'of_flat_dt_match_machine' [-Werror=implicit-function-declaration]:  => 218:2
>   + /home/kisskb/slave/src/arch/arm/kernel/devtree.c: error: implicit declaration of function 'of_get_flat_dt_prop' [-Werror=implicit-function-declaration]:  => 229:3
>   + /home/kisskb/slave/src/arch/arm/kernel/devtree.c: error: implicit declaration of function 'of_get_flat_dt_root' [-Werror=implicit-function-declaration]:  => 228:3
>   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_DIRTY' undeclared (first use in this function):  => 39:2
>   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_MT_WRITEBACK' undeclared (first use in this function):  => 39:2
>   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_PRESENT' undeclared (first use in this function):  => 39:2
>   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_XN' undeclared (first use in this function):  => 39:2
>   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_YOUNG' undeclared (first use in this function):  => 39:2

arm-randconfig

>   + /home/kisskb/slave/src/arch/powerpc/kvm/book3s_pr.c: error: 'last_sc' may be used uninitialized in this function [-Werror=uninitialized]:  => 1094:31

powerpc-allyesconfig, powerpc-randconfig, powerpc-allmodconfig

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
