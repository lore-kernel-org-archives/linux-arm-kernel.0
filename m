Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF5DC2F421
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:24:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1587321019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K7WXW2FF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1587321019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6wYNuUc+3mmYizVGRFvvqPZrFqXFv1lWSNhRUCMMi5o=; b=K7WXW2FFXQs+sO
	XcoUkkBr7T9ijEN/3OriFoYC17lkhva8wFFQd2xn9p+eE9WG/o7ZqxSVTn+pR0QXehZ4h7xG6qctB
	QERJjza21boIzBeSBV5F7/NBF461loOUNjogOXQvdafHfvzhQWN/DVs6Y00y1awmVxkmlOA+DSggE
	nfRD7/TXBa+JgCDyG7YmA5WYIJC3v6qFjWRMEL50MtsH08kyWy5lXruvTUtGSYyuiNeXlkSXa0aUU
	4dBsTNzcifD6j7N0IlzLur9cTSPCslpTB5EZO0fKgP0Kic9byPIyhDeUo2hkGhuLTdyQ3QUspcU3O
	sEYIMCnFeBro14BLPUpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glcN5-0007sb-5S; Mon, 21 Jan 2019 16:24:23 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glcN1-0007sB-PF
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 16:24:21 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50118EBD;
 Mon, 21 Jan 2019 08:24:19 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 859803F614; Mon, 21 Jan 2019 08:24:18 -0800 (PST)
Date: Mon, 21 Jan 2019 16:24:16 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64: defaults NR_CPUS to 256
Message-ID: <20190121162415.GF29504@arrakis.emea.arm.com>
References: <20190114114125.10972-1-mark.rutland@arm.com>
 <20190114115035.GA13490@fuggles.cambridge.arm.com>
 <20190114120031.GB10258@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190114120031.GB10258@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_082419_827878_B09D7572 
X-CRM114-Status: GOOD (  18.99  )
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
Cc: Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 14, 2019 at 12:00:33PM +0000, Mark Rutland wrote:
> On Mon, Jan 14, 2019 at 11:50:35AM +0000, Will Deacon wrote:
> > On Mon, Jan 14, 2019 at 11:41:25AM +0000, Mark Rutland wrote:
> > > There are shipping arm64 platforms with 256 hardware threads. So that we
> > > can make use of these with defconfig, bump the arm64 default NR_CPUS to
> > > 256.
> > > 
> > > At the same time, drop a redundant comment. We only have one default for
> > > NR_CPUS, so there's nothing to sort.
> > > 
> > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > ---
> > >  arch/arm64/Kconfig | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index a4168d366127..4cad67b9ec0a 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -792,8 +792,7 @@ config SCHED_SMT
> > >  config NR_CPUS
> > >  	int "Maximum number of CPUs (2-4096)"
> > >  	range 2 4096
> > > -	# These have to remain sorted largest to smallest
> > > -	default "64"
> > > +	default "256"
> > 
> > Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Cheers!
> 
> Catalin, assuming you'll pick this up, could you please correct the
> title with s/defaults/default/ ?
> 
> ... or if you prefer, I can resend with that corrected.

Queued for 5.1 (with title corrected). Thanks.

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
