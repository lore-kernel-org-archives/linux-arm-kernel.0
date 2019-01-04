Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA093C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:58:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98F0A218E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KedDfpm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F0A218E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DcDYcKWIhSuYRPxsAnSHZ4v5EPIp+YjTbqnvmjYRa9w=; b=KedDfpm3fQCCQo
	EiaFZ69U9xOhtp17hUh657Q3RsBJcNHIe3k59aK70TyQU5k9/skr6iNMsChcVODYj6Gdhwm/7mbnl
	WOZrOm9gBpbP+ZgBGtbJ43pQUf/IeynsiCIK6x7ThYSYxXfusY2CRnpk77zOpUxk5AJ61KS1YsG4Y
	RdXG8/bNHcuLskDKFDLovK5Lf/0ZZpw8lg5WReh0wCQ70nCdN0Hcfqn9cIrRlBZTgTxuq+u0olS2N
	76TdC0g394iJWvbi9tK9K063vwz+8fVZvBn/G312s3g7E/+gPhC/U6fcv/dr1TfOjYYNtB+7UCInK
	mo2wj2zLE0pteeRdOo/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfTk7-0003XT-0t; Fri, 04 Jan 2019 17:58:47 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfTk4-0003X7-EM
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 17:58:45 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3CA5EBD;
 Fri,  4 Jan 2019 09:58:43 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 524183F5D4;
 Fri,  4 Jan 2019 09:58:42 -0800 (PST)
Subject: Re: [PATCH v4 4/6] arm64/kvm: enable pointer authentication
 cpufeature conditionally
To: Amit Daniel Kachhap <amit.kachhap@arm.com>
References: <1545119810-12182-1-git-send-email-amit.kachhap@arm.com>
 <1545119810-12182-5-git-send-email-amit.kachhap@arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <33542a00-23f4-b159-91f5-f05d3afa5b9f@arm.com>
Date: Fri, 4 Jan 2019 17:58:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1545119810-12182-5-git-send-email-amit.kachhap@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_095844_485390_DBA5D419 
X-CRM114-Status: GOOD (  16.25  )
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
 Dave Martin <Dave.Martin@arm.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Amit,

On 18/12/2018 07:56, Amit Daniel Kachhap wrote:
> According to userspace settings, pointer authentication cpufeature
> is enabled/disabled from guests.

This reads like the guest is changing something in the host. Isn't this hiding
the id-register values from the guest?


> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 6af6c7d..ce6144a 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1066,6 +1066,15 @@ static u64 read_id_reg(struct sys_reg_desc const *r, bool raz)
>  			kvm_debug("SVE unsupported for guests, suppressing\n");
>  
>  		val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
> +	} else if (id == SYS_ID_AA64ISAR1_EL1) {
> +		const u64 ptrauth_mask = (0xfUL << ID_AA64ISAR1_APA_SHIFT) |
> +					 (0xfUL << ID_AA64ISAR1_API_SHIFT) |
> +					 (0xfUL << ID_AA64ISAR1_GPA_SHIFT) |
> +					 (0xfUL << ID_AA64ISAR1_GPI_SHIFT);
> +		if (!kvm_arm_vcpu_ptrauth_allowed(vcpu)) {
> +			kvm_debug("ptrauth unsupported for guests, suppressing\n");
> +			val &= ~ptrauth_mask;
> +		}

I think this hunk should have been in the previous patch as otherwise its a
bisection oddity.

Could you merge this hunk with the previous patch, and move the mechanical bits
that pass vcpu around to a prior preparatory patch.

(I'm still unsure if we need to hide this as a user-controlled policy)


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
