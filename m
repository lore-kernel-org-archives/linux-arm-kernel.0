Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4AEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:10:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B56920989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dyuehmnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B56920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AMT/hcXd6nzCJVK1RU4YNM77hQpg53aNWD9Ax71BqdI=; b=dyuehmnmv9xWXN
	sP5M0XEID4h8TkhJHCZWOx30E+v1ZR3Oqt+PFlrLbt0Jl0yxIABbP8tZw0XkkiPG6JJwKr9+iH0ek
	EdjEUMVkgDkSAK1iXXllnmK/1jNHl9zLgEixzGFKbiyj2GPCpBdwfsyx9/fVcsBXI629J6wHBEzOW
	HXcofvcjA++Rnk303VA2XZIZUNLu6XnHZPL+ubxIWodbEB1KFZGMuSNCYGoA2jnqtw/ejvyrW8fPD
	73w4D1e/fSLPfr6RNnm8y7LzQHNQ0ui4gMD6qaRA4PTTmS66AmB6vylDnXO92ahDRverdjFuz4hBK
	di9jrqz5gC0wWVQuzZFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy5ip-0004Zq-T9; Mon, 25 Feb 2019 02:10:23 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy5iY-0003Ex-Bz; Mon, 25 Feb 2019 02:10:08 +0000
X-UUID: a732d591615546bc8547be8b57c5b9dd-20190224
X-UUID: a732d591615546bc8547be8b57c5b9dd-20190224
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <wangyan.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1518121534; Sun, 24 Feb 2019 18:09:39 -0800
Received: from MTKMBS33DR.mediatek.inc (172.27.6.106) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 24 Feb 2019 18:09:37 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Mon, 25 Feb 2019 10:09:35 +0800
Received: from mszsdaap41.mediatek.inc (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 25 Feb 2019 10:09:34 +0800
From: wangyan wang <wangyan.wang@mediatek.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, CK Hu <ck.hu@mediatek.com>
Subject: [PATCH V6 5/8] clk: mediatek: add MUX_GATE_FLAGS_2
Date: Mon, 25 Feb 2019 10:09:09 +0800
Message-ID: <20190225020912.29120-6-wangyan.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190225020912.29120-1-wangyan.wang@mediatek.com>
References: <20190225020912.29120-1-wangyan.wang@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_181006_605371_747FAFA8 
X-CRM114-Status: GOOD (  10.47  )
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
Cc: Ryder Lee <ryder.lee@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 srv_heupstream@mediatek.com, chunhui dai <chunhui.dai@mediatek.com>, David
 Airlie <airlied@linux.ie>, Sean
 Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
 wangyan wang <wangyan.wang@mediatek.com>, linux-mediatek@lists.infradead.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Colin Ian King <colin.king@canonical.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: chunhui dai <chunhui.dai@mediatek.com>

Add MUX_GATE_FLAGS_2 for the clock which needs to set two falgs.
Such as some mux need to set the flags of "CLK_MUX_ROUND_CLOSEST".

Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
Signed-off-by: wangyan wang <wangyan.wang@mediatek.com>
---
 drivers/clk/mediatek/clk-mtk.c |  2 +-
 drivers/clk/mediatek/clk-mtk.h | 20 ++++++++++++++------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 9c0ae4278a94..2ed996404804 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -167,7 +167,7 @@ struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
 		mux->mask = BIT(mc->mux_width) - 1;
 		mux->shift = mc->mux_shift;
 		mux->lock = lock;
-
+		mux->flags = mc->mux_flags;
 		mux_hw = &mux->hw;
 		mux_ops = &clk_mux_ops;
 
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index f83c2bbb677e..4b88d196d52f 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -81,15 +81,13 @@ struct mtk_composite {
 	signed char divider_shift;
 	signed char divider_width;
 
+	u8 mux_flags;
+
 	signed char num_parents;
 };
 
-/*
- * In case the rate change propagation to parent clocks is undesirable,
- * this macro allows to specify the clock flags manually.
- */
-#define MUX_GATE_FLAGS(_id, _name, _parents, _reg, _shift, _width,	\
-			_gate, _flags) {				\
+#define MUX_GATE_FLAGS_2(_id, _name, _parents, _reg, _shift,		\
+				_width, _gate, _flags, _muxflags) {	\
 		.id = _id,						\
 		.name = _name,						\
 		.mux_reg = _reg,					\
@@ -101,8 +99,18 @@ struct mtk_composite {
 		.parent_names = _parents,				\
 		.num_parents = ARRAY_SIZE(_parents),			\
 		.flags = _flags,					\
+		.mux_flags = _muxflags,					\
 	}
 
+/*
+ * In case the rate change propagation to parent clocks is undesirable,
+ * this macro allows to specify the clock flags manually.
+ */
+#define MUX_GATE_FLAGS(_id, _name, _parents, _reg, _shift, _width,	\
+			_gate, _flags)					\
+		MUX_GATE_FLAGS_2(_id, _name, _parents, _reg,		\
+					_shift, _width, _gate, _flags, 0)
+
 /*
  * Unless necessary, all MUX_GATE clocks propagate rate changes to their
  * parent clock by default.
-- 
2.14.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
