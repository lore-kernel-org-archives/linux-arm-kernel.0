Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A45EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:14:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD8C2087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZdEPN1Kz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD8C2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/x+HwCW0K/PilkPrSfXgqmVkmjZxj29dcs0UdiWUbvk=; b=ZdEPN1KzRGktZZ
	NX+oEOD7HyJ5+VY6+aUs1D4sRTdsFbvoXG1aP9pdIxBWWBOqlEbDy8fyBsUDd40BqheAiDZkRJZUM
	Hf5u56oDWLnGPPFFlSyaCxM9vXvOMztADv5Yid6dxQRr7GSsrhrFDedUNROZ2/IxoBeAnMKSsILU2
	grvKam8klczqazfwC/rpIHpkFCm5OoW3/S63G8pCojxhovNMmxUNTToj0zi+hUlNdV00cNlJqc4LK
	1vD81AUivgP5Y6dDjgLPoDP8eEnIO5NYYJeTrYvPuBzymRkLw5UjwB9heuUJwEa9kzoGi/YtMsY0G
	2/DVvCv/AszhUADcI9EQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybd9-00007r-Dl; Tue, 26 Feb 2019 12:14:39 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybcV-0007yE-RQ
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:14:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 881CF80D;
 Tue, 26 Feb 2019 04:13:59 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB59F3F5C1;
 Tue, 26 Feb 2019 04:13:57 -0800 (PST)
Date: Tue, 26 Feb 2019 12:13:55 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v5 23/26] KVM: arm64/sve: Allow userspace to enable SVE
 for vcpus
Message-ID: <20190226121355.GU3567@e103592.cambridge.arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-24-git-send-email-Dave.Martin@arm.com>
 <88f7a00d-019a-5ed3-5a80-6032775dc5c5@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <88f7a00d-019a-5ed3-5a80-6032775dc5c5@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_041400_246790_B422C2F2 
X-CRM114-Status: GOOD (  23.19  )
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

On Fri, Feb 22, 2019 at 09:05:16AM +0000, Julien Thierry wrote:
> Hi Dave,
> 
> On 18/02/2019 19:52, Dave Martin wrote:
> > Now that all the pieces are in place, this patch offers a new flag
> > KVM_ARM_VCPU_SVE that userspace can pass to KVM_ARM_VCPU_INIT to
> > turn on SVE for the guest, on a per-vcpu basis.
> > 
> > As part of this, support for initialisation and reset of the SVE
> > vector length set and registers is added in the appropriate places.
> > Allocation SVE registers is deferred until kvm_arm_vcpu_finalize(),
> > by which time the size of the registers is known.
> > 
> > Setting the vector lengths supported by the vcpu is considered
> > configuration of the emulated hardware rather than runtime
> > configuration, so no support is offered for changing the vector
> > lengths of an existing vcpu across reset.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > 
> > ---
> > 
> > Changes since v4:
> > 
> >  * Pull out vcpu_sve_state_size(), for use earlier in the series.
> > 
> >  * Remove unnecessary vcpu->arch.sve_vqs[], and clamp maximum guest
> >    vector length to 256 bytes for forwards compatibility.
> > 
> >    (See "KVM: arm64/sve: Add pseudo-register for the guest's vector
> >    lengths".)
> > 
> >  * Minor tidyups to make some checks less verbose.
> > ---
> >  arch/arm64/include/asm/kvm_host.h |  2 +-
> >  arch/arm64/include/uapi/asm/kvm.h |  1 +
> >  arch/arm64/kvm/reset.c            | 70 ++++++++++++++++++++++++++++++++++++++-
> >  3 files changed, 71 insertions(+), 2 deletions(-)

[...]

> > diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c

[...]

> >  int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu)
> >  {
> >  	if (likely(kvm_arm_vcpu_finalized(vcpu)))
> >  		return 0;
> >  
> > +	if (vcpu_has_sve(vcpu)) {
> > +		size_t size = vcpu_sve_state_size(vcpu);
> > +
> > +		if (!size)
> > +			return -EINVAL;
> > +
> > +		vcpu->arch.sve_state = kzalloc(size, GFP_KERNEL);
> 
> We should probably free this in kvm_arch_vcpu_free().

Hmmm, good spot!

Looks like I lost that during a previous rebase.

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
