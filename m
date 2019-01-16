Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C878C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:07:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAA9320840
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="klVtGf2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA9320840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mbnzlAeA0WmLBVd/tutLv8Zfxh5aDtrsU9HQJOnGTPg=; b=klVtGf2BfTnn3Z
	GlitUTIMexfoeiPNzmS9RcaB2j7bPsE0YGNPrNhfxgdQJ6vSrGpOpX+pSNhssKG7KzAkgAKkYHoo9
	PS1lu6LpQnHEhIcHCIFOJT0dS4rIeCKuXJcmHP+ySglRlufauFHdPUMXH6PNDjWNeBdG03eHWSGPY
	6EqBHkN/qD1akmbIn6RFx3TPBz9d6LXabwaoMDrxq1fZzi0laawdjsv3+MzstNcuaawc02XaX4zJc
	c2aEKe7IiktvqgUfWFcC1fFpeHanB3rdM8Tr8YDz8UYRU4PqLXwwOWrsEUpuSn1kjnRSfwUJslm3t
	pxyQwmiQX4evEawbp9ng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjdQX-0005rD-TK; Wed, 16 Jan 2019 05:07:45 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjdQI-0005e9-DQ; Wed, 16 Jan 2019 05:07:32 +0000
X-UUID: 5b97101bab24493f9a1a83a7d88e840e-20190115
X-UUID: 5b97101bab24493f9a1a83a7d88e840e-20190115
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <ck.hu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 2007656019; Tue, 15 Jan 2019 21:07:25 -0800
Received: from mtkmbs03n1.mediatek.inc (172.21.101.181) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 15 Jan 2019 21:07:24 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 16 Jan 2019 13:07:22 +0800
Received: from mtkslt305.mediatek.inc (10.21.14.140) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Wed, 16 Jan 2019 13:07:22 +0800
From: CK Hu <ck.hu@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Houlong Wei <houlong.wei@mediatek.com>
Subject: [PATCH 3/3] mailbox: mediatek: Remove busylist
Date: Wed, 16 Jan 2019 13:04:35 +0800
Message-ID: <20190116050435.11624-4-ck.hu@mediatek.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190116050435.11624-1-ck.hu@mediatek.com>
References: <20190116050435.11624-1-ck.hu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_210730_530001_3DA04BBB 
X-CRM114-Status: GOOD (  17.81  )
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
Cc: CK Hu <ck.hu@mediatek.com>, srv_heupstream@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

After implement abort_data, controller need not to implement its own
queue. Remove busylist because it's useless.

Signed-off-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 255 ++++-------------------------
 1 file changed, 29 insertions(+), 226 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index f2219f263ef6..45c59f677ecb 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -16,9 +16,7 @@
 #include <linux/mailbox/mtk-cmdq-mailbox.h>
 #include <linux/of_device.h>
 
-#define CMDQ_OP_CODE_MASK		(0xff << CMDQ_OP_CODE_SHIFT)
 #define CMDQ_IRQ_MASK			0xffff
-#define CMDQ_NUM_CMD(t)			(t->cmd_buf_size / CMDQ_INST_SIZE)
 
 #define CMDQ_CURR_IRQ_STATUS		0x10
 #define CMDQ_THR_SLOT_CYCLES		0x30
@@ -47,22 +45,10 @@
 #define CMDQ_THR_IRQ_EN			(CMDQ_THR_IRQ_ERROR | CMDQ_THR_IRQ_DONE)
 #define CMDQ_THR_IS_WAITING		BIT(31)
 
-#define CMDQ_JUMP_BY_OFFSET		0x10000000
-#define CMDQ_JUMP_BY_PA			0x10000001
-
 struct cmdq_thread {
 	struct mbox_chan	*chan;
 	void __iomem		*base;
-	struct list_head	task_busy_list;
 	u32			priority;
-	bool			atomic_exec;
-};
-
-struct cmdq_task {
-	struct cmdq		*cmdq;
-	struct list_head	list_entry;
-	dma_addr_t		pa_base;
-	struct cmdq_thread	*thread;
 	struct cmdq_pkt		*pkt; /* the packet sent from mailbox client */
 };
 
