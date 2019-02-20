Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3306BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:46:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECDE020880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iwKzwAZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECDE020880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MVoEwMyg1VbpH57QQ/1AIgfsCEzk65Z7Mn4oLPt3oBk=; b=iwKzwAZPMtaumQ
	bY2Q4xNsDtezrNAePiE1zW4WjL9qgUXk7dnXhxLR5Ty+NiSxq26TjVWu1NRoggXdQGcMc/A98yoMu
	SanWpccYYNbeDm91Wi0e+IWxHWMLgZsuwpnGiL1sM3NKHrp/lBaDuhvKEui/gWWatM5fevStdAF1R
	k8HheTtFYRlfjzFuKQ6f0U+H+Tc9sd2kP/oSeW9ZfeK+WsQvtkC2rQPlSkPK9gvxZmes4Kgnbsrq/
	3NLCwj4RSuq/Xp2ydKt78UWnIMHDt47uT//SLVhJOnACRGlwsFn9cV4klDzJM4Iiz4rzley25yvxF
	k3dVKRNATjR+ExZZ8m8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwSCf-0004mg-Ez; Wed, 20 Feb 2019 13:46:25 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwSCc-0004mH-4b
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 13:46:23 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7132EEBD;
 Wed, 20 Feb 2019 05:46:21 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 561C13F690;
 Wed, 20 Feb 2019 05:46:20 -0800 (PST)
Date: Wed, 20 Feb 2019 13:46:16 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
To: Vladimir Murzin <vladimir.murzin@arm.com>
Subject: Re: [PATCH 1/2] arm64: virt: Relax GIC version check
Message-ID: <20190220134616.7a8da0f5@why.wild-wind.fr.eu.org>
In-Reply-To: <1550662986-40987-1-git-send-email-vladimir.murzin@arm.com>
References: <1550662986-40987-1-git-send-email-vladimir.murzin@arm.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_054622_182922_E503EC45 
X-CRM114-Status: GOOD (  18.13  )
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
Cc: Catalin Marinas <Catalin.Marinas@arm.com>,
 Will Deacon <Will.Deacon@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

+ Will, Catalin

On Wed, 20 Feb 2019 11:43:05 +0000
Vladimir Murzin <vladimir.murzin@arm.com> wrote:

> Updates to the GIC architecture allow ID_AA64PFR0_EL1.GIC to have
> values other than 0 or 1. At the moment, Linux is quite strict in the
> way it handles this field at early boot stage (cpufeature is fine) and
> will refuse to use the system register CPU interface if it doesn't
> find the value 1.
> 
> To help backports (even though the code was correct at the time of writing)
> Fixes: 021f653791ad17e03f98aaa7fb933816ae16f161 ("irqchip: gic-v3: Initial support for GICv3")
> 
> Reported-by: Chase Conklin <Chase.Conklin@arm.com>
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/arm64/kernel/head.S | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 15d79a8..eecf792 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -539,8 +539,7 @@ set_hcr:
>  	/* GICv3 system register access */
>  	mrs	x0, id_aa64pfr0_el1
>  	ubfx	x0, x0, #24, #4
> -	cmp	x0, #1
> -	b.ne	3f
> +	cbz	x0, 3f
>  
>  	mrs_s	x0, SYS_ICC_SRE_EL2
>  	orr	x0, x0, #ICC_SRE_EL2_SRE	// Set ICC_SRE_EL2.SRE==1

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

Will, Catalin: It is probably too late for the merge window, but on the
odd chance you could queue it as a fix... Otherwise, this will be a 5.2
candidate.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
