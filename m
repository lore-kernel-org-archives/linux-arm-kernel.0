Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67841C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:40:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 342FC21874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zx8bigh+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVHBNgit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342FC21874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Yd+UPr5eMcp/GpKWUAgENAPBt3YorIgV3gyuAOOT1TU=; b=Zx8bigh+QhVGkl
	lr/SodlAPOTQd5Xmgyl6hnQSjDaVfS85vPLBIwpxbeiF6WnuCwuHd9S0KhtFNis6pPqGr3iqa5h8Y
	FftI09Yf+NXNYq4vUYMmEsl/KnUKQb9e5phgQDx4aN87b+TYNLm+YYAcKRlV9PRY2FnmnEo4IPKCG
	U11BWJwbjklCU7oa2bUQzGA//PkFi34fG+9CwCcWLA2R8YKRUqDvJ+FysGh5QLSlK8wFvV1E/ujf2
	5nO5uSL6UgdaGMmAwJLP2qACzMYMbu4gz1FqXSjh+Z79zSk3kVrDds1c3CEc1LoIWLJxmmmVJVU/y
	EyzhHwfqBTE9bacvDFDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfOlw-00057N-GH; Fri, 04 Jan 2019 12:40:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfOlt-00055m-6Y; Fri, 04 Jan 2019 12:40:18 +0000
