From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 25 Apr 2016 10:18:39 +0200
Subject: Build regressions/improvements in v4.6-rc5
In-Reply-To: <1461572127-14630-1-git-send-email-geert@linux-m68k.org>
References: <1461572127-14630-1-git-send-email-geert@linux-m68k.org>
Message-ID: <CAMuHMdX4LJ-OVTijYn-VB0B5djM4n3G=1NrHg8WaJoNq_NXMzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 10:15 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.6-rc5[1] to v4.6-rc4[3], the summaries are:
>   - build errors: +15/-5

  + /home/kisskb/slave/src/arch/arm/mach-sa1100/assabet.c: error:
'PMD_MASK' undeclared (first use in this function):  => 496:38
  + /home/kisskb/slave/src/arch/arm/mach-sa1100/assabet.c: error:
'pmdval_t' undeclared (first use in this function):  => 498:13
  + /home/kisskb/slave/src/arch/arm/mach-sa1100/assabet.c: error:
implicit declaration of function 'flush_pmd_entry'
[-Werror=implicit-function-declaration]:  => 503:2
  + /home/kisskb/slave/src/arch/arm/mm/copypage-v4mc.c: error:
'COPYPAGE_MINICACHE' undeclared (first use in this function):  =>
77:14
  + /home/kisskb/slave/src/arch/arm/mm/copypage-v4mc.c: error:
'L_PTE_MT_MINICACHE' undeclared (first use in this function):  =>
77:47
  + /home/kisskb/slave/src/arch/arm/mm/copypage-v4mc.c: error:
'L_PTE_PRESENT' undeclared (first use in this function):  => 77:47
  + /home/kisskb/slave/src/arch/arm/mm/copypage-v4mc.c: error:
'L_PTE_YOUNG' undeclared (first use in this function):  => 77:47
  + /home/kisskb/slave/src/arch/arm/mm/copypage-v4mc.c: error:
implicit declaration of function '__flush_dcache_page'
[-Werror=implicit-function-declaration]:  => 73:3
  + /home/kisskb/slave/src/arch/arm/mm/copypage-v4mc.c: error:
implicit declaration of function 'mk_pte'
[-Werror=implicit-function-declaration]:  => 77:2
  + /home/kisskb/slave/src/arch/arm/mm/copypage-v4mc.c: error:
implicit declaration of function 'set_top_pte'
[-Werror=implicit-function-declaration]:  => 77:2
  + /home/kisskb/slave/src/arch/arm/mm/copypage-v4mc.c: error: unknown
field 'cpu_clear_user_highpage' specified in initializer:  => 113:2
  + /home/kisskb/slave/src/arch/arm/mm/copypage-v4mc.c: error: unknown
field 'cpu_copy_user_highpage' specified in initializer:  => 114:2
  + /home/kisskb/slave/src/arch/arm/mm/copypage-v4mc.c: error:
variable 'v4_mc_user_fns' has initializer but incomplete type:  =>
112:8

arm-randconfig

  + error: bytcr_rt5640.c: undefined reference to
`sst_acpi_find_name_from_hid':  => .text+0xa68aa)

i386-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/10230/ (all 262 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/10194/ (all 262 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
