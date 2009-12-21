From: jbe@pengutronix.de (Juergen Beisert)
Date: Mon, 21 Dec 2009 14:10:11 +0100
Subject: kernel boot failure on with s32440/mini2440 with git head
	(dd59f6c76b2)
In-Reply-To: <4B2E4A65.8070207@walsimou.com>
References: <4B2E4A65.8070207@walsimou.com>
Message-ID: <200912211410.12014.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sonntag, 20. Dezember 2009, Gaye Abdoulaye Walsimou wrote:
> Hello list,
> I have here a boot Oops (see below) with the latest git revision of
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git,
> which does not happen with 2.6.32.
> Thanks in advance for comments.
> Regards
>
> ####Boot log ####
>
> Uncompressing
> Linux......................................................................
>..................................... Linux version
> 2.6.33-rc1-00096-gdd59f6c
> (walsimou at wnotebook02.walsimou.com) (gcc version 4.4.2 (GCC) ) #71
> PREEMPT Sun Dec 209
> CPU: ARM920T [41129200] revision 0 (ARMv4T), cr=c0007177
> CPU: VIVT data cache, VIVT instruction cache
> Machine: MINI2440
> Memory policy: ECC disabled, Data cache writeback
> CPU S3C2440A (id 0x32440001)
> S3C24XX Clocks, Copyright 2004 Simtec Electronics
> S3C244X: core 400.000 MHz, memory 100.000 MHz, peripheral 50.000 MHz
> CLOCK: Slow mode (1.500 MHz), fast, MPLL on, UPLL on
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
> Kernel command line: root=/dev/ram rw rootfstype=initramfs
> console=ttySAC0,115200 user_debug=31 rdinit=/sbin/init
> PID hash table entries: 256 (order: -2, 1024 bytes)
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 64MB = 64MB total
> Memory: 56568KB available (2476K code, 364K data, 5460K init, 0K highmem)
> Hierarchical RCU implementation.
> NR_IRQS:85
> irq: clearing subpending status 00000003
> irq: clearing subpending status 00000002
> Console: colour dummy device 80x30
> console [ttySAC0] enabled
> Calibrating delay loop... 199.47 BogoMIPS (lpj=498688)
> Mount-cache hash table entries: 512
> CPU: Testing write buffer coherency: ok
> NET: Registered protocol family 16
> MINI2440: Option string mini2440=0tb
> MINI2440: 't' ignored, touchscreen not compiled in
> MINI2440: LCD [0:240x320] 1:800x480 2:1024x768
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000000 pgd = c0004000
> [00000000] *pgd=00000000
> Internal error: Oops: 5 [#1] PREEMPT
> last sysfs file:
> Modules linked in:
> CPU: 0    Not tainted  (2.6.33-rc1-00096-gdd59f6c #71)
> PC is at memcpy+0x64/0x29c
> LR is at kmemdup+0x30/0x38
> pc : [<c065bfc4>]    lr : [<c05b529c>]    psr: 00000013
> sp : c381dee4  ip : 0000001c  fp : c381df1c
> r10: c0556690  r9 : 00000000  r8 : c07cccc8
> r7 : c07cc640  r6 : 00000000  r5 : c3854360  r4 : 00000004
> r3 : c3805400  r2 : ffffffe4  r1 : 00000000  r0 : c3854360
> Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: c000717f  Table: 30004000  DAC: 00000017
> Process swapper (pid: 1, stack limit = 0xc381c270)
> Stack: (0xc381dee4 to 0xc381e000)
> dee0:          c3854360 00000000 c07cc640 c07cccc8 c3854360 00000004
> c05b529c
> df00: c3854380 00000000 c38543a0 c07cc640 c381df3c c381df20 c000efb0
> c05b527c
> df20: 00000003 0000006c c0556804 c07cc640 c381df94 c381df40 c000db0c
> c000ef20
> df40: c06a6f7c 00000002 00000003 00000000 c07cc640 c0556690 00000000
> 00000000
> df60: 00000000 00000000 00000000 00000000 c000b6a0 c001f88c 00000001
> 00000000
> df80: 00000000 00000000 c381dfa4 c381df98 c000b6c0 c000d898 c381dfdc
> c381dfa8
> dfa0: c055d3e0 c000b6b0 00000054 c07d2108 00000000 00000000 c381dfdc
> c001f634
> dfc0: c001f88c 00000000 00000000 00000000 c381dff4 c381dfe0 c0008600
> c055d388
> dfe0: 00000000 00000000 00000000 c381dff8 c0575868 c0008560 33cc33cc
> 33cc37cc
> Backtrace:
> [<c05b526c>] (kmemdup+0x0/0x38) from [<c000efb0>]
> (s3c_nand_set_platdata+0xa0/0x10c)
>  r7:c07cc640 r6:c38543a0 r5:00000000 r4:c3854380
> [<c000ef10>] (s3c_nand_set_platdata+0x0/0x10c) from [<c000db0c>]
> (mini2440_init+0x284/0x30c)
>  r7:c07cc640 r6:c0556804 r5:0000006c r4:00000003
> [<c000d888>] (mini2440_init+0x0/0x30c) from [<c000b6c0>]
> (customize_machine+0x20/0x2c)
> [<c000b6a0>] (customize_machine+0x0/0x2c) from [<c055d3e0>]
> (do_one_initcall+0x68/0x1c4)
> [<c055d378>] (do_one_initcall+0x0/0x1c4) from [<c0008600>]
> (kernel_init+0xb0/0x12c)
>  r8:00000000 r7:00000000 r6:00000000 r5:c001f88c r4:c001f634
> [<c0008550>] (kernel_init+0x0/0x12c) from [<c0575868>] (do_exit+0x0/0x650)
>  r5:00000000 r4:00000000
> Code: e4915004 e4916004 e4917004 e4918004 (e491e004)
> ---[ end trace 2719ed1c0000000a ]---
> Kernel panic - not syncing: Attempted to kill init!
> Backtrace:
> [<c05618a0>] (dump_backtrace+0x0/0x114) from [<c074268c>]
> (dump_stack+0x18/0x1c)
>  r7:00000005 r6:c3819c40 r5:c07d0080 r4:c07de690
> [<c0742674>] (dump_stack+0x0/0x1c) from [<c07426e4>] (panic+0x54/0x12c)
> [<c0742690>] (panic+0x0/0x12c) from [<c05758d8>] (do_exit+0x70/0x650)
>  r3:c07d0080 r2:00000002 r1:c381dd44 r0:c0799fb8
> [<c0575868>] (do_exit+0x0/0x650) from [<c0561db8>] (die+0x190/0x1b4)
> [<c0561c28>] (die+0x0/0x1b4) from [<c05635fc>]
> (__do_kernel_fault+0x6c/0x7c) [<c0563590>] (__do_kernel_fault+0x0/0x7c)
> from [<c05637d8>]
> (do_page_fault+0x1cc/0x1e4)
>  r7:00000000 r6:00000000 r5:c381de9c r4:c3819c40
> [<c056360c>] (do_page_fault+0x0/0x1e4) from [<c0563894>]
> (do_translation_fault+0x18/0x7c)
> [<c056387c>] (do_translation_fault+0x0/0x7c) from [<c055d314>]
> (do_DataAbort+0x3c/0xa0)
>  r7:c381de9c r6:00000000 r5:c07cbd40 r4:00000005
> [<c055d2d8>] (do_DataAbort+0x0/0xa0) from [<c055db00>]
> (__dabt_svc+0x40/0x60)
> Exception stack(0xc381de9c to 0xc381dee4)
> de80:
> c3854360
> dea0: 00000000 ffffffe4 c3805400 00000004 c3854360 00000000 c07cc640
> c07cccc8
> dec0: 00000000 c0556690 c381df1c 0000001c c381dee4 c05b529c c065bfc4
> 00000013
> dee0: ffffffff
>  r7:c07cc640 r6:00000000 r5:c381ded0 r4:ffffffff
> [<c05b526c>] (kmemdup+0x0/0x38) from [<c000efb0>]
> (s3c_nand_set_platdata+0xa0/0x10c)
>  r7:c07cc640 r6:c38543a0 r5:00000000 r4:c3854380
> [<c000ef10>] (s3c_nand_set_platdata+0x0/0x10c) from [<c000db0c>]
> (mini2440_init+0x284/0x30c)
>  r7:c07cc640 r6:c0556804 r5:0000006c r4:00000003
> [<c000d888>] (mini2440_init+0x0/0x30c) from [<c000b6c0>]
> (customize_machine+0x20/0x2c)
> [<c000b6a0>] (customize_machine+0x0/0x2c) from [<c055d3e0>]
> (do_one_initcall+0x68/0x1c4)
> [<c055d378>] (do_one_initcall+0x0/0x1c4) from [<c0008600>]
> (kernel_init+0xb0/0x12c)
>  r8:00000000 r7:00000000 r6:00000000 r5:c001f88c r4:c001f634
> [<c0008550>] (kernel_init+0x0/0x12c) from [<c0575868>] (do_exit+0x0/0x650)
>  r5:00000000 r4:00000000

Some (or most?) of the __initdata are bogus in the 
arch/arm/mach-s3c2440/mach-mini2440.c. You must remove them.

jbe

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-8766-939 228     |
Vertretung Sued/Muenchen, Germany             | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
