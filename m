Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E23C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:15:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5ED22087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Oh7Z03/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5ED22087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6zjvWD+pc8+ab4Vy3c39pbeMStkICORmYKnSOg5iRP8=; b=Oh7Z03/Ivx0wtv
	+NEwrmsVdO7IIX9bCwE1V0ILdE3echj1Md00iFXCfS1QkZNrP9yohCNIPY+VxhNRMQifiPFL7TAMT
	4S0gnKHu9Y8ndsV6ehymRpmisRPSlZfl36+6xnT+vdEc11Eym5PA1RyRbralblJ/mRXsCSYsK1pth
	CreVNi7+JRF7YgjyTuv8zQ6LlP2a/WpugJs8QKcnWjHtKSu61vTad+RvQ6u/J/zlKGr8cGooovW/Q
	T4GJHrljD1Kp8h2rp1+e4G+e3iGvVD2eFOrVXPN4zNAHe5ueI3Vvd1Uk7M7NEbooIcIx7aYiD1wR2
	Eku2oTX6L2asPAxIK18w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybdw-0002NU-U2; Tue, 26 Feb 2019 12:15:28 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybcl-00086Y-LD
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:14:16 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 736C180D;
 Tue, 26 Feb 2019 04:14:15 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A68473F5C1;
 Tue, 26 Feb 2019 04:14:13 -0800 (PST)
Date: Tue, 26 Feb 2019 12:14:11 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v5 24/26] KVM: arm64: Add a capabillity to advertise SVE
 support
Message-ID: <20190226121411.GV3567@e103592.cambridge.arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-25-git-send-email-Dave.Martin@arm.com>
 <e1e048ff-dbe0-34fe-3318-d9c9ecbccf0e@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e1e048ff-dbe0-34fe-3318-d9c9ecbccf0e@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_041415_708921_FB1E56A2 
X-CRM114-Status: GOOD (  26.45  )
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

On Fri, Feb 22, 2019 at 09:10:46AM +0000, Julien Thierry wrote:
> Hi Dave,
> 
> On 18/02/2019 19:52, Dave Martin wrote:
> > To provide a uniform way to check for KVM SVE support amongst other
> > features, this patch adds a suitable capability KVM_CAP_ARM_SVE,
> > and reports it as present when SVE is available.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---
> >  arch/arm64/kvm/reset.c   | 8 ++++++++
> >  include/uapi/linux/kvm.h | 1 +
> >  2 files changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> > index e67cd2e..f636b34 100644
> > --- a/arch/arm64/kvm/reset.c
> > +++ b/arch/arm64/kvm/reset.c
> > @@ -35,6 +35,7 @@
> >  #include <asm/kvm_asm.h>
> >  #include <asm/kvm_coproc.h>
> >  #include <asm/kvm_mmu.h>
> > +#include <asm/virt.h>
> >  
> >  /* Maximum phys_shift supported for any VM on this host */
> >  static u32 kvm_ipa_limit;
> > @@ -93,6 +94,9 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> >  	case KVM_CAP_ARM_VM_IPA_SIZE:
> >  		r = kvm_ipa_limit;
> >  		break;
> > +	case KVM_CAP_ARM_SVE:
> > +		r = system_supports_sve();
> > +		break;
> >  	default:
> >  		r = 0;
> >  	}
> > @@ -105,6 +109,10 @@ static int kvm_reset_sve(struct kvm_vcpu *vcpu)
> >  	if (!system_supports_sve())
> >  		return -EINVAL;
> >  
> > +	/* Verify that KVM startup enforced this when SVE was detected: */
> > +	if (WARN_ON(!has_vhe()))
> > +		return -EINVAL;
> 
> I'm wondering, wouldn't it make more sense to check for this when
> userland tries to set KVM_ARM_VCPU_SVE?
> 
> Reviewed-by: Julien Thierry <julien.thierry@arm.com>

I have a vague memory of these being some sort of reason for this, but
looking at the code now I can't see why the check can't be moved to
kvm_reset_vcpu().

How does the following look?  The effective is no different, but the
code arrangement may be a bit less surprising this way:

int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
{
[...]
        if (test_bit(KVM_ARM_VCPU_SVE, vcpu->arch.features)) {
		if (!system_supports_sve())
			return -EINVAL;

		if (WARN_ON(!has_vhe()))
			return -EINVAL;

		/* KVM statup should enforce this on SVE hardware: */
                ret = kvm_reset_sve(vcpu);
                if (ret)
                        return ret;
        }


This function is bascially the arch backend for KVM_ARM_VCPU_INIT, so I
don't see a better place to do this right now.  Adding an extra hook
just for this kind of thing feels like overkill...

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
