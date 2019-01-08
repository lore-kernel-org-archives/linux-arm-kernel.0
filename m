Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C7BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:01:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F1A2173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cj/7D/Dc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVH07tF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F1A2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y2QvA9R9j4q5x+oXJ+fQHT4z/GZsNIWA5Sup/GjtRY4=; b=Cj/7D/Dcf0EfrG
	jd3AkuaiALhDLC9R4ZbFBcZANgYOxRTmKYbKOQ+NIyTFMcDWM2QyMX8yfgwmBEoqN/BMfasEhdB4U
	U3ZCLZ4ZmKEUGR67E5nfEQ6xLfntUEcDg0TD4hyUkInoG2RRFubhrnpZsIN9WjC78xFSEvhBLgLkJ
	TCAfUEsmK1QalxPiory7W8vw0XnvVm0mdc3YXNWCf7eAAtDOnaE4S7VU4GMTnWDpqk34tGOgipd8H
	6aD9+cYaex8tl6G/ytCgIb64CX3pvUs9OXFmrSccx0IxPZ3oOWC+/WJ98XcAyQaMVVI7agIw+c7Qt
	58Z7VgBTXNwjsoruTYMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggukq-0006wr-GA; Tue, 08 Jan 2019 17:01:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggukm-0006wH-Gn; Tue, 08 Jan 2019 17:01:26 +0000
Received: from localhost (unknown [171.76.109.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C564C20827;
 Tue,  8 Jan 2019 17:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546966883;
 bh=ZRtsnS+5LBwEuU4GkKiAOJXa+BwPlS5MtTkpo09pNPE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qVH07tF8I4q5dXW82bQCSPyJD92jXj539t+sMbLkGDXL8NEzHmxbiSIbZJz7pKug9
 MkxkXF7uiRt02cyDPpcIiakHk/TuNSTlAr7QZqOLuYOe0zSvB7tx4+mFGChA72WOmG
 nJYAOaVyLBDtWO4qg/mwAC078DTWF7aBVSi5JNCg=
Date: Tue, 8 Jan 2019 22:29:46 +0530
From: Vinod Koul <vkoul@kernel.org>
To: "Shun-Chih.Yu" <shun-chih.yu@mediatek.com>
Subject: Re: [PATCH 2/2] dmaengine: mediatek: Add MediaTek Command-Queue DMA
 controller for MT6765 SoC
Message-ID: <20190108165946.GQ13372@vkoul-mobl.Dlink>
References: <1545916258-18218-1-git-send-email-shun-chih.yu@mediatek.com>
 <1545916258-18218-3-git-send-email-shun-chih.yu@mediatek.com>
 <20190104123836.GB13372@vkoul-mobl.Dlink>
 <1546949984.25257.96.camel@mtkswgap22>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546949984.25257.96.camel@mtkswgap22>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_090124_588559_1E7235E0 
X-CRM114-Status: GOOD (  19.17  )
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
Cc: devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
 linux-kernel@vger.kernel.org, srv_wsdupstream@mediatek.com,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, dmaengine@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 08-01-19, 20:19, Shun-Chih.Yu wrote:
> On Fri, 2019-01-04 at 18:08 +0530, Vinod Koul wrote:
> > On 27-12-18, 21:10, shun-chih.yu@mediatek.com wrote:
> > > From: Shun-Chih Yu <shun-chih.yu@mediatek.com>

> > Have you tested this with dmatest, if so can you provide results of the
> > test as well.
> Yes, I tested with dmatest in multi-thread version. 
> The results shown below, and I would attach them in the next revision if needed.
> 
> dmatest: dma0chan0-copy2: summary 5000 tests, 0 failures 3500 iops 28037
> KB/s (0)
> dmatest: dma0chan0-copy4: summary 5000 tests, 0 failures 3494 iops 27612
> KB/s (0)
> dmatest: dma0chan0-copy1: summary 5000 tests, 0 failures 3491 iops 27749
> KB/s (0)
> dmatest: dma0chan0-copy7: summary 5000 tests, 0 failures 3673 iops 29092
> KB/s (0)
> dmatest: dma0chan0-copy6: summary 5000 tests, 0 failures 3763 iops 30237
> KB/s (0)
> dmatest: dma0chan0-copy0: summary 5000 tests, 0 failures 3730 iops 30131
> KB/s (0)
> dmatest: dma0chan0-copy3: summary 5000 tests, 0 failures 3717 iops 29569
> KB/s (0)
> dmatest: dma0chan0-copy5: summary 5000 tests, 0 failures 3699 iops 29302
> KB/s (0)

Having them in cover letter helps :)

> > > Signed-off-by: Shun-Chih Yu <shun-chih.yu@mediatek.com>
> > > Reviewed-by: Vinod Koul <vkoul@kernel.org>
> > 
> > This is _WRONG_ I have never provided such tag, can you explain why this
> > was added without my approval?
> So sorry about this, I misunderstood the usage of reviewed-by tag and I
> would remove this. Thanks for pointing out this mistake.

This tag should be added _only_ when someone replies with
Reviewed-by: ..., same goes for Acked-by and Tested-by: ... etc

> > > +static void mtk_dma_write(struct mtk_cqdma_pchan *pc, u32 reg, u32 val)
> > > +{
> > > +	writel_relaxed(val, pc->base + reg);
> > 
> > Why is it relaxed one?
> Most of the operations to the CQDMA hardware could be relaxed, and the 

looks like you missed the rest of sentence

> > > +static enum dma_status mtk_cqdma_tx_status(struct dma_chan *c,
> > > +					   dma_cookie_t cookie,
> > > +					   struct dma_tx_state *txstate)
> > > +{
> > > +	struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
> > > +	struct mtk_cqdma_vdesc *cvd;
> > > +	struct virt_dma_desc *vd;
> > > +	enum dma_status ret;
> > > +	unsigned long flags;
> > > +	size_t bytes = 0;
> > > +
> > > +	ret = dma_cookie_status(c, cookie, txstate);
> > > +	if (ret == DMA_COMPLETE || !txstate)
> > > +		return ret;
> > > +
> > > +	spin_lock_irqsave(&cvc->vc.lock, flags);
> > > +	vd = mtk_cqdma_find_active_desc(c, cookie);
> > > +	spin_unlock_irqrestore(&cvc->vc.lock, flags);
> > > +
> > > +	if (vd) {
> > > +		cvd = to_cqdma_vdesc(vd);
> > > +		bytes = cvd->len;
> > > +	}
> > > +
> > > +	dma_set_residue(txstate, bytes);
> > 
> > Have you tested this and are able to report residue properly?
> > 
> I tested and thought the residue report properly. But after checking the
> definition of residue in tx_status again, I found that should be always
> return 0 in the driver instead, since there is no state DMA_IN_PROGRESS
> or DMA_PAUSED in the driver. I would fix this in the next revision.

So memcpy is quite fast :D, that's why. This is more helpful in
slave-dma which is relatively slow :)

-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
