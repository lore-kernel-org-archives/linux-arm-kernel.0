Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93ECFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:12:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 648F6217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Karm056h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648F6217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f5LDnWdIg+nd5ljlzQLLdmq/GATiJHE83Ngg52pjVaU=; b=Karm056hQVrow+
	oMS4pOBPXmR3jubWYMyJzCA/ip++3x6jblAarZ+lWxiJfjsiV3dRWEP5gCcxVYfpaqqEu4eIGLHIt
	PTM76N2Ke7Aqk8FOOS2XWlGfredBf0aC2OHDSNCASvl40sHNzADXXtI1iuFNHuzqBbKxq3qxR0sw5
	EkLx/NOIS26EWvJ9pefY08jAYYOXpNqqW7qENwPrtUK5E2SkMF2BYeIYi4EXDZI+v4cGLdGqLhC4D
	a4FUT/CzCdc2K5wB4TGXkUcI/8yjWsttkk9/JkBO8jxEUEG9SyacbjRKzoBi9OOYsttlL5bApAzch
	7FBRdds3RA19KTGi9g/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gycWv-0004Qh-H5; Tue, 26 Feb 2019 13:12:17 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gycWr-00049l-7e; Tue, 26 Feb 2019 13:12:14 +0000
X-UUID: 947dd91a672e445599f189b3bfadbfe0-20190226
X-UUID: 947dd91a672e445599f189b3bfadbfe0-20190226
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <qii.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1143948791; Tue, 26 Feb 2019 05:11:40 -0800
Received: from mtkmbs03n2.mediatek.inc (172.21.101.182) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 26 Feb 2019 05:11:38 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 26 Feb 2019 21:11:32 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 26 Feb 2019 21:11:32 +0800
From: Qii Wang <qii.wang@mediatek.com>
To: <wsa@the-dreams.de>
Subject: [PATCH v5 5/5] i2c: mediatek: Add i2c support for MediaTek MT8183
Date: Tue, 26 Feb 2019 21:11:00 +0800
Message-ID: <1551186660-16902-6-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1551186660-16902-1-git-send-email-qii.wang@mediatek.com>
References: <1551186660-16902-1-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 11B92B1443A08D297F05AA5B6C5DF1EF231F38301BBC7109F8EECBA4F7780E572000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_051213_274724_0FFC1FE3 
X-CRM114-Status: GOOD (  13.52  )
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
Cc: devicetree@vger.kernel.org, qii.wang@mediatek.com,
 srv_heupstream@mediatek.com, robh@kernel.org, leilk.liu@mediatek.com,
 xinping.qian@mediatek.com, linux-kernel@vger.kernel.org,
 liguo.zhang@mediatek.com, linux-mediatek@lists.infradead.org,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add i2c compatible for MT8183. Compare to MT2712 i2c controller,
MT8183 has different register offsets. Ltiming_reg is added to
adjust low width of SCL. Arb clock and dma_sync are needed.

