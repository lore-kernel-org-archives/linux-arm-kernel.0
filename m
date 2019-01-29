Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F47C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:40:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFE872175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r26XCbcr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE872175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BnBeVlXQf/wk8cYrhb+xTryZeZPIXtToYYFpzJqa5kg=; b=r26XCbcrW8avEd
	H0yQDXUQnK/ktPKK/16cWAXLElwArMauHMX1ADhE5xboXLDuhNZQ2kjJpqyGo774uvwiz2lST8XtD
	ZZ1ZcHnAqawAUoS9C81kPNWr9cELJc8Z6ZKKhDH1fvDZcQKLjtttISzV5YrCY4uLy8HupLCL5bVdD
	pJEFaZaGS/ifXtrU7syCary75xLd9Yj0I4V9RWFrRngzjKnzthhyZ1ZQZOvAoPzMOJI9n/VqAx22F
	1B6cBIuaDttz5uLJ1tVJbTsSC8usjGGZYffZc+steFvXgGUqHZ68cI4h0Jqpd12nnGl5WVLW+R/k+
	j7aIv9bs95IjPLOMQYtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goO0Y-00074N-Bs; Tue, 29 Jan 2019 07:40:34 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goNtO-00050M-ET; Tue, 29 Jan 2019 07:33:21 +0000
X-UUID: 2f1138a1d0644f9b95c073215585d24b-20190128
X-UUID: 2f1138a1d0644f9b95c073215585d24b-20190128
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <bibby.hsieh@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1945524770; Mon, 28 Jan 2019 23:32:21 -0800
Received: from MTKMBS02N2.mediatek.inc (172.21.101.101) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 28 Jan 2019 23:32:21 -0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 29 Jan 2019 15:32:12 +0800
Received: from mtkslt302.mediatek.inc (10.21.14.115) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Tue, 29 Jan 2019 15:32:12 +0800
From: Bibby Hsieh <bibby.hsieh@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, CK HU
 <ck.hu@mediatek.com>
Subject: [PATCH 09/10] soc: mediatek: change the argument of write and
 write_mask API
Date: Tue, 29 Jan 2019 15:32:06 +0800
Message-ID: <1548747128-60136-10-git-send-email-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548747128-60136-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1548747128-60136-1-git-send-email-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 5CABCEE1B16ABE4A2AC62D473E6598E5333E263EFBD4220D2931816D65A199232000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_233310_770327_696FB15D 
X-CRM114-Status: GOOD (  13.11  )
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
Cc: devicetree@vger.kernel.org, Nicolas Boichat <drinkcat@chromium.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, srv_heupstream@mediatek.com,
 Daoyuan Huang <daoyuan.huang@mediatek.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 Daniel Kurtz <djkurtz@chromium.org>,
 Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>, kendrick.hsu@mediatek.com,
 linux-mediatek@lists.infradead.org, Houlong Wei <houlong.wei@mediatek.com>,
 Sascha
 Hauer <kernel@pengutronix.de>, Frederic Chen <Frederic.Chen@mediatek.com>,
 YT Shen <yt.shen@mediatek.com>, Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
 Bibby Hsieh <bibby.hsieh@mediatek.com>, linux-arm-kernel@lists.infradead.org,
 ginny.chen@mediatek.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In order to enhance the convienience of client usage,
we change the input argument from subsys and offset to
struct cmdq_base and dma_addr_t.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 24 +++++++++++++++++-------
 include/linux/soc/mediatek/mtk-cmdq.h  | 16 ++++++++--------
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 923a815..34ae712 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -238,8 +238,13 @@ static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, s16 arg_c, s16 arg_b,
 	return 0;
 }
 
-int cmdq_pkt_write(struct cmdq_pkt *pkt, u8 subsys, u16 offset, u32 value)
+int cmdq_pkt_write(struct cmdq_pkt *pkt, struct cmdq_base *clt_base,
+		   dma_addr_t addr, u32 value)
 {
+	const u32 base = (addr >> 32) ? 0 : addr & 0xFFFF0000;
+	u8 subsys = cmdq_subsys_base_to_id(clt_base, base);
+	s16 offset = addr & 0x0000FFFF;
+
 	return cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(value),
 				       CMDQ_GET_ARG_B(value), offset, subsys,
 				       CMDQ_IMMEDIATE_VALUE,
@@ -248,21 +253,26 @@ int cmdq_pkt_write(struct cmdq_pkt *pkt, u8 subsys, u16 offset, u32 value)
 }
 EXPORT_SYMBOL(cmdq_pkt_write);
 
-int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u8 subsys, u16 offset,
-			u32 value, u32 mask)
+int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, struct cmdq_base *clt_base,
+			dma_addr_t addr, u32 value, u32 mask)
 {
-	u32 offset_mask = offset;
+	const u32 base = (addr >> 32) ? 0 : addr & 0xFFFF0000;
+	u8 subsys = cmdq_subsys_base_to_id(clt_base, base);
+	s16 offset = addr & 0x0000FFFF;
 	int err = 0;
 
 	if (mask != 0xffffffff) {
 		err = cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(~mask),
 					      CMDQ_GET_ARG_B(~mask), 0, 0, 0, 0,
 					      0, CMDQ_CODE_MASK);
-		offset_mask |= CMDQ_WRITE_ENABLE_MASK;
+		offset |= CMDQ_WRITE_ENABLE_MASK;
 	}
-	err |= cmdq_pkt_write(pkt, subsys, offset_mask, value);
 
-	return err;
+	return cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(value),
+				       CMDQ_GET_ARG_B(value), offset, subsys,
+				       CMDQ_IMMEDIATE_VALUE,
+				       CMDQ_IMMEDIATE_VALUE,
+				       CMDQ_IMMEDIATE_VALUE, CMDQ_CODE_WRITE);
 }
 EXPORT_SYMBOL(cmdq_pkt_write_mask);
 
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index e4d1876..230bc2b 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -70,26 +70,26 @@ struct cmdq_client *cmdq_mbox_create(struct device *dev, int index,
 /**
  * cmdq_pkt_write() - append write command to the CMDQ packet
  * @pkt:	the CMDQ packet
- * @subsys:	the CMDQ sub system code
- * @offset:	register offset from CMDQ sub system
+ * @cmdq_base:	the CMDQ sub system code and base address
+ * @addr:	register address
  * @value:	the specified target register value
  *
  * Return: 0 for success; else the error code is returned
  */
-int cmdq_pkt_write(struct cmdq_pkt *pkt, u8 subsys, u16 offset, u32 value);
-
+int cmdq_pkt_write(struct cmdq_pkt *pkt, struct cmdq_base *clt_base,
+		   dma_addr_t addr, u32 value);
 /**
  * cmdq_pkt_write_mask() - append write command with mask to the CMDQ packet
  * @pkt:	the CMDQ packet
- * @subsys:	the CMDQ sub system code
- * @offset:	register offset from CMDQ sub system
+ * @cmdq_base:	the CMDQ sub system code and base address
+ * @addr:	register address
  * @value:	the specified target register value
  * @mask:	the specified target register mask
  *
  * Return: 0 for success; else the error code is returned
  */
-int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u8 subsys, u16 offset,
-			u32 value, u32 mask);
+int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, struct cmdq_base *clt_base,
+			dma_addr_t addr, u32 value, u32 mask);
 
 /**
  * cmdq_pkt_wfe() - append wait for event command to the CMDQ packet
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
