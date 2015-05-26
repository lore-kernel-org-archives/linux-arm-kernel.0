From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 26 May 2015 09:45:07 +0200
Subject: Build regressions/improvements in v4.1-rc5
In-Reply-To: <1432625994-30130-1-git-send-email-geert@linux-m68k.org>
References: <1432625994-30130-1-git-send-email-geert@linux-m68k.org>
Message-ID: <CAMuHMdUpADBcW-4G6GZ5VT7u9Srj7ErwD0vEVUd9kYMGf7SKDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 26, 2015 at 9:39 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.1-rc5[1] to v4.1-rc4[3], the summaries are:
>   - build errors: +52/-28

  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error:
'L_PTE_MT_BUFFERABLE' undeclared here (not in a function):  => 81:10
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error:
'L_PTE_MT_DEV_CACHED' undeclared here (not in a function):  => 117:10
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error:
'L_PTE_MT_DEV_NONSHARED' undeclared here (not in a function):  =>
108:10
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error:
'L_PTE_MT_DEV_SHARED' undeclared here (not in a function):  => 103:10
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error:
'L_PTE_MT_DEV_WC' undeclared here (not in a function):  => 113:10
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: 'L_PTE_MT_MASK'
undeclared here (not in a function):  => 76:11
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error:
'L_PTE_MT_MINICACHE' undeclared here (not in a function):  => 94:10
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error:
'L_PTE_MT_UNCACHED' undeclared here (not in a function):  => 77:10
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error:
'L_PTE_MT_WRITEALLOC' undeclared here (not in a function):  => 99:10
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error:
'L_PTE_MT_WRITEBACK' undeclared here (not in a function):  => 89:10
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error:
'L_PTE_MT_WRITETHROUGH' undeclared here (not in a function):  => 85:10
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: 'L_PTE_RDONLY'
undeclared here (not in a function):  => 61:11
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: 'L_PTE_SHARED'
undeclared here (not in a function):  => 71:11
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: 'L_PTE_USER'
undeclared here (not in a function):  => 56:11
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: 'L_PTE_XN'
undeclared here (not in a function):  => 66:11
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error:
'PMD_SECT_AP_READ' undeclared here (not in a function):  => 153:13
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error:
'PMD_SECT_AP_WRITE' undeclared here (not in a function):  => 153:32
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: 'PMD_SECT_S'
undeclared here (not in a function):  => 175:11
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: 'PMD_SECT_XN'
undeclared here (not in a function):  => 170:11
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: 'PMD_SIZE'
undeclared (first use in this function):  => 276:22
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: 'PTRS_PER_PGD'
undeclared (first use in this function):  => 314:18
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: 'PTRS_PER_PMD'
undeclared (first use in this function):  => 275:18
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: 'PTRS_PER_PTE'
undeclared (first use in this function):  => 263:18
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: 'SECTION_SIZE'
undeclared (first use in this function):  => 282:7
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: (near
initialization for 'section_bits[0].mask'):  => 153:3
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: (near
initialization for 'section_bits[1].mask'):  => 157:3
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: (near
initialization for 'section_bits[1].val'):  => 158:3
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: (near
initialization for 'section_bits[2].mask'):  => 161:3
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: (near
initialization for 'section_bits[2].val'):  => 162:3
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: (near
initialization for 'section_bits[3].mask'):  => 165:3
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: (near
initialization for 'section_bits[3].val'):  => 166:3
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: (near
initialization for 'section_bits[4].mask'):  => 170:3
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: (near
initialization for 'section_bits[4].val'):  => 171:3
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: (near
initialization for 'section_bits[5].mask'):  => 175:3
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: (near
initialization for 'section_bits[5].val'):  => 176:3
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: implicit
declaration of function 'pmd_large'
[-Werror=implicit-function-declaration]:  => 277:3
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: implicit
declaration of function 'pmd_none'
[-Werror=implicit-function-declaration]:  => 277:3
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: implicit
declaration of function 'pmd_present'
[-Werror=implicit-function-declaration]:  => 277:3
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: implicit
declaration of function 'pte_offset_kernel'
[-Werror=implicit-function-declaration]:  => 259:2
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: initializer
element is not constant:  => 170:3, 153:3, 166:3, 162:3, 165:3, 157:3,
175:3, 176:3, 158:3, 171:3, 161:3
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: invalid operands
to binary * (have 'unsigned int' and 'const struct prot_bits *'):  =>
276:20
  + /home/kisskb/slave/src/arch/arm/mm/dump.c: error: invalid operands
to binary | (have 'const struct prot_bits *' and 'const struct
prot_bits *'):  => 165:30, 166:30, 161:30, 153:30, 157:30

arm/arm-randconfig (reported before for v3.19-rc3).

  + /home/kisskb/slave/src/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c:
error: implicit declaration of function 'dma_alloc_attrs'
[-Werror=implicit-function-declaration]:  => 218:2
  + /home/kisskb/slave/src/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c:
error: implicit declaration of function 'dma_free_attrs'
[-Werror=implicit-function-declaration]:  => 154:2

xtensa-allmodconfig

  + /home/kisskb/slave/src/fs/dax.c: error: implicit declaration of
function 'copy_user_page' [-Werror=implicit-function-declaration]:  =>
265:2

sh-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/8914/ (254 out of 257 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/8886/ (254 out of 257 configs)


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
