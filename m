Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F01C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:30:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 036692075A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sk3O0OgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036692075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pjm1uzMaURJVIUtZIOPKtQG2OYYgjWPOzT1bz5ww97Q=; b=sk3O0OgIMkcOzX
	Rul+irIUgjftgv1Dl7ylIhtc/G76p/Z3h7HObkfuA3+03HtXzrrl5QDLbMLXRwdkUD19CWYKQhK9z
	0/aMyAUoYXwMGF6MGQhbl7wfz5M1acY5VB+VytbCPKimBasVHtS7bWazXU1DEfZlC0hyp6qNsahKx
	tQM3rXlaSo28SDHRLB3Q9ubGvi1Nr7Tg8NnRPojaMrGo9mA7UBKgT8x6hRezSzbhQpiovfLQteIoK
	J5DVSh6K/pnG4GYCzCy+oxDKry5JgYft9CWUlswvTg2wKV9lFIDbSNGfadVnPM3BNi/Uhq1wlnrRX
	izIviv0zll9oAY5NgFcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx9yX-0006GF-9c; Fri, 22 Feb 2019 12:30:45 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx9uS-0008Lm-OJ
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:26:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A580615AB;
 Fri, 22 Feb 2019 04:26:32 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DF1F3F690;
 Fri, 22 Feb 2019 04:26:31 -0800 (PST)
Date: Fri, 22 Feb 2019 12:26:24 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH 1/2] KVM: arm/arm64: Add save/restore support for
 firmware workaround state
Message-ID: <20190222122624.507d7a9f@donnerap.cambridge.arm.com>
In-Reply-To: <2b794331-cebe-92f1-7adc-58b041bbe1d6@arm.com>
References: <20190107120537.184252-1-andre.przywara@arm.com>
 <20190107120537.184252-2-andre.przywara@arm.com>
 <2b794331-cebe-92f1-7adc-58b041bbe1d6@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_042633_444542_0D2B5CFD 
X-CRM114-Status: GOOD (  31.37  )
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 7 Jan 2019 13:17:37 +0000
Steven Price <steven.price@arm.com> wrote:

Hi,

