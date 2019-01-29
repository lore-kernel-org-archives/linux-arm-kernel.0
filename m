Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44472C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:54:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1459620989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j8Kdg5Zj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dr0A3bLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1459620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gC2i9ZpSY7D2acUQ8DZGDBsKQ622Fq4ngIApY9PNjIc=; b=j8Kdg5Zj8UjrpR
	oFGDirKYDvOS7EbqL0D6fTSuSSijsBxHiWRh0n436K27PMeLTWGZsJo0eEbl4pDwHl/l4zBZQDwpx
	Q0NwENarpsuv15v2dmlb+nb3HaDOtL3EAbUQn13yWMYUA8No3790rm603r68l686cd5rLokhissYk
	WZrDLrx+NTVqi3lZEmAIYtTRpxmTCYKMLVqF49DurYurX9XfcEEKMnXSQFmznR8fDKt4nrVcKp43S
	RYoK8trY8Z/xXhmnEQblZ9lUGRTGRpUmTeCOfOG5eT6x6dZWrX6oP2IhWDNWgUUEsCdoMDwxAD4a1
	GrGap7eIhMIQwCuzSRKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goTpv-0007xs-0L; Tue, 29 Jan 2019 13:53:59 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goTpq-0007xA-7j
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 13:53:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HWL/qnb3kbO1zthUdqvwoeKKfOJfY2stseiaFy1yfuE=; b=dr0A3bLynP/MeQkT3GP9vRss6
 NK9krfhUZ9dwpQaQzINk8R7/b/JWjzEzrs3LeIJwmPjMBE3qQO/HraZNvOauOU2KVxZSDgqpdD/g5
 m8oEXFeZmpEDPTwFS7kGwpKCoJPQfKQp+CEg3Fw2EWT3BCodC6rz1uobVKv8IsRFqAE/4=;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55532)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1goTpk-0008VV-IA; Tue, 29 Jan 2019 13:53:48 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1goTpi-0005MW-MU; Tue, 29 Jan 2019 13:53:46 +0000
Date: Tue, 29 Jan 2019 13:53:46 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Leigh Brown <leigh@solinno.co.uk>
Subject: Re: Out-of-tree mwlwifi driver crashes
Message-ID: <20190129135346.tg2cefmyfvq2dxc5@e5254000004ec.dyn.armlinux.org.uk>
References: <01e409217be1c1cb08ac3bab072fccd3@solinno.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <01e409217be1c1cb08ac3bab072fccd3@solinno.co.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_055354_724047_DD61925B 
X-CRM114-Status: GOOD (  21.08  )
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
Cc: linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 29, 2019 at 01:47:38PM +0000, Leigh Brown wrote:
> Hi Thomas,
> 
> The following commit causes the out-of-tree mwlwifi driver [1] to crash,
> which
> I have found with git bisect.
> 
> commit 1f08673eef1236f7d02d93fcf596bb8531ef0d12
> Author: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Date:   Thu Oct 18 17:37:18 2018 +0200
> 
>     PCI: mvebu: Convert to PCI emulated bridge config space
> 
>     Convert the pci-mvebu driver to use the pci-bridge-emul logic, that
>     helps emulating a root port PCI bridge configuration space.
> 
>     Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
>     [lorenzo.pieralisi@arm.com: updated commit log]
>     Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> I have raised the issue with the driver maintainers but they responded that
> this is a kernel regression [2].
> 
> Do you think this is a driver issue or a regression? I am happy to test
> proposed
> fixes but I don't understand enough about the driver or PCI to investigate.
> 
> If I revert that single commit, the issue goes away.
> 
> Any help would be gratefully received.
> 
> The crash dump is as follows:
> 
> pgd = f47c1616

All crash dumps have a line before this which describes why the crash
dump is being produced - cutting it out of the crash dump makes it
much harder to know what happened.  Please re-post with the full crash
dump.  Thanks.

