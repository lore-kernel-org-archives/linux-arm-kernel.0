Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770C5C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:46:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E5421855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pfvvp8Tm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E5421855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Yj3MoQoWMcS9tWKhPEpgh6QLypm61Yh/J27DCh3uPt4=; b=Pfvvp8TmgsAmlj
	rghzE12PLxoPgAn0bQP0OHiRAfRrmmaYVN4+7ZSdFh1n98DS7UR05Qy8uifs9QJwRBwM60g1nFWw6
	LplqWrce5gdwJ4j5loQ8pNejQNpu7fTj5lcoPb72AgUePh78uCfcpKMRwXkEexr5vy1YXtFv63MLc
	Tj5tpbETSNbp9xiK4O8AemJAVImJ3ilostuaela/vxImVcnpT7kTi2jP1O/VoxwGil32a2HFvE+By
	S979kAN0PoyJE/pCDxhypU9JTj0pIXeD/Hz9ZcU5cyGvmXjYzESZwJ6Yyd/k8063hp8DtRbCvseBn
	Ux+vc52Zz9/zNf6b/rcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmcWQ-0001qM-4G; Thu, 24 Jan 2019 10:46:10 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmcWD-0001iL-2G; Thu, 24 Jan 2019 10:46:05 +0000
X-UUID: e220b1f1666644e4ad75a29fae86a138-20190124
X-UUID: e220b1f1666644e4ad75a29fae86a138-20190124
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <shun-chih.yu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 339545451; Thu, 24 Jan 2019 02:45:39 -0800
Received: from MTKMBS02N1.mediatek.inc (172.21.101.77) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 24 Jan 2019 02:45:38 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 24 Jan 2019 18:45:36 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Thu, 24 Jan 2019 18:45:36 +0800
From: <shun-chih.yu@mediatek.com>
To: Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>, "Rob
 Herring" <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 "Dan Williams" <dan.j.williams@intel.com>
Subject: [PATCH 2/2] dmaengine: mediatek-cqdma: remove redundant queue
 structure
