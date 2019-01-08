Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A7BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:14:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25EF220850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="btzDEPSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25EF220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Td9WG+lqG6mXXRdsWaniHvDTHTB9CyhXFco4Oce2b1A=; b=btzDEPSOAjF9gB
	gSMKFQFfEInA3tkgWxCAJN7U01Qy22kY47FUKo1yAJQbC60poxmTQXQANjF+kpXw05aNCmK79Xc06
	rcNWGn97ioI/lLlHTfc7JunUEaaroUofFDlTIEF4YxwqD2wdMsbxI3v7M8MjLxoiPpRcEgMXIOlT1
	wYc9y0EfBnqrs8eT45yNP/slWTVh2pVOPri+S0lsxBUolkYr3j5drdYDs592tW+I9Ki8aoz/z4ujU
	nxdm0T4iwtZ7zSHrnLQUH6I8oklIV3oO0lN68YuYg/U3N2kV7U4rDDhviStLRvbFfoOvi50UktqBf
	1o1v0Cus22iQwetGLimg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggqHT-0002nY-1E; Tue, 08 Jan 2019 12:14:51 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggqHP-0002kz-0a; Tue, 08 Jan 2019 12:14:48 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D0481596;
 Tue,  8 Jan 2019 04:14:45 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B61413F70D;
 Tue,  8 Jan 2019 04:14:43 -0800 (PST)
Date: Tue, 8 Jan 2019 12:14:41 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Miles Chen <miles.chen@mediatek.com>
Subject: Re: [PATCH] arm64: trap illegal translations in __virt_to_phys()
Message-ID: <20190108121440.GC29102@lakrids.cambridge.arm.com>
References: <1546860080-13027-1-git-send-email-miles.chen@mediatek.com>
 <20190107150019.GC46743@lakrids.cambridge.arm.com>
 <1546917883.6754.8.camel@mtkswgap22>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546917883.6754.8.camel@mtkswgap22>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_041447_221071_1E9707C5 
X-CRM114-Status: GOOD (  16.95  )
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
Cc: wsd_upstream@mediatek.com, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 08, 2019 at 11:24:43AM +0800, Miles Chen wrote:
> On Mon, 2019-01-07 at 15:00 +0000, Mark Rutland wrote:
> > On Mon, Jan 07, 2019 at 07:21:20PM +0800, Miles Chen wrote:
> > > Current __virt_to_phys() only print warning messages for non-linear
> > > addresses. It's hard to catch all warnings by those messages.
> > 
> > Why? Are you seeing a large number of warnings somewhere?
> 
> Official kernel works fine. I saw some cases in our internal branch and
> we're fixing them.
> 
> > 
> > > So add a VIRTUAL_BUG_ON() to trap all non-linear and non-symbol
> > > addresses (e.g., stack addresses)
> > > 
> > > Tested by pass stack addresses and symbol addresses to __pa(). Result:
> > > stack addresses: kernel BUG()
> > 
> > Either:
> > 
> > * Stacks are vmap'd, and __is_lm_address(stack_addr) is false. We'll
> >   produce a WARNING() today (and return a junk physical address).
> > 
> > * Stacks are linear mapped, and cannot be distinguished from other
> >   linear mapped addresses. The physical address will be valid.
> > 
> > ... so I don't understand why you need to change this.
> 
> For the first case: for vmap'd stack, __pa() returns a junk
> physical address and it might be easier to debug this incorrect address
> translation by a BUG() call instead of monitoring the warning log.

I think that's an argument for upgrading the existing WARN() to a BUG(),
rather than adding a separate VIRTUAL_BUG_ON().

However, there are cases where the junk physical address is not used to
perform an access, and the WARN() is more helpful.

You can set panic_on_warn to get an immediate panic() when the WARN()
fires. Is there some reason that approach doesn't work for you?

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
