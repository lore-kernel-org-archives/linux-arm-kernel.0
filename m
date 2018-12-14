Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E904C67873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:04:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63AE120870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="foE0hcFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AE120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zjZC371fECONBeZT4Kv752q4By6AHtK0HHHfNwpYHLg=; b=foE0hcFRx5oANy
	j6eNz9NMi4mwCk3dZasgD4z38zSwAyERr2eGr18g6rcee4fArZ+XqAQlPhTc5FQFi0hnXtM8AS3m/
	sDtvoj/RNCYSxWUhZ7OrwFg4PAwGZIv19jVndV6FpIw042Ijc4hYQzrXe8mpVjWCw3GA8W0JHygHi
	9ejZqMyiAuR07+ffWFlbpvpyikdCMpd5/wBM/9M45YMpmIqqyIjh8/0mP1DyvKD8U73lFX0oTUSqU
	N/4f0V2uYcMzpWwzz1EhggQmu1panRS+oEVXFvvfnx9OxKeqUWZnSVfa+OkOe1QseG6fT2wEluaJz
	eWoJFBmPGPBrtrXTJNQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXcqU-0000g3-3c; Fri, 14 Dec 2018 02:04:54 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXcqQ-0000d8-4c; Fri, 14 Dec 2018 02:04:51 +0000
X-UUID: 19ee1892613e45daa65a7b9c047d64a3-20181214
X-UUID: 19ee1892613e45daa65a7b9c047d64a3-20181214
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by
 mailgw01.mediatek.com (envelope-from <weiyi.lu@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 744815289; Fri, 14 Dec 2018 10:04:24 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Dec 2018 10:04:19 +0800
Received: from mtkslt210.mediatek.inc (10.21.14.14) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Dec 2018 10:04:19 +0800
From: Weiyi Lu <weiyi.lu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Stephen Boyd
 <sboyd@codeaurora.org>, Rob Herring <robh@kernel.org>
Subject: [resend PATCH v1 2/2] clk: mediatek: update clock driver of MT2712
Date: Fri, 14 Dec 2018 10:04:17 +0800
Message-ID: <20181214020417.2871-4-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181214020417.2871-1-weiyi.lu@mediatek.com>
References: <20181214020417.2871-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: EF4EB2EA208F57F3D0056F890733E7F6D5DC0C35D23C0A7444B93812A9D9DE842000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_180450_307810_93668A9B 
X-CRM114-Status: UNSURE (   8.83  )
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
Cc: James Liao <jamesjj.liao@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
 srv_heupstream@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

According to 3rd ECO design change,
1. Add new fixed factor clock of audio.
2. Add the parent clocks for audio clock mux.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/clk/mediatek/clk-mt2712.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index 991d4093726e..e36f4aab634d 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -223,6 +223,8 @@ static const struct mtk_fixed_factor top_divs[] = {
 		4),
 	FACTOR(CLK_TOP_APLL1_D3, "apll1_d3", "apll1_ck", 1,
 		3),
+	FACTOR(CLK_TOP_APLL2_D3, "apll2_d3", "apll2_ck", 1,
+		3),
 };
 
 static const char * const axi_parents[] = {
@@ -594,7 +596,8 @@ static const char * const a1sys_hp_parents[] = {
 	"apll1_ck",
 	"apll1_d2",
 	"apll1_d4",
-	"apll1_d8"
+	"apll1_d8",
+	"apll1_d3"
 };
 
 static const char * const a2sys_hp_parents[] = {
@@ -602,7 +605,8 @@ static const char * const a2sys_hp_parents[] = {
 	"apll2_ck",
 	"apll2_d2",
 	"apll2_d4",
-	"apll2_d8"
+	"apll2_d8",
+	"apll2_d3"
 };
 
 static const char * const asm_l_parents[] = {
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
