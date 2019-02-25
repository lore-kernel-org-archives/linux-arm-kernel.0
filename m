Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6A6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:11:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E6B220989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cFldSb3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6B220989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xa24+6W4uZRrDa5E6IK4mohviLjERzfsrbBSa0cpu1I=; b=cFldSb3Fb8yUuD
	gbvPiICHb7JJeTImo96r9a5cMkF7HKGRvOh9ILfwl8E9R7aGBwyjdRIK+JFBsV7ewK5NPUxFX+gzm
	Sb1xrFiYqqJIUZuTpTXy/HFfzVnehnT8eJH5lmKDdCOYLZWBNIR/cXYgaiqDo00r/c9vXWedjCLcP
	05FWMSRPLvxR7/S9nbCKXD9W6xVe8fh/Womy6KA3OyfqWgmU0OhBdneZaoIXrIFdNWRKcTi/o4PGF
	j30BuWDJ1D+jlZDkNbQSnMd6NMYLFT2GnZ96gwI6M1X7t3F2w5/4RFZFOVxZgnrL3tIdD7kBTn7Yb
	YA17OgoVR/RHPbTN6+fw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy5k4-0006Kq-JK; Mon, 25 Feb 2019 02:11:40 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy5ig-0004Iw-RN; Mon, 25 Feb 2019 02:10:17 +0000
X-UUID: 2c6bad6b3a1049179ab5b65a32af4532-20190224
X-UUID: 2c6bad6b3a1049179ab5b65a32af4532-20190224
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <wangyan.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 2037158252; Sun, 24 Feb 2019 18:09:36 -0800
Received: from MTKMBS33N1.mediatek.inc (172.27.4.75) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 24 Feb 2019 18:09:34 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Mon, 25 Feb 2019 10:09:32 +0800
Received: from mszsdaap41.mediatek.inc (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 25 Feb 2019 10:09:31 +0800
From: wangyan wang <wangyan.wang@mediatek.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, CK Hu <ck.hu@mediatek.com>
Subject: [PATCH V6 4/8] drm/mediatek: fix the rate and divder of hdmi phy for
 MT2701
Date: Mon, 25 Feb 2019 10:09:08 +0800
Message-ID: <20190225020912.29120-5-wangyan.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190225020912.29120-1-wangyan.wang@mediatek.com>
References: <20190225020912.29120-1-wangyan.wang@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_181015_135370_BA6052FF 
X-CRM114-Status: UNSURE (   9.95  )
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

Due to a clerical error,there is one zero less for 12800000.
Fix it for 128000000.

Fixes: 0fc721b2968e ("drm/mediatek: add hdmi driver for MT2701 and MT7623")

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
Signed-off-by: wangyan wang <wangyan.wang@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
index 43bc058d5528..88dd9e812ca0 100644
--- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
@@ -114,8 +114,8 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	if (rate <= 64000000)
 		pos_div = 3;
-	else if (rate <= 12800000)
-		pos_div = 1;
+	else if (rate <= 128000000)
+		pos_div = 2;
 	else
 		pos_div = 1;
 
-- 
2.14.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
