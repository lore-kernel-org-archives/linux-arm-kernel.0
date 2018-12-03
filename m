Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A32C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:35:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B874420851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EsKOfC8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B874420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Evbbv2UMgIu5Fq2sz0qq43uHNZfAkuHaNFTCXrCdyEc=; b=EsKOfC8N06Su57
	i9jgwu88/q7WzHzO9bMc4LDES3vuQAtu/NNJuGt+HB/jk6s45G7KxBkCKRmb25FnSvvspMlCf0MMI
	vex8x72ii88wSelIQfz6/jusn3g0bucErI8qeJIsL2+SzTTKSePdbhi5MPwfTpq4yjtdZn+94vkaG
	dTzepZt2Gc/BURRVK4FlJrY+oZyN6D6SKBcRxJomJOp0QZQ3t7Ep39ytvxCN3eFziT7QYHIBrVp0y
	pF1KYy0qzv397A9vy+P1yWxXw4dgrDU0bT2CJiMD1MnYskixdPEqsZ2IQnxlAThPigQbt+cp6C0Eu
	DVF3em1U2JN2CHokJwjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvs2-0004zl-I6; Mon, 03 Dec 2018 21:35:14 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvpd-00023A-P7
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:32:54 +0000
Received: by mail-oi1-f194.google.com with SMTP id t204so12342921oie.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:32:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=crpmuMvjqBUzMweRcyITJf7puD+Tt8shjcgunnXtNSw=;
 b=a/JsxzhB9vi+46tMR4P0fOVCsXws6wHmdBeyu0TjyC1w2sSHJAZ+ygk3lDA3ccG+Ob
 s2rq1iRBovu0l0l1hxPXHYBMoGXRa+xa3Ke1xP7hXPjNfXGbo7+DlU/bbJf6iaqkVEYA
 qbiOMzfVF023faDxPPwr1hEwINvAPMUn1CxiYERxD//atA7WcRx7uQgr3sbZh12UdIFL
 21gUC0GFb5KGFNAY7dPamvN90qp7dxPiUQRW9oj1pMXjWNZ7by+RM+4ZmQN/bXC/EtJz
 Jg4zdyxnAYKmrlMOMPKwIzuHuschp36otpweFs2GyMJ7t070clg3wIHy/la7idDlyXLg
 B82w==
X-Gm-Message-State: AA+aEWZWxU327EUDUv+NHeqAjM0lhWU20+39U1EwV6o+2K/WH2bfOkS4
 hPhwmU43inwHHrdUzTga/w==
X-Google-Smtp-Source: AFSGD/WbaVbWvCcLA6sXHHyRjSgS3AMA7ZRkmz2ls6tHdAnvD+09yqYGArH6HcCp2dFdAHA28AH6Mw==
X-Received: by 2002:aca:dfc4:: with SMTP id w187mr11306228oig.35.1543872760042; 
 Mon, 03 Dec 2018 13:32:40 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:32:39 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/34] dt-bindings: arm: Convert Altera board/soc bindings
 to json-schema
Date: Mon,  3 Dec 2018 15:32:01 -0600
Message-Id: <20181203213223.16986-13-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_133246_331096_3566C7E8 
X-CRM114-Status: GOOD (  13.41  )
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
 Frank Rowand <frowand.list@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Grant Likely <grant.likely@arm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert Altera SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/altera.txt        | 14 -------------
 .../devicetree/bindings/arm/altera.yaml       | 20 +++++++++++++++++++
 2 files changed, 20 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/altera.txt
 create mode 100644 Documentation/devicetree/bindings/arm/altera.yaml

diff --git a/Documentation/devicetree/bindings/arm/altera.txt b/Documentation/devicetree/bindings/arm/altera.txt
deleted file mode 100644
index 558735aacca8..000000000000
--- a/Documentation/devicetree/bindings/arm/altera.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-Altera's SoCFPGA platform device tree bindings
----------------------------------------------
-
-Boards with Cyclone 5 SoC:
-Required root node properties:
-compatible = "altr,socfpga-cyclone5", "altr,socfpga";
-
-Boards with Arria 5 SoC:
-Required root node properties:
-compatible = "altr,socfpga-arria5", "altr,socfpga";
-
-Boards with Arria 10 SoC:
-Required root node properties:
-compatible = "altr,socfpga-arria10", "altr,socfpga";
diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
new file mode 100644
index 000000000000..49e0362ddc11
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/altera.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera's SoCFPGA platform device tree bindings
+
+maintainers:
+  - Dinh Nguyen <dinguyen@kernel.org>
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - altr,socfpga-cyclone5
+        - altr,socfpga-arria5
+        - altr,socfpga-arria10
+      - const: altr,socfpga
+...
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
