Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AD7C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:31:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FED02175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eNY/YroS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FED02175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NknBkl/3dlLpOzRtrjVuKPnCx7Fwy5vJz7GbbvdbRn8=; b=eNY/YroSdflXd4
	rEMRuLlozxgNwAzfKGhLsfcFWtOYxM8/IR261e3CqV47QVOXVU4CJOUJ7VqJUv4odKbXI2BZkxsRU
	xTxTxBXdxqTdoeZn7Ai86mt7GRtQU1R8aeLgv9/k8ykr/2LqgGcxK/wA+d3GcN85dR0KTNfwgHBO8
	wjppal5n2cp9QL9/siUISY9H5DiKswJKLLNlM6cGW3d+2V+qn+Q523Cdz3TZ80RcQ2QWdBd27jUMG
	2cs1Z9n4HlMdJd8/aUEBZY0/YrP2wcAGZy2CryvxikXXW2YN2nRO/3NkJhp5DqcjwXll9od+xGjNz
	JV+bKS+80nAN8Ld2oh1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goL3m-0001hn-Um; Tue, 29 Jan 2019 04:31:42 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goL3g-0001f0-7r; Tue, 29 Jan 2019 04:31:37 +0000
X-UUID: fb6e1585c381416a9ca50c14a41f5284-20190128
X-UUID: fb6e1585c381416a9ca50c14a41f5284-20190128
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <ryder.lee@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 705133501; Mon, 28 Jan 2019 20:31:33 -0800
Received: from mtkmbs08n1.mediatek.inc (172.21.101.55) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 28 Jan 2019 20:31:31 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 29 Jan 2019 12:31:23 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Tue, 29 Jan 2019 12:31:23 +0800
From: Ryder Lee <ryder.lee@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 3/7] dt-bindings: arm: mediatek: add support for MT7622
 BPI-R64 and MT7629 RFB
Date: Tue, 29 Jan 2019 12:31:15 +0800
Message-ID: <1421bc57f9f4d5f3e087a1fd38c5fa9ef087dd1b.1548735271.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <d1ab6c89b115ad0582815816490fa0c13ea83178.1548735271.git.ryder.lee@mediatek.com>
References: <d1ab6c89b115ad0582815816490fa0c13ea83178.1548735271.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_203136_291571_136A2DC8 
X-CRM114-Status: UNSURE (   7.76  )
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
Cc: devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
 Sean Wang <sean.wang@kernel.org>, Weijie Gao <weijie.gao@mediatek.com>,
 Roy Luo <roychl666@gmail.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Update binding document for MT7622 BPI-R64 and MT7629 reference board.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index a3d1b4f..3ebcc9e 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -16,6 +16,7 @@ compatible: Must contain one of
    "mediatek,mt6797"
    "mediatek,mt7622"
    "mediatek,mt7623"
+   "mediatek,mt7629"
    "mediatek,mt8127"
    "mediatek,mt8135"
    "mediatek,mt8173"
@@ -56,6 +57,9 @@ Supported boards:
 - Reference board variant 1 for MT7622:
     Required root node properties:
       - compatible = "mediatek,mt7622-rfb1", "mediatek,mt7622";
+- Bananapi BPI-R64 for MT7622:
+    Required root node properties:
+      - compatible = "bananapi,bpi-r64", "mediatek,mt7622";
 - Reference board for MT7623a with eMMC:
     Required root node properties:
       - compatible = "mediatek,mt7623a-rfb-emmc", "mediatek,mt7623";
@@ -67,6 +71,9 @@ Supported boards:
       - compatible = "mediatek,mt7623n-rfb-emmc", "mediatek,mt7623";
 - Bananapi BPI-R2 board:
       - compatible = "bananapi,bpi-r2", "mediatek,mt7623";
+- Reference board for MT7629:
+    Required root node properties:
+      - compatible = "mediatek,mt7629-rfb", "mediatek,mt7629";
 - MTK mt8127 tablet moose EVB:
     Required root node properties:
       - compatible = "mediatek,mt8127-moose", "mediatek,mt8127";
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