> On 07/01/2019 12:05, Andre Przywara wrote:
> > KVM implements the firmware interface for mitigating cache speculation
> > vulnerabilities. Guests may use this interface to ensure mitigation is
> > active.
> > If we want to migrate such a guest to a host with a different support
> > level for those workarounds, migration might need to fail, to ensure that
> > critical guests don't loose their protection.
> > 
> > Introduce a way for userland to save and restore the workarounds state.
> > On restoring we do checks that make sure we don't downgrade our
> > mitigation level.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  arch/arm/include/asm/kvm_emulate.h   |  10 ++
> >  arch/arm/include/uapi/asm/kvm.h      |   9 ++
> >  arch/arm64/include/asm/kvm_emulate.h |  14 +++
> >  arch/arm64/include/uapi/asm/kvm.h    |   9 ++
> >  virt/kvm/arm/psci.c                  | 138 ++++++++++++++++++++++++++-
> >  5 files changed, 178 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
> > index 77121b713bef..2255c50debab 100644
> > --- a/arch/arm/include/asm/kvm_emulate.h
> > +++ b/arch/arm/include/asm/kvm_emulate.h
> > @@ -275,6 +275,16 @@ static inline unsigned long kvm_vcpu_get_mpidr_aff(struct kvm_vcpu *vcpu)
> >  	return vcpu_cp15(vcpu, c0_MPIDR) & MPIDR_HWID_BITMASK;
> >  }
> >  
> > +static inline bool kvm_arm_get_vcpu_workaround_2_flag(struct kvm_vcpu *vcpu)
> > +{
> > +	return false;
> > +}
> > +
> > +static inline void kvm_arm_set_vcpu_workaround_2_flag(struct kvm_vcpu *vcpu,
> > +						      bool flag)
> > +{
> > +}
> > +
> >  static inline void kvm_vcpu_set_be(struct kvm_vcpu *vcpu)
> >  {
> >  	*vcpu_cpsr(vcpu) |= PSR_E_BIT;
> > diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
> > index 4602464ebdfb..02c93b1d8f6d 100644
> > --- a/arch/arm/include/uapi/asm/kvm.h
> > +++ b/arch/arm/include/uapi/asm/kvm.h
> > @@ -214,6 +214,15 @@ struct kvm_vcpu_events {
> >  #define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM | KVM_REG_SIZE_U64 | \
> >  					 KVM_REG_ARM_FW | ((r) & 0xffff))
> >  #define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1	KVM_REG_ARM_FW_REG(1)
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL	0
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL	1
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2	KVM_REG_ARM_FW_REG(2)
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_MASK	0x3
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL	0
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL	1
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNAFFECTED	2
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED	4
> >  
> >  /* Device Control API: ARM VGIC */
> >  #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
> > diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> > index 506386a3edde..a44f07f68da4 100644
> > --- a/arch/arm64/include/asm/kvm_emulate.h
> > +++ b/arch/arm64/include/asm/kvm_emulate.h
> > @@ -336,6 +336,20 @@ static inline unsigned long kvm_vcpu_get_mpidr_aff(struct kvm_vcpu *vcpu)
> >  	return vcpu_read_sys_reg(vcpu, MPIDR_EL1) & MPIDR_HWID_BITMASK;
> >  }
> >  
> > +static inline bool kvm_arm_get_vcpu_workaround_2_flag(struct kvm_vcpu *vcpu)
> > +{
> > +	return vcpu->arch.workaround_flags & VCPU_WORKAROUND_2_FLAG;
> > +}
> > +
> > +static inline void kvm_arm_set_vcpu_workaround_2_flag(struct kvm_vcpu *vcpu,
> > +						      bool flag)
> > +{
> > +	if (flag)
> > +		vcpu->arch.workaround_flags |= VCPU_WORKAROUND_2_FLAG;
> > +	else
> > +		vcpu->arch.workaround_flags &= ~VCPU_WORKAROUND_2_FLAG;
> > +}
> > +
> >  static inline void kvm_vcpu_set_be(struct kvm_vcpu *vcpu)
> >  {
> >  	if (vcpu_mode_is_32bit(vcpu)) {
> > diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> > index 97c3478ee6e7..4a19ef199a99 100644
> > --- a/arch/arm64/include/uapi/asm/kvm.h
> > +++ b/arch/arm64/include/uapi/asm/kvm.h
> > @@ -225,6 +225,15 @@ struct kvm_vcpu_events {
> >  #define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
> >  					 KVM_REG_ARM_FW | ((r) & 0xffff))
> >  #define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1	KVM_REG_ARM_FW_REG(1)
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL	0
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL	1  
> 
> I can't help feeling we need more than one bit to deal with all the
> possible states. The host can support/not-support the workaround (i.e
> the HVC) and the guest can be using/not using the workaround.
> 
> In particular I can imagine the following situation:
> 
> * Guest starts on a host (host A) without the workaround HVC (so
> configures not to use it). Assuming the host doesn't need the workaround
> the guest is therefore not vulnerable.
> 
> * Migrated to a new host (host B) with the workaround HVC (this is
> accepted), the guest is potentially vulnerable.
> 
> * Migration back to the original host (host A) is then rejected, even
> though the guest isn't using the HVC.
> 
> I can see two options here:
> 
> * Reject the migration to host B as the guest may be vulnerable after
> the migration. I.e. the workaround availability cannot change (either
> way) during a migration
> 
> * Store an extra bit of information which is whether a particular guest
> has the HVC exposed to it. Ideally the HVC handling for the workaround
> would also get disabled when running on a host which supports the HVC
> but was migrated from a host which doesn't. This prevents problems with
> a guest which is e.g. migrated during boot and may do feature detection
> after the migration.
> 
> Since this is a new ABI it would be good to get the register values
> sorted even if we don't have a complete implementation of it.

So I thought about this a bit more and now implemented something like a combination of your two options above:
- There is a new UNAFFECTED state, which is currently unused. As mentioned before, the current NOT_AVAIL does not mean not needed, but actually translates as "unknown". At the moment this is our best guess on this matter. There are patches on the list which extend the host workaround code, so we can then actually differentiate between "unknown" and "always mitigated". Once they have landed, we can then communicate this new state to userland.
- For now we are very strict and allow only migration if the workaround levels are identical. Since the guest may have detected either one state during its boot, we don't have much
of a choice here. When we later gain the UNAFFECTED state, we can additionally allow migration from "NOT_AVAIL" to "UNAFFECTED".

I hope this covers your concerns.

Cheers,
Andre.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
