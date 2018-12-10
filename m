Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D91C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:36:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E04972084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JHS4Y0O9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04972084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=omRGP604G0KUidRRkrcQ53AqrPRQ2M5HbNN26Scl00A=; b=JHS4Y0O9R2LVAP
	1HA6VgjNZXTKYjm3Tt8WAaEI8W+ejmnVvlCr/Uw62E1gvHanXHFLNFBobLC4w2ksyFYUw48X9KmU4
	zolSI7H01sZ+ns380LtF2K1EG7XPkW2W7Zt09SH4IMFGktS5WDH3ekItCguhnkN/rx7fVxS1zq5mm
	gtKsa1mWnvklS3A+p1S1FMiU9GX4kpA86W4t97OA8RfH/ed6+NhRAwm7KQ1oCMU87I6XoSFQVrzOB
	t4UILeRghWmkyyBYYozy3b1EbCe5/JNoFXTdYtF13/thA9V6/M6nzQ3faZmTtPtGbXVM0nqzmV3Qz
	YTGAzI63mJ2eeBSp832g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWG6e-0007MB-Kk; Mon, 10 Dec 2018 07:35:56 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWG41-0003d9-Im; Mon, 10 Dec 2018 07:33:29 +0000
X-UUID: 93df4c07fe634112ac29a9ed2759183a-20181210
X-UUID: 93df4c07fe634112ac29a9ed2759183a-20181210
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
 (envelope-from <weiyi.lu@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1590165344; Mon, 10 Dec 2018 15:32:53 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 10 Dec 2018 15:32:51 +0800
Received: from mtkslt210.mediatek.inc (10.21.14.14) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 10 Dec 2018 15:32:51 +0800
From: Weiyi Lu <weiyi.lu@mediatek.com>
To: Nicolas Boichat <drinkcat@chromium.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, Rob Herring
 <robh@kernel.org>
Subject: [PATCH v3 05/12] dt-bindings: ARM: Mediatek: Document bindings for
 MT8183
Date: Mon, 10 Dec 2018 15:32:33 +0800
Message-ID: <20181210073240.32278-7-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181210073240.32278-1-weiyi.lu@mediatek.com>
References: <20181210073240.32278-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: A6B030523002F33B83960A30D400A1FB87B0EF1120D9B442EB3E8BD1B9A182112000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_233314_243995_783B71FB 
X-CRM114-Status: GOOD (  11.92  )
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
 linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds the binding documentation for apmixedsys, audiosys,
camsys, imgsys, infracfg, mcucfg, mfgcfg, mmsys, topckgen, vdecsys,
vencsys and ipu for Mediatek MT8183.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../arm/mediatek/mediatek,apmixedsys.txt      |  1 +
 .../bindings/arm/mediatek/mediatek,audsys.txt |  1 +
 .../bindings/arm/mediatek/mediatek,camsys.txt | 22 ++++++++++
 .../bindings/arm/mediatek/mediatek,imgsys.txt |  1 +
 .../arm/mediatek/mediatek,infracfg.txt        |  1 +
 .../bindings/arm/mediatek/mediatek,ipu.txt    | 43 +++++++++++++++++++
 .../bindings/arm/mediatek/mediatek,mcucfg.txt |  1 +
 .../bindings/arm/mediatek/mediatek,mfgcfg.txt |  1 +
 .../bindings/arm/mediatek/mediatek,mmsys.txt  |  1 +
 .../arm/mediatek/mediatek,topckgen.txt        |  1 +
 .../arm/mediatek/mediatek,vdecsys.txt         |  1 +
 .../arm/mediatek/mediatek,vencsys.txt         |  1 +
 12 files changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ipu.txt

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
index 4e4a3c0ab9ab..641f19e036a2 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
@@ -13,6 +13,7 @@ Required Properties:
 	- "mediatek,mt7623-apmixedsys", "mediatek,mt2701-apmixedsys"
 	- "mediatek,mt8135-apmixedsys"
 	- "mediatek,mt8173-apmixedsys"
+	- "mediatek,mt8183-apmixedsys", "syscon"
 - #clock-cells: Must be 1
 
 The apmixedsys controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
index d1606b2c3e63..f3cef1a6d95c 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
@@ -9,6 +9,7 @@ Required Properties:
 	- "mediatek,mt2701-audsys", "syscon"
 	- "mediatek,mt7622-audsys", "syscon"
 	- "mediatek,mt7623-audsys", "mediatek,mt2701-audsys", "syscon"
+	- "mediatek,mt8183-audiosys", "syscon"
 - #clock-cells: Must be 1
 
 The AUDSYS controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
new file mode 100644
index 000000000000..d8930f64aa98
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
@@ -0,0 +1,22 @@
+MediaTek CAMSYS controller
+============================
+
+The MediaTek camsys controller provides various clocks to the system.
+
+Required Properties:
+
+- compatible: Should be one of:
+	- "mediatek,mt8183-camsys", "syscon"
+- #clock-cells: Must be 1
+
+The camsys controller uses the common clk binding from
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+The available clocks are defined in dt-bindings/clock/mt*-clk.h.
+
+Example:
+
+camsys: camsys@1a000000  {
+	compatible = "mediatek,mt8183-camsys", "syscon";
+	reg = <0 0x1a000000  0 0x1000>;
+	#clock-cells = <1>;
+};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
index 3f99672163e3..e3bc4a1e7a6e 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
@@ -11,6 +11,7 @@ Required Properties:
 	- "mediatek,mt6797-imgsys", "syscon"
 	- "mediatek,mt7623-imgsys", "mediatek,mt2701-imgsys", "syscon"
 	- "mediatek,mt8173-imgsys", "syscon"
+	- "mediatek,mt8183-imgsys", "syscon"
 - #clock-cells: Must be 1
 
 The imgsys controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
index 89f4272a1441..44b2f3281c34 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
@@ -14,6 +14,7 @@ Required Properties:
 	- "mediatek,mt7623-infracfg", "mediatek,mt2701-infracfg", "syscon"
 	- "mediatek,mt8135-infracfg", "syscon"
 	- "mediatek,mt8173-infracfg", "syscon"
+	- "mediatek,mt8183-infracfg", "syscon"
 - #clock-cells: Must be 1
 - #reset-cells: Must be 1
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ipu.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ipu.txt
new file mode 100644
index 000000000000..aabc8c5c8ed2
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ipu.txt
@@ -0,0 +1,43 @@
+Mediatek IPU controller
+============================
+
+The Mediatek ipu controller provides various clocks to the system.
+
+Required Properties:
+
+- compatible: Should be one of:
+	- "mediatek,mt8183-ipu_conn", "syscon"
+	- "mediatek,mt8183-ipu_adl", "syscon"
+	- "mediatek,mt8183-ipu_core0", "syscon"
+	- "mediatek,mt8183-ipu_core1", "syscon"
+- #clock-cells: Must be 1
+
+The ipu controller uses the common clk binding from
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+The available clocks are defined in dt-bindings/clock/mt*-clk.h.
+
+Example:
+
+ipu_conn: syscon@19000000 {
+	compatible = "mediatek,mt8183-ipu_conn", "syscon";
+	reg = <0 0x19000000 0 0x1000>;
+	#clock-cells = <1>;
+};
+
+ipu_adl: syscon@19010000 {
+	compatible = "mediatek,mt8183-ipu_adl", "syscon";
+	reg = <0 0x19010000 0 0x1000>;
+	#clock-cells = <1>;
+};
+
+ipu_core0: syscon@19180000 {
+	compatible = "mediatek,mt8183-ipu_core0", "syscon";
+	reg = <0 0x19180000 0 0x1000>;
+	#clock-cells = <1>;
+};
+
+ipu_core1: syscon@19280000 {
+	compatible = "mediatek,mt8183-ipu_core1", "syscon";
+	reg = <0 0x19280000 0 0x1000>;
+	#clock-cells = <1>;
+};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mcucfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mcucfg.txt
index b8fb03f3613e..2b882b7ca72e 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mcucfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mcucfg.txt
@@ -7,6 +7,7 @@ Required Properties:
 
 - compatible: Should be one of:
 	- "mediatek,mt2712-mcucfg", "syscon"
+	- "mediatek,mt8183-mcucfg", "syscon"
 - #clock-cells: Must be 1
 
 The mcucfg controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt
index 859e67b416d5..72787e7dd227 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt
@@ -7,6 +7,7 @@ Required Properties:
 
 - compatible: Should be one of:
 	- "mediatek,mt2712-mfgcfg", "syscon"
+	- "mediatek,mt8183-mfgcfg", "syscon"
 - #clock-cells: Must be 1
 
 The mfgcfg controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
index 15d977afad31..545eab717c96 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
@@ -11,6 +11,7 @@ Required Properties:
 	- "mediatek,mt6797-mmsys", "syscon"
 	- "mediatek,mt7623-mmsys", "mediatek,mt2701-mmsys", "syscon"
 	- "mediatek,mt8173-mmsys", "syscon"
+	- "mediatek,mt8183-mmsys", "syscon"
 - #clock-cells: Must be 1
 
 The mmsys controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
index d849465b8c99..08bbd37190ad 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
@@ -13,6 +13,7 @@ Required Properties:
 	- "mediatek,mt7623-topckgen", "mediatek,mt2701-topckgen"
 	- "mediatek,mt8135-topckgen"
 	- "mediatek,mt8173-topckgen"
+	- "mediatek,mt8183-topckgen", "syscon"
 - #clock-cells: Must be 1
 
 The topckgen controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
index 3212afc753c8..57176bb8dbb5 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
@@ -11,6 +11,7 @@ Required Properties:
 	- "mediatek,mt6797-vdecsys", "syscon"
 	- "mediatek,mt7623-vdecsys", "mediatek,mt2701-vdecsys", "syscon"
 	- "mediatek,mt8173-vdecsys", "syscon"
+	- "mediatek,mt8183-vdecsys", "syscon"
 - #clock-cells: Must be 1
 
 The vdecsys controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt
index 851545357e94..c9faa6269087 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt
@@ -9,6 +9,7 @@ Required Properties:
 	- "mediatek,mt2712-vencsys", "syscon"
 	- "mediatek,mt6797-vencsys", "syscon"
 	- "mediatek,mt8173-vencsys", "syscon"
+	- "mediatek,mt8183-vencsys", "syscon"
 - #clock-cells: Must be 1
 
 The vencsys controller uses the common clk binding from
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
