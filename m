Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC32C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:20:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9F4220850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AJ4FkY3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F4220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hDGvABOuBaVIeFjoqU1cIBL7ah6zLrJncT8ol0q7vOg=; b=AJ4FkY3fPB1UbH
	keZGsg2QF/0UF24x2x++roDCz9tT7LmStodfbHFjEjduK2K3CL4aRsNupZyoMfK+QcOntyJcIzcvU
	kE2SXl16YggHKUFfGfm1uSG6YVtU64aBkR7yxGFZdxJYzqp0UW/bYYvLWyDCAkQmMI30FbEAOSAaz
	oya39ZoHAuswWQh+L7hEF8ic+j5f25fxZ4ig9jWA25tDmnovo4ij5/fjd7PL4pvynqsoTJuUm09cO
	QYNbEVHpTMGr+XBijvE/fCLT9FXf0DGt1zUhD/GaPStfu6XjLJsx2hfmDLVjFG2RguZ3NuDDHVYKj
	qsdGSqPvGqzrQazEhm7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggqMQ-0004ce-If; Tue, 08 Jan 2019 12:19:58 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggqMM-0004br-0Y; Tue, 08 Jan 2019 12:19:55 +0000
X-UUID: 2f41445348f846848bccff774c469d52-20190108
X-UUID: 2f41445348f846848bccff774c469d52-20190108
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <shun-chih.yu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 223682836; Tue, 08 Jan 2019 04:19:47 -0800
Received: from MTKMBS01N2.mediatek.inc (172.21.101.79) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 8 Jan 2019 04:19:46 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 8 Jan 2019 20:19:44 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 8 Jan 2019 20:19:44 +0800
Message-ID: <1546949984.25257.96.camel@mtkswgap22>
Subject: Re: [PATCH 2/2] dmaengine: mediatek: Add MediaTek Command-Queue DMA
 controller for MT6765 SoC
From: Shun-Chih.Yu <shun-chih.yu@mediatek.com>
To: Vinod Koul <vkoul@kernel.org>
Date: Tue, 8 Jan 2019 20:19:44 +0800
In-Reply-To: <20190104123836.GB13372@vkoul-mobl.Dlink>
References: <1545916258-18218-1-git-send-email-shun-chih.yu@mediatek.com>
 <1545916258-18218-3-git-send-email-shun-chih.yu@mediatek.com>
 <20190104123836.GB13372@vkoul-mobl.Dlink>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 22FDBF553B484EE4BD51183E7AA607E8002825509AFF949B5A12C1BCCFC84A912000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_041954_071845_8BF53A22 
X-CRM114-Status: GOOD (  31.16  )
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

On Fri, 2019-01-04 at 18:08 +0530, Vinod Koul wrote:
> On 27-12-18, 21:10, shun-chih.yu@mediatek.com wrote:
> > From: Shun-Chih Yu <shun-chih.yu@mediatek.com>
> > 
> 
> This should be v4 of the patch series, why is it not tagged so?
I would tag properly in the next revision.

> > MediaTek Command-Queue DMA controller (CQDMA) on MT6765 SoC is dedicated
> > to memory-to-memory transfer through queue based descriptor management.
> 
> Have you tested this with dmatest, if so can you provide results of the
> test as well.
Yes, I tested with dmatest in multi-thread version. 
The results shown below, and I would attach them in the next revision if needed.

dmatest: dma0chan0-copy2: summary 5000 tests, 0 failures 3500 iops 28037
KB/s (0)
dmatest: dma0chan0-copy4: summary 5000 tests, 0 failures 3494 iops 27612
KB/s (0)
dmatest: dma0chan0-copy1: summary 5000 tests, 0 failures 3491 iops 27749
KB/s (0)
dmatest: dma0chan0-copy7: summary 5000 tests, 0 failures 3673 iops 29092
KB/s (0)
dmatest: dma0chan0-copy6: summary 5000 tests, 0 failures 3763 iops 30237
KB/s (0)
dmatest: dma0chan0-copy0: summary 5000 tests, 0 failures 3730 iops 30131
KB/s (0)
dmatest: dma0chan0-copy3: summary 5000 tests, 0 failures 3717 iops 29569
KB/s (0)
dmatest: dma0chan0-copy5: summary 5000 tests, 0 failures 3699 iops 29302
KB/s (0)


