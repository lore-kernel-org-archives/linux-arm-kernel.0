Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1C7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:56:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E0C120821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t4kKUspd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0C120821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WV0HCCxqVqnKHDi9PI7KxOQTCC3RkT64IpI/i86esd8=; b=t4kKUspdGBqwkw
	PP472qll2YsB1SWDNxMQ/DCVIoGxw/QFikmJVr3sH2bVdtHVOqrA0NuUmAShkNBA2ywAkwItztG1w
	3gwtJ0qPHxpnaahbcJW49NQnIdiUtDQG5KFSMVtZlkOtuYDvbdIhHRzPj89rIHfG34V5WKZNIsnQr
	na24C76ETPr26GaJ5bGgzPYi4gmSRYwphY21aa6lsaBXgp1IntbPXrp/gkbVfc92tgcVN/hVprhfe
	oXzmPffrj47VvxSLt3/zNN7WPamyP/9YL0nb1lKWc/lq+MhXwYyZiMTvgnABSDo6NggMBLU1DC3M7
	L3xOAMLYCx4mVjVpPCIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWJF5-000478-4Y; Mon, 10 Dec 2018 10:56:51 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWJF0-00046n-W8
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 10:56:48 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 835211596;
 Mon, 10 Dec 2018 02:56:36 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CEA13F6A8;
 Mon, 10 Dec 2018 02:56:35 -0800 (PST)
Date: Mon, 10 Dec 2018 10:56:32 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH 06/12] KVM: arm64: Support Live Physical Time reporting
Message-ID: <20181210105632.hjdnszkcqwiqbyub@lakrids.cambridge.arm.com>
References: <20181128144527.44710-1-steven.price@arm.com>
 <20181128144527.44710-7-steven.price@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128144527.44710-7-steven.price@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_025647_044826_9AC84F8C 
X-CRM114-Status: GOOD (  20.77  )
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
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 02:45:21PM +0000, Steven Price wrote:
> Provide a method for a guest to derive a paravirtualized counter/timer
> which isn't dependent on the host's counter frequency. This allows a
> guest to be migrated onto a new host which doesn't have the same
> frequency without the virtual counter being disturbed.

I have a number of concerns about paravirtualizing the timer frequency,
but I'll bring that up in reply to the cover letter.

I have some orthogonal comments below.

> The host provides a shared page which contains coefficients that can be
> used to map the real counter from the host (the Arm "virtual counter")
> to a paravirtualized view of time. On migration the new host updates the
> coefficients to ensure that the guests view of time (after using the
> coefficients) doesn't change and that the derived counter progresses at
> the same real frequency.

Can we please avoid using the term 'page' here?

There is a data structure in shared memory, but it is not page-sized,
and referring to it as a page here and elsewhere is confusing. The spec
never uses the term 'page'

Could we please say something like:

  The host provides a datastrucutre in shared memory which ...

... to avoid the implication this is page sized/aligned etc.

[...]

> +	struct kvm_arch_pvtime {
> +		void *pv_page;
> +
> +		gpa_t lpt_page;
> +		u32 lpt_fpv;
> +	} pvtime;

To remove the page terminology, perhaps something like:

	struct kvm_arch_pvtime {
 		struct lpt	*lpt;
 		gpa_t		lpt_gpa;
 		u32		lpt_fpv;
 	};

[...]

> diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
> index 8bf259dae9f6..fd3a2caabeb2 100644
> --- a/include/linux/kvm_types.h
> +++ b/include/linux/kvm_types.h
> @@ -49,6 +49,8 @@ typedef unsigned long  gva_t;
>  typedef u64            gpa_t;
>  typedef u64            gfn_t;
>  
> +#define GPA_INVALID    -1

To avoid any fun with signed/unsigned comparison, can we please make
this:

#define GPA_INVALID	((gpa_t)-1)

... or:

#define GPA_INVALID     (~(gpa_t)0)

[...]

> +static void update_vtimer_cval(struct kvm *kvm, u32 previous_rate)
> +{
> +	u32 current_rate = arch_timer_get_rate();
> +	u64 current_time = kvm_phys_timer_read();
> +	int i;
> +	struct kvm_vcpu *vcpu;
> +	u64 rel_cval;
> +
> +	/* Early out if there's nothing to do */
> +	if (likely(previous_rate == current_rate))
> +		return;

Given this only happens on migration, I don't think we need to care
about likely/unlikely here, and can drop that from the condition.

[...]

> +int kvm_arm_update_lpt_sequence(struct kvm *kvm)
> +{
> +	struct pvclock_vm_time_info *pvclock;
> +	u64 lpt_ipa = kvm->arch.pvtime.lpt_page;
> +	u64 native_freq, pv_freq, scale_mult, div_by_pv_freq_mult;
> +	u64 shift = 0;
> +	u64 sequence_number = 0;
> +
> +	if (lpt_ipa == GPA_INVALID)
> +		return -EINVAL;
> +
> +	/* Page address must be 64 byte aligned */
> +	if (lpt_ipa & 63)
> +		return -EINVAL;

Please use IS_ALIGNED(), e.g.

	if (!IS_ALIGNED(lpt_ipa, 64))
		return -EINVAL;

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
