Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C70CC282CF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:55:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 085002147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CUfdpypb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085002147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IKWUcbu6/3evnXJskHk+/f3WCSgLyjhpx2ItWuAvTeM=; b=CUfdpypbvHefNZ
	CPR7sJn+2Iaos85VHJYScSZ5Sct2bxFNcQBFqpJBnUkSYy5OMYwEaLHi+N+GwkgUYniWvO4yNFliP
	kiEPGx+RrEDLvF6Eni9Xf05xU+cvOi20WN7mhHpBaRfJ6CWL7NE7emYETXfKi+jCpzfBAb5dbAoS7
	jiPiLAGeH0cpJzV/YZvf6rY0aEBFJN8W4pcZa7E9ctap6wpmZTXC3cs0gcFGIrkQJs1u5r/CNSDk5
	bd4p5umIYOfP80mxjQTGVdzkt2ZrFIg3bw1HWVHz+lD13Z0dXjqE1TwC9AmXB1H+BCht8c7cNTkLb
	pyB4GJrjM1CxrLIGwmow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goABT-0006MT-LC; Mon, 28 Jan 2019 16:54:55 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goABP-0006Kp-UH
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 16:54:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0427F15AD;
 Mon, 28 Jan 2019 08:54:49 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 393C33F59C;
 Mon, 28 Jan 2019 08:54:48 -0800 (PST)
Subject: Re: BUG: sleeping function called from invalid context at
 kernel/locking/mutex.c:908
