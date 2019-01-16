Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A079C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:08:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19D3F20840
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="abE+sL8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D3F20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6w/hUyrELOJydmG2PsGbnJ8whTF8rnWj8SkWWDvp1Q4=; b=abE+sL8YCt2al8
	7+wvPAil6HOe4Rk6+dOW+bodJYxFj0qk6pySOc+I4LL1zF15i+/y415FFcRDgzjEAyXVGrMmmZIZN
	sDYwSyCmbBrGtxhxmx70PV7tMOy/UQAfivKcxuqE/zQwXc2VXeb3LKhA5wdqKl3W9NixYOjlGRQSu
	50h3wtsc1ndHvQD2Isw6s2ZO0c6NhUmzpWoTi8+z4j7VaI5+oiInOwhoAFbpv+lDIyDMzqZFmjEEG
	QOvqgpivd2gTlrSOsDstbOnK1DgyEOYluGvl+8BZN9Qr0HjZCFP0WS+ttLMvg16NSYOBCuepkysvl
	+60lkda5TQomPQtYwvJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjdQp-0006EG-S8; Wed, 16 Jan 2019 05:08:03 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjdQK-0005e8-Ai; Wed, 16 Jan 2019 05:07:33 +0000
X-UUID: 25ffdfcfd0044776b5b577dced84ea70-20190115
X-UUID: 25ffdfcfd0044776b5b577dced84ea70-20190115
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <ck.hu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1678661172; Tue, 15 Jan 2019 21:07:26 -0800
Received: from mtkmbs03n2.mediatek.inc (172.21.101.182) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 15 Jan 2019 21:07:24 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 16 Jan 2019 13:07:22 +0800
Received: from mtkslt305.mediatek.inc (10.21.14.140) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Wed, 16 Jan 2019 13:07:22 +0800
From: CK Hu <ck.hu@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Houlong Wei <houlong.wei@mediatek.com>
Subject: [PATCH 2/3] mailbox: mediatek: Implement abort_data function.
Date: Wed, 16 Jan 2019 13:04:34 +0800
Message-ID: <20190116050435.11624-3-ck.hu@mediatek.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190116050435.11624-1-ck.hu@mediatek.com>
References: <20190116050435.11624-1-ck.hu@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 69A7877979E11386BBE973F251CDFD145478041FA21F307B5E29E033EBCC8AFE2000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_210732_369915_0C60CD45 
X-CRM114-Status: UNSURE (   9.87  )
X-CRM114-Notice: Please train this message.
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

For client driver which need to reorganize the command buffer, it could
use this function to abort the sent but not executed command buffer.

Signed-off-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 40 ++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 22811784dc7d..f2219f263ef6 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -417,6 +417,45 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
 	return 0;
 }
 
+static void cmdq_mbox_abort_data(struct mbox_chan *chan)
+{
+	struct cmdq_thread *thread = (struct cmdq_thread *)chan->con_priv;
+	struct cmdq *cmdq = dev_get_drvdata(chan->mbox->dev);
+	struct cmdq_task *task, *tmp;
+	unsigned long flags;
+	u32 enable;
+
+	spin_lock_irqsave(&thread->chan->lock, flags);
+	if (list_empty(&thread->task_busy_list))
+		goto out;
+
+	WARN_ON(cmdq_thread_suspend(cmdq, thread) < 0);
+	if (!cmdq_thread_is_in_wfe(thread))
+		goto wait;
+
+	list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
+				 list_entry) {
+		list_del(&task->list_entry);
+		kfree(task);
+	}
+
+	cmdq_thread_resume(thread);
+	cmdq_thread_disable(cmdq, thread);
+	clk_disable(cmdq->clock);
+
+out:
+	spin_unlock_irqrestore(&thread->chan->lock, flags);
+	return;
+
+wait:
+	cmdq_thread_resume(thread);
+	spin_unlock_irqrestore(&thread->chan->lock, flags);
+	if (readl_poll_timeout_atomic(thread->base + CMDQ_THR_ENABLE_TASK,
+				      enable, !enable, 1, 20))
+		dev_err(cmdq->mbox.dev, "Fail to wait GCE thread 0x%x done\n",
+			(u32)(thread->base - cmdq->base));
+}
+
 static int cmdq_mbox_startup(struct mbox_chan *chan)
 {
 	return 0;
@@ -427,6 +466,7 @@ static void cmdq_mbox_shutdown(struct mbox_chan *chan)
 }
 
 static const struct mbox_chan_ops cmdq_mbox_chan_ops = {
+	.abort_data = cmdq_mbox_abort_data,
 	.send_data = cmdq_mbox_send_data,
 	.startup = cmdq_mbox_startup,
 	.shutdown = cmdq_mbox_shutdown,
-- 
2.18.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
