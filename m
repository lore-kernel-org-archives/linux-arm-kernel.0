Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5647C00319
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:50:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98B2D20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d6/XQV8R";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sNakXodk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B2D20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qh105/vIKdAI6zlVT1oJRhrSXgjN8vzuN+lNano0yqs=; b=d6/XQV8RzvIXa4
	8o5J1MWcG/iTvlw48m4f8NJEkBdZD1A7b71U/MO9PF+BtCjvSTXTy4ebGy9ZMWKRzreC/Iqi7T004
	nmRD0jyY/yXvbrDKh8NCmhjHkkieijgmPfxdqfVxGHFQAokMsmnUAJ1sa0RyO/5iC95aKVJCu6oxs
	VYiuXudbPRBigZK1KtTaDRe3N08sirAyUfLu5lPA4h+dP9k+tW1PIQ0Sf11jxWKXcqtQxKjL9wq77
	WTGFVHKt7jxaSEWx0muB++Vk55aOERIaDwdGwlq0OSxcqs8Y1Z2AkPRVA0IfjDsK0Kf9ka+5RGEau
	g0GIARLkHSv/XpEu02aQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqc6-0002cu-KI; Thu, 21 Feb 2019 15:50:18 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqYH-0006AQ-IF
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:46:37 +0000
Received: by mail-lj1-x243.google.com with SMTP id v16so24368862ljg.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Lg7YL4rHndwDCrRxPsXDrWFsjfxlwxbyihlkIAGrRzI=;
 b=sNakXodk/ShNGnRclW/54m3+Tjj+LeFwB4THdg93gKM2eY1OePWEwX1YLdEUuIamy4
 1SZY4YTo78nm2wugtfvH4IF635ZM4an5QS7JqgwBSBU2NL1o7iKuMa0nsSDCzZOxIvR7
 0xCpO7dZKjf8AlAtsBU6yqb/UNilQ3rUy/FFrVkC5QH1+L1gsjA9dmiCtDJpK0lS7pyg
 Vkhvvh+XPr7OPm1VR5FxLM8IlLlSOws7LBlOB/e/L9N13Njdlo9Nc/+4jmGuFac31NGD
 6yKI2q9zAUI4n5/kk0mSegt5qodGCl+V2pOAkrI/q5OPrg4oDrVUOXP1XPxfltDAJ2xa
 ELXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Lg7YL4rHndwDCrRxPsXDrWFsjfxlwxbyihlkIAGrRzI=;
 b=kOfix2MXQ0nP1+gH6HPpwjAsFnHSYDsUbTIDLs/Akovy0tZH8wCKJPllQkMVqxLgvf
 8XO5Gd6iPfqTKsQ1d4GrY24v8ztrzBHmkumPqPfMgU+10fkM6EDhDkCo8dm+AyEi+Ryp
 Abv5FXiUvy6iQoZ47BTEicbffMCv/nycZXz9eIZyBF/wK+fx/KAK4RHv1n9i/U7S96oi
 r2HkMTw0fvzEv7NL1+GBqNbgJjlYaktanPshdbXLNkKrMtMMPGyuSfpChxIP0Tu5YJgy
 x3FETAFUijqTK/rS93/phgLGY/fS91Q88PQhc8DAL92qRIoJ46dbRvDjwy7zpGk1CJ3k
 Qp5A==
X-Gm-Message-State: AHQUAubQUM45KvYoyqrKwVDUW7k1vs3nVgl4qDdiUwJ2T902q+FxoL/Y
 OAYqH3ujydli960Ey2nqlOfpaL0/NyA=
X-Google-Smtp-Source: AHgI3IasHGq3p+GKRu8zS+xzxOTK2Er/noLd/bQVOqctmoRhnO79xgGQvSzLo2RFzpM1/qTEAVEXWA==
X-Received: by 2002:a2e:4784:: with SMTP id
 u126-v6mr24103823lja.124.1550763979328; 
 Thu, 21 Feb 2019 07:46:19 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.46.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:46:18 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 28/30 v2] soc: ixp4xx: qmgr: Add DT bindings for IXP4xx qmgr
Date: Thu, 21 Feb 2019 16:44:56 +0100
Message-Id: <20190221154458.23763-29-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154458.23763-1-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_074621_938169_E21F2A82 
X-CRM114-Status: GOOD (  12.29  )
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
Cc: devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds device tree bindings for the Intel IXP4xx AHB
Queue Manager.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../misc/intel,ixp4xx-queue-manager.yaml      | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/intel,ixp4xx-queue-manager.yaml

diff --git a/Documentation/devicetree/bindings/misc/intel,ixp4xx-queue-manager.yaml b/Documentation/devicetree/bindings/misc/intel,ixp4xx-queue-manager.yaml
new file mode 100644
index 000000000000..c324860bede5
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/intel,ixp4xx-queue-manager.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 Linaro Ltd.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/misc/intel-ixp4xx-ahb-queue-manager.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel IXP4xx AHB Queue Manager
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description: |
+  The IXP4xx AHB Queue Manager maintains queues as circular buffers in
+  an 8KB embedded SRAM along with hardware pointers. It is used by both
+  the XScale processor and the NPEs (Network Processing Units) in the
+  IXP4xx for accelerating queues, especially for networking. Clients pick
+  queues from the queue manager with foo-queue = <&qmgr N> where the
+  &qmgr is a phandle to the queue manager and N is the queue resource
+  number. The queue resources available and their specific purpose
+  on a certain IXP4xx system will vary.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: intel,ixp4xx-ahb-queue-manager
+
+  reg:
+    items:
+      - description: Queue Manager MMIO range
+
+  interrupts:
+    minItems: 2
+    maxItems: 2
+    items:
+      - description: Interrupt for queues 0-31
+      - description: Interrupt for queues 32-63
+
+  '#queue-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    qmgr: queue-manager@60000000 {
+         compatible = "intel,ixp4xx-ahb-queue-manager";
+         reg = <0x60000000 0x4000>;
+         interrupts = <3 IRQ_TYPE_LEVEL_HIGH>, <4 IRQ_TYPE_LEVEL_HIGH>;
+         #queue-cells = <1>;
+    };
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