> [d1480c14] *pgd=16096811, *pte=e0100243, *ppte=e0100013
> Internal error: : 1008 [#1] SMP THUMB2
> Modules linked in: sg(+) mwlwifi(+)
> CPU: 1 PID: 426 Comm: systemd-udevd Not tainted 4.20.3+ #11
> Hardware name: Marvell Armada 380/385 (Device Tree)
> PC is at pcie_reset+0xb/0x40 [mwlwifi]
> LR is at pcie_download_firmware+0x18/0x2fc [mwlwifi]
> pc : [<af80ac2c>]    lr : [<af80ac79>]    psr: 60070133
> sp : ce3a9c58  ip : c9318180  fp : b0847eec
> r10: b0804c08  r9 : c9318140  r8 : 000029a4
> r7 : 00000000  r6 : ce380440  r5 : ce380de0  r4 : ce3857a0
> r3 : ce380de0  r2 : d1480000  r1 : ce380de0  r0 : ce380440
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Segment none
> Control: 50c5387d  Table: 1e3ac04a  DAC: 00000051
> Process systemd-udevd (pid: 426, stack limit = 0x1e0d6d10)
> Stack: (0xce3a9c58 to 0xce3aa000)
> 9c40:                                                       ce3857a0
> af80ac79
> 9c60: cf443870 000029a4 000029a8 b0804c08 00000000 ce380de0 af81336a
> 00000000
> 9c80: 00000000 000029a4 000029a8 b0804c08 b0847eec af803875 1e3fc000
> c60c6040
> 9ca0: ce380440 b0804c08 cf443870 5e4e1a10 00100000 cf443800 ce3857a0
> ce380440
> 9cc0: ce380de0 cf443800 af812290 cf443870 b0847eec af80a52f 00019100
> af815104
> 9ce0: af815104 cf443870 cf443800 00000000 af8150b4 af81507c 00000013
> b02629cf
> 9d00: b0262963 cf443870 00000000 00000000 b0847ee0 00000000 af8150b4
> b028e12f
> 9d20: 00000000 cf443870 af8150b4 af8150b4 b028e429 00000000 00000024
> 00000028
> 9d40: c93186e4 b028e40b af8150b4 cf443870 00000000 cf443870 cf4438a4
> af8150b4
> 9d60: b028e429 00000000 00000024 b028e473 cf443870 b0804c08 af8150b4
> b028d1c9
> 9d80: ce3a9da8 cf414c58 ce9a1db4 5e4e1a10 00000000 af8150b4 c60c6e00
> 00000000
> 9da0: b08173fc b028d6a3 af8130db af8130dc 0000006d af8150b4 b0804c08
> af833001
> 9dc0: ffffe000 b028e8fd af8150fc b0831300 b0804c08 b0102601 00000001
> 006000c0
> 9de0: ce29e000 ce93a240 cf4e9b40 cf501400 ce29e000 00003bdd 8040003f
> ce29e000
> 9e00: 80000000 5e4e1a10 ce37bf80 cffc0f60 00000001 00000001 cffc0f60
> 00000001
> 9e20: 00000001 5e4e1a10 af815640 af815640 c9318b80 c93186c0 00000001
> b016020d
> 9e40: af815640 b072f5fc ce3a9f40 af815640 00000001 b015f877 af81564c
> 00007fff
> 9e60: af815640 b015dc91 ce248488 af815688 b015dbd1 b080f790 b0502ac8
> d128a440
> 9e80: a6f1bbb8 000001f8 ce3a8000 af000000 00000000 b0804c08 ce3a9ec0
> b01a133f
> 9ea0: 00000000 00000000 00000000 00000000 00000000 00000000 6e72656b
> 00006c65
> 9ec0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000
> 9ee0: 00000000 00000000 00000000 00000000 00000000 5e4e1a10 7fffffff
> 00000000
> 9f00: b0804c08 a6f1bbb8 00000006 b0101224 ce3a8000 0000017b 02147238
> b015fd1b
> 9f20: 7fffffff 00000000 00000003 00000000 0001b4b8 d126f000 0001b4b8
> 00000000
> 9f40: d127f730 d127ff00 d126f000 0001b4b8 d1289ea0 d1289d14 d1283d38
> 00013000
> 9f60: 00014f90 00000000 00000000 00000000 000061e4 00000024 00000025
> 0000001b
> 9f80: 00000000 00000013 00000000 5e4e1a10 00000006 02147238 0213c3c8
> f739ef00
> 9fa0: 0000017b b0101001 02147238 0213c3c8 00000006 a6f1bbb8 00000000
> a6f1c398
> 9fc0: 02147238 0213c3c8 f739ef00 0000017b 00020000 004ef6c4 00000000
> 02147238
> 9fe0: ae813948 ae813938 a6f15aeb a6e25fc2 600f0030 00000006 00000000
> 00000000
> [<af80ac2c>] (pcie_reset [mwlwifi]) from [<af80ac79>]
> (pcie_download_firmware+0x18/0x2fc [mwlwifi])
> [<af80ac79>] (pcie_download_firmware [mwlwifi]) from [<af803875>]
> (mwl_init_hw+0xf8/0x8b0 [mwlwifi])
> [<af803875>] (mwl_init_hw [mwlwifi]) from [<af80a52f>]
> (pcie_probe+0x18e/0x1e8 [mwlwifi])
> [<af80a52f>] (pcie_probe [mwlwifi]) from [<b02629cf>]
> (pci_device_probe+0x6d/0xb6)
> [<b02629cf>] (pci_device_probe) from [<b028e12f>] (really_probe+0x137/0x1c4)
> [<b028e12f>] (really_probe) from [<b028e40b>]
> (driver_probe_device+0xef/0x10c)
> [<b028e40b>] (driver_probe_device) from [<b028e473>]
> (__driver_attach+0x4b/0x6e)
> [<b028e473>] (__driver_attach) from [<b028d1c9>]
> (bus_for_each_dev+0x31/0x5c)
> [<b028d1c9>] (bus_for_each_dev) from [<b028d6a3>]
> (bus_add_driver+0xd7/0x130)
> [<b028d6a3>] (bus_add_driver) from [<b028e8fd>] (driver_register+0x5b/0x8a)
> [<b028e8fd>] (driver_register) from [<b0102601>] (do_one_initcall+0x45/0xfc)
> [<b0102601>] (do_one_initcall) from [<b016020d>] (do_init_module+0x39/0x134)
> [<b016020d>] (do_init_module) from [<b015f877>] (load_module+0x1141/0x1492)
> [<b015f877>] (load_module) from [<b015fd1b>] (sys_finit_module+0x53/0x6c)
> [<b015fd1b>] (sys_finit_module) from [<b0101001>]
> (ret_fast_syscall+0x1/0x62)
> Exception stack(0xce3a9fa8 to 0xce3a9ff0)
> 9fa0:                   02147238 0213c3c8 00000006 a6f1bbb8 00000000
> a6f1c398
> 9fc0: 02147238 0213c3c8 f739ef00 0000017b 00020000 004ef6c4 00000000
> 02147238
> 9fe0: ae813948 ae813938 a6f15aeb a6e25fc2
> Code: 727c 6b43 589c 68e2 (f8d2) 2c14
> ---[ end trace 57b500d8bc2ce2a5 ]---
> Kernel panic - not syncing: Fatal exception
> CPU0: stopping
> CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D           4.20.3+ #11
> Hardware name: Marvell Armada 380/385 (Device Tree)
> [<b010a691>] (unwind_backtrace) from [<b0108017>] (show_stack+0xb/0xc)
> [<b0108017>] (show_stack) from [<b043c073>] (dump_stack+0x5b/0x70)
> [<b043c073>] (dump_stack) from [<b0109ba5>] (handle_IPI+0x95/0x118)
> [<b0109ba5>] (handle_IPI) from [<b0250a85>] (gic_handle_irq+0x59/0x68)
> [<b0250a85>] (gic_handle_irq) from [<b0101a65>] (__irq_svc+0x65/0x94)
> Exception stack(0xb0801f20 to 0xb0801f68)
> 1f20: 00000000 00042a24 cfbd42a0 b010e121 00000000 b0800000 b0804c08
> 00000000
> 1f40: 00000001 b0801f78 b0804c68 00000000 00000008 b0801f70 b010636f
> b0106366
> 1f60: 40010033 ffffffff
> [<b0101a65>] (__irq_svc) from [<b0106366>] (arch_cpu_idle+0xc/0x1e)
> [<b0106366>] (arch_cpu_idle) from [<b0132d9b>] (do_idle+0xd7/0x17c)
> [<b0132d9b>] (do_idle) from [<b0132fab>] (cpu_startup_entry+0x13/0x14)
> [<b0132fab>] (cpu_startup_entry) from [<b0700937>]
> (start_kernel+0x25f/0x2dc)
> 
> [1]: https://github.com/kaloz/mwlwifi/
> [2]: https://github.com/kaloz/mwlwifi/issues/345
> 
> Regards,
> 
> Leigh.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
