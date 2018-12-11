Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E384C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:16:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 011C920849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="khouaDQB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q16MKVaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011C920849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F6U1Nd2uPwJBmcJ+t2upczTmwukD99XhvyMF50CMi/U=; b=khouaDQB1TK35X
	zni29R0hLTcdQiFUNyrR9u/4s1MiVEHMquPRvWl3pB9ASx8jrD18IMxpnuSgRxRbXdnbr9mc4dJN5
	GzfUjS4amdeHnbQJ/yLuxBsyxcrSG63BkvYi9ybyyhuBtERojsyzQ++5Xib7pe/Qrudu7VMO6+gyF
	eHH7zEcbkHtDzNNOBGEpX0SER/ZEJ1ey/Jv5BMDiuCEOa3Jl9Zf7VQoZ3KYMUxx5zCYDIP+C+hiNN
	dAORb+gEw2K0O5IwaY2is/xLKdy0EruZjvM6mbURCr93OPLhWXf5bLFjg2P1z4KLfQBL3Myc65qJZ
	79MvTKUJ4Z4rohXSoEJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWoRv-0002xu-7t; Tue, 11 Dec 2018 20:16:11 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWoRp-0002xG-DB
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 20:16:09 +0000
Received: by mail-wm1-x341.google.com with SMTP id a62so3559671wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 12:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=R9sDS/Q5gGgepGaD1x4UJiVCeRSfzStd3Fy59/HioRY=;
 b=q16MKVafo9bc+gSMtfuh9zDZ4v7i9DV0F/B/+PpMOJdWDpDcbze6G8xcIKIAAJko5l
 QLknhBPdSF6Iqay/AL/+pzAYG6YMSA2xe553il2RRjmw8aUlmZKfXz2XrveqZkI1Uh4b
 yqDPnBzM99UrtBYwWYYrCe14WEk2PQ6l506aftX7Q6zA8FaEFmFgk1hWhWlPU3+3QGp6
 k7k5cFfARjurFI0I9iWCfrQQYayuBSroO/tR6bL2tiju7en9VDCxDlqK8g68+dLlbwp1
 uEZGowTV84xJWl1J5by8kIWsfZSKxHjsRi0dD5+0k8EqZ2YcSMQB7LJNG+6nnQS1b2io
 PmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=R9sDS/Q5gGgepGaD1x4UJiVCeRSfzStd3Fy59/HioRY=;
 b=i2h/xBHYkuEcCTnl+ZnC8Wv/fD8Wx7oAqVOj5ZZ51haCgV1uY3WDeUbGkdAXeHvbQi
 R1lsW0RWbpoVXRc2fyEyCVt+1qQ7PK7oSv9wUNigLIAF2sNp9SD1z045G75DX6VhN6JV
 ygpI3zZMWtByhnnY101Ji9H23l5atREuoN0UUmbStx0CcSaxA8ewD1rogwLgLZ7IIBds
 xm5zdUHweAZuuHyvp3pza7drOv3sw6b9a9EmmvPSGIU1C0MBsw0R6S+2xpX5ffLZhJwH
 fNo0b014E+1AGQ58l7330k0DA5cXoFCE7LKQToxESlh9CQLGvgkuRqs3C2KvhSJ7il1/
 6IsQ==
X-Gm-Message-State: AA+aEWa7uzhgdR6he8GsrNl+swBltVrbEcW6VKOFFsiVyZF4JU2i+PVQ
 gX6c8clCjhdfjA8sgbhtfRs=
X-Google-Smtp-Source: AFSGD/WNk35UYMUwlyzH6T4KK5e8cxF3t6vhBV51eVwamA+qI3CfmTR4ATtRwU6li5nJ8HEkTLzKYg==
X-Received: by 2002:a1c:6a09:: with SMTP id f9mr3874303wmc.150.1544559350873; 
 Tue, 11 Dec 2018 12:15:50 -0800 (PST)
Received: from joyx-ThinkPad-T430
 (cpc91194-cmbg18-2-0-cust492.5-4.cable.virginm.net. [80.6.181.237])
 by smtp.gmail.com with ESMTPSA id n9sm15650408wrx.80.2018.12.11.12.15.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Dec 2018 12:15:50 -0800 (PST)
Date: Tue, 11 Dec 2018 20:15:45 +0000
From: Wei Xu <xuwei04@gmail.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: next/master boot: 175 boots: 18 failed, 143 passed with 10
 offline, 1 untried/unknown, 3 conflicts (next-20181211)
Message-ID: <20181211201545.GA18349@joyx-ThinkPad-T430>
References: <5c0fb738.1c69fb81.f62ad.3f45@mx.google.com>
 <20181211152311.GK6686@sirena.org.uk>
 <e6995b4a-184a-d8d4-f4d4-9ce75d8f47c0@huawei.com>
 <20181211165031.GN6686@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211165031.GN6686@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_121605_468057_46E2C5EF 
X-CRM114-Status: GOOD (  14.31  )
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
Cc: kernel-build-reports@lists.linaro.org, catalin.marinas@arm.com,
 John Garry <john.garry@huawei.com>, will.deacon@arm.com,
 Wei Xu <xuwei5@hisilicon.com>,
 Guillaume Tucker <guillaume.tucker@collabora.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 04:50:31PM +0000, Mark Brown wrote:
