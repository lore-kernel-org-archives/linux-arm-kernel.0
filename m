Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8F4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:40:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AE05217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kj8tKHOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE05217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lA7r+cxfvEMmSBb2NavMuSFyt0IO1rkU0HpJK7sR4KU=; b=Kj8tKHOGNwzjDp
	qhSr32fXPG0SZnjJs7qmpq9XvOhsbsujvU7iXfKBFVXexe3wLdbnojE1I2WKjKnpYTlq/mFk8Drpx
	zItLRg38R0XBtnB4sbIHVcAgMQ+16RSBbYjuJbtfRYx1LWLZj9zuxgVUz1k2Dm2mP87DjlALtPdvU
	wswWizCp5kH8UoXAMagaIBVrPVc5z4djcUrY0h4ecUdf+/FFfnParx7RYxpZSbmXdezsPNql4KD/l
	OltoUZlN8t0+OxC33tHMzvDb+NGiFR/0MeAGrGhb42kzDFnV5fjyB0PBVZUkZnuQWte4kb8fwbBOG
	KTp4SS/XH26Yj1MeWbmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyc26-0005Vo-9m; Tue, 26 Feb 2019 12:40:26 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyc23-0005VV-Bi
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:40:24 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F13480D;
 Tue, 26 Feb 2019 04:40:23 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F4483F703;
 Tue, 26 Feb 2019 04:40:21 -0800 (PST)
Date: Tue, 26 Feb 2019 12:40:18 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v5 05/26] KVM: arm64: Add missing #include of
 <linux/bitmap.h> to kvm_host.h
Message-ID: <20190226124018.GC17422@lakrids.cambridge.arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-6-git-send-email-Dave.Martin@arm.com>
 <20190220152349.GE4763@lakrids.cambridge.arm.com>
 <20190226120616.GG3567@e103592.cambridge.arm.com>
 <20190226123145.GB17422@lakrids.cambridge.arm.com>
 <20190226123320.GW3567@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190226123320.GW3567@e103592.cambridge.arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_044023_406300_8D20A9D4 
X-CRM114-Status: GOOD (  14.14  )
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
Cc: Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 12:33:22PM +0000, Dave Martin wrote:
> On Tue, Feb 26, 2019 at 12:31:45PM +0000, Mark Rutland wrote:
> > On Tue, Feb 26, 2019 at 12:06:16PM +0000, Dave Martin wrote:
> > > On Wed, Feb 20, 2019 at 03:23:50PM +0000, Mark Rutland wrote:
> 
> [...]
> 
> > > > #include <asm/barrier.h>
> > > 
> > > [...]
> > > 
> > > > #include <linux/jump_label.h>
> > > > #include <linux/percpu.h>
> > > 
> > > Done for those three.
> > 
> > Great.
> > 
> > > > #include <linux/thread_info.h>
> > > 
> > > Since commit e6b673b741ea ("KVM: arm64: Optimise FPSIMD handling to
> > > reduce guest/host thrashing", we do have <asm/thread_info.h>.
> > > 
> > > Since this header is not generic, this seems reasonable.  Is there
> > > something from <linux/thread_info.h> used here that I'm missing?
> > 
> > I think I just confused myself; <asm/thread_info.h> seems sufficient.
> 
> OK, I shan't worry about that one, then.

Cool.

FWIW, feel free to add:

Acked-by: Mark Rutland <mark.rutland@arm.com>

... to that fixed-up commmit.

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