Received: from localhost (unknown [171.76.109.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 698EA21871;
 Fri,  4 Jan 2019 12:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546605614;
 bh=hF2imHRmRVa4hohWZd0oeeeoZD7AkFa74s0AOUjVqHY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qVHBNgit3oF3Pp1nAd3FQe2IN3pMtMaQdv8osfozcqtJ47dqquyGEig8FYRw42dgz
 3d3lzosYYe7HrNJAaGo1G5Eli+69QPkoaFFn/58sd3Z9lj4hQssdWaPH9c8sYOclTq
 yQR1BOl4Xs3Yl6OL400KR/hrx7HoGfsj1mry/YHw=
Date: Fri, 4 Jan 2019 18:08:36 +0530
From: Vinod Koul <vkoul@kernel.org>
To: shun-chih.yu@mediatek.com
Subject: Re: [PATCH 2/2] dmaengine: mediatek: Add MediaTek Command-Queue DMA
 controller for MT6765 SoC
Message-ID: <20190104123836.GB13372@vkoul-mobl.Dlink>
References: <1545916258-18218-1-git-send-email-shun-chih.yu@mediatek.com>
 <1545916258-18218-3-git-send-email-shun-chih.yu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545916258-18218-3-git-send-email-shun-chih.yu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_044017_282668_9D5E5309 
X-CRM114-Status: GOOD (  20.13  )
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
 dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 27-12-18, 21:10, shun-chih.yu@mediatek.com wrote:
> From: Shun-Chih Yu <shun-chih.yu@mediatek.com>
> 

This should be v4 of the patch series, why is it not tagged so?

> MediaTek Command-Queue DMA controller (CQDMA) on MT6765 SoC is dedicated
> to memory-to-memory transfer through queue based descriptor management.

Have you tested this with dmatest, if so can you provide results of the
test as well.

> There are only 3 physical channels inside CQDMA, while the driver is
> extended to support 32 virtual channels for multiple dma users to issue
> dma requests onto the CQDMA simultaneously.
> 
> Change-Id: I1e8d116c5ecbbc49190ffc925cb59a0d035d886b

Please remove this from upstream, checkpatch would have warned that!

> Signed-off-by: Shun-Chih Yu <shun-chih.yu@mediatek.com>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>

This is _WRONG_ I have never provided such tag, can you explain why this
was added without my approval?

>  	  This controller provides the channels which is dedicated to
>  	  memory-to-memory transfer to offload from CPU through ring-
>  	  based descriptor management.
> +
> +config MTK_CQDMA
> +	tristate "MediaTek Command-Queue DMA controller support"

Am not sure if I asked this earlier but, what is difference with HSDMA?

> +/**
> + * struct mtk_cqdma_pchan - The struct holding info describing physical
> + *                         channel (PC)
> + * @queue:                 Queue for the CVDs issued to this PC
> + * @base:                  The mapped register I/O base of this PC
> + * @irq:                   The IRQ that this PC are using
> + * @refcnt:                Track how many VCs are using this PC
> + * @lock:                 Lock protect agaisting multiple VCs access PC

Please maintain alignment!

> + */
> +struct mtk_cqdma_pchan {
> +	struct list_head queue;
> +	void __iomem *base;
> +	u32 irq;
> +	refcount_t refcnt;
> +
> +	/* lock to protect PC */

This is not required, you already have above !

> +	spinlock_t lock;
> +};
> +
> +/**
> + * struct mtk_cqdma_vchan - The struct holding info describing virtual
> + *                         channel (VC)
> + * @vc:                    An instance for struct virt_dma_chan
> + * @pc:                    The pointer to the underlying PC
> + * @issue_completion:	   The wait for all issued descriptors completited

typo completited , am not sure why you need this

> +static void mtk_dma_write(struct mtk_cqdma_pchan *pc, u32 reg, u32 val)
> +{
> +	writel_relaxed(val, pc->base + reg);

Why is it relaxed one?

> +static void mtk_cqdma_consume_work_queue(struct mtk_cqdma_pchan *pc)
> +{
> +	struct mtk_cqdma_vchan *cvc;
> +	struct mtk_cqdma_vdesc *cvd;
> +	size_t tlen;
> +
> +	/* consume a CVD from PC's queue */
> +	cvd = list_first_entry_or_null(&pc->queue,
> +				       struct mtk_cqdma_vdesc, node);

you can use vchan_next_desc() and also remove your own queue as
virt-desc already implements that logic!

> +	if (unlikely(!cvd))
> +		return;
> +
> +	cvc = to_cqdma_vchan(cvd->ch);
> +
> +	tlen = (cvd->len < MTK_CQDMA_MAX_LEN) ? cvd->len : MTK_CQDMA_MAX_LEN;
> +	cvd->len -= tlen;
> +	cvd->src += tlen;
> +	cvd->dest += tlen;
> +
> +	/* check whether the CVD completed */
> +	if (!cvd->len) {
> +		/* delete CVD from PC's queue */
> +		list_del(&cvd->node);
> +
> +		spin_lock(&cvc->vc.lock);
> +
> +		/* add the VD into list desc_completed */
> +		vchan_cookie_complete(&cvd->vd);
> +
> +		/* setup completion if this VC is under synchronization */
> +		if (cvc->issue_synchronize && !mtk_cqdma_is_vchan_active(cvc)) {
> +			complete(&cvc->issue_completion);
> +			cvc->issue_synchronize = false;
> +		}

why do you need your own completion?

> +
> +		spin_unlock(&cvc->vc.lock);
> +	}
> +
> +	/* iterate on the next CVD if the current CVD completed */
> +	if (!cvd->len)
> +		cvd = list_first_entry_or_null(&pc->queue,
> +					       struct mtk_cqdma_vdesc, node);
> +
> +	/* start the next transaction */
> +	if (cvd)
> +		mtk_cqdma_start(pc, cvd);

most of this logic looks reduandant to me. Virt-dma was designed to do
exactly this, have N physical channels and share with M virt channels.
Please reuse and remove code from this driver.

> +static struct virt_dma_desc *mtk_cqdma_find_active_desc(struct dma_chan *c,
> +							dma_cookie_t cookie)
> +{
> +	struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
> +	struct virt_dma_desc *vd;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&cvc->pc->lock, flags);
> +	list_for_each_entry(vd, &cvc->pc->queue, node)
> +		if (vd->tx.cookie == cookie) {
> +			spin_unlock_irqrestore(&cvc->pc->lock, flags);
> +			return vd;
> +		}
> +	spin_unlock_irqrestore(&cvc->pc->lock, flags);
> +
> +	list_for_each_entry(vd, &cvc->vc.desc_issued, node)
> +		if (vd->tx.cookie == cookie)
> +			return vd;

vchan_find_desc() ??

> +static enum dma_status mtk_cqdma_tx_status(struct dma_chan *c,
> +					   dma_cookie_t cookie,
> +					   struct dma_tx_state *txstate)
> +{
> +	struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
> +	struct mtk_cqdma_vdesc *cvd;
> +	struct virt_dma_desc *vd;
> +	enum dma_status ret;
> +	unsigned long flags;
> +	size_t bytes = 0;
> +
> +	ret = dma_cookie_status(c, cookie, txstate);
> +	if (ret == DMA_COMPLETE || !txstate)
> +		return ret;
> +
> +	spin_lock_irqsave(&cvc->vc.lock, flags);
> +	vd = mtk_cqdma_find_active_desc(c, cookie);
> +	spin_unlock_irqrestore(&cvc->vc.lock, flags);
> +
> +	if (vd) {
> +		cvd = to_cqdma_vdesc(vd);
> +		bytes = cvd->len;
> +	}
> +
> +	dma_set_residue(txstate, bytes);

Have you tested this and are able to report residue properly?

> +static void mtk_cqdma_free_inactive_desc(struct dma_chan *c)
> +{
> +	struct virt_dma_chan *vc = to_virt_chan(c);
> +	unsigned long flags;
> +	LIST_HEAD(head);
> +
> +	/*
> +	 * set desc_allocated, desc_submitted,
> +	 * and desc_issued as the candicates to be freed
> +	 */
> +	spin_lock_irqsave(&vc->lock, flags);
> +	list_splice_tail_init(&vc->desc_allocated, &head);
> +	list_splice_tail_init(&vc->desc_submitted, &head);
> +	list_splice_tail_init(&vc->desc_issued, &head);

You missed completed and didnt use vchan_get_all_descriptors() ??


Looking at the driver, I feel things have been complicated a bit, you
can reuse more code and routines in vchan layer and remove driver
handling and make things with less bugs (used more tested generic code)
and simpler to review ..

Please do so in next rev and tag version properly!

-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
