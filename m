Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05915C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:50:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1E9B20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QkjmgHTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E9B20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rfcZkAlAVjQffjPCPU5XOy9/KLF6wjLFvO3IQcQQ1L8=; b=QkjmgHTf/wcBu8
	Yt1PV282WNXeerACLRcRn7LSiBmuMa0rBDWBz4LiW8+xr+N5SXC2tvdDavkKslLvVrdr4V01sFgYB
	1Ye7mLoI7jsHj3tcONdSm58T9M8Y0HSobPWo1hJqil/YBGgq37wUTuVGVGkaILN37c1hxMRSJGSEK
	eA7XZ8JEaHdeLNwr1UicqycnSF6kYMhHbE+taiKNNx41MU3M3eJVOr5ZunmiFXdyfFrFaj8Kz36gc
	CCRWMQbYJuyxBKfMWcyScvBR5BLvLGCd4Gx9DTC/KHqXfGAyl8NZdFDCiBJ5C9u/qKQ1WCjv0kTPS
	uGhGLfuXXw5CnuzgX+iA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwSGM-0006KR-RR; Wed, 20 Feb 2019 13:50:14 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwSGJ-0006K7-IZ
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 13:50:12 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CEE4EBD;
 Wed, 20 Feb 2019 05:50:11 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C9D13F690;
 Wed, 20 Feb 2019 05:50:09 -0800 (PST)
Date: Wed, 20 Feb 2019 13:50:05 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
To: Vladimir Murzin <vladimir.murzin@arm.com>
Subject: Re: [PATCH 2/2] ARM: virt: Align GIC version check with arm64
 counterpart
Message-ID: <20190220135005.2df6c6e1@why.wild-wind.fr.eu.org>
In-Reply-To: <1550662986-40987-2-git-send-email-vladimir.murzin@arm.com>
References: <1550662986-40987-1-git-send-email-vladimir.murzin@arm.com>
 <1550662986-40987-2-git-send-email-vladimir.murzin@arm.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_055011_619326_2256F9B9 
X-CRM114-Status: GOOD (  16.01  )
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
Cc: Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 20 Feb 2019 11:43:06 +0000
Vladimir Murzin <vladimir.murzin@arm.com> wrote:

+ Russell,

> arm64 has got relaxation on GIC version check at early boot stage due
> to update of the GIC architecture let's align ARM with that.
> 
> To help backports (even though the code was correct at the time of writing)
> Fixes: e59941b9b3817c9b1dd6662d903150fe3f3c3b0b ("ARM: 8527/1: virt: enable GICv3 system registers")
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/arm/kernel/hyp-stub.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
> index 9ef1759..fd0a723 100644
> --- a/arch/arm/kernel/hyp-stub.S
> +++ b/arch/arm/kernel/hyp-stub.S
> @@ -179,8 +179,8 @@ ARM_BE8(orr	r7, r7, #(1 << 25))     @ HSCTLR.EE
>  	@ Check whether GICv3 system registers are available
>  	mrc	p15, 0, r7, c0, c1, 1	@ ID_PFR1
>  	ubfx	r7, r7, #28, #4
> -	cmp	r7, #1
> -	bne	2f
> +	teq	r7, #0
> +	beq	2f
>  
>  	@ Enable system register accesses
>  	mrc	p15, 4, r7, c12, c9, 5	@ ICC_HSRE

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

Can you please put this in Russell's patch system?

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
