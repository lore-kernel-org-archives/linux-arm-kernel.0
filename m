Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B891CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:13:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8870B21855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="If6LeIlQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8870B21855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4xHzCxyzq7ja2W6EwYdr3aGg5qMYWJUrL5DZ1vej50Q=; b=If6LeIlQyKke/b
	Kh/pCHlK0WMqBVicLhYH8KqQNSilqTD1yq3tRnIsM+tLln4sCBzLwn+NUB7poq0jlr9WBl3C0BKPQ
	lazoJdanGLeDmSq9hRBv8YQAKED/XTHea3W9vdMD5T+FcXWdqnIYOCgMMcihOpcQ1l7u6npL2qEs7
	AT4tfdWS44FUocmnN2hC2IDtG86pJcp1SogWQyg2l7vKfEeo/iNU3/gXbAclJbenfYn+TgDuJF/qp
	OMbUQvoCvB0Z5Iw6gUPwIcdZwuQ2WcWFMFlNPJ6Y8Q0OwaibjfVuQTQQtcUnHPnwCwscRp3WJ/d4a
	rPJCmR58siG6t23ZyehQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybc8-0007Qq-16; Tue, 26 Feb 2019 12:13:36 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybby-0007II-6l
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:13:29 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04557A78;
 Tue, 26 Feb 2019 04:13:26 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 379E03F5C1;
 Tue, 26 Feb 2019 04:13:24 -0800 (PST)
Date: Tue, 26 Feb 2019 12:13:21 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v5 14/26] KVM: arm64/sve: Context switch the SVE registers
Message-ID: <20190226121321.GQ3567@e103592.cambridge.arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-15-git-send-email-Dave.Martin@arm.com>
 <83fa5587-24a0-5bbb-c113-cddc74571ea2@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <83fa5587-24a0-5bbb-c113-cddc74571ea2@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_041326_713789_C5032645 
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

On Wed, Feb 20, 2019 at 04:46:57PM +0000, Julien Thierry wrote:
> 
> 
> On 18/02/2019 19:52, Dave Martin wrote:
> > In order to give each vcpu its own view of the SVE registers, this
> > patch adds context storage via a new sve_state pointer in struct
> > vcpu_arch.  An additional member sve_max_vl is also added for each
> > vcpu, to determine the maximum vector length visible to the guest
> > and thus the value to be configured in ZCR_EL2.LEN while the is
> 
> "While the <guest> is active"?

Hmmm, yes.  Thanks for deciphering that.  Done.

> > active.  This also determines the layout and size of the storage in
> > sve_state, which is read and written by the same backend functions
> > that are used for context-switching the SVE state for host tasks.
> > 
> > On SVE-enabled vcpus, SVE access traps are now handled by switching
> > in the vcpu's SVE context and disabling the trap before returning
> > to the guest.  On other vcpus, the trap is not handled and an exit
> > back to the host occurs, where the handle_sve() fallback path
> > reflects an undefined instruction exception back to the guest,
> > consistently with the behaviour of non-SVE-capable hardware (as was
> > done unconditionally prior to this patch).
> > 
> > No SVE handling is added on non-VHE-only paths, since VHE is an
> > architectural and Kconfig prerequisite of SVE.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > 
> 
> Otherwise:
> 
> Reviewed-by: Julien Thierry <julien.thierry@arm.com>

Thanks
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
