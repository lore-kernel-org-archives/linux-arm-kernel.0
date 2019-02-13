Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BC0C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:21:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D4D222B5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TsBB61WC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D4D222B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4MWIaNFEIp8pB+WJc+m6rBtDKy2wpc0Mvi359Jzs9A0=; b=TsBB61WC1oLopK
	pXbiCXiusVK9UxhUagBF2sG46FizqiqHpnggQPJpMeE+D0iI32vW9mYqhZLqp11x3y/OWRas7HcaE
	X1bRGJlJ+s5IEWZDovu/1xaVnibx4rEmDT0dLu2TZWk84l+TZq5bnNNoNq3xSGd4zBgB2c2LjZnlb
	Kq1FkyCGztQl5lros1CnxHA+Uoaju6pLZUHSq4m9C52bmU95p7fZgd6ve5E1UalLq8cwbkEQwA/W1
	rz2qZE9P1e5UQNQP83SCLTCIMJkUAlCgilumqdM1EkPMNtDrv1eO17YS/lj2IxvodEHfo8acY1UN7
	5bMuNLWTZDswFVfwQVaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtsbn-0002Zv-Ol; Wed, 13 Feb 2019 11:21:43 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtsbl-0002ZZ-8t
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 11:21:42 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9195DA78;
 Wed, 13 Feb 2019 03:21:40 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4E063F557;
 Wed, 13 Feb 2019 03:21:38 -0800 (PST)
Date: Wed, 13 Feb 2019 11:21:36 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/3] arm64: mmu: early_pgtable_alloc: remove unnecessary
 comments
Message-ID: <20190213112136.GB22119@lakrids.cambridge.arm.com>
References: <20190213094831.7292-1-peng.fan@nxp.com>
 <20190213094831.7292-2-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190213094831.7292-2-peng.fan@nxp.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_032141_320901_A63FBAD9 
X-CRM114-Status: GOOD (  18.63  )
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
Cc: "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "yaojun8558363@gmail.com" <yaojun8558363@gmail.com>,
 "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
 "van.freenix@gmail.com" <van.freenix@gmail.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 09:37:29AM +0000, Peng Fan wrote:
> The empty zero page has been moved to bss area by
> commit 5227cfa71f9e ("arm64: mm: place empty_zero_page in bss"),
> and it alreay added "dsb     ishst" in head.S to make sure the empty
> zero page visible to PTW.
> 
> There is no code to reflect the comment, so remove it.

The comment below refers to the memory pointed to by ptr, which is
zeroed by the memset. The comment does not refer to the generic
empty_zero_page.

This comment is correct, and should stay. Please drop this patch.

Thanks,
Mark.

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/mm/mmu.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 065202da3ad2..f61fa7c8fd2e 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -113,10 +113,6 @@ static phys_addr_t __init early_pgtable_alloc(void)
>  
>  	memset(ptr, 0, PAGE_SIZE);
>  
> -	/*
> -	 * Implicit barriers also ensure the zeroed page is visible to the page
> -	 * table walker
> -	 */
>  	pte_clear_fixmap();
>  
>  	return phys;
> -- 
> 2.16.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
