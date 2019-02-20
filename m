Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99ADBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:43:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B5E2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nT1pVywV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B5E2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Md13+QBKefTirenaPVJHeEnibPLY0mq+09XIQ8T6W9s=; b=nT1pVywVxs+CQl
	Q0/DrdK1mQqNmStYC4LLvHhSrW99yfZc7O/FdEDL2DjUPGoZUrI2MB3+RWeyVfOxZcFdQ+thq8LTv
	VOi9yVl3+0DluKh7rG9OzHi7OZKXeu4hALntYGVvY0KsWfYeajJnMshQX5RhSlcLy5oVWX1GoYA9Z
	UV3SgTJUGl77eMRmwHdQwKY7MWRkcwWG1nznHdJJ7aTeT74jwSFjgGezOql5ehSTmIh2NBSU/L7Gw
	YE6l8rCcEpV8gKDCucpFED7tck4WKgBCub5tp/AyLYmmZfDagLye0vOZ5hzanXgdmwO74WLI9N/2M
	Zmy/rIp0RQgxBVEKOvGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwQHo-0006kL-SM; Wed, 20 Feb 2019 11:43:36 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwQHl-0006ja-Ch
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 11:43:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79AD1A78;
 Wed, 20 Feb 2019 03:43:32 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 382803F575;
 Wed, 20 Feb 2019 03:43:27 -0800 (PST)
Subject: Re: [PATCH v5 07/26] arm64/sve: Clarify role of the VQ map
 maintenance functions
To: Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.cs.columbia.edu
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-8-git-send-email-Dave.Martin@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <f8a56d62-3b45-e369-ed4a-187895a178c0@arm.com>
Date: Wed, 20 Feb 2019 11:43:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1550519559-15915-8-git-send-email-Dave.Martin@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_034333_439170_AB98CB99 
X-CRM114-Status: GOOD (  21.45  )
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
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 18/02/2019 19:52, Dave Martin wrote:
> The roles of sve_init_vq_map(), sve_update_vq_map() and
> sve_verify_vq_map() are highly non-obvious to anyone who has not dug
> through cpufeatures.c in detail.
> 
> Since the way these functions interact with each other is more
> important here than a full understanding of the cpufeatures code, this
> patch adds comments to make the functions' roles clearer.
> 
> No functional change.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  arch/arm64/kernel/fpsimd.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 64729e2..92c2331 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -647,6 +647,10 @@ static void sve_probe_vqs(DECLARE_BITMAP(map, SVE_VQ_MAX))
>  	}
>  }
>  
> +/*
> + * Initialise the set of known supported VQs for the boot CPU.
> + * This is called during kernel boot, before secondary CPUs are brought up.
> + */
>  void __init sve_init_vq_map(void)
>  {
>  	sve_probe_vqs(sve_vq_map);
> @@ -656,6 +660,7 @@ void __init sve_init_vq_map(void)
>  /*
>   * If we haven't committed to the set of supported VQs yet, filter out
>   * those not supported by the current CPU.
> + * This function is called during the bring-up of early secondary CPUs only.
>   */
>  void sve_update_vq_map(void)
>  {
> @@ -666,7 +671,10 @@ void sve_update_vq_map(void)
>  	bitmap_or(sve_vq_partial_map, sve_vq_partial_map, tmp_map, SVE_VQ_MAX);
>  }
>  
> -/* Check whether the current CPU supports all VQs in the committed set */
> +/*
> + * Check whether the current CPU supports all VQs in the committed set.
> + * This function is called during the bring-up of late secondary CPUs only.

Oh I see, this is for late CPUs. So you can probably disregard my
comment on the warning in the previous patch.

If you respin this series, I feel it would be more useful to have this
patch before the current patch 6.

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
