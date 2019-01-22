Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE41C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:17:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1758B20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N+ab4C2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1758B20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2DDq3g7cjxcFYqwATfSEyq11FXME1NcFqxPTnUWHlkQ=; b=N+ab4C2T66yhnm
	98ZIO3vAXwYpOsMv80wj5fYcWML/vgeF18ls4EWVI+GEM7y/ylop1MheQvJx8mnkt+89FWeuPVz20
	MmQ5QtNZusJin8fEQBEi88sFvfCBKh+oDSPXuqF+plMKf8fdhW15F/mPMFaxPVk3yzT57DA6oRPyH
	DIJTK/1gyXf1pXUy6qKlDf0Do0XZhHJpt88fd8XTmACqJ5tHnkLf+EXpiTPT5XKLVFYO1pFjAh4G8
	kXj6Rf+T1sZ+ercYkyi9Tw0h8WIxJEKFRjy4x9YYCg1rlMXjbtE5X9z671rVsDnp20W5SInEVxVXe
	aerYxGsqe1cGyevbzbdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glxno-0001qA-Oh; Tue, 22 Jan 2019 15:17:24 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glxnk-0001pE-9i
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 15:17:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80397A78;
 Tue, 22 Jan 2019 07:17:18 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BF253F589;
 Tue, 22 Jan 2019 07:17:17 -0800 (PST)
Date: Tue, 22 Jan 2019 15:17:14 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 1/2] KVM: arm/arm64: Add save/restore support for
 firmware workaround state
Message-ID: <20190122151714.GG3578@e103592.cambridge.arm.com>
References: <20190107120537.184252-1-andre.przywara@arm.com>
 <20190107120537.184252-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190107120537.184252-2-andre.przywara@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_071720_350550_884BC80B 
X-CRM114-Status: GOOD (  22.19  )
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

On Mon, Jan 07, 2019 at 12:05:36PM +0000, Andre Przywara wrote:
> KVM implements the firmware interface for mitigating cache speculation
> vulnerabilities. Guests may use this interface to ensure mitigation is
> active.
> If we want to migrate such a guest to a host with a different support
> level for those workarounds, migration might need to fail, to ensure that
> critical guests don't loose their protection.
> 
> Introduce a way for userland to save and restore the workarounds state.
> On restoring we do checks that make sure we don't downgrade our
> mitigation level.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/include/asm/kvm_emulate.h   |  10 ++
>  arch/arm/include/uapi/asm/kvm.h      |   9 ++
>  arch/arm64/include/asm/kvm_emulate.h |  14 +++
>  arch/arm64/include/uapi/asm/kvm.h    |   9 ++
>  virt/kvm/arm/psci.c                  | 138 ++++++++++++++++++++++++++-
>  5 files changed, 178 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
> index 77121b713bef..2255c50debab 100644
> --- a/arch/arm/include/asm/kvm_emulate.h
> +++ b/arch/arm/include/asm/kvm_emulate.h
> @@ -275,6 +275,16 @@ static inline unsigned long kvm_vcpu_get_mpidr_aff(struct kvm_vcpu *vcpu)
>  	return vcpu_cp15(vcpu, c0_MPIDR) & MPIDR_HWID_BITMASK;
>  }
>  
> +static inline bool kvm_arm_get_vcpu_workaround_2_flag(struct kvm_vcpu *vcpu)
> +{
> +	return false;
> +}
> +
> +static inline void kvm_arm_set_vcpu_workaround_2_flag(struct kvm_vcpu *vcpu,
> +						      bool flag)
> +{
> +}
> +
>  static inline void kvm_vcpu_set_be(struct kvm_vcpu *vcpu)
>  {
>  	*vcpu_cpsr(vcpu) |= PSR_E_BIT;
> diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
> index 4602464ebdfb..02c93b1d8f6d 100644
> --- a/arch/arm/include/uapi/asm/kvm.h
> +++ b/arch/arm/include/uapi/asm/kvm.h
> @@ -214,6 +214,15 @@ struct kvm_vcpu_events {
>  #define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM | KVM_REG_SIZE_U64 | \
>  					 KVM_REG_ARM_FW | ((r) & 0xffff))
>  #define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
> +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1	KVM_REG_ARM_FW_REG(1)
> +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL	0
> +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL	1
> +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2	KVM_REG_ARM_FW_REG(2)
> +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_MASK	0x3
> +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL	0
> +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL	1
> +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNAFFECTED	2
> +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED	4
>  
>  /* Device Control API: ARM VGIC */
>  #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index 506386a3edde..a44f07f68da4 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -336,6 +336,20 @@ static inline unsigned long kvm_vcpu_get_mpidr_aff(struct kvm_vcpu *vcpu)
>  	return vcpu_read_sys_reg(vcpu, MPIDR_EL1) & MPIDR_HWID_BITMASK;
>  }
>  
> +static inline bool kvm_arm_get_vcpu_workaround_2_flag(struct kvm_vcpu *vcpu)
> +{
> +	return vcpu->arch.workaround_flags & VCPU_WORKAROUND_2_FLAG;
> +}
> +
> +static inline void kvm_arm_set_vcpu_workaround_2_flag(struct kvm_vcpu *vcpu,
> +						      bool flag)
> +{
> +	if (flag)
> +		vcpu->arch.workaround_flags |= VCPU_WORKAROUND_2_FLAG;
> +	else
> +		vcpu->arch.workaround_flags &= ~VCPU_WORKAROUND_2_FLAG;
> +}
> +
>  static inline void kvm_vcpu_set_be(struct kvm_vcpu *vcpu)
>  {
>  	if (vcpu_mode_is_32bit(vcpu)) {
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index 97c3478ee6e7..4a19ef199a99 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -225,6 +225,15 @@ struct kvm_vcpu_events {
>  #define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
>  					 KVM_REG_ARM_FW | ((r) & 0xffff))
>  #define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
> +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1	KVM_REG_ARM_FW_REG(1)
> +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL	0
> +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL	1
> +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2	KVM_REG_ARM_FW_REG(2)
> +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_MASK	0x3
> +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL	0
> +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL	1
> +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNAFFECTED	2
> +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED	4

If this is the first exposure of this information to userspace, I wonder
if we can come up with some common semantics that avoid having to add
new ad-hoc code (and bugs) every time a new vulnerability/workaround is
defined.

We seem to have at least the two following independent properties
for a vulnerability, with the listed values for each:

 * vulnerability (Vulnerable, Unknown, Not Vulnerable)

 * mitigation support (Not Requestable, Requestable)

Migrations must not move to the left in _either_ list for any
vulnerability.

If we want to hedge out bets we could follow the style of the ID
registers and allocate to each theoretical vulnerability a pair of
signed 2- or (for more expansion room if we think we might need it)
4-bit fields.

We could perhaps allocate as follows:

 * -1=Vulnerable, 0=Unknown, 1=Not Vulnerable
 *  0=Mitigation not requestable, 1=Mitigation requestable


Checking code wouldn't need to know which fields describe mitigation
mechanisms and which describe vulnerabilities: we'd just do a strict >=
comparison on each.

Further, if a register is never written before the vcpu is first run,
we should imply a write of 0 to it as part of KVM_RUN (so that if the
destination node has a negative value anywhere, KVM_RUN barfs cleanly.


(Those semantics should apply equally to the CPU ID registers, though
we don't currently do that.)

Thoughts?

[...]

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
