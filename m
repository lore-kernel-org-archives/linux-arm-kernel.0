From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 24 Aug 2015 10:36:04 +0200
Subject: Build regressions/improvements in v4.2-rc8
In-Reply-To: <1440405251-9184-1-git-send-email-geert@linux-m68k.org>
References: <1440405251-9184-1-git-send-email-geert@linux-m68k.org>
Message-ID: <CAMuHMdVomabvJOLLJ-tJs6KjL05YpH3zLkyrPbyEghe=WvOVkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 10:34 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.2-rc8[1] to v4.2-rc7[3], the summaries are:
>   - build errors: +4/-7

4 regressions:
  + /home/kisskb/slave/src/include/linux/kvm_host.h: error: array
subscript is above array bounds [-Werror=array-bounds]:  => 430:19
    (arch/powerpc/kvm/book3s_64_mmu.c: In function 'kvmppc_mmu
_book3s_64_tlbie':)

powerpc-randconfig (seen before in a v3.15-rc1 build?)

  + error: initramfs.c: undefined reference to `__stack_chk_guard':
=> .init.text+0x1cb0)
    (init/built-in.o: In function `parse_header':)

x86_64-randconfig

  + error: pci.c: undefined reference to `pci_ioremap_io':  => .init.text+0x3c4)
    (arch/arm/mach-versatile/built-in.o: In function `pci_versatile_setup')

arm-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/9289/ (253 out of 254 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/9260/ (253 out of 254 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
