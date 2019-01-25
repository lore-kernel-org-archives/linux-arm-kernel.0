Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE32C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:47:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC7CB218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l5xu20L9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC7CB218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WgXA78auOrbu7LpDBB1zaR8R4zgee5Pb1RTPsBdQ3gs=; b=l5xu20L96Of9yn
	XEqwtWAOMEgE8Oo/+R2fiTeerjFoLQX/S4IJRcdai2jSUZ/Gw/8t8BP0T9lAmKIINLGxOrYVdZdXr
	2ySeDCyKf/x5V53/Gw9f5P1eOUooc71BEGXj8oMj12ctbKf8sEuT5nGm9H0c6sMSyDkHVCFOOKm59
	8f8vmtd3b2ZJYnYEuwFZjG1dZN8lU80D0/F0ztI+if5EvmffuHfAX9tvFuM/wspPByjjqfrtx0BdH
	fyxJnUk7G6LReXX3IxmouxxnmKLCFrDhNaOaw0jfnbn3ZWVJxStxm3J4e8qBAfkv6yVexKyJELdEp
	EHcqqgTtUWbzkeeV8NhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn2lA-00052J-9i; Fri, 25 Jan 2019 14:47:08 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn2l6-00051i-HY
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 14:47:06 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19053A78;
 Fri, 25 Jan 2019 06:47:02 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8D4A3F5C1;
 Fri, 25 Jan 2019 06:47:00 -0800 (PST)
Date: Fri, 25 Jan 2019 14:46:57 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 1/2] KVM: arm/arm64: Add save/restore support for
 firmware workaround state
Message-ID: <20190125144657.3db91c91@donnerap.cambridge.arm.com>
In-Reply-To: <20190122151714.GG3578@e103592.cambridge.arm.com>
References: <20190107120537.184252-1-andre.przywara@arm.com>
 <20190107120537.184252-2-andre.przywara@arm.com>
 <20190122151714.GG3578@e103592.cambridge.arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_064704_589990_15B630F2 
