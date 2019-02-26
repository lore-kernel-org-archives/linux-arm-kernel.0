Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD511C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:34:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 737642173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aOs95o1W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737642173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ivk2tg7ZX65f8Trx8Vkx2KDpKuVuIXohRXDvYAm44Sg=; b=aOs95o1WyknUEE
	dAc/1fEqoyo/r9GwnBfbffGKKq3aB0HUjnvHsxRzpHXTHIYUI0EiRrWOQxi7ZTxhs8mpxyjtmTGrb
	WBWGn55fA7Ze6eX83Cy7svb0eQOEJZL67/XFomwHoEJuPZaqrzo3OEZls+48JAtB6GvIAHzhhC5et
	di/X3JzuxpITMb0wPpIuJd8TVP0i/QFMtWKJf+Jm7AvkzSqAQ12+CIjfl88XK2IqfqwJGCG5OavcR
	KAaGiMuZIoPodrH79UCBa14/iUxzPR22hgpRm6tApTIwWGfxRX2ZMkEjAyo4T4eW/1lAeINl+kcLE
	xgHEfCcPu+9ED69jS3Tg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyhZ2-0006v8-78; Tue, 26 Feb 2019 18:34:48 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyhYy-0006j8-6B
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 18:34:46 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E77F80D;
 Tue, 26 Feb 2019 10:34:43 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA4DE3F738;
 Tue, 26 Feb 2019 10:34:40 -0800 (PST)
Subject: Re: [PATCH v6 5/6] arm64/kvm: control accessibility of ptrauth key
 registers
To: Amit Daniel Kachhap <amit.kachhap@arm.com>
References: <1550568271-5319-1-git-send-email-amit.kachhap@arm.com>
 <1550568271-5319-6-git-send-email-amit.kachhap@arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <fb401da1-63cb-fde1-67e4-e15f58940ae9@arm.com>
Date: Tue, 26 Feb 2019 18:34:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550568271-5319-6-git-send-email-amit.kachhap@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_103444_242529_548C957B 
X-CRM114-Status: GOOD (  18.67  )
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
 linux-kernel@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>, kvmarm@lists.cs.columbia.edu,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Amit,

On 19/02/2019 09:24, Amit Daniel Kachhap wrote:
> According to userspace settings, ptrauth key registers are conditionally
> present in guest system register list based on user specified flag
> KVM_ARM_VCPU_PTRAUTH.
> 
> Reset routines still sets these registers to default values but they are
> left like that as they are conditionally accessible (set/get).

What problem is this patch solving?

I think it's that now we have ptrauth support, we have a glut of new registers visible to
user-space. This breaks migration and save/resume if the target machine doesn't have
pointer-auth configured, even if the guest wasn't using it.
Because we've got a VCPU bit, we can be smarter about this, and only expose the registers
if user-space was able to enable ptrauth.


> ---
> This patch needs patch [1] by Dave Martin and adds feature to manage accessibility in a scalable way.
> 
> [1]: https://lore.kernel.org/linux-arm-kernel/1547757219-19439-13-git-send-email-Dave.Martin@arm.com/ 

This is v4. Shortly before you posted this there was a v5 (but the subject changed, easily
missed). V5 has subsequently been reviewed. As we can't have both, could you rebase onto
that v5 so that there is one way of doing this?

(in general if you could re-post the version you develop/tested with then it makes it
clear what is going on)


> diff --git a/Documentation/arm64/pointer-authentication.txt b/Documentation/arm64/pointer-authentication.txt
> index 0529a7d..996e435 100644
> --- a/Documentation/arm64/pointer-authentication.txt
> +++ b/Documentation/arm64/pointer-authentication.txt
> @@ -87,3 +87,7 @@ created by passing a flag (KVM_ARM_VCPU_PTRAUTH) requesting this feature
>  to be enabled. Without this flag, pointer authentication is not enabled
>  in KVM guests and attempted use of the feature will result in an UNDEFINED
>  exception being injected into the guest.
> +
> +Additionally, when KVM_ARM_VCPU_PTRAUTH is not set then KVM will filter
> +out the Pointer Authentication system key registers from KVM_GET/SET_REG_*
> +ioctls.
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index f7bcc60..c2f4974 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1005,8 +1005,13 @@ static bool trap_ptrauth(struct kvm_vcpu *vcpu,
>  	return false;
>  }
>  
> +static bool check_ptrauth(const struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd)
> +{
> +	return kvm_arm_vcpu_ptrauth_allowed(vcpu);
> +}
> +
>  #define __PTRAUTH_KEY(k)						\
> -	{ SYS_DESC(SYS_## k), trap_ptrauth, reset_unknown, k }
> +	{ SYS_DESC(SYS_## k), trap_ptrauth, reset_unknown, k , .check_present = check_ptrauth}


Looks good. I'm pretty sure the changes due to Dave's v5 map neatly.


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
