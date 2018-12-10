Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B683DC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:44:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 846F620880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GOdz/llu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 846F620880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=cOQWA6qGJnhPfLFP2ZG0pr+z9QfUTLLGo7NeO1pKQbc=; b=GOdz/lluER8unM
	ll2Q44HdMz2DSBZph2PH6xrXbRrpEYLMu1vAZQ96vZ4QoarQfhAp20qZ0qNSL/Od8zx+JCPdsd3d5
	bQgQ/+ifrYbWcDaS6LtG3P6NEYyzF7cFep1blu9AzoTiXpsVaekHD0GHs2DDkQD4xIMB8WYerqdln
	4lM7+cZoREOFkSSlULG1FZu0QoIVfJ/Nj+bx66zF282+1sOhuMPg4V0Tg8MJX0P49FzplnVLnxRNr
	PBvxLrKBHN7ReJsQ+q1J4ldkrjrvnLRE+9fPA43842ZgH+wqiGJou8TQgjPx1Hf76wtEtWeRg/JxI
	1p7Zb0jBNcW985s5QHsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWJz1-0004gc-Ng; Mon, 10 Dec 2018 11:44:19 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWJyx-0004f9-CR; Mon, 10 Dec 2018 11:44:17 +0000
X-UUID: 78d59e2f836d44699d08c7e812b31ef2-20181210
X-UUID: 78d59e2f836d44699d08c7e812b31ef2-20181210
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by
 mailgw01.mediatek.com (envelope-from <jjian.zhou@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1090352921; Mon, 10 Dec 2018 19:43:57 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 10 Dec 2018 19:43:56 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 10 Dec 2018 19:43:55 +0800
From: Jjian Zhou <jjian.zhou@mediatek.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3] mmc: mediatek: Add MMC_CAP_SDIO_IRQ support
Date: Mon, 10 Dec 2018 19:43:53 +0800
Message-ID: <1544442233-20303-1-git-send-email-jjian.zhou@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_034415_674332_C1859859 
X-CRM114-Status: GOOD (  11.47  )
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
Cc: linux-arm-kernel@lists.infradead.org, Ryder Lee <ryder.lee@mediatek.com>,
 srv_heupstream@mediatek.com, Sean Wang <sean.wang@mediatek.com>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yong Mao <yong.mao@mediatek.com>, linux-mediatek@lists.infradead.org,
 Chaotian Jing <chaotian.jing@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 jjian zhou <jjian.zhou@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: jjian zhou <jjian.zhou@mediatek.com>

This patch enables support SDIO IRQs. It enables
MMC_CAP_SDIO_IRQ & MMC_CAP2_SDIO_IRQ_NOTHREAD
and implement the ->ack_sdio_irq callback.

Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
Signed-off-by: Yong Mao <yong.mao@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 49 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 6334cc7..40a1848 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1114,6 +1114,7 @@ static void msdc_start_command(struct msdc_host *host,
 		struct mmc_request *mrq, struct mmc_command *cmd)
 {
 	u32 rawcmd;
+	unsigned long flags;

 	WARN_ON(host->cmd);
 	host->cmd = cmd;
@@ -1131,7 +1132,10 @@ static void msdc_start_command(struct msdc_host *host,
 	cmd->error = 0;
 	rawcmd = msdc_cmd_prepare_raw_cmd(host, mrq, cmd);

+	spin_lock_irqsave(&host->lock, flags);
 	sdr_set_bits(host->base + MSDC_INTEN, cmd_ints_mask);
+	spin_unlock_irqrestore(&host->lock, flags);
+
 	writel(cmd->arg, host->base + SDC_ARG);
 	writel(rawcmd, host->base + SDC_CMD);
 }
@@ -1351,6 +1355,27 @@ static void msdc_request_timeout(struct work_struct *work)
 	}
 }

+static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
+{
+	unsigned long flags;
+	struct msdc_host *host = mmc_priv(mmc);
+
+	if (enb)
+		pm_runtime_get_sync(host->dev);
+
+	spin_lock_irqsave(&host->lock, flags);
+	if (enb)
+		sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
+	else
+		sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	if (!enb) {
+		pm_runtime_mark_last_busy(host->dev);
+		pm_runtime_put_autosuspend(host->dev);
+	}
+}
+
 static irqreturn_t msdc_irq(int irq, void *dev_id)
 {
 	struct msdc_host *host = (struct msdc_host *) dev_id;
@@ -1373,7 +1398,12 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
 		data = host->data;
 		spin_unlock_irqrestore(&host->lock, flags);

-		if (!(events & event_mask))
+		if ((events & event_mask) & MSDC_INT_SDIOIRQ) {
+			msdc_enable_sdio_irq(host->mmc, 0);
+			sdio_signal_irq(host->mmc);
+		}
+
+		if (!(events & (event_mask & ~MSDC_INT_SDIOIRQ)))
 			break;

 		if (!mrq) {
@@ -1493,8 +1523,11 @@ static void msdc_init_hw(struct msdc_host *host)
 	 */
 	sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIO);

-	/* disable detect SDIO device interrupt function */
-	sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
+	/* Config SDIO device detect interrupt function */
+	if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
+		sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
+	else
+		sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);

 	/* Configure to default data timeout */
 	sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
@@ -2013,6 +2046,11 @@ static void msdc_hw_reset(struct mmc_host *mmc)
 	sdr_clr_bits(host->base + EMMC_IOCON, 1);
 }

+static void msdc_ack_sdio_irq(struct mmc_host *mmc)
+{
+	msdc_enable_sdio_irq(mmc, 1);
+}
+
 static const struct mmc_host_ops mt_msdc_ops = {
 	.post_req = msdc_post_req,
 	.pre_req = msdc_pre_req,
@@ -2020,6 +2058,8 @@ static void msdc_hw_reset(struct mmc_host *mmc)
 	.set_ios = msdc_ops_set_ios,
 	.get_ro = mmc_gpio_get_ro,
 	.get_cd = mmc_gpio_get_cd,
+	.enable_sdio_irq = msdc_enable_sdio_irq,
+	.ack_sdio_irq = msdc_ack_sdio_irq,
 	.start_signal_voltage_switch = msdc_ops_switch_volt,
 	.card_busy = msdc_card_busy,
 	.execute_tuning = msdc_execute_tuning,
@@ -2147,6 +2187,9 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	else
 		mmc->f_min = DIV_ROUND_UP(host->src_clk_freq, 4 * 4095);

+	if (mmc->caps & MMC_CAP_SDIO_IRQ)
+		mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
+
 	mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
 	/* MMC core transfer sizes tunable parameters */
 	mmc->max_segs = MAX_BD_NUM;
--
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
