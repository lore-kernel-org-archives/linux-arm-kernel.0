Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E66C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:26:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3944C20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r0FkR9bb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3944C20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mSmi8fm387SyGrB4OHcTez850PnQMEyGLQjmumTVln4=; b=r0FkR9bbTzcXpdsk9gO7zIKDL
	wiegjasf1pJ72iX0NE8DsNidHXEkYEG+SAGbnpjGesRDKUaJLkclLe2gxZvByPsZa83lccuczUNO9
	vC8Z06b28MJhLZc1fzhJtmpxFULjuMj7cbgptjJMWWYbtCZmKIYoVT0JRdymfVuRwnhiMwDmU5wZE
	ZtCvxURtZ/1mTGFLZJs+oo0pPOgzbppNqyu7QJIwYHGd6xXh3cO8xysGe9oAT7UpTJkalkCeotnxg
	Rp21dE4ixvBpFee0jsxt7AgWPUhvaXfcaNn74xO9qDr45c7UA0PtgCjCH0fAMVax31QgoZAtjgrSz
	wao/4/esQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXOCU-00007G-Rx; Thu, 13 Dec 2018 10:26:38 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXOCP-0008WP-Pr; Thu, 13 Dec 2018 10:26:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C712080D;
 Thu, 13 Dec 2018 02:26:21 -0800 (PST)
Received: from [10.37.13.2] (unknown [10.37.13.2])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC5D73F6A8;
 Thu, 13 Dec 2018 02:26:18 -0800 (PST)
Subject: Re: [PATCH] Revert "iommu/io-pgtable-arm: Check for v7s-incapable
 systems"
To: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will.deacon@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>
References: <1544692788-24427-1-git-send-email-yong.wu@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <38526eab-3010-1ce6-a801-28f5c15dce44@arm.com>
Date: Thu, 13 Dec 2018 10:26:13 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1544692788-24427-1-git-send-email-yong.wu@mediatek.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_022633_839252_623CAD78 
X-CRM114-Status: GOOD (  16.89  )
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
Cc: youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
 Stephen Boyd <swboyd@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 CK Hu <ck.hu@mediatek.com>, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2018-12-13 9:19 am, Yong Wu wrote:
> This reverts commit 82db33dc5e49fb625262d81125625d07a0d6184e.
> 
> After the commit 29859aeb8a6e ("iommu/io-pgtable-arm-v7s: Abort
> allocation when table address overflows the PTE"), v7s will return fail
> if the page table allocation isn't expected. this PHYS_OFFSET check
> is unnecessary now.
> 
> And this check may lead to fail. For example, If CONFIG_RANDOMIZE_BASE
> is enabled, the "memstart_addr" will be updated randomly, then the
> PHYS_OFFSET may be random.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Joerg, if you have any more fixes to send for 4.19, please consider 
picking this up directly.

Thanks,
Robin.

> Reported-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/io-pgtable-arm-v7s.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index 445c3bd..cec29bf 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -709,10 +709,6 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
>   {
>   	struct arm_v7s_io_pgtable *data;
>   
> -#ifdef PHYS_OFFSET
> -	if (upper_32_bits(PHYS_OFFSET))
> -		return NULL;
> -#endif
>   	if (cfg->ias > ARM_V7S_ADDR_BITS || cfg->oas > ARM_V7S_ADDR_BITS)
>   		return NULL;
>   
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
