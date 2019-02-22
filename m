Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92852C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:36:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64CE52077B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bHkWcsrB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CE52077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K54wy/MDuX7R17OWqjeQeQYRTys+ABcJxIstk2F9Sy0=; b=bHkWcsrBskIsmx
	CzN4zrcywwgRm9nS7+0Yz6i3poc5uZLaDHdsBVSDhWCWTvs9vBAii6T3XJhBseAFXJgALpX8aErr4
	XK1igBVBxBKV65gxspJaWgOGDfd/7EILvemIcNRRadqV6qKl57kb1tTMKQdM987NoaLmq43VkpdVM
	5SLj4zjlaYJ3ilGd/3SKaQw44OSpc6l/shxCVUJRRLQV+u/KgYrs5wsgK2OLQpjlEE2juBRh/pNf/
	Ma3iQvQOBhUGODj7N/Fj/ygvopSq6jmBsiL0nI+AmavfW/Hoc2PE+/ntyQp2al1/jrpzfughhN55i
	mPxRXpNPNwHPct6oBJ9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxEk6-0004w9-HU; Fri, 22 Feb 2019 17:36:10 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxEk2-0004vb-Up
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 17:36:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8B2D80D;
 Fri, 22 Feb 2019 09:36:06 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5005C3F5C1;
 Fri, 22 Feb 2019 09:36:05 -0800 (PST)
Date: Fri, 22 Feb 2019 17:36:02 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v3 1/2] KVM: arm/arm64: Add save/restore support for
 firmware workaround state
Message-ID: <20190222173602.05f34343@donnerap.cambridge.arm.com>
In-Reply-To: <c3dba11e-7f17-d49a-4eac-f3309f836d66@arm.com>
References: <20190222121818.30164-1-andre.przywara@arm.com>
 <20190222121818.30164-2-andre.przywara@arm.com>
 <c3dba11e-7f17-d49a-4eac-f3309f836d66@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_093607_008963_AEB42992 
X-CRM114-Status: GOOD (  20.82  )
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
Cc: kvm@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 22 Feb 2019 17:16:12 +0000
Steven Price <steven.price@arm.com> wrote:

> On 22/02/2019 12:18, Andre Przywara wrote:
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
> >  arch/arm/include/asm/kvm_emulate.h   |  10 +++
> >  arch/arm/include/uapi/asm/kvm.h      |  10 +++
> >  arch/arm64/include/asm/kvm_emulate.h |  14 ++++
> >  arch/arm64/include/uapi/asm/kvm.h    |   9 ++
> >  virt/kvm/arm/psci.c                  | 119 +++++++++++++++++++++++----
> >  5 files changed, 146 insertions(+), 16 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
> > index 8927cae7c966..663a02d7e6f4 100644
> > --- a/arch/arm/include/asm/kvm_emulate.h
> > +++ b/arch/arm/include/asm/kvm_emulate.h
> > @@ -283,6 +283,16 @@ static inline unsigned long kvm_vcpu_get_mpidr_aff(struct kvm_vcpu *vcpu)
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
> > index 4602464ebdfb..ba4d2afe65e3 100644
> > --- a/arch/arm/include/uapi/asm/kvm.h
> > +++ b/arch/arm/include/uapi/asm/kvm.h
> > @@ -214,6 +214,16 @@ struct kvm_vcpu_events {
> >  #define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM | KVM_REG_SIZE_U64 | \
> >  					 KVM_REG_ARM_FW | ((r) & 0xffff))
> >  #define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1	KVM_REG_ARM_FW_REG(1)
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL	0
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL	1
> > +#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_UNAFFECTED	2  
> 
> Thanks for adding the UNAFFECTED state for WORKAROUND_1 - this means the
> ABI at least can deal with migration to a host which supports but
> doesn't need the workaround. I'm happy for the actual support for this
> to be added later if/when it's needed.

Thanks. Actually we *can't* do anything right now, because the host kernel only provides this "requires w/a or not" state, so for the current kernel we will never see UNAFFECTED. If QEMU wants to set UNAFFECTED because the source kernel had it, we naturally deny it, as future code would do as well. So I think this solution is forward compatible.
 
> Reviewed-by: Steven Price <steven.price@arm.com>

Thanks for that!
Andre.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
