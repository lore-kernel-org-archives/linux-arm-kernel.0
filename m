Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3F2C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:10:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D05D9217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jy+xDXnp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HtrHyWtK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05D9217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jj7+7hOAtlKa4ueidqrUKog/xsjj9vlHvPvuHlWja9g=; b=Jy+xDXnpg1E9n/
	UR1kESGkzHosMIwAy14UadkAnxQqaUaJxTs+MLnJLj6zOcmUd4wHG9YpV9AlGOrC7HyuMRKum67Ty
	7Zyd5SrWsXHZY4yy+HgIRKCselgHCBujJfO1hNq7o9K+kkNcX1urEYpQ5BSg4AHZBl5ADsfMGiGw+
	argqNgbA2+q2F3xorTX+hvoN59A5o6W9pjTpGJ5usLAHkhs/HbspRtltYQ2UmLDOGTqL2sQ9tzKMI
	QwoF/7re3kKHpPusfx77epmyC/E9Nl4J884PjvTMO0Xx22/HlQQwaU3HwTbSfL6eYwLmPt4ZQLTSh
	ftVxL8vrSBHu6w3Xa0xA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmhag-0003Ja-Pa; Thu, 24 Jan 2019 16:10:54 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmhae-0003JS-Bo
 for linux-arm-kernel@bombadil.infradead.org; Thu, 24 Jan 2019 16:10:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i7Fq2hj79lP3WJEIp5Hi89WcEteCxHqDCv4qFcLi7oo=; b=HtrHyWtKChlPg9kps2cUHAOYa
 2tRrcs5ecCUyibSCMV8gpafwGyNFYNgR6DiPXYzm11BUi+aY3ldSphEYNZTlOyUN+uN8zbeBoGp18
 CwyU+3ybCmTaGG+40C5A+zRdoMxBBSf2duuhcGLkkrmH7dDnANJPqO4AqOrzVEXpRw5ht/Mfi2v2B
 nf0Zov/iJmkJpUS+ffx3iZEuZQHMwbl1pXV6KLJQhkp6LjixXCjgfg+ecYKmfFeiiYJdhVesf8W0q
 3banuuN+XtO/7nDcJ8xZjEZ2wVKa784Vui/EYnrOgO4q4OuCZkmo4BAvpVnS2TANYtKREu22KRcVv
 g4G5BlPlg==;
Received: from foss.arm.com ([217.140.101.70])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmgkY-0004Ay-K1
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 15:17:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C2A4A78;
 Thu, 24 Jan 2019 07:16:59 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 2026E3F5AF; Thu, 24 Jan 2019 07:16:57 -0800 (PST)
Date: Thu, 24 Jan 2019 15:16:55 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 2/6] arm64/mm: Ensure PGD kmem cache object is actually
 allocated
Message-ID: <20190124151655.GH253679@arrakis.emea.arm.com>
References: <1548307220-19756-1-git-send-email-anshuman.khandual@arm.com>
 <1548307220-19756-3-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548307220-19756-3-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_101702_784712_D20D1638 
X-CRM114-Status: GOOD (  15.46  )
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
Cc: mark.rutland@arm.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
 Steve.Capper@arm.com, will.deacon@arm.com, james.morse@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 24, 2019 at 10:50:16AM +0530, Anshuman Khandual wrote:
> 'pgd_cache' is created for allocating non PAGE_SIZE based PGD pointers. In
> such cases ensure that the kmem cache object is allocated before proceeding
> further with boot.
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/mm/pgd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
> index 289f911..8cb4e39 100644
> --- a/arch/arm64/mm/pgd.c
> +++ b/arch/arm64/mm/pgd.c
> @@ -62,4 +62,5 @@ void __init pgd_cache_init(void)
>  	 */
>  	pgd_cache = kmem_cache_create("pgd_cache", PGD_SIZE, PGD_SIZE,
>  				      SLAB_PANIC, NULL);
> +	BUG_ON(!pgd_cache);

Isn't SLAB_PANIC sufficient here?

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
