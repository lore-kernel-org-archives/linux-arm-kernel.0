Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B79FC00319
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:47:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C92120855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gIBcoAqt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SdzM9T+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C92120855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I+fitr4ogctB7ZB2BJ9p2NuNYHwzszkw1P/A61suFQA=; b=gIBcoAqtHrooxA
	GRBDbQlYKvSHeumF0qf7ekTvBkmTobIcM2rPwnRZTE2lygVJvMQVG6t31KSHZZfJniWILvdyLBFOh
	UB3hbmgQG8KH/Q8tTWnkTqXc7rYO4K5M6hujkvvyHV6Jd14pT+2bB1O/OhKvf4Ix2SYlpH4yj5DqS
	PmgIZS6xgduqeR4gD3W5l7QOBToryEMox8FTe2nnRUiwuQM//bVF/Bk5TlPemX55AN3a4mFq2UiRm
	nLQh1K50ViMweOHE2qAsbRuingNmfRHlFyT+NkWYaQZ5BR54L7NdnZB6BB5oYgO7r4O4eqm0S8T3D
	+bwTddUuHMY3wYFBUBoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqZW-0007R6-Ec; Thu, 21 Feb 2019 15:47:38 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqXb-0005G5-Og
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:46:03 +0000
Received: by mail-lj1-x241.google.com with SMTP id j13-v6so24437546ljc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M/pLMnhSvVZVSoeIbvbkl48PXY+MXU30hXCPMAGgHSA=;
 b=SdzM9T+2iClRMDmhsUvvmz03nLqcCFgpPqPcBKfeOiUrn/qWefqEtsGcvPi9aKsvpv
 TVq27v4vX8byObujRH25aagGli99Yau+u+KO2bxevjZ/4VWau1ofDemTXjKQHE0cN7DV
 qlIvsIOzOA38/wJsVhk2h93XFWO6m3cUonbpFj1qadqzFDg3T//R8mneeygAMtC0zZRd
 yeKlUOB1NM1BC2OCZer2BG11kH2Anlt+CodshlNd63i7WMDoSDk9gGBKUoenOYfgySQE
 DaVN9JBb9Uat6Zvwnojx3NmA3bAd4wKw6p4D6QrPO5QjVW74/vcW7sWQ+WHPpoXhRFJt
 chUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M/pLMnhSvVZVSoeIbvbkl48PXY+MXU30hXCPMAGgHSA=;
 b=YUSs1nTiBipRFoHutXUTmgymBkCU1UQzWcByWqGaz4qJ8e2mlTONa9//wtVuCSbqy2
 FhkD85lHIj3WAQZ2vlgYTCULRGMGsUg+7Kz1HoroV2dPLKryL3PK9Xaxhmxi/ZZ4ovKQ
 rrPfe5MAIpQPk3G7uXvUqt6K6NEmYObecRaGjaq3ux1TkhlAdBCALoMaWSI3PEvd8o6j
 bV0SbtoJkHGSX4fwaI/heicEYzLdcYWTl7/AkacC0XbU37nI+ZKa8j6dsIJf/ngiYZnm
 ZcKgvQOj2ph2PhKpFMU+hrzda9+NHGEZMvOpVniNXWAWtopx83EpTpZdONkLc/Lh1XUI
 8a6Q==
X-Gm-Message-State: AHQUAuYVFqfB3vNT8kKZBzthDfzIONjbvPTlDLvf+uVWpqN91oJDTuOz
 wUzRGzDPWBmLkMSwhjQuYQbDbPF0hI4=
X-Google-Smtp-Source: AHgI3IYqN59k/Lq7Iwr65+N8Rb1pSwyscJdodUPM4jfC1b21YuFhwueitsu05UqmTyxGMipPFAdKKw==
X-Received: by 2002:a2e:9c8e:: with SMTP id x14mr7744850lji.166.1550763937419; 
 Thu, 21 Feb 2019 07:45:37 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.45.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:45:36 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 11/30 v2] clocksource/drivers/ixp4xx: Add DT bindings
Date: Thu, 21 Feb 2019 16:44:39 +0100
Message-Id: <20190221154458.23763-12-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154458.23763-1-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_074540_122615_596EE1B8 
X-CRM114-Status: GOOD (  14.50  )
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
Cc: devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds device tree bindings for the Intel IXP4xx
timers.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Switch to JSON YAML schema, why not.
- Not collecting any review tags as this changed a bit.
---
 .../bindings/timer/intel,ixp4xx-timer.yaml    | 42 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.yaml b/Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.yaml
new file mode 100644
index 000000000000..a36a0746c056
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2018 Linaro Ltd.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/timer/intel-ixp4xx-timer.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel IXP4xx XScale Networking Processors Timers
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description: This timer is found in the Intel IXP4xx processors.
+
+properties:
+  compatible:
+    items:
+      - const: intel,ixp4xx-timer
+
+  reg:
+    description: Should contain registers location and length
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: Timer 1 interrupt
+      - description: Timer 2 interrupt
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    timer@c8005000 {
+        compatible = "intel,ixp4xx-timer";
+        reg = <0xc8005000 0x100>;
+        interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 79f01af59a63..bd04142b1026 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1651,6 +1651,7 @@ M:	Krzysztof Halasa <khalasa@piap.pl>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml
+F:	Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.yaml
 F:	arch/arm/mach-ixp4xx/
 F:	drivers/clocksource/timer-ixp4xx.c
 F:	drivers/gpio/gpio-ixp4xx.c
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