> On Tue, Dec 11, 2018 at 04:24:10PM +0000, John Garry wrote:
> > On 11/12/2018 15:23, Mark Brown wrote:
> > > On Tue, Dec 11, 2018 at 05:10:16AM -0800, kernelci.org bot wrote:
> 
> > > >     defconfig:
> > > >         hip07-d05:
> > > >             lab-collabora: new failure (last pass: next-20181210)
> 
> > > It takes an oops during IPMI initialization:
> 
> > I have seen this issue previously. It would be specific to D05. I think that
> > there is an issue with the FW in this board, in that DMI reports IPMI
> > support incorrectly.
> 
> > Could we add a kernel command-line to avoid IPMI detection from DMI,
> > ipmi_si.trydmi=0
> 
> Copying in Guillaume who can hopefully help with that (and who I
> should've copied in originally, sorry).

Hi all,

I tested next-20181210 on D05 and found it works well.
I think it caused by the FW.

The log is as below:
	[    0.000000] Booting Linux on physical CPU 0x0000010000 [0x410fd082]
	[    0.000000] Linux version 4.20.0-rc6-next-20181211 (joyx@htsatcamb-server) (gcc version 7.3.1 20180425 [linaro-7.3-2018.05 revision d29120a424ecfbc167ef90065c0eeb7f91977701] (Linaro GCC 7.3-2018.05)) #48 SMP PREEMPT Tue Dec 11 16:57:30 GMT 2018
	[    0.000000] Machine model: Hisilicon Hip07 D05 Development Board
	[    0.000000] efi: Getting EFI parameters from FDT:
	[    0.000000] efi: EFI v2.60 by EDK II
	[    0.000000] efi:  SMBIOS=0x3f050000  SMBIOS 3.0=0x39b00000  ACPI=0x39bd0000  ACPI 2.0=0x39bd0014  MEMATTR=0x3ccc4018  MEMRESERVE=0x31902e98
	[    0.000000] cma: Reserved 32 MiB at 0x000000003d000000
	[    0.000000] OF: NUMA: parsing numa-distance-map-v1
	[    0.000000] NUMA: Warning: invalid memblk node 4 [mem 0x1040000000-0x1ffbffffff]
	[    0.000000] NUMA: Faking a node at [mem 0x0000000000000000-0x0000041ffbffffff]
	[    0.000000] NUMA: NODE_DATA [mem 0x41febf98840-0x41febf99fff]
	[    0.000000] Zone ranges:
	[    0.000000]   DMA32    [mem 0x0000000000000000-0x00000000ffffffff]
	[    0.000000]   Normal   [mem 0x0000000100000000-0x0000041ffbffffff]
	[    0.000000] Movable zone start for each node
	[    0.000000] Early memory node ranges
	[    0.000000]   node   0: [mem 0x0000000000000000-0x0000000031902fff]
	[    0.000000]   node   0: [mem 0x0000000031903000-0x0000000031906fff]
	[    0.000000]   node   0: [mem 0x0000000031907000-0x000000003999ffff]
	[    0.000000]   node   0: [mem 0x00000000399a0000-0x0000000039a3ffff]
	[    0.000000]   node   0: [mem 0x0000000039a40000-0x0000000039a8ffff]
	[    0.000000]   node   0: [mem 0x0000000039a90000-0x0000000039a9ffff]
	[    0.000000]   node   0: [mem 0x0000000039aa0000-0x0000000039aeffff]
	[    0.000000]   node   0: [mem 0x0000000039af0000-0x0000000039bbffff]
	[    0.000000]   node   0: [mem 0x0000000039bc0000-0x0000000039bdffff]
	[    0.000000]   node   0: [mem 0x0000000039be0000-0x000000003a05ffff]
	[    0.000000]   node   0: [mem 0x000000003a060000-0x000000003f04ffff]
	[    0.000000]   node   0: [mem 0x000000003f050000-0x000000003f07ffff]
	[    0.000000]   node   0: [mem 0x000000003f080000-0x000000003fbfffff]
	[    0.000000]   node   0: [mem 0x0000001040000000-0x0000001ffbffffff]
	[    0.000000]   node   0: [mem 0x0000041000000000-0x0000041ffbffffff]
	[    0.000000] Zeroed struct page in unavailable ranges: 148 pages
	[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x0000041ffbffffff]
	[    0.000000] psci: probing for conduit method from DT.
	[    0.000000] psci: PSCIv1.0 detected in firmware.
	[    0.000000] psci: Using standard PSCI v0.2 function IDs
	[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
	[    0.000000] psci: SMC Calling Convention v1.0
	[    0.000000] random: get_random_bytes called from start_kernel+0xa8/0x40c with crng_init=0
	[    0.000000] percpu: Embedded 23 pages/cpu @(____ptrval____) s55704 r8192 d30312 u94208
	[    0.000000] Detected PIPT I-cache on CPU0
	[    0.000000] CPU features: detected: EL2 vector hardening
	[    0.000000] CPU features: detected: Kernel page table isolation (KPTI)
	[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 32996880
	[    0.000000] Policy zone: Normal
	[    0.000000] Kernel command line: BOOT_IMAGE=/joyx/Image rdinit=/init acpi=off
	[    0.000000] printk: log_buf_len individual max cpu contribution: 4096 bytes
	[    0.000000] printk: log_buf_len total cpu_extra contributions: 258048 bytes
	[    0.000000] printk: log_buf_len min size: 131072 bytes
	[    0.000000] printk: log_buf_len: 524288 bytes
	[    0.000000] printk: early log buf free: 126460(96%)
	[    0.000000] software IO TLB: mapped [mem 0x359a0000-0x399a0000] (64MB)
	[    0.000000] Memory: 131560596K/134082560K available (11068K kernel code, 1570K rwdata, 5332K rodata, 1408K init, 379K bss, 2489196K reserved, 32768K cma-reserved)
	[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=64, Nodes=1
	[    0.000000] rcu: Preemptible hierarchical RCU implementation.
	[    0.000000]  Tasks RCU enabled.
	[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
	[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
	[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
	[    0.000000] GICv3: Distributor has no Range Selector support
	[    0.000000] GICv3: VLPI support, direct LPI support
	[    0.000000] GICv3: CPU0: found redistributor 10000 region 0:0x000000004d100000
	[    0.000000] ITS [mem 0x4c000000-0x4c03ffff]
	[    0.000000] ITS@0x000000004c000000: Using ITS number 0
	[    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
	[    0.000000] ITS@0x000000004c000000: allocated 524288 Devices @41feac00000 (flat, esz 8, psz 16K, shr 1)
	[    0.000000] ITS@0x000000004c000000: allocated 65536 Virtual CPUs @41feb580000 (flat, esz 8, psz 4K, shr 1)
	[    0.000000] ITS@0x000000004c000000: allocated 512 Interrupt Collections @41feb52a000 (flat, esz 8, psz 4K, shr 1)
	[    0.000000] ITS [mem 0x6c000000-0x6c03ffff]
	[    0.000000] ITS@0x000000006c000000: Using ITS number 1
	[    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
	[    0.000000] ITS@0x000000006c000000: allocated 524288 Devices @41fea800000 (flat, esz 8, psz 16K, shr 1)
	[    0.000000] ITS@0x000000006c000000: allocated 65536 Virtual CPUs @41feb600000 (flat, esz 8, psz 4K, shr 1)
	[    0.000000] ITS@0x000000006c000000: allocated 512 Interrupt Collections @41feb52c000 (flat, esz 8, psz 4K, shr 1)
	[    0.000000] ITS [mem 0xc6000000-0xc603ffff]
	[    0.000000] ITS@0x00000000c6000000: Using ITS number 2
	[    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
	[    0.000000] ITS@0x00000000c6000000: allocated 524288 Devices @41fea400000 (flat, esz 8, psz 16K, shr 1)
	[    0.000000] ITS@0x00000000c6000000: allocated 65536 Virtual CPUs @41feb680000 (flat, esz 8, psz 4K, shr 1)
	[    0.000000] ITS@0x00000000c6000000: allocated 512 Interrupt Collections @41feb52d000 (flat, esz 8, psz 4K, shr 1)
	[    0.000000] ITS [mem 0x8c6000000-0x8c603ffff]
	[    0.000000] ITS@0x00000008c6000000: Using ITS number 3
	[    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
	[    0.000000] ITS@0x00000008c6000000: allocated 524288 Devices @41fea000000 (flat, esz 8, psz 16K, shr 1)
	[    0.000000] ITS@0x00000008c6000000: allocated 65536 Virtual CPUs @41feb700000 (flat, esz 8, psz 4K, shr 1)
	[    0.000000] ITS@0x00000008c6000000: allocated 512 Interrupt Collections @41feb52e000 (flat, esz 8, psz 4K, shr 1)
	[    0.000000] ITS [mem 0x4004c000000-0x4004c03ffff]
	[    0.000000] ITS@0x000004004c000000: Using ITS number 4
	[    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
	[    0.000000] ITS@0x000004004c000000: allocated 524288 Devices @41fe9c00000 (flat, esz 8, psz 16K, shr 1)
	[    0.000000] ITS@0x000004004c000000: allocated 65536 Virtual CPUs @41feb780000 (flat, esz 8, psz 4K, shr 1)
	[    0.000000] ITS@0x000004004c000000: allocated 512 Interrupt Collections @41feb52f000 (flat, esz 8, psz 4K, shr 1)
	[    0.000000] ITS [mem 0x4006c000000-0x4006c03ffff]
	[    0.000000] ITS@0x000004006c000000: Using ITS number 5
	[    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
	[    0.000000] ITS@0x000004006c000000: allocated 524288 Devices @41fe9400000 (flat, esz 8, psz 16K, shr 1)
	[    0.000000] ITS@0x000004006c000000: allocated 65536 Virtual CPUs @41fe9880000 (flat, esz 8, psz 4K, shr 1)
	[    0.000000] ITS@0x000004006c000000: allocated 512 Interrupt Collections @41fe9801000 (flat, esz 8, psz 4K, shr 1)
	[    0.000000] ITS [mem 0x400c6000000-0x400c603ffff]
	[    0.000000] ITS@0x00000400c6000000: Using ITS number 6
	[    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
	[    0.000000] ITS@0x00000400c6000000: allocated 524288 Devices @41fe9000000 (flat, esz 8, psz 16K, shr 1)
	[    0.000000] ITS@0x00000400c6000000: allocated 65536 Virtual CPUs @41fe9900000 (flat, esz 8, psz 4K, shr 1)
	[    0.000000] ITS@0x00000400c6000000: allocated 512 Interrupt Collections @41fe9802000 (flat, esz 8, psz 4K, shr 1)
	[    0.000000] ITS [mem 0x408c6000000-0x408c603ffff]
	[    0.000000] ITS@0x00000408c6000000: Using ITS number 7
	[    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
	[    0.000000] ITS@0x00000408c6000000: allocated 524288 Devices @41fe8c00000 (flat, esz 8, psz 16K, shr 1)
	[    0.000000] ITS@0x00000408c6000000: allocated 65536 Virtual CPUs @41fe9980000 (flat, esz 8, psz 4K, shr 1)
	[    0.000000] ITS@0x00000408c6000000: allocated 512 Interrupt Collections @41fe9803000 (flat, esz 8, psz 4K, shr 1)
	[    0.000000] GICv3: using LPI property table @0x0000041fe9840000
	[    0.000000] ITS: Using DirectLPI for VPE invalidation
	[    0.000000] ITS: Enabling GICv4 support
	[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000041fe9850000
	[    0.000000] arch_timer: cp15 timer(s) running at 50.00MHz (phys).
	[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
	[    0.000001] sched_clock: 56 bits at 50MHz, resolution 20ns, wraps every 4398046511100ns
	[    0.000159] Console: colour dummy device 80x25
	[    0.000446] printk: console [tty0] enabled
	[    0.000499] Calibrating delay loop (skipped), value calculated using timer frequency.. 100.00 BogoMIPS (lpj=200000)
	[    0.000507] pid_max: default: 65536 minimum: 512
	[    0.000562] LSM: Security Framework initializing
	[    0.035969] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes)
	[    0.053360] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes)
	[    0.053997] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes)
	[    0.054584] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes)
	[    0.054838] *** VALIDATE proc ***
	[    0.054976] *** VALIDATE cgroup1 ***
	[    0.054981] *** VALIDATE cgroup2 ***
	[    0.096093] ASID allocator initialised with 32768 entries
	[    0.104084] rcu: Hierarchical SRCU implementation.
	[    0.112134] Platform MSI: interrupt-controller@4c000000 domain created
	[    0.112148] Platform MSI: interrupt-controller@6c000000 domain created
	[    0.112157] Platform MSI: interrupt-controller@c6000000 domain created
	[    0.112165] Platform MSI: interrupt-controller@8,c6000000 domain created
	[    0.112172] Platform MSI: interrupt-controller@400,4c000000 domain created
	[    0.112179] Platform MSI: interrupt-controller@400,6c000000 domain created
	[    0.112187] Platform MSI: interrupt-controller@400,c6000000 domain created
	[    0.112194] Platform MSI: interrupt-controller@408,c6000000 domain created
	[    0.112246] PCI/MSI: /interrupt-controller@4d000000/interrupt-controller@4c000000 domain created
	[    0.112255] PCI/MSI: /interrupt-controller@4d000000/interrupt-controller@6c000000 domain created
	[    0.112262] PCI/MSI: /interrupt-controller@4d000000/interrupt-controller@c6000000 domain created
	[    0.112271] PCI/MSI: /interrupt-controller@4d000000/interrupt-controller@8,c6000000 domain created
	[    0.112279] PCI/MSI: /interrupt-controller@4d000000/interrupt-controller@400,4c000000 domain created
	[    0.112287] PCI/MSI: /interrupt-controller@4d000000/interrupt-controller@400,6c000000 domain created
	[    0.112296] PCI/MSI: /interrupt-controller@4d000000/interrupt-controller@400,c6000000 domain created
	[    0.112304] PCI/MSI: /interrupt-controller@4d000000/interrupt-controller@408,c6000000 domain created
	[    0.112793] Remapping and enabling EFI services.
	[    0.120095] smp: Bringing up secondary CPUs ...
	[    0.202700] Detected PIPT I-cache on CPU1
	[    0.202714] GICv3: CPU1: found redistributor 10001 region 0:0x000000004d140000
	[    0.202720] GICv3: CPU1: using allocated LPI pending table @0x0000041fe9860000
	[    0.202857] CPU1: Booted secondary processor 0x0000010001 [0x410fd082]
	[    0.285325] Detected PIPT I-cache on CPU2
	[    0.285332] GICv3: CPU2: found redistributor 10002 region 0:0x000000004d180000
	[    0.285336] GICv3: CPU2: using allocated LPI pending table @0x0000041fe9870000
	[    0.285442] CPU2: Booted secondary processor 0x0000010002 [0x410fd082]
	[    0.367951] Detected PIPT I-cache on CPU3
	[    0.367958] GICv3: CPU3: found redistributor 10003 region 0:0x000000004d1c0000
	[    0.367963] GICv3: CPU3: using allocated LPI pending table @0x0000041fe9a00000
	[    0.368065] CPU3: Booted secondary processor 0x0000010003 [0x410fd082]
	[    0.450582] Detected PIPT I-cache on CPU4
	[    0.450591] GICv3: CPU4: found redistributor 10100 region 0:0x000000004d200000
	[    0.450596] GICv3: CPU4: using allocated LPI pending table @0x0000041fe9a10000
	[    0.450700] CPU4: Booted secondary processor 0x0000010100 [0x410fd082]
	[    0.533206] Detected PIPT I-cache on CPU5
	[    0.533213] GICv3: CPU5: found redistributor 10101 region 0:0x000000004d240000
	[    0.533218] GICv3: CPU5: using allocated LPI pending table @0x0000041fe9a20000
	[    0.533321] CPU5: Booted secondary processor 0x0000010101 [0x410fd082]
	[    0.615835] Detected PIPT I-cache on CPU6
	[    0.615842] GICv3: CPU6: found redistributor 10102 region 0:0x000000004d280000
	[    0.615847] GICv3: CPU6: using allocated LPI pending table @0x0000041fe9a30000
	[    0.615952] CPU6: Booted secondary processor 0x0000010102 [0x410fd082]
	[    0.698460] Detected PIPT I-cache on CPU7
	[    0.698469] GICv3: CPU7: found redistributor 10103 region 0:0x000000004d2c0000
	[    0.698473] GICv3: CPU7: using allocated LPI pending table @0x0000041fe9a40000
	[    0.698575] CPU7: Booted secondary processor 0x0000010103 [0x410fd082]
	[    0.781090] Detected PIPT I-cache on CPU8
	[    0.781099] GICv3: CPU8: found redistributor 10200 region 0:0x000000004d300000
	[    0.781104] GICv3: CPU8: using allocated LPI pending table @0x0000041fe9a50000
	[    0.781211] CPU8: Booted secondary processor 0x0000010200 [0x410fd082]
	[    0.863715] Detected PIPT I-cache on CPU9
	[    0.863723] GICv3: CPU9: found redistributor 10201 region 0:0x000000004d340000
	[    0.863728] GICv3: CPU9: using allocated LPI pending table @0x0000041fe9a60000
	[    0.863831] CPU9: Booted secondary processor 0x0000010201 [0x410fd082]
	[    0.946342] Detected PIPT I-cache on CPU10
	[    0.946350] GICv3: CPU10: found redistributor 10202 region 0:0x000000004d380000
	[    0.946354] GICv3: CPU10: using allocated LPI pending table @0x0000041fe9a70000
	[    0.946458] CPU10: Booted secondary processor 0x0000010202 [0x410fd082]
	[    1.028968] Detected PIPT I-cache on CPU11
	[    1.028976] GICv3: CPU11: found redistributor 10203 region 0:0x000000004d3c0000
	[    1.028981] GICv3: CPU11: using allocated LPI pending table @0x0000041fe9a80000
	[    1.029084] CPU11: Booted secondary processor 0x0000010203 [0x410fd082]
	[    1.111596] Detected PIPT I-cache on CPU12
	[    1.111605] GICv3: CPU12: found redistributor 10300 region 0:0x000000004d400000
	[    1.111611] GICv3: CPU12: using allocated LPI pending table @0x0000041fe9a90000
	[    1.111717] CPU12: Booted secondary processor 0x0000010300 [0x410fd082]
	[    1.194222] Detected PIPT I-cache on CPU13
	[    1.194230] GICv3: CPU13: found redistributor 10301 region 0:0x000000004d440000
	[    1.194235] GICv3: CPU13: using allocated LPI pending table @0x0000041fe9aa0000
	[    1.194339] CPU13: Booted secondary processor 0x0000010301 [0x410fd082]
	[    1.276850] Detected PIPT I-cache on CPU14
	[    1.276858] GICv3: CPU14: found redistributor 10302 region 0:0x000000004d480000
	[    1.276862] GICv3: CPU14: using allocated LPI pending table @0x0000041fe9ab0000
	[    1.276967] CPU14: Booted secondary processor 0x0000010302 [0x410fd082]
	[    1.359476] Detected PIPT I-cache on CPU15
	[    1.359484] GICv3: CPU15: found redistributor 10303 region 0:0x000000004d4c0000
	[    1.359489] GICv3: CPU15: using allocated LPI pending table @0x0000041fe9ac0000
	[    1.359590] CPU15: Booted secondary processor 0x0000010303 [0x410fd082]
	[    1.441762] Detected PIPT I-cache on CPU16
	[    1.441775] GICv3: CPU16: found redistributor 30000 region 1:0x000000006d100000
	[    1.441781] GICv3: CPU16: using allocated LPI pending table @0x0000041fe9ad0000
	[    1.441930] CPU16: Booted secondary processor 0x0000030000 [0x410fd082]
	[    1.524388] Detected PIPT I-cache on CPU17
	[    1.524397] GICv3: CPU17: found redistributor 30001 region 1:0x000000006d140000
	[    1.524402] GICv3: CPU17: using allocated LPI pending table @0x0000041fe9ae0000
	[    1.524545] CPU17: Booted secondary processor 0x0000030001 [0x410fd082]
	[    1.607016] Detected PIPT I-cache on CPU18
	[    1.607026] GICv3: CPU18: found redistributor 30002 region 1:0x000000006d180000
	[    1.607031] GICv3: CPU18: using allocated LPI pending table @0x0000041fe9af0000
	[    1.607175] CPU18: Booted secondary processor 0x0000030002 [0x410fd082]
	[    1.689644] Detected PIPT I-cache on CPU19
	[    1.689654] GICv3: CPU19: found redistributor 30003 region 1:0x000000006d1c0000
	[    1.689659] GICv3: CPU19: using allocated LPI pending table @0x0000041fe9b00000
	[    1.689802] CPU19: Booted secondary processor 0x0000030003 [0x410fd082]
	[    1.772276] Detected PIPT I-cache on CPU20
	[    1.772289] GICv3: CPU20: found redistributor 30100 region 1:0x000000006d200000
	[    1.772296] GICv3: CPU20: using allocated LPI pending table @0x0000041fe9b10000
	[    1.772445] CPU20: Booted secondary processor 0x0000030100 [0x410fd082]
	[    1.854901] Detected PIPT I-cache on CPU21
	[    1.854911] GICv3: CPU21: found redistributor 30101 region 1:0x000000006d240000
	[    1.854916] GICv3: CPU21: using allocated LPI pending table @0x0000041fe9b20000
	[    1.855059] CPU21: Booted secondary processor 0x0000030101 [0x410fd082]
	[    1.937530] Detected PIPT I-cache on CPU22
	[    1.937539] GICv3: CPU22: found redistributor 30102 region 1:0x000000006d280000
	[    1.937544] GICv3: CPU22: using allocated LPI pending table @0x0000041fe9b30000
	[    1.937688] CPU22: Booted secondary processor 0x0000030102 [0x410fd082]
	[    2.020158] Detected PIPT I-cache on CPU23
	[    2.020169] GICv3: CPU23: found redistributor 30103 region 1:0x000000006d2c0000
	[    2.020173] GICv3: CPU23: using allocated LPI pending table @0x0000041fe9b40000
	[    2.020315] CPU23: Booted secondary processor 0x0000030103 [0x410fd082]
	[    2.102789] Detected PIPT I-cache on CPU24
	[    2.102802] GICv3: CPU24: found redistributor 30200 region 1:0x000000006d300000
	[    2.102810] GICv3: CPU24: using allocated LPI pending table @0x0000041fe9b50000
	[    2.102960] CPU24: Booted secondary processor 0x0000030200 [0x410fd082]
	[    2.185415] Detected PIPT I-cache on CPU25
	[    2.185426] GICv3: CPU25: found redistributor 30201 region 1:0x000000006d340000
	[    2.185430] GICv3: CPU25: using allocated LPI pending table @0x0000041fe9b60000
	[    2.185572] CPU25: Booted secondary processor 0x0000030201 [0x410fd082]
	[    2.268043] Detected PIPT I-cache on CPU26
	[    2.268054] GICv3: CPU26: found redistributor 30202 region 1:0x000000006d380000
	[    2.268059] GICv3: CPU26: using allocated LPI pending table @0x0000041fe9b70000
	[    2.268203] CPU26: Booted secondary processor 0x0000030202 [0x410fd082]
	[    2.350672] Detected PIPT I-cache on CPU27
	[    2.350683] GICv3: CPU27: found redistributor 30203 region 1:0x000000006d3c0000
	[    2.350688] GICv3: CPU27: using allocated LPI pending table @0x0000041fe9b80000
	[    2.350830] CPU27: Booted secondary processor 0x0000030203 [0x410fd082]
	[    2.433304] Detected PIPT I-cache on CPU28
	[    2.433317] GICv3: CPU28: found redistributor 30300 region 1:0x000000006d400000
	[    2.433324] GICv3: CPU28: using allocated LPI pending table @0x0000041fe9b90000
	[    2.433474] CPU28: Booted secondary processor 0x0000030300 [0x410fd082]
	[    2.515930] Detected PIPT I-cache on CPU29
	[    2.515940] GICv3: CPU29: found redistributor 30301 region 1:0x000000006d440000
	[    2.515945] GICv3: CPU29: using allocated LPI pending table @0x0000041fe9ba0000
	[    2.516088] CPU29: Booted secondary processor 0x0000030301 [0x410fd082]
	[    2.598559] Detected PIPT I-cache on CPU30
	[    2.598570] GICv3: CPU30: found redistributor 30302 region 1:0x000000006d480000
	[    2.598574] GICv3: CPU30: using allocated LPI pending table @0x0000041fe9bb0000
	[    2.598718] CPU30: Booted secondary processor 0x0000030302 [0x410fd082]
	[    2.681189] Detected PIPT I-cache on CPU31
	[    2.681200] GICv3: CPU31: found redistributor 30303 region 1:0x000000006d4c0000
	[    2.681205] GICv3: CPU31: using allocated LPI pending table @0x0000041fe9bc0000
	[    2.681349] CPU31: Booted secondary processor 0x0000030303 [0x410fd082]
	[    2.763503] Detected PIPT I-cache on CPU32
	[    2.763540] GICv3: CPU32: found redistributor 50000 region 2:0x000004004d100000
	[    2.763557] GICv3: CPU32: using allocated LPI pending table @0x0000041fe9bd0000
	[    2.763709] CPU32: Booted secondary processor 0x0000050000 [0x410fd082]
	[    2.846121] Detected PIPT I-cache on CPU33
	[    2.846143] GICv3: CPU33: found redistributor 50001 region 2:0x000004004d140000
	[    2.846148] GICv3: CPU33: using allocated LPI pending table @0x0000041fe9be0000
	[    2.846252] CPU33: Booted secondary processor 0x0000050001 [0x410fd082]
	[    2.928764] Detected PIPT I-cache on CPU34
	[    2.928786] GICv3: CPU34: found redistributor 50002 region 2:0x000004004d180000
	[    2.928791] GICv3: CPU34: using allocated LPI pending table @0x0000041fe9bf0000
	[    2.928896] CPU34: Booted secondary processor 0x0000050002 [0x410fd082]
	[    3.011405] Detected PIPT I-cache on CPU35
	[    3.011427] GICv3: CPU35: found redistributor 50003 region 2:0x000004004d1c0000
	[    3.011432] GICv3: CPU35: using allocated LPI pending table @0x0000041fe8800000
	[    3.011536] CPU35: Booted secondary processor 0x0000050003 [0x410fd082]
	[    3.094049] Detected PIPT I-cache on CPU36
	[    3.094072] GICv3: CPU36: found redistributor 50100 region 2:0x000004004d200000
	[    3.094078] GICv3: CPU36: using allocated LPI pending table @0x0000041fe8810000
	[    3.094184] CPU36: Booted secondary processor 0x0000050100 [0x410fd082]
	[    3.176690] Detected PIPT I-cache on CPU37
	[    3.176712] GICv3: CPU37: found redistributor 50101 region 2:0x000004004d240000
	[    3.176717] GICv3: CPU37: using allocated LPI pending table @0x0000041fe8820000
	[    3.176820] CPU37: Booted secondary processor 0x0000050101 [0x410fd082]
	[    3.259335] Detected PIPT I-cache on CPU38
	[    3.259357] GICv3: CPU38: found redistributor 50102 region 2:0x000004004d280000
	[    3.259362] GICv3: CPU38: using allocated LPI pending table @0x0000041fe8830000
	[    3.259465] CPU38: Booted secondary processor 0x0000050102 [0x410fd082]
	[    3.341975] Detected PIPT I-cache on CPU39
	[    3.341998] GICv3: CPU39: found redistributor 50103 region 2:0x000004004d2c0000
	[    3.342003] GICv3: CPU39: using allocated LPI pending table @0x0000041fe8840000
	[    3.342107] CPU39: Booted secondary processor 0x0000050103 [0x410fd082]
	[    3.424622] Detected PIPT I-cache on CPU40
	[    3.424646] GICv3: CPU40: found redistributor 50200 region 2:0x000004004d300000
	[    3.424652] GICv3: CPU40: using allocated LPI pending table @0x0000041fe8850000
	[    3.424757] CPU40: Booted secondary processor 0x0000050200 [0x410fd082]
	[    3.507263] Detected PIPT I-cache on CPU41
	[    3.507286] GICv3: CPU41: found redistributor 50201 region 2:0x000004004d340000
	[    3.507290] GICv3: CPU41: using allocated LPI pending table @0x0000041fe8860000
	[    3.507394] CPU41: Booted secondary processor 0x0000050201 [0x410fd082]
	[    3.589907] Detected PIPT I-cache on CPU42
	[    3.589930] GICv3: CPU42: found redistributor 50202 region 2:0x000004004d380000
	[    3.589935] GICv3: CPU42: using allocated LPI pending table @0x0000041fe8870000
	[    3.590040] CPU42: Booted secondary processor 0x0000050202 [0x410fd082]
	[    3.672547] Detected PIPT I-cache on CPU43
	[    3.672570] GICv3: CPU43: found redistributor 50203 region 2:0x000004004d3c0000
	[    3.672575] GICv3: CPU43: using allocated LPI pending table @0x0000041fe8880000
	[    3.672680] CPU43: Booted secondary processor 0x0000050203 [0x410fd082]
	[    3.755193] Detected PIPT I-cache on CPU44
	[    3.755218] GICv3: CPU44: found redistributor 50300 region 2:0x000004004d400000
	[    3.755225] GICv3: CPU44: using allocated LPI pending table @0x0000041fe8890000
	[    3.755331] CPU44: Booted secondary processor 0x0000050300 [0x410fd082]
	[    3.837834] Detected PIPT I-cache on CPU45
	[    3.837857] GICv3: CPU45: found redistributor 50301 region 2:0x000004004d440000
	[    3.837862] GICv3: CPU45: using allocated LPI pending table @0x0000041fe88a0000
	[    3.837965] CPU45: Booted secondary processor 0x0000050301 [0x410fd082]
	[    3.920478] Detected PIPT I-cache on CPU46
	[    3.920501] GICv3: CPU46: found redistributor 50302 region 2:0x000004004d480000
	[    3.920506] GICv3: CPU46: using allocated LPI pending table @0x0000041fe88b0000
	[    3.920610] CPU46: Booted secondary processor 0x0000050302 [0x410fd082]
	[    4.003121] Detected PIPT I-cache on CPU47
	[    4.003144] GICv3: CPU47: found redistributor 50303 region 2:0x000004004d4c0000
	[    4.003149] GICv3: CPU47: using allocated LPI pending table @0x0000041fe88c0000
	[    4.003254] CPU47: Booted secondary processor 0x0000050303 [0x410fd082]
	[    4.085421] Detected PIPT I-cache on CPU48
	[    4.085451] GICv3: CPU48: found redistributor 70000 region 3:0x000004006d100000
	[    4.085459] GICv3: CPU48: using allocated LPI pending table @0x0000041fe88d0000
	[    4.085605] CPU48: Booted secondary processor 0x0000070000 [0x410fd082]
	[    4.168060] Detected PIPT I-cache on CPU49
	[    4.168086] GICv3: CPU49: found redistributor 70001 region 3:0x000004006d140000
	[    4.168092] GICv3: CPU49: using allocated LPI pending table @0x0000041fe88e0000
	[    4.168232] CPU49: Booted secondary processor 0x0000070001 [0x410fd082]
	[    4.250705] Detected PIPT I-cache on CPU50
	[    4.250731] GICv3: CPU50: found redistributor 70002 region 3:0x000004006d180000
	[    4.250736] GICv3: CPU50: using allocated LPI pending table @0x0000041fe88f0000
	[    4.250878] CPU50: Booted secondary processor 0x0000070002 [0x410fd082]
	[    4.333348] Detected PIPT I-cache on CPU51
	[    4.333374] GICv3: CPU51: found redistributor 70003 region 3:0x000004006d1c0000
	[    4.333380] GICv3: CPU51: using allocated LPI pending table @0x0000041fe8900000
	[    4.333522] CPU51: Booted secondary processor 0x0000070003 [0x410fd082]
	[    4.415997] Detected PIPT I-cache on CPU52
	[    4.416027] GICv3: CPU52: found redistributor 70100 region 3:0x000004006d200000
	[    4.416035] GICv3: CPU52: using allocated LPI pending table @0x0000041fe8910000
	[    4.416184] CPU52: Booted secondary processor 0x0000070100 [0x410fd082]
	[    4.498638] Detected PIPT I-cache on CPU53
	[    4.498664] GICv3: CPU53: found redistributor 70101 region 3:0x000004006d240000
	[    4.498669] GICv3: CPU53: using allocated LPI pending table @0x0000041fe8920000
	[    4.498810] CPU53: Booted secondary processor 0x0000070101 [0x410fd082]
	[    4.581284] Detected PIPT I-cache on CPU54
	[    4.581311] GICv3: CPU54: found redistributor 70102 region 3:0x000004006d280000
	[    4.581316] GICv3: CPU54: using allocated LPI pending table @0x0000041fe8930000
	[    4.581457] CPU54: Booted secondary processor 0x0000070102 [0x410fd082]
	[    4.663927] Detected PIPT I-cache on CPU55
	[    4.663954] GICv3: CPU55: found redistributor 70103 region 3:0x000004006d2c0000
	[    4.663959] GICv3: CPU55: using allocated LPI pending table @0x0000041fe8940000
	[    4.664099] CPU55: Booted secondary processor 0x0000070103 [0x410fd082]
	[    4.746575] Detected PIPT I-cache on CPU56
	[    4.746604] GICv3: CPU56: found redistributor 70200 region 3:0x000004006d300000
	[    4.746613] GICv3: CPU56: using allocated LPI pending table @0x0000041fe8950000
	[    4.746760] CPU56: Booted secondary processor 0x0000070200 [0x410fd082]
	[    4.829215] Detected PIPT I-cache on CPU57
	[    4.829241] GICv3: CPU57: found redistributor 70201 region 3:0x000004006d340000
	[    4.829247] GICv3: CPU57: using allocated LPI pending table @0x0000041fe8960000
	[    4.829388] CPU57: Booted secondary processor 0x0000070201 [0x410fd082]
	[    4.911861] Detected PIPT I-cache on CPU58
	[    4.911888] GICv3: CPU58: found redistributor 70202 region 3:0x000004006d380000
	[    4.911894] GICv3: CPU58: using allocated LPI pending table @0x0000041fe8970000
	[    4.912034] CPU58: Booted secondary processor 0x0000070202 [0x410fd082]
	[    4.994506] Detected PIPT I-cache on CPU59
	[    4.994532] GICv3: CPU59: found redistributor 70203 region 3:0x000004006d3c0000
	[    4.994538] GICv3: CPU59: using allocated LPI pending table @0x0000041fe8980000
	[    4.994678] CPU59: Booted secondary processor 0x0000070203 [0x410fd082]
	[    5.077154] Detected PIPT I-cache on CPU60
	[    5.077184] GICv3: CPU60: found redistributor 70300 region 3:0x000004006d400000
	[    5.077194] GICv3: CPU60: using allocated LPI pending table @0x0000041fe8990000
	[    5.077341] CPU60: Booted secondary processor 0x0000070300 [0x410fd082]
	[    5.159795] Detected PIPT I-cache on CPU61
	[    5.159822] GICv3: CPU61: found redistributor 70301 region 3:0x000004006d440000
	[    5.159827] GICv3: CPU61: using allocated LPI pending table @0x0000041fe89a0000
	[    5.159969] CPU61: Booted secondary processor 0x0000070301 [0x410fd082]
	[    5.242443] Detected PIPT I-cache on CPU62
	[    5.242470] GICv3: CPU62: found redistributor 70302 region 3:0x000004006d480000
	[    5.242475] GICv3: CPU62: using allocated LPI pending table @0x0000041fe89b0000
	[    5.242618] CPU62: Booted secondary processor 0x0000070302 [0x410fd082]
	[    5.325086] Detected PIPT I-cache on CPU63
	[    5.325113] GICv3: CPU63: found redistributor 70303 region 3:0x000004006d4c0000
	[    5.325118] GICv3: CPU63: using allocated LPI pending table @0x0000041fe89c0000
	[    5.325258] CPU63: Booted secondary processor 0x0000070303 [0x410fd082]
	[    5.325338] smp: Brought up 1 node, 64 CPUs
	[    5.325949] SMP: Total of 64 processors activated.
	[    5.325953] CPU features: detected: GIC system register CPU interface
	[    5.325957] CPU features: detected: 32-bit EL0 Support
	[    5.325962] CPU features: detected: CRC32 instructions
	[   37.857913] CPU: All CPU(s) started at EL2
	[   37.858056] alternatives: patching kernel code
	[   37.859195] devtmpfs: initialized
	[   37.861655] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
	[   37.861850] futex hash table entries: 16384 (order: 8, 1048576 bytes)
	[   37.863258] pinctrl core: initialized pinctrl subsystem
	[   37.863848] SMBIOS 3.0.0 present.
	[   37.863857] DMI: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 IT17 Nemo 2.0 RC0 10/05/2018
	[   37.864066] NET: Registered protocol family 16
	[   37.864914] audit: initializing netlink subsys (disabled)
	[   37.865008] audit: type=2000 audit(3.660:1): state=initialized audit_enabled=0 res=1
	[   37.865530] cpuidle: using governor menu
	[   37.865723] vdso: 2 pages (1 code @ (____ptrval____), 1 data @ (____ptrval____))
	[   37.865729] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
	[   37.866862] DMA: preallocated 256 KiB pool for atomic allocations
	[   37.867315] Serial: AMBA PL011 UART driver
	[   37.878295] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
	[   37.878303] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
	[   37.878308] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
	[   37.878312] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
	[   37.878720] cryptd: max_cpu_qlen set to 1000
	[   37.879341] ACPI: Interpreter disabled.
	[   37.879892] vgaarb: loaded
	[   37.880053] SCSI subsystem initialized
	[   37.880341] usbcore: registered new interface driver usbfs
	[   37.880358] usbcore: registered new interface driver hub
	[   37.880554] usbcore: registered new device driver usb
	[   37.880801] pps_core: LinuxPPS API ver. 1 registered
	[   37.880810] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
	[   37.880821] PTP clock support registered
	[   37.880865] EDAC MC: Ver: 3.0.0
	[   37.881061] Registered efivars operations
	[   37.881612] Advanced Linux Sound Architecture Driver Initialized.
	[   37.882021] clocksource: Switched to clocksource arch_sys_counter
	[   37.882175] VFS: Disk quotas dquot_6.6.0
	[   37.882203] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
	[   37.882226] *** VALIDATE hugetlbfs ***
	[   37.882298] pnp: PnP ACPI: disabled
	[   37.884713] NET: Registered protocol family 2
	[   37.885270] tcp_listen_portaddr_hash hash table entries: 65536 (order: 8, 1048576 bytes)
	[   37.885997] TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
	[   37.887227] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
	[   37.888046] TCP: Hash tables configured (established 524288 bind 65536)
	[   37.888455] UDP hash table entries: 65536 (order: 9, 2097152 bytes)
	[   37.889229] UDP-Lite hash table entries: 65536 (order: 9, 2097152 bytes)
	[   37.889975] NET: Registered protocol family 1
	[   37.890252] RPC: Registered named UNIX socket transport module.
	[   37.890256] RPC: Registered udp transport module.
	[   37.890260] RPC: Registered tcp transport module.
	[   37.890264] RPC: Registered tcp NFSv4.1 backchannel transport module.
	[   37.890331] Unpacking initramfs...
	[   38.431501] Freeing initrd memory: 29988K
	[   38.434774] hw perfevents: enabled with armv8_cortex_a72 PMU driver, 7 counters available
	[   38.435078] kvm [1]: 8-bit VMID
	[   38.435083] kvm [1]: IPA Size Limit: 44bits
	[   38.435702] kvm [1]: GICv4 support disabled
	[   38.435707] kvm [1]: vgic-v2@fe020000
	[   38.435735] kvm [1]: GIC system register CPU interface enabled
	[   38.436492] kvm [1]: vgic interrupt IRQ1
	[   38.437216] kvm [1]: Hyp mode initialized successfully
	[   38.487671] Initialise system trusted keyrings
	[   38.487769] workingset: timestamp_bits=44 max_order=25 bucket_order=0
	[   38.490524] squashfs: version 4.0 (2009/01/31) Phillip Lougher
	[   38.490949] NFS: Registering the id_resolver key type
	[   38.490958] Key type id_resolver registered
	[   38.490962] Key type id_legacy registered
	[   38.490969] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
	[   38.491017] 9p: Installing v9fs 9p2000 file system support
	[   38.509723] Key type asymmetric registered
	[   38.509730] Asymmetric key parser 'x509' registered
	[   38.509749] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
	[   38.509755] io scheduler mq-deadline registered
	[   38.509759] io scheduler kyber registered
	[   38.512628] hisi-lpc a01b0000.isa: registered range [0x0000000000ffbfff - 0x0000000000ffffff]
	[   38.515403] hisi-pcie-almost-ecam af800000.pcie: host bridge /soc/pcie@a00a0000 ranges:
	[   38.515420] hisi-pcie-almost-ecam af800000.pcie:   MEM 0xa8000000..0xaf7effff -> 0xa8000000
	[   38.515429] hisi-pcie-almost-ecam af800000.pcie:    IO 0xaf7f0000..0xaf7fffff -> 0x00000000
	[   38.515438] hisi-pcie-almost-ecam af800000.pcie: resource collision: [io  0x0000-0xffff] conflicts with IPMI Address 1 [io  0x00e4]
	[   38.515447] hisi-pcie-almost-ecam: probe of af800000.pcie failed with error -16
	[   38.515817] EINJ: ACPI disabled.
	[   38.519589] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
	[   38.520402] SuperH (H)SCI(F) driver initialized
	[   38.520545] msm_serial: driver initialized
	[   38.520775] arm-smmu-v3 d0040000.smmu_alg: option hisilicon,broken-prefetch-cmd
	[   38.520857] arm-smmu-v3 d0040000.smmu_alg: ias 44-bit, oas 44-bit (features 0x00000f0d)
	[   38.524363] arm-smmu-v3 8d0040000.smmu_alg: option hisilicon,broken-prefetch-cmd
	[   38.524449] arm-smmu-v3 8d0040000.smmu_alg: ias 44-bit, oas 44-bit (features 0x00000f0d)
	[   38.527710] arm-smmu-v3 400d0040000.smmu_alg: option hisilicon,broken-prefetch-cmd
	[   38.527793] arm-smmu-v3 400d0040000.smmu_alg: ias 44-bit, oas 44-bit (features 0x00000f0d)
	[   38.531165] arm-smmu-v3 408d0040000.smmu_alg: option hisilicon,broken-prefetch-cmd
	[   38.531268] arm-smmu-v3 408d0040000.smmu_alg: ias 44-bit, oas 44-bit (features 0x00000f0d)
	[   38.551308] loop: module loaded
	[   38.564642] cma: cma_alloc: alloc failed, req-size: 33 pages, ret: -12
	[   38.564728] cma: cma_alloc: alloc failed, req-size: 33 pages, ret: -12
	[   38.564808] cma: cma_alloc: alloc failed, req-size: 33 pages, ret: -12
	[   38.564887] cma: cma_alloc: alloc failed, req-size: 33 pages, ret: -12
	[   38.564965] cma: cma_alloc: alloc failed, req-size: 33 pages, ret: -12
	[   38.565045] cma: cma_alloc: alloc failed, req-size: 33 pages, ret: -12
	[   38.565124] cma: cma_alloc: alloc failed, req-size: 33 pages, ret: -12
	[   38.565204] cma: cma_alloc: alloc failed, req-size: 33 pages, ret: -12
	[   38.565282] cma: cma_alloc: alloc failed, req-size: 33 pages, ret: -12
	[   38.565362] cma: cma_alloc: alloc failed, req-size: 33 pages, ret: -12
	[   38.565441] cma: cma_alloc: alloc failed, req-size: 33 pages, ret: -12
	[   38.565519] cma: cma_alloc: alloc failed, req-size: 33 pages, ret: -12
	[   38.565598] cma: cma_alloc: alloc failed, req-size: 33 pages, ret: -12
	[   38.565677] cma: cma_alloc: alloc failed, req-size: 33 pages, ret: -12
	[   38.565755] cma: cma_alloc: alloc failed, req-size: 33 pages, ret: -12
	[   38.565834] cma: cma_alloc: alloc failed, req-size: 33 pages, ret: -12
	[   38.565914] cma: cma_alloc: alloc failed, req-size: 33 pages, ret: -12
	[   38.565994] cma: cma_alloc: alloc failed, req-size: 33 pages, ret: -12
	[   38.566080] cma: cma_alloc: alloc failed, req-size: 33 pages, ret: -12
	[   38.566160] cma: cma_alloc: alloc failed, req-size: 33 pages, ret: -12
	[   38.566238] cma: cma_alloc: alloc failed, req-size: 33 pages, ret: -12
	[   38.566371] cma: cma_alloc: alloc failed, req-size: 128 pages, ret: -12
	[   38.566564] cma: cma_alloc: alloc failed, req-size: 1024 pages, ret: -12
	[   38.569166] scsi host0: hisi_sas_v2_hw
	[   39.198633] hisi_sas_v2_hw a2000000.sas: phyup: phy0 link_rate=11
	[   39.198653] hisi_sas_v2_hw a2000000.sas: phyup: phy1 link_rate=11
	[   39.203631] hisi_sas_v2_hw a2000000.sas: phyup: phy2 link_rate=11
	[   39.203641] hisi_sas_v2_hw a2000000.sas: phyup: phy3 link_rate=11
	[   39.203649] hisi_sas_v2_hw a2000000.sas: phyup: phy4 link_rate=11
	[   39.203659] hisi_sas_v2_hw a2000000.sas: phyup: phy5 link_rate=11
	[   39.203668] hisi_sas_v2_hw a2000000.sas: phyup: phy6 link_rate=11
	[   39.203678] hisi_sas_v2_hw a2000000.sas: phyup: phy7 link_rate=11
	[   39.210342] hisi_sas_v2_hw a2000000.sas: dev[0:2] found
	[   39.213623] hisi_sas_v2_hw a2000000.sas: dev[2:5] found
	[   39.219415] hisi_sas_v2_hw a2000000.sas: dev[1:1] found
	[   39.226032] hisi_sas_v2_hw a2000000.sas: dev[3:1] found
	[   39.232668] hisi_sas_v2_hw a2000000.sas: dev[4:1] found
	[   39.232785] hisi_sas_v2_hw a2000000.sas: dev[5:1] found
	[   39.239415] hisi_sas_v2_hw a2000000.sas: dev[6:1] found
	[   39.246052] hisi_sas_v2_hw a2000000.sas: dev[7:1] found
	[   39.252660] hisi_sas_v2_hw a2000000.sas: dev[8:1] found
	[   39.259334] hisi_sas_v2_hw a2000000.sas: dev[9:1] found
	[   39.259520] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
	[   39.420013] ata1.00: ATA-8: HGST HUS724040ALA640, MFAOA8B0, max UDMA/133
	[   39.420027] ata1.00: 7814037168 sectors, multi 0: LBA48 NCQ (depth 32)
	[   39.421818] ata1.00: configured for UDMA/133
	[   39.421843] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
	[   39.432874] scsi 0:0:0:0: Direct-Access     ATA      HGST HUS724040AL A8B0 PQ: 0 ANSI: 5
	[   39.433185] sd 0:0:0:0: [sda] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
	[   39.433215] sd 0:0:0:0: [sda] Write Protect is off
	[   39.433254] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
	[   39.471281] scsi 0:0:1:0: Direct-Access     SanDisk  LT0200MO         P404 PQ: 0 ANSI: 6
	[   39.486941]  sda: sda1
	[   39.487973] sd 0:0:0:0: [sda] Attached SCSI disk
	[   39.769843] scsi 0:0:2:0: Direct-Access     SanDisk  LT0200MO         P404 PQ: 0 ANSI: 6
	[   39.947275] sd 0:0:1:0: [sdb] 390721968 512-byte logical blocks: (200 GB/186 GiB)
	[   39.989339] sd 0:0:1:0: [sdb] Write Protect is off
	[   40.031685] scsi 0:0:3:0: Direct-Access     HGST     HUC156030CSS200  A3F0 PQ: 0 ANSI: 6
	[   40.034071] sd 0:0:3:0: [sdd] 586072368 512-byte logical blocks: (300 GB/279 GiB)
	[   40.035291] sd 0:0:3:0: [sdd] Write Protect is off
	[   40.037640] sd 0:0:3:0: [sdd] Write cache: enabled, read cache: enabled, supports DPO and FUA
	[   40.059425] sd 0:0:3:0: [sdd] Attached SCSI disk
	[   40.071332] sd 0:0:1:0: [sdb] Write cache: disabled, read cache: disabled, supports DPO and FUA
	[   40.071380] scsi 0:0:4:0: Direct-Access     SanDisk  LT0200MO         P404 PQ: 0 ANSI: 6
	[   40.245865] sd 0:0:2:0: [sdc] 390721968 512-byte logical blocks: (200 GB/186 GiB)
	[   40.287947] sd 0:0:2:0: [sdc] Write Protect is off
	[   40.369964] sd 0:0:2:0: [sdc] Write cache: disabled, read cache: disabled, supports DPO and FUA
	[   40.370017] scsi 0:0:5:0: Direct-Access     SanDisk  LT0200MO         P404 PQ: 0 ANSI: 6
	[   40.547427] sd 0:0:4:0: [sde] 390721968 512-byte logical blocks: (200 GB/186 GiB)
	[   40.589465] sd 0:0:4:0: [sde] Write Protect is off
	[   40.668789] scsi 0:0:6:0: Direct-Access     SanDisk  LT0200MO         P404 PQ: 0 ANSI: 6
	[   40.671583] sd 0:0:4:0: [sde] Write cache: disabled, read cache: disabled, supports DPO and FUA
	[   40.734152]  sdb: sdb1 sdb2
	[   40.846100] sd 0:0:5:0: [sdf] 390721968 512-byte logical blocks: (200 GB/186 GiB)
	[   40.888148] sd 0:0:5:0: [sdf] Write Protect is off
	[   40.893800] sd 0:0:6:0: [sdg] Disabling DIF Type 1 protection
	[   40.967256] scsi 0:0:7:0: Direct-Access     SanDisk  LT0200MO         P404 PQ: 0 ANSI: 6
	[   40.970171] sd 0:0:5:0: [sdf] Write cache: disabled, read cache: disabled, supports DPO and FUA
	[   41.008257] random: fast init done
	[   41.032637]  sdc: sdc1 sdc2 sdc3
	[   41.144708] sd 0:0:6:0: [sdg] 390721968 512-byte logical blocks: (200 GB/186 GiB)
	[   41.186749] sd 0:0:6:0: [sdg] Write Protect is off
	[   41.229168] scsi 0:0:8:0: Enclosure         12G SAS  Expander         RevB PQ: 0 ANSI: 6
	[   41.229274] scsi 0:0:8:0: Power-on or device reset occurred
	[   41.231546] libphy: Fixed MDIO Bus: probed
	[   41.231688] tun: Universal TUN/TAP device driver, 1.6
	[   41.231990] thunder_xcv, ver 1.0
	[   41.232009] thunder_bgx, ver 1.0
	[   41.232026] nicpf, ver 1.0
	[   41.268742] sd 0:0:6:0: [sdg] Write cache: disabled, read cache: disabled, supports DPO and FUA
	[   41.306280] sd 0:0:1:0: [sdb] Attached SCSI disk
	[   41.334505]  sde: sde1 sde2 sde3
	[   41.443959] sd 0:0:7:0: [sdh] 390721968 512-byte logical blocks: (200 GB/186 GiB)
	[   41.486007] sd 0:0:7:0: [sdh] Write Protect is off
	[   41.568030] sd 0:0:7:0: [sdh] Write cache: disabled, read cache: disabled, supports DPO and FUA
	[   41.590426] mdio_bus Mii-603c0000.mdio: MDIO reset fail
	[   41.590432] libphy: Hisilicon MII Bus: probed
	[   41.604566] sd 0:0:2:0: [sdc] Attached SCSI disk
	[   41.632812]  sdf: sdf1 sdf2 sdf3
	[   41.906402] sd 0:0:4:0: [sde] Attached SCSI disk
	[   42.204683] sd 0:0:5:0: [sdf] Attached SCSI disk
	[   42.231450]  sdh: sdh1 sdh2
	[   42.382819] hns-nic soc:ethernet@4: No valid mac, use random mac a2:04:2d:5a:18:6a
	[   42.388328] hns-nic soc:ethernet@4 (unnamed net_device) (uninitialized): netif_napi_add() called with weight 256
	[   42.388928] hns-nic soc:ethernet@5: No valid mac, use random mac 26:65:e4:af:9c:85
	[   42.394990] hns-nic soc:ethernet@0: No valid mac, use random mac 1e:86:a1:67:3c:9f
	[   42.401030] hns-nic soc:ethernet@1: No valid mac, use random mac ce:88:68:ba:1d:9c
	[   42.406949] hclge is initializing
	[   42.406956] hns3: Hisilicon Ethernet Network Driver for Hip08 Family - version
	[   42.406960] hns3: Copyright (c) 2017 Huawei Corporation.
	[   42.406998] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
	[   42.407002] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
	[   42.407023] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
	[   42.407027] igb: Copyright (c) 2007-2014 Intel Corporation.
	[   42.407047] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
	[   42.407052] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
	[   42.407240] sky2: driver version 1.30
	[   42.407528] VFIO - User Level meta-driver version: 0.3
	[   42.408087] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
	[   42.408092] ehci-pci: EHCI PCI platform driver
	[   42.408108] ehci-platform: EHCI generic platform driver
	[   42.408202] ehci-platform a7020000.ehci: EHCI Host Controller
	[   42.408212] ehci-platform a7020000.ehci: new USB bus registered, assigned bus number 1
	[   42.408439] ehci-platform a7020000.ehci: irq 339, io mem 0xa7020000
	[   42.422015] ehci-platform a7020000.ehci: USB 2.0 started, EHCI 1.00
	[   42.422222] hub 1-0:1.0: USB hub found
	[   42.422234] hub 1-0:1.0: 2 ports detected
	[   42.422400] ehci-orion: EHCI orion driver
	[   42.422444] ehci-exynos: EHCI EXYNOS driver
	[   42.422480] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
	[   42.422492] ohci-pci: OHCI PCI platform driver
	[   42.422510] ohci-platform: OHCI generic platform driver
	[   42.422573] ohci-platform a7030000.ohci: Generic Platform OHCI controller
	[   42.422581] ohci-platform a7030000.ohci: new USB bus registered, assigned bus number 2
	[   42.422672] ohci-platform a7030000.ohci: irq 340, io mem 0xa7030000
	[   42.486191] hub 2-0:1.0: USB hub found
	[   42.486203] hub 2-0:1.0: 2 ports detected
	[   42.486346] ohci-exynos: OHCI EXYNOS driver
	[   42.486534] usbcore: registered new interface driver usb-storage
	[   42.613408] rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
	[   42.613657] i2c /dev entries driver
	[   42.615224] sdhci: Secure Digital Host Controller Interface driver
	[   42.615229] sdhci: Copyright(c) Pierre Ossman
	[   42.615379] Synopsys Designware Multimedia Card Interface Driver
	[   42.615713] sdhci-pltfm: SDHCI platform and OF driver helper
	[   42.617216] ledtrig-cpu: registered to indicate activity on CPUs
	[   42.617702] usbcore: registered new interface driver usbhid
	[   42.617706] usbhid: USB HID core driver
	[   42.618918] NET: Registered protocol family 17
	[   42.618999] 9pnet: Installing 9P2000 support
	[   42.619029] Key type dns_resolver registered
	[   42.619256] registered taskstats version 1
	[   42.619260] Loading compiled-in X.509 certificates
	[   42.619478] 602b0000.uart: ttyAMA0 at MMIO 0x602b0000 (irq = 341, base_baud = 0) is a SBSA
	[   42.626259] sd 0:0:6:0: [sdg] Attached SCSI disk
	[   42.647383] printk: console [ttyAMA0] enabled
	[   42.758014] usb 1-1: new high-speed USB device number 2 using ehci-platform
	[   42.803593] sd 0:0:7:0: [sdh] Attached SCSI disk
	[   42.826958] rtc-efi rtc-efi: setting system clock to 2018-12-11 17:09:49 UTC (1544548189)
	[   42.962621] hub 1-1:1.0: USB hub found
	[   42.963069] ALSA device list:
	[   42.968839] hub 1-1:1.0: 4 ports detected
	[   42.971826]   No soundcards found.
	[   46.718560] Freeing unused kernel memory: 1408K
	[   46.746123] Run /init as init process
	Starting rcS...
	++ Mounting filesystem
	ifdown: interface lo not configured
	ifdown: interface eth0 not configured
	++ Starting ssh daemon
	[   46.794176] random: sshd: uninitialized urandom read (32 bytes read)
	[   46.846017] usb 1-2: new high-speed USB device number 3 using ehci-platform
	ip: RTNETLINK answers: File exists
	udhcpc: started, v1.29.0.git
	Setting IP address 0.0.0.0 on eth0
	/var/empty must be owned by root and not group or world-writable.
	rcS Complete
	Welcome to Mini Linux
	GNU/Linux 4.20.0-rc6-next-20181211 aarch64
	Version: 1.1.6
		.--.
	       |o_o |
	       |:_/ |
	      //   \ \
	     (|     | )
	    /'\_   _/`\
	    \___)=(___/
	Documentation: http://open-estuary.org
	E-mail: Chinafengliang@163.com
	estuary:/$ udhcpc: sending discover
	[   47.006618] hub 1-2:1.0: USB hub found
	[   47.010463] hub 1-2:1.0: 4 ports detected
	[   47.086018] usb 1-1.1: new full-speed USB device number 4 using ehci-platform
	[   47.302012] usb 1-2.1: new full-speed USB device number 5 using ehci-platform
	[   47.418664] input: Keyboard/Mouse KVM 1.1.0 as /devices/platform/soc/a7020000.ehci/usb1/1-2/1-2.1/1-2.1:1.0/0003:12D1:0003.0001/input/input0
	[   47.490246] hid-generic 0003:12D1:0003.0001: input: USB HID v1.10 Keyboard [Keyboard/Mouse KVM 1.1.0] on usb-a7020000.ehci-2.1/input0
	[   47.503263] input: Keyboard/Mouse KVM 1.1.0 as /devices/platform/soc/a7020000.ehci/usb1/1-2/1-2.1/1-2.1:1.1/0003:12D1:0003.0002/input/input1
	[   47.515917] hid-generic 0003:12D1:0003.0002: input: USB HID v1.10 Mouse [Keyboard/Mouse KVM 1.1.0] on usb-a7020000.ehci-2.1/input1
	udhcpc: sending discover
	udhcpc: sending discover
	udhcpc: no lease, failing

	estuary:/$

Best Regards,
Wei

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
