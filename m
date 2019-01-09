Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FB2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:35:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBFA62146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZC19xiNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBFA62146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jGDAcV/jzGPw/MR2+E3fSa1ewGqaj7fa3bV660lwbf0=; b=ZC19xiNNbpE99L
	6tYRmmSI646YNWVN+k10AQ3u7b689C8xTBk7hZiATPkf65RMJ2FhZqazfUKamtNeRI2MgyoIbqqCX
	k7dkCWb7mmr1BbdiVTTSRTsh7PETg//mEWAbT9voCjNwPL9w6JdYXtuyBMbHtkh1BfQ/O9HfI9ANf
	3u1/8WHP2etZgYb2g11I6iDPBMulfcziiNIRlPS/eoNClkI2v11NJMqsefm6OtLQlDM2Uh8VvrTV0
	gd5DPWO2gG20LWykdI1GVg2ZFLk2V3PfcTc3mdIeC8T9KX8XAQphEQeaYZC24k4aKiajm2dCdr0Iv
	1WKn/Znf4mMEyWr+KrlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gh2mT-0004f5-Ae; Wed, 09 Jan 2019 01:35:41 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh2mP-0004eI-4I; Wed, 09 Jan 2019 01:35:38 +0000
X-UUID: 93c49c3392ad4de08806687fdc797e9e-20190108
X-UUID: 93c49c3392ad4de08806687fdc797e9e-20190108
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <miles.chen@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 391827558; Tue, 08 Jan 2019 17:35:20 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 8 Jan 2019 17:35:19 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by mtkcas07.mediatek.inc
 (172.21.101.84) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Wed, 9 Jan 2019 09:35:17 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 9 Jan 2019 09:35:17 +0800
Message-ID: <1546997717.20937.3.camel@mtkswgap22>
Subject: Re: [PATCH] arm64: trap illegal translations in __virt_to_phys()
From: Miles Chen <miles.chen@mediatek.com>
To: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 9 Jan 2019 09:35:17 +0800
In-Reply-To: <20190108121440.GC29102@lakrids.cambridge.arm.com>
References: <1546860080-13027-1-git-send-email-miles.chen@mediatek.com>
 <20190107150019.GC46743@lakrids.cambridge.arm.com>
 <1546917883.6754.8.camel@mtkswgap22>
 <20190108121440.GC29102@lakrids.cambridge.arm.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_173537_177017_06AA6239 
X-CRM114-Status: GOOD (  18.35  )
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

On Tue, 2019-01-08 at 12:14 +0000, Mark Rutland wrote:
> On Tue, Jan 08, 2019 at 11:24:43AM +0800, Miles Chen wrote:
> > On Mon, 2019-01-07 at 15:00 +0000, Mark Rutland wrote:
> > > On Mon, Jan 07, 2019 at 07:21:20PM +0800, Miles Chen wrote:
> > > > Current __virt_to_phys() only print warning messages for non-linear
> > > > addresses. It's hard to catch all warnings by those messages.
> > > 
> > > Why? Are you seeing a large number of warnings somewhere?
> > 
> > Official kernel works fine. I saw some cases in our internal branch and
> > we're fixing them.
> > 
> > > 
> > > > So add a VIRTUAL_BUG_ON() to trap all non-linear and non-symbol
> > > > addresses (e.g., stack addresses)
> > > > 
> > > > Tested by pass stack addresses and symbol addresses to __pa(). Result:
> > > > stack addresses: kernel BUG()
> > > 
> > > Either:
> > > 
> > > * Stacks are vmap'd, and __is_lm_address(stack_addr) is false. We'll
> > >   produce a WARNING() today (and return a junk physical address).
> > > 
> > > * Stacks are linear mapped, and cannot be distinguished from other
> > >   linear mapped addresses. The physical address will be valid.
> > > 
> > > ... so I don't understand why you need to change this.
> > 
> > For the first case: for vmap'd stack, __pa() returns a junk
> > physical address and it might be easier to debug this incorrect address
> > translation by a BUG() call instead of monitoring the warning log.
> 
> I think that's an argument for upgrading the existing WARN() to a BUG(),
> rather than adding a separate VIRTUAL_BUG_ON().
> 
> However, there are cases where the junk physical address is not used to
> perform an access, and the WARN() is more helpful.

got it.

> 
> You can set panic_on_warn to get an immediate panic() when the WARN()
> fires. Is there some reason that approach doesn't work for you?

panic_on_warn works fine. thanks for your comment.


cheers,
Miles

> 
> Thanks,
> Mark.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
