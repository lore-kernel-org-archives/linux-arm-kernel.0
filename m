Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE8EC10F0B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:14:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B0752173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iJNwCMLA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0752173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zvRgiXhEETM9wySbV+M28GXFtBEV1cfZ4CJuODqBWmw=; b=iJNwCMLA+V6iGZ
	naGgz5/nNI1NTMoI1QNNl31X5EnJTOw7GsbutF5uVjbWdrn0XSIPxokaA8XGtF84p/8arrMdo9hQ8
	aTImdNLrAk5BvfsXJF+69qjoDP6CYriHX/ffVSOGSBSGXQ1U7g4p1E38O5VddiqgSgx0ImSmKCXWD
	fmJJkHR05s7r8XmUbd4fnb8CD7UG3pvIWmbTsAB1QXRKMhSiHQnmug/5yKE0IpYlGvd2ay/aqvvvn
	/yzw9OXbZdqBUfoMe7GkmbCt/n5kSafZJTjV6CvcgmUvCQicMxwS3sMbnoDchMq/OoCciBZQQQxxE
	3uaMHjrU9ZVjZzgeLjaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybcy-0008HY-OL; Tue, 26 Feb 2019 12:14:28 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybcO-0007oI-A2
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:14:04 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EA24A78;
 Tue, 26 Feb 2019 04:13:52 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51E143F5C1;
 Tue, 26 Feb 2019 04:13:50 -0800 (PST)
Date: Tue, 26 Feb 2019 12:13:47 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v5 22/26] KVM: arm64/sve: Add pseudo-register for the
 guest's vector lengths
Message-ID: <20190226121347.GT3567@e103592.cambridge.arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-23-git-send-email-Dave.Martin@arm.com>
 <34b7691f-7acb-c9aa-6e53-2857e429f148@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <34b7691f-7acb-c9aa-6e53-2857e429f148@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_041352_731444_499ECE4C 
X-CRM114-Status: GOOD (  37.96  )
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

On Thu, Feb 21, 2019 at 05:48:59PM +0000, Julien Thierry wrote:
> Hi Dave,
> 
> On 18/02/2019 19:52, Dave Martin wrote:
> > This patch adds a new pseudo-register KVM_REG_ARM64_SVE_VLS to
> > allow userspace to set and query the set of vector lengths visible
> > to the guest, along with corresponding storage in struct
> > kvm_vcpu_arch.
> > 
> > In the future, multiple register slices per SVE register may be
> > visible through the ioctl interface.  Once the set of slices has
> > been determined we would not be able to allow the vector length set
> > to be changed any more, in order to avoid userspace seeing
> > inconsistent sets of registers.  For this reason, this patch adds
> > support to track vcpu finalization explicitly, and enforce proper
> > sequencing of ioctls.
> > 
> > The new pseudo-register is not exposed yet.  Subsequent patches
> > will allow SVE to be turned on for guest vcpus, making it visible.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > 
> > ---
> > 
> > Changes since v4:
> > 
> >  * Add a UAPI header comment indicating the pseudo-register status of
> >    KVM_REG_ARM64_SVE_VLS.
> > 
> >  * Get rid of the sve_vqs[] array from struct kvm_vcpu_arch.  This
> >    array is pointless, because its contents must match the host's
> >    internal sve_vq_map anyway, up to vcpu->arch.sve_max_vl.
> > 
> >    The ioctl register accessors are slow-path code, so we can decode
> >    or reconstruct sve_vqs[] on demand instead, for exchange with
> >    userspace.
> > 
> >  * For compatibility with potential future architecture extensions,
> >    enabling vector lengths above 256 bytes for the guest is explicitly
> >    disallowed now (because the code for exposing additional bits
> >    through ioctl is currently missing).  This can be addressed later
> >    if/when needed.
> > 
> > Note:
> > 
> >  * I defensively pass an array by pointer here, to help avoid
> >    accidentally breaking assumptions during future maintenance.
> > 
> >    Due to (over?)zealous constification, this causes the following
> >    sparse warning.  I think this is sparse getting confused: I am not
> >    relying on any kernel-specific semantics here, and GCC generates no
> >    warning.
> > 
> > +arch/arm64/kvm/guest.c:33: warning: incorrect type in argument 1 (different modifiers)
> > +arch/arm64/kvm/guest.c:33:    expected unsigned long long const [usertype] ( *const vqs )[8]
> > +arch/arm64/kvm/guest.c:33:    got unsigned long long [usertype] ( * )[8]
> > 
> > ---

[...]

> > diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h

[...]

