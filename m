Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D3FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:58:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC5FD20873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jzy/U4e/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5FD20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cznyOz5Bis7QgCroyQ3/oSEZ9T7zcC2Nyvp89858UL4=; b=Jzy/U4e/vHfId7
	rXdxHeLGCUeUK8radOC2ZkvVo1TQAA1UNtAGPrR832CiWGNiQ1hfvom0M4jiLs9iKiQJyzSnostZN
	CcgDHiNDgHtFmAso+YLef0LdpkGUIz9/f+vn4pn964zmGKlr2eo8zIntbc5HvzcJi1LjiqMC+55Mm
	4d9kNd5FNLS4v8LTEFFOPqYormlKE7xe7sHWzC8BpOTLD+dsaMwY8Y2ZxRe02OFCnLJonTXxHd712
	dZ+mumTYaM3JjWzwpHYQgvt8aWoiZ3V6yY+9xsc6PpzeHzlH/0Tg3kh2SNa/PhGk3y6kP9Nmld99R
	qJGJw33rsYPta3926/kg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt9Ho-0000Vh-Qt; Mon, 11 Feb 2019 10:58:04 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt9Hk-0000Tb-JR
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 10:58:02 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C153EA78;
 Mon, 11 Feb 2019 02:57:59 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DC9B3F557;
 Mon, 11 Feb 2019 02:57:58 -0800 (PST)
Date: Mon, 11 Feb 2019 10:57:55 +0000
From: Will Deacon <will.deacon@arm.com>
To: AngeloGioacchino Del Regno <kholk11@gmail.com>
Subject: Re: [PATCH] arm64/io: Don't use WZR in writel
Message-ID: <20190211105755.GB30880@fuggles.cambridge.arm.com>
References: <68b71c15f32341468a868f6418e4fcb375bc49ba.camel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <68b71c15f32341468a868f6418e4fcb375bc49ba.camel@gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_025800_641703_3297122C 
X-CRM114-Status: GOOD (  16.34  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Feb 09, 2019 at 07:34:53PM +0100, AngeloGioacchino Del Regno wrote:
> From 33fb6d036de273bb71ac1c67d7a91b7a5148e659 Mon Sep 17 00:00:00 2001
> From: "Angelo G. Del Regno" <kholk11@gmail.com>
> Date: Sat, 9 Feb 2019 18:56:46 +0100
> Subject: [PATCH] arm64/io: Don't use WZR in writel
> 
> This is a partial revert of commit ee5e41b5f21a
> ("arm64/io: Allow I/O writes to use {W,X}ZR")
> 
> When we try to use the zero register directly on some SoCs,
> their security will make them freeze due to a firmware bug.
> This behavior is seen with the arm-smmu driver freezing on
> TLBI and TLBSYNC on MSM8996, MSM8998, SDM630, SDM660.

Hmm, this sounds very fragile. I hope they're not trapping and emulating
MMIO accesses and treating the zero register as the stack pointer...

Wouldn't this also be triggerable from userspace by mmap()ing either
/dev/mem or e.g. a PCI bar via sysfs?

> Allocating a temporary register to store the zero for the
> write actually solves the issue on these SoCs.

I don't think this catches all MMIO accesses, so I think we need to
understand more about the actual issue here. For example, is it only the
SMMU that causes this problem? Also, any workaround should be specific to
the broken SoCs.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