To: John Stultz <john.stultz@linaro.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <CALAqxLX0P6P4xnv=HgQsP-Cv4dkGJhkkMRn7jy-sbzZKUa1z4w@mail.gmail.com>
From: Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <747e7740-b5d3-3ed1-17ed-21401cef1711@arm.com>
Date: Mon, 28 Jan 2019 16:54:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CALAqxLX0P6P4xnv=HgQsP-Cv4dkGJhkkMRn7jy-sbzZKUa1z4w@mail.gmail.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_085451_982779_B628F9FB 
X-CRM114-Status: GOOD (  20.04  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <Will.Deacon@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi John,

Sorry I had missed that thread, Marc brought it up to me

On 24/01/2019 05:36, John Stultz wrote:
> Trying to boot hikey960 with v5.0-rc3 (and Valentin's 2 recent lockdep
> fixes), with lock debugging enabled, I'm seeing the BUG below.
> 
> Wanted to see if anyone else had seen this or had ideas at what was going on.
> 
> thanks
> -john
> 
> [    0.183376] Detected VIPT I-cache on CPU4
> [    0.183388] CPU features: SANITY CHECK: Unexpected variation in
> SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU4:
> 0x00000000101122
> [    0.183399] CPU features: Unsupported CPU feature variation detected.
> [    0.183417] BUG: sleeping function called from invalid context at
> kernel/locking/mutex.c:908
> [    0.183421] in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/4
> [    0.183451] no locks held by swapper/4/0.
> [    0.183454] irq event stamp: 0
> [    0.183459] hardirqs last  enabled at (0): [<0000000000000000>]
>       (null)
> [    0.183474] hardirqs last disabled at (0): [<ffffff80100f2af0>]
> copy_process.isra.3.part.4+0x450/0x17b0
> [    0.183479] softirqs last  enabled at (0): [<ffffff80100f2af0>]
> copy_process.isra.3.part.4+0x450/0x17b0
> [    0.183483] softirqs last disabled at (0): [<0000000000000000>]
>       (null)
> [    0.183485] Preemption disabled at:
> [    0.183493] [<ffffff801009b680>] secondary_start_kernel+0xc0/0x1f8
> [    0.183501] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G S
>   5.0.0-rc3-00002-g4daf5b1 #372
> [    0.183504] Hardware name: HiKey960 (DT)
> [    0.183508] Call trace:
> [    0.183515]  dump_backtrace+0x0/0x150
> [    0.183518]  show_stack+0x24/0x30
> [    0.183526]  dump_stack+0xa0/0xd4
> [    0.183532]  ___might_sleep+0x1e4/0x240
> [    0.183535]  __might_sleep+0x58/0x90
> [    0.183540]  __mutex_lock+0x64/0x890
> [    0.183543]  mutex_lock_nested+0x3c/0x50
> [    0.183549]  static_key_enable_cpuslocked+0x64/0xd8
> [    0.183556]  arch_timer_check_ool_workaround+0x208/0x260
> [    0.183559]  arch_timer_starting_cpu+0xfc/0x2f8
> [    0.183563]  cpuhp_invoke_callback+0xd8/0xce0
> [    0.183567]  notify_cpu_starting+0x84/0xa0
> [    0.183570]  secondary_start_kernel+0xec/0x1f8
> [    0.183601] arch_timer: Enabling local workaround for ARM erratum 858921
> [    0.183618] arch_timer: CPU4: Trapping CNTVCT access
> [    0.183625] CPU4: Booted secondary processor 0x0000000100 [0x410fd091]
> 

Urgh, I was going to say I don't get that warning with the lockdep patches,
but I just realized you actually get a different warning because you have
DEBUG_ATOMIC_SLEEP. I'll see if I can make sense of this one, it reminds me
of [1] although we already have the _cpuslocked variant.

FWIW I don't have the heart to delete the rest, so if you want to compare
John's log with mine you can see it's a warning in the same area but not
the same actual warning.

[1]: https://lkml.org/lkml/2018/4/29/106

-----8<-----

Just gave it a spin on v5.0-rc4 - I still have the CPU features warning,
but none of the timer workarounds.

This is what I get with just an extra defconfig patch to get to load my
userspace [2]:

[    0.780221] Detected VIPT I-cache on CPU4
[    0.780232] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU4: 0x00000000101122
[    0.780241] CPU features: Unsupported CPU feature variation detected.
[    0.780275] WARNING: CPU: 4 PID: 0 at kernel/cpu.c:316 lockdep_assert_cpus_held+0x30/0x40
[    0.780279] Modules linked in:
[    0.780289] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G S                5.0.0-rc4-00001-g99274c821251 #29
[    0.780292] Hardware name: HiKey960 (DT)
[    0.780296] pstate: 600001c5 (nZCv dAIF -PAN -UAO)
[    0.780300] pc : lockdep_assert_cpus_held+0x30/0x40
[    0.780304] lr : lockdep_assert_cpus_held+0x2c/0x40
[    0.780306] sp : ffff0000128d3e50
[    0.780308] x29: ffff0000128d3e50 x28: 0000000000000000 
[    0.780313] x27: 0000000000000001 x26: ffff8000bf970fd0 
[    0.780317] x25: ffff000010acf8e8 x24: 0000000000000001 
[    0.780321] x23: ffff000010ef6000 x22: ffff000010acfe10 
[    0.780324] x21: 0000000000000001 x20: 0000000000000003 
[    0.780328] x19: ffff00001225f9e8 x18: ffffffffffffffff 
[    0.780332] x17: 0000000000000000 x16: 0000000000000000 
[    0.780335] x15: ffff000011484000 x14: 00000000fffffff0 
[    0.780340] x13: 00000000ca811012 x12: ffff8000bcb2e1e8 
[    0.780343] x11: ffff00001220d000 x10: ffff000011463808 
[    0.780347] x9 : 0000000000000000 x8 : ffff000011463808 
[    0.780351] x7 : ffff000010177950 x6 : ffff000011478c78 
[    0.780355] x5 : ffff000011463830 x4 : 0000000000000001 
[    0.780358] x3 : 0000000000000000 x2 : 0000000000000001 
[    0.780362] x1 : 00000000ffffffff x0 : 0000000000000000 
[    0.780367] Call trace:
[    0.780371]  lockdep_assert_cpus_held+0x30/0x40
[    0.780378]  static_key_enable_cpuslocked+0x20/0xc8
[    0.780385]  arch_timer_check_ool_workaround+0xe0/0x220
[    0.780391]  arch_timer_starting_cpu+0xdc/0x2d0
[    0.780394]  cpuhp_invoke_callback+0xd8/0xcc8
[    0.780398]  notify_cpu_starting+0x70/0xa8
[    0.780404]  secondary_start_kernel+0x120/0x1d8
[    0.780407] irq event stamp: 0
[    0.780410] hardirqs last  enabled at (0): [<0000000000000000>]           (null)
[    0.780415] hardirqs last disabled at (0): [<ffff0000100e4fc0>] copy_process.isra.3.part.4+0x540/0x1850
[    0.780419] softirqs last  enabled at (0): [<ffff0000100e4fc0>] copy_process.isra.3.part.4+0x540/0x1850
[    0.780421] softirqs last disabled at (0): [<0000000000000000>]           (null)
[    0.780428] ---[ end trace 651209311577d561 ]---

(and same bizz for CPUs [5-7])

This is what I get when the 2 lockdep patches are applied:

[    0.780276] Detected VIPT I-cache on CPU4
[    0.780286] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU4: 0x00000000101122
[    0.780296] CPU features: Unsupported CPU feature variation detected.
[    0.780333] arch_timer: Enabling local workaround for ARM erratum 858921
[    0.780349] arch_timer: CPU4: Trapping CNTVCT access
[    0.780356] CPU4: Booted secondary processor 0x0000000100 [0x410fd091]
[    0.810727] Detected VIPT I-cache on CPU5
[    0.810734] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU5: 0x00000000101122
[    0.810745] arch_timer: Enabling local workaround for ARM erratum 858921
[    0.810754] arch_timer: CPU5: Trapping CNTVCT access
[    0.810759] CPU5: Booted secondary processor 0x0000000101 [0x410fd091]
[    0.842867] Detected VIPT I-cache on CPU6
[    0.842873] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU6: 0x00000000101122
[    0.842884] arch_timer: Enabling local workaround for ARM erratum 858921
[    0.842893] arch_timer: CPU6: Trapping CNTVCT access
[    0.842899] CPU6: Booted secondary processor 0x0000000102 [0x410fd091]
[    0.874936] Detected VIPT I-cache on CPU7
[    0.874943] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU7: 0x00000000101122
[    0.874954] arch_timer: Enabling local workaround for ARM erratum 858921
[    0.874963] arch_timer: CPU7: Trapping CNTVCT access
[    0.874968] CPU7: Booted secondary processor 0x0000000103 [0x410fd091]
[    0.875135] smp: Brought up 1 node, 8 CPUs
[    1.063435] SMP: Total of 8 processors activated.
[    1.068232] CPU features: detected: 32-bit EL0 Support
[    1.073501] CPU features: detected: CRC32 instructions
[    1.079747] CPU: All CPU(s) started at EL2

I did double-check and I have lockdep in both cases:

zcat /proc/config.gz | grep LOCKDEP
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set

[2]: 

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c8432e24207e..fb84abfd4caa 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -219,10 +219,10 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_SAS_ATA=y
 CONFIG_SCSI_HISI_SAS=y
 CONFIG_SCSI_HISI_SAS_PCI=y
-CONFIG_SCSI_UFSHCD=m
-CONFIG_SCSI_UFSHCD_PLATFORM=m
+CONFIG_SCSI_UFSHCD=y
+CONFIG_SCSI_UFSHCD_PLATFORM=y
+CONFIG_SCSI_UFS_HISI=y
 CONFIG_SCSI_UFS_QCOM=m
-CONFIG_SCSI_UFS_HISI=m
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_SATA_AHCI_PLATFORM=y

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
