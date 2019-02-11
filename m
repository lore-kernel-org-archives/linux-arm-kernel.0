Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D958C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:18:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F4CB20836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JBx+s/pU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4CB20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2dR8n/UNnib0HEjwyU3xzeKckePaZSOZxeJrvfnzLg4=; b=JBx+s/pUt2TgTu
	0g7yMeXXssDw90JroKXtEJycyNqOGxN4MwAJqWZ4d/bzah2QoSL0AGZWvn1h0ZDcksIbVqoHd+QRZ
	go9AiiPOC9T1qjbvsRFCS6Z6bvaw3s3e10PQ5fHWWDot8jSvrDAnDXUdCWenmYhV6/33FwGA/tJUD
	ShNBM/ASBXPKCShi4emvR07oL8HQ2P7r+ZsKqHLvy8nb1NTpMoRc2OzrNEWKrMwL/MXgyj8uCLG9E
	zANAVXYqwHLErMKXsgHCu2f4KAtzfh13GA/NJeF3aDU1kcwWFZ9YlbiZuxHtZz0KMlANqzsYr/f/i
	DigsOAePXbeWjh32iPVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt5qp-0001bS-Mw; Mon, 11 Feb 2019 07:17:59 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt5qi-0001TZ-Vx; Mon, 11 Feb 2019 07:17:55 +0000
X-UUID: b81607002d6747eda26633ae9da93a2c-20190210
X-UUID: b81607002d6747eda26633ae9da93a2c-20190210
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <seiya.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 278735624; Sun, 10 Feb 2019 23:17:46 -0800
Received: from mtkmbs08n1.mediatek.inc (172.21.101.55) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 10 Feb 2019 23:17:45 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 11 Feb 2019 15:17:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Mon, 11 Feb 2019 15:17:43 +0800
From: Seiya Wang <seiya.wang@mediatek.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v1 2/2] clk: mediatek: correct cpu clock name for MT8173 SoC
Date: Mon, 11 Feb 2019 15:15:55 +0800
Message-ID: <20190211071555.31430-2-seiya.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190211071555.31430-1-seiya.wang@mediatek.com>
References: <20190211071555.31430-1-seiya.wang@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_231753_551516_B9CAE409 
X-CRM114-Status: GOOD (  10.35  )
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
Cc: devicetree@vger.kernel.org, Seiya Wang <seiya.wang@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Change cpu clock name from ca57 to ca72 since MT8173 does use cortex-a72.

Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
---
 drivers/clk/mediatek/clk-mt8173.c      | 4 ++--
 include/dt-bindings/clock/mt8173-clk.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 96c292c3e440..deedeb3ea33b 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -533,7 +533,7 @@ static const char * const ca53_parents[] __initconst = {
 	"univpll"
 };
 
-static const char * const ca57_parents[] __initconst = {
+static const char * const ca72_parents[] __initconst = {
 	"clk26m",
 	"armca15pll",
 	"mainpll",
@@ -542,7 +542,7 @@ static const char * const ca57_parents[] __initconst = {
 
 static const struct mtk_composite cpu_muxes[] __initconst = {
 	MUX(CLK_INFRA_CA53SEL, "infra_ca53_sel", ca53_parents, 0x0000, 0, 2),
-	MUX(CLK_INFRA_CA57SEL, "infra_ca57_sel", ca57_parents, 0x0000, 2, 2),
+	MUX(CLK_INFRA_CA72SEL, "infra_ca72_sel", ca72_parents, 0x0000, 2, 2),
 };
 
 static const struct mtk_composite top_muxes[] __initconst = {
diff --git a/include/dt-bindings/clock/mt8173-clk.h b/include/dt-bindings/clock/mt8173-clk.h
index 8aea623dd518..f7e5356fd602 100644
--- a/include/dt-bindings/clock/mt8173-clk.h
+++ b/include/dt-bindings/clock/mt8173-clk.h
@@ -194,7 +194,7 @@
 #define CLK_INFRA_PMICWRAP		11
 #define CLK_INFRA_CLK_13M		12
 #define CLK_INFRA_CA53SEL               13
-#define CLK_INFRA_CA57SEL               14
+#define CLK_INFRA_CA72SEL               14
 #define CLK_INFRA_NR_CLK                15
 
 /* PERI_SYS */
-- 
2.14.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