@@ -130,171 +116,47 @@ static void cmdq_thread_disable(struct cmdq *cmdq, struct cmdq_thread *thread)
 	writel(CMDQ_THR_DISABLED, thread->base + CMDQ_THR_ENABLE_TASK);
 }
 
-/* notify GCE to re-fetch commands by setting GCE thread PC */
-static void cmdq_thread_invalidate_fetched_data(struct cmdq_thread *thread)
-{
-	writel(readl(thread->base + CMDQ_THR_CURR_ADDR),
-	       thread->base + CMDQ_THR_CURR_ADDR);
-}
-
-static void cmdq_task_insert_into_thread(struct cmdq_task *task)
-{
-	struct device *dev = task->cmdq->mbox.dev;
-	struct cmdq_thread *thread = task->thread;
-	struct cmdq_task *prev_task = list_last_entry(
-			&thread->task_busy_list, typeof(*task), list_entry);
-	u64 *prev_task_base = prev_task->pkt->va_base;
-
-	/* let previous task jump to this task */
-	dma_sync_single_for_cpu(dev, prev_task->pa_base,
-				prev_task->pkt->cmd_buf_size, DMA_TO_DEVICE);
-	prev_task_base[CMDQ_NUM_CMD(prev_task->pkt) - 1] =
-		(u64)CMDQ_JUMP_BY_PA << 32 | task->pa_base;
-	dma_sync_single_for_device(dev, prev_task->pa_base,
-				   prev_task->pkt->cmd_buf_size, DMA_TO_DEVICE);
-
-	cmdq_thread_invalidate_fetched_data(thread);
-}
-
-static bool cmdq_command_is_wfe(u64 cmd)
-{
-	u64 wfe_option = CMDQ_WFE_UPDATE | CMDQ_WFE_WAIT | CMDQ_WFE_WAIT_VALUE;
-	u64 wfe_op = (u64)(CMDQ_CODE_WFE << CMDQ_OP_CODE_SHIFT) << 32;
-	u64 wfe_mask = (u64)CMDQ_OP_CODE_MASK << 32 | 0xffffffff;
-
-	return ((cmd & wfe_mask) == (wfe_op | wfe_option));
-}
-
-/* we assume tasks in the same display GCE thread are waiting the same event. */
-static void cmdq_task_remove_wfe(struct cmdq_task *task)
-{
-	struct device *dev = task->cmdq->mbox.dev;
-	u64 *base = task->pkt->va_base;
-	int i;
-
-	dma_sync_single_for_cpu(dev, task->pa_base, task->pkt->cmd_buf_size,
-				DMA_TO_DEVICE);
-	for (i = 0; i < CMDQ_NUM_CMD(task->pkt); i++)
-		if (cmdq_command_is_wfe(base[i]))
-			base[i] = (u64)CMDQ_JUMP_BY_OFFSET << 32 |
-				  CMDQ_JUMP_PASS;
-	dma_sync_single_for_device(dev, task->pa_base, task->pkt->cmd_buf_size,
-				   DMA_TO_DEVICE);
-}
-
 static bool cmdq_thread_is_in_wfe(struct cmdq_thread *thread)
 {
 	return readl(thread->base + CMDQ_THR_WAIT_TOKEN) & CMDQ_THR_IS_WAITING;
 }
 
