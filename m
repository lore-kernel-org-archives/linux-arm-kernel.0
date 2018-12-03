Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9644C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:34:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 988D620850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bdo2RBkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988D620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xhCGOcEyqKF9gHpBPh+h4Jc8Cq55pksiaQp5d1hhzlA=; b=bdo2RBkxZyn4+9
	oe8Bimy7rAMi4qQ7W+4FG6IRVIY6c2pFJmCrAVbUGDswnD1hz/+9GiNvd/JLUg0DN4fru9pFoyg4S
	5GlMvT76pU87PBuiG31u0iLWPU8A4NSxfDbyq2q4H4X2DAukug1GTtK9VDhdzTv7MvICoULPprNTJ
	ahDF7UkVdPempeYCI4AbpNz4t8D1JKK/PtQftn/AeGigQOtdF15j934BWxC202X0L2XpJFbdYFFiO
	ctdalplMuzOufcwRHHG+j5JFkb41CbiWuXf8nJXxhidJV+/S6FpZKBGpvZqFgbrPZN2ngravQ+/95
	pUXQrSeHl0BS7LfkbroQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gToMn-0007Hm-AI; Mon, 03 Dec 2018 13:34:29 +0000
Received: from [210.61.82.184] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gToMC-0006by-CP; Mon, 03 Dec 2018 13:33:54 +0000
X-UUID: 4c2c5a6177de4ddea95e434658bf045b-20181203
X-UUID: 4c2c5a6177de4ddea95e434658bf045b-20181203
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw02.mediatek.com (envelope-from <qii.wang@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1093234821; Mon, 03 Dec 2018 21:33:22 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 3 Dec 2018 21:33:13 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 3 Dec 2018 21:33:13 +0800
From: <qii.wang@mediatek.com>
To: <wsa@the-dreams.de>
Subject: [PATCH 2/5] i2c: mediatek: remove useless code and replace definitions
Date: Mon, 3 Dec 2018 21:32:51 +0800
Message-ID: <1543843974-4054-3-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com>
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 96542F084A7B41856A9BCC3EA707BFFA2BB1E33880D4F72E327DA73DD87F6D582000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_053352_713547_46661813 
X-CRM114-Status: GOOD (  10.08  )
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
Cc: devicetree@vger.kernel.org, ryder.lee@mediatek.com, qii.wang@mediatek.com,
 srv_heupstream@mediatek.com, leilk.liu@mediatek.com,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: qii wang <qii.wang@mediatek.com>

Completion_done is useless when we don't use its return value,
so we remove it. Different speeds have been defined by macros,
so we use macros definitions.

Signed-off-by: qii wang <qii.wang@mediatek.com>
---
 drivers/i2c/busses/i2c-mt65xx.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index a74ef76..660de1e 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -456,7 +456,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 
 	control_reg = readw(i2c->base + OFFSET_CONTROL) &
 			~(I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS);
-	if ((i2c->speed_hz > 400000) || (left_num >= 1))
+	if ((i2c->speed_hz > MAX_FS_MODE_SPEED) || (left_num >= 1))
 		control_reg |= I2C_CONTROL_RS;
 
 	if (i2c->op == I2C_MASTER_WRRD)
@@ -465,7 +465,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 	writew(control_reg, i2c->base + OFFSET_CONTROL);
 
 	/* set start condition */
-	if (i2c->speed_hz <= 100000)
+	if (i2c->speed_hz <= I2C_DEFAULT_SPEED)
 		writew(I2C_ST_START_CON, i2c->base + OFFSET_EXT_CONF);
 	else
 		writew(I2C_FS_START_CON, i2c->base + OFFSET_EXT_CONF);
@@ -642,8 +642,6 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 		return -ETIMEDOUT;
 	}
 
-	completion_done(&i2c->msg_complete);
-
 	if (i2c->irq_stat & (I2C_HS_NACKERR | I2C_ACKERR)) {
 		dev_dbg(i2c->dev, "addr: %x, transfer ACK error\n", msgs->addr);
 		mtk_i2c_init_hw(i2c);
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
