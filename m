Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8DBC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:32:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D0552087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tdqucY47";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ufv3mNgc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0552087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sLC73y2PqXEb28KuB6bENHPsQMZb0/Dp4IIvwfKYjjU=; b=tdqucY47/Npupx
	sUsUEavE8U4bBJR0A46KVNNuCdxMWMvi28iRWZTX2PwWxdxvc1Go83cwnM1jnxocWvt3pPLwAZR8Y
	1irutHFoPJkEC1oX4FwqwJVNEnZBKAmv1QUtu5jNXhgs6GOFvcP1ULnNXI3jHcSNz9TIhzdsx7q0u
	6VmPC6VDiyGxq5zCrlLOMou/VZuRicItaWp1FvzSGhU7Xeg+zdxcKdlIHNNOD3578Hzhyl7/bnn2X
	VaZ/6TKUo1hIWBPToJTWocgUrVafL/ZVke1LVQWnyLKZ/Td7LpTSr6ZjtOPgKZUv8L7h+QkUs7APz
	+XOknP3rVpPnQ6dK3ASg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTwlB-0008MQ-LZ; Mon, 03 Dec 2018 22:32:13 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTwkT-0007ax-94
 for linux-arm-kernel@bombadil.infradead.org; Mon, 03 Dec 2018 22:31:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RFNhrVaX0tcK7B5SDfm+gr2U6XZm1ep5FyiI36IZL/M=; b=Ufv3mNgcbDP+Yy0FTk4zPXKMSR
 JeO7UXPLrJZzXS8qBsufG8X9wPs4h/5AiIMQ++FYpkhbHHoNlMRHRYpaM8pj9euzyrv6N9YU+2lTj
 CxTlyoR65MKoKQ7PYFre+Ovv2f2VkhXMectOkVXnV6hcKYvvUUy4gy6OKofV0eZ2ZTampFv4gjOn8
 zMAZeAu2wX5mEqgxvNnTYHwU04GdIMpbpSa6ppSfld43q07GsxLzklFBw1A5u0TJpGj4EHHZD60xs
 Tb2LtAP9uF9Z2eYo2UrAGSCpvY1Yz9B3Tlf4NaoQZ07nRYtIM9WXp/HIWuRkocwxMR/0PzC9CxZgq
 OFscsjqQ==;
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvq2-00036I-Ph
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:33:13 +0000
Received: by mail-oi1-f194.google.com with SMTP id v6so12363542oif.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:33:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RFNhrVaX0tcK7B5SDfm+gr2U6XZm1ep5FyiI36IZL/M=;
 b=a1yYJxm8ztNqoOmbbOAs5ixiK3kWkb/0VGf9ROcLWL55piW+XgFOhEgVRPR59kiSgT
 4klrOPh6o4LwgwzevYBXc3GybK/R+WQcV0BKiYXw6zw4S49vR37OgbU34qEwKgEB+44S
 e2AXcGT+4R7pZURyhiXQ2oTZISBTbGEPxm8HJDW0XIOsOKeIUnzhJVwEUKB1W9AWdFrl
 Qu28yEQ9p6hiU7U5MaOuuzKRGIqvD2NDh85PXAjRaBLahbSLPfKRWUIRl2JZqwbl2si8
 sxh0LTL3f2Ifk9YGsUNk0skoLbCx2bUG5UUJ+U6crkNgkGX8VmpRnw1UktWfCf9rdWOg
 U2NA==
X-Gm-Message-State: AA+aEWbqdSoswBk8OmNjresj9Z9jGrHIdZswd2fu7Bct2Yf5J6/q0+0V
 soCq7jr9yHfAKiNwBPrkmQ==
X-Google-Smtp-Source: AFSGD/Ud56FYKmO5ManIayqdpS05DTeS2+4DIywWI5IKaX/qHCAEwMUMzGq1RG8i/+ZnTnMsn7wjGA==
X-Received: by 2002:aca:a90f:: with SMTP id s15mr11316635oie.137.1543872777556; 
 Mon, 03 Dec 2018 13:32:57 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:32:57 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 26/34] dt-bindings: arm: Convert Renesas board/soc bindings
 to json-schema
Date: Mon,  3 Dec 2018 15:32:15 -0600
Message-Id: <20181203213223.16986-27-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_163311_050768_A16A6140 
X-CRM114-Status: GOOD (  16.42  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>,
 Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org,
 Grant Likely <grant.likely@arm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert Renesas SoC bindings to DT schema format using json-schema.

Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-renesas-soc@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/shmobile.txt      | 151 ------------
 .../devicetree/bindings/arm/shmobile.yaml     | 218 ++++++++++++++++++
 2 files changed, 218 insertions(+), 151 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/shmobile.txt
 create mode 100644 Documentation/devicetree/bindings/arm/shmobile.yaml

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
deleted file mode 100644
index 5f18ce9cdbb8..000000000000
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ /dev/null
@@ -1,151 +0,0 @@
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
diff --git a/Documentation/devicetree/bindings/arm/shmobile.yaml b/Documentation/devicetree/bindings/arm/shmobile.yaml
new file mode 100644
index 000000000000..bc2ad4539482
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/shmobile.yaml
@@ -0,0 +1,218 @@
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
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