-static void cmdq_thread_wait_end(struct cmdq_thread *thread,
-				 unsigned long end_pa)
-{
-	struct device *dev = thread->chan->mbox->dev;
-	unsigned long curr_pa;
-
-	if (readl_poll_timeout_atomic(thread->base + CMDQ_THR_CURR_ADDR,
-			curr_pa, curr_pa == end_pa, 1, 20))
-		dev_err(dev, "GCE thread cannot run to end.\n");
-}
-
-static void cmdq_task_exec_done(struct cmdq_task *task, enum cmdq_cb_status sta)
-{
-	struct cmdq_task_cb *cb = &task->pkt->async_cb;
-	struct cmdq_cb_data data;
-
-	WARN_ON(cb->cb == (cmdq_async_flush_cb)NULL);
-	data.sta = sta;
-	data.data = cb->data;
-	cb->cb(data);
-
-	list_del(&task->list_entry);
-}
-
-static void cmdq_task_handle_error(struct cmdq_task *task)
-{
-	struct cmdq_thread *thread = task->thread;
-	struct cmdq_task *next_task;
-
-	dev_err(task->cmdq->mbox.dev, "task 0x%p error\n", task);
-	WARN_ON(cmdq_thread_suspend(task->cmdq, thread) < 0);
-	next_task = list_first_entry_or_null(&thread->task_busy_list,
-			struct cmdq_task, list_entry);
-	if (next_task)
-		writel(next_task->pa_base, thread->base + CMDQ_THR_CURR_ADDR);
-	cmdq_thread_resume(thread);
-}
-
 static void cmdq_thread_irq_handler(struct cmdq *cmdq,
 				    struct cmdq_thread *thread)
 {
-	struct cmdq_task *task, *tmp, *curr_task = NULL;
-	u32 curr_pa, irq_flag, task_end_pa;
-	bool err;
+	unsigned long flags;
+	u32 curr_pa, irq_flag, end_pa;
+	int ret = 0;
 
+	spin_lock_irqsave(&thread->chan->lock, flags);
 	irq_flag = readl(thread->base + CMDQ_THR_IRQ_STATUS);
 	writel(~irq_flag, thread->base + CMDQ_THR_IRQ_STATUS);
 
-	/*
-	 * When ISR call this function, another CPU core could run
-	 * "release task" right before we acquire the spin lock, and thus
-	 * reset / disable this GCE thread, so we need to check the enable
-	 * bit of this GCE thread.
-	 */
-	if (!(readl(thread->base + CMDQ_THR_ENABLE_TASK) & CMDQ_THR_ENABLED))
-		return;
-
-	if (irq_flag & CMDQ_THR_IRQ_ERROR)
-		err = true;
-	else if (irq_flag & CMDQ_THR_IRQ_DONE)
-		err = false;
-	else
-		return;
-
 	curr_pa = readl(thread->base + CMDQ_THR_CURR_ADDR);
+	end_pa = readl(thread->base + CMDQ_THR_END_ADDR);
 
-	list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
-				 list_entry) {
-		task_end_pa = task->pa_base + task->pkt->cmd_buf_size;
-		if (curr_pa >= task->pa_base && curr_pa < task_end_pa)
-			curr_task = task;
-
-		if (!curr_task || curr_pa == task_end_pa - CMDQ_INST_SIZE) {
-			cmdq_task_exec_done(task, CMDQ_CB_NORMAL);
-			kfree(task);
-		} else if (err) {
-			cmdq_task_exec_done(task, CMDQ_CB_ERROR);
-			cmdq_task_handle_error(curr_task);
-			kfree(task);
-		}
-
-		if (curr_task)
-			break;
-	}
+	if (curr_pa != end_pa ||  irq_flag & CMDQ_THR_IRQ_ERROR)
+		ret = -EFAULT;
 
