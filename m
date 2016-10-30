From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 30 Oct 2016 14:01:24 +0100
Subject: Build regressions/improvements in v4.9-rc3
In-Reply-To: <1477829325-4495-1-git-send-email-geert@linux-m68k.org>
References: <1477829325-4495-1-git-send-email-geert@linux-m68k.org>
Message-ID: <CAMuHMdUU0h1w5p_p54G8gZa7vmJU5cSWGg8MP0HBADBf6FSFiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 30, 2016 at 1:08 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.9-rc3[1] compared to v4.8[2].
>
> Summarized:
>   - build errors: +176/-3

  + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad
instruction `llock r2,[r0]':  => 184, 185
  + /home/kisskb/slave/src/arch/arc/include/asm/atomic.h: Error: bad
instruction `scond r2,[r0]':  => 186, 187
    [...]
  + /home/kisskb/slave/src/include/uapi/linux/swab.h: Error: bad
instruction `swape r3,r3':  => 58
  + /home/kisskb/slave/src/include/uapi/linux/swab.h: Error: bad
instruction `swape r4,r4':  => 58

arcompact/axs101_defconfig

  + /home/kisskb/slave/src/drivers/pci/host/pci-rcar-gen2.c: error:
implicit declaration of function 'of_n_addr_cells'
[-Werror=implicit-function-declaration]:  => 303:2

arm-randconfig

See https://patchwork.kernel.org/patch/4289161/ and
https://patchwork.kernel.org/patch/8209431/

> [1] http://kisskb.ellerman.id.au/kisskb/head/11140/ (all 262 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/11104/ (all 262 configs)

Gr{oetje,eeting}s,

                         Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
