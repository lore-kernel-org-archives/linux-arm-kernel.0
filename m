Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E854C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:28:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0620D2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gvZBnb1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0620D2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Upo0r3MXrkn7ZEPxIK6woPeR14eSTo80nW3E/CmWwb8=; b=gvZBnb1z17AGwm
	IwvZyxTIiEbs3UQ9mw2GbX6ybmUMjsUEwtOS9m9+RylR/zGMrzk6AQnUPFnqGdkw38M9AgJYRTTtQ
	GhtW14wsWQYd0YCBXS06jTJKmgjzo3ngz0d3u/b4MPqYKZMvFrMPo4bsCyGz18BTOgHF7i0PRJroY
	l8Jsk0SZZ32ipjCMfOXnwmJCvgzHA+7oC9AAmM7iuvJalmEgxCcHYe/tAz5NQFOotJAKFvFD3m3us
	tXB3kjJonul+Fnq7Q9hhNAfR3l6uIW0J5Nv4E7Z+JgD+A2UED7ekneEKvIi6arzLj8zAhToYZQGuq
	w028M2zgDZyqfYTrxngg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glyu9-00061b-3o; Tue, 22 Jan 2019 16:28:01 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glyu5-0005u5-PV
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 16:27:59 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E622A78;
 Tue, 22 Jan 2019 08:27:57 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B55AB3F6A8;
 Tue, 22 Jan 2019 08:27:55 -0800 (PST)
Date: Tue, 22 Jan 2019 16:27:53 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v4 13/25] KVM: arm64/sve: System register context switch
 and access support
Message-ID: <20190122162752.GI3578@e103592.cambridge.arm.com>
References: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
 <1547757219-19439-14-git-send-email-Dave.Martin@arm.com>
 <3d6da606-d7ae-5232-8317-4c550370b469@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3d6da606-d7ae-5232-8317-4c550370b469@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_082757_856680_00A670A3 
X-CRM114-Status: GOOD (  33.06  )
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 04:42:07PM +0000, Marc Zyngier wrote:
> On 17/01/2019 20:33, Dave Martin wrote:
> > This patch adds the necessary support for context switching ZCR_EL1
> > for each vcpu.
> > 
> > ZCR_EL1 is trapped alongside the FPSIMD/SVE registers, so it makes
> > sense for it to be handled as part of the guest FPSIMD/SVE context
> > for context switch purposes instead of handling it as a general
> > system register.  This means that it can be switched in lazily at
> > the appropriate time.  No effort is made to track host context for
> > this register, since SVE requires VHE: thus the hosts's value for
> > this register lives permanently in ZCR_EL2 and does not alias the
> > guest's value at any time.
> > 
> > The Hyp switch and fpsimd context handling code is extended
> > appropriately.
> > 
> > Accessors are added in sys_regs.c to expose the SVE system
> > registers and ID register fields.  Because these need to be
> > conditionally visible based on the guest configuration, they are
> > implemented separately for now rather than by use of the generic
> > system register helpers.  This may be abstracted better later on
> > when/if there are more features requiring this model.
> > 
> > ID_AA64ZFR0_EL1 is RO-RAZ for MRS/MSR when SVE is disabled for the
> > guest, but for compatibility with non-SVE aware KVM implementations
> > the register should not be enumerated at all for KVM_GET_REG_LIST
> > in this case.  For consistency we also reject ioctl access to the
> > register.  This ensures that a non-SVE-enabled guest looks the same
> > to userspace, irrespective of whether the kernel KVM implementation
> > supports SVE.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>

[...]

> > diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
> > index 1cf4f02..5ff2d90 100644
> > --- a/arch/arm64/kvm/fpsimd.c
> > +++ b/arch/arm64/kvm/fpsimd.c
> > @@ -103,6 +103,8 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
> >  void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
> >  {
> >  	unsigned long flags;
> > +	bool host_has_sve = system_supports_sve();
> > +	bool guest_has_sve = vcpu_has_sve(vcpu);
> >  
> >  	local_irq_save(flags);
> >  
> > @@ -110,7 +112,11 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
> >  		/* Clean guest FP state to memory and invalidate cpu view */
> >  		fpsimd_save();
> >  		fpsimd_flush_cpu_state();
> > -	} else if (system_supports_sve()) {
> > +
> > +		if (guest_has_sve)
> > +			vcpu->arch.ctxt.sys_regs[ZCR_EL1] =
> > +				read_sysreg_s(SYS_ZCR_EL12);
> 
> nit: Please keep assignments on a single line.

My antipathy for long lines got the better of me here.

If I can come up with a non-ridiculous way of shortening this line I'll
do that, otherwise I'm can join these lines and live with it.

> 
> > +	} else if (host_has_sve) {
> >  		/*
> >  		 * The FPSIMD/SVE state in the CPU has not been touched, and we
> >  		 * have SVE (and VHE): CPACR_EL1 (alias CPTR_EL2) has been

[...]

> >  /*
> >   * cpufeature ID register user accessors
> >   *
> > @@ -1278,7 +1374,11 @@ static const struct sys_reg_desc sys_reg_descs[] = {
> >  	ID_SANITISED(ID_AA64PFR1_EL1),
> >  	ID_UNALLOCATED(4,2),
> >  	ID_UNALLOCATED(4,3),
> > +#ifdef CONFIG_ARM64_SVE
> > +	{ SYS_DESC(SYS_ID_AA64ZFR0_EL1), access_id_aa64zfr0_el1, .get_user = get_id_aa64zfr0_el1, .set_user = set_id_aa64zfr0_el1, .check_present = sve_check_present },
> > +#else
> >  	ID_UNALLOCATED(4,4),
> > +#endif
> 
> Can't we always have this code present and fallback to the "unallocated"
> behaviour at runtime?

This may actually be preferable, since "check_present()" sounds like it
ought to be used to check whether the register is present for all
purposes, whereas right now it's only called to check whether to
enumerate the register in KVM_GET_REG_LIST.  This behaviour may confuse
us later on...

There may have been some difficulty with this, but if so I can't
remember what.  I'll take a look.

[...]

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