-	if (list_empty(&thread->task_busy_list)) {
-		cmdq_thread_disable(cmdq, thread);
-		clk_disable(cmdq->clock);
-	}
+	thread->pkt = NULL;
+	cmdq_thread_disable(cmdq, thread);
+	clk_disable(cmdq->clock);
+	spin_unlock_irqrestore(&thread->chan->lock, flags);
+	mbox_chan_txdone(thread->chan, ret);
 }
 
 static irqreturn_t cmdq_irq_handler(int irq, void *dev)
 {
 	struct cmdq *cmdq = dev;
-	unsigned long irq_status, flags = 0L;
+	unsigned long irq_status;
 	int bit;
 
 	irq_status = readl(cmdq->base + CMDQ_CURR_IRQ_STATUS) & CMDQ_IRQ_MASK;
 	if (!(irq_status ^ CMDQ_IRQ_MASK))
 		return IRQ_NONE;
 
-	for_each_clear_bit(bit, &irq_status, fls(CMDQ_IRQ_MASK)) {
-		struct cmdq_thread *thread = &cmdq->thread[bit];
-
-		spin_lock_irqsave(&thread->chan->lock, flags);
-		cmdq_thread_irq_handler(cmdq, thread);
-		spin_unlock_irqrestore(&thread->chan->lock, flags);
-	}
+	for_each_clear_bit(bit, &irq_status, fls(CMDQ_IRQ_MASK))
+		cmdq_thread_irq_handler(cmdq, &cmdq->thread[bit]);
 
 	return IRQ_HANDLED;
 }
