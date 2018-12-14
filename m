Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2D8C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:05:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 978C220870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hlS+OlDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978C220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Rcd0n8e2/6JLj5lIhf87Ukfkw9iIFLJDw+rBK91E59I=; b=hlS+OlDN8jeY1v
	cood90B+ywmTKQP7NOk5yLsGgY6l2RCuuqa5fc5Iw5KRJR9jPnRti43I9CHYabYIV/ncmD7NmpDt1
	xaIgYICxilLdoGuxXHuoe+tgaAwvOOW4dxtAxTILuZZDX/ZCS2csIZDjWfoGDCcLKuV9sfSA5e8fB
	tJ2IsJxqAFgMp59tBfE3GI32y7dAxSPRbpSAVDNUCn+C5SmflNAMnzfCdQzBOb25J3wGW6zmIAt9Z
	Ub0hH1ix4UBsplReC+3X7LNQVOQiYxNWTU89tmEOh1ph3dXaFqVpOS4LE6GJyGbCPvaEZu7vEoyE4
	L5YFEl7dmZkbdhFBP0jQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXcr0-0002TK-MO; Fri, 14 Dec 2018 02:05:26 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXcqQ-0000d7-Ew; Fri, 14 Dec 2018 02:04:52 +0000
X-UUID: be1ddd17aeda42feaabcf474277c118c-20181214
X-UUID: be1ddd17aeda42feaabcf474277c118c-20181214
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
 (envelope-from <weiyi.lu@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 532484311; Fri, 14 Dec 2018 10:04:20 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Dec 2018 10:04:19 +0800
Received: from mtkslt210.mediatek.inc (10.21.14.14) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Dec 2018 10:04:18 +0800
From: Weiyi Lu <weiyi.lu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Stephen Boyd
 <sboyd@codeaurora.org>, Rob Herring <robh@kernel.org>
Subject: [resend PATCH v1 1/2] dt-bindings: clock: add clock for MT2712
Date: Fri, 14 Dec 2018 10:04:16 +0800
Message-ID: <20181214020417.2871-3-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181214020417.2871-1-weiyi.lu@mediatek.com>
References: <20181214020417.2871-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_180450_628992_9E13C140 
X-CRM114-Status: UNSURE (   8.99  )
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

Add new clock according to 3rd ECO design change.
It's the parent clock of audio clock mux.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 include/dt-bindings/clock/mt2712-clk.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/mt2712-clk.h b/include/dt-bindings/clock/mt2712-clk.h
index 76265836a1e1..c3b29dff9c0e 100644
--- a/include/dt-bindings/clock/mt2712-clk.h
+++ b/include/dt-bindings/clock/mt2712-clk.h
@@ -228,7 +228,8 @@
 #define CLK_TOP_NFI2X_EN		189
 #define CLK_TOP_NFIECC_EN		190
 #define CLK_TOP_NFI1X_CK_EN		191
-#define CLK_TOP_NR_CLK			192
+#define CLK_TOP_APLL2_D3		192
+#define CLK_TOP_NR_CLK			193
 
 /* INFRACFG */
 
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
