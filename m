Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E55C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:13:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DEE32173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NW2BMd5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DEE32173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fP5SBtxsdOBww6uvKO/qFuadKwRcR1+EBA0R6O9bcZY=; b=NW2BMd5QFQg8Y8
	B6Li6Ro9vjVfXxPBtlUFVA2lB1VD9mJGZKyLBd3fnrXd5ueOpjXPdPXteYs3nnsnDu6GxlAQKVedy
	Yf49hJSsa5/iLuCeshp/FgdZX9jkTRA1h5euZa+npoYsajvaeFnAYTRKg8IK69/coNn9aEFrMdV3N
	Mo1UfyjGmNPymFREuxmUMLrs2NE7wUyodTKNbByn5SDYGlQy3Vb8RkfzEr3dTzZXRMEqUrPf7W8Kx
	iQNWbM4F6CWa1qMoWELDLNGNgTCYG3UA9bvzice4nYENxzU2r0/hb3g5dLhqqb24ZY/2LNom22STE
	LC+wOe0umdLpplH8Srew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybbs-0007AE-9w; Tue, 26 Feb 2019 12:13:20 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybbp-00079k-6M
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:13:18 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3D2680D;
 Tue, 26 Feb 2019 04:13:16 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12C963F5C1;
 Tue, 26 Feb 2019 04:13:14 -0800 (PST)
Date: Tue, 26 Feb 2019 12:13:12 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 14/26] KVM: arm64/sve: Context switch the SVE registers
Message-ID: <20190226121312.GP3567@e103592.cambridge.arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-15-git-send-email-Dave.Martin@arm.com>
 <20190220161917.GG4763@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190220161917.GG4763@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_041317_234856_3F69B7EC 
X-CRM114-Status: GOOD (  18.17  )
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

On Wed, Feb 20, 2019 at 04:19:18PM +0000, Mark Rutland wrote:
> On Mon, Feb 18, 2019 at 07:52:27PM +0000, Dave Martin wrote:
> > -static bool __hyp_text __hyp_switch_fpsimd(struct kvm_vcpu *vcpu)
> > +/* Check for an FPSIMD/SVE trap and handle as appropriate */
> > +static bool __hyp_text __hyp_handle_fpsimd(struct kvm_vcpu *vcpu)
> >  {
> > -	struct user_fpsimd_state *host_fpsimd = vcpu->arch.host_fpsimd_state;
> > +	bool vhe, sve_guest, sve_host;
> > +	u8 trap_class;
> 
> Nit: elsewhere in kvm, this gets called hsr_ec. Can we use the same name
> here?

Done.

(This name is not used in hyp/switch.c yet, and I was sort of trying to
conform to the naming of kvm_vcpu_trap_get_class().  But hsr_ec is used
elsewhere, and more self-describing, so it makes sense.)

> 
> >  
> > -	if (has_vhe())
> > -		write_sysreg(read_sysreg(cpacr_el1) | CPACR_EL1_FPEN,
> > -			     cpacr_el1);
> > -	else
> > +	if (!system_supports_fpsimd())
> > +		return false;
> > +
> > +	if (system_supports_sve()) {
> > +		sve_guest = vcpu_has_sve(vcpu);
> > +		sve_host = vcpu->arch.flags & KVM_ARM64_HOST_SVE_IN_USE;
> > +		vhe = true;
> > +	} else {
> > +		sve_guest = false;
> > +		sve_host = false;
> > +		vhe = has_vhe();
> > +	}
> > +
> > +	trap_class = kvm_vcpu_trap_get_class(vcpu);
> > +	if (trap_class != ESR_ELx_EC_FP_ASIMD &&
> > +	    (!sve_guest || trap_class != ESR_ELx_EC_SVE))
> > +		return false;
> 
> This is somewhat painful to decipher, but I couldn't come up with
> something that was both succint and legible.
> 
> Maybe it's worth duplicating the SVE check, i.e.
> 
> 	if (hsr_ec != ESR_ELx_EC_FP_ASIMD &&
> 	    hsr_ec != ESR_ELx_EC_SVE)
> 		return false;
> 
> 	if (!sve_guest && hsr_ec == ESR_ELx_EC_SVE)
> 		return false;
> 
> ... ?

There were previously some static_key checks in here that I didn't want
to duplicate, which is part of the reason for trying to merge related
if-conditions together explicitly.

This is no longer relevant now that the static_key checks have been
hoisted out explicitly.  Something along the lines of your version
would definitely be clearer.  gcc also seems to merge the conditions
competently, so I'll pick up your suggestion for now.

Thanks
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