@@ -310,7 +172,7 @@ static int cmdq_suspend(struct device *dev)
 
 	for (i = 0; i < cmdq->thread_nr; i++) {
 		thread = &cmdq->thread[i];
-		if (!list_empty(&thread->task_busy_list)) {
+		if (thread->pkt) {
 			task_running = true;
 			break;
 		}
@@ -347,72 +209,21 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
 	struct cmdq_pkt *pkt = (struct cmdq_pkt *)data;
 	struct cmdq_thread *thread = (struct cmdq_thread *)chan->con_priv;
 	struct cmdq *cmdq = dev_get_drvdata(chan->mbox->dev);
-	struct cmdq_task *task;
-	unsigned long curr_pa, end_pa;
 
 	/* Client should not flush new tasks if suspended. */
 	WARN_ON(cmdq->suspended);
 
-	task = kzalloc(sizeof(*task), GFP_ATOMIC);
-	if (!task)
-		return -ENOMEM;
+	thread->pkt = pkt;
 
-	task->cmdq = cmdq;
-	INIT_LIST_HEAD(&task->list_entry);
-	task->pa_base = pkt->pa_base;
-	task->thread = thread;
-	task->pkt = pkt;
-
-	if (list_empty(&thread->task_busy_list)) {
-		WARN_ON(clk_enable(cmdq->clock) < 0);
-		WARN_ON(cmdq_thread_reset(cmdq, thread) < 0);
-
-		writel(task->pa_base, thread->base + CMDQ_THR_CURR_ADDR);
-		writel(task->pa_base + pkt->cmd_buf_size,
-		       thread->base + CMDQ_THR_END_ADDR);
-		writel(thread->priority, thread->base + CMDQ_THR_PRIORITY);
-		writel(CMDQ_THR_IRQ_EN, thread->base + CMDQ_THR_IRQ_ENABLE);
-		writel(CMDQ_THR_ENABLED, thread->base + CMDQ_THR_ENABLE_TASK);
-	} else {
-		WARN_ON(cmdq_thread_suspend(cmdq, thread) < 0);
-		curr_pa = readl(thread->base + CMDQ_THR_CURR_ADDR);
-		end_pa = readl(thread->base + CMDQ_THR_END_ADDR);
-
-		/*
-		 * Atomic execution should remove the following wfe, i.e. only
-		 * wait event at first task, and prevent to pause when running.
-		 */
-		if (thread->atomic_exec) {
-			/* GCE is executing if command is not WFE */
-			if (!cmdq_thread_is_in_wfe(thread)) {
-				cmdq_thread_resume(thread);
-				cmdq_thread_wait_end(thread, end_pa);
-				WARN_ON(cmdq_thread_suspend(cmdq, thread) < 0);
-				/* set to this task directly */
-				writel(task->pa_base,
-				       thread->base + CMDQ_THR_CURR_ADDR);
-			} else {
-				cmdq_task_insert_into_thread(task);
-				cmdq_task_remove_wfe(task);
-				smp_mb(); /* modify jump before enable thread */
-			}
-		} else {
-			/* check boundary */
-			if (curr_pa == end_pa - CMDQ_INST_SIZE ||
-			    curr_pa == end_pa) {
-				/* set to this task directly */
-				writel(task->pa_base,
-				       thread->base + CMDQ_THR_CURR_ADDR);
-			} else {
-				cmdq_task_insert_into_thread(task);
-				smp_mb(); /* modify jump before enable thread */
-			}
-		}
-		writel(task->pa_base + pkt->cmd_buf_size,
-		       thread->base + CMDQ_THR_END_ADDR);
-		cmdq_thread_resume(thread);
-	}
-	list_move_tail(&task->list_entry, &thread->task_busy_list);
+	WARN_ON(clk_enable(cmdq->clock) < 0);
+	WARN_ON(cmdq_thread_reset(cmdq, thread) < 0);
+
+	writel(thread->pkt->pa_base, thread->base + CMDQ_THR_CURR_ADDR);
+	writel(thread->pkt->pa_base + pkt->cmd_buf_size,
+	       thread->base + CMDQ_THR_END_ADDR);
+	writel(thread->priority, thread->base + CMDQ_THR_PRIORITY);
+	writel(CMDQ_THR_IRQ_EN, thread->base + CMDQ_THR_IRQ_ENABLE);
+	writel(CMDQ_THR_ENABLED, thread->base + CMDQ_THR_ENABLE_TASK);
 
 	return 0;
 }
@@ -421,23 +232,18 @@ static void cmdq_mbox_abort_data(struct mbox_chan *chan)
 {
 	struct cmdq_thread *thread = (struct cmdq_thread *)chan->con_priv;
 	struct cmdq *cmdq = dev_get_drvdata(chan->mbox->dev);
-	struct cmdq_task *task, *tmp;
 	unsigned long flags;
 	u32 enable;
 
 	spin_lock_irqsave(&thread->chan->lock, flags);
-	if (list_empty(&thread->task_busy_list))
+	if (!thread->pkt)
 		goto out;
 
 	WARN_ON(cmdq_thread_suspend(cmdq, thread) < 0);
 	if (!cmdq_thread_is_in_wfe(thread))
 		goto wait;
 
-	list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
-				 list_entry) {
-		list_del(&task->list_entry);
-		kfree(task);
-	}
+	thread->pkt = NULL;
 
 	cmdq_thread_resume(thread);
 	cmdq_thread_disable(cmdq, thread);
@@ -483,7 +289,6 @@ static struct mbox_chan *cmdq_xlate(struct mbox_controller *mbox,
 
 	thread = (struct cmdq_thread *)mbox->chans[ind].con_priv;
 	thread->priority = sp->args[1];
-	thread->atomic_exec = (sp->args[2] != 0);
 	thread->chan = &mbox->chans[ind];
 
 	return &mbox->chans[ind];
@@ -539,8 +344,7 @@ static int cmdq_probe(struct platform_device *pdev)
 	cmdq->mbox.ops = &cmdq_mbox_chan_ops;
 	cmdq->mbox.of_xlate = cmdq_xlate;
 
-	/* make use of TXDONE_BY_ACK */
-	cmdq->mbox.txdone_irq = false;
+	cmdq->mbox.txdone_irq = true;
 	cmdq->mbox.txdone_poll = false;
 
 	cmdq->thread = devm_kcalloc(dev, cmdq->thread_nr,
@@ -551,7 +355,6 @@ static int cmdq_probe(struct platform_device *pdev)
 	for (i = 0; i < cmdq->thread_nr; i++) {
 		cmdq->thread[i].base = cmdq->base + CMDQ_THR_BASE +
 				CMDQ_THR_SIZE * i;
-		INIT_LIST_HEAD(&cmdq->thread[i].task_busy_list);
 		cmdq->mbox.chans[i].con_priv = (void *)&cmdq->thread[i];
 	}
 
-- 
2.18.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
