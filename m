Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7729C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:50:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63EFB2084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Am/CHKhD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VgT5Q5gZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63EFB2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GyH8SCdSE7nZQJQe/C361LWSDorcUf8/CsLoNIBPhYQ=; b=Am/CHKhDTGsim3
	uSyZ1qvyRouVsypbDhDYgimAdvDeBGGKHHVAQVgAf9JFxx2ME9KtPngGjhaUJTQLNw5P86sqtbkvY
	GwA+ZRPuWt9urI4qbJXBTz9vsVw5aB0S1dkokqGYDQ3N5nyQUFnIWoRRqhRPvCt3cimqZfflR5a5+
	NuX/D15b4K78w3qAi54Qk7XxdwmNcTYIp3WciQsYiGfDjTNemEjfKTaqIQlbHqSsCoWkTn4fT/YeR
	YvEh3nR01SScQF/yRB7bOq8rAQqbYZBwePLiO9qn4cy/Kpdm7hz3aTCbtDNqBfsgPYSZNw++1HN1H
	KLnhJTNYExIWTIud8XTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqbs-0001Bw-GK; Thu, 21 Feb 2019 15:50:04 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqYC-00064Z-QO
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:46:35 +0000
Received: by mail-lf1-x144.google.com with SMTP id v7so20718990lfd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9AKPZy57Xp9MQSyeUW4oZ24ugkhPxGm7E69P5yoWAno=;
 b=VgT5Q5gZ6OYWE6AeqseGL6S8SaOvXfHHkv8k5YlbUuE+MZRsuySHbszh1H5PFb2Frs
 K7WZi46mSmnhmLL7ZrJLdYSTZ+Ue7/ZH6wY4M8UbS2nfQjDuxgF0rhWooP8rA03OXVD+
 9DHvMg8B7hWaAGgTyR3gjzXvAD3I1Kp19sEND5DrcWx9lzGNeVVjEC6LxoDI/slLWOtD
 1YzSqmRYaxyfJjubNCH24KM5IqnFAd/DKnG68t88FuVOM+RvUf0CDX2egNMwBl4vzbqZ
 ChOSA+vRoL09Re/TyudmNNBaGXqqyNNEwzgUo+SuiIFRJob/09W0wfcaOF6QkLLIX+3v
 VSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9AKPZy57Xp9MQSyeUW4oZ24ugkhPxGm7E69P5yoWAno=;
 b=SZZRkDgtaYau3BdhYgxZmwgq+5wvLo0JYjYejkfxXKuZIPhv40o/xpQVisPiM9OZ4K
 9AStXczpNe+X5HUY17HpbQQpeW7DFize7EwKF5skkicdGk28J++61+N7WbrHASEkSoOO
 GzaokMFHr8LDBqpKBT6PrxQnIBLD5qaDh7+59Gaz8G3/UcEZPeVczAHvWWRhNe0v4PmH
 0YsPOgiLH/S4U2ZdbSdPZ9SDbuN3nzavwqzBDwSkrgQvK+Z0s5nsZZWx1aEnS3EV99sk
 I0LsR1j4TRfEzN0tatnShw0IT00bXSMQ7e7Le0RxQ1T+6ygkW6Dl45V5hXD2uFG3uzni
 IQSw==
X-Gm-Message-State: AHQUAuYgG886QanS4OEbOQnKY+/+M4vf330UIyDmyOJSKtxdJXX6ZcAd
 3z67aBTdfgtcGe05+DEzwE58NXzB6FU=
X-Google-Smtp-Source: AHgI3IaxYEcQy4sNY9o7Tmpb4DLH9VE83aVHvAXWsOxHOaOhXmnkOSGbvjC6rekwrZ9Kxs+ZW+piew==
X-Received: by 2002:ac2:5183:: with SMTP id u3mr24292418lfi.153.1550763973564; 
 Thu, 21 Feb 2019 07:46:13 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.46.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:46:12 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 26/30 v2] soc: ixp4xx: Add DT bindings for IXP4xx NPE
Date: Thu, 21 Feb 2019 16:44:54 +0100
Message-Id: <20190221154458.23763-27-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154458.23763-1-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_074617_275280_4D7E7EBD 
X-CRM114-Status: GOOD (  12.99  )
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

This adds DT bindings for the Intel IXP4xx Network Processing
Engine (NPE). These are three firmware-executing units found in
the IXP4xx SoC. These bindings use YAML.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 ...ntel,ixp4xx-network-processing-engine.yaml | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/intel,ixp4xx-network-processing-engine.yaml

diff --git a/Documentation/devicetree/bindings/firmware/intel,ixp4xx-network-processing-engine.yaml b/Documentation/devicetree/bindings/firmware/intel,ixp4xx-network-processing-engine.yaml
new file mode 100644
index 000000000000..8cb136c376fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/intel,ixp4xx-network-processing-engine.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 Linaro Ltd.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/firmware/intel-ixp4xx-network-processing-engine.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel IXP4xx Network Processing Engine
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description: |
+  On the IXP4xx SoCs, the Network Processing Engine (NPE) is a small
+  processor that can load a firmware to perform offloading of networking
+  and crypto tasks. It also manages the MDIO bus to the ethernet PHYs
+  on the IXP4xx platform. All IXP4xx platforms have three NPEs at
+  consecutive memory locations. They are all included in the same
+  device node since they are not independent of each other.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: intel,ixp4xx-network-processing-engine
+
+  reg:
+    minItems: 3
+    maxItems: 3
+    items:
+      - description: NPE0 register range
+      - description: NPE1 register range
+      - description: NPE2 register range
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    npe@c8006000 {
+         compatible = "intel,ixp4xx-network-processing-engine";
+         reg = <0xc8006000 0x1000>, <0xc8007000 0x1000>, <0xc8008000 0x1000>;
+    };
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
