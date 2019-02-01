Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BD4C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:30:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9343820869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rf781jYg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9343820869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DON4xi/3XOivTPuAaOVJ1phVBW2UjbeqFKJHVdR9ZMI=; b=rf781jYg5f9oBJ
	WD0bQoGYQ8FYsLGAHijtTW7S9VlD7mt3bNR3aD3PWPoTZBGRJNWO0GtS0AG3GGFvxrbARunkChDPg
	9s9ZKymK9ew/CLnbrzGMb7PB1iM8anqNrFN96MYnlel7p0gvBhtUL6OxvcAN57qrRnZaHoirCPQ+c
	jVnIPsIikkZdfBTx3JV2tSz6P45RPa11EFQFF9OlH1PPURn4LEeKzsA4TGvQBkY6W2EY7pQ01sYJ8
	CU4siH36S+SAJJU0ZFXAHFq36YALws2EzyyxPQT4Ue2VO20R4Zskl9doJqt0ONjFjCwH8aZV7Urdb
	+St3Ayaq4hE7wFN7DMxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpUDq-0007X7-Jf; Fri, 01 Feb 2019 08:30:50 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpUDX-0007GQ-Vr; Fri, 01 Feb 2019 08:30:33 +0000
X-UUID: 200325500573474a9fdbac610e8f20ac-20190201
X-UUID: 200325500573474a9fdbac610e8f20ac-20190201
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <weiyi.lu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1726601777; Fri, 01 Feb 2019 00:30:28 -0800
Received: from MTKMBS02N1.mediatek.inc (172.21.101.77) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 00:30:27 -0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 16:30:25 +0800
Received: from mtkslt210.mediatek.inc (10.21.14.14) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 16:30:25 +0800
From: Weiyi Lu <weiyi.lu@mediatek.com>
To: Nicolas Boichat <drinkcat@chromium.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, Rob Herring
 <robh@kernel.org>
Subject: [PATCH v4 03/12] clk: mediatek: add configurable pcwibits and fmin to
 mtk_pll_data
Date: Fri, 1 Feb 2019 16:30:07 +0800
Message-ID: <20190201083016.25856-5-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190201083016.25856-1-weiyi.lu@mediatek.com>
References: <20190201083016.25856-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_003032_024206_498DD785 
X-CRM114-Status: GOOD (  11.81  )
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
Cc: James Liao <jamesjj.liao@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
 srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>,
 linux-mediatek@lists.infradead.org, Owen Chen <owen.chen@mediatek.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Owen Chen <owen.chen@mediatek.com>

1. pcwibits: The integer bits of pcw for plls is extend to 8 bits,
   add a variable to indicate this change and
   backward-compatible.
2. fmin: The pll freqency lower-bound is vary from 1GMhz to
   1.5Ghz, add a variable to indicate platform-dependent.

Signed-off-by: Owen Chen <owen.chen@mediatek.com>
Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
Acked-by: Sean Wang <sean.wang@kernel.org>
---
 drivers/clk/mediatek/clk-mtk.h |  2 ++
 drivers/clk/mediatek/clk-pll.c | 15 +++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index f83c2bbb677e..11b5517903d0 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -214,8 +214,10 @@ struct mtk_pll_data {
 	unsigned int flags;
 	const struct clk_ops *ops;
 	u32 rst_bar_mask;
+	unsigned long fmin;
 	unsigned long fmax;
 	int pcwbits;
+	int pcwibits;
 	uint32_t pcw_reg;
 	int pcw_shift;
 	const struct mtk_pll_div_table *div_table;
diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index f0ff5f535c7e..cf444031bdfb 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -32,6 +32,8 @@
 #define AUDPLL_TUNER_EN		BIT(31)
 
 #define POSTDIV_MASK		0x7
+
+/* default 7 bits integer, can be overridden with pcwibits. */
 #define INTEGER_BITS		7
 
 /*
@@ -68,12 +70,15 @@ static unsigned long __mtk_pll_recalc_rate(struct mtk_clk_pll *pll, u32 fin,
 		u32 pcw, int postdiv)
 {
 	int pcwbits = pll->data->pcwbits;
-	int pcwfbits;
+	int pcwfbits = 0;
+	int ibits;
 	u64 vco;
 	u8 c = 0;
 
 	/* The fractional part of the PLL divider. */
-	pcwfbits = pcwbits > INTEGER_BITS ? pcwbits - INTEGER_BITS : 0;
+	ibits = pll->data->pcwibits ? pll->data->pcwibits : INTEGER_BITS;
+	if (pcwbits > ibits)
+		pcwfbits = pcwbits - ibits;
 
 	vco = (u64)fin * pcw;
 
@@ -167,9 +172,10 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
 static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
 		u32 freq, u32 fin)
 {
-	unsigned long fmin = 1000 * MHZ;
+	unsigned long fmin = pll->data->fmin ? pll->data->fmin : (1000 * MHZ);
 	const struct mtk_pll_div_table *div_table = pll->data->div_table;
 	u64 _pcw;
+	int ibits;
 	u32 val;
 
 	if (freq > pll->data->fmax)
@@ -193,7 +199,8 @@ static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
 	}
 
 	/* _pcw = freq * postdiv / fin * 2^pcwfbits */
-	_pcw = ((u64)freq << val) << (pll->data->pcwbits - INTEGER_BITS);
+	ibits = pll->data->pcwibits ? pll->data->pcwibits : INTEGER_BITS;
+	_pcw = ((u64)freq << val) << (pll->data->pcwbits - ibits);
 	do_div(_pcw, fin);
 
 	*pcw = (u32)_pcw;
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
