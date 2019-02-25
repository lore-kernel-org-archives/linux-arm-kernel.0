Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4E7C00319
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:09:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE387213F2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GdVmZSG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE387213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=wUdW07RxRG3JLwpxD9zur8frYcVsELqfNdTUJNlMSEM=; b=GdVmZSG9Yg9QWt
	ouQ2D18YJA4Sx4KQwizVNWj6TALHirxq2mRv1A++hB9glze2nJsk/5INU+6LU4itep3FpdjN+pwrv
	pHEHZmsItzTKqCS+W4ibNUb7GwSM9YOH3XHEsrxh49hj49VKT+SgS4xcUBwiEVmf6n2aARhBrXikb
	PBCNlJhoCnAyKjQeI1Qx/uRghUmWi3nSF5izyCARYJ4sGUYUwYs4/dhZ7lzE9fadOZT7L72wJYZ5u
	W4W3jA98dU73cB72dDWTcaOc80ulwpV+zFhcYUjtFnSFmNvooEjIMluB41u2AwO0jDlsNiwMVteXN
	xeBcOtYFQrK7t0LwaRzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy5i0-0002XR-CI; Mon, 25 Feb 2019 02:09:32 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy5hw-0002WO-S3; Mon, 25 Feb 2019 02:09:30 +0000
X-UUID: 6a1b38d5a179483bb1e69063e346c162-20190224
X-UUID: 6a1b38d5a179483bb1e69063e346c162-20190224
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <wangyan.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1562599369; Sun, 24 Feb 2019 18:09:22 -0800
Received: from MTKMBS33N2.mediatek.inc (172.27.4.76) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 24 Feb 2019 18:09:20 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Mon, 25 Feb 2019 10:09:18 +0800
Received: from mszsdaap41.mediatek.inc (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 25 Feb 2019 10:09:17 +0800
From: wangyan wang <wangyan.wang@mediatek.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, CK Hu <ck.hu@mediatek.com>
Subject: [PATCH V6 0/8] make mt7623 clock of hdmi stable
Date: Mon, 25 Feb 2019 10:09:04 +0800
Message-ID: <20190225020912.29120-1-wangyan.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_180928_912015_BBD907B0 
X-CRM114-Status: UNSURE (   8.57  )
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

From: Wangyan Wang <wangyan.wang@mediatek.com>

V6 adopt maintainer's suggestion.
Here is the change list between V5 & V6
1. change "unsigned char mux_flags;" to "u8 mux_flags;" to
match with the struct in " clk: mediatek: add MUX_GATE_FLAGS_2".


chunhui dai (8):
  drm/mediatek: recalculate hdmi phy clock of MT2701 by querying
    hardware
  drm/mediatek: move the setting of fixed divider
  drm/mediatek: using different flags of clk for HDMI phy
  drm/mediatek: fix the rate and divder of hdmi phy for MT2701
  clk: mediatek: add MUX_GATE_FLAGS_2
  clk: mediatek: using CLK_MUX_ROUND_CLOSEST for the clock of dpi1_sel
  drm/mediatek: using new factor for tvdpll in MT2701
  drm/mediatek: fix the rate of parent for hdmi phy in MT2701

 drivers/clk/mediatek/clk-mt2701.c              |  4 +-
 drivers/clk/mediatek/clk-mtk.c                 |  2 +-
 drivers/clk/mediatek/clk-mtk.h                 | 20 ++++++---
 drivers/gpu/drm/mediatek/mtk_dpi.c             |  8 ++--
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 34 ++++------------
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  7 +---
 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 56 +++++++++++++++++++++++---
 drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c | 23 +++++++++++
 8 files changed, 102 insertions(+), 52 deletions(-)

-- 
2.14.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
