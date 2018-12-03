Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB33C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:37:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DC1920851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fAd3DCuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC1920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BElwVj7+tEVoNmblEhP8zrXorME+CM02ku3C0dIDllE=; b=fAd3DCuIwgQ/zB
	d6TBhZT5nSRiUP8dbF/SAAstDBe98cBhoxVQozAw8W2v+0HKLKiY0xFh6u3TY37HPSbv2eE1td27a
	SXKJnPcsOWKnnhnJeyVrMXwB1eOmpVq/Wkm5u5bkXVe9sRqhySy8ivD9CkMQb2lDk1/Ylhq7kFi+N
	8+A4hZG5T7GcPEe5GBh4Q7DUNYP7NMituGUialgXEVwc7reAMmg7kONyAOTHHPycJzaamplauAOmS
	P2i0zch3AA/Y/hPEDtccE/j8bN0pQxQto3fC9RYyQJ/YNwpRV5JbxEwk+4V1ca1SJ9M4FqU8RELt4
	u+UCxSD8YAlS6tYQbCsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvue-00006m-Pg; Mon, 03 Dec 2018 21:37:56 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvpp-00029k-QP
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:33:13 +0000
Received: by mail-ot1-f66.google.com with SMTP id e12so13138057otl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:32:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tYVF1/N3KzDGFvlUREOlAA6rOeGKGj1HKQArIj1wxGM=;
 b=cUDWbRCqxGB/g46JwDWtvafGRxkbJlppjAMuoK1JbKRyNStBlioIU16JO/9Nce/bjU
 S+XljE4U82gZQLaGtxKShlglEyEY7NNhBK/SpWzy8m1HdMFcuYjwuzuJ62YWTDlhpdI/
 MG2jR3372Q/1XnpjnJRKzxSMfa+KcOesaIDmH8oAvWpn2IyfLmpxVFwaYEiyx77xiGLR
 4IkHDrox7axlMZJNS8RB++QjeTyl247fR5iwV/b0qcYStLRaN4XHb7VQklz26YkGFjZS
 E3fP/VsZbwS+OafP0iEVfXC3k/NVCIMuzvMs9iKEGWXfByfojUupf6lYG4SFUOhtTW/h
 DzWA==
X-Gm-Message-State: AA+aEWY75Icka2T1uF/Bi4Xnb05T7AkIFyEq0rE8wKkLwlFjmsZQdtoN
 GKStVuyE78cQ0XeUH7OGPQ==
X-Google-Smtp-Source: AFSGD/UBdGfcxoc66a+Wu6V2RgEoWHkXqh+yZgo9RFy4a0rjU9R++UXS7xSpOi4QQ7F/mgJpLl9RLg==
X-Received: by 2002:a9d:348:: with SMTP id 66mr10568044otv.300.1543872766523; 
 Mon, 03 Dec 2018 13:32:46 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:32:45 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/34] dt-bindings: arm: Convert TI davinci board/soc
 bindings to json-schema
Date: Mon,  3 Dec 2018 15:32:06 -0600
Message-Id: <20181203213223.16986-18-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_133258_286050_60319AEC 
X-CRM114-Status: GOOD (  13.57  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kumar Gala <kumar.gala@linaro.org>,
 arm@kernel.org, Sean Hudson <darknighte@darknighte.com>,
 Kevin Hilman <khilman@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Sekhar Nori <nsekhar@ti.com>, Grant Likely <grant.likely@arm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert TI Davinci SoC bindings to DT schema format using json-schema.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/davinci.txt       | 25 ------------------
 .../bindings/arm/ti/ti,davinci.yaml           | 26 +++++++++++++++++++
 2 files changed, 26 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/davinci.txt
 create mode 100644 Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml

diff --git a/Documentation/devicetree/bindings/arm/davinci.txt b/Documentation/devicetree/bindings/arm/davinci.txt
deleted file mode 100644
index 715622c36260..000000000000
--- a/Documentation/devicetree/bindings/arm/davinci.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Texas Instruments DaVinci Platforms Device Tree Bindings
---------------------------------------------------------
-
-DA850/OMAP-L138/AM18x Evaluation Module (EVM) board
-Required root node properties:
-    - compatible = "ti,da850-evm", "ti,da850";
-
-DA850/OMAP-L138/AM18x L138/C6748 Development Kit (LCDK) board
-Required root node properties:
-    - compatible = "ti,da850-lcdk", "ti,da850";
-
-EnBW AM1808 based CMC board
-Required root node properties:
-    - compatible = "enbw,cmc", "ti,da850;
-
-LEGO MINDSTORMS EV3 (AM1808 based)
-Required root node properties:
-    - compatible = "lego,ev3", "ti,da850";
-
-Generic DaVinci Boards
-----------------------
-
-DA850/OMAP-L138/AM18x generic board
-Required root node properties:
-    - compatible = "ti,da850";
diff --git a/Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml b/Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml
new file mode 100644
index 000000000000..4326d2cfa15d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/ti/davinci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments DaVinci Platforms Device Tree Bindings
+
+maintainers:
+  - Sekhar Nori <nsekhar@ti.com>
+
+description:
+  DA850/OMAP-L138/AM18x based boards
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+          - ti,da850-evm    # DA850/OMAP-L138/AM18x Evaluation Module (EVM) board
+          - ti,da850-lcdk   # DA850/OMAP-L138/AM18x L138/C6748 Development Kit (LCDK) board
+          - enbw,cmc        # EnBW AM1808 based CMC board
+          - lego,ev3        # LEGO MINDSTORMS EV3 (AM1808 based)
+      - const: ti,da850
+...
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
