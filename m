Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA683C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:40:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 776FC2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="odkr2sT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776FC2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eHcTOja2Ov3bkfnKPJMJV9fmUP/DAjREXdidlW8dy3k=; b=odkr2sT5WwvbUy
	RP82Jov3/NgjEHcxCIUW8pJXI1uNXJbXqrRxZJoQLpNBc0jgirmM2BsVDuUcNw6ZImnoWep518FZ3
	VCvc2PlLxynuvB6azfPdYwDYK4W4z+ym/tp2IXX9yxHHqUs9jAewu/WnSNk1F0F+4vsA//iHnFCUR
	HhhzATTiLe+MdU36SxXYH5khWsM0yGFPY/NLlEcsaAA7vDZrfeN5Bva1Ct7F+cmQEDzrwWilo7Sf2
	ezOyeFejXXzo4XTdDbOhRog5wmER4fbGp2Ru7QdrMcb1IxBZyNYYNfKOpdat/whI/6iC1WCZkwN/Q
	ir9hvgKCPY0vsgBrtL+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx9Bl-0006Lq-MT; Fri, 22 Feb 2019 11:40:21 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx9Bi-0006LX-Nj
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 11:40:20 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D46C15AB;
 Fri, 22 Feb 2019 03:40:18 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28E413F5C1;
 Fri, 22 Feb 2019 03:40:16 -0800 (PST)
Date: Fri, 22 Feb 2019 11:40:13 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v1 1/4] KVM: arm64: Use macro to replace hard number
Message-ID: <20190222114013.GB42419@lakrids.cambridge.arm.com>
References: <20190222082327.3312-1-leo.yan@linaro.org>
 <20190222082327.3312-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190222082327.3312-2-leo.yan@linaro.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_034018_779629_2177831D 
X-CRM114-Status: GOOD (  14.89  )
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
 Christoffer Dall <christoffer.dall@arm.com>, linux-kernel@vger.kernel.org,
 Jun Yao <yaojun8558363@gmail.com>, James Morse <james.morse@arm.com>,
 Andre Przywara <andre.przywara@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 04:23:23PM +0800, Leo Yan wrote:
> Use macro for ID_AA64MMFR1_EL1.VH bits shift instead of 8 directly.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

It's always nice to get rid of magic numbers, and this is correct
AFAICT. FWIW:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/head.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 4471f570a295..3ac377e9fd28 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -490,7 +490,7 @@ ENTRY(el2_setup)
>  	 * kernel is intended to run at EL2.
>  	 */
>  	mrs	x2, id_aa64mmfr1_el1
> -	ubfx	x2, x2, #8, #4
> +	ubfx	x2, x2, #ID_AA64MMFR1_VHE_SHIFT, #4
>  #else
>  	mov	x2, xzr
>  #endif
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
