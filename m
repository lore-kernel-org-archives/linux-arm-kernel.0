Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B148C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:35:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0C5B2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OurrNWNk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C5B2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:Subject:From:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nonZMbUruzfyNtXtwLTOpzWMLO1B+cMwZ68NboKe6TM=; b=OurrNWNk9IWW3R
	MINcahxxuEbuJGtyPyqPImx85m8RbXZ7wyW50x8y7AdQJh82R517N3wdMHOk3eknLGKzM3ihKa4tz
	s4mIDP4PeEusPOY1b9KdFS1EwiymNTJgaqsrun4/Yq16cJB4yHdz0ndk4SITc+JXfeMv+WZtsuRDF
	ge7QHMXPjEMRIAqaasCiIlCQ4fVCGArctrNv7aLgm+zaUpeM1xVyZbPXgC6rqsZCQwASRd9JnKrqj
	Z1KBp2D9gt7hQuw/+ZCUtfLDw4Fc3rXO6SA9Shcx4g7VtGD52BCMChWvjtcGsXl5ouIoHO+krlr0D
	C600W/RPta4PJJGrmVnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtyRe-0005UK-W9; Wed, 13 Feb 2019 17:35:39 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtyRT-0005I9-Kz
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 17:35:36 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41790A78;
 Wed, 13 Feb 2019 09:35:27 -0800 (PST)
Received: from [10.1.197.21] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 0B3333F675; Wed, 13 Feb 2019 09:35:23 -0800 (PST)
From: Kristina Martsenko <kristina.martsenko@arm.com>
Subject: Re: [PATCH v5 4/5] arm64/kvm: add a userspace option to enable
 pointer authentication
To: Amit Daniel Kachhap <amit.kachhap@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <1548658727-14271-1-git-send-email-amit.kachhap@arm.com>
 <1548658727-14271-5-git-send-email-amit.kachhap@arm.com>
Message-ID: <a9b22dcf-2238-344f-0b7b-b4a9de7c562c@arm.com>
Date: Wed, 13 Feb 2019 17:35:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548658727-14271-5-git-send-email-amit.kachhap@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_093528_404791_92D3F714 
X-CRM114-Status: GOOD (  17.59  )
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
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 kvmarm@lists.cs.columbia.edu,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 28/01/2019 06:58, Amit Daniel Kachhap wrote:
> This feature will allow the KVM guest to allow the handling of
> pointer authentication instructions or to treat them as undefined
> if not set. It uses the existing vcpu API KVM_ARM_VCPU_INIT to
> supply this parameter instead of creating a new API.
> 
> A new register is not created to pass this parameter via
> SET/GET_ONE_REG interface as just a flag (KVM_ARM_VCPU_PTRAUTH)
> supplied is enough to enable this feature.

[...]

> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index b200c14..b6950df 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -346,6 +346,10 @@ static inline int kvm_arm_have_ssbd(void)
>  static inline void kvm_vcpu_load_sysregs(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_vcpu_put_sysregs(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_arm_vcpu_ptrauth_reset(struct kvm_vcpu *vcpu) {}
> +static inline bool kvm_arm_vcpu_ptrauth_allowed(struct kvm_vcpu *vcpu)
> +{
> +	return false;
> +}

It seems like this is only ever called from arm64 code, so do we need an
arch/arm/ definition?

> +/**
> + * kvm_arm_vcpu_ptrauth_allowed - checks if ptrauth feature is present in vcpu
> + *
> + * @vcpu: The VCPU pointer
> + *
> + * This function will be used to enable/disable ptrauth in guest as configured
> + * by the KVM userspace API.
> + */
> +bool kvm_arm_vcpu_ptrauth_allowed(struct kvm_vcpu *vcpu)
> +{
> +	return test_bit(KVM_ARM_VCPU_PTRAUTH, vcpu->arch.features);
> +}

I'm not sure, but should there also be something like

if (test_bit(KVM_ARM_VCPU_PTRAUTH, vcpu->arch.features) &&
    !kvm_supports_ptrauth())
	return -EINVAL;

in kvm_reset_vcpu?

Thanks,
Kristina

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
