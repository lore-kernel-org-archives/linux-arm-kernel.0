Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9562CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:01:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47C8221906
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m8DGFkdd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C8221906
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iuFvQW3bUdi8ryC1TIJ+N+pqgxprPFv45/3xzvjw1LQ=; b=m8DGFkdd0QhyBH
	BN13TxWLEXK243Pidl+TFiH3uhemTtt2PmViFg3gLRHe/NNILBeJzkAiJjUipkpyU59U0X3m06V2H
	GY5rROhsos0JFbLVOgBpklrKch6nSV7aXOe+ALni2IEMGfDmhSbaTakrs9isOZ/zt/t8PY+bqHCn5
	RcF5NzhM53x0vAqzhhU+hCysRGXoo+cbxK4HxfktMF8J05kJaKCB79F5tETj8H+Z6MMHIfihyaunW
	uWVUuKc7BeI3cRdJCLdkV0ZdKhwrVfWuN8Tfx8VVUBU2cxzynA422yuouEaw792QnE1NqTVSaQk68
	o/sk2puaXbwfbK1h8qJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaKQ8-0003qM-0r; Fri, 21 Dec 2018 13:00:52 +0000
Received: from [210.61.82.184] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaKPH-0001Je-9Q; Fri, 21 Dec 2018 13:00:10 +0000
X-UUID: 3dcaf488c5c24a52ab458e341ded707b-20181221
X-UUID: 3dcaf488c5c24a52ab458e341ded707b-20181221
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
 (envelope-from <qii.wang@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1672867; Fri, 21 Dec 2018 20:59:02 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 21 Dec 2018 20:59:01 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 21 Dec 2018 20:59:01 +0800
From: qii wang <qii.wang@mediatek.com>
To: <wsa@the-dreams.de>
Subject: [PATCH 2/6] i2c: mediatek: speeds is replaced by macros definitions
Date: Fri, 21 Dec 2018 20:58:27 +0800
Message-ID: <1545397111-24183-3-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1545397111-24183-1-git-send-email-qii.wang@mediatek.com>
References: <1545397111-24183-1-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_045959_887240_FB92B30D 
X-CRM114-Status: GOOD (  10.20  )
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

Different speeds have been defined by macros,
so we use macros definitions.

Signed-off-by: qii wang <qii.wang@mediatek.com>
---
 drivers/i2c/busses/i2c-mt65xx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index a74ef76..7396449 100644
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
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
