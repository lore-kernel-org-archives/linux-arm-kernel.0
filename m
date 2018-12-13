Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12998C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:02:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49262075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BiRZngs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49262075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pfLP9lMiXfr6cAcAgP6k/ytiFUixgmYNAA7zDy7VDlE=; b=BiRZngs60HBIc9
	oLULiHECqT5AV6jQRC9cf68jMP5f/FOj/4FPEi4Z1geT+75BrGCr6kmu1bdQAGwYCacXN/GWEmC4I
	0CuDurJXExHHi3fdPMGAScAnTb49vA5JlWEzafRQm7K+u58sZ0CDap/ECpnAVWxNSOKBGeAhx9bRp
	HtHyH28VrwutohipRil+Kt5pxLvxeGL0+rHvn5zfWHUj6cjvLwLHUIGtmOkllbgpRDa+SS45GLuKv
	gkWCQkdIhbB2nHPyXLIhBlbLeICNBl9i/pG0iKs/z8m6c9PTWqUIOCso978PXI0ZVwQKNigZBZWi+
	UhoHbiyrEbOr+DZI1Jew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQcr-00058a-LE; Thu, 13 Dec 2018 13:02:01 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQco-000584-3X
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 13:01:59 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA7ECEBD;
 Thu, 13 Dec 2018 05:01:46 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 99EFB3F575;
 Thu, 13 Dec 2018 05:01:46 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 6C35F1AE0D04; Thu, 13 Dec 2018 13:02:10 +0000 (GMT)
Date: Thu, 13 Dec 2018 13:02:10 +0000
From: Will Deacon <will.deacon@arm.com>
To: John Garry <john.garry@huawei.com>
Subject: Re: arm64 board boot pauses on linux-next (resend)
Message-ID: <20181213130210.GC31177@edgewater-inn.cambridge.arm.com>
References: <95b1b28c-da6d-fa1f-4b39-ed3c37c4bb9e@huawei.com>
 <8e1e38dd-70b0-a0ec-0687-581cc773b600@arm.com>
 <644bb3fa-20e5-9958-e3aa-67eb711289ce@huawei.com>
 <4f82e9c4-acfb-d36e-5a54-876fd0e22d69@arm.com>
 <eac9866b-3cb4-f7af-dc21-7f685bd3aa96@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <eac9866b-3cb4-f7af-dc21-7f685bd3aa96@huawei.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_050158_174460_79A62694 
X-CRM114-Status: GOOD (  24.00  )
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
Cc: ard.biesheuvel@linaro.org, Robin Murphy <robin.murphy@arm.com>,
 Linuxarm <linuxarm@huawei.com>, linux-arm-kernel@lists.infradead.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[+Ard]

On Thu, Dec 13, 2018 at 11:27:09AM +0000, John Garry wrote:
> On 12/12/2018 19:16, Suzuki K Poulose wrote:
> > On 12/12/2018 06:07 PM, John Garry wrote:
> > > On 12/12/2018 17:17, Robin Murphy wrote:
> > > > On 12/12/2018 16:48, John Garry wrote:
> > > > > I am finding our arm64 D05 board particularly slow to boot from
> > > > > linux-next, specifically a 30+ second pause when setting up CPU
> > > > > features.
> > > > 
> > > > That does look like it's almost certainly spending the mystery time in
> > > > setup_cpu_features() itself.
> > > 
> > > Seems to be "Kernel page table isolation (KPTI)" feature which we hang
> > > on, but I would not say that's conclusive.
> > > 
> > 
> > I think I have an idea what could be happening. The cpu_enable()
> > for KPTI, waits for all the secondary CPUs to enter a busy loop,
> > before installing the non-global mapping. So, with the changes in
> > -next, we batch the cpu_enabl() callbacks, which implies, the seconary
> > CPUs end up in the "cpu_enable()" for KPTI at different times.
> > 
> > Could you check if the following hack makes it any better ?
> > 
> 
> Unfortunately it does not help:
> [    5.502243] CPU63: Booted secondary processor 0x0000070303 [0x410fd082]
> [    5.502329] smp: Brought up 4 nodes, 64 CPUs
> [    7.442722] SMP: Total of 64 processors activated.
> [    7.447567] CPU features: detected: GIC system register CPU interface
> [    7.454098] CPU features: detected: 32-bit EL0 Support
> [    7.459291] CPU features: detected: CRC32 instructions
> [   40.236781] CPU: All CPU(s) started at EL2
> [   40.241062] alternatives: patching kernel code
> [   40.263213] devtmpfs: initialized
> [   40.267140] clocksource: jiffies: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 7645041785100000 ns
> [   40.277147] futex hash table entries: 16384 (order: 8, 1048576 bytes)
> [   40.284424] pinctrl core: initialized pinctrl subsystem
> [   40.290081] SMBIOS 3.0.0 present.
> 
> BTW, If you guys know the reason for this delay and it is not going to be an
> issue, then that's fine. I just wanted to raise awareness.

I think I've managed to reproduce the issue locally and it appears to be
because of the default rodata=full changes. One impact of the change is
that the linear map is now mapped at page granularity, so the kpti work
to convert everything to non-global takes considerably longer.

Given that most machines are not affected by meltdown, I think we should
probably look at expanding the whitelist we have, rather than pile more
complexity into the early page table code.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
