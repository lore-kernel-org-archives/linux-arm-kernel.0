Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9D1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:33:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C9272173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uigRLhBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9272173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=veAI5eYa4BTAwzWftFrr5kxHoXwaFrhMvMmXfHh0e1Y=; b=uigRLhBi2czBzw
	uyYb3VcvkAKfnE3wTLQ/LCJSRahSRNz75vH32IPoiO78c1w1r28cMZmnpVqxT+paoTLbl2QiSEiSt
	HbKB57k24g8jUG6N3hRBN2Qulg55aePSEsiAQBAfk49+tERGanpwg5c1r1Bb+ZpjxbmB6WqZIgoww
	SVZSLpUojXRf3DnF2ayan2u0dwfYC6L+gTLShKwDptvc06Of69Rn9frfyUJUgMQvksHF7+axxRdEL
	MsNPw1E3ebXf9hC7e2sDhU7bUoZbmDbIYrO5fsKHrCckevAdPvhwGM83qnrsbTttk91RrztmZ1yZY
	dO6tZPmFa7V6LmhbsVkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyhXf-00057X-Lw; Tue, 26 Feb 2019 18:33:23 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyhXc-000575-GL
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 18:33:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D29380D;
 Tue, 26 Feb 2019 10:33:19 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 024B73F738;
 Tue, 26 Feb 2019 10:33:16 -0800 (PST)
Subject: Re: [PATCH v6 4/6] arm64/kvm: add a userspace option to enable
 pointer authentication
To: Amit Daniel Kachhap <amit.kachhap@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <1550568271-5319-1-git-send-email-amit.kachhap@arm.com>
 <1550568271-5319-5-git-send-email-amit.kachhap@arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <f7e4156e-c9aa-0356-d9a4-6b01ff23c5c0@arm.com>
Date: Tue, 26 Feb 2019 18:33:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550568271-5319-5-git-send-email-amit.kachhap@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_103320_557298_A680DF97 
X-CRM114-Status: GOOD (  24.12  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Jones <drjones@redhat.com>,
 Julien Thierry <julien.thierry@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>, kvmarm@lists.cs.columbia.edu,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Amit,

On 19/02/2019 09:24, Amit Daniel Kachhap wrote:
> This feature will allow the KVM guest to allow the handling of
> pointer authentication instructions or to treat them as undefined
> if not set. It uses the existing vcpu API KVM_ARM_VCPU_INIT to
> supply this parameter instead of creating a new API.
> 
> A new register is not created to pass this parameter via
> SET/GET_ONE_REG interface as just a flag (KVM_ARM_VCPU_PTRAUTH)
> supplied is enough to enable this feature.

and an attempt to restore the id register with the other version would fail.


> diff --git a/Documentation/arm64/pointer-authentication.txt b/Documentation/arm64/pointer-authentication.txt
> index a25cd21..0529a7d 100644
> --- a/Documentation/arm64/pointer-authentication.txt
> +++ b/Documentation/arm64/pointer-authentication.txt
> @@ -82,7 +82,8 @@ pointers).
>  Virtualization
>  --------------
>  
> -Pointer authentication is not currently supported in KVM guests. KVM
> -will mask the feature bits from ID_AA64ISAR1_EL1, and attempted use of
> -the feature will result in an UNDEFINED exception being injected into
> -the guest.

> +Pointer authentication is enabled in KVM guest when virtual machine is
> +created by passing a flag (KVM_ARM_VCPU_PTRAUTH)

(This is still mixing VM and VCPU)


> + requesting this feature to be enabled.

.. on each vcpu?


> +Without this flag, pointer authentication is not enabled
> +in KVM guests and attempted use of the feature will result in an UNDEFINED
> +exception being injected into the guest.

'guests' here suggests its a VM property. If you set it on some VCPU but not others KVM
will generate undefs instead of enabling the feature. (which is the right thing to do)

I think it needs to be clear this is a per-vcpu property.


> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index 97c3478..5f82ca1 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -102,6 +102,7 @@ struct kvm_regs {
>  #define KVM_ARM_VCPU_EL1_32BIT		1 /* CPU running a 32bit VM */
>  #define KVM_ARM_VCPU_PSCI_0_2		2 /* CPU uses PSCI v0.2 */
>  #define KVM_ARM_VCPU_PMU_V3		3 /* Support guest PMUv3 */

> +#define KVM_ARM_VCPU_PTRAUTH		4 /* VCPU uses address authentication */

Just address authentication? I agree with Mark we should have two bits to match what gets
exposed to EL0. One would then be address, the other generic.


> diff --git a/arch/arm64/kvm/hyp/ptrauth-sr.c b/arch/arm64/kvm/hyp/ptrauth-sr.c
> index 528ee6e..6846a23 100644
> --- a/arch/arm64/kvm/hyp/ptrauth-sr.c
> +++ b/arch/arm64/kvm/hyp/ptrauth-sr.c
> @@ -93,9 +93,23 @@ void kvm_arm_vcpu_ptrauth_reset(struct kvm_vcpu *vcpu)

> +/**
> + * kvm_arm_vcpu_ptrauth_allowed - checks if ptrauth feature is allowed by user
> + *
> + * @vcpu: The VCPU pointer
> + *
> + * This function will be used to check userspace option to have ptrauth or not
> + * in the guest kernel.
> + */
> +bool kvm_arm_vcpu_ptrauth_allowed(const struct kvm_vcpu *vcpu)
> +{
> +	return kvm_supports_ptrauth() &&
> +		test_bit(KVM_ARM_VCPU_PTRAUTH, vcpu->arch.features);
> +}

This isn't used from world-switch, could it be moved to guest.c?


> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 12529df..f7bcc60 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1055,7 +1055,7 @@ static bool access_cntp_cval(struct kvm_vcpu *vcpu,
>  }
>  
>  /* Read a sanitised cpufeature ID register by sys_reg_desc */
> -static u64 read_id_reg(struct sys_reg_desc const *r, bool raz)
> +static u64 read_id_reg(struct kvm_vcpu *vcpu, struct sys_reg_desc const *r, bool raz)

(It might be easier on the reviewer to move these mechanical changes to an earlier patch)


Looks good,

Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
