Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFCAC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:36:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C7F520851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qg5oJbqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7F520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ex9XcWKdyIa1YfqEYJK/rnVquEOCVlwgPTWbizI+u/w=; b=Qg5oJbqconvly5
	ZouMjYwT/fik+w7gZ09+yd9YnFj848+qQV6Rzo+/OjubB/jvUx1TtHBed8qcH2qOQmq5qHz3SSK9H
	QEIuLwTuk1KRZmNp4Y46bmsPz08PJtbod4f0Dq8WnzcUYF4iLyEYMqgIcwK9f+GzNkUFMSwuxakM/
	N6a5yjEJdi0RNWO8O9Sjl6BBYUFmAGFE4itct4es8zE/YJHqC1x6mgFAO6kIG1NzMRGE+xUCferBc
	9H4C+ZCqdVKDjekZigCYaga50aiDe5otQxNbiBNf4HL8w1+NThPOWymU0F21hdOd8tt6uD0MKm0z/
	svm4KzLTGOEhPZwR57Bw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvtB-0006zj-UV; Mon, 03 Dec 2018 21:36:25 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvph-00026e-3D
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:33:03 +0000
Received: by mail-ot1-f67.google.com with SMTP id u16so13121134otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:32:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+0uYgcD111shZCxPVWjIXktAHYqgAFqUOZcPK2YVI38=;
 b=TxfpWYcOfQ+l6+7XocmpXng3EtMMvmripF9P5v1OWFfJT+FrVyBqVg0Dwk2GqD7SbD
 nG9Lm/D55tdQxR3u5AQnADmTRSr2tTRrS0YoW7wyzoKdIjRIj5HR4AEt9BQxbHPlFBpW
 FtVXwUDmk8HkJIMq71gLMK/8iJFouHzsLWko/+/C3sHripdlp7jvWlL9thc8z7HTFC2+
 EVktgaep4djGHtoz+T7hSje/MFoG8ZNxyS1qJvqAWrCelEPDP05g/DhxNyG+jnsd0fHb
 Srh3UI/UBoKL/Xhde7716+IwUTQrHLEWINm3Lq2YQUR16zlwbpSX/c+Bc1+ETDjLISSL
 LbIw==
X-Gm-Message-State: AA+aEWZ7oezFP9mCKGZyBwLg+N96PJID7HprdfOut7D/alpOPz8WKmm8
 NhVhk+fhlp4jNbf84o+cwDiUNAM=
X-Google-Smtp-Source: AFSGD/XBXab5CsrSP95ZpOT1ojWIXGO4faNCG4fK546h4y8gbiPmKpA2pvGjzdCBsx46epOg8LRzeA==
X-Received: by 2002:a9d:bee:: with SMTP id 101mr11690699oth.120.1543872763948; 
 Mon, 03 Dec 2018 13:32:43 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:32:43 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/34] dt-bindings: arm: Convert Atmel board/soc bindings
 to json-schema
