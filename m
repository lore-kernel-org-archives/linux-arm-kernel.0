Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630DBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 05:39:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 313A9205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 05:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hb+efmhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 313A9205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=g80SXcCy4aw9vJQhuJd9XjC9HazYrN04NsWH4pMcfas=; b=hb+efmhydXoRO5
	lMOxTzQPKJP+tm3uze+xeu0dRcVcE4T1CbyXQ4/bxXBMoBdV2EIRaaYUuqsEn8unElMgDz1yQfpX0
	QbeHn+FV4gA0EYbSHp1RfogkmdyIOSCxI7nmmiwdo8qAZ9JeshI7r91tss55WFT8XETHDY2lw0+Ix
	ltUY9ZFVUSP2nvYuLQ6XrBBbVy8/xJ8S6XHavfV/H/cvoiDlM9Gj4eEgdVKkc/oNAWu6Rzns6yvnF
	VnKiaH+as31u7kDG3/xl2q2Q9KCOdve2v4WPbuRi1ezJejF/GzsC2Cz/FxIqDOTQisR0hESFVnY0c
	ClsrDuZJp6FHQk41rDaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk0Ow-0005f7-2c; Thu, 17 Jan 2019 05:39:38 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk0Or-0005e6-7a; Thu, 17 Jan 2019 05:39:34 +0000
X-UUID: 4a24ea6fecf44d448b9d73c4446501ee-20190116
X-UUID: 4a24ea6fecf44d448b9d73c4446501ee-20190116
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <yunfei.dong@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 220359693; Wed, 16 Jan 2019 21:39:29 -0800
Received: from mtkmbs08n2.mediatek.inc (172.21.101.56) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 16 Jan 2019 21:39:28 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 17 Jan 2019 13:39:25 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 17 Jan 2019 13:39:25 +0800
From: Yunfei Dong <yunfei.dong@mediatek.com>
To: Tiffany Lin <tiffany.lin@mediatek.com>, Andrew-CT Chen
 <andrew-ct.chen@mediatek.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3,
 1/3] media: dt-bindings: media: add 'assigned-clocks' to vcodec
 examples
Date: Thu, 17 Jan 2019 13:39:18 +0800
Message-ID: <1547703560-16195-1-git-send-email-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-TM-SNTS-SMTP: 3CD434C3B5ED7A540F4A79D3232CFAE402E6880ACB5F90B220D8CFD89672F5302000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_213933_276961_CBC2B51C 
X-CRM114-Status: UNSURE (   7.28  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Yunfei Dong <yunfei.dong@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Qianqian Yan <qianqian.yan@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Fix MTK binding document for MT8173 dtsi changed in order
to use standard CCF interface.
MT8173 SoC from Mediatek.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Signed-off-by: Qianqian Yan <qianqian.yan@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/media/mediatek-vcodec.txt   | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
index 2a615d84a682..b6b5dde6abd8 100644
--- a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
+++ b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
@@ -66,6 +66,15 @@ vcodec_dec: vcodec@16000000 {
                   "vencpll",
                   "venc_lt_sel",
                   "vdec_bus_clk_src";
+    assigned-clocks = <&topckgen CLK_TOP_VENC_LT_SEL>,
+                      <&topckgen CLK_TOP_CCI400_SEL>,
+                      <&topckgen CLK_TOP_VDEC_SEL>,
+                      <&apmixedsys CLK_APMIXED_VCODECPLL>,
+                      <&apmixedsys CLK_APMIXED_VENCPLL>;
+    assigned-clock-parents = <&topckgen CLK_TOP_VCODECPLL_370P5>,
+                             <&topckgen CLK_TOP_UNIVPLL_D2>,
+                             <&topckgen CLK_TOP_VCODECPLL>;
+    assigned-clock-rates = <0>, <0>, <0>, <1482000000>, <800000000>;
   };
 
   vcodec_enc: vcodec@18002000 {
@@ -105,4 +114,8 @@ vcodec_dec: vcodec@16000000 {
                   "venc_sel",
                   "venc_lt_sel_src",
                   "venc_lt_sel";
+    assigned-clocks = <&topckgen CLK_TOP_VENC_SEL>,
+                      <&topckgen CLK_TOP_VENC_LT_SEL>;
+    assigned-clock-parents = <&topckgen CLK_TOP_VENCPLL_D2>,
+                             <&topckgen CLK_TOP_UNIVPLL1_D2>;
   };
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