> > +static int get_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> > +{
> > +	unsigned int max_vq, vq;
> > +	u64 vqs[DIV_ROUND_UP(SVE_VQ_MAX - SVE_VQ_MIN + 1, 64)];
> > +
> > +	if (WARN_ON(!sve_vl_valid(vcpu->arch.sve_max_vl)))
> > +		return -EINVAL;
> > +
> > +	memset(vqs, 0, sizeof(vqs));
> > +
> > +	max_vq = sve_vq_from_vl(vcpu->arch.sve_max_vl);
> > +	for (vq = SVE_VQ_MIN; vq <= max_vq; ++vq)
> > +		if (sve_vq_available(vq))
> > +			vqs[vq_word(vq)] |= vq_mask(vq);
> > +
> > +	BUILD_BUG_ON(sizeof(vqs) != KVM_REG_SIZE(reg->id));
> 
> reg->id is not know at build time. From my understanding of
> BUILD_BUG_ON(), things actually ends up evaluated at runtime but I'm not
> sure what happens when doing sizeof(char[1- 2*0]) at runtime.
>
> Anyway, I don't think this is intended.

There's no runtime check: BUILD_BUG_ON() will cause compilation to fail
if the required condition doesn't fall out from optimisation.

Because of the way this function is called, reg->id is always
KVM_REG_ARM64_SVE_VLS, so inlining and constant propagation will make
this check pass (and compile to nothing).

We can assume a certain amount of inlining: the kernel officially can't
be built without optimisation.  But the precise build configuration can
sometimes have an effect here -- so it may not be better to rely on this
working for this slow-path code.

I'll convert these to if (WARN_ON()) return -EIO or something, or drop
them if I can get rid of them in other refactoring.

The fact that struct kvm_one_reg lacks any "size" field is rather
unfortunate, since it provides no explicit way for userspace to tell us
the size of its buffer.

> > +	if (copy_to_user((void __user *)reg->addr, vqs, sizeof(vqs)))
> > +		return -EFAULT;
> > +
> > +	return 0;
> > +}
> > +
> > +static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> > +{
> > +	unsigned int max_vq, vq;
> > +	u64 vqs[DIV_ROUND_UP(SVE_VQ_MAX - SVE_VQ_MIN + 1, 64)];
> > +
> > +	if (kvm_arm_vcpu_finalized(vcpu))
> > +		return -EPERM; /* too late! */
> > +
> > +	if (WARN_ON(vcpu->arch.sve_state))
> > +		return -EINVAL;
> > +
> > +	BUILD_BUG_ON(sizeof(vqs) != KVM_REG_SIZE(reg->id));
> 
> Same as above.
> 
> > +	if (copy_from_user(vqs, (const void __user *)reg->addr, sizeof(vqs)))
> > +		return -EFAULT;
> > +
> > +	max_vq = 0;
> > +	for (vq = SVE_VQ_MIN; vq <= SVE_VQ_MAX; ++vq)
> > +		if (vq_present(&vqs, vq))
> > +			max_vq = vq;
> > +
> > +	/*
> > +	 * The get_sve_reg()/set_sve_reg() ioctl interface will need
> > +	 * to be extended with multiple register slice support in
> > +	 * order to support vector lengths greater than
> > +	 * SVE_VL_ARCH_MAX:
> > +	 */
> > +	if (WARN_ONCE(sve_vl_from_vq(max_vq) > SVE_VL_ARCH_MAX,
> > +		      "KVM: Requested vector length not supported yet\n"))
> > +		return -EINVAL;
> > +
> > +	for (vq = SVE_VQ_MIN; vq <= max_vq; ++vq)
> > +		if (vq_present(&vqs, vq) != sve_vq_available(vq))
> > +			return -EINVAL;
> > +
> > +	/* Can't run with no vector lengths at all: */
> > +	if (max_vq < SVE_VQ_MIN)
> > +		return -EINVAL;
> > +
> > +	vcpu->arch.sve_max_vl = sve_vl_from_vq(max_vq);
> > +
> > +	return 0;
> > +}
> > +
> >  #define SVE_REG_SLICE_SHIFT	0
> >  #define SVE_REG_SLICE_BITS	5
> >  #define SVE_REG_ID_SHIFT	(SVE_REG_SLICE_SHIFT + SVE_REG_SLICE_BITS)
> > @@ -297,9 +372,21 @@ static int sve_reg_region(struct sve_state_region *region,
> >  static int get_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> >  {
> >  	struct sve_state_region region;
> > +	int ret;
> >  	char __user *uptr = (char __user *)reg->addr;
> >  
> > -	if (!vcpu_has_sve(vcpu) || sve_reg_region(&region, vcpu, reg))
> > +	if (!vcpu_has_sve(vcpu))
> > +		return -ENOENT;
> > +
> > +	if (reg->id == KVM_REG_ARM64_SVE_VLS)
> > +		return get_sve_vls(vcpu, reg);
> > +
> > +	/* Finalize the number of slices per SVE register: */
> > +	ret = kvm_arm_vcpu_finalize(vcpu);
> 
> Having this here feels a bit random...

I'll have another think about this.

KVM_REG_ARM64_SVE_VLS certainly has nothing to do with anything except
SVE, and putting it in the SVE coproc space allows us to demux SVE-
related stuff from everything else neatly.

The whole "coprocessor" concept is nonsense for arm64 anyway except
for the sysregs (where the reg ID encodings map directly onto the
architecture and also align with AArch32).  So, the copro number is
pretty meaningless except as a demux key for related groups of
registers, which is how I use it here.

There's also no well-defined distinction between real and fake
registers, and no natural home for miscellaneous fakes -- all existing
blocks are for specific purposes such as recording the state of emulated
firmware APIs etc.  The SVE registers as exposed here already have no
direct equivalent in the architecture either, due to the padding up to
2048 bits, and the presentation of FFR as addressable P-register etc.

> I'd suggest considering the pseudo-register outside of the SVE co-proc,
> as part of a set of registers that do not finalize a vcpu when accessed.

(Also, the dependency is not one-way:  _SVE_VLS is not independent
of finalization: quite the reverse -- it can only be written _before_
finalization.)

> All other registers (even non-sve ones) would finalize the vcpu when
> accessed from userland.

So, we could consider register to be in two classes as you suggest:

 * early registers
 * regular registers (i.e., everything else)

where early registers can only be written until the first access to a
regular register, or the first KVM_GET_REG_LIST or KVM_RUN.

This is a stricter rule than I have today: i.e., _SVE_VLS would really
need to be written before touching anything else.  But that may be a
good thing for avoiding future ABI drift.

This may be premature factoring though.  It's not clear whether many new
registers like KVM_REG_ARM64_SVE_VLS will exist, or that they would have
compatible sequencing requirements.

Thoughts?


Independently of this, I'll have a look at whether there's
a straightforward way to simplify the code flow.

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
