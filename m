Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A36C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:51:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C37D92084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iyHel0vb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37D92084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wbbzggBkPH2bTyFGtEgFPfOEa0Sm0lSs9FwjCXtFW50=; b=iyHel0vbKI57gE
	1HrI/a8CcJSl4IgE+Qeb/s5AOFtNWieASgF0M0DSBEFaxw8sX6Td24CULtiMOCmCsebw6n2uCR9Vt
	vqedqIz09aP1dZNdbfiW/Z8oz1wW7K6OJdMplP5CUzMxJZd5SnVDQdulZJ+PeJPUxi5ovfEabL5tA
	+pVrudHUJ6JfDiozhS/85/CWX86oJhtczeSPbG2+TkcvKMWo9ajNtmL/7q0O2MGHt508JIKAAxQaz
	9sDfxXd+RAEKD4d8DVByA/o98urdb0FE6PvSKyMMf9iyg2KdV0K4y65wvXg4yLyljfj+FlkVSVKti
	jdCYcSGddiCZmydJXBxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqcz-0003Rx-Tu; Thu, 21 Feb 2019 15:51:13 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqct-0003O3-Aj
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:51:12 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2B99A78;
 Thu, 21 Feb 2019 07:51:05 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 106E43F5C1;
 Thu, 21 Feb 2019 07:51:03 -0800 (PST)
Date: Thu, 21 Feb 2019 15:51:01 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: Re: [PATCH v6 2/6] arm64/kvm: preserve host MDCR_EL2 value
Message-ID: <20190221155101.GV3567@e103592.cambridge.arm.com>
References: <1550568271-5319-1-git-send-email-amit.kachhap@arm.com>
 <1550568271-5319-3-git-send-email-amit.kachhap@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550568271-5319-3-git-send-email-amit.kachhap@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_075107_610684_2725EE35 
X-CRM114-Status: GOOD (  19.52  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Kristina Martsenko <kristina.martsenko@arm.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 19, 2019 at 02:54:27PM +0530, Amit Daniel Kachhap wrote:
> Save host MDCR_EL2 value during kvm HYP initialisation and restore
> after every switch from host to guest. There should not be any
> change in functionality due to this.
> 
> The value of mdcr_el2 is now stored in struct kvm_cpu_context as
> both host and guest can now use this field in a common way.

Is MDCR_EL2 somehow relevant to pointer auth?

It's not entirely clear why this patch is here.

If this is a cleanup to align the handling of this register with
how HCR_EL2 is handled, it would be good to explain that in the commit
message.

> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> ---
>  arch/arm/include/asm/kvm_host.h   |  1 -
>  arch/arm64/include/asm/kvm_host.h |  6 ++----
>  arch/arm64/kvm/debug.c            | 28 ++++++----------------------
>  arch/arm64/kvm/hyp/switch.c       | 17 ++++-------------
>  arch/arm64/kvm/hyp/sysreg-sr.c    |  6 ++++++
>  virt/kvm/arm/arm.c                |  1 -
>  6 files changed, 18 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index 05706b4..704667e 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -294,7 +294,6 @@ static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
>  static inline void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu) {}
>  
> -static inline void kvm_arm_init_debug(void) {}
>  static inline void kvm_arm_setup_debug(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_arm_clear_debug(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu) {}
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 1b2e05b..2f1bb86 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -205,6 +205,8 @@ struct kvm_cpu_context {
>  
>  	/* HYP host/guest configuration */
>  	u64 hcr_el2;
> +	u32 mdcr_el2;
> +

ARMv8-A says MDCR_EL2 is a 64-bit register.

Bits [63:20] are currently RES0, so this is probably not a big deal.
But it would be better to make this 64-bit to prevent future accidents.
It may be better to make that change in a separate patch.

This is probably non-urgent, since this is clearly not causing problems
for anyone today.

[...]

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
