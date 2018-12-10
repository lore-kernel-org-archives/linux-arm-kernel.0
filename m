Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C30C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:34:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2284720821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BtwwRFIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2284720821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ingZRCaTzDaTtoLn5sm8OD+Ki0bCQRj1SckeOhpbmuY=; b=BtwwRFIOY5Gw3J
	Ka8GQJFpNjVGPfn6yqNF1oov8YSwnqN5svq8i3ZL8b7puWbBACVier5pDyItOshK8iBzgeYz2zJ2I
	iPoy8cmllI6FMY/4jS9NqohvPj9QReB6EfzPW88Y0Ci2AEZa7/jX43OwtG435z2z9rLqlZwnoJmBG
	jabT/wybjs4lrIe+JXVcqo47/zRI903omQETjFyh5GwMWw4Rvl224vmye+GD6tfRwLruw4seQYokg
	4A5iO4e48LFJDyAHLdM0IdIGPk03ECZ6gfAB7m8gHEBYlxHXhSsZ1r2O3miD4uCsBfR/sTa+02vAK
	XpRBUA+whtQpQvZ5mf7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWRK9-0001Qz-3b; Mon, 10 Dec 2018 19:34:37 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWRK6-0001O2-Cq
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 19:34:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF34115AD;
 Mon, 10 Dec 2018 11:34:23 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9F89E3F59C;
 Mon, 10 Dec 2018 11:34:23 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 5BFB41AE0B6A; Mon, 10 Dec 2018 19:34:46 +0000 (GMT)
Date: Mon, 10 Dec 2018 19:34:46 +0000
From: Will Deacon <will.deacon@arm.com>
To: Steve Capper <steve.capper@arm.com>
Subject: Re: [PATCH V5 0/7] 52-bit userspace VAs
Message-ID: <20181210193445.GB8923@edgewater-inn.cambridge.arm.com>
References: <20181206225042.11548-1-steve.capper@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181206225042.11548-1-steve.capper@arm.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_113434_434498_3CFD03FC 
X-CRM114-Status: GOOD (  16.16  )
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
Cc: ard.biesheuvel@linaro.org, jcm@redhat.com, suzuki.poulose@arm.com,
 linux-mm@kvack.org, catalin.marinas@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 10:50:35PM +0000, Steve Capper wrote:
> This patch series brings support for 52-bit userspace VAs to systems that
> have ARMv8.2-LVA and are running with a 48-bit VA_BITS and a 64KB
> PAGE_SIZE.
> 
> If no hardware support is present, the kernel runs with a 48-bit VA space
> for userspace.
> 
> Userspace can exploit this feature by providing an address hint to mmap
> where addr[51:48] != 0. Otherwise all the VA mappings will behave in the
> same way as a 48-bit VA system (this is to maintain compatibility with
> software that assumes the maximum VA size on arm64 is 48-bit).
> 
> This patch series applies to 4.20-rc1.
> 
> Testing was in a model with Trusted Firmware and UEFI for boot.
> 
> Changed in V5, ttbr1 offsetting code simplified. Extra patch added to
> check for VA space support mismatch between CPUs.

I was all ready to push this out, but I spotted a build failure with
allmodconfig because TASK_SIZE refers to the non-EXPORTed symbol
vabits_user:

ERROR: "vabits_user" [lib/test_user_copy.ko] undefined!
ERROR: "vabits_user" [drivers/misc/lkdtm/lkdtm.ko] undefined!
ERROR: "vabits_user" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!

So I've pushed an extra patch on top to fix that by exporting the symbol.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