> > There are only 3 physical channels inside CQDMA, while the driver is
> > extended to support 32 virtual channels for multiple dma users to issue
> > dma requests onto the CQDMA simultaneously.
> > 
> > Change-Id: I1e8d116c5ecbbc49190ffc925cb59a0d035d886b
> 
> Please remove this from upstream, checkpatch would have warned that!
I would remove it and be more careful about this.

> > Signed-off-by: Shun-Chih Yu <shun-chih.yu@mediatek.com>
> > Reviewed-by: Vinod Koul <vkoul@kernel.org>
> 
> This is _WRONG_ I have never provided such tag, can you explain why this
> was added without my approval?
So sorry about this, I misunderstood the usage of reviewed-by tag and I
would remove this. Thanks for pointing out this mistake.

> >  	  This controller provides the channels which is dedicated to
> >  	  memory-to-memory transfer to offload from CPU through ring-
> >  	  based descriptor management.
> > +
> > +config MTK_CQDMA
> > +	tristate "MediaTek Command-Queue DMA controller support"
> 
> Am not sure if I asked this earlier but, what is difference with HSDMA?
They are different in hardware design.
For example, HSDMA has ring-based descriptor management, while CQDMA only has
one descriptor.

> > +/**
> > + * struct mtk_cqdma_pchan - The struct holding info describing physical
> > + *                         channel (PC)
> > + * @queue:                 Queue for the CVDs issued to this PC
> > + * @base:                  The mapped register I/O base of this PC
> > + * @irq:                   The IRQ that this PC are using
> > + * @refcnt:                Track how many VCs are using this PC
> > + * @lock:                 Lock protect agaisting multiple VCs access PC
> 
> Please maintain alignment!
Sure, I would fix this.

> > + */
> > +struct mtk_cqdma_pchan {
> > +	struct list_head queue;
> > +	void __iomem *base;
> > +	u32 irq;
> > +	refcount_t refcnt;
> > +
> > +	/* lock to protect PC */
> 
> This is not required, you already have above !
Sure, I would remove this.

> > +	spinlock_t lock;
> > +};
> > +
> > +/**
> > + * struct mtk_cqdma_vchan - The struct holding info describing virtual
> > + *                         channel (VC)
> > + * @vc:                    An instance for struct virt_dma_chan
> > + * @pc:                    The pointer to the underlying PC
> > + * @issue_completion:	   The wait for all issued descriptors completited
> 
> typo completited , am not sure why you need this
> 
This completion should be redundant and would be removed in the next
revision.

> > +static void mtk_dma_write(struct mtk_cqdma_pchan *pc, u32 reg, u32 val)
> > +{
> > +	writel_relaxed(val, pc->base + reg);
> 
> Why is it relaxed one?
Most of the operations to the CQDMA hardware could be relaxed, and the 

> > +static void mtk_cqdma_consume_work_queue(struct mtk_cqdma_pchan *pc)
> > +{
> > +	struct mtk_cqdma_vchan *cvc;
> > +	struct mtk_cqdma_vdesc *cvd;
> > +	size_t tlen;
> > +
> > +	/* consume a CVD from PC's queue */
> > +	cvd = list_first_entry_or_null(&pc->queue,
> > +				       struct mtk_cqdma_vdesc, node);
> 
> you can use vchan_next_desc() and also remove your own queue as
> virt-desc already implements that logic!
This logic would be simplified and the queue would be removed in next revision.

