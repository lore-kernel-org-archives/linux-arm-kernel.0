Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA80DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:48:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB1ED2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YJBKXFIr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="dVtPphJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB1ED2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=F+TcdIT7YYkpjvTwpzTvDbCOO0XqO0g6yTV+CWbFh1E=; b=YJBKXFIrLEL+vM+iW3msrD+zdp
	e/g4QkOy3bIdVYXX0otrdbxQUKp+O68t5xS3bhq/ZqIsarkb+z2zbswhRHSB4mXesOVdHpUJ8Ok8n
	VJzRaJRKhUZXIKQQ5t70nn56ShtYbgzhxCpoTv9dSGidHs8Eugk6Pbji7WyJDHfW/M5ITdm7GF9rV
	WVY533ak/xUrj6r9PoFFAKjc79e10ons3vDaCh/GcEQAjG1bA5qlj8ShMu/Agp4phak/1Bpebq7XD
	NqUsS7sbSsIZqf1fFrk934eZ08Pkv/tjfd8npgOkdyUBUol2uieWnZaySL3dkcYMeeJfj5gEWfWdT
	jDYVNmug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvgTZ-0007i5-5f; Mon, 18 Feb 2019 10:48:41 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvgTM-0007Tx-L4
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 10:48:32 +0000
Received: from penelope.horms.nl (unknown [62.119.166.9])
 by kirsty.vergenet.net (Postfix) with ESMTPA id EC69225B770;
 Mon, 18 Feb 2019 21:48:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1550486902; bh=Bv1JCQNkgLtaFBzSLt8wejtxlIlE6ucRHFJt7KBn7mc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dVtPphJpwx46L12UJudmeCH8SOKEupKLenb9Gz3S1Sb3fBn9CHEs6JY7+aP2CXeyi
 fj1OCefo9GQ01AjJeWjiG81/Wc4nkX0fbmQqjgzl+nwfxyUFIBp+bD7ktAPAPGpWz6
 B6Pg8LVAg14vFZkn0+nMAveXR7AXqslRlqIJW4ns=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id BB0DBE218D0; Mon, 18 Feb 2019 11:48:07 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: arm: Convert Renesas board/soc bindings to
 json-schema
Date: Mon, 18 Feb 2019 11:48:03 +0100
Message-Id: <12749350567c819d8a35a405743313bd869c95c0.1549624030.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1549624030.git.horms+renesas@verge.net.au>
References: <cover.1549624030.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_024828_995261_DA1E40E8 
X-CRM114-Status: GOOD (  12.02  )
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
Cc: Rob Herring <robh@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 Simon Horman <horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Rob Herring <robh@kernel.org>

Convert Renesas SoC bindings to DT schema format using json-schema.

v2.1 [Simon Horman]
- rebased on renesas-devel-20181204-v4.20-rc5
  + Added r8a7744 development platform and SoM
  + Correct RZ/G2E part number
- Update MAINTAINERS

Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/renesas.yaml | 228 +++++++++++++++++++++
 Documentation/devicetree/bindings/arm/shmobile.txt | 155 --------------
 MAINTAINERS                                        |   4 +-
 3 files changed, 230 insertions(+), 157 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/renesas.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/shmobile.txt

diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
new file mode 100644
index 000000000000..5e9d4864a600
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/renesas.yaml
@@ -0,0 +1,228 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/shmobile.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas SH-Mobile, R-Mobile, and R-Car Platform Device Tree Bindings
+
+maintainers:
+  - Geert Uytterhoeven <geert+renesas@glider.be>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Emma Mobile EV2
+        items:
+          - enum:
+              - renesas,kzm9d # Kyoto Microcomputer Co. KZM-A9-Dual
+          - const: renesas,emev2
+
+      - description: RZ/A1H (R7S72100)
+        items:
+          - enum:
+              - renesas,genmai # Genmai (RTK772100BC00000BR)
+              - renesas,gr-peach # GR-Peach (X28A-M01-E/F)
+              - renesas,rskrza1 # RSKRZA1 (YR0K77210C000BE)
+          - const: renesas,r7s72100
+
+      - description: RZ/A2 (R7S9210)
+        items:
+          - const: renesas,r7s9210
+
+      - description: SH-Mobile AG5 (R8A73A00/SH73A0)
+        items:
+          - enum:
+              - renesas,kzm9g # Kyoto Microcomputer Co. KZM-A9-GT
+          - const: renesas,sh73a0
+
+      - description: R-Mobile APE6 (R8A73A40)
+        items:
+          - enum:
+              - renesas,ape6evm
+          - const: renesas,r8a73a4
+
+      - description: R-Mobile A1 (R8A77400)
+        items:
+          - enum:
+              - renesas,armadillo800eva # Atmark Techno Armadillo-800 EVA
+          - const: renesas,r8a7740
+
+      - description: RZ/G1H (R8A77420)
+        items:
+          - const: renesas,r8a7742
+
+      - description: RZ/G1M (R8A77430)
+        items:
+          - enum:
+              # iWave Systems RZ/G1M Qseven Development Platform (iW-RainboW-G20D-Qseven)
+              - iwave,g20d
+          - const: iwave,g20m
+          - const: renesas,r8a7743
+
+      - items:
+          - enum:
+              # iWave Systems RZ/G1M Qseven System On Module (iW-RainboW-G20M-Qseven)
+              - iwave,g20m
+              - renesas,sk-rzg1m # SK-RZG1M (YR8A77430S000BE)
+          - const: renesas,r8a7743
+
+      - description: RZ/G1N (R8A77440)
+        items:
+          - enum:
+              # iWave Systems RZ/G1N Qseven Development Platform (iW-RainboW-G20D-Qseven)
+              - iwave,g20d
+          - const: iwave,g20m
+          - const: renesas,r8a7744
+
+      - items:
+          - enum:
+              # iWave Systems RZ/G1N Qseven System On Module (iW-RainboW-G20M-Qseven)
+              - iwave,g20m
+          - const: renesas,r8a7744
+
+      - description: RZ/G1E (R8A77450)
+        items:
+          - enum:
+              - iwave,g22m # iWave Systems RZ/G1E SODIMM System On Module (iW-RainboW-G22M-SM)
+              - renesas,sk-rzg1e # SK-RZG1E (YR8A77450S000BE)
+          - const: renesas,r8a7745
+
+      - description: iWave Systems RZ/G1E SODIMM SOM Development Platform (iW-RainboW-G22D)
+        items:
+          - const: iwave,g22d
+          - const: iwave,g22m
+          - const: renesas,r8a7745
+
+      - description: RZ/G1C (R8A77470)
+        items:
+          - enum:
+              - iwave,g23s #iWave Systems RZ/G1C Single Board Computer (iW-RainboW-G23S)
+          - const: renesas,r8a77470
+
+      - description: RZ/G2M (R8A774A1)
+        items:
+          - const: renesas,r8a774a1
+
+      - description: RZ/G2E (R8A774C0)
+        items:
+          - const: renesas,r8a774c0
+
+      - description: R-Car M1A (R8A77781)
+        items:
+          - enum:
+              - renesas,bockw
+          - const: renesas,r8a7778
+
+      - description: R-Car H1 (R8A77790)
+        items:
+          - enum:
+              - renesas,marzen # Marzen (R0P7779A00010S)
+              - renesas,stout # Stout (ADAS Starterkit, Y-R-CAR-ADAS-SKH2-BOARD)
+          - const: renesas,r8a7779
+
+      - description: R-Car H2 (R8A77900)
+        items:
+          - enum:
+              - renesas,lager # Lager (RTP0RC7790SEB00010S)
+          - const: renesas,r8a7790
+
+      - description: R-Car M2-W (R8A77910)
+        items:
+          - enum:
+              - renesas,henninger
+              - renesas,koelsch # Koelsch (RTP0RC7791SEB00010S)
+              - renesas,porter # Porter (M2-LCDP)
+          - const: renesas,r8a7791
+
+      - description: R-Car V2H (R8A77920)
+        items:
+          - enum:
+              - renesas,blanche # Blanche (RTP0RC7792SEB00010S)
+              - renesas,wheat # Wheat (RTP0RC7792ASKB0000JE)
+          - const: renesas,r8a7792
+
+      - description: R-Car M2-N (R8A77930)
+        items:
+          - enum:
+              - renesas,gose # Gose (RTP0RC7793SEB00010S)
+          - const: renesas,r8a7793
+
+      - description: R-Car E2 (R8A77940)
+        items:
+          - enum:
+              - renesas,alt # Alt (RTP0RC7794SEB00010S)
+              - renesas,silk # SILK (RTP0RC7794LCB00011S)
+          - const: renesas,r8a7794
+
+      - description: R-Car H3 (R8A77950)
+        items:
+          - enum:
+                # H3ULCB (R-Car Starter Kit Premier, RTP0RC7795SKBX0010SA00 (H3 ES1.1))
+                # H3ULCB (R-Car Starter Kit Premier, RTP0RC77951SKBX010SA00 (H3 ES2.0))
+              - renesas,h3ulcb
+              - renesas,salvator-x # Salvator-X (RTP0RC7795SIPB0010S)
+              - renesas,salvator-xs # Salvator-XS (Salvator-X 2nd version, RTP0RC7795SIPB0012S)
+          - const: renesas,r8a7795
+
+      - description: R-Car M3-W (R8A77960)
+        items:
+          - enum:
+              - renesas,m3ulcb # M3ULCB (R-Car Starter Kit Pro, RTP0RC7796SKBX0010SA09 (M3 ES1.0))
+              - renesas,salvator-x # Salvator-X (RTP0RC7796SIPB0011S)
+              - renesas,salvator-xs # Salvator-XS (Salvator-X 2nd version, RTP0RC7796SIPB0012S)
+          - const: renesas,r8a7796
+
+      - description: Kingfisher (SBEV-RCAR-KF-M03)
+        items:
+          - const: shimafuji,kingfisher
+          - enum:
+              - renesas,h3ulcb
+              - renesas,m3ulcb
+          - enum:
+              - renesas,r8a7795
+              - renesas,r8a7796
+
+      - description: R-Car M3-N (R8A77965)
+        items:
+          - enum:
+              - renesas,m3nulcb # M3NULCB (R-Car Starter Kit Pro, RTP0RC77965SKBX010SA00 (M3-N ES1.1))
+              - renesas,salvator-x # Salvator-X (RTP0RC7796SIPB0011S (M3-N))
+              - renesas,salvator-xs # Salvator-XS (Salvator-X 2nd version, RTP0RC77965SIPB012S)
+          - const: renesas,r8a77965
+
+      - description: R-Car V3M (R8A77970)
+        items:
+          - enum:
+              - renesas,eagle # Eagle (RTP0RC77970SEB0010S)
+              - renesas,v3msk # V3MSK (Y-ASK-RCAR-V3M-WS10)
+          - const: renesas,r8a77970
+
+      - description: R-Car V3H (R8A77980)
+        items:
+          - enum:
+              - renesas,condor # Condor (RTP0RC77980SEB0010SS/RTP0RC77980SEB0010SA01)
+              - renesas,v3hsk # V3HSK (Y-ASK-RCAR-V3H-WS10)
+          - const: renesas,r8a77980
+
+      - description: R-Car E3 (R8A77990)
+        items:
+          - enum:
+              - renesas,ebisu # Ebisu (RTP0RC77990SEB0010S)
+          - const: renesas,r8a77990
+
+      - description: R-Car D3 (R8A77995)
+        items:
+          - enum:
+              - renesas,draak # Draak (RTP0RC77995SEB0010S)
+          - const: renesas,r8a77995
+
+      - description: RZ/N1D (R9A06G032)
+        items:
+          - enum:
+              - renesas,rzn1d400-db # RZN1D-DB (RZ/N1D Demo Board for the RZ/N1D 400 pins package)
+          - const: renesas,r9a06g032
+
+...
diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
deleted file mode 100644
index 7f91c2a8b54e..000000000000
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ /dev/null
@@ -1,155 +0,0 @@
-Renesas SH-Mobile, R-Mobile, and R-Car Platform Device Tree Bindings
---------------------------------------------------------------------
-
-SoCs:
-
-  - Emma Mobile EV2
-    compatible = "renesas,emev2"
-  - RZ/A1H (R7S72100)
-    compatible = "renesas,r7s72100"
-  - RZ/A2 (R7S9210)
-    compatible = "renesas,r7s9210"
-  - SH-Mobile AG5 (R8A73A00/SH73A0)
-    compatible = "renesas,sh73a0"
-  - R-Mobile APE6 (R8A73A40)
-    compatible = "renesas,r8a73a4"
-  - R-Mobile A1 (R8A77400)
-    compatible = "renesas,r8a7740"
-  - RZ/G1H (R8A77420)
-    compatible = "renesas,r8a7742"
-  - RZ/G1M (R8A77430)
-    compatible = "renesas,r8a7743"
-  - RZ/G1N (R8A77440)
-    compatible = "renesas,r8a7744"
-  - RZ/G1E (R8A77450)
-    compatible = "renesas,r8a7745"
-  - RZ/G1C (R8A77470)
-    compatible = "renesas,r8a77470"
-  - RZ/G2M (R8A774A1)
-    compatible = "renesas,r8a774a1"
-  - RZ/G2E (R8A774C0)
-    compatible = "renesas,r8a774c0"
-  - R-Car M1A (R8A77781)
-    compatible = "renesas,r8a7778"
-  - R-Car H1 (R8A77790)
-    compatible = "renesas,r8a7779"
-  - R-Car H2 (R8A77900)
-    compatible = "renesas,r8a7790"
-  - R-Car M2-W (R8A77910)
-    compatible = "renesas,r8a7791"
-  - R-Car V2H (R8A77920)
-    compatible = "renesas,r8a7792"
-  - R-Car M2-N (R8A77930)
-    compatible = "renesas,r8a7793"
-  - R-Car E2 (R8A77940)
-    compatible = "renesas,r8a7794"
-  - R-Car H3 (R8A77950)
-    compatible = "renesas,r8a7795"
-  - R-Car M3-W (R8A77960)
-    compatible = "renesas,r8a7796"
-  - R-Car M3-N (R8A77965)
-    compatible = "renesas,r8a77965"
-  - R-Car V3M (R8A77970)
-    compatible = "renesas,r8a77970"
-  - R-Car V3H (R8A77980)
-    compatible = "renesas,r8a77980"
-  - R-Car E3 (R8A77990)
-    compatible = "renesas,r8a77990"
-  - R-Car D3 (R8A77995)
-    compatible = "renesas,r8a77995"
-  - RZ/N1D (R9A06G032)
-    compatible = "renesas,r9a06g032"
-
-Boards:
-
-  - Alt (RTP0RC7794SEB00010S)
-    compatible = "renesas,alt", "renesas,r8a7794"
-  - APE6-EVM
-    compatible = "renesas,ape6evm", "renesas,r8a73a4"
-  - Atmark Techno Armadillo-800 EVA
-    compatible = "renesas,armadillo800eva", "renesas,r8a7740"
-  - Blanche (RTP0RC7792SEB00010S)
-    compatible = "renesas,blanche", "renesas,r8a7792"
-  - BOCK-W
-    compatible = "renesas,bockw", "renesas,r8a7778"
-  - Condor (RTP0RC77980SEB0010SS/RTP0RC77980SEB0010SA01)
-    compatible = "renesas,condor", "renesas,r8a77980"
-  - Draak (RTP0RC77995SEB0010S)
-    compatible = "renesas,draak", "renesas,r8a77995"
-  - Eagle (RTP0RC77970SEB0010S)
-    compatible = "renesas,eagle", "renesas,r8a77970"
-  - Ebisu (RTP0RC77990SEB0010S)
-    compatible = "renesas,ebisu", "renesas,r8a77990"
-  - Genmai (RTK772100BC00000BR)
-    compatible = "renesas,genmai", "renesas,r7s72100"
-  - GR-Peach (X28A-M01-E/F)
-    compatible = "renesas,gr-peach", "renesas,r7s72100"
-  - Gose (RTP0RC7793SEB00010S)
-    compatible = "renesas,gose", "renesas,r8a7793"
-  - H3ULCB (R-Car Starter Kit Premier, RTP0RC7795SKBX0010SA00 (H3 ES1.1))
-    H3ULCB (R-Car Starter Kit Premier, RTP0RC77951SKBX010SA00 (H3 ES2.0))
-    compatible = "renesas,h3ulcb", "renesas,r8a7795"
-  - Henninger
-    compatible = "renesas,henninger", "renesas,r8a7791"
-  - iWave Systems RZ/G1C Single Board Computer (iW-RainboW-G23S)
-    compatible = "iwave,g23s", "renesas,r8a77470"
-  - iWave Systems RZ/G1E SODIMM SOM Development Platform (iW-RainboW-G22D)
-    compatible = "iwave,g22d", "iwave,g22m", "renesas,r8a7745"
-  - iWave Systems RZ/G1E SODIMM System On Module (iW-RainboW-G22M-SM)
-    compatible = "iwave,g22m", "renesas,r8a7745"
-  - iWave Systems RZ/G1M Qseven Development Platform (iW-RainboW-G20D-Qseven)
-    compatible = "iwave,g20d", "iwave,g20m", "renesas,r8a7743"
-  - iWave Systems RZ/G1M Qseven System On Module (iW-RainboW-G20M-Qseven)
-    compatible = "iwave,g20m", "renesas,r8a7743"
-  - iWave Systems RZ/G1N Qseven Development Platform (iW-RainboW-G20D-Qseven)
-    compatible = "iwave,g20d", "iwave,g20m", "renesas,r8a7744"
-  - iWave Systems RZ/G1N Qseven System On Module (iW-RainboW-G20M-Qseven)
-    compatible = "iwave,g20m", "renesas,r8a7744"
-  - Kingfisher (SBEV-RCAR-KF-M03)
-    compatible = "shimafuji,kingfisher"
-  - Koelsch (RTP0RC7791SEB00010S)
-    compatible = "renesas,koelsch", "renesas,r8a7791"
-  - Kyoto Microcomputer Co. KZM-A9-Dual
-    compatible = "renesas,kzm9d", "renesas,emev2"
-  - Kyoto Microcomputer Co. KZM-A9-GT
-    compatible = "renesas,kzm9g", "renesas,sh73a0"
-  - Lager (RTP0RC7790SEB00010S)
-    compatible = "renesas,lager", "renesas,r8a7790"
-  - M3ULCB (R-Car Starter Kit Pro, RTP0RC7796SKBX0010SA09 (M3 ES1.0))
-    compatible = "renesas,m3ulcb", "renesas,r8a7796"
-  - M3NULCB (R-Car Starter Kit Pro, RTP0RC77965SKBX010SA00 (M3-N ES1.1))
-    compatible = "renesas,m3nulcb", "renesas,r8a77965"
-  - Marzen (R0P7779A00010S)
-    compatible = "renesas,marzen", "renesas,r8a7779"
-  - Porter (M2-LCDP)
-    compatible = "renesas,porter", "renesas,r8a7791"
-  - RSKRZA1 (YR0K77210C000BE)
-    compatible = "renesas,rskrza1", "renesas,r7s72100"
-  - RZN1D-DB (RZ/N1D Demo Board for the RZ/N1D 400 pins package)
-    compatible = "renesas,rzn1d400-db", "renesas,r9a06g032"
-  - Salvator-X (RTP0RC7795SIPB0010S)
-    compatible = "renesas,salvator-x", "renesas,r8a7795"
-  - Salvator-X (RTP0RC7796SIPB0011S)
-    compatible = "renesas,salvator-x", "renesas,r8a7796"
-  - Salvator-X (RTP0RC7796SIPB0011S (M3-N))
-    compatible = "renesas,salvator-x", "renesas,r8a77965"
-  - Salvator-XS (Salvator-X 2nd version, RTP0RC7795SIPB0012S)
-    compatible = "renesas,salvator-xs", "renesas,r8a7795"
-  - Salvator-XS (Salvator-X 2nd version, RTP0RC7796SIPB0012S)
-    compatible = "renesas,salvator-xs", "renesas,r8a7796"
-  - Salvator-XS (Salvator-X 2nd version, RTP0RC77965SIPB012S)
-    compatible = "renesas,salvator-xs", "renesas,r8a77965"
-  - SILK (RTP0RC7794LCB00011S)
-    compatible = "renesas,silk", "renesas,r8a7794"
-  - SK-RZG1E (YR8A77450S000BE)
-    compatible = "renesas,sk-rzg1e", "renesas,r8a7745"
-  - SK-RZG1M (YR8A77430S000BE)
-    compatible = "renesas,sk-rzg1m", "renesas,r8a7743"
-  - Stout (ADAS Starterkit, Y-R-CAR-ADAS-SKH2-BOARD)
-    compatible = "renesas,stout", "renesas,r8a7790"
-  - V3HSK (Y-ASK-RCAR-V3H-WS10)
-    compatible = "renesas,v3hsk", "renesas,r8a77980"
-  - V3MSK (Y-ASK-RCAR-V3M-WS10)
-    compatible = "renesas,v3msk", "renesas,r8a77970"
-  - Wheat (RTP0RC7792ASKB0000JE)
-    compatible = "renesas,wheat", "renesas,r8a7792"
diff --git a/MAINTAINERS b/MAINTAINERS
index 32d444476a90..df275b4174dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1997,7 +1997,7 @@ Q:	http://patchwork.kernel.org/project/linux-renesas-soc/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
 S:	Supported
 F:	arch/arm64/boot/dts/renesas/
-F:	Documentation/devicetree/bindings/arm/shmobile.txt
+F:	Documentation/devicetree/bindings/arm/renesas.yaml
 F:	drivers/soc/renesas/
 F:	include/linux/soc/renesas/
 
@@ -2116,7 +2116,7 @@ F:	arch/arm/boot/dts/sh*
 F:	arch/arm/configs/shmobile_defconfig
 F:	arch/arm/include/debug/renesas-scif.S
 F:	arch/arm/mach-shmobile/
-F:	Documentation/devicetree/bindings/arm/shmobile.txt
+F:	Documentation/devicetree/bindings/arm/renesas.yaml
 F:	drivers/soc/renesas/
 F:	include/linux/soc/renesas/
 
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
