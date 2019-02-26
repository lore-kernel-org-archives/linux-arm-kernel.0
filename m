Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6296C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:13:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B20412173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="se+YhYTY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20412173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7M5OIjd4HWk5bY6dZZfWUMokmDH6Is520Oi7yMrE6+Y=; b=se+YhYTYg16LN2
	39y61AsgpMWioWac/Dhyf3awyysvhhBf/zD+eaVgRWD9wTsVXxbRqZE+CzWCX9FQfXd5DS3p6+D+S
	75Xc/KfDCJjZsHHC9aIVImmO0Omeh9faNoay/f7vq0kmDzKN9nLUZl/Jw1FxhG309LF9WDWRA8LCl
	qRszqQiT/9QNzZPoL4l52yQ1wvXBiEdLoWKycUyl1Yc+/ENCD22WXx+Vy6/w5l60Wh+TOyAFkaKaR
	JVLWZEyO3EMwcnZ26CtTfdM6RyblyVeIZM6KZWc8DBB4CmIX+NmuCyHNsBMrFpsuISbCMtXkFveIH
	uXCiGpNXQ6Pd3qhvtU5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybbS-0006sF-SN; Tue, 26 Feb 2019 12:12:54 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybbP-0006og-Ti
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:12:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6767880D;
 Tue, 26 Feb 2019 04:12:51 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99BA13F5C1;
 Tue, 26 Feb 2019 04:12:49 -0800 (PST)
Date: Tue, 26 Feb 2019 12:12:47 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 12/26] KVM: arm64: Support runtime sysreg visibility
 filtering
Message-ID: <20190226121247.GO3567@e103592.cambridge.arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-13-git-send-email-Dave.Martin@arm.com>
 <20190220153726.GF4763@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190220153726.GF4763@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_041251_975054_FAEB91BA 
X-CRM114-Status: GOOD (  25.64  )
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

On Wed, Feb 20, 2019 at 03:37:26PM +0000, Mark Rutland wrote:
> On Mon, Feb 18, 2019 at 07:52:25PM +0000, Dave Martin wrote:
> > Some optional features of the Arm architecture add new system
> > registers that are not present in the base architecture.
> > 
> > Where these features are optional for the guest, the visibility of
> > these registers may need to depend on some runtime configuration,
> > such as a flag passed to KVM_ARM_VCPU_INIT.
> > 
> > For example, ZCR_EL1 and ID_AA64ZFR0_EL1 need to be hidden if SVE
> > is not enabled for the guest, even though these registers may be
> > present in the hardware and visible to the host at EL2.
> > 
> > Adding special-case checks all over the place for individual
> > registers is going to get messy as the number of conditionally-
> > visible registers grows.
> > 
> > In order to help solve this problem, this patch adds a new sysreg
> > method restrictions() that can be used to hook in any needed
> > runtime visibility checks.  This method can currently return
> > REG_NO_USER to inhibit enumeration and ioctl access to the register
> > for userspace, and REG_NO_GUEST to inhibit runtime access by the
> > guest using MSR/MRS.
> > 
> > This allows a conditionally modified view of individual system
> > registers such as the CPU ID registers, in addition to completely
> > hiding register where appropriate.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > 
> > ---
> > 
> > Changes since v4:
> > 
> >  * Move from a boolean sysreg property that just suppresses register
> >    enumeration via KVM_GET_REG_LIST, to a multi-flag property that
> >    allows independent runtime control of MRS/MSR and user ioctl access.
> > 
> >    This allows registers to be either hidden completely, or to have
> >    hybrid behaviours (such as the not-enumerated, RAZ, WAZ behaviour of
> >    "non-present" CPU ID regs).
> 
> Sorry for bikeshedding...
> 
> > +	/* Check for regs disabled by runtime config */
> > +	if (restrictions(vcpu, r) & REG_NO_GUEST) {
> 
> Maybe it's worth wrapping this as something like
> 
> 	reg_runtime_hidden_from_guest(vcpu, r)
> 
> ... and avoid exposing the raw flags to all the places we have to check?
> 
> [...]
> 
> > +#define REG_NO_USER	(1 << 0) /* hidden from userspace ioctl interface */
> > +#define REG_NO_GUEST	(1 << 1) /* hidden from guest */
> 
> Perhaps REG_USER_HIDDEN and REG_GUEST_HIDDEN?

I'm not attached to any particular naming, so I'm not opposed to making
changes similar to those you suggest.

There are some anomalies right now:

1) Currently, we can express REG_NO_GUEST by itself, which is a of an
odd thing to have.  I'm not sure whether that's a problem or not.
Keeping the flags as-is at least keeps the code simple.

2) These flags do not quite have the obvious semantics: these are
overrides rather than determining precisely when a reg is/isn't
accessible.

So, REG_NO_USER means "don't even call this reg's get/set_user(): forbid
user access unconditionally", whereas lack of this flag means "call the
appropriate get/set_user() function to find out what to do, which may
or may not result in forbidding the access".

Maybe this subtlety is just a question of clear commenting.  I can't
think of obviously-correct names that won't be stupidly verbose...

Thoughts?

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
