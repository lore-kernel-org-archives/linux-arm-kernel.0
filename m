From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 15 Mar 2011 11:52:49 +0530
Subject: [GIT PULL] OMAP PM updates for 2.6.39
In-Reply-To: <4D7E71C0.4010808@openelec.tv>
References: <87k4g6eakw.fsf@ti.com> <4D7E6DCF.1060703@openelec.tv>
	<20110314193848.GI7258@atomide.com> <4D7E71C0.4010808@openelec.tv>
Message-ID: <735d6a4901cc578e1e03808435b072bf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Stephan Raue
> Sent: Tuesday, March 15, 2011 1:21 AM
> To: Tony Lindgren
> Cc: Kevin Hilman; linux-omap at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [GIT PULL] OMAP PM updates for 2.6.39
>
> Am 14.03.2011 20:38, schrieb Tony Lindgren:
> > * Stephan Raue<mailinglists@openelec.tv>  [110314 12:32]:
> >> Hi,
> >>
> >> Am 11.03.2011 01:59, schrieb Kevin Hilman:
> >>> Dave Martin (5):
> >>>        ARM: omap4: Provide do_wfi() for Thumb-2
> >>>        ARM: omap4: Convert END() to ENDPROC() for correct
> linkage with CONFIG_THUMB2_KERNEL
> >>>        ARM: omap3: Remove hand-encoded SMC instructions
> >> "ARM: omap3: Remove hand-encoded SMC instructions" fails for me
> with:
> >>
> >> /home/stephan/projects/openelec/build.OpenELEC-panda.arm-
> devel/toolchain/bin/arm-openelec-linux-gnueabi-gcc -Wp,-
> MD,arch/arm/mach-omap2/.sleep34xx.o.d  -nostdinc -isystem
> /home/stephan/projects/openelec/build.OpenELEC-panda.arm-
> devel/toolchain/lib/gcc/arm-openelec-linux-gnueabi/4.5.2/include -
> I/home/stephan/projects/openelec/build.OpenELEC-panda.arm-
> devel/linux-2.6.38-rc8/arch/arm/include -Iinclude  -include
> include/generated/autoconf.h -D__KERNEL__ -mlittle-endian -
> Iarch/arm/mach-omap2/include -Iarch/arm/plat-omap/include -
> D__ASSEMBLY__ -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables
> -mthumb -Wa,-mimplicit-it=always -Wa,-mno-warn-deprecated -Wa,-
> mthumb -D__LINUX_ARM_ARCH__=7 -march=armv7-a  -include asm/unified.h
> -msoft-float -gdwarf-2     -Wa,-march=armv7-a   -c -o arch/arm/mach-
> omap2/sleep34xx.o arch/arm/mach-omap2/sleep34xx.S
> >> arch/arm/mach-omap2/sleep34xx.S: Assembler messages:
> >> arch/arm/mach-omap2/sleep34xx.S:149: Error: selected processor
> does not support ARM mode `smc #1'
> >> arch/arm/mach-omap2/sleep34xx.S:416: Error: selected processor
> does not support ARM mode `smc #1'
> >> arch/arm/mach-omap2/sleep34xx.S:427: Error: selected processor
> does not support ARM mode `smc #1'
> >> arch/arm/mach-omap2/sleep34xx.S:452: Error: selected processor
> does not support ARM mode `smc #0'
> >> arch/arm/mach-omap2/sleep34xx.S:458: Error: selected processor
> does not support ARM mode `smc #0'
> >> arch/arm/mach-omap2/sleep34xx.S:463: Error: selected processor
> does not support ARM mode `smc #0'
> >> make[2]: *** [arch/arm/mach-omap2/sleep34xx.o] Error 1
> >> make[1]: *** [arch/arm/mach-omap2] Error 2
> >>
> >>
> >> replacing in arch/arm/mach-omap2/Makefile:
> >>
> >> AFLAGS_sleep24xx.o                      :=-Wa,-march=armv6
> >> AFLAGS_sleep34xx.o                      :=-Wa,-march=armv7-a
> >>
> >> to:
> >>
> >> AFLAGS_sleep24xx.o                      :=-Wa,-march=armv6
> >> AFLAGS_sleep34xx.o                      :=-Wa,-march=armv7-
> a$(plus_sec)
> >>
> >> helps compiling (see also:
> https://patchwork.kernel.org/patch/369681/)
> > Care to post a patch for this and mention your compiler version
> too?
> >
> > Tony
> patch attached.
>
> i am using http://gitorious.org/linux-omap-dss2/linux with gcc-
> 4.5.2, binutils-2.21
>
Looks like I need to upgrade my gcc version. This is not seen with
4.3.3

Regards,
Santosh
