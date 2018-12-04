Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539C7C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:41:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A47206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ud26BbYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A47206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q0nVHRp2PiLNeoEhI9P0gMhGef01AZ0d7hN4CPwxyKA=; b=Ud26BbYd0K1thj
	DudHuk/9PyRbt88H/wNPJWM8Ot4lkHlML+79KdNq/M2Cr2SWFRC/VgfJ5kGf+KMtx2LHrgfBPliHh
	8PFYvAW7Yw8JBKOgA2Eca/p+/tA89+yPBg0KOO9v8KLWvwmV3xAqulxaITzk2eOxNx+7c/XEaAy7Q
	VMRZp9AERu4uXsDbRnqldNn6PSMoVoz2NUPxKWkut2rT+px0EjG/S3IWb1iw5zJAfcmIGm2+MAk0Y
	ccbv9KXVM9a4xRuXf/6c/gp0AtPDSmb7NSPXV9RtBkc5cV4C6LumnVtQTof9SGdu3D65tcl8Jmsbv
	dMRRVENi77+WNRSyApAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUDlU-0006I8-4k; Tue, 04 Dec 2018 16:41:40 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUDlN-0006HA-8m
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 16:41:38 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A52CA78;
 Tue,  4 Dec 2018 08:41:22 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 28F673F614;
 Tue,  4 Dec 2018 08:41:22 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 862C81AE0BA0; Tue,  4 Dec 2018 16:41:42 +0000 (GMT)
Date: Tue, 4 Dec 2018 16:41:42 +0000
From: Will Deacon <will.deacon@arm.com>
To: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH v3, RFC] iommu/io-pgtable-arm-v7s: Use page_frag to
 request DMA32 memory
Message-ID: <20181204164142.GA8520@arm.com>
References: <20181204082300.95106-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181204082300.95106-1-drinkcat@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_084133_363008_EAE255BC 
X-CRM114-Status: GOOD (  24.33  )
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
Cc: hch@infradead.org, Michal Hocko <mhocko@suse.com>,
 Tomasz Figa <tfiga@google.com>, Joerg Roedel <joro@8bytes.org>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 Yong Wu <yong.wu@mediatek.com>, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
 Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com,
 Christoph Lameter <cl@linux.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 04, 2018 at 04:23:00PM +0800, Nicolas Boichat wrote:
> IOMMUs using ARMv7 short-descriptor format require page tables
> (level 1 and 2) to be allocated within the first 4GB of RAM, even
> on 64-bit systems.
> 
> For level 1/2 tables, ensure GFP_DMA32 is used if CONFIG_ZONE_DMA32
> is defined (e.g. on arm64 platforms).
> 
> For level 2 tables (1 KB), we use page_frag to allocate these pages,
> as we cannot directly use kmalloc (no slab cache for GFP_DMA32) or
> kmem_cache (mm/ code treats GFP_DMA32 as an invalid flag).
> 
> One downside is that we only free the allocated page if all the
> 4 fragments (4 IOMMU L2 tables) are freed, but given that we
> usually only allocate limited number of IOMMU L2 tables, this
> should not have too much impact on memory usage: In the absolute
> worst case (4096 L2 page tables, each on their own 4K page),
> we would use 16 MB of memory for 4 MB of L2 tables.
> 
> Also, print an error when the physical address does not fit in
> 32-bit, to make debugging easier in the future.
> 
> Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
> 
> As an alternative to the series [1], which adds support for GFP_DMA32
> to kmem_cache in mm/. IMHO the solution in [1] is cleaner and more
> efficient, as it allows freed fragments (L2 tables) to be reused, but
> this approach does not require any core change.
> 
> [1] https://patchwork.kernel.org/cover/10677529/, 3 patches
> 
>  drivers/iommu/io-pgtable-arm-v7s.c | 32 ++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index 445c3bde04800c..0de6a51eb6755f 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -161,6 +161,12 @@
>  
>  #define ARM_V7S_TCR_PD1			BIT(5)
>  
> +#ifdef CONFIG_ZONE_DMA32
> +#define ARM_V7S_TABLE_GFP_DMA GFP_DMA32
> +#else
> +#define ARM_V7S_TABLE_GFP_DMA GFP_DMA
> +#endif

We may as well include __GFP_ZERO in here too.
Anyway, this looks alright to me:

Acked-by: Will Deacon <will.deacon@arm.com>

But it sounds like you're still on the fence about this patch, so I won't
pick it up unless you ask explicitly.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
