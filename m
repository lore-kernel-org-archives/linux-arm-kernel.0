From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 23 Aug 2010 11:21:05 +0900
Subject: [PATCH 00/14] ARM: S5PV310: Updates clock
In-Reply-To: <AANLkTinjfjiHQ7W5FpwKHKbdAhDxVKwET+9F5082nxhg@mail.gmail.com>
References: <1282140084-10265-1-git-send-email-kgene.kim@samsung.com>
	<AANLkTinjfjiHQ7W5FpwKHKbdAhDxVKwET+9F5082nxhg@mail.gmail.com>
Message-ID: <005f01cb4269$d8ec8690$8ac593b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> Well,
> 
> The current V310 clock codes don't work. I wonder these codes are
> should be tested by your team. but it's just hang at clock init.
> 
> With this patch, it's also don't boot. We also fixed the wrong uart
> clock bit. but same. don't works.
> 
> Question? Do you can boot with this codes at your board?
> 

Actually, tested on the board but some codes which don't match common kernel framework such as serial and so on had not been submitted at that time.
...will be submitted soon.

> Thank you,
> Kyungmin Park
> 
> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Linux version 2.6.36-rc1-ga400ca7-dirty
> (dofmind at dofmind-linux) (gcc version 4.4.1 (GCC) ) #334 PREEMPT Mon
> Aug 23 10:45:59 KST 2010
> [    0.000000] CPU: ARMv7 Processor [412fc091] revision 1 (ARMv7),
> cr=10c53c7f
> [    0.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing
> instruction cache
> [    0.000000] Machine: UNIVERSAL_C210
> [    0.000000] bootconsole [earlycon0] enabled
> [    0.000000] Memory policy: ECC disabled, Data cache writeback
> [    0.000000] CPU S5PV310 (id 0x43200200)
> [    0.000000] S3C24XX Clocks, Copyright 2004 Simtec Electronics
> [    0.000000] s3c_register_clksrc: clock armclk has no registers set
> [    0.000000] S5PV310: PLL settings, A=800000000, M=660000000,
> E=96000000 V=108000000
> [    0.000000] S5PV310: ARMCLK=800000000, DMC=330000000,
> ACLK200=165000000
> [    0.000000] ACLK100=82500000, ACLK160=132000000, ACLK133=110000000
> [    0.000000] uclk1: source is mout_mpll (6), rate is 82500000
> [    0.000000] uclk1: source is mout_mpll (6), rate is 82500000
> [    0.000000] uclk1: source is mout_mpll (6), rate is 82500000
> [    0.000000] uclk1: source is mout_mpll (6), rate is 82500000
> [    0.000000] sclk_pwm: source is mout_mpll (6), rate is 73333333
> [    0.000000] sclk_csis: source is ext_xtal (0), rate is 24000000
> [    0.000000] sclk_csis: source is ext_xtal (0), rate is 24000000
> [    0.000000] sclk_cam: source is ext_xtal (0), rate is 24000000
> [    0.000000] sclk_cam: source is ext_xtal (0), rate is 24000000
> [    0.000000] sclk_fimc: source is ext_xtal (0), rate is 24000000
> [    0.000000] sclk_fimc: source is ext_xtal (0), rate is 24000000
> [    0.000000] sclk_fimc: source is ext_xtal (0), rate is 24000000
> [    0.000000] sclk_fimc: source is ext_xtal (0), rate is 24000000
> [    0.000000] sclk_fimd: source is ext_xtal (0), rate is 24000000
> [    0.000000] sclk_fimd: source is ext_xtal (0), rate is 24000000
> [    0.000000] sclk_sata: source is mout_mpll (0), rate is 110000000
> [    0.000000] sclk_spi: source is ext_xtal (0), rate is 24000000
> [    0.000000] sclk_spi: source is ext_xtal (0), rate is 24000000
> [    0.000000] sclk_spi: source is ext_xtal (0), rate is 24000000
> [    0.000000] sclk_fimg2d: source is mout_g2d0 (0), rate is 0
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
> Total pages: 130048
> [    0.000000] Kernel command line: root=ubi0!rootfs rootfstype=ubifs
> rootflags=bulk_read,no_chk_data_crc ubi.mtd=8 ubi.mtd=3 ubi.mtd=6
> earlyprintk console=ttySAC2,115200n8 mem=512M mtdparts=samsung-onenan)
> [    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> [    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> [    0.000000] Memory: 512MB = 512MB total
> [    0.000000] Memory: 517040k/517040k available, 7248k reserved, 0K highmem
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
> [    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
> [    0.000000]     vmalloc : 0xe0800000 - 0xf0000000   ( 248 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
> [    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
> [    0.000000]       .init : 0xc0008000 - 0xc001f000   (  92 kB)
> [    0.000000]       .text : 0xc001f000 - 0xc023b000   (2160 kB)
> [    0.000000]       .data : 0xc0250000 - 0xc0271340   ( 133 kB)
> [    0.000000] SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0,
> CPUs=1, Nodes=1
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000]  RCU-based detection of stalled CPUs is disabled.
> [    0.000000]  Verbose stalled-CPUs detection is disabled.
> [    0.000000] NR_IRQS:440
> [    0.000000] Console: colour dummy device 80x30
> s3c24xx_serial_initconsole
> s3c24xx_serial_init_ports: initialising ports...
> s3c24xx_serial_init_port: port=c026caa0, platdev=c0271b20
> s3c24xx_serial_init_port: c026caa0 (hw 0)...
> resource c02564b8 (13800000..13800100)
> port: map=13800000, mem=f5000000, irq=16 (16,18), clock=1
> s3c24xx_serial_init_port: port=c026cb68, platdev=c0256f08
> s3c24xx_serial_init_port: c026cb68 (hw 1)...
> resource c0256528 (13810000..13810100)
> port: map=13810000, mem=f5010000, irq=20 (20,22), clock=1
> s3c24xx_serial_init_port: port=c026cc30, platdev=c0256fe8
> s3c24xx_serial_init_port: c026cc30 (hw 2)...
> resource c0256598 (13820000..13820100)
> port: map=13820000, mem=f5020000, irq=24 (24,26), clock=1
> s3c24xx_serial_init_port: port=c026ccf8, platdev=c02570c8
> s3c24xx_serial_init_port: c026ccf8 (hw 3)...
> resource c0256608 (13830000..13830100)
> port: map=13830000, mem=f5030000, irq=28 (28,30), clock=1
> s3c24xx_serial_console_setup: co=c026cd9c (2), 115200n8
> s3c24xx_serial_console_setup: port=c026cc30 (2)
> s3c24xx_serial_console_setup: baud 115200
> selecting clock fffffffe
> fracval = 0000
> config: 8bits/char
> 
> 
> On Wed, Aug 18, 2010 at 11:01 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > This patch updates clock for S5PV310/S5PC210.
> >
> > [PATCH 01/14] ARM: S5PV310: Adds clock addresses for S5PV310
> > [PATCH 02/14] ARM: S5PV310: Removed unused clock
> > [PATCH 03/14] ARM: S5PV310: Adds clkset_aclk for removing clkset_aclk_xxx
> > [PATCH 04/14] ARM: S5PV310: Fix on PLL setting for S5PV310
> > [PATCH 05/14] ARM: S5PV310: Adds clk_sclk_usbphy0, _usbphy1, and
> _hdmiphy
> > [PATCH 06/14] ARM: S5PV310: Should be clk_sclk_apll not clk_mout_apll
> > [PATCH 07/14] ARM: S5PV310: Adds printing ACLK200, ACLK100, ACLK160 and
> ACLK133
> > [PATCH 08/14] ARM: S5PV310: Adds enable and ctrlbit for clk_vpllsrc
> > [PATCH 09/14] ARM: S5PV310: Adds SDMMC clock for S5PV310
> > [PATCH 10/14] ARM: S5PV310: Adds uart clocks
> > [PATCH 11/14] ARM: S5PV310: Bug fix on uclk1 and sclk_pwm
> > [PATCH 12/14] ARM: S5PV310: Add various clocks
> > [PATCH 13/14] ARM: S5PV310: Add video clocks
> > [PATCH 14/14] ARM: S5PV310: Adds various special clocks
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >



Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
