Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035B1C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:34:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF63920839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VNZoxRSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF63920839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hvD81fvZBAbMr0ItqX/iN8sOqviHBNA+49+UrwpOf5Y=; b=VNZoxRSFGthr2j
	JiMygBLT9HEAmVkGyd640HiOlbHIl1Qvid/DWouHjb2VfH0SroXfKpdtqrmVmm26ucc8Nb6r7yv7m
	5VWllcJVhUcJbMIIL42zRU9sEf8GnMl1VN62akEO8H5a/heokxtync049jh03pAJ/IGVrpp+iRkhh
	Se4UL9R607AdD9eh4uhbfB0vY9KmDZ2ySSOuiDfWpxopZL1Wd1ydLuFIvKmzdbyB8GNLnvZxWw72a
	cCHU7E+g+TqoQsVTuZoBxx7iE2BxWDKXZrnxLCuAdZa21vIuvc8LNN4c44w3aTW/olXSKGjqJ9+M5
	KpN/uUUltAo9MAswbd6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX8PK-0002BL-7a; Wed, 12 Dec 2018 17:34:50 +0000
Received: from smtp3-g21.free.fr ([212.27.42.3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX8PC-0002Aa-RZ
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 17:34:48 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id 0419213F86F;
 Wed, 12 Dec 2018 18:34:06 +0100 (CET)
Subject: Re: WIP: UFS on apq8098
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
 Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 Andy Gross <andy.gross@linaro.org>, Jeffrey Hugo <jhugo@codeaurora.org>
References: <ab9c8bec-35be-9e01-a567-bc2e4b2bef87@free.fr>
Message-ID: <bea2710e-729f-d3c9-8d62-28cf642ab827@free.fr>
Date: Wed, 12 Dec 2018 18:34:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <ab9c8bec-35be-9e01-a567-bc2e4b2bef87@free.fr>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_093443_368598_01D053E6 
X-CRM114-Status: GOOD (  10.05  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Stephen Boyd <sboyd@kernel.org>, MSM <linux-arm-msm@vger.kernel.org>,
 Evan Green <evgreen@chromium.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 03/12/2018 16:18, Marc Gonzalez wrote:

> I'm trying to enable UFS on apq8098. Just wanted to share my progress
> so far, in case someone spots any glaring mistakes.

I feel I'm close, but I'm still missing something. Full boot log and
complete diff provided below, for reference.

I'm open to suggestions :-)

(Maybe I went overboard with the defconfig changes, I'll try reverting
to the default one.)


[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x51af8014]
[    0.000000] Linux version 4.20.0-rc4 (mgonzalez@venus) (gcc version 7.3.1 20180425 [linaro-7.3-2018.05 revision d29120a424ecfbc167ef90065c0eeb7f91977701] (Linaro GCC 7.3-2018.05)) #21 SMP PREEMPT Wed Dec 12 17:58:29 CET 2018
[    0.000000] Machine model: Qualcomm Technologies, Inc. MSM8998 v1 MTP
[    0.000000] printk: debug: ignoring loglevel setting.
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: UEFI not found.
[    0.000000] cma: Reserved 32 MiB at 0x00000000fe000000
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 0x0000000080000000-0x000000017e3bffff]
[    0.000000] NUMA: NODE_DATA [mem 0x17e395840-0x17e396fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000017e3bffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000857fffff]
[    0.000000]   node   0: [mem 0x0000000088800000-0x00000000a1dfffff]
[    0.000000]   node   0: [mem 0x00000000a2000000-0x000000017e3bffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x000000017e3bffff]
[    0.000000] On node 0 totalpages: 1028544
[    0.000000]   DMA32 zone: 8192 pages used for memmap
[    0.000000]   DMA32 zone: 0 pages reserved
[    0.000000]   DMA32 zone: 511488 pages, LIFO batch:63
[    0.000000]   Normal zone: 8079 pages used for memmap
[    0.000000]   Normal zone: 517056 pages, LIFO batch:63
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.0
[    0.000000] random: get_random_bytes called from start_kernel+0xac/0x408 with crng_init=0
[    0.000000] percpu: Embedded 22 pages/cpu @(____ptrval____) s50456 r8192 d31464 u90112
[    0.000000] pcpu-alloc: s50456 r8192 d31464 u90112 alloc=22*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7 
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: Kernel page table isolation (KPTI)
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1012273
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: console=ttyMSM0,115200,n8 ignore_loglevel androidboot.bootdevice=1da4000.ufshc androidboot.serialno=53733c35 androidboot.baseband=apq mdss_mdp.panel=1:hdmi:16
[    0.000000] software IO TLB: mapped [mem 0xf9fff000-0xfdfff000] (64MB)
[    0.000000] Memory: 3930600K/4114176K available (6076K kernel code, 666K rwdata, 2540K rodata, 8320K init, 295K bss, 150808K reserved, 32768K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=8.
[    0.000000]  Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] GICv3: no VLPI support, no direct LPI support
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000000017b00000
[    0.000000] ITS: No ITS available, not enabling LPIs
[    0.000000] arch_timer: cp15 and mmio timer(s) running at 19.20MHz (virt/virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
[    0.000002] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps every 4398046511078ns
[    0.000092] Console: colour dummy device 80x25
[    0.000138] Calibrating delay loop (skipped), value calculated using timer frequency.. 38.40 BogoMIPS (lpj=76800)
[    0.000146] pid_max: default: 32768 minimum: 301
[    0.000202] LSM: Security Framework initializing
[    0.001077] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.001507] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.001538] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.001562] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.023898] ASID allocator initialised with 32768 entries
[    0.031898] rcu: Hierarchical SRCU implementation.
[    0.040058] EFI services will not be available.
[    0.047921] smp: Bringing up secondary CPUs ...
[    0.082052] Detected VIPT I-cache on CPU1
[    0.082080] GICv3: CPU1: found redistributor 1 region 0:0x0000000017b20000
[    0.082124] CPU1: Booted secondary processor 0x0000000001 [0x51af8014]
[    0.114143] Detected VIPT I-cache on CPU2
[    0.114164] GICv3: CPU2: found redistributor 2 region 0:0x0000000017b40000
[    0.114204] CPU2: Booted secondary processor 0x0000000002 [0x51af8014]
[    0.146436] Detected VIPT I-cache on CPU3
[    0.146460] GICv3: CPU3: found redistributor 3 region 0:0x0000000017b60000
[    0.146498] CPU3: Booted secondary processor 0x0000000003 [0x51af8014]
[    0.179024] Detected VIPT I-cache on CPU4
[    0.179051] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU4: 0x00000000101122
[    0.179074] CPU features: Unsupported CPU feature variation detected.
[    0.179107] GICv3: CPU4: found redistributor 100 region 0:0x0000000017b80000
[    0.179178] CPU4: Booted secondary processor 0x0000000100 [0x51af8001]
[    0.211120] Detected VIPT I-cache on CPU5
[    0.211144] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU5: 0x00000000101122
[    0.211196] GICv3: CPU5: found redistributor 101 region 0:0x0000000017ba0000
[    0.211264] CPU5: Booted secondary processor 0x0000000101 [0x51af8001]
[    0.243449] Detected VIPT I-cache on CPU6
[    0.243473] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU6: 0x00000000101122
[    0.243526] GICv3: CPU6: found redistributor 102 region 0:0x0000000017bc0000
[    0.243594] CPU6: Booted secondary processor 0x0000000102 [0x51af8001]
[    0.275776] Detected VIPT I-cache on CPU7
[    0.275801] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU7: 0x00000000101122
[    0.275857] GICv3: CPU7: found redistributor 103 region 0:0x0000000017be0000
[    0.275925] CPU7: Booted secondary processor 0x0000000103 [0x51af8001]
[    0.276077] smp: Brought up 1 node, 8 CPUs
[    0.276122] SMP: Total of 8 processors activated.
[    0.276127] CPU features: detected: GIC system register CPU interface
[    0.276132] CPU features: detected: 32-bit EL0 Support
[    0.276137] CPU features: detected: CRC32 instructions
[    0.281429] CPU: All CPU(s) started at EL1
[    0.281470] alternatives: patching kernel code
[    0.282439] devtmpfs: initialized
[    0.284896] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.284927] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    0.285779] pinctrl core: initialized pinctrl subsystem
[    0.286377] DMI not present or invalid.
[    0.287218] vdso: 2 pages (1 code @ (____ptrval____), 1 data @ (____ptrval____))
[    0.287224] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.288088] DMA: preallocated 256 KiB pool for atomic allocations
[    0.288299] Serial: AMBA PL011 UART driver
[    0.305646] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.306104] cryptd: max_cpu_qlen set to 1000
[    0.307280] vgaarb: loaded
[    0.307461] SCSI subsystem initialized
[    0.307576] pps_core: LinuxPPS API ver. 1 registered
[    0.307581] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.307660] EDAC MC: Ver: 3.0.0
[    0.308606] clocksource: Switched to clocksource arch_sys_counter
[    0.308704] VFS: Disk quotas dquot_6.6.0
[    0.308738] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.313884] PCI: CLS 0 bytes, default 64
[    0.317814] s1: supplied by vph_pwr
[    0.318299] s2: supplied by vph_pwr
[    0.318548] s3: supplied by vph_pwr
[    0.318613] s3: Bringing 0uV into 1352000-1352000uV
[    0.319113] s4: supplied by vph_pwr
[    0.319172] s4: Bringing 0uV into 1800000-1800000uV
[    0.319463] s5: supplied by vph_pwr
[    0.319511] s5: Bringing 0uV into 1904000-1904000uV
[    0.319827] s6: supplied by vph_pwr
[    0.320150] s7: supplied by vph_pwr
[    0.320198] s7: Bringing 0uV into 900000-900000uV
[    0.320426] s8: supplied by vph_pwr
[    0.320690] s9: supplied by vph_pwr
[    0.320912] s10: supplied by vph_pwr
[    0.321197] s11: supplied by vph_pwr
[    0.321401] s12: supplied by vph_pwr
[    0.321611] s13: supplied by vph_pwr
[    0.321931] l1: supplied by s7
[    0.321985] l1: Bringing 0uV into 880000-880000uV
[    0.322228] l2: supplied by s3
[    0.322277] l2: Bringing 0uV into 1200000-1200000uV
[    0.322516] l3: supplied by s7
[    0.322652] l3: Bringing 0uV into 1000000-1000000uV
[    0.322922] l4: supplied by s7
[    0.323107] l5: supplied by s7
[    0.323161] l5: Bringing 0uV into 800000-800000uV
[    0.323440] l6: supplied by s5
[    0.323591] l6: Bringing 0uV into 1808000-1808000uV
[    0.323884] l7: supplied by s5
[    0.323931] l7: Bringing 0uV into 1800000-1800000uV
[    0.324210] l8: supplied by s3
[    0.324254] l8: Bringing 0uV into 1200000-1200000uV
[    0.324514] l9: Bringing 0uV into 1808000-1808000uV
[    0.324897] l10: Bringing 0uV into 1808000-1808000uV
[    0.325302] l11: supplied by s7
[    0.325360] l11: Bringing 0uV into 1000000-1000000uV
[    0.325640] l12: supplied by s5
[    0.325709] l12: Bringing 0uV into 1800000-1800000uV
[    0.325982] l13: Bringing 0uV into 1808000-1808000uV
[    0.326310] l14: supplied by s5
[    0.326449] l14: Bringing 0uV into 1880000-1880000uV
[    0.326738] l15: supplied by s5
[    0.326792] l15: Bringing 0uV into 1800000-1800000uV
[    0.327078] l16: Bringing 0uV into 2704000-2704000uV
[    0.327375] l17: supplied by s3
[    0.327447] l17: Bringing 0uV into 1304000-1304000uV
[    0.327858] l18: Bringing 0uV into 2704000-2704000uV
[    0.328191] l19: Bringing 0uV into 3008000-3008000uV
[    0.328497] l20: Bringing 0uV into 2960000-2960000uV
[    0.328934] l21: Bringing 0uV into 2960000-2960000uV
[    0.329293] l22: Bringing 0uV into 2864000-2864000uV
[    0.329638] l23: Bringing 0uV into 3312000-3312000uV
[    0.329989] l24: Bringing 0uV into 3088000-3088000uV
[    0.330502] l25: Bringing 0uV into 3104000-3104000uV
[    0.330949] l26: supplied by s3
[    0.331004] l26: Bringing 0uV into 1200000-1200000uV
[    0.331404] l27: supplied by s7
[    0.331748] l28: Bringing 0uV into 3008000-3008000uV
[    0.332157] lvs1: supplied by s4
[    0.333678] lvs2: supplied by s4
[    0.334967] bob: supplied by vph_pwr
[    0.335041] bob: Bringing 0uV into 3312000-3312000uV
[    0.856203] Initialise system trusted keyrings
[    0.856623] workingset: timestamp_bits=44 max_order=20 bucket_order=0
[    0.950470] Key type asymmetric registered
[    0.950527] Asymmetric key parser 'x509' registered
[    0.950838] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[    0.950865] io scheduler noop registered
[    0.950874] io scheduler deadline registered
[    0.951442] io scheduler cfq registered (default)
[    0.951457] io scheduler mq-deadline registered
[    0.951465] io scheduler kyber registered
[    0.954299] qcom-qmp-phy 1da7000.phy: Linked as a consumer to regulator.15
[    0.954431] qcom-qmp-phy 1da7000.phy: Linked as a consumer to regulator.16
[    0.955131] qcom-qmp-phy 1da7000.phy: Registered Qcom-QMP phy
[    0.966031] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.968531] msm_serial c1b0000.serial: msm_serial: detected port #0
[    0.968642] msm_serial c1b0000.serial: uartclk = 1843200
[    0.968802] c1b0000.serial: ttyMSM0 at MMIO 0xc1b0000 (irq = 13, base_baud = 115200) is a MSM
[    0.968922] msm_serial: console setup on port #0
[    2.051671] printk: console [ttyMSM0] enabled
[    2.056705] msm_serial: driver initialized
[    2.080393] loop: module loaded
[    2.083564] ufshcd-qcom 1da4000.ufshc: ufshcd_populate_vreg: Unable to find vdd-hba-supply regulator, assuming enabled
[    2.083793] MYDEBUG: ufshcd_parse_pinctrl_info=0
[    2.093295] ufshcd_init_clocks: core_clk max=200000000
[    2.098008] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk, rate: 198400000
[    2.102953] ufshcd_init_clocks: bus_aggr_clk max=0
[    2.111164] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: bus_aggr_clk, rate: 198400000
[    2.115881] ufshcd_init_clocks: iface_clk max=0
[    2.124443] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: iface_clk, rate: 0
[    2.128812] ufshcd_init_clocks: core_clk_unipro max=150000000
[    2.136439] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk_unipro, rate: 148800000
[    2.142280] ufshcd_init_clocks: core_clk_ice max=300000000
[    2.151106] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: core_clk_ice, rate: 0
[    2.156425] ufshcd_init_clocks: ref_clk max=0
[    2.164288] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: ref_clk, rate: 19200000
[    2.168661] ufshcd_init_clocks: tx_lane0_sync_clk max=0
[    2.176449] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: tx_lane0_sync_clk, rate: 0
[    2.181691] ufshcd_init_clocks: rx_lane0_sync_clk max=0
[    2.189988] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: rx_lane0_sync_clk, rate: 0
[    2.195135] ufshcd_init_clocks: rx_lane1_sync_clk max=0
[    2.203443] ufshcd-qcom 1da4000.ufshc: ufshcd_init_clocks: clk: rx_lane1_sync_clk, rate: 0
[    2.208761] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: core_clk enabled
[    2.216923] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: bus_aggr_clk enabled
[    2.224471] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: iface_clk enabled
[    2.232457] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: core_clk_unipro enabled
[    2.240441] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: core_clk_ice enabled
[    2.248840] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: ref_clk enabled
[    2.256426] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: tx_lane0_sync_clk enabled
[    2.264064] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: rx_lane0_sync_clk enabled
[    2.272654] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: rx_lane1_sync_clk enabled
[    2.281262] l20: supplied by bob
[    2.289650] ufshcd-qcom 1da4000.ufshc: Linked as a consumer to regulator.34
[    2.292778] ufshcd-qcom 1da4000.ufshc: Linked as a consumer to regulator.40
[    2.299441] ufshcd-qcom 1da4000.ufshc: Linked as a consumer to regulator.5
[    2.309977] scsi host0: ufshcd
[    2.314021] MYDEBUG: ufshcd_assert_device_reset
[    2.316332] MYDEBUG: ufshcd_deassert_device_reset
[    2.334733] spmi spmi-0: PMIC arbiter version v3 (0x30000000)
[    2.347478] ufshcd-qcom 1da4000.ufshc: ufshcd_print_pwr_info:[RX, TX]: gear=[1, 1], lane[1, 1], pwr[SLOWAUTO_MODE, SLOWAUTO_MODE], rate = 0
[    2.347827] VFIO - User Level meta-driver version: 0.3
[    2.348407] ufshcd_wait_for_dev_cmd: time_left=8
[    2.359735] i2c /dev entries driver
[    2.364079] ufshcd_wait_for_dev_cmd = 0
[    2.370940] input: pm8941_pwrkey as /devices/platform/soc/800f000.spmi/spmi-0/0-00/800f000.spmi:pmic@0:pon@800/800f000.spmi:pmic@0:pon@800:pwrkey/input/input0
[    2.382326] Loading compiled-in X.509 certificates
[    2.418526] l9: supplied by bob
[    2.418737] l10: supplied by bob
[    2.420720] l13: supplied by bob
[    2.424065] l16: supplied by bob
[    2.427305] l18: supplied by bob
[    2.430508] l19: supplied by bob
[    2.433722] l21: supplied by bob
[    2.437023] l22: supplied by bob
[    2.440135] l23: supplied by bob
[    2.443358] l24: supplied by bob
[    2.446563] l25: supplied by bob
[    2.449774] l28: supplied by bob
[    3.872668] ufshcd_wait_for_dev_cmd: time_left=0
[    3.872757] ufshcd-qcom 1da4000.ufshc: ufshcd_wait_for_dev_cmd: dev_cmd request timedout, tag 31
[    3.876423] ufshcd_wait_for_dev_cmd = -11
[    3.885185] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag: Sending flag query for idn 1 failed, err = -11
[    3.889102] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag_retry: failed with error -11, retries 0
[    3.964264] ufshcd-qcom 1da4000.ufshc: ufshcd_update_uic_error: UIC error flags = 0x00000000
[    4.027895] ufshcd-qcom 1da4000.ufshc: ufshcd_update_uic_error: UIC error flags = 0x00000000
[    4.098358] ufshcd-qcom 1da4000.ufshc: ufshcd_update_uic_error: UIC error flags = 0x00000001
[    5.408617] ufshcd_wait_for_dev_cmd: time_left=0
[    5.408666] ufshcd-qcom 1da4000.ufshc: ufshcd_wait_for_dev_cmd: dev_cmd request timedout, tag 31
[    5.412355] ufshcd_wait_for_dev_cmd = -11
[    5.421097] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag: Sending flag query for idn 1 failed, err = -11
[    5.425042] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag_retry: failed with error -11, retries 1
[    6.944607] ufshcd_wait_for_dev_cmd: time_left=0
[    6.944657] ufshcd-qcom 1da4000.ufshc: ufshcd_wait_for_dev_cmd: dev_cmd request timedout, tag 31
[    6.948345] ufshcd_wait_for_dev_cmd = -11
[    6.957084] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag: Sending flag query for idn 1 failed, err = -11
[    6.961029] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag_retry: failed with error -11, retries 2
[    6.970576] ufshcd-qcom 1da4000.ufshc: ufshcd_query_flag_retry: query attribute, opcode 6, idn 1, failed with error -11 after 3 retires
[    6.979368] ufshcd-qcom 1da4000.ufshc: ufshcd_complete_dev_init setting fDeviceInit flag failed with error -11
[    6.992389] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: core_clk disabled
[    7.001331] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: bus_aggr_clk disabled
[    7.009212] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: iface_clk disabled
[    7.017296] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: core_clk_unipro disabled
[    7.025008] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: core_clk_ice disabled
[    7.033312] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: ref_clk disabled
[    7.041501] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: tx_lane0_sync_clk disabled
[    7.048884] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: rx_lane0_sync_clk disabled
[    7.057562] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: rx_lane1_sync_clk disabled
[    7.078107] Freeing unused kernel memory: 8320K
[    7.089357] Run /init as init process
[    7.170002] udevd[1016]: error getting socket: Function not implemented
[    7.170137] udevd[1016]: error initializing udev control socket
[    7.282476] random: dd: uninitialized urandom read (512 bytes read)




diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dts b/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
index 66540d2ca13b..c9eea78cfdb6 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
@@ -9,5 +9,5 @@
 	model = "Qualcomm Technologies, Inc. MSM8998 v1 MTP";
 	compatible = "qcom,msm8998-mtp";
 
-	qcom,board-id = <8 0>;
+	qcom,board-id = <8 1>;
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
index b4276da1fb0d..e1c87de39076 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
@@ -241,3 +241,49 @@
 		};
 	};
 };
+
+&ufshc {
+	status = "ok";
+/***	vdd-hba-supply = <&gcc UFS_GDSC>;	-EPROBE_DEFER ***/
+	pinctrl-names = "dev-reset-assert", "dev-reset-deassert";
+	pinctrl-0 = <&ufs_dev_reset_assert>;
+	pinctrl-1 = <&ufs_dev_reset_deassert>;
+	vdd-hba-fixed-regulator;
+	vcc-supply = <&vreg_l20a_2p95>;
+	vccq-supply = <&vreg_l26a_1p2>;
+	vccq2-supply = <&vreg_s4a_1p8>;
+	vcc-max-microamp = <750000>;
+	vccq-max-microamp = <560000>;
+	vccq2-max-microamp = <750000>;
+};
+
+&ufsphy {
+	status = "ok";
+	vdda-phy-supply = <&vreg_l1a_0p875>;
+	vdda-pll-supply = <&vreg_l2a_1p2>;
+	vddp-ref-clk-supply = <&vreg_l26a_1p2>;
+	vdda-phy-max-microamp = <51400>;
+	vdda-pll-max-microamp = <14600>;
+	vddp-ref-clk-max-microamp = <100>;
+	vddp-ref-clk-always-on;
+};
+
+&tlmm {
+	gpio-reserved-ranges = <0 4>, <81 4>;
+	ufs_dev_reset_assert: ufs_dev_reset_assert {
+		config {
+			pins = "ufs_reset";
+			bias-pull-down;
+			drive-strength = <8>;
+			output-low;
+		};
+	};
+	ufs_dev_reset_deassert: ufs_dev_reset_deassert {
+		config {
+			pins = "ufs_reset";
+			bias-pull-down;
+			drive-strength = <8>;
+			output-high;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 78227cce16db..03ba269f5440 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -3,11 +3,12 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-msm8998.h>
+#include <dt-bindings/clock/qcom,rpmcc.h>
 
 / {
 	interrupt-parent = <&intc>;
 
-	qcom,msm-id = <292 0x0>;
+	qcom,msm-id = <319 0x20001>;
 
 	#address-cells = <2>;
 	#size-cells = <2>;
@@ -264,6 +265,11 @@
 		rpm_requests: rpm-requests {
 			compatible = "qcom,rpm-msm8998";
 			qcom,glink-channels = "rpm_requests";
+
+			rpmcc: qcom,rpmcc {
+				compatible = "qcom,rpmcc-msm8998";
+				#clock-cells = <1>;
+			};
 		};
 	};
 
@@ -686,5 +692,75 @@
 			redistributor-stride = <0x0 0x20000>;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		ufshc: ufshc@1da4000 {
+			compatible = "qcom,msm8998-ufshc", "qcom,ufshc",
+				     "jedec,ufs-2.0";
+			reg = <0x1da4000 0x2500>;
+			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&ufsphy_lanes>;
+			phy-names = "ufsphy";
+			lanes-per-direction = <2>;
+			power-domains = <&gcc UFS_GDSC>;
+
+			clock-names =
+				"core_clk",
+				"bus_aggr_clk",
+				"iface_clk",
+				"core_clk_unipro",
+				"core_clk_ice",
+				"ref_clk",
+				"tx_lane0_sync_clk",
+				"rx_lane0_sync_clk",
+				"rx_lane1_sync_clk";
+			clocks =
+				<&gcc GCC_UFS_AXI_CLK>,
+				<&gcc GCC_AGGRE1_UFS_AXI_CLK>,
+				<&gcc GCC_UFS_AHB_CLK>,
+				<&gcc GCC_UFS_UNIPRO_CORE_CLK>,
+				<&gcc GCC_UFS_ICE_CORE_CLK>,
+				<&rpmcc RPM_SMD_BB_CLK1>,
+				<&gcc GCC_UFS_TX_SYMBOL_0_CLK>,
+				<&gcc GCC_UFS_RX_SYMBOL_0_CLK>,
+				<&gcc GCC_UFS_RX_SYMBOL_1_CLK>;
+			freq-table-hz =
+				<50000000 200000000>,
+				<0 0>,
+				<0 0>,
+				<37500000 150000000>,
+				<75000000 300000000>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<0 0>;
+
+			resets = <&gcc GCC_UFS_BCR>;
+			reset-names = "rst";
+
+			status = "disabled";
+		};
+
+		ufsphy: phy@1da7000 {
+			compatible = "qcom,sdm845-qmp-ufs-phy";
+			reg = <0x1da7000 0x18c>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			clock-names = "ref", "ref_aux";
+			clocks =
+				<&gcc GCC_UFS_CLKREF_CLK>,
+				<&gcc GCC_UFS_PHY_AUX_CLK>;
+
+			status = "disabled";
+
+			ufsphy_lanes: lanes@1da7400 {
+				reg = <0x1da7400 0x108>,
+				      <0x1da7600 0x1e0>,
+				      <0x1da7c00 0x1dc>,
+				      <0x1da7800 0x108>,
+				      <0x1da7a00 0x1e0>;
+				#phy-cells = <0>;
+			};
+		};
 	};
 };
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c9a57d11330b..ae2f4588a450 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1,15 +1,10 @@
 CONFIG_SYSVIPC=y
-CONFIG_POSIX_MQUEUE=y
-CONFIG_AUDIT=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_IRQ_TIME_ACCOUNTING=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
-CONFIG_TASKSTATS=y
-CONFIG_TASK_DELAY_ACCT=y
-CONFIG_TASK_XACCT=y
-CONFIG_TASK_IO_ACCOUNTING=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_NUMA_BALANCING=y
@@ -28,249 +23,64 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_ALL=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
-CONFIG_JUMP_LABEL=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_ARCH_SUNXI=y
-CONFIG_ARCH_ALPINE=y
-CONFIG_ARCH_BCM2835=y
-CONFIG_ARCH_BCM_IPROC=y
-CONFIG_ARCH_BERLIN=y
-CONFIG_ARCH_BRCMSTB=y
-CONFIG_ARCH_EXYNOS=y
-CONFIG_ARCH_K3=y
-CONFIG_ARCH_LAYERSCAPE=y
-CONFIG_ARCH_LG1K=y
-CONFIG_ARCH_HISI=y
-CONFIG_ARCH_MEDIATEK=y
-CONFIG_ARCH_MESON=y
-CONFIG_ARCH_MVEBU=y
 CONFIG_ARCH_QCOM=y
-CONFIG_ARCH_ROCKCHIP=y
-CONFIG_ARCH_SEATTLE=y
-CONFIG_ARCH_SYNQUACER=y
-CONFIG_ARCH_RENESAS=y
-CONFIG_ARCH_R8A774A1=y
-CONFIG_ARCH_R8A774C0=y
-CONFIG_ARCH_R8A7795=y
-CONFIG_ARCH_R8A7796=y
-CONFIG_ARCH_R8A77965=y
-CONFIG_ARCH_R8A77970=y
-CONFIG_ARCH_R8A77980=y
-CONFIG_ARCH_R8A77990=y
-CONFIG_ARCH_R8A77995=y
-CONFIG_ARCH_STRATIX10=y
-CONFIG_ARCH_TEGRA=y
-CONFIG_ARCH_SPRD=y
-CONFIG_ARCH_THUNDER=y
-CONFIG_ARCH_THUNDER2=y
-CONFIG_ARCH_UNIPHIER=y
-CONFIG_ARCH_VEXPRESS=y
-CONFIG_ARCH_XGENE=y
-CONFIG_ARCH_ZX=y
-CONFIG_ARCH_ZYNQMP=y
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
-CONFIG_PCI_IOV=y
-CONFIG_HOTPLUG_PCI=y
-CONFIG_HOTPLUG_PCI_ACPI=y
-CONFIG_PCI_AARDVARK=y
-CONFIG_PCI_TEGRA=y
-CONFIG_PCIE_RCAR=y
 CONFIG_PCI_HOST_GENERIC=y
-CONFIG_PCI_XGENE=y
-CONFIG_PCI_HOST_THUNDER_PEM=y
-CONFIG_PCI_HOST_THUNDER_ECAM=y
-CONFIG_PCIE_ROCKCHIP_HOST=m
-CONFIG_PCI_LAYERSCAPE=y
-CONFIG_PCI_HISI=y
+CONFIG_PCIE_DW_PLAT_HOST=y
 CONFIG_PCIE_QCOM=y
-CONFIG_PCIE_ARMADA_8K=y
-CONFIG_PCIE_KIRIN=y
-CONFIG_PCIE_HISI_STB=y
 CONFIG_ARM64_VA_BITS_48=y
 CONFIG_SCHED_MC=y
+CONFIG_HOTPLUG_CPU=y
 CONFIG_NUMA=y
-CONFIG_PREEMPT=y
-CONFIG_KSM=y
-CONFIG_MEMORY_FAILURE=y
-CONFIG_TRANSPARENT_HUGEPAGE=y
-CONFIG_CMA=y
 CONFIG_SECCOMP=y
-CONFIG_KEXEC=y
 CONFIG_CRASH_DUMP=y
 CONFIG_XEN=y
-# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_COMPAT=y
-CONFIG_HIBERNATION=y
-CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
-CONFIG_ARM_CPUIDLE=y
-CONFIG_CPU_FREQ=y
-CONFIG_CPU_FREQ_STAT=y
-CONFIG_CPU_FREQ_GOV_POWERSAVE=m
-CONFIG_CPU_FREQ_GOV_USERSPACE=y
-CONFIG_CPU_FREQ_GOV_ONDEMAND=y
-CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
-CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
-CONFIG_CPUFREQ_DT=y
-CONFIG_ACPI_CPPC_CPUFREQ=m
-CONFIG_ARM_ARMADA_37XX_CPUFREQ=y
-CONFIG_ARM_BIG_LITTLE_CPUFREQ=y
-CONFIG_ARM_SCPI_CPUFREQ=y
-CONFIG_ARM_TEGRA186_CPUFREQ=y
-CONFIG_TI_SCI_PROTOCOL=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_IPV6=m
-CONFIG_NETFILTER=y
-CONFIG_NF_CONNTRACK=m
-CONFIG_NF_CONNTRACK_EVENTS=y
-CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
-CONFIG_NETFILTER_XT_TARGET_LOG=m
-CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
-CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
-CONFIG_NF_CONNTRACK_IPV4=m
-CONFIG_IP_NF_IPTABLES=m
-CONFIG_IP_NF_FILTER=m
-CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IP_NF_NAT=m
-CONFIG_IP_NF_TARGET_MASQUERADE=m
-CONFIG_IP_NF_MANGLE=m
-CONFIG_NF_CONNTRACK_IPV6=m
-CONFIG_IP6_NF_IPTABLES=m
-CONFIG_IP6_NF_FILTER=m
-CONFIG_IP6_NF_TARGET_REJECT=m
-CONFIG_IP6_NF_MANGLE=m
-CONFIG_IP6_NF_NAT=m
-CONFIG_IP6_NF_TARGET_MASQUERADE=m
-CONFIG_BRIDGE=m
-CONFIG_BRIDGE_VLAN_FILTERING=y
-CONFIG_VLAN_8021Q=m
-CONFIG_VLAN_8021Q_GVRP=y
-CONFIG_VLAN_8021Q_MVRP=y
-CONFIG_QRTR=m
-CONFIG_QRTR_SMD=m
-CONFIG_QRTR_TUN=m
-CONFIG_BPF_JIT=y
-CONFIG_BT=m
-CONFIG_BT_HIDP=m
-# CONFIG_BT_HS is not set
-# CONFIG_BT_LE is not set
-CONFIG_BT_LEDS=y
-# CONFIG_BT_DEBUGFS is not set
-CONFIG_BT_HCIBTUSB=m
-CONFIG_BT_HCIUART=m
-CONFIG_BT_HCIUART_LL=y
-CONFIG_BT_HCIUART_BCM=y
-CONFIG_CFG80211=m
-CONFIG_MAC80211=m
-CONFIG_MAC80211_LEDS=y
-CONFIG_RFKILL=m
-CONFIG_NET_9P=y
-CONFIG_NET_9P_VIRTIO=y
+# CONFIG_SUSPEND is not set
+CONFIG_PM=y
+CONFIG_ARM_SCPI_PROTOCOL=y
+CONFIG_EFI_CAPSULE_LOADER=y
+CONFIG_ARM64_CRYPTO=y
+CONFIG_CRYPTO_SHA1_ARM64_CE=y
+CONFIG_CRYPTO_SHA2_ARM64_CE=y
+CONFIG_CRYPTO_SHA512_ARM64_CE=m
+CONFIG_CRYPTO_SHA3_ARM64=m
+CONFIG_CRYPTO_SM3_ARM64_CE=m
+CONFIG_CRYPTO_GHASH_ARM64_CE=y
+CONFIG_CRYPTO_CRCT10DIF_ARM64_CE=m
+CONFIG_CRYPTO_AES_ARM64_CE_CCM=y
+CONFIG_CRYPTO_AES_ARM64_CE_BLK=y
+CONFIG_CRYPTO_CHACHA20_NEON=m
+CONFIG_CRYPTO_AES_ARM64_BS=m
+CONFIG_JUMP_LABEL=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_BLK_DEV_INTEGRITY=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_KSM=y
+CONFIG_MEMORY_FAILURE=y
+CONFIG_TRANSPARENT_HUGEPAGE=y
+CONFIG_CMA=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=32
-CONFIG_HISILICON_LPC=y
-CONFIG_SIMPLE_PM_BUS=y
-CONFIG_MTD=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_M25P80=y
-CONFIG_MTD_NAND=y
-CONFIG_MTD_NAND_DENALI_DT=y
-CONFIG_MTD_NAND_MARVELL=y
-CONFIG_MTD_NAND_QCOM=y
-CONFIG_MTD_SPI_NOR=y
+CONFIG_BRCMSTB_GISB_ARB=y
+CONFIG_VEXPRESS_CONFIG=y
+CONFIG_OF_OVERLAY=y
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_NBD=m
 CONFIG_VIRTIO_BLK=y
-CONFIG_BLK_DEV_NVME=m
 CONFIG_SRAM=y
 CONFIG_EEPROM_AT25=m
+CONFIG_SCSI=y
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=y
-CONFIG_SCSI_SAS_ATA=y
-CONFIG_SCSI_HISI_SAS=y
-CONFIG_SCSI_HISI_SAS_PCI=y
-CONFIG_SCSI_UFSHCD=m
-CONFIG_SCSI_UFSHCD_PLATFORM=m
-CONFIG_SCSI_UFS_HISI=y
-CONFIG_SCSI_UFS_QCOM=m
-CONFIG_ATA=y
-CONFIG_SATA_AHCI=y
-CONFIG_SATA_AHCI_PLATFORM=y
-CONFIG_AHCI_CEVA=y
-CONFIG_AHCI_MVEBU=y
-CONFIG_AHCI_XGENE=y
-CONFIG_AHCI_QORIQ=y
-CONFIG_SATA_SIL24=y
-CONFIG_SATA_RCAR=y
-CONFIG_PATA_PLATFORM=y
-CONFIG_PATA_OF_PLATFORM=y
-CONFIG_NETDEVICES=y
-CONFIG_MACVLAN=m
-CONFIG_MACVTAP=m
-CONFIG_TUN=y
-CONFIG_VETH=m
-CONFIG_VIRTIO_NET=y
-CONFIG_AMD_XGBE=y
-CONFIG_NET_XGENE=y
-CONFIG_ATL1C=m
-CONFIG_MACB=y
-CONFIG_THUNDER_NIC_PF=y
-CONFIG_HIX5HD2_GMAC=y
-CONFIG_HNS_DSAF=y
-CONFIG_HNS_ENET=y
-CONFIG_HNS3=y
-CONFIG_HNS3_HCLGE=y
-CONFIG_HNS3_ENET=y
-CONFIG_E1000E=y
-CONFIG_IGB=y
-CONFIG_IGBVF=y
-CONFIG_MVNETA=y
-CONFIG_MVPP2=y
-CONFIG_SKY2=y
-CONFIG_QCOM_EMAC=m
-CONFIG_RAVB=y
-CONFIG_SMC91X=y
-CONFIG_SMSC911X=y
-CONFIG_SNI_AVE=y
-CONFIG_SNI_NETSEC=y
-CONFIG_STMMAC_ETH=m
-CONFIG_MDIO_BUS_MUX_MMIOREG=y
-CONFIG_AT803X_PHY=m
-CONFIG_MARVELL_PHY=m
-CONFIG_MARVELL_10G_PHY=m
-CONFIG_MESON_GXL_PHY=m
-CONFIG_MICREL_PHY=y
-CONFIG_REALTEK_PHY=m
-CONFIG_ROCKCHIP_PHY=y
-CONFIG_USB_PEGASUS=m
-CONFIG_USB_RTL8150=m
-CONFIG_USB_RTL8152=m
-CONFIG_USB_LAN78XX=m
-CONFIG_USB_USBNET=m
-CONFIG_USB_NET_DM9601=m
-CONFIG_USB_NET_SR9800=m
-CONFIG_USB_NET_SMSC75XX=m
-CONFIG_USB_NET_SMSC95XX=m
-CONFIG_USB_NET_PLUSB=m
-CONFIG_USB_NET_MCS7830=m
-CONFIG_ATH10K=m
-CONFIG_ATH10K_PCI=m
-CONFIG_BRCMFMAC=m
-CONFIG_MWIFIEX=m
-CONFIG_MWIFIEX_PCIE=m
-CONFIG_WL18XX=m
-CONFIG_WLCORE_SDIO=m
+CONFIG_SCSI_SAS_LIBSAS=y
+CONFIG_SCSI_UFSHCD=y
+CONFIG_SCSI_UFSHCD_PLATFORM=y
+CONFIG_SCSI_UFS_QCOM=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_ADC=m
 CONFIG_KEYBOARD_GPIO=y
@@ -279,7 +89,6 @@ CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=m
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_PM8941_PWRKEY=y
-CONFIG_INPUT_HISI_POWERKEY=y
 # CONFIG_SERIO_SERPORT is not set
 CONFIG_SERIO_AMBAKMI=y
 CONFIG_LEGACY_PTY_COUNT=16
@@ -287,25 +96,14 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
-CONFIG_SERIAL_8250_BCM2835AUX=y
 CONFIG_SERIAL_8250_DW=y
-CONFIG_SERIAL_8250_OMAP=y
-CONFIG_SERIAL_8250_MT6577=y
-CONFIG_SERIAL_8250_UNIPHIER=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
-CONFIG_SERIAL_MESON=y
-CONFIG_SERIAL_MESON_CONSOLE=y
-CONFIG_SERIAL_SAMSUNG=y
-CONFIG_SERIAL_SAMSUNG_CONSOLE=y
-CONFIG_SERIAL_TEGRA=y
-CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_MSM=y
 CONFIG_SERIAL_MSM_CONSOLE=y
 CONFIG_SERIAL_XILINX_PS_UART=y
 CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
-CONFIG_SERIAL_MVEBU_UART=y
 CONFIG_SERIAL_DEV_BUS=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_IPMI_HANDLER=m
@@ -316,154 +114,81 @@ CONFIG_TCG_TIS_I2C_INFINEON=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_PCA954x=y
-CONFIG_I2C_BCM2835=m
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
-CONFIG_I2C_IMX=y
-CONFIG_I2C_MESON=y
-CONFIG_I2C_MV64XXX=y
-CONFIG_I2C_PXA=y
 CONFIG_I2C_QUP=y
 CONFIG_I2C_RK3X=y
-CONFIG_I2C_SH_MOBILE=y
-CONFIG_I2C_TEGRA=y
-CONFIG_I2C_UNIPHIER_F=y
-CONFIG_I2C_RCAR=y
 CONFIG_I2C_CROS_EC_TUNNEL=y
+CONFIG_I2C_SLAVE=y
 CONFIG_SPI=y
-CONFIG_SPI_ARMADA_3700=y
-CONFIG_SPI_BCM2835=m
-CONFIG_SPI_BCM2835AUX=m
-CONFIG_SPI_MESON_SPICC=m
-CONFIG_SPI_MESON_SPIFC=m
-CONFIG_SPI_ORION=y
+CONFIG_SPI_MEM=y
 CONFIG_SPI_PL022=y
 CONFIG_SPI_ROCKCHIP=y
 CONFIG_SPI_QUP=y
-CONFIG_SPI_S3C64XX=y
 CONFIG_SPI_SPIDEV=m
 CONFIG_SPMI=y
+CONFIG_PPS=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_PINCTRL_MAX77620=y
 CONFIG_PINCTRL_IPQ8074=y
 CONFIG_PINCTRL_MSM8916=y
 CONFIG_PINCTRL_MSM8994=y
 CONFIG_PINCTRL_MSM8996=y
-CONFIG_PINCTRL_QDF2XXX=y
+CONFIG_PINCTRL_MSM8998=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
-CONFIG_PINCTRL_MT7622=y
 CONFIG_GPIO_DWAPB=y
 CONFIG_GPIO_MB86S7X=y
 CONFIG_GPIO_PL061=y
-CONFIG_GPIO_RCAR=y
-CONFIG_GPIO_UNIPHIER=y
 CONFIG_GPIO_XGENE=y
-CONFIG_GPIO_XGENE_SB=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCA953X_IRQ=y
 CONFIG_GPIO_MAX77620=y
-CONFIG_POWER_AVS=y
-CONFIG_ROCKCHIP_IODOMAIN=y
+CONFIG_POWER_RESET_BRCMSTB=y
 CONFIG_POWER_RESET_MSM=y
+CONFIG_POWER_RESET_QCOM_PON=y
+CONFIG_POWER_RESET_RESTART=y
+CONFIG_POWER_RESET_VEXPRESS=y
 CONFIG_POWER_RESET_XGENE=y
 CONFIG_POWER_RESET_SYSCON=y
+CONFIG_POWER_RESET_SYSCON_POWEROFF=y
 CONFIG_SYSCON_REBOOT_MODE=y
 CONFIG_BATTERY_SBS=m
 CONFIG_BATTERY_BQ27XXX=y
 CONFIG_SENSORS_ARM_SCPI=y
 CONFIG_SENSORS_LM90=m
 CONFIG_SENSORS_INA2XX=m
-CONFIG_SENSORS_RASPBERRYPI_HWMON=m
+CONFIG_THERMAL=y
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
-CONFIG_CPU_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
-CONFIG_ROCKCHIP_THERMAL=m
-CONFIG_RCAR_GEN3_THERMAL=y
-CONFIG_ARMADA_THERMAL=y
-CONFIG_BRCMSTB_THERMAL=m
-CONFIG_EXYNOS_THERMAL=y
-CONFIG_TEGRA_BPMP_THERMAL=m
 CONFIG_QCOM_TSENS=y
-CONFIG_UNIPHIER_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_ARM_SP805_WATCHDOG=y
-CONFIG_S3C2410_WATCHDOG=y
-CONFIG_MESON_GXBB_WATCHDOG=m
-CONFIG_MESON_WATCHDOG=m
-CONFIG_RENESAS_WDT=y
-CONFIG_UNIPHIER_WATCHDOG=y
-CONFIG_BCM2835_WDT=y
 CONFIG_MFD_BD9571MWV=y
-CONFIG_MFD_AXP20X_RSB=y
 CONFIG_MFD_CROS_EC=y
-CONFIG_CROS_EC_I2C=y
-CONFIG_CROS_EC_SPI=y
 CONFIG_MFD_CROS_EC_CHARDEV=m
-CONFIG_MFD_EXYNOS_LPASS=m
 CONFIG_MFD_HI6421_PMIC=y
-CONFIG_MFD_HI655X_PMIC=y
 CONFIG_MFD_MAX77620=y
 CONFIG_MFD_SPMI_PMIC=y
 CONFIG_MFD_RK808=y
 CONFIG_MFD_SEC_CORE=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
-CONFIG_REGULATOR_AXP20X=y
 CONFIG_REGULATOR_BD9571MWV=y
 CONFIG_REGULATOR_FAN53555=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_HI6421V530=y
-CONFIG_REGULATOR_HI655X=y
 CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_PWM=y
+CONFIG_REGULATOR_QCOM_RPMH=y
 CONFIG_REGULATOR_QCOM_SMD_RPM=y
 CONFIG_REGULATOR_QCOM_SPMI=y
 CONFIG_REGULATOR_RK808=y
 CONFIG_REGULATOR_S2MPS11=y
-CONFIG_REGULATOR_VCTRL=m
-CONFIG_RC_CORE=m
-CONFIG_RC_DECODERS=y
-CONFIG_RC_DEVICES=y
-CONFIG_IR_MESON=m
-CONFIG_MEDIA_SUPPORT=m
-CONFIG_MEDIA_CAMERA_SUPPORT=y
-CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
-CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
-CONFIG_MEDIA_CONTROLLER=y
-CONFIG_VIDEO_V4L2_SUBDEV_API=y
-# CONFIG_DVB_NET is not set
-CONFIG_V4L_MEM2MEM_DRIVERS=y
-CONFIG_MEDIA_USB_SUPPORT=y
-CONFIG_USB_VIDEO_CLASS=m
-CONFIG_VIDEO_SAMSUNG_S5P_JPEG=m
-CONFIG_VIDEO_SAMSUNG_S5P_MFC=m
-CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC=m
-CONFIG_VIDEO_RENESAS_FCP=m
-CONFIG_VIDEO_RENESAS_VSP1=m
-CONFIG_DRM=m
-CONFIG_DRM_NOUVEAU=m
-CONFIG_DRM_EXYNOS=m
-CONFIG_DRM_EXYNOS5433_DECON=y
-CONFIG_DRM_EXYNOS7_DECON=y
-CONFIG_DRM_EXYNOS_DSI=y
-# CONFIG_DRM_EXYNOS_DP is not set
-CONFIG_DRM_EXYNOS_HDMI=y
-CONFIG_DRM_EXYNOS_MIC=y
-CONFIG_DRM_ROCKCHIP=m
-CONFIG_DRM_SUN4I=m
-CONFIG_ROCKCHIP_ANALOGIX_DP=y
-CONFIG_ROCKCHIP_CDN_DP=y
-CONFIG_ROCKCHIP_DW_HDMI=y
-CONFIG_ROCKCHIP_DW_MIPI_DSI=y
-CONFIG_ROCKCHIP_INNO_HDMI=y
-CONFIG_DRM_RCAR_DU=m
-CONFIG_DRM_RCAR_LVDS=m
-CONFIG_DRM_TEGRA=m
+CONFIG_REGULATOR_VCTRL=y
+CONFIG_DRM=y
+CONFIG_DRM_I2C_CH7006=m
+CONFIG_DRM_I2C_SIL164=m
+CONFIG_DRM_MSM_REGISTER_LOGGING=y
 CONFIG_DRM_PANEL_SIMPLE=m
 CONFIG_DRM_I2C_ADV7511=m
-CONFIG_DRM_VC4=m
-CONFIG_DRM_HISI_HIBMC=m
-CONFIG_DRM_HISI_KIRIN=m
-CONFIG_DRM_MESON=m
-CONFIG_FB=y
 CONFIG_FB_ARMCLCD=y
 CONFIG_BACKLIGHT_GENERIC=m
 CONFIG_BACKLIGHT_PWM=m
@@ -471,244 +196,126 @@ CONFIG_BACKLIGHT_LP855X=m
 CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
-CONFIG_SOUND=y
-CONFIG_SND=y
-CONFIG_SND_SOC=y
-CONFIG_SND_BCM2835_SOC_I2S=m
-CONFIG_SND_SOC_ROCKCHIP=m
-CONFIG_SND_SOC_ROCKCHIP_I2S=m
-CONFIG_SND_SOC_ROCKCHIP_SPDIF=m
-CONFIG_SND_SOC_ROCKCHIP_RT5645=m
-CONFIG_SND_SOC_RK3399_GRU_SOUND=m
-CONFIG_SND_SOC_SAMSUNG=y
-CONFIG_SND_SOC_RCAR=m
-CONFIG_SND_SOC_AK4613=m
-CONFIG_SND_SOC_DA7219=m
-CONFIG_SND_SOC_MAX98357A=m
-CONFIG_SND_SOC_RL6231=m
-CONFIG_SND_SOC_RT5514=m
-CONFIG_SND_SOC_RT5514_SPI=m
-CONFIG_SND_SOC_RT5645=m
-CONFIG_SND_SIMPLE_CARD=m
-CONFIG_SND_AUDIO_GRAPH_CARD=m
 CONFIG_I2C_HID=m
-CONFIG_USB=y
-CONFIG_USB_OTG=y
-CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_TEGRA=y
-CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_EHCI_EXYNOS=y
-CONFIG_USB_EHCI_HCD_PLATFORM=y
-CONFIG_USB_OHCI_HCD=y
-CONFIG_USB_OHCI_EXYNOS=y
-CONFIG_USB_OHCI_HCD_PLATFORM=y
-CONFIG_USB_RENESAS_USBHS=m
-CONFIG_USB_STORAGE=y
-CONFIG_USB_MUSB_HDRC=y
-CONFIG_USB_MUSB_SUNXI=y
-CONFIG_USB_DWC3=y
-CONFIG_USB_DWC2=y
-CONFIG_USB_CHIPIDEA=y
-CONFIG_USB_CHIPIDEA_UDC=y
-CONFIG_USB_CHIPIDEA_HOST=y
-CONFIG_USB_CHIPIDEA_ULPI=y
-CONFIG_USB_ISP1760=y
-CONFIG_USB_HSIC_USB3503=y
-CONFIG_NOP_USB_XCEIV=y
-CONFIG_USB_ULPI=y
-CONFIG_USB_GADGET=y
-CONFIG_USB_RENESAS_USBHS_UDC=m
-CONFIG_USB_RENESAS_USB3=m
-CONFIG_USB_ULPI_BUS=y
-CONFIG_MMC=y
-CONFIG_MMC_BLOCK_MINORS=32
-CONFIG_MMC_ARMMMCI=y
-CONFIG_MMC_SDHCI=y
-CONFIG_MMC_SDHCI_ACPI=y
-CONFIG_MMC_SDHCI_PLTFM=y
-CONFIG_MMC_SDHCI_OF_ARASAN=y
-CONFIG_MMC_SDHCI_OF_ESDHC=y
-CONFIG_MMC_SDHCI_CADENCE=y
-CONFIG_MMC_SDHCI_TEGRA=y
-CONFIG_MMC_SDHCI_F_SDH30=y
-CONFIG_MMC_MESON_GX=y
-CONFIG_MMC_SDHCI_MSM=y
-CONFIG_MMC_SPI=y
-CONFIG_MMC_SDHI=y
-CONFIG_MMC_UNIPHIER=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_EXYNOS=y
-CONFIG_MMC_DW_HI3798CV200=y
-CONFIG_MMC_DW_K3=y
-CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_MMC_SUNXI=y
-CONFIG_MMC_BCM2835=y
-CONFIG_MMC_SDHCI_XENON=y
-CONFIG_NEW_LEDS=y
-CONFIG_LEDS_CLASS=y
-CONFIG_LEDS_GPIO=y
-CONFIG_LEDS_PWM=y
-CONFIG_LEDS_SYSCON=y
-CONFIG_LEDS_TRIGGER_DISK=y
-CONFIG_LEDS_TRIGGER_HEARTBEAT=y
-CONFIG_LEDS_TRIGGER_CPU=y
-CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
-CONFIG_LEDS_TRIGGER_PANIC=y
+# CONFIG_USB_SUPPORT is not set
 CONFIG_EDAC=y
-CONFIG_EDAC_GHES=y
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_MAX77686=y
-CONFIG_RTC_DRV_RK808=m
-CONFIG_RTC_DRV_S5M=y
-CONFIG_RTC_DRV_DS3232=y
-CONFIG_RTC_DRV_EFI=y
-CONFIG_RTC_DRV_CROS_EC=y
-CONFIG_RTC_DRV_S3C=y
-CONFIG_RTC_DRV_PL031=y
-CONFIG_RTC_DRV_SUN6I=y
-CONFIG_RTC_DRV_ARMADA38X=y
-CONFIG_RTC_DRV_TEGRA=y
-CONFIG_RTC_DRV_XGENE=y
 CONFIG_DMADEVICES=y
-CONFIG_DMA_BCM2835=m
-CONFIG_K3_DMA=y
 CONFIG_MV_XOR_V2=y
 CONFIG_PL330_DMA=y
-CONFIG_TEGRA20_APB_DMA=y
 CONFIG_QCOM_BAM_DMA=y
 CONFIG_QCOM_HIDMA_MGMT=y
 CONFIG_QCOM_HIDMA=y
-CONFIG_RCAR_DMAC=y
-CONFIG_RENESAS_USB_DMAC=m
 CONFIG_VFIO=y
-CONFIG_VFIO_PCI=y
-CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_MMIO=y
 CONFIG_XEN_GNTDEV=y
 CONFIG_XEN_GRANT_DEV_ALLOC=y
+CONFIG_CROS_EC_I2C=y
+CONFIG_CROS_EC_SPI=y
+CONFIG_COMMON_CLK_VERSATILE=y
+CONFIG_CLK_SP810=y
+CONFIG_CLK_VEXPRESS_OSC=y
 CONFIG_COMMON_CLK_RK808=y
 CONFIG_COMMON_CLK_SCPI=y
 CONFIG_COMMON_CLK_CS2000_CP=y
 CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_CLK_QORIQ=y
 CONFIG_COMMON_CLK_PWM=y
-CONFIG_TI_SCI_CLK=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_QCOM_CLK_SMD_RPM=y
+CONFIG_QCOM_CLK_RPMH=y
 CONFIG_IPQ_GCC_8074=y
 CONFIG_MSM_GCC_8916=y
 CONFIG_MSM_GCC_8994=y
 CONFIG_MSM_MMCC_8996=y
+CONFIG_MSM_GCC_8998=y
+CONFIG_SPMI_PMIC_CLKDIV=y
+CONFIG_QCOM_HFPLL=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
+CONFIG_ARM_TIMER_SP804=y
+CONFIG_MAILBOX=y
 CONFIG_ARM_MHU=y
 CONFIG_PLATFORM_MHU=y
-CONFIG_BCM2835_MBOX=y
-CONFIG_TI_MESSAGE_MANAGER=y
 CONFIG_QCOM_APCS_IPC=y
-CONFIG_ROCKCHIP_IOMMU=y
-CONFIG_TEGRA_IOMMU_SMMU=y
 CONFIG_ARM_SMMU=y
 CONFIG_ARM_SMMU_V3=y
 CONFIG_QCOM_IOMMU=y
 CONFIG_RPMSG_QCOM_GLINK_RPM=y
+CONFIG_RPMSG_QCOM_GLINK_SMEM=y
 CONFIG_RPMSG_QCOM_SMD=y
-CONFIG_RASPBERRYPI_POWER=y
+CONFIG_RPMSG_VIRTIO=y
+CONFIG_QCOM_COMMAND_DB=y
+CONFIG_QCOM_GENI_SE=y
+CONFIG_QCOM_GSBI=y
+CONFIG_QCOM_LLCC=y
+CONFIG_QCOM_SDM845_LLCC=y
+CONFIG_QCOM_RMTFS_MEM=y
+CONFIG_QCOM_RPMH=y
 CONFIG_QCOM_SMEM=y
 CONFIG_QCOM_SMD_RPM=y
 CONFIG_QCOM_SMP2P=y
 CONFIG_QCOM_SMSM=y
-CONFIG_ROCKCHIP_PM_DOMAINS=y
-CONFIG_ARCH_TEGRA_132_SOC=y
-CONFIG_ARCH_TEGRA_210_SOC=y
-CONFIG_ARCH_TEGRA_186_SOC=y
-CONFIG_ARCH_TEGRA_194_SOC=y
-CONFIG_ARCH_K3_AM6_SOC=y
-CONFIG_SOC_TI=y
-CONFIG_TI_SCI_PM_DOMAINS=y
-CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
+CONFIG_QCOM_WCNSS_CTRL=y
+CONFIG_QCOM_APR=y
+CONFIG_DEVFREQ_GOV_PERFORMANCE=y
+CONFIG_PM_DEVFREQ_EVENT=y
+CONFIG_EXTCON=y
 CONFIG_EXTCON_USB_GPIO=y
 CONFIG_EXTCON_USBC_CROS_EC=y
 CONFIG_MEMORY=y
 CONFIG_IIO=y
-CONFIG_EXYNOS_ADC=y
-CONFIG_ROCKCHIP_SARADC=m
 CONFIG_IIO_CROS_EC_SENSORS_CORE=m
 CONFIG_IIO_CROS_EC_SENSORS=m
 CONFIG_IIO_CROS_EC_LIGHT_PROX=m
 CONFIG_IIO_CROS_EC_BARO=m
 CONFIG_PWM=y
-CONFIG_PWM_BCM2835=m
 CONFIG_PWM_CROS_EC=m
-CONFIG_PWM_MESON=m
-CONFIG_PWM_RCAR=m
-CONFIG_PWM_ROCKCHIP=y
-CONFIG_PWM_SAMSUNG=y
-CONFIG_PWM_TEGRA=m
-CONFIG_RESET_TI_SCI=y
-CONFIG_PHY_XGENE=y
-CONFIG_PHY_SUN4I_USB=y
-CONFIG_PHY_HI6220_USB=y
-CONFIG_PHY_HISTB_COMBPHY=y
-CONFIG_PHY_HISI_INNO_USB2=y
-CONFIG_PHY_MVEBU_CP110_COMPHY=y
-CONFIG_PHY_QCOM_QMP=m
-CONFIG_PHY_QCOM_USB_HS=y
-CONFIG_PHY_RCAR_GEN3_USB2=y
-CONFIG_PHY_RCAR_GEN3_USB3=m
-CONFIG_PHY_ROCKCHIP_EMMC=y
-CONFIG_PHY_ROCKCHIP_INNO_HDMI=m
-CONFIG_PHY_ROCKCHIP_INNO_USB2=y
-CONFIG_PHY_ROCKCHIP_PCIE=m
-CONFIG_PHY_ROCKCHIP_TYPEC=y
-CONFIG_PHY_TEGRA_XUSB=y
-CONFIG_PHY_UNIPHIER_USB3=y
-CONFIG_PHY_UNIPHIER_USB2=y
-CONFIG_HISI_PMU=y
-CONFIG_QCOM_L2_PMU=y
-CONFIG_QCOM_L3_PMU=y
+CONFIG_QCOM_PDC=y
+CONFIG_PHY_QCOM_APQ8064_SATA=y
+CONFIG_PHY_QCOM_IPQ806X_SATA=y
+CONFIG_PHY_QCOM_QMP=y
+CONFIG_PHY_QCOM_QUSB2=y
 CONFIG_QCOM_QFPROM=y
-CONFIG_ROCKCHIP_EFUSE=y
-CONFIG_UNIPHIER_EFUSE=y
-CONFIG_MESON_EFUSE=m
 CONFIG_TEE=y
 CONFIG_OPTEE=y
-CONFIG_ARM_SCPI_PROTOCOL=y
-CONFIG_RASPBERRYPI_FIRMWARE=y
-CONFIG_EFI_CAPSULE_LOADER=y
-CONFIG_ACPI=y
-CONFIG_ACPI_APEI=y
-CONFIG_ACPI_APEI_GHES=y
-CONFIG_ACPI_APEI_MEMORY_FAILURE=y
-CONFIG_ACPI_APEI_EINJ=y
-CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
-CONFIG_BTRFS_FS=m
-CONFIG_BTRFS_FS_POSIX_ACL=y
 CONFIG_FANOTIFY=y
 CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
 CONFIG_QUOTA=y
 CONFIG_AUTOFS4_FS=y
-CONFIG_FUSE_FS=m
-CONFIG_CUSE=m
-CONFIG_OVERLAY_FS=m
 CONFIG_VFAT_FS=y
 CONFIG_HUGETLBFS=y
 CONFIG_CONFIGFS_FS=y
 CONFIG_EFIVAR_FS=y
-CONFIG_SQUASHFS=y
-CONFIG_NFS_FS=y
-CONFIG_NFS_V4=y
-CONFIG_NFS_V4_1=y
-CONFIG_NFS_V4_2=y
-CONFIG_ROOT_NFS=y
-CONFIG_9P_FS=y
+# CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-CONFIG_VIRTUALIZATION=y
-CONFIG_KVM=y
+CONFIG_KEYS=y
+CONFIG_SECURITY=y
+CONFIG_CRYPTO_RSA=y
+CONFIG_CRYPTO_ECDH=m
+CONFIG_CRYPTO_CCM=m
+CONFIG_CRYPTO_GCM=m
+CONFIG_CRYPTO_ECHAINIV=y
+CONFIG_CRYPTO_ECB=m
+CONFIG_CRYPTO_CMAC=m
+CONFIG_CRYPTO_MD5=m
+CONFIG_CRYPTO_SHA512=m
+CONFIG_CRYPTO_ARC4=m
+CONFIG_CRYPTO_DES=m
+CONFIG_CRYPTO_DEFLATE=y
+CONFIG_CRYPTO_ANSI_CPRNG=y
+CONFIG_ASYMMETRIC_KEY_TYPE=y
+CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
+CONFIG_X509_CERTIFICATE_PARSER=y
+CONFIG_PKCS7_MESSAGE_PARSER=y
+CONFIG_SYSTEM_TRUSTED_KEYRING=y
+CONFIG_INDIRECT_PIO=y
+CONFIG_CRC_ITU_T=y
+CONFIG_CRC7=y
+CONFIG_LIBCRC32C=m
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
@@ -718,19 +325,3 @@ CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_FTRACE is not set
 CONFIG_MEMTEST=y
-CONFIG_SECURITY=y
-CONFIG_CRYPTO_ECHAINIV=y
-CONFIG_CRYPTO_ANSI_CPRNG=y
-CONFIG_CRYPTO_DEV_FSL_DPAA2_CAAM=y
-CONFIG_ARM64_CRYPTO=y
-CONFIG_CRYPTO_SHA1_ARM64_CE=y
-CONFIG_CRYPTO_SHA2_ARM64_CE=y
-CONFIG_CRYPTO_SHA512_ARM64_CE=m
-CONFIG_CRYPTO_SHA3_ARM64=m
-CONFIG_CRYPTO_SM3_ARM64_CE=m
-CONFIG_CRYPTO_GHASH_ARM64_CE=y
-CONFIG_CRYPTO_CRCT10DIF_ARM64_CE=m
-CONFIG_CRYPTO_AES_ARM64_CE_CCM=y
-CONFIG_CRYPTO_AES_ARM64_CE_BLK=y
-CONFIG_CRYPTO_CHACHA20_NEON=m
-CONFIG_CRYPTO_AES_ARM64_BS=m
diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 850c02a52248..be072897a80d 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -611,10 +611,113 @@ static const struct rpm_smd_clk_desc rpm_clk_msm8996 = {
 	.num_clks = ARRAY_SIZE(msm8996_clks),
 };
 
+/* QCS404 */
+DEFINE_CLK_SMD_RPM_QDSS(qcs404, qdss_clk, qdss_a_clk, QCOM_SMD_RPM_MISC_CLK, 1);
+
+DEFINE_CLK_SMD_RPM(qcs404, pnoc_clk, pnoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 0);
+DEFINE_CLK_SMD_RPM(qcs404, snoc_clk, snoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 1);
+
+DEFINE_CLK_SMD_RPM(qcs404, bimc_clk, bimc_a_clk, QCOM_SMD_RPM_MEM_CLK, 0);
+DEFINE_CLK_SMD_RPM(qcs404, bimc_gpu_clk, bimc_gpu_a_clk, QCOM_SMD_RPM_MEM_CLK, 2);
+
+DEFINE_CLK_SMD_RPM(qcs404, qpic_clk, qpic_a_clk, QCOM_SMD_RPM_QPIC_CLK, 0);
+DEFINE_CLK_SMD_RPM(qcs404, ce1_clk, ce1_a_clk, QCOM_SMD_RPM_CE_CLK, 0);
+
+DEFINE_CLK_SMD_RPM_XO_BUFFER(qcs404, rf_clk1, rf_clk1_a, 4);
+DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(qcs404, rf_clk1_pin, rf_clk1_a_pin, 4);
+
+DEFINE_CLK_SMD_RPM_XO_BUFFER(qcs404, ln_bb_clk, ln_bb_a_clk, 8);
+DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(qcs404, ln_bb_clk_pin, ln_bb_clk_a_pin, 8);
+
+static struct clk_smd_rpm *qcs404_clks[] = {
+	[RPM_SMD_QDSS_CLK] = &qcs404_qdss_clk,
+	[RPM_SMD_QDSS_A_CLK] = &qcs404_qdss_a_clk,
+	[RPM_SMD_PNOC_CLK] = &qcs404_pnoc_clk,
+	[RPM_SMD_PNOC_A_CLK] = &qcs404_pnoc_a_clk,
+	[RPM_SMD_SNOC_CLK] = &qcs404_snoc_clk,
+	[RPM_SMD_SNOC_A_CLK] = &qcs404_snoc_a_clk,
+	[RPM_SMD_BIMC_CLK] = &qcs404_bimc_clk,
+	[RPM_SMD_BIMC_A_CLK] = &qcs404_bimc_a_clk,
+	[RPM_SMD_BIMC_GPU_CLK] = &qcs404_bimc_gpu_clk,
+	[RPM_SMD_BIMC_GPU_A_CLK] = &qcs404_bimc_gpu_a_clk,
+	[RPM_SMD_QPIC_CLK] = &qcs404_qpic_clk,
+	[RPM_SMD_QPIC_CLK_A] = &qcs404_qpic_a_clk,
+	[RPM_SMD_CE1_CLK] = &qcs404_ce1_clk,
+	[RPM_SMD_CE1_A_CLK] = &qcs404_ce1_a_clk,
+	[RPM_SMD_RF_CLK1] = &qcs404_rf_clk1,
+	[RPM_SMD_RF_CLK1_A] = &qcs404_rf_clk1_a,
+	[RPM_SMD_LN_BB_CLK] = &qcs404_ln_bb_clk,
+	[RPM_SMD_LN_BB_A_CLK] = &qcs404_ln_bb_a_clk,
+};
+
+static const struct rpm_smd_clk_desc rpm_clk_qcs404 = {
+	.clks = qcs404_clks,
+	.num_clks = ARRAY_SIZE(qcs404_clks),
+};
+
+/* msm8998 */
+DEFINE_CLK_SMD_RPM(msm8998, snoc_clk, snoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 1);
+DEFINE_CLK_SMD_RPM(msm8998, cnoc_clk, cnoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 2);
+DEFINE_CLK_SMD_RPM(msm8998, ce1_clk, ce1_a_clk, QCOM_SMD_RPM_CE_CLK, 0);
+DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, div_clk1, div_clk1_a, 0xb);
+DEFINE_CLK_SMD_RPM(msm8998, ipa_clk, ipa_a_clk, QCOM_SMD_RPM_IPA_CLK, 0);
+DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, bb_clk1, bb_clk1_a, 1);
+DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, bb_clk2, bb_clk2_a, 2);
+DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, bb_clk3_pin, bb_clk3_a_pin, 3);
+DEFINE_CLK_SMD_RPM(msm8998, mmssnoc_axi_rpm_clk, mmssnoc_axi_rpm_a_clk,
+		   QCOM_SMD_RPM_MMAXI_CLK, 0);
+DEFINE_CLK_SMD_RPM(msm8998, aggre1_noc_clk, aggre1_noc_a_clk,
+		   QCOM_SMD_RPM_AGGR_CLK, 1);
+DEFINE_CLK_SMD_RPM(msm8998, aggre2_noc_clk, aggre2_noc_a_clk,
+		   QCOM_SMD_RPM_AGGR_CLK, 2);
+DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, rf_clk1, rf_clk1_a, 4);
+DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, rf_clk2_pin, rf_clk2_a_pin, 5);
+DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, rf_clk3, rf_clk3_a, 6);
+DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, rf_clk3_pin, rf_clk3_a_pin, 6);
+static struct clk_smd_rpm *msm8998_clks[] = {
+	[RPM_SMD_SNOC_CLK] = &msm8998_snoc_clk,
+	[RPM_SMD_SNOC_A_CLK] = &msm8998_snoc_a_clk,
+	[RPM_SMD_CNOC_CLK] = &msm8998_cnoc_clk,
+	[RPM_SMD_CNOC_A_CLK] = &msm8998_cnoc_a_clk,
+	[RPM_SMD_CE1_CLK] = &msm8998_ce1_clk,
+	[RPM_SMD_CE1_A_CLK] = &msm8998_ce1_a_clk,
+	[RPM_SMD_DIV_CLK1] = &msm8998_div_clk1,
+	[RPM_SMD_DIV_A_CLK1] = &msm8998_div_clk1_a,
+	[RPM_SMD_IPA_CLK] = &msm8998_ipa_clk,
+	[RPM_SMD_IPA_A_CLK] = &msm8998_ipa_a_clk,
+	[RPM_SMD_BB_CLK1] = &msm8998_bb_clk1,
+	[RPM_SMD_BB_CLK1_A] = &msm8998_bb_clk1_a,
+	[RPM_SMD_BB_CLK2] = &msm8998_bb_clk2,
+	[RPM_SMD_BB_CLK2_A] = &msm8998_bb_clk2_a,
+	[RPM_SMD_BB_CLK3_PIN] = &msm8998_bb_clk3_pin,
+	[RPM_SMD_BB_CLK3_A_PIN] = &msm8998_bb_clk3_a_pin,
+	[RPM_SMD_MMAXI_CLK] = &msm8998_mmssnoc_axi_rpm_clk,
+	[RPM_SMD_MMAXI_A_CLK] = &msm8998_mmssnoc_axi_rpm_a_clk,
+	[RPM_SMD_AGGR1_NOC_CLK] = &msm8998_aggre1_noc_clk,
+	[RPM_SMD_AGGR1_NOC_A_CLK] = &msm8998_aggre1_noc_a_clk,
+	[RPM_SMD_AGGR2_NOC_CLK] = &msm8998_aggre2_noc_clk,
+	[RPM_SMD_AGGR2_NOC_A_CLK] = &msm8998_aggre2_noc_a_clk,
+	[RPM_SMD_RF_CLK1] = &msm8998_rf_clk1,
+	[RPM_SMD_RF_CLK1_A] = &msm8998_rf_clk1_a,
+	[RPM_SMD_RF_CLK2_PIN] = &msm8998_rf_clk2_pin,
+	[RPM_SMD_RF_CLK2_A_PIN] = &msm8998_rf_clk2_a_pin,
+	[RPM_SMD_RF_CLK3] = &msm8998_rf_clk3,
+	[RPM_SMD_RF_CLK3_A] = &msm8998_rf_clk3_a,
+	[RPM_SMD_RF_CLK3_PIN] = &msm8998_rf_clk3_pin,
+	[RPM_SMD_RF_CLK3_A_PIN] = &msm8998_rf_clk3_a_pin,
+};
+
+static const struct rpm_smd_clk_desc rpm_clk_msm8998 = {
+	.clks = msm8998_clks,
+	.num_clks = ARRAY_SIZE(msm8998_clks),
+};
+
 static const struct of_device_id rpm_smd_clk_match_table[] = {
 	{ .compatible = "qcom,rpmcc-msm8916", .data = &rpm_clk_msm8916 },
 	{ .compatible = "qcom,rpmcc-msm8974", .data = &rpm_clk_msm8974 },
 	{ .compatible = "qcom,rpmcc-msm8996", .data = &rpm_clk_msm8996 },
+	{ .compatible = "qcom,rpmcc-msm8998", .data = &rpm_clk_msm8998 },
+	{ .compatible = "qcom,rpmcc-qcs404",  .data = &rpm_clk_qcs404  },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rpm_smd_clk_match_table);
diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
index 9f0ae403d5f5..621f1a66ce86 100644
--- a/drivers/clk/qcom/gcc-msm8998.c
+++ b/drivers/clk/qcom/gcc-msm8998.c
@@ -117,6 +117,17 @@ static const char * const gcc_parent_names_5[] = {
 	"core_bi_pll_test_se",
 };
 
