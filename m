Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFACAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:43:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82F21218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WinqNrlN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F21218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FShLh2cwaSl89fEFrN1tpJODzx4Adobvi512KHzecRU=; b=WinqNrlNfkPbUA
	N8A2Rc+eiSS1FdtJJ+iNGi9BEA2b7pPkld2c0jAHLOA3IgPeBnd8K1dGP3v3WiVXOvMXjUQYWNGiC
	Kg79ro8l+GJq+HGjPuIvZZ0eZxFlIlyEZHX3uc0fdLZWrkeILxvNo9Hduv120YRYO65limdlK9tvu
	AGiqScHQGSpsViptudHPH5iIHTYmr5+i7f4T/s8lBPcpcJAivJdI1BBceL1IYT4NBGcEWFzfnAyva
	eFNpUGohPUK64P/jj+bnOgzmVA5rBxywSYp5UXODwBu3fGwCBIsXC1jw0wAcahWxmaK8Qd3qZ+Oc9
	S3TaV3IQSVwuYL3NvOLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gynJR-0005Gv-JF; Wed, 27 Feb 2019 00:43:05 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gynJO-0005GH-3w
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 00:43:03 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id F243E80CD;
 Wed, 27 Feb 2019 00:43:09 +0000 (UTC)
Date: Tue, 26 Feb 2019 16:42:55 -0800
From: Tony Lindgren <tony@atomide.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] Revert "dma-contiguous: do not allocate a single page
 from CMA area"
Message-ID: <20190227004255.GG39872@atomide.com>
References: <20190226202327.5349-1-nicoleotsuka@gmail.com>
 <1a3af95a-6e08-01fa-e4ef-07c1c1b6db69@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1a3af95a-6e08-01fa-e4ef-07c1c1b6db69@arm.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_164302_198334_4F47CC92 
X-CRM114-Status: GOOD (  12.01  )
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
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, sre@kernel.org,
 Nicolin Chen <nicoleotsuka@gmail.com>, tomi.valkeinen@ti.com,
 laurent.pinchart@ideasonboard.com, linux-omap@vger.kernel.org, hch@lst.de,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Robin Murphy <robin.murphy@arm.com> [190226 23:36]:
> On 2019-02-26 8:23 pm, Nicolin Chen wrote:
> > This reverts commit d222e42e88168fd67e6d131984b86477af1fc256.
> > 
> > The original change breaks omap dss:
> >      omapdss_dispc 58001000.dispc:
> >          dispc_errata_i734_wa_init: dma_alloc_writecombine failed
> > 
> > Let's revert it first and then find a safer solution instead.

Sounds like a good idea since we're only have few days left
before the merge window.

> Ah, I think I see the problem - once arch/arm's __dma_alloc() has decided to
> use CMA (because dev_get_cma_area(dev) returns the global area), it then
> won't fall back to trying a regular page allocation if
> dma_alloc_from_contiguous() returns NULL. Thus anything on 32-bit Arm trying
> to allocate a single-page buffer in blockable context with a CMA-enabled
> config is just going to fail. Similarly, it looks like none of the
> DMA_ATTR_FORCE_CONTIGUOUS cases are prepared to handle this change either
> (amd_iommu appears technically affected, but is already using
> dma_alloc_from_contiguous() backwards compared to everyone else, hmm).
> 
> I guess the question is whether to add alloc_page()/free_page() fallbacks to
> those call sites, or stuff them directly into the CMA helpers here.

Well if you come up with some test patch, I can easily test it :)

> > Would you please test and verify? Thanks!

Yes this revert works for me:

Tested-by: Tony Lindgren <tony@atomide.com>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
