Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C5FC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:31:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CBED2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RJ0RJMSa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gOLEhg/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBED2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SuP0lad+hU05vrbWEZCxTobIc4Vu4Sgm7dsaORzIRtA=; b=RJ0RJMSaDmCO0/
	DREpSRzn4BHNuXs1i7WPGZfavJBiee49hsWXOltwkr59PKm0dt0S++vc3bVEkfbN8FV4EzowPXLDb
	81KtAouLorL4KMADCKxcC4ST5RHceWk2l5cjAa4QnmbFivsUElX75GMGlfIlJ955VSBzfJCH5zrnQ
	hihcGolo/VSNyjd6rRFEVIBlSV+FdLYsy/iaG4RHhd46IhsEnBG6I/X2UOkFrN+jdt1xK5BZ/LnlV
	1XVrp+6rGYrtmCQZmTo4YoZEC0YaT3Ex7JyjrI1F3q92hhsquRsJrojUvwUDShWX/LCifR/u6RF5C
	BdT9alj8HcDEij2ctrAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTwkr-00084Q-QY; Mon, 03 Dec 2018 22:31:53 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTwkR-0007ax-JU
 for linux-arm-kernel@bombadil.infradead.org; Mon, 03 Dec 2018 22:31:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/92DiavR/XOHqaCGpCKXJW+JP+tQRs9C+uVOk6OIp1s=; b=gOLEhg/zTWVenQPEi11DhILuj2
 Xbnj1DD8mqC8zQ12PEaiy6mRe0tMxBXO0u2F1zYTSLTNFWDFOvpfRv1wywfxJiC4FhzQAK2jP66AE
 jMYQ7fWmibVMaYQi90WgLGW/Dd5HLZ2FiuL0XuSQtyAtDJjl5ftiTC2rA145xtEN11R5pmqWyLqdP
 fG+s7TREPKhthrgTw+rwDYNFTGbZxTAsE7CyP+J8SLl0JAyV36ixV4AxI5LB5Z6m5t3smjkzWsGFI
 AO09swAV7OrDZTXgwoPKbu8BwZGhUvRKp1OKqC1IrbyuQR2KEi/Ln00ij6P2VTWG7+wOQpzCJK9wL
 THM6E6AA==;
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvq7-00036X-92
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:33:16 +0000
Received: by mail-ot1-f67.google.com with SMTP id i20so13136696otl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/92DiavR/XOHqaCGpCKXJW+JP+tQRs9C+uVOk6OIp1s=;
 b=ouC1vxNE1rChvzyP7Foh2bpKHqsVNtMBe1l553vM62TSmIarsuz1tB4olD0+N3NKD4
 UINygVCaSNGVV2FlNW3breQoDo73t3NN+hVGfU9zxYUnWF9mrHTIPEo9D9D0jOahbhoc
 eq7XmkLhMZpYSIVL6QgAmxQw0RFVLjxjNqq5K7WeZAlqNC1aatytaUcN1AWLNmEjqsOV
 N6Oj2VwLc0nuXxKvPpCOWfe4R7NYO0j32jMOqh9GKyHUbVsZYy+MpnAiw61rYt6rSCYR
 MBC9YyYgBpvxzM501vTS9KkJUIDaCUVkQQi7C/gdnG+iPoP3+OSR0LY4py6zLM3gRmnF
 49HQ==
X-Gm-Message-State: AA+aEWYVeUm5uuSrhAJyOdDOurFO1BpOArnDHFyKHPjk47kDoWHtvmvS
 oZpced2BnzVHqf2HzhXyCQ==
X-Google-Smtp-Source: AFSGD/VtQ/5gSTtjzeX8q6VwImffvSZJapn9KmJ8qmm7Tc4/yN2d0tyrgec64J8lZNgv4y3KHtwuuA==
X-Received: by 2002:a05:6830:1099:: with SMTP id
 y25mr12304339oto.313.1543872784277; 
 Mon, 03 Dec 2018 13:33:04 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.33.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:33:03 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 32/34] dt-bindings: arm: Convert Xilinx board/soc bindings
 to json-schema
Date: Mon,  3 Dec 2018 15:32:21 -0600
Message-Id: <20181203213223.16986-33-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_163315_399252_36F936F9 
X-CRM114-Status: GOOD (  15.26  )
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
 Frank Rowand <frowand.list@gmail.com>, Michal Simek <michal.simek@xilinx.com>,
 Grant Likely <grant.likely@arm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert Xilinx SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/xilinx.txt        | 83 -------------------
 .../devicetree/bindings/arm/xilinx.yaml       | 82 ++++++++++++++++++
 2 files changed, 82 insertions(+), 83 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/xilinx.txt
 create mode 100644 Documentation/devicetree/bindings/arm/xilinx.yaml

diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
deleted file mode 100644
index 26fe5ecc4332..000000000000
--- a/Documentation/devicetree/bindings/arm/xilinx.txt
+++ /dev/null
@@ -1,83 +0,0 @@
-Xilinx Zynq Platforms Device Tree Bindings
-
-Boards with Zynq-7000 SOC based on an ARM Cortex A9 processor
-shall have the following properties.
-
-Required root node properties:
-    - compatible = "xlnx,zynq-7000";
-
-Additional compatible strings:
-
-- Adapteva Parallella board
-  "adapteva,parallella"
-
-- Avnet MicroZed board
-  "avnet,zynq-microzed"
-  "xlnx,zynq-microzed"
-
-- Avnet ZedBoard board
-  "avnet,zynq-zed"
-  "xlnx,zynq-zed"
-
-- Digilent Zybo board
-  "digilent,zynq-zybo"
-
-- Digilent Zybo Z7 board
-  "digilent,zynq-zybo-z7"
-
-- Xilinx CC108 internal board
-  "xlnx,zynq-cc108"
-
-- Xilinx ZC702 internal board
-  "xlnx,zynq-zc702"
-
-- Xilinx ZC706 internal board
-  "xlnx,zynq-zc706"
-
-- Xilinx ZC770 internal board, with different FMC cards
-  "xlnx,zynq-zc770-xm010"
-  "xlnx,zynq-zc770-xm011"
-  "xlnx,zynq-zc770-xm012"
-  "xlnx,zynq-zc770-xm013"
-
----------------------------------------------------------------
-
-Xilinx Zynq UltraScale+ MPSoC Platforms Device Tree Bindings
-
-Boards with ZynqMP SOC based on an ARM Cortex A53 processor
-shall have the following properties.
-
-Required root node properties:
-    - compatible = "xlnx,zynqmp";
-
-
-Additional compatible strings:
-
-- Xilinx internal board zc1232
-  "xlnx,zynqmp-zc1232-revA", "xlnx,zynqmp-zc1232"
-
-- Xilinx internal board zc1254
-  "xlnx,zynqmp-zc1254-revA", "xlnx,zynqmp-zc1254"
-
-- Xilinx internal board zc1275
-  "xlnx,zynqmp-zc1275-revA", "xlnx,zynqmp-zc1275"
-
-- Xilinx internal board zc1751
-  "xlnx,zynqmp-zc1751"
-
-- Xilinx 96boards compatible board zcu100
-  "xlnx,zynqmp-zcu100-revC", "xlnx,zynqmp-zcu100"
-
-- Xilinx evaluation board zcu102
-  "xlnx,zynqmp-zcu102-revA", "xlnx,zynqmp-zcu102"
-  "xlnx,zynqmp-zcu102-revB", "xlnx,zynqmp-zcu102"
-  "xlnx,zynqmp-zcu102-rev1.0", "xlnx,zynqmp-zcu102"
-
-- Xilinx evaluation board zcu104
-  "xlnx,zynqmp-zcu104-revA", "xlnx,zynqmp-zcu104"
-
-- Xilinx evaluation board zcu106
-  "xlnx,zynqmp-zcu106-revA", "xlnx,zynqmp-zcu106"
-
-- Xilinx evaluation board zcu111
-  "xlnx,zynqmp-zcu111-revA", "xlnx,zynqmp-zcu111"
diff --git a/Documentation/devicetree/bindings/arm/xilinx.yaml b/Documentation/devicetree/bindings/arm/xilinx.yaml
new file mode 100644
index 000000000000..64cd21b737af
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/xilinx.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/xilinx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Zynq Platforms Device Tree Bindings
+
+maintainers:
+  - Michal Simek <michal.simek@xilinx.com>
+
+description: |
+  Xilinx boards with Zynq-7000 SOC or Zynq UltraScale+ MPSoC
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - adapteva,parallella
+              - digilent,zynq-zybo
+              - digilent,zynq-zybo-z7
+              - xlnx,zynq-cc108
+              - xlnx,zynq-zc702
+              - xlnx,zynq-zc706
+              - xlnx,zynq-zc770-xm010
+              - xlnx,zynq-zc770-xm011
+              - xlnx,zynq-zc770-xm012
+              - xlnx,zynq-zc770-xm013
+          - const: xlnx,zynq-7000
+
+      - items:
+          - const: avnet,zynq-microzed
+          - const: xlnx,zynq-microzed
+          - const: xlnx,zynq-7000
+
+      - items:
+          - const: avnet,zynq-zed
+          - const: xlnx,zynq-zed
+          - const: xlnx,zynq-7000
+
+      - items:
+          - enum:
+              - xlnx,zynqmp-zc1751
+          - const: xlnx,zynqmp
+
+      - description: Xilinx internal board zc1232
+        items:
+          - const: xlnx,zynqmp-zc1232-revA
+          - const: xlnx,zynqmp-zc1232
+          - const: xlnx,zynqmp
+
+      - description: Xilinx internal board zc1254
+        items:
+          - const: xlnx,zynqmp-zc1254-revA
+          - const: xlnx,zynqmp-zc1254
+          - const: xlnx,zynqmp
+
+      - description: Xilinx internal board zc1275
+        items:
+          - const: xlnx,zynqmp-zc1275-revA
+          - const: xlnx,zynqmp-zc1275
+          - const: xlnx,zynqmp
+
+      - description: Xilinx 96boards compatible board zcu100
+        items:
+          - const: xlnx,zynqmp-zcu100-revC
+          - const: xlnx,zynqmp-zcu100
+          - const: xlnx,zynqmp
+
+      - description: Xilinx evaluation board zcu102
+        items:
+          - enum:
+              - xlnx,zynqmp-zcu102-revA
+              - xlnx,zynqmp-zcu102-revB
+              - xlnx,zynqmp-zcu102-rev1.0
+          - const: xlnx,zynqmp-zcu102
+          - const: xlnx,zynqmp
+
+...
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
