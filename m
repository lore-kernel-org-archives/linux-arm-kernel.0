Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D23C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:24:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C42A02087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qh6HcG4g";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BkUBUEri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42A02087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wGGM0Sg2nIYGUwPGjghoN3KnH1QNii/Zy0kG1zBX1Wc=; b=Qh6HcG4gybpWtY
	ldZchsYj0GDzG8zIaDHUIfgZd/uIPlbxT+IJMoBnXT22ldPdYwtZ7aQYs04muEIWn2rNQ53navRCr
	W9q25zHJjja/ngoKOhIr6ohaVNQvY+D83shIpsXS0/5CGgEr3mDuRMQOhFso8oNOoMNluid3A/iRH
	RHMOCrcPXXFzu0qU37IfN2Z/quMuX9cORgCOaWw2tusSt0c5EC/2s8ard6Mdlsv2DhuoItxeY5Id1
	ZH6vgHWvRfDtrJgqaRT9iff9JZEJzFsM/mevn8+XOpyCUf/gLEaSluGPUUYwd+QAjjQR8N+w5ggc5
	f3IrKxYgrxLk1F4RJu2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybmH-0004nG-Th; Tue, 26 Feb 2019 12:24:05 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybmF-0004gC-76
 for linux-arm-kernel@bombadil.infradead.org; Tue, 26 Feb 2019 12:24:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7FWIgQmHac+5d6/2Z99u0V4qgUTi+rABxE5BQnZmAIA=; b=BkUBUErib+mRlI4cT0LD77SYs
 IFd3b+ohQSLneQS6OPw5qVICZumOPxC2H6veuXv8POlY2ef7uFXS/WOYPr7bXFY2MgD5y/8bzJjU+
 hP/mLRpDkv1qRkqTA2FnpNmDr2ViOB8FJ+94XLSRMkKGyLWTy5D3p5GJzVWyAt24dBh4zltCaIglS
 gaCC627m11k1zaaN6IjjaW8xBEkqFIp9Z82bvoS9c9XIsrqAV1HMgJUssLhDm6jUOIiPcf0T1U2x0
 CuvrQ/mwXGglvT48TdT8qOiSNicN3VgUs4qi4T/J9LPnXS3NG+XNUol8/tgb/R2Dp25iFKUOA7JA9
 0dVEA0njA==;
Received: from foss.arm.com ([217.140.101.70])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybWg-0002t4-Cn
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:08:00 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98C3BA78;
 Tue, 26 Feb 2019 04:07:56 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB94C3F71D;
 Tue, 26 Feb 2019 04:07:54 -0800 (PST)
Date: Tue, 26 Feb 2019 12:07:52 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v5 12/26] KVM: arm64: Support runtime sysreg visibility
 filtering
Message-ID: <20190226120752.GN3567@e103592.cambridge.arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-13-git-send-email-Dave.Martin@arm.com>
 <2819c91f-3a28-b878-0ea1-d20afcf05895@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2819c91f-3a28-b878-0ea1-d20afcf05895@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_120758_690673_C88AFDAD 
X-CRM114-Status: GOOD (  21.80  )
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

On Wed, Feb 20, 2019 at 02:33:44PM +0000, Julien Thierry wrote:
> 
> 
> On 18/02/2019 19:52, Dave Martin wrote:
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
> 
> Reviewed-by: Julien Thierry <julien.thierry@arm.com>

Thanks
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
