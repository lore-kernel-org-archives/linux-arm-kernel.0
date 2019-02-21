Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E39C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:00:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF8CD2083E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kzq1/sJG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k6IOv8NP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8CD2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7igRIsWpoI6s0itgEW2RZVeaXwWLG92ikMLnXzO7MRE=; b=Kzq1/sJGgFF6SF
	SwFfMk1LeJZBQ3mvUOtRB1B98QwbJxz70KKqMlWIuBhjE+8X6dZI7HXkf+PlscDPSwdtkZ9W7W/CN
	E2QXVwyoht23eKDNSRMgs2mXTNnPWZhCGyHjIYl9XM+HBHP0Npi5Ii1PyDeZgjBaQKhUKMg6j1rS/
	sQ1EwzLMAJsbUHT6s1tN0zq+YX7tgWawfHNN9Yl43qv57AXjWo/9DgvTJSJ4nGPn+EbFN0I7uU+pR
	65oKUP5QAWS8P0PIJpyeFHFmUyS73ObSbRFZyb//NBag9BvlM//r//VLWs24wII3dx9ZZ7UxmIIPk
	1LwaabAq3vFq0Kl528vQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqlT-0006s0-NL; Thu, 21 Feb 2019 15:59:59 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqXW-00058c-Nw
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:45:50 +0000
Received: by mail-lj1-x242.google.com with SMTP id j13-v6so24437244ljc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/KRBvvDb8vJ/IUxT9QJ5LwxvIcDsKjNvBeUVd1RADoU=;
 b=k6IOv8NPdHKnwkB3ruTvLUZ6lv4iMw4ZoA1QaBdeOXEaVf9a61ykj6wzVVH/Fxgrlj
 SSjcb/k4XWkxbbN/jJeZIDtHZOXvp61POLwEMW6/ZK8S2a1mgu4lEc2q992a9KTUafH1
 pkRXgTmAjaLhei19rvunYSOW68YltBYWx4r7CIAFRzqtXRgBifd/CnsD2EuY/x2CjNvz
 unSL01cre4m1YX4MoXz1IzSrhBtJJaFaSDKjK+vZFloy8Csp+nopDx8+3nhMEihg2SXR
 mBTcmlSTFEIW0VM2ymYyZGe0L6zzMdXxUw8SUXhgH2ue75X6afgfpWNkWjHqUyNsjYR3
 e/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/KRBvvDb8vJ/IUxT9QJ5LwxvIcDsKjNvBeUVd1RADoU=;
 b=ki+SIqvKqlRMzkEn970Cs4i3NwQ90T6qSafd+G6jvXIV70z2Lfn1SqLf3z5vvUe327
 MHdhtQaqNtBpdvQ+M1tJjEH5JvbiJTFu6rBhg0A955A6Rnvc8aBAewwVNSZhwZ2HJCPv
 BCAfg5YuiSvvTgvc8HjFK4RlPypKL7KBS5GVfGaHyo8+/v9Hr1/6XqduEYE/5Z6qKY61
 ikenF4oamvIvYxppS6qr5kwqkdagou3oIi741GdbxJlSbDgdXUw1unioDPhaHBVt8VPw
 cdSoImJad5Pw+5vTbNJgc5H5wGXiZ8eg6S4HPRfKCmJF4+AL22Yo/C4EYc/zRfPI1u3I
 fnog==
X-Gm-Message-State: AHQUAua8/UjxqHWhGU6c3ZjZ06cO+0sskFMNMJLh1C02eIOhbdoU31aV
 gZUN3batsSFgf1IrfklR8Tyx5AmGHxk=
X-Google-Smtp-Source: AHgI3IY3O2+ilBx3HvsdwXYcmn+6qpQ2t4X3/RPpCo2TcClbeScD0RcjWZuEOVVWNYDqb/m87DqOyA==
X-Received: by 2002:a2e:7615:: with SMTP id
 r21-v6mr24318641ljc.131.1550763932024; 
 Thu, 21 Feb 2019 07:45:32 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.45.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:45:31 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 09/30 v2] irqchip: ixp4xx: Add DT bindings
Date: Thu, 21 Feb 2019 16:44:37 +0100
Message-Id: <20190221154458.23763-10-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154458.23763-1-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_074534_926511_A90CD702 
X-CRM114-Status: GOOD (  15.20  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, devicetree@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds device tree bindings for the IXP4xx interrupt
controller. It's a standard 2-cell controller.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Converted to use JSON yaml schema, why not.
- Not keeping Rob's ACK because I think he wants to take
  a second look.
---
 .../intel,ixp4xx-interrupt.yaml               | 57 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml b/Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml
new file mode 100644
index 000000000000..f32c08f270d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2018 Linaro Ltd.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/interrupt/intel-ixp4xx-interrupt.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel IXP4xx XScale Networking Processors Interrupt Controller
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description: |
+  This interrupt controller is found in the Intel IXP4xx processors.
+  Some processors have 32 interrupts, some have up to 64 interrupts.
+  The exact number of interrupts is determined from the compatible
+  string.
+
+  The distinct IXP4xx families with different interrupt controller
+  variations are IXP42x, IXP43x, IXP45x and IXP46x. Those four
+  families were the only ones to reach the developer and consumer
+  market.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+        - enum:
+          - intel,ixp42x-interrupt
+          - intel,ixp43x-interrupt
+          - intel,ixp45x-interrupt
+          - intel,ixp46x-interrupt
+
+  reg:
+    description: The register bank for the interrupt controller.
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description: The number of cells to define the interrupts.
+      with two cells specified in interrupt-controller/interrupts.txt
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+
+examples:
+  - |
+    intcon: interrupt-controller@c8003000 {
+        compatible = "intel,ixp43x-interrupt";
+        reg = <0xc8003000 0x100>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index a2fb67b75026..79f01af59a63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1650,6 +1650,7 @@ M:	Imre Kaloz <kaloz@openwrt.org>
 M:	Krzysztof Halasa <khalasa@piap.pl>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml
 F:	arch/arm/mach-ixp4xx/
 F:	drivers/clocksource/timer-ixp4xx.c
 F:	drivers/gpio/gpio-ixp4xx.c
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