Date: Thu, 24 Jan 2019 18:44:40 +0800
Message-ID: <1548326680-16454-3-git-send-email-shun-chih.yu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1548326680-16454-1-git-send-email-shun-chih.yu@mediatek.com>
References: <1548326680-16454-1-git-send-email-shun-chih.yu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_024557_664897_E15CFBE9 
X-CRM114-Status: GOOD (  23.34  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 srv_wsdupstream@mediatek.com, linux-mediatek@lists.infradead.org,
 Shun-Chih Yu <shun-chih.yu@mediatek.com>, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Shun-Chih Yu <shun-chih.yu@mediatek.com>

This patch introduces active_vdec to indicate the virtual descriptor
under processing by the CQDMA dmaengine, and simplify the control logic
by removing redundant queue structure, tasklets, and completion
management.

Also, wrong residue assignment in mtk_cqdma_tx_status and typos are
fixed.

Signed-off-by: Shun-Chih Yu <shun-chih.yu@mediatek.com>
---
 drivers/dma/mediatek/mtk-cqdma.c |  399 ++++++++++----------------------------
 1 file changed, 98 insertions(+), 301 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index 131f397..387781b 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -22,6 +22,7 @@
 #include <linux/of_dma.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/preempt.h>
 #include <linux/refcount.h>
 #include <linux/slab.h>
 
@@ -47,7 +48,6 @@
 #define MTK_CQDMA_SRC			0x1c
 #define MTK_CQDMA_DST			0x20
 #define MTK_CQDMA_LEN1			0x24
-#define MTK_CQDMA_LEN2			0x28
 #define MTK_CQDMA_SRC2			0x60
 #define MTK_CQDMA_DST2			0x64
 
@@ -69,45 +69,32 @@
  *                         descriptor (CVD)
  * @vd:                    An instance for struct virt_dma_desc
  * @len:                   The total data size device wants to move
- * @residue:               The remaining data size device will move
  * @dest:                  The destination address device wants to move to
  * @src:                   The source address device wants to move from
  * @ch:                    The pointer to the corresponding dma channel
- * @node:                  The lise_head struct to build link-list for VDs
- * @parent:                The pointer to the parent CVD
  */
 struct mtk_cqdma_vdesc {
 	struct virt_dma_desc vd;
 	size_t len;
-	size_t residue;
 	dma_addr_t dest;
 	dma_addr_t src;
 	struct dma_chan *ch;
-
-	struct list_head node;
-	struct mtk_cqdma_vdesc *parent;
 };
 
 /**
  * struct mtk_cqdma_pchan - The struct holding info describing physical
  *                         channel (PC)
- * @queue:                 Queue for the PDs issued to this PC
+ * @active_vdesc:          The pointer to the CVD which is under processing
  * @base:                  The mapped register I/O base of this PC
  * @irq:                   The IRQ that this PC are using
  * @refcnt:                Track how many VCs are using this PC
- * @tasklet:               Tasklet for this PC
  * @lock:                  Lock protect agaisting multiple VCs access PC
  */
 struct mtk_cqdma_pchan {
-	struct list_head queue;
+	struct mtk_cqdma_vdesc *active_vdesc;
 	void __iomem *base;
 	u32 irq;
-
 	refcount_t refcnt;
-
-	struct tasklet_struct tasklet;
-
-	/* lock to protect PC */
 	spinlock_t lock;
 };
 
@@ -116,14 +103,10 @@ struct mtk_cqdma_pchan {
  *                         channel (VC)
  * @vc:                    An instance for struct virt_dma_chan
  * @pc:                    The pointer to the underlying PC
- * @issue_completion:	   The wait for all issued descriptors completited
- * @issue_synchronize:	   Bool indicating channel synchronization starts
  */
 struct mtk_cqdma_vchan {
 	struct virt_dma_chan vc;
 	struct mtk_cqdma_pchan *pc;
-	struct completion issue_completion;
-	bool issue_synchronize;
 };
 
 /**
@@ -168,7 +151,7 @@ static struct device *cqdma2dev(struct mtk_cqdma_device *cqdma)
 
 static u32 mtk_dma_read(struct mtk_cqdma_pchan *pc, u32 reg)
 {
-	return readl(pc->base + reg);
+	return readl_relaxed(pc->base + reg);
 }
 
 static void mtk_dma_write(struct mtk_cqdma_pchan *pc, u32 reg, u32 val)
@@ -202,22 +185,22 @@ static void mtk_cqdma_vdesc_free(struct virt_dma_desc *vd)
 	kfree(to_cqdma_vdesc(vd));
 }
 
-static int mtk_cqdma_poll_engine_done(struct mtk_cqdma_pchan *pc, bool atomic)
+static int mtk_cqdma_poll_engine_done(struct mtk_cqdma_pchan *pc)
 {
 	u32 status = 0;
 
-	if (!atomic)
+	if (!in_task())
 		return readl_poll_timeout(pc->base + MTK_CQDMA_EN,
 					  status,
 					  !(status & MTK_CQDMA_EN_BIT),
 					  MTK_CQDMA_USEC_POLL,
 					  MTK_CQDMA_TIMEOUT_POLL);
-
-	return readl_poll_timeout_atomic(pc->base + MTK_CQDMA_EN,
-					 status,
-					 !(status & MTK_CQDMA_EN_BIT),
-					 MTK_CQDMA_USEC_POLL,
-					 MTK_CQDMA_TIMEOUT_POLL);
+	else
+		return readl_poll_timeout_atomic(pc->base + MTK_CQDMA_EN,
+						 status,
+						 !(status & MTK_CQDMA_EN_BIT),
+						 MTK_CQDMA_USEC_POLL,
+						 MTK_CQDMA_TIMEOUT_POLL);
 }
 
 static int mtk_cqdma_hard_reset(struct mtk_cqdma_pchan *pc)
@@ -225,20 +208,17 @@ static int mtk_cqdma_hard_reset(struct mtk_cqdma_pchan *pc)
 	mtk_dma_set(pc, MTK_CQDMA_RESET, MTK_CQDMA_HARD_RST_BIT);
 	mtk_dma_clr(pc, MTK_CQDMA_RESET, MTK_CQDMA_HARD_RST_BIT);
 
-	return mtk_cqdma_poll_engine_done(pc, false);
+	return mtk_cqdma_poll_engine_done(pc);
 }
 
 static void mtk_cqdma_start(struct mtk_cqdma_pchan *pc,
 			    struct mtk_cqdma_vdesc *cvd)
 {
-	/* wait for the previous transaction done */
-	if (mtk_cqdma_poll_engine_done(pc, true) < 0)
-		dev_err(cqdma2dev(to_cqdma_dev(cvd->ch)), "cqdma wait transaction timeout\n");
-
 	/* warm reset the dma engine for the new transaction */
 	mtk_dma_set(pc, MTK_CQDMA_RESET, MTK_CQDMA_WARM_RST_BIT);
-	if (mtk_cqdma_poll_engine_done(pc, true) < 0)
-		dev_err(cqdma2dev(to_cqdma_dev(cvd->ch)), "cqdma warm reset timeout\n");
+	if (mtk_cqdma_poll_engine_done(pc) < 0)
+		dev_err(cqdma2dev(to_cqdma_dev(cvd->ch)),
+			"cqdma warm reset timeout\n");
 
 	/* setup the source */
 	mtk_dma_set(pc, MTK_CQDMA_SRC, cvd->src & MTK_CQDMA_ADDR_LIMIT);
@@ -253,11 +233,12 @@ static void mtk_cqdma_start(struct mtk_cqdma_pchan *pc,
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 	mtk_dma_set(pc, MTK_CQDMA_DST2, cvd->dest >> MTK_CQDMA_ADDR2_SHFIT);
 #else
-	mtk_dma_set(pc, MTK_CQDMA_SRC2, 0);
+	mtk_dma_set(pc, MTK_CQDMA_DST2, 0);
 #endif
 
 	/* setup the length */
-	mtk_dma_set(pc, MTK_CQDMA_LEN1, cvd->len);
+	mtk_dma_set(pc, MTK_CQDMA_LEN1, (cvd->len < MTK_CQDMA_MAX_LEN) ?
+		    cvd->len : MTK_CQDMA_MAX_LEN);
 
 	/* start dma engine */
 	mtk_dma_set(pc, MTK_CQDMA_EN, MTK_CQDMA_EN_BIT);
@@ -265,30 +246,17 @@ static void mtk_cqdma_start(struct mtk_cqdma_pchan *pc,
 
 static void mtk_cqdma_issue_vchan_pending(struct mtk_cqdma_vchan *cvc)
 {
-	struct virt_dma_desc *vd, *vd2;
+	struct virt_dma_desc *vd;
 	struct mtk_cqdma_pchan *pc = cvc->pc;
-	struct mtk_cqdma_vdesc *cvd;
-	bool trigger_engine = false;
 
 	lockdep_assert_held(&cvc->vc.lock);
 	lockdep_assert_held(&pc->lock);
 
-	list_for_each_entry_safe(vd, vd2, &cvc->vc.desc_issued, node) {
-		/* need to trigger dma engine if PC's queue is empty */
-		if (list_empty(&pc->queue))
-			trigger_engine = true;
-
-		cvd = to_cqdma_vdesc(vd);
+	vd = vchan_next_desc(&cvc->vc);
 
-		/* add VD into PC's queue */
-		list_add_tail(&cvd->node, &pc->queue);
-
-		/* start the dma engine */
-		if (trigger_engine)
-			mtk_cqdma_start(pc, cvd);
-
-		/* remove VD from list desc_issued */
-		list_del(&vd->node);
+	if (vd && !pc->active_vdesc) {
+		pc->active_vdesc = to_cqdma_vdesc(vd);
+		mtk_cqdma_start(pc, pc->active_vdesc);
 	}
 }
 
@@ -298,100 +266,55 @@ static void mtk_cqdma_issue_vchan_pending(struct mtk_cqdma_vchan *cvc)
  */
 static bool mtk_cqdma_is_vchan_active(struct mtk_cqdma_vchan *cvc)
 {
-	struct mtk_cqdma_vdesc *cvd;
-
-	list_for_each_entry(cvd, &cvc->pc->queue, node)
-		if (cvc == to_cqdma_vchan(cvd->ch))
-			return true;
-
-	return false;
+	return (!cvc->pc->active_vdesc) ? false :
+	       (cvc == to_cqdma_vchan(cvc->pc->active_vdesc->ch));
 }
 
-/*
- * return the pointer of the CVD that is just consumed by the PC
- */
-static struct mtk_cqdma_vdesc
-*mtk_cqdma_consume_work_queue(struct mtk_cqdma_pchan *pc)
+static void mtk_cqdma_complete_vdesc(struct mtk_cqdma_pchan *pc)
 {
 	struct mtk_cqdma_vchan *cvc;
-	struct mtk_cqdma_vdesc *cvd, *ret = NULL;
-
-	/* consume a CVD from PC's queue */
-	cvd = list_first_entry_or_null(&pc->queue,
-				       struct mtk_cqdma_vdesc, node);
-	if (unlikely(!cvd || !cvd->parent))
-		return NULL;
+	struct mtk_cqdma_vdesc *cvd;
+	struct virt_dma_desc *vd;
+	size_t tlen;
 
+	cvd = pc->active_vdesc;
 	cvc = to_cqdma_vchan(cvd->ch);
-	ret = cvd;
-
-	/* update residue of the parent CVD */
-	cvd->parent->residue -= cvd->len;
 
-	/* delete CVD from PC's queue */
-	list_del(&cvd->node);
+	tlen = (cvd->len < MTK_CQDMA_MAX_LEN) ? cvd->len : MTK_CQDMA_MAX_LEN;
+	cvd->len -= tlen;
+	cvd->src += tlen;
+	cvd->dest += tlen;
 
 	spin_lock(&cvc->vc.lock);
 
-	/* check whether all the child CVDs completed */
-	if (!cvd->parent->residue) {
-		/* add the parent VD into list desc_completed */
-		vchan_cookie_complete(&cvd->parent->vd);
-
-		/* setup completion if this VC is under synchronization */
-		if (cvc->issue_synchronize && !mtk_cqdma_is_vchan_active(cvc)) {
-			complete(&cvc->issue_completion);
-			cvc->issue_synchronize = false;
-		}
-	}
-
-	spin_unlock(&cvc->vc.lock);
-
-	/* start transaction for next CVD in the queue */
-	cvd = list_first_entry_or_null(&pc->queue,
-				       struct mtk_cqdma_vdesc, node);
-	if (cvd)
-		mtk_cqdma_start(pc, cvd);
+	/* check whether the VD completed */
+	if (!cvd->len) {
+		/* delete VD from desc_issued */
+		list_del(&cvd->vd.node);
 
-	return ret;
-}
-
-static void mtk_cqdma_tasklet_cb(unsigned long data)
-{
-	struct mtk_cqdma_pchan *pc = (struct mtk_cqdma_pchan *)data;
-	struct mtk_cqdma_vdesc *cvd = NULL;
-	unsigned long flags;
+		/* add the VD into list desc_completed */
+		vchan_cookie_complete(&cvd->vd);
 
-	spin_lock_irqsave(&pc->lock, flags);
-	/* consume the queue */
-	cvd = mtk_cqdma_consume_work_queue(pc);
-	spin_unlock_irqrestore(&pc->lock, flags);
-
-	/* submit the next CVD */
-	if (cvd) {
-		dma_run_dependencies(&cvd->vd.tx);
-
-		/*
-		 * free child CVD after completion.
-		 * the parent CVD would be freeed with desc_free by user.
-		 */
-		if (cvd->parent != cvd)
-			kfree(cvd);
+		/* get the next active VD */
+		vd = vchan_next_desc(&cvc->vc);
+		pc->active_vdesc = (!vd) ? NULL : to_cqdma_vdesc(vd);
 	}
 
-	/* re-enable interrupt before leaving tasklet */
-	enable_irq(pc->irq);
+	/* start the next transaction */
+	if (pc->active_vdesc)
+		mtk_cqdma_start(pc, pc->active_vdesc);
+
+	spin_unlock(&cvc->vc.lock);
 }
 
 static irqreturn_t mtk_cqdma_irq(int irq, void *devid)
 {
 	struct mtk_cqdma_device *cqdma = devid;
 	irqreturn_t ret = IRQ_NONE;
-	bool schedule_tasklet = false;
 	u32 i;
 
 	/* clear interrupt flags for each PC */
-	for (i = 0; i < cqdma->dma_channels; ++i, schedule_tasklet = false) {
+	for (i = 0; i < cqdma->dma_channels; ++i) {
 		spin_lock(&cqdma->pc[i]->lock);
 		if (mtk_dma_read(cqdma->pc[i],
 				 MTK_CQDMA_INT_FLAG) & MTK_CQDMA_INT_FLAG_BIT) {
@@ -399,72 +322,21 @@ static irqreturn_t mtk_cqdma_irq(int irq, void *devid)
 			mtk_dma_clr(cqdma->pc[i], MTK_CQDMA_INT_FLAG,
 				    MTK_CQDMA_INT_FLAG_BIT);
 
-			schedule_tasklet = true;
+			mtk_cqdma_complete_vdesc(cqdma->pc[i]);
+
 			ret = IRQ_HANDLED;
 		}
 		spin_unlock(&cqdma->pc[i]->lock);
-
-		if (schedule_tasklet) {
-			/* disable interrupt */
-			disable_irq_nosync(cqdma->pc[i]->irq);
-
-			/* schedule the tasklet to handle the transactions */
-			tasklet_schedule(&cqdma->pc[i]->tasklet);
-		}
 	}
 
 	return ret;
 }
 
-static struct virt_dma_desc *mtk_cqdma_find_active_desc(struct dma_chan *c,
-							dma_cookie_t cookie)
-{
-	struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
-	struct virt_dma_desc *vd;
-	unsigned long flags;
-
-	spin_lock_irqsave(&cvc->pc->lock, flags);
-	list_for_each_entry(vd, &cvc->pc->queue, node)
-		if (vd->tx.cookie == cookie) {
-			spin_unlock_irqrestore(&cvc->pc->lock, flags);
-			return vd;
-		}
-	spin_unlock_irqrestore(&cvc->pc->lock, flags);
-
-	list_for_each_entry(vd, &cvc->vc.desc_issued, node)
-		if (vd->tx.cookie == cookie)
-			return vd;
-
-	return NULL;
-}
-
 static enum dma_status mtk_cqdma_tx_status(struct dma_chan *c,
 					   dma_cookie_t cookie,
 					   struct dma_tx_state *txstate)
 {
-	struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
-	struct mtk_cqdma_vdesc *cvd;
-	struct virt_dma_desc *vd;
-	enum dma_status ret;
-	unsigned long flags;
-	size_t bytes = 0;
-
-	ret = dma_cookie_status(c, cookie, txstate);
-	if (ret == DMA_COMPLETE || !txstate)
-		return ret;
-
-	spin_lock_irqsave(&cvc->vc.lock, flags);
-	vd = mtk_cqdma_find_active_desc(c, cookie);
-	spin_unlock_irqrestore(&cvc->vc.lock, flags);
-
-	if (vd) {
-		cvd = to_cqdma_vdesc(vd);
-		bytes = cvd->residue;
-	}
-
-	dma_set_residue(txstate, bytes);
-
-	return ret;
+	return dma_cookie_status(c, cookie, txstate);
 }
 
 static void mtk_cqdma_issue_pending(struct dma_chan *c)
@@ -473,7 +345,7 @@ static void mtk_cqdma_issue_pending(struct dma_chan *c)
 	unsigned long pc_flags;
 	unsigned long vc_flags;
 
-	/* acquire PC's lock before VS's lock for lock dependency in tasklet */
+	/* acquire PC's lock before VC's lock for lock dependency in ISR */
 	spin_lock_irqsave(&cvc->pc->lock, pc_flags);
 	spin_lock_irqsave(&cvc->vc.lock, vc_flags);
 
@@ -488,124 +360,56 @@ static void mtk_cqdma_issue_pending(struct dma_chan *c)
 mtk_cqdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest,
 			  dma_addr_t src, size_t len, unsigned long flags)
 {
-	struct mtk_cqdma_vdesc **cvd;
-	struct dma_async_tx_descriptor *tx = NULL, *prev_tx = NULL;
-	size_t i, tlen, nr_vd;
-
-	/*
-	 * In the case that trsanction length is larger than the
-	 * DMA engine supports, a single memcpy transaction needs
-	 * to be separated into several DMA transactions.
-	 * Each DMA transaction would be described by a CVD,
-	 * and the first one is referred as the parent CVD,
-	 * while the others are child CVDs.
-	 * The parent CVD's tx descriptor is the only tx descriptor
-	 * returned to the DMA user, and it should not be completed
-	 * until all the child CVDs completed.
-	 */
-	nr_vd = DIV_ROUND_UP(len, MTK_CQDMA_MAX_LEN);
-	cvd = kcalloc(nr_vd, sizeof(*cvd), GFP_NOWAIT);
+	struct mtk_cqdma_vdesc *cvd;
+
+	cvd = kzalloc(sizeof(*cvd), GFP_NOWAIT);
 	if (!cvd)
 		return NULL;
 
-	for (i = 0; i < nr_vd; ++i) {
-		cvd[i] = kzalloc(sizeof(*cvd[i]), GFP_NOWAIT);
-		if (!cvd[i]) {
-			for (; i > 0; --i)
-				kfree(cvd[i - 1]);
-			return NULL;
-		}
+	/* setup dma channel */
+	cvd->ch = c;
 
-		/* setup dma channel */
-		cvd[i]->ch = c;
+	/* setup sourece, destination, and length */
+	cvd->len = len;
+	cvd->src = src;
+	cvd->dest = dest;
 
-		/* setup sourece, destination, and length */
-		tlen = (len > MTK_CQDMA_MAX_LEN) ? MTK_CQDMA_MAX_LEN : len;
-		cvd[i]->len = tlen;
-		cvd[i]->src = src;
-		cvd[i]->dest = dest;
-
-		/* setup tx descriptor */
-		tx = vchan_tx_prep(to_virt_chan(c), &cvd[i]->vd, flags);
-		tx->next = NULL;
-
-		if (!i) {
-			cvd[0]->residue = len;
-		} else {
-			prev_tx->next = tx;
-			cvd[i]->residue = tlen;
-		}
-
-		cvd[i]->parent = cvd[0];
-
-		/* update the src, dest, len, prev_tx for the next CVD */
-		src += tlen;
-		dest += tlen;
-		len -= tlen;
-		prev_tx = tx;
-	}
-
-	return &cvd[0]->vd.tx;
+	return vchan_tx_prep(to_virt_chan(c), &cvd->vd, flags);
 }
 
-static void mtk_cqdma_free_inactive_desc(struct dma_chan *c)
-{
-	struct virt_dma_chan *vc = to_virt_chan(c);
-	unsigned long flags;
-	LIST_HEAD(head);
-
-	/*
-	 * set desc_allocated, desc_submitted,
-	 * and desc_issued as the candicates to be freed
-	 */
-	spin_lock_irqsave(&vc->lock, flags);
-	list_splice_tail_init(&vc->desc_allocated, &head);
-	list_splice_tail_init(&vc->desc_submitted, &head);
-	list_splice_tail_init(&vc->desc_issued, &head);
-	spin_unlock_irqrestore(&vc->lock, flags);
-
-	/* free descriptor lists */
-	vchan_dma_desc_free_list(vc, &head);
-}
-
-static void mtk_cqdma_free_active_desc(struct dma_chan *c)
+static int mtk_cqdma_terminate_all(struct dma_chan *c)
 {
 	struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
-	bool sync_needed = false;
+	struct virt_dma_chan *vc = to_virt_chan(c);
 	unsigned long pc_flags;
 	unsigned long vc_flags;
+	LIST_HEAD(head);
 
-	/* acquire PC's lock first due to lock dependency in dma ISR */
-	spin_lock_irqsave(&cvc->pc->lock, pc_flags);
-	spin_lock_irqsave(&cvc->vc.lock, vc_flags);
-
-	/* synchronization is required if this VC is active */
-	if (mtk_cqdma_is_vchan_active(cvc)) {
-		cvc->issue_synchronize = true;
-		sync_needed = true;
-	}
+	do {
+		/* acquire PC's lock first due to lock dependency in dma ISR */
+		spin_lock_irqsave(&cvc->pc->lock, pc_flags);
+		spin_lock_irqsave(&cvc->vc.lock, vc_flags);
 
-	spin_unlock_irqrestore(&cvc->vc.lock, vc_flags);
-	spin_unlock_irqrestore(&cvc->pc->lock, pc_flags);
+		/* wait for the VC to be inactive  */
+		if (mtk_cqdma_is_vchan_active(cvc)) {
+			spin_unlock_irqrestore(&cvc->vc.lock, vc_flags);
+			spin_unlock_irqrestore(&cvc->pc->lock, pc_flags);
+			continue;
+		}
 
-	/* waiting for the completion of this VC */
-	if (sync_needed)
-		wait_for_completion(&cvc->issue_completion);
+		/* get VDs from lists */
+		vchan_get_all_descriptors(vc, &head);
 
-	/* free all descriptors in list desc_completed */
-	vchan_synchronize(&cvc->vc);
+		/* free all the VDs */
+		vchan_dma_desc_free_list(vc, &head);
 
-	WARN_ONCE(!list_empty(&cvc->vc.desc_completed),
-		  "Desc pending still in list desc_completed\n");
-}
+		spin_unlock_irqrestore(&cvc->vc.lock, vc_flags);
+		spin_unlock_irqrestore(&cvc->pc->lock, pc_flags);
 
-static int mtk_cqdma_terminate_all(struct dma_chan *c)
-{
-	/* free descriptors not processed yet by hardware */
-	mtk_cqdma_free_inactive_desc(c);
+		break;
+	} while (1);
 
-	/* free descriptors being processed by hardware */
-	mtk_cqdma_free_active_desc(c);
+	vchan_synchronize(&cvc->vc);
 
 	return 0;
 }
@@ -618,7 +422,7 @@ static int mtk_cqdma_alloc_chan_resources(struct dma_chan *c)
 	u32 i, min_refcnt = U32_MAX, refcnt;
 	unsigned long flags;
 
-	/* allocate PC with the minimun refcount */
+	/* allocate PC with the minimum refcount */
 	for (i = 0; i < cqdma->dma_channels; ++i) {
 		refcnt = refcount_read(&cqdma->pc[i]->refcnt);
 		if (refcnt < min_refcnt) {
@@ -671,8 +475,9 @@ static void mtk_cqdma_free_chan_resources(struct dma_chan *c)
 		mtk_dma_set(cvc->pc, MTK_CQDMA_FLUSH, MTK_CQDMA_FLUSH_BIT);
 
 		/* wait for the completion of flush operation */
-		if (mtk_cqdma_poll_engine_done(cvc->pc, false) < 0)
-			dev_err(cqdma2dev(to_cqdma_dev(c)), "cqdma flush timeout\n");
+		if (mtk_cqdma_poll_engine_done(cvc->pc) < 0)
+			dev_err(cqdma2dev(to_cqdma_dev(c)),
+				"cqdma flush timeout\n");
 
 		/* clear the flush bit and interrupt flag */
 		mtk_dma_clr(cvc->pc, MTK_CQDMA_FLUSH, MTK_CQDMA_FLUSH_BIT);
@@ -787,9 +592,9 @@ static int mtk_cqdma_probe(struct platform_device *pdev)
 	if (pdev->dev.of_node && of_property_read_u32(pdev->dev.of_node,
 						      "dma-requests",
 						      &cqdma->dma_requests)) {
-		dev_info(&pdev->dev,
-			 "Using %u as missing dma-requests property\n",
-			 MTK_CQDMA_NR_VCHANS);
+		dev_dbg(&pdev->dev,
+			"Using %u as missing dma-requests property\n",
+			MTK_CQDMA_NR_VCHANS);
 
 		cqdma->dma_requests = MTK_CQDMA_NR_VCHANS;
 	}
@@ -797,9 +602,9 @@ static int mtk_cqdma_probe(struct platform_device *pdev)
 	if (pdev->dev.of_node && of_property_read_u32(pdev->dev.of_node,
 						      "dma-channels",
 						      &cqdma->dma_channels)) {
-		dev_info(&pdev->dev,
-			 "Using %u as missing dma-channels property\n",
-			 MTK_CQDMA_NR_PCHANS);
+		dev_dbg(&pdev->dev,
+			"Using %u as missing dma-channels property\n",
+			MTK_CQDMA_NR_PCHANS);
 
 		cqdma->dma_channels = MTK_CQDMA_NR_PCHANS;
 	}
@@ -816,7 +621,7 @@ static int mtk_cqdma_probe(struct platform_device *pdev)
 		if (!cqdma->pc[i])
 			return -ENOMEM;
 
-		INIT_LIST_HEAD(&cqdma->pc[i]->queue);
+		cqdma->pc[i]->active_vdesc = NULL;
 		spin_lock_init(&cqdma->pc[i]->lock);
 		refcount_set(&cqdma->pc[i]->refcnt, 0);
 
@@ -860,7 +665,6 @@ static int mtk_cqdma_probe(struct platform_device *pdev)
 		vc = &cqdma->vc[i];
 		vc->vc.desc_free = mtk_cqdma_vdesc_free;
 		vchan_init(&vc->vc, dd);
-		init_completion(&vc->issue_completion);
 	}
 
 	err = dma_async_device_register(dd);
@@ -884,12 +688,7 @@ static int mtk_cqdma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, cqdma);
 
-	/* initialize tasklet for each PC */
-	for (i = 0; i < cqdma->dma_channels; ++i)
-		tasklet_init(&cqdma->pc[i]->tasklet, mtk_cqdma_tasklet_cb,
-			     (unsigned long)cqdma->pc[i]);
-
-	dev_info(&pdev->dev, "MediaTek CQDMA driver registered\n");
+	dev_dbg(&pdev->dev, "MediaTek CQDMA driver registered\n");
 
 	return 0;
 
@@ -923,8 +722,6 @@ static int mtk_cqdma_remove(struct platform_device *pdev)
 
 		/* Waits for any pending IRQ handlers to complete */
 		synchronize_irq(cqdma->pc[i]->irq);
-
-		tasklet_kill(&cqdma->pc[i]->tasklet);
 	}
 
 	/* disable hardware */
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
