Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3A7C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:43:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC430222B2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WOWAyt+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC430222B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7uRgdnKxeQ51XECZUUoNxBfKVjXS18XLPgGsVy6JO44=; b=WOWAyt+ZXNVclY
	m1NnPK1lOx6ZLNTBof6hX0R83h7ziL1R8CJ0BYKufdfAkK/c8QbsMfC/aoOJ5FKO8Fpm9cz5GS/g+
	S3z2VKtkoXXzi8xlmN9lVfGCvtvENzVSAY91eg+6PXIGuClT4tpxRK3u43XHp9Mnvfnx71x1fKOuS
	Ksh0qr983qTQ7XszatYFzRNeBoE2LYOV3z8kDbEmNRfKw5mWaijtKJtEzVl8VL0svGUGp66AF7LXA
	/d4Rksyyy/h1S7GHTP3aZGyesvI0cDJEU3crIE4Iwsfw14HokcgxblJ1plMKC+fl9bYA69j8++A5l
	pg/UCiRIyQSCd5Ukuq4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtswU-0002fh-8Q; Wed, 13 Feb 2019 11:43:06 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtswR-0002fF-8w
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 11:43:04 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E3FAA78;
 Wed, 13 Feb 2019 03:43:02 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47C0C3F557;
 Wed, 13 Feb 2019 03:43:01 -0800 (PST)
Date: Wed, 13 Feb 2019 11:42:58 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 0/4] arm64: SMCCC conduit cleanup
Message-ID: <20190213114258.GD22119@lakrids.cambridge.arm.com>
References: <20180503170330.5591-1-mark.rutland@arm.com>
 <20190212152444.GE6302@fuggles.cambridge.arm.com>
 <20190212172035.GC199333@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190212172035.GC199333@arrakis.emea.arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_034303_316491_07C6874D 
X-CRM114-Status: GOOD (  15.15  )
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
Cc: lorenzo.pieralisi@arm.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
 Will Deacon <will.deacon@arm.com>, james.morse@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 12, 2019 at 05:20:35PM +0000, Catalin Marinas wrote:
> On Tue, Feb 12, 2019 at 03:24:44PM +0000, Will Deacon wrote:
> > On Thu, May 03, 2018 at 06:03:26PM +0100, Mark Rutland wrote:
> > > Currently, the cpu errata code goes digging into PSCI internals to
> > > discover the SMCCC conduit, using the (arguably misnamed) PSCI_CONDUIT_*
> > > definitions. This lack of abstraction is somewhat unfortunate.
> > > 
> > > Further, the SDEI code has an almost identical set of CONDUIT_*
> > > definitions, and the duplication is rather unfortunate.
> > > 
> > > Let's unify things behind a common set of SMCCC_CONDUIT_* definitions,
> > > and expose the SMCCCv1.1 conduit via a new helper that hides the PSCI
> > > driver internals.
> > 
> > I just noticed that this didn't get merged, for some reason. I acked it at
> > the time, so what's left to do?
> 
> Apparently I queued it briefly and then dropped it:
> 
> https://lore.kernel.org/linux-arm-kernel/20180601143747.3axhy5a2kmxecfcs@armageddon.cambridge.arm.com/

IIRC there were conflicts with some of the FW mitigations code.

I'll try to rebase and resend this shortly.

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