> > +	if (unlikely(!cvd))
> > +		return;
> > +
> > +	cvc = to_cqdma_vchan(cvd->ch);
> > +
> > +	tlen = (cvd->len < MTK_CQDMA_MAX_LEN) ? cvd->len : MTK_CQDMA_MAX_LEN;
> > +	cvd->len -= tlen;
> > +	cvd->src += tlen;
> > +	cvd->dest += tlen;
> > +
> > +	/* check whether the CVD completed */
> > +	if (!cvd->len) {
> > +		/* delete CVD from PC's queue */
> > +		list_del(&cvd->node);
> > +
> > +		spin_lock(&cvc->vc.lock);
> > +
> > +		/* add the VD into list desc_completed */
> > +		vchan_cookie_complete(&cvd->vd);
> > +
> > +		/* setup completion if this VC is under synchronization */
> > +		if (cvc->issue_synchronize && !mtk_cqdma_is_vchan_active(cvc)) {
> > +			complete(&cvc->issue_completion);
> > +			cvc->issue_synchronize = false;
> > +		}
> 
> why do you need your own completion?
> 
This completion should be redundant and would be removed in the next
revision.
> > +
> > +		spin_unlock(&cvc->vc.lock);
> > +	}
> > +
> > +	/* iterate on the next CVD if the current CVD completed */
> > +	if (!cvd->len)
> > +		cvd = list_first_entry_or_null(&pc->queue,
> > +					       struct mtk_cqdma_vdesc, node);
> > +
> > +	/* start the next transaction */
> > +	if (cvd)
> > +		mtk_cqdma_start(pc, cvd);
> 
> most of this logic looks reduandant to me. Virt-dma was designed to do
> exactly this, have N physical channels and share with M virt channels.
> Please reuse and remove code from this driver.
> 
I would re-factor this part for reuse on virt-dma and remove redundant
code.
> > +static struct virt_dma_desc *mtk_cqdma_find_active_desc(struct dma_chan *c,
> > +							dma_cookie_t cookie)
> > +{
> > +	struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
> > +	struct virt_dma_desc *vd;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&cvc->pc->lock, flags);
> > +	list_for_each_entry(vd, &cvc->pc->queue, node)
> > +		if (vd->tx.cookie == cookie) {
> > +			spin_unlock_irqrestore(&cvc->pc->lock, flags);
> > +			return vd;
> > +		}
> > +	spin_unlock_irqrestore(&cvc->pc->lock, flags);
> > +
> > +	list_for_each_entry(vd, &cvc->vc.desc_issued, node)
> > +		if (vd->tx.cookie == cookie)
> > +			return vd;
> 
> vchan_find_desc() ??
> 
This logic could be replaced with vchan_find_desc(), and I will fix in
the next revision.
> > +static enum dma_status mtk_cqdma_tx_status(struct dma_chan *c,
> > +					   dma_cookie_t cookie,
> > +					   struct dma_tx_state *txstate)
> > +{
> > +	struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
> > +	struct mtk_cqdma_vdesc *cvd;
> > +	struct virt_dma_desc *vd;
> > +	enum dma_status ret;
> > +	unsigned long flags;
> > +	size_t bytes = 0;
> > +
> > +	ret = dma_cookie_status(c, cookie, txstate);
> > +	if (ret == DMA_COMPLETE || !txstate)
> > +		return ret;
> > +
> > +	spin_lock_irqsave(&cvc->vc.lock, flags);
> > +	vd = mtk_cqdma_find_active_desc(c, cookie);
> > +	spin_unlock_irqrestore(&cvc->vc.lock, flags);
> > +
> > +	if (vd) {
> > +		cvd = to_cqdma_vdesc(vd);
> > +		bytes = cvd->len;
> > +	}
> > +
> > +	dma_set_residue(txstate, bytes);
> 
> Have you tested this and are able to report residue properly?
> 
I tested and thought the residue report properly. But after checking the
definition of residue in tx_status again, I found that should be always
return 0 in the driver instead, since there is no state DMA_IN_PROGRESS
or DMA_PAUSED in the driver. I would fix this in the next revision.

> > +static void mtk_cqdma_free_inactive_desc(struct dma_chan *c)
> > +{
> > +	struct virt_dma_chan *vc = to_virt_chan(c);
> > +	unsigned long flags;
> > +	LIST_HEAD(head);
> > +
> > +	/*
> > +	 * set desc_allocated, desc_submitted,
> > +	 * and desc_issued as the candicates to be freed
> > +	 */
> > +	spin_lock_irqsave(&vc->lock, flags);
> > +	list_splice_tail_init(&vc->desc_allocated, &head);
> > +	list_splice_tail_init(&vc->desc_submitted, &head);
> > +	list_splice_tail_init(&vc->desc_issued, &head);
> 
> You missed completed and didnt use vchan_get_all_descriptors() ??
> 
I missed desc_completed when I tried to move desc_completed into
mtk_cqdma_free_active_desc, yet this logic should be simplified in the
next revision. The separation on free_active_desc and free_inactive_desc
seems no necessary, and I would merge them and use
vchan_get_all_descriptors only.
> 
> Looking at the driver, I feel things have been complicated a bit, you
> can reuse more code and routines in vchan layer and remove driver
> handling and make things with less bugs (used more tested generic code)
> and simpler to review ..
> 
> Please do so in next rev and tag version properly!
> 
Yes, the current implementation should be further simplified and
leverage much more code and routines in vchan layer, I am working on the
next patch and making sure all of them fixed in the next revision.
Thanks for your valuable review and sorry for the misuse on the review
tag, 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