Date: Mon,  3 Dec 2018 15:32:04 -0600
Message-Id: <20181203213223.16986-16-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_133249_616805_32D5AFBA 
X-CRM114-Status: GOOD (  14.66  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 Grant Likely <grant.likely@arm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert Atmel SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/atmel-at91.txt    |  72 ----------
 .../devicetree/bindings/arm/atmel-at91.yaml   | 133 ++++++++++++++++++
 2 files changed, 133 insertions(+), 72 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/atmel-at91.txt
 create mode 100644 Documentation/devicetree/bindings/arm/atmel-at91.yaml

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
deleted file mode 100644
index 4bf1b4da7659..000000000000
--- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
+++ /dev/null
@@ -1,72 +0,0 @@
-Atmel AT91 device tree bindings.
-================================
-
-Boards with a SoC of the Atmel AT91 or SMART family shall have the following
-properties:
-
-Required root node properties:
-compatible: must be one of:
- * "atmel,at91rm9200"
-
- * "atmel,at91sam9" for SoCs using an ARM926EJ-S core, shall be extended with
-   the specific SoC family or compatible:
-    o "atmel,at91sam9260"
-    o "atmel,at91sam9261"
-    o "atmel,at91sam9263"
-    o "atmel,at91sam9x5" for the 5 series, shall be extended with the specific
-      SoC compatible:
-       - "atmel,at91sam9g15"
-       - "atmel,at91sam9g25"
-       - "atmel,at91sam9g35"
-       - "atmel,at91sam9x25"
-       - "atmel,at91sam9x35"
-    o "atmel,at91sam9g20"
-    o "atmel,at91sam9g45"
-    o "atmel,at91sam9n12"
-    o "atmel,at91sam9rl"
-    o "atmel,at91sam9xe"
- * "atmel,sama5" for SoCs using a Cortex-A5, shall be extended with the specific
-   SoC family:
-    o "atmel,sama5d2" shall be extended with the specific SoC compatible:
-       - "atmel,sama5d27"
-    o "atmel,sama5d3" shall be extended with the specific SoC compatible:
-       - "atmel,sama5d31"
-       - "atmel,sama5d33"
-       - "atmel,sama5d34"
-       - "atmel,sama5d35"
-       - "atmel,sama5d36"
-    o "atmel,sama5d4" shall be extended with the specific SoC compatible:
-       - "atmel,sama5d41"
-       - "atmel,sama5d42"
-       - "atmel,sama5d43"
-       - "atmel,sama5d44"
-
- * "atmel,samv7" for MCUs using a Cortex-M7, shall be extended with the specific
-   SoC family:
-    o "atmel,sams70" shall be extended with the specific MCU compatible:
-       - "atmel,sams70j19"
-       - "atmel,sams70j20"
-       - "atmel,sams70j21"
-       - "atmel,sams70n19"
-       - "atmel,sams70n20"
-       - "atmel,sams70n21"
-       - "atmel,sams70q19"
-       - "atmel,sams70q20"
-       - "atmel,sams70q21"
-    o "atmel,samv70" shall be extended with the specific MCU compatible:
-       - "atmel,samv70j19"
-       - "atmel,samv70j20"
-       - "atmel,samv70n19"
-       - "atmel,samv70n20"
-       - "atmel,samv70q19"
-       - "atmel,samv70q20"
-    o "atmel,samv71" shall be extended with the specific MCU compatible:
-       - "atmel,samv71j19"
-       - "atmel,samv71j20"
-       - "atmel,samv71j21"
-       - "atmel,samv71n19"
-       - "atmel,samv71n20"
-       - "atmel,samv71n21"
-       - "atmel,samv71q19"
-       - "atmel,samv71q20"
-       - "atmel,samv71q21"
diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
new file mode 100644
index 000000000000..19431f58b906
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -0,0 +1,133 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/atmel-at91.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel AT91 device tree bindings.
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@free-electrons.com>
+  - Ludovic Desroches <ludovic.desroches@atmel.com>
+
+description: |
+  Boards with a SoC of the Atmel AT91 or SMART family shall have the following
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - const: atmel,at91rm9200
+      - items:
+          - enum:
+              - olimex,sam9-l9260
+          - enum:
+              - atmel,at91sam9260
+              - atmel,at91sam9261
+              - atmel,at91sam9263
+              - atmel,at91sam9g20
+              - atmel,at91sam9g45
+              - atmel,at91sam9n12
+              - atmel,at91sam9rl
+              - atmel,at91sam9xe
+          - const: atmel,at91sam9
+
+      - items:
+          - enum:
+              - atmel,at91sam9g15
+              - atmel,at91sam9g25
+              - atmel,at91sam9g35
+              - atmel,at91sam9x25
+              - atmel,at91sam9x35
+          - const: atmel,at91sam9x5
+          - const: atmel,at91sam9
+
+      - items:
+          - const: atmel,sama5d27
+          - const: atmel,sama5d2
+          - const: atmel,sama5
+
+      - description: Nattis v2 board with Natte v2 power board
+        items:
+          - const: axentia,nattis-2
+          - const: axentia,natte-2
+          - const: axentia,linea
+          - const: atmel,sama5d31
+          - const: atmel,sama5d3
+          - const: atmel,sama5
+
+      - description: TSE-850 v3 board
+        items:
+          - const: axentia,tse850v3
+          - const: axentia,linea
+          - const: atmel,sama5d31
+          - const: atmel,sama5d3
+          - const: atmel,sama5
+
+      - items:
+          - const: axentia,linea
+          - const: atmel,sama5d31
+          - const: atmel,sama5d3
+          - const: atmel,sama5
+
+      - items:
+          - enum:
+              - atmel,sama5d31
+              - atmel,sama5d33
+              - atmel,sama5d34
+              - atmel,sama5d35
+              - atmel,sama5d36
+          - const: atmel,sama5d3
+          - const: atmel,sama5
+
+      - items:
+          - enum:
+              - atmel,sama5d41
+              - atmel,sama5d42
+              - atmel,sama5d43
+              - atmel,sama5d44
+          - const: atmel,sama5d4
+          - const: atmel,sama5
+
+      - items:
+          - enum:
+              - atmel,sams70j19
+              - atmel,sams70j20
+              - atmel,sams70j21
+              - atmel,sams70n19
+              - atmel,sams70n20
+              - atmel,sams70n21
+              - atmel,sams70q19
+              - atmel,sams70q20
+              - atmel,sams70q21
+          - const: atmel,sams70
+          - const: atmel,samv7
+
+      - items:
+          - enum:
+              - atmel,samv70j19
+              - atmel,samv70j20
+              - atmel,samv70n19
+              - atmel,samv70n20
+              - atmel,samv70q19
+              - atmel,samv70q20
+          - const: atmel,samv70
+          - const: atmel,samv7
+
+      - items:
+          - enum:
+              - atmel,samv71j19
+              - atmel,samv71j20
+              - atmel,samv71j21
+              - atmel,samv71n19
+              - atmel,samv71n20
+              - atmel,samv71n21
+              - atmel,samv71q19
+              - atmel,samv71q20
+              - atmel,samv71q21
+          - const: atmel,samv71
+          - const: atmel,samv7
+
+...
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