Signed-off-by: Qii Wang <qii.wang@mediatek.com>
---
 drivers/i2c/busses/i2c-mt65xx.c |   53 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 75d88e1..82eedbd 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -133,6 +133,8 @@ enum I2C_REGS_OFFSET {
 	OFFSET_DEBUGCTRL,
 	OFFSET_TRANSFER_LEN_AUX,
 	OFFSET_CLOCK_DIV,
+	/* MT8183 only regs */
+	OFFSET_LTIMING,
 };
 
 static const u16 mt_i2c_regs_v1[] = {
@@ -162,6 +164,32 @@ enum I2C_REGS_OFFSET {
 	[OFFSET_CLOCK_DIV] = 0x70,
 };
 
+static const u16 mt_i2c_regs_v2[] = {
+	[OFFSET_DATA_PORT] = 0x0,
+	[OFFSET_SLAVE_ADDR] = 0x4,
+	[OFFSET_INTR_MASK] = 0x8,
+	[OFFSET_INTR_STAT] = 0xc,
+	[OFFSET_CONTROL] = 0x10,
+	[OFFSET_TRANSFER_LEN] = 0x14,
+	[OFFSET_TRANSAC_LEN] = 0x18,
+	[OFFSET_DELAY_LEN] = 0x1c,
+	[OFFSET_TIMING] = 0x20,
+	[OFFSET_START] = 0x24,
+	[OFFSET_EXT_CONF] = 0x28,
+	[OFFSET_LTIMING] = 0x2c,
+	[OFFSET_HS] = 0x30,
+	[OFFSET_IO_CONFIG] = 0x34,
+	[OFFSET_FIFO_ADDR_CLR] = 0x38,
+	[OFFSET_TRANSFER_LEN_AUX] = 0x44,
+	[OFFSET_CLOCK_DIV] = 0x48,
+	[OFFSET_SOFTRESET] = 0x50,
+	[OFFSET_DEBUGSTAT] = 0xe0,
+	[OFFSET_DEBUGCTRL] = 0xe8,
+	[OFFSET_FIFO_STAT] = 0xf4,
+	[OFFSET_FIFO_THRESH] = 0xf8,
+	[OFFSET_DCM_EN] = 0xf88,
+};
+
 struct mtk_i2c_compatible {
 	const struct i2c_adapter_quirks *quirks;
 	const u16 *regs;
@@ -195,6 +223,7 @@ struct mtk_i2c {
 	enum mtk_trans_op op;
 	u16 timing_reg;
 	u16 high_speed_reg;
+	u16 ltiming_reg;
 	unsigned char auto_restart;
 	bool ignore_restart_irq;
 	const struct mtk_i2c_compatible *dev_comp;
@@ -271,12 +300,24 @@ struct mtk_i2c {
 	.dma_sync = 0,
 };
 
+static const struct mtk_i2c_compatible mt8183_compat = {
+	.regs = mt_i2c_regs_v2,
+	.pmic_i2c = 0,
+	.dcm = 0,
+	.auto_restart = 1,
+	.aux_len_reg = 1,
+	.support_33bits = 1,
+	.timing_adjust = 1,
+	.dma_sync = 1,
+};
+
 static const struct of_device_id mtk_i2c_of_match[] = {
 	{ .compatible = "mediatek,mt2712-i2c", .data = &mt2712_compat },
 	{ .compatible = "mediatek,mt6577-i2c", .data = &mt6577_compat },
 	{ .compatible = "mediatek,mt6589-i2c", .data = &mt6589_compat },
 	{ .compatible = "mediatek,mt7622-i2c", .data = &mt7622_compat },
 	{ .compatible = "mediatek,mt8173-i2c", .data = &mt8173_compat },
+	{ .compatible = "mediatek,mt8183-i2c", .data = &mt8183_compat },
 	{}
 };
 MODULE_DEVICE_TABLE(of, mtk_i2c_of_match);
@@ -361,6 +402,8 @@ static void mtk_i2c_init_hw(struct mtk_i2c *i2c)
 
 	mtk_i2c_writew(i2c, i2c->timing_reg, OFFSET_TIMING);
 	mtk_i2c_writew(i2c, i2c->high_speed_reg, OFFSET_HS);
+	if (i2c->dev_comp->regs == mt_i2c_regs_v2)
+		mtk_i2c_writew(i2c, i2c->ltiming_reg, OFFSET_LTIMING);
 
 	/* If use i2c pin from PMIC mt6397 side, need set PATH_DIR first */
 	if (i2c->have_pmic)
@@ -460,6 +503,8 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk)
 	unsigned int clk_src;
 	unsigned int step_cnt;
 	unsigned int sample_cnt;
+	unsigned int l_step_cnt;
+	unsigned int l_sample_cnt;
 	unsigned int target_speed;
 	int ret;
 
@@ -469,11 +514,11 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk)
 	if (target_speed > MAX_FS_MODE_SPEED) {
 		/* Set master code speed register */
 		ret = mtk_i2c_calculate_speed(i2c, clk_src, MAX_FS_MODE_SPEED,
-					      &step_cnt, &sample_cnt);
+					      &l_step_cnt, &l_sample_cnt);
 		if (ret < 0)
 			return ret;
 
-		i2c->timing_reg = (sample_cnt << 8) | step_cnt;
+		i2c->timing_reg = (l_sample_cnt << 8) | l_step_cnt;
 
 		/* Set the high speed mode register */
 		ret = mtk_i2c_calculate_speed(i2c, clk_src, target_speed,
@@ -483,6 +528,8 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk)
 
 		i2c->high_speed_reg = I2C_TIME_DEFAULT_VALUE |
 			(sample_cnt << 12) | (step_cnt << 8);
+		i2c->ltiming_reg = (l_sample_cnt << 6) | l_step_cnt |
+				   (sample_cnt << 12) | (step_cnt << 9);
 	} else {
 		ret = mtk_i2c_calculate_speed(i2c, clk_src, target_speed,
 					      &step_cnt, &sample_cnt);
@@ -493,6 +540,8 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk)
 
 		/* Disable the high speed transaction */
 		i2c->high_speed_reg = I2C_TIME_CLR_VALUE;
+
+		i2c->ltiming_reg = (sample_cnt << 6) | step_cnt;
 	}
 
 	return 0;
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