X-CRM114-Status: GOOD (  34.43  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, kvm@vger.kernel.org,
 Christoffer Dall <christoffer.dall@arm.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 22 Jan 2019 15:17:14 +0000
Dave Martin <Dave.Martin@arm.com> wrote:

Hi Dave,

thanks for having a look!

> On Mon, Jan 07, 2019 at 12:05:36PM +0000, Andre Przywara wrote:
> > KVM implements the firmware interface for mitigating cache
> > speculation vulnerabilities. Guests may use this interface to
> > ensure mitigation is active.
> > If we want to migrate such a guest to a host with a different
> > support level for those workarounds, migration might need to fail,
> > to ensure that critical guests don't loose their protection.
> > 
> > Introduce a way for userland to save and restore the workarounds
> > state. On restoring we do checks that make sure we don't downgrade
> > our mitigation level.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  arch/arm/include/asm/kvm_emulate.h   |  10 ++
> >  arch/arm/include/uapi/asm/kvm.h      |   9 ++
> >  arch/arm64/include/asm/kvm_emulate.h |  14 +++
> >  arch/arm64/include/uapi/asm/kvm.h    |   9 ++
> >  virt/kvm/arm/psci.c                  | 138
> > ++++++++++++++++++++++++++- 5 files changed, 178 insertions(+), 2
> > deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/kvm_emulate.h
> > b/arch/arm/include/asm/kvm_emulate.h index
> > 77121b713bef..2255c50debab 100644 ---
> > a/arch/arm/include/asm/kvm_emulate.h +++
> > b/arch/arm/include/asm/kvm_emulate.h @@ -275,6 +275,16 @@ static
> > inline unsigned long kvm_vcpu_get_mpidr_aff(struct kvm_vcpu *vcpu)
> > return vcpu_cp15(vcpu, c0_MPIDR) & MPIDR_HWID_BITMASK; }
> >  
> > +static inline bool kvm_arm_get_vcpu_workaround_2_flag(struct
> > kvm_vcpu *vcpu) +{
> > +	return false;
> > +}
> > +
> > +static inline void kvm_arm_set_vcpu_workaround_2_flag(struct
> > kvm_vcpu *vcpu,
> > +						      bool flag)
> > +{
> > +}
> > +
> >  static inline void kvm_vcpu_set_be(struct kvm_vcpu *vcpu)
> >  {
> >  	*vcpu_cpsr(vcpu) |= PSR_E_BIT;
> > diff --git a/arch/arm/include/uapi/asm/kvm.h
> > b/arch/arm/include/uapi/asm/kvm.h index 4602464ebdfb..02c93b1d8f6d
> > 100644 --- a/arch/arm/include/uapi/asm/kvm.h
> > +++ b/arch/arm/include/uapi/asm/kvm.h
> > @@ -214,6 +214,15 @@ struct kvm_vcpu_events {
> >  #define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM |
> > KVM_REG_SIZE_U64 | \ KVM_REG_ARM_FW | ((r) & 0xffff))
> >  #define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1
> > KVM_REG_ARM_FW_REG(1) +#define
> > KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL	0 +#define
> > KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL	1 +#define
> > KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2	KVM_REG_ARM_FW_REG(2)
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_MASK	0x3
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL	0
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL	1
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNAFFECTED	2
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED	4 
> >  /* Device Control API: ARM VGIC */
> >  #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
> > diff --git a/arch/arm64/include/asm/kvm_emulate.h
> > b/arch/arm64/include/asm/kvm_emulate.h index
> > 506386a3edde..a44f07f68da4 100644 ---
> > a/arch/arm64/include/asm/kvm_emulate.h +++
> > b/arch/arm64/include/asm/kvm_emulate.h @@ -336,6 +336,20 @@ static
> > inline unsigned long kvm_vcpu_get_mpidr_aff(struct kvm_vcpu *vcpu)
> > return vcpu_read_sys_reg(vcpu, MPIDR_EL1) & MPIDR_HWID_BITMASK; }
> >  
> > +static inline bool kvm_arm_get_vcpu_workaround_2_flag(struct
> > kvm_vcpu *vcpu) +{
> > +	return vcpu->arch.workaround_flags &
> > VCPU_WORKAROUND_2_FLAG; +}
> > +
> > +static inline void kvm_arm_set_vcpu_workaround_2_flag(struct
> > kvm_vcpu *vcpu,
> > +						      bool flag)
> > +{
> > +	if (flag)
> > +		vcpu->arch.workaround_flags |=
> > VCPU_WORKAROUND_2_FLAG;
> > +	else
> > +		vcpu->arch.workaround_flags &=
> > ~VCPU_WORKAROUND_2_FLAG; +}
> > +
> >  static inline void kvm_vcpu_set_be(struct kvm_vcpu *vcpu)
> >  {
> >  	if (vcpu_mode_is_32bit(vcpu)) {
> > diff --git a/arch/arm64/include/uapi/asm/kvm.h
> > b/arch/arm64/include/uapi/asm/kvm.h index
> > 97c3478ee6e7..4a19ef199a99 100644 ---
> > a/arch/arm64/include/uapi/asm/kvm.h +++
> > b/arch/arm64/include/uapi/asm/kvm.h @@ -225,6 +225,15 @@ struct
> > kvm_vcpu_events { #define KVM_REG_ARM_FW_REG(r)
> > (KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \ KVM_REG_ARM_FW | ((r) &
> > 0xffff)) #define KVM_REG_ARM_PSCI_VERSION
> > KVM_REG_ARM_FW_REG(0) +#define
> > KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1	KVM_REG_ARM_FW_REG(1)
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL	0
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL	1
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2
> > KVM_REG_ARM_FW_REG(2) +#define
> > KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_MASK	0x3 +#define
> > KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL	0 +#define
> > KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL	1 +#define
> > KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNAFFECTED	2 +#define
> > KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED	4  
> 
> If this is the first exposure of this information to userspace, I
> wonder if we can come up with some common semantics that avoid having
> to add new ad-hoc code (and bugs) every time a new
> vulnerability/workaround is defined.
> 
> We seem to have at least the two following independent properties
> for a vulnerability, with the listed values for each:
> 
>  * vulnerability (Vulnerable, Unknown, Not Vulnerable)
> 
>  * mitigation support (Not Requestable, Requestable)
> 
> Migrations must not move to the left in _either_ list for any
> vulnerability.
> 
> If we want to hedge out bets we could follow the style of the ID
> registers and allocate to each theoretical vulnerability a pair of
> signed 2- or (for more expansion room if we think we might need it)
> 4-bit fields.
> 
> We could perhaps allocate as follows:
> 
>  * -1=Vulnerable, 0=Unknown, 1=Not Vulnerable
>  *  0=Mitigation not requestable, 1=Mitigation requestable

So as discussed in person, that sounds quite neat. I implemented
that, but the sign extension and masking to n bits is not very pretty
and limits readability.
However the property of having a kind of "vulnerability scale", where a
simple comparison would determine compatibility, is a good thing to
have and drastically simplifies the checking code.

> Checking code wouldn't need to know which fields describe mitigation
> mechanisms and which describe vulnerabilities: we'd just do a strict
> >= comparison on each.
> 
> Further, if a register is never written before the vcpu is first run,
> we should imply a write of 0 to it as part of KVM_RUN (so that if the
> destination node has a negative value anywhere, KVM_RUN barfs cleanly.

What I like about the signedness is this "0 means unknown", which is
magically forwards compatible. However I am not sure we can transfer
this semantic into every upcoming register that pops up in the future.
Actually we might not need this:
My understanding of how QEMU handles this in migration is that it reads
the f/w reg on the originating host A and writes this into the target
host B, without itself interpreting this in any way. It's up to the
target kernel (basically this code here) to check compatibility. So I am
not sure we actually need a stable scheme. If host A doesn't know about
a certain register, it won't appear in the result of the
KVM_GET_REG_LIST ioctl, so it won't be transferred to host B at all. In
the opposite case the receiving host would reject an unknown register,
which I believe is safer, although I see that it leaves the "unknown"
case on the table.

It would be good to have some opinion of how forward looking we want to
(and can) be here.

Meanwhile I am sending a v2 which implements the linear scale idea,
without using signed values, as this indeed simplifies the code.
I have the signed version still in a branch here, let me know if you
want to have a look.

Cheers,
Andre.

> (Those semantics should apply equally to the CPU ID registers, though
> we don't currently do that.)
> 
> Thoughts?
> 
> [...]
> 
> Cheers
> ---Dave


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