+static struct clk_fixed_factor xo = {
+	.mult = 1,
+	.div = 1,
+	.hw.init = &(struct clk_init_data){
+		.name = "xo",
+		.parent_names = (const char *[]){ "xo_board" },
+		.num_parents = 1,
+		.ops = &clk_fixed_factor_ops,
+	},
+};
+
 static struct pll_vco fabia_vco[] = {
 	{ 250000000, 2000000000, 0 },
 	{ 125000000, 1000000000, 1 },
@@ -1099,6 +1110,27 @@ static struct clk_rcg2 ufs_axi_clk_src = {
 	},
 };
 
+static const struct freq_tbl ftbl_ufs_unipro_core_clk_src[] = {
+	F(37500000, P_GPLL0_OUT_MAIN, 16, 0, 0),
+	F(75000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
+	F(150000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 ufs_unipro_core_clk_src = {
+	.cmd_rcgr = 0x76028,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_1,
+	.freq_tbl = ftbl_ufs_unipro_core_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "ufs_unipro_core_clk_src",
+		.parent_names = gcc_parent_names_1,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
 static const struct freq_tbl ftbl_usb30_master_clk_src[] = {
 	F(19200000, P_XO, 1, 0, 0),
 	F(120000000, P_GPLL0_OUT_MAIN, 5, 0, 0),
@@ -1884,7 +1916,7 @@ static struct clk_branch gcc_gp3_clk = {
 
 static struct clk_branch gcc_gpu_bimc_gfx_clk = {
 	.halt_reg = 0x71010,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x71010,
 		.enable_mask = BIT(0),
@@ -1972,6 +2004,7 @@ static struct clk_branch gcc_hmss_dvm_bus_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_hmss_dvm_bus_clk",
+			.flags = CLK_IS_CRITICAL,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2015,6 +2048,7 @@ static struct clk_branch gcc_lpass_at_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_lpass_at_clk",
+			.flags = CLK_IS_CRITICAL,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2401,7 +2435,7 @@ static struct clk_branch gcc_ufs_phy_aux_clk = {
 
 static struct clk_branch gcc_ufs_rx_symbol_0_clk = {
 	.halt_reg = 0x75014,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x75014,
 		.enable_mask = BIT(0),
@@ -2414,7 +2448,7 @@ static struct clk_branch gcc_ufs_rx_symbol_0_clk = {
 
 static struct clk_branch gcc_ufs_rx_symbol_1_clk = {
 	.halt_reg = 0x7605c,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x7605c,
 		.enable_mask = BIT(0),
@@ -2427,7 +2461,7 @@ static struct clk_branch gcc_ufs_rx_symbol_1_clk = {
 
 static struct clk_branch gcc_ufs_tx_symbol_0_clk = {
 	.halt_reg = 0x75010,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x75010,
 		.enable_mask = BIT(0),
@@ -2438,6 +2472,8 @@ static struct clk_branch gcc_ufs_tx_symbol_0_clk = {
 	},
 };
 
+static const char *foo[] = { "ufs_unipro_core_clk_src" };
+
 static struct clk_branch gcc_ufs_unipro_core_clk = {
 	.halt_reg = 0x76008,
 	.halt_check = BRANCH_HALT,
@@ -2446,6 +2482,8 @@ static struct clk_branch gcc_ufs_unipro_core_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_ufs_unipro_core_clk",
+			.parent_names = foo,
+			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2541,6 +2579,76 @@ static struct clk_branch gcc_usb_phy_cfg_ahb2phy_clk = {
 	},
 };
 
+static struct clk_branch gcc_hdmi_clkref_clk = {
+	.halt_reg = 0x88000,
+	.clkr = {
+		.enable_reg = 0x88000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_hdmi_clkref_clk",
+			.parent_names = (const char *[]){ "xo" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ufs_clkref_clk = {
+	.halt_reg = 0x88004,
+	.clkr = {
+		.enable_reg = 0x88004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_ufs_clkref_clk",
+			.parent_names = (const char *[]){ "xo" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb3_clkref_clk = {
+	.halt_reg = 0x88008,
+	.clkr = {
+		.enable_reg = 0x88008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_usb3_clkref_clk",
+			.parent_names = (const char *[]){ "xo" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_clkref_clk = {
+	.halt_reg = 0x8800c,
+	.clkr = {
+		.enable_reg = 0x8800c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_pcie_clkref_clk",
+			.parent_names = (const char *[]){ "xo" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_rx1_usb2_clkref_clk = {
+	.halt_reg = 0x88014,
+	.clkr = {
+		.enable_reg = 0x88014,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_rx1_usb2_clkref_clk",
+			.parent_names = (const char *[]){ "xo" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct gdsc pcie_0_gdsc = {
 	.gdscr = 0x6b004,
 	.gds_hw_ctrl = 0x0,
@@ -2688,6 +2796,7 @@ static struct clk_regmap *gcc_msm8998_clocks[] = {
 	[GCC_UFS_RX_SYMBOL_1_CLK] = &gcc_ufs_rx_symbol_1_clk.clkr,
 	[GCC_UFS_TX_SYMBOL_0_CLK] = &gcc_ufs_tx_symbol_0_clk.clkr,
 	[GCC_UFS_UNIPRO_CORE_CLK] = &gcc_ufs_unipro_core_clk.clkr,
+	[UFS_UNIPRO_CORE_CLK_SRC] = &ufs_unipro_core_clk_src.clkr,
 	[GCC_USB30_MASTER_CLK] = &gcc_usb30_master_clk.clkr,
 	[GCC_USB30_MOCK_UTMI_CLK] = &gcc_usb30_mock_utmi_clk.clkr,
 	[GCC_USB30_SLEEP_CLK] = &gcc_usb30_sleep_clk.clkr,
@@ -2733,6 +2842,11 @@ static struct clk_regmap *gcc_msm8998_clocks[] = {
 	[USB30_MASTER_CLK_SRC] = &usb30_master_clk_src.clkr,
 	[USB30_MOCK_UTMI_CLK_SRC] = &usb30_mock_utmi_clk_src.clkr,
 	[USB3_PHY_AUX_CLK_SRC] = &usb3_phy_aux_clk_src.clkr,
+	[GCC_HDMI_CLKREF_CLK] = &gcc_hdmi_clkref_clk.clkr,
+	[GCC_UFS_CLKREF_CLK] = &gcc_ufs_clkref_clk.clkr,
+	[GCC_USB3_CLKREF_CLK] = &gcc_usb3_clkref_clk.clkr,
+	[GCC_PCIE_CLKREF_CLK] = &gcc_pcie_clkref_clk.clkr,
+	[GCC_RX1_USB2_CLKREF_CLK] = &gcc_rx1_usb2_clkref_clk.clkr,
 };
 
 static struct gdsc *gcc_msm8998_gdscs[] = {
@@ -2742,25 +2856,25 @@ static struct gdsc *gcc_msm8998_gdscs[] = {
 };
 
 static const struct qcom_reset_map gcc_msm8998_resets[] = {
-	[GCC_BLSP1_QUP1_BCR] = { 0x102400 },
-	[GCC_BLSP1_QUP2_BCR] = { 0x110592 },
-	[GCC_BLSP1_QUP3_BCR] = { 0x118784 },
-	[GCC_BLSP1_QUP4_BCR] = { 0x126976 },
-	[GCC_BLSP1_QUP5_BCR] = { 0x135168 },
-	[GCC_BLSP1_QUP6_BCR] = { 0x143360 },
-	[GCC_BLSP2_QUP1_BCR] = { 0x155648 },
-	[GCC_BLSP2_QUP2_BCR] = { 0x163840 },
-	[GCC_BLSP2_QUP3_BCR] = { 0x172032 },
-	[GCC_BLSP2_QUP4_BCR] = { 0x180224 },
-	[GCC_BLSP2_QUP5_BCR] = { 0x188416 },
-	[GCC_BLSP2_QUP6_BCR] = { 0x196608 },
-	[GCC_PCIE_0_BCR] = { 0x438272 },
-	[GCC_PDM_BCR] = { 0x208896 },
-	[GCC_SDCC2_BCR] = { 0x81920 },
-	[GCC_SDCC4_BCR] = { 0x90112 },
-	[GCC_TSIF_BCR] = { 0x221184 },
-	[GCC_UFS_BCR] = { 0x479232 },
-	[GCC_USB_30_BCR] = { 0x61440 },
+	[GCC_BLSP1_QUP1_BCR] = { 0x19000 },
+	[GCC_BLSP1_QUP2_BCR] = { 0x1b000 },
+	[GCC_BLSP1_QUP3_BCR] = { 0x1d000 },
+	[GCC_BLSP1_QUP4_BCR] = { 0x1f000 },
+	[GCC_BLSP1_QUP5_BCR] = { 0x21000 },
+	[GCC_BLSP1_QUP6_BCR] = { 0x23000 },
+	[GCC_BLSP2_QUP1_BCR] = { 0x26000 },
+	[GCC_BLSP2_QUP2_BCR] = { 0x28000 },
+	[GCC_BLSP2_QUP3_BCR] = { 0x2a000 },
+	[GCC_BLSP2_QUP4_BCR] = { 0x2c000 },
+	[GCC_BLSP2_QUP5_BCR] = { 0x2e000 },
+	[GCC_BLSP2_QUP6_BCR] = { 0x30000 },
+	[GCC_PCIE_0_BCR] = { 0x6b000 },
+	[GCC_PDM_BCR] = { 0x33000 },
+	[GCC_SDCC2_BCR] = { 0x14000 },
+	[GCC_SDCC4_BCR] = { 0x16000 },
+	[GCC_TSIF_BCR] = { 0x36000 },
+	[GCC_UFS_BCR] = { 0x75000 },
+	[GCC_USB_30_BCR] = { 0xf000 },
 };
 
 static const struct regmap_config gcc_msm8998_regmap_config = {
@@ -2798,6 +2912,10 @@ static int gcc_msm8998_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = devm_clk_hw_register(&pdev->dev, &xo.hw);
+	if (ret)
+		return ret;
+
 	return qcom_cc_really_probe(pdev, &gcc_msm8998_desc, regmap);
 }
 
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index a83332411026..7fd9dae0d24f 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -72,6 +72,9 @@
 
 #define MAX_PROP_NAME				32
 
+/* Define the assumed distance between lanes for underspecified device trees. */
+#define QMP_PHY_LEGACY_LANE_STRIDE		0x400
+
 struct qmp_phy_init_tbl {
 	unsigned int offset;
 	unsigned int val;
@@ -390,7 +393,7 @@ static const struct qmp_phy_init_tbl ipq8074_pcie_pcs_tbl[] = {
 };
 
 static const struct qmp_phy_init_tbl qmp_v3_usb3_serdes_tbl[] = {
-	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_IVCO, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_IVCO, 0x0f),
 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYSCLK_EN_SEL, 0x14),
 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x08),
 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
@@ -650,8 +653,8 @@ static const struct qmp_phy_init_tbl sdm845_ufsphy_serdes_tbl[] = {
 
 static const struct qmp_phy_init_tbl sdm845_ufsphy_tx_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V3_TX_LANE_MODE_1, 0x06),
-	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_TX, 0x04),
-	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_RX, 0x07),
+	//QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_TX, 0x04),
+	//QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_RX, 0x07),
 };
 
 static const struct qmp_phy_init_tbl sdm845_ufsphy_rx_tbl[] = {
@@ -663,14 +666,14 @@ static const struct qmp_phy_init_tbl sdm845_ufsphy_rx_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_TERM_BW, 0x5b),
 	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL2, 0x06),
 	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL3, 0x04),
-	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL4, 0x1b),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL4, 0x1d),
 	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SVS_SO_GAIN_HALF, 0x04),
 	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SVS_SO_GAIN_QUARTER, 0x04),
 	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SVS_SO_GAIN, 0x04),
 	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x4b),
 	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_PI_CONTROLS, 0x81),
 	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_LOW, 0x80),
-	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_MODE_00, 0x59),
+	//QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_MODE_00, 0x59),
 };
 
 static const struct qmp_phy_init_tbl sdm845_ufsphy_pcs_tbl[] = {
@@ -733,9 +736,6 @@ struct qmp_phy_cfg {
 	bool has_phy_dp_com_ctrl;
 	/* true, if PHY has secondary tx/rx lanes to be configured */
 	bool is_dual_lane_phy;
-	/* Register offset of secondary tx/rx lanes for USB DP combo PHY */
-	unsigned int tx_b_lane_offset;
-	unsigned int rx_b_lane_offset;
 
 	/* true, if PCS block has no separate SW_RESET register */
 	bool no_pcs_sw_reset;
@@ -748,6 +748,8 @@ struct qmp_phy_cfg {
  * @tx: iomapped memory space for lane's tx
  * @rx: iomapped memory space for lane's rx
  * @pcs: iomapped memory space for lane's pcs
+ * @tx2: iomapped memory space for second lane's tx (in dual lane PHYs)
+ * @rx2: iomapped memory space for second lane's rx (in dual lane PHYs)
  * @pcs_misc: iomapped memory space for lane's pcs_misc
  * @pipe_clk: pipe lock
  * @index: lane index
@@ -759,6 +761,8 @@ struct qmp_phy {
 	void __iomem *tx;
 	void __iomem *rx;
 	void __iomem *pcs;
+	void __iomem *tx2;
+	void __iomem *rx2;
 	void __iomem *pcs_misc;
 	struct clk *pipe_clk;
 	unsigned int index;
@@ -975,8 +979,6 @@ static const struct qmp_phy_cfg qmp_v3_usb3phy_cfg = {
 
 	.has_phy_dp_com_ctrl	= true,
 	.is_dual_lane_phy	= true,
-	.tx_b_lane_offset	= 0x400,
-	.rx_b_lane_offset	= 0x400,
 };
 
 static const struct qmp_phy_cfg qmp_v3_usb3_uniphy_cfg = {
@@ -1031,9 +1033,6 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
 	.mask_pcs_ready		= PCS_READY,
 
 	.is_dual_lane_phy	= true,
-	.tx_b_lane_offset	= 0x400,
-	.rx_b_lane_offset	= 0x400,
-
 	.no_pcs_sw_reset	= true,
 };
 
@@ -1238,12 +1237,12 @@ static int qcom_qmp_phy_init(struct phy *phy)
 	qcom_qmp_phy_configure(tx, cfg->regs, cfg->tx_tbl, cfg->tx_tbl_num);
 	/* Configuration for other LANE for USB-DP combo PHY */
 	if (cfg->is_dual_lane_phy)
-		qcom_qmp_phy_configure(tx + cfg->tx_b_lane_offset, cfg->regs,
+		qcom_qmp_phy_configure(qphy->tx2, cfg->regs,
 				       cfg->tx_tbl, cfg->tx_tbl_num);
 
 	qcom_qmp_phy_configure(rx, cfg->regs, cfg->rx_tbl, cfg->rx_tbl_num);
 	if (cfg->is_dual_lane_phy)
-		qcom_qmp_phy_configure(rx + cfg->rx_b_lane_offset, cfg->regs,
+		qcom_qmp_phy_configure(qphy->rx2, cfg->regs,
 				       cfg->rx_tbl, cfg->rx_tbl_num);
 
 	qcom_qmp_phy_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
@@ -1614,8 +1613,9 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id)
 
 	/*
 	 * Get memory resources for each phy lane:
-	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2; and
-	 * pcs_misc (optional) -> 3.
+	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2.
+	 * For dual lane PHYs: tx2 -> 3, rx2 -> 4, pcs_misc (optional) -> 5
+	 * For single lane PHYs: pcs_misc (optional) -> 3.
 	 */
 	qphy->tx = of_iomap(np, 0);
 	if (!qphy->tx)
@@ -1629,7 +1629,32 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id)
 	if (!qphy->pcs)
 		return -ENOMEM;
 
-	qphy->pcs_misc = of_iomap(np, 3);
+	/*
+	 * If this is a dual-lane PHY, then there should be registers for the
+	 * second lane. Some old device trees did not specify this, so fall
+	 * back to old legacy behavior of assuming they can be reached at an
+	 * offset from the first lane.
+	 */
+	if (qmp->cfg->is_dual_lane_phy) {
+		qphy->tx2 = of_iomap(np, 3);
+		qphy->rx2 = of_iomap(np, 4);
+		if (!qphy->tx2 || !qphy->rx2) {
+			dev_warn(dev,
+				 "Underspecified device tree, falling back to legacy register regions\n");
+
+			/* In the old version, pcs_misc is at index 3. */
+			qphy->pcs_misc = qphy->tx2;
+			qphy->tx2 = qphy->tx + QMP_PHY_LEGACY_LANE_STRIDE;
+			qphy->rx2 = qphy->rx + QMP_PHY_LEGACY_LANE_STRIDE;
+
+		} else {
+			qphy->pcs_misc = of_iomap(np, 5);
+		}
+
+	} else {
+		qphy->pcs_misc = of_iomap(np, 3);
+	}
+
 	if (!qphy->pcs_misc)
 		dev_vdbg(dev, "PHY pcs_misc-reg not used\n");
 
diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index 3aeadb14aae1..dc60f4032d81 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -12,6 +12,7 @@
  *
  */
 
+#define DEBUG
 #include <linux/time.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -267,6 +268,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 			__func__, ret);
 		goto out;
 	}
+	host->is_phy_init = true;
 
 	/* De-assert PHY reset and start serdes */
 	ufs_qcom_deassert_reset(hba);
@@ -595,6 +597,35 @@ static int ufs_qcom_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	return err;
 }
 
+static int ufs_qcom_core_reset(struct ufs_hba *hba)
+{
+	int ret = -ENOTSUPP;
+
+	if (!hba->core_reset) {
+		dev_err(hba->dev, "%s: failed, err = %d\n", __func__,
+				ret);
+		goto out;
+	}
+
+	ret = reset_control_assert(hba->core_reset);
+	if (ret) {
+		dev_err(hba->dev, "core_reset assert failed, err = %d\n",
+				ret);
+		goto out;
+	}
+
+	/* As per spec, delay is required to let reset assert go through */
+	usleep_range(1, 2);
+
+	ret = reset_control_deassert(hba->core_reset);
+	if (ret)
+		dev_err(hba->dev, "core_reset deassert failed, err = %d\n",
+				ret);
+
+out:
+	return ret;
+}
+
 struct ufs_qcom_dev_params {
 	u32 pwm_rx_gear;	/* pwm rx gear to work in */
 	u32 pwm_tx_gear;	/* pwm tx gear to work in */
@@ -1118,7 +1149,8 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
 		return 0;
 
 	if (on && (status == POST_CHANGE)) {
-		phy_power_on(host->generic_phy);
+		if (host->is_phy_init)
+			phy_power_on(host->generic_phy);
 
 		/* enable the device ref clock for HS mode*/
 		if (ufshcd_is_hs_mode(&hba->pwr_info))
@@ -1637,6 +1669,7 @@ static struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
 	.apply_dev_quirks	= ufs_qcom_apply_dev_quirks,
 	.suspend		= ufs_qcom_suspend,
 	.resume			= ufs_qcom_resume,
+	.core_reset		= ufs_qcom_core_reset,
 	.dbg_register_dump	= ufs_qcom_dump_dbg_regs,
 };
 
diff --git a/drivers/scsi/ufs/ufs-qcom.h b/drivers/scsi/ufs/ufs-qcom.h
index c114826316eb..540c1d84794d 100644
--- a/drivers/scsi/ufs/ufs-qcom.h
+++ b/drivers/scsi/ufs/ufs-qcom.h
@@ -237,6 +237,7 @@ struct ufs_qcom_host {
 	/* Bitmask for enabling debug prints */
 	u32 dbg_print_en;
 	struct ufs_qcom_testbus testbus;
+	bool is_phy_init;
 };
 
 static inline u32
diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
index 895a9b5ac989..1ad931101bc3 100644
--- a/drivers/scsi/ufs/ufshcd-pltfrm.c
+++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
@@ -36,12 +36,29 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
 
 #include "ufshcd.h"
 #include "ufshcd-pltfrm.h"
 
 #define UFSHCD_DEFAULT_LANES_PER_DIRECTION		2
 
+static int ufshcd_parse_reset_info(struct ufs_hba *hba)
+{
+	int ret = 0;
+
+	hba->core_reset = devm_reset_control_get_optional_exclusive(hba->dev,
+				"rst");
+	if (IS_ERR(hba->core_reset)) {
+		ret = PTR_ERR(hba->core_reset);
+		dev_err(hba->dev, "core_reset unavailable,err = %d\n",
+				ret);
+		hba->core_reset = NULL;
+	}
+
+	return ret;
+}
+
 static int ufshcd_parse_clock_info(struct ufs_hba *hba)
 {
 	int ret = 0;
@@ -221,6 +238,21 @@ static int ufshcd_parse_regulator_info(struct ufs_hba *hba)
 	return err;
 }
 
+static int ufshcd_parse_pinctrl_info(struct ufs_hba *hba)
+{
+	int ret = 0;
+
+	/* Try to obtain pinctrl handle */
+	hba->pctrl = devm_pinctrl_get(hba->dev);
+	if (IS_ERR(hba->pctrl)) {
+		ret = PTR_ERR(hba->pctrl);
+		hba->pctrl = NULL;
+	}
+
+	printk("MYDEBUG: %s=%d\n", __func__, ret);
+	return ret;
+}
+
 #ifdef CONFIG_PM
 /**
  * ufshcd_pltfrm_suspend - suspend power management function
@@ -340,6 +372,19 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
 		goto dealloc_host;
 	}
 
+	err = ufshcd_parse_reset_info(hba);
+	if (err) {
+		dev_err(&pdev->dev, "%s: reset parse failed %d\n",
+				__func__, err);
+	}
+
+	err = ufshcd_parse_pinctrl_info(hba);
+	if (err) {
+		dev_err(&pdev->dev, "%s: unable to parse pinctrl data %d\n",
+				__func__, err);
+		/* let's not fail the probe */
+	}
+
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index f1c57cd33b5b..320bbd9849bc 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -37,6 +37,8 @@
  * license terms, and distributes only under these terms.
  */
 
+#define DEBUG
+#include <linux/pinctrl/consumer.h>
 #include <linux/async.h>
 #include <linux/devfreq.h>
 #include <linux/nls.h>
@@ -110,13 +112,19 @@
 int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
 		     const char *prefix)
 {
-	u8 *regs;
+	u32 *regs;
+	size_t pos;
+
+	if (offset % 4 != 0 || len % 4 != 0) /* keep readl happy */
+		return -EINVAL;
 
 	regs = kzalloc(len, GFP_KERNEL);
 	if (!regs)
 		return -ENOMEM;
 
-	memcpy_fromio(regs, hba->mmio_base + offset, len);
+	for (pos = 0; pos < len; pos += 4)
+		regs[pos / 4] = ufshcd_readl(hba, offset + pos);
+
 	ufshcd_hex_dump(prefix, regs, len);
 	kfree(regs);
 
@@ -2585,6 +2593,7 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
 
 	time_left = wait_for_completion_timeout(hba->dev_cmd.complete,
 			msecs_to_jiffies(max_timeout));
+	printk("%s: time_left=%lu\n", __func__, time_left);
 
 	/* Make sure descriptors are ready before ringing the doorbell */
 	wmb();
@@ -2698,6 +2707,7 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 
 	err = ufshcd_wait_for_dev_cmd(hba, lrbp, timeout);
+	printk("%s = %d\n", "ufshcd_wait_for_dev_cmd", err);
 
 	ufshcd_add_query_upiu_trace(hba, tag,
 			err ? "query_complete_err" : "query_complete");
@@ -3813,6 +3823,15 @@ static int ufshcd_link_recovery(struct ufs_hba *hba)
 	ufshcd_set_eh_in_progress(hba);
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 
+	if (hba->core_reset) {
+		ret = ufshcd_vops_core_reset(hba);
+		if (ret)
+			dev_err(hba->dev,
+				"full reset returned %d, trying to recover the link\n",
+				ret);
+		return ret;
+	}
+
 	ret = ufshcd_host_reset_and_restore(hba);
 
 	spin_lock_irqsave(hba->host->host_lock, flags);
@@ -7252,6 +7271,7 @@ static int ufshcd_init_clocks(struct ufs_hba *hba)
 			goto out;
 		}
 
+		printk("%s: %s max=%u\n", __func__, clki->name, clki->max_freq);
 		if (clki->max_freq) {
 			ret = clk_set_rate(clki->clk, clki->max_freq);
 			if (ret) {
@@ -8113,6 +8133,65 @@ int ufshcd_alloc_host(struct device *dev, struct ufs_hba **hba_handle)
 }
 EXPORT_SYMBOL(ufshcd_alloc_host);
 
+static int ufshcd_device_reset_ctrl(struct ufs_hba *hba, bool ctrl)
+{
+	int ret = 0;
+
+	if (!hba->pctrl)
+		return 0;
+
+	/* Assert reset if ctrl == true */
+	if (ctrl)
+		ret = pinctrl_select_state(hba->pctrl,
+			pinctrl_lookup_state(hba->pctrl, "dev-reset-assert"));
+	else
+		ret = pinctrl_select_state(hba->pctrl,
+			pinctrl_lookup_state(hba->pctrl, "dev-reset-deassert"));
+
+	if (ret < 0)
+		dev_err(hba->dev, "%s: %s failed with err %d\n",
+			__func__, ctrl ? "Assert" : "Deassert", ret);
+
+	return ret;
+}
+
+static inline int ufshcd_assert_device_reset(struct ufs_hba *hba)
+{
+	printk("MYDEBUG: %s\n", __func__);
+	return ufshcd_device_reset_ctrl(hba, true);
+}
+
+static inline int ufshcd_deassert_device_reset(struct ufs_hba *hba)
+{
+	printk("MYDEBUG: %s\n", __func__);
+	return ufshcd_device_reset_ctrl(hba, false);
+}
+
+static int ufshcd_reset_device(struct ufs_hba *hba)
+{
+	int ret;
+
+	/* reset the connected UFS device */
+	ret = ufshcd_assert_device_reset(hba);
+	if (ret)
+		goto out;
+	/*
+	 * The reset signal is active low.
+	 * The UFS device shall detect more than or equal to 1us of positive
+	 * or negative RST_n pulse width.
+	 * To be on safe side, keep the reset low for atleast 10us.
+	 */
+	usleep_range(10, 15);
+
+	ret = ufshcd_deassert_device_reset(hba);
+	if (ret)
+		goto out;
+	/* same as assert, wait for atleast 10us after deassert */
+	usleep_range(10, 15);
+out:
+	return ret;
+}
+
 /**
  * ufshcd_init - Driver initialization routine
  * @hba: per-adapter instance
@@ -8237,6 +8316,16 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 		goto exit_gating;
 	}
 
+	/* Reset controller to power on reset (POR) state */
+	if (hba->core_reset)
+		ufshcd_vops_core_reset(hba);
+
+	/* reset connected UFS device */
+	err = ufshcd_reset_device(hba);
+	if (err)
+		dev_warn(hba->dev, "%s: device reset failed. err %d\n",
+			 __func__, err);
+
 	/* Host controller enable */
 	err = ufshcd_hba_enable(hba);
 	if (err) {
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 1a1c2b487a4e..fb1c25cf33c0 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -55,6 +55,7 @@
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include "unipro.h"
 
 #include <asm/irq.h>
@@ -296,6 +297,8 @@ struct ufs_pwr_mode_info {
  * @apply_dev_quirks: called to apply device specific quirks
  * @suspend: called during host controller PM callback
  * @resume: called during host controller PM callback
+ * @core_reset:  called before UFS PHY init and during link recovery for
+ *		 handling variant specific implementations of resetting the hci
  * @dbg_register_dump: used to dump controller debug information
  * @phy_initialization: used to initialize phys
  */
@@ -324,6 +327,7 @@ struct ufs_hba_variant_ops {
 	int	(*apply_dev_quirks)(struct ufs_hba *);
 	int     (*suspend)(struct ufs_hba *, enum ufs_pm_op);
 	int     (*resume)(struct ufs_hba *, enum ufs_pm_op);
+	int	(*core_reset)(struct ufs_hba *);
 	void	(*dbg_register_dump)(struct ufs_hba *hba);
 	int	(*phy_initialization)(struct ufs_hba *);
 };
@@ -700,11 +704,13 @@ struct ufs_hba {
 	bool is_urgent_bkops_lvl_checked;
 
 	struct rw_semaphore clk_scaling_lock;
+	struct reset_control *core_reset;
 	struct ufs_desc_size desc_size;
 	atomic_t scsi_block_reqs_cnt;
 
 	struct device		bsg_dev;
 	struct request_queue	*bsg_queue;
+	struct pinctrl *pctrl;
 };
 
 /* Returns true if clocks can be gated. Otherwise false */
@@ -1032,6 +1038,13 @@ static inline int ufshcd_vops_resume(struct ufs_hba *hba, enum ufs_pm_op op)
 	return 0;
 }
 
+static inline int ufshcd_vops_core_reset(struct ufs_hba *hba)
+{
+	if (hba->vops && hba->vops->core_reset)
+		return hba->vops->core_reset(hba);
+	return 0;
+}
+
 static inline void ufshcd_vops_dbg_register_dump(struct ufs_hba *hba)
 {
 	if (hba->vops && hba->vops->dbg_register_dump)
diff --git a/include/dt-bindings/clock/qcom,gcc-msm8998.h b/include/dt-bindings/clock/qcom,gcc-msm8998.h
index 58a242e656b1..7cdbff00b9a0 100644
--- a/include/dt-bindings/clock/qcom,gcc-msm8998.h
+++ b/include/dt-bindings/clock/qcom,gcc-msm8998.h
@@ -180,6 +180,12 @@
 #define USB30_MASTER_CLK_SRC					163
 #define USB30_MOCK_UTMI_CLK_SRC					164
 #define USB3_PHY_AUX_CLK_SRC					165
+#define GCC_USB3_CLKREF_CLK					166
+#define GCC_HDMI_CLKREF_CLK					167
+#define GCC_UFS_CLKREF_CLK					168
+#define GCC_PCIE_CLKREF_CLK					169
+#define GCC_RX1_USB2_CLKREF_CLK					170
+#define UFS_UNIPRO_CORE_CLK_SRC					171
 
 #define PCIE_0_GDSC						0
 #define UFS_GDSC						1
diff --git a/include/dt-bindings/clock/qcom,rpmcc.h b/include/dt-bindings/clock/qcom,rpmcc.h
index c585b82b9c05..81dbd1f07e36 100644
--- a/include/dt-bindings/clock/qcom,rpmcc.h
+++ b/include/dt-bindings/clock/qcom,rpmcc.h
@@ -123,5 +123,15 @@
 #define RPM_SMD_DIV_A_CLK3			73
 #define RPM_SMD_LN_BB_CLK			74
 #define RPM_SMD_LN_BB_A_CLK			75
+#define RPM_SMD_BIMC_GPU_CLK			76
+#define RPM_SMD_BIMC_GPU_A_CLK			77
+#define RPM_SMD_QPIC_CLK			78
+#define RPM_SMD_QPIC_CLK_A			79
+#define RPM_SMD_BB_CLK3_PIN			80
+#define RPM_SMD_BB_CLK3_A_PIN			81
+#define RPM_SMD_RF_CLK3				82
+#define RPM_SMD_RF_CLK3_A			83
+#define RPM_SMD_RF_CLK3_PIN			84
+#define RPM_SMD_RF_CLK3_A_PIN			85
 
 #endif

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
