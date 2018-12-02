Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C8DC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 12:43:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A7A2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 12:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="giqSv12m";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvMrjOsP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A7A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darnok.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4bNZcLNP0TMhImpebwFbkMzNIUVItfJbUI+Z9CcHQpE=; b=giqSv12m0i6DC7
	+uMMxi0UWcyNweAot1XCUWoGBihVbkWT2yAWX8y7Vl21smkfbAaDAIqAMKsYENnOgaEBVwkCIrKKS
	lA+QbhmbEZCdF+GfpX4QT4yz1R6WJLR0D8gKWifju+3KOFU4FIjPu0i6fCCvm5RWi/kmphZCbgz5E
	70J0+jNdE6xViNa+FeSVBeZGUX8icK5EKPtkFCSCmQXvS43Y3qiP6LCmo9D85Z1/ZIIky0r/Wqsgu
	3bSZq1ftiPE6LJlEUUN8bo0fB9h/lnCtJE2wsnO4HdG6ZfS9+/BNvBp42XI6hjnWZLTnOukDw34wC
	RAkWWAHwNivGoa9ZroFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTR5S-00028p-Bg; Sun, 02 Dec 2018 12:43:02 +0000
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTR5O-00027w-Fl
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 12:42:59 +0000
Received: by mail-qt1-x843.google.com with SMTP id y20so10836020qtm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 04:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=lEtZ8HUr5ta3aKPraRuQaLc/uiyvX7GFrTe4WWXumQI=;
 b=nvMrjOsPdkPMzQLlt1gunKPVHCAajsFxx0tWR6GaGF7HBlewscy+eiPaX1SQpZP/nS
 vnhJr27IuE7V4isA7367vYd3vuhRTsll1+3rA5gg8VyHUOcAEUjtBSRVEQw+hZYzgP1t
 UxYBtIpAA5c8k4TEigeoDoqu5fnoWxGrPrm603hx3H2+5NAdttbjdDWgbZsI7ovMhLSR
 l5IbUKsCuCwlMtSDiP4/QAo6BjTwdjHw5Bo8lY5GWkQaBUVmNu1yqTu1S4YXUes+ZsU+
 JE0JiR3PKDnT7okU4ZU17FJmEdzcM2mJAs3I7t5mM82Vcjz1779tMprJlSleWYPdf9xD
 l9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=lEtZ8HUr5ta3aKPraRuQaLc/uiyvX7GFrTe4WWXumQI=;
 b=WWclCS4Qzej0cRXqyenRUgQXCM2fC4sqq0p/N0nBY4N61Uz2ZDOubLEjXr8I5zFhxt
 FjJXqGF4DobFy3lMcdpP+JDhKxMRYjQJFiDzWnEK3COzWrwj9DcCFyRJMaTMVIaap4MQ
 5SSQKclLvZXgiottpWNuazJHQH/GmPzfdYQ9TV0de6p9VLDEwvw73bB5nU1yZNYGLWNl
 gheG5wlilwahVzPoYsh764Q09UUXz3AAxqH7llthgqHh+FgEwp4TfBsZG2I1tPgePaAY
 gLNDqKEFHX5C7vTnrw2KRWIqbq8WSUndBawpvWQ+aftQq11rQqu5QrrXRKDuNkHc5OZJ
 QP3g==
X-Gm-Message-State: AA+aEWZVJY+1fCf5YblcTKRi8EOUnNadRKgXafPicg14j2LDmhonqluD
 rRe6JmmAwGhW6fdEPhk/F1s=
X-Google-Smtp-Source: AFSGD/XJoGLFFla/kAziyV6siowbKNDg2u87EjOALppmCId+LntOL79e/BjjXr0SoIlJXgIs/OJ+yA==
X-Received: by 2002:a05:6214:c7:: with SMTP id
 f7mr12527886qvs.44.1543754566450; 
 Sun, 02 Dec 2018 04:42:46 -0800 (PST)
Received: from localhost.localdomain
 (209-6-36-129.s6527.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com.
 [209.6.36.129])
 by smtp.gmail.com with ESMTPSA id s46sm6666795qtc.63.2018.12.02.04.42.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 02 Dec 2018 04:42:45 -0800 (PST)
Date: Sun, 2 Dec 2018 07:42:42 -0500
From: Konrad Rzeszutek Wilk <konrad@darnok.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 21/23] xen-swiotlb: remove the mapping_error dma_map_ops
 method
Message-ID: <20181202124241.GB3166@localhost.localdomain>
References: <20181130132231.16512-1-hch@lst.de>
 <20181130132231.16512-22-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181130132231.16512-22-hch@lst.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_044258_526535_0DBAEDA2 
X-CRM114-Status: GOOD (  19.14  )
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
Cc: linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jon Mason <jdmason@kudzu.us>, xen-devel@lists.xenproject.org,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 02:22:29PM +0100, Christoph Hellwig wrote:
> Return DMA_MAPPING_ERROR instead of 0 on a dma mapping failure and let
> the core dma-mapping code handle the rest.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Konrad Rzeszutek Wilk <konrad@darnok.org>
> ---
>  drivers/xen/swiotlb-xen.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 2a7f545bd0b5..6dc969d5ea2f 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -53,8 +53,6 @@
>   * API.
>   */
>  
> -#define XEN_SWIOTLB_ERROR_CODE	(~(dma_addr_t)0x0)
> -
>  static char *xen_io_tlb_start, *xen_io_tlb_end;
>  static unsigned long xen_io_tlb_nslabs;
>  /*
> @@ -406,7 +404,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
>  	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys, size, dir,
>  				     attrs);
>  	if (map == SWIOTLB_MAP_ERROR)
> -		return XEN_SWIOTLB_ERROR_CODE;
> +		return DMA_MAPPING_ERROR;
>  
>  	dev_addr = xen_phys_to_bus(map);
>  	xen_dma_map_page(dev, pfn_to_page(map >> PAGE_SHIFT),
> @@ -421,7 +419,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
>  	attrs |= DMA_ATTR_SKIP_CPU_SYNC;
>  	swiotlb_tbl_unmap_single(dev, map, size, dir, attrs);
>  
> -	return XEN_SWIOTLB_ERROR_CODE;
> +	return DMA_MAPPING_ERROR;
>  }
>  
>  /*
> @@ -700,11 +698,6 @@ xen_swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
>  	return dma_common_get_sgtable(dev, sgt, cpu_addr, handle, size, attrs);
>  }
>  
> -static int xen_swiotlb_mapping_error(struct device *dev, dma_addr_t dma_addr)
> -{
> -	return dma_addr == XEN_SWIOTLB_ERROR_CODE;
> -}
> -
>  const struct dma_map_ops xen_swiotlb_dma_ops = {
>  	.alloc = xen_swiotlb_alloc_coherent,
>  	.free = xen_swiotlb_free_coherent,
> @@ -719,5 +712,4 @@ const struct dma_map_ops xen_swiotlb_dma_ops = {
>  	.dma_supported = xen_swiotlb_dma_supported,
>  	.mmap = xen_swiotlb_dma_mmap,
>  	.get_sgtable = xen_swiotlb_get_sgtable,
> -	.mapping_error	= xen_swiotlb_mapping_error,
>  };
> -- 
> 2.19.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
