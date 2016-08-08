From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 8 Aug 2016 10:38:07 +0200
Subject: Build regressions/improvements in v4.8-rc1
In-Reply-To: <alpine.DEB.2.10.1608081032130.9359@ayla.of.borg>
References: <alpine.DEB.2.10.1608081032130.9359@ayla.of.borg>
Message-ID: <CAMuHMdW_fPP5dyOtRC98gh1kG-zuW_KxV7vAME_7b8Z-U10N_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 8, 2016 at 10:32 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.8-rc1[1] compared to v4.7[2].
>
> Summarized:
>   - build errors: +8/-12

>   + /home/kisskb/slave/src/arch/arm/kernel/setup.c: error: 'SECTION_SIZE' undeclared (first use in this function):  => 1003:25

arm-randconfig

>   + error: "__ucmpdi2" [drivers/scsi/sd_mod.ko] undefined!:  => N/A

bfin/CM-BF548_defconfig

>   + error: /home/kisskb/slave/src/drivers/block/loop.c: undefined reference to `__ucmpdi2':  => .text+0x3aaee), .text+0x2ee10), .text+0x2ee1c)
>   + error: /home/kisskb/slave/src/drivers/scsi/sd.c: undefined reference to `__ucmpdi2':  => .text+0x36cb8), .text+0x3865c)

Various blackfin

>   + error: No rule to make target arch/sh/boot/dts/.dtb.o:  => N/A

sh-allyesconfig, sh-allmodconfig

>   + {standard input}: Error: Instruction with long immediate data in delay slot:  => 18728

arcv2/axs103_smp_defconfig

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
