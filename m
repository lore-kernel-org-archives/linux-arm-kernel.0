Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEAAC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:34:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B17A20864
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lFFCakL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B17A20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=za8KdaOxnVOoLX4d5C/m2t/ucW0/UE6sQTfyKs9KxWc=; b=lFFCakL/p90Km2
	rZSss6TE0GlBqW5FAiQGo2pYmNSHOBROB2hnL/Q/pSFkhKHr3hoL9XAKcXZkAD344GLcGWA97mJek
	KTN7AaLBvkGLVG6cyEirn8LViDowIumUg1FRgqnySgSwLmxmc7Xubm/SGSSvHt5GL/YmstQypmJ/W
	Nktr10/ZrdD+q7DWdBgsybViNDp0Y7sqT7NuLYLWqz5Gfg0zCtNz3G1U/P0zvq2pOxRGKjT9ChBiJ
	DMy6DroRGi7AMD4c71j4mDXOd2SUjho7OGcz/3VqGysnmKfRX4WZ/3aXr2VI/8dV6XfW2XQoK5HUI
	ubhi6a4TKLGeKRYgjw/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvr6-0003h1-Qg; Mon, 03 Dec 2018 21:34:16 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvpZ-00021a-PE
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:32:49 +0000
Received: by mail-ot1-f65.google.com with SMTP id v23so13106389otk.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:32:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r8hHjlrgRb6o1Gybi9b4yXPPCrMqQy6hVm/Nzderzac=;
 b=cHjils106SsAPvhcF75lhnEbEN5mLrGkzB9IqglAZGm1CF1Tnuw8UbR0xVvF/AAodu
 vyXr5qZ2ACXBFx0M8cCqm/XnjQIHak7VfD/uLlJWcNBsFLPZkciBfQEJrWD+H9qmwV5E
 lgvPOdV5DBvlpjaxgKhdT+yDV1G89unNkkud58N5lckPHu/wme0C2Ybi5CEbtGIAd8dc
 weKIOO6abx+uxm6F4TyGne7tkO50Ho46R2nGUeTZ5ZRw5APmJzwE+eCdvs1ctUIziFEz
 /rPWKusOxGnARcNSBuP9EnZvhZTrIQM3Fx6GeHZbPPP0Ec3o6BZ4blsb6l5pFyXjb7zl
 HkGQ==
X-Gm-Message-State: AA+aEWZ82K9nsr24a14nrPN982iHlGsO3NRyPWsalkmE4nQWdoizE83A
 EI6H7fVSa+mzNYBoQQRYxilSsTk=
X-Google-Smtp-Source: AFSGD/U1q5zdn1LQBvwIziKGdAO2KoR11z7owggnYBrzJQspi/AhLcah+Bq3pcrKybosnc7TgdH3gA==
X-Received: by 2002:a9d:6c11:: with SMTP id f17mr10582822otq.38.1543872751944; 
 Mon, 03 Dec 2018 13:32:31 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:32:31 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/34] dt-bindings: i2c: Convert i2c-gpio binding to
 json-schema
Date: Mon,  3 Dec 2018 15:31:54 -0600
Message-Id: <20181203213223.16986-6-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_133242_267436_4CD785D7 
X-CRM114-Status: GOOD (  17.39  )
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
Cc: Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 Grant Likely <grant.likely@arm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert the i2c-gpio binding to DT schema format using json-schema. This
serves as an example of how to include other schema (i2c-controller.yaml
in this case).

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/i2c/i2c-gpio.txt      | 46 ------------
 .../devicetree/bindings/i2c/i2c-gpio.yaml     | 73 +++++++++++++++++++
 2 files changed, 73 insertions(+), 46 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-gpio.yaml

diff --git a/Documentation/devicetree/bindings/i2c/i2c-gpio.txt b/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
deleted file mode 100644
index 38a05562d1d2..000000000000
--- a/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-Device-Tree bindings for i2c gpio driver
-
-Required properties:
-	- compatible = "i2c-gpio";
-	- sda-gpios: gpio used for the sda signal, this should be flagged as
-	  active high using open drain with (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)
-	  from <dt-bindings/gpio/gpio.h> since the signal is by definition
-	  open drain.
-	- scl-gpios: gpio used for the scl signal, this should be flagged as
-	  active high using open drain with (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)
-	  from <dt-bindings/gpio/gpio.h> since the signal is by definition
-	  open drain.
-
-Optional properties:
-	- i2c-gpio,scl-output-only: scl as output only
-	- i2c-gpio,delay-us: delay between GPIO operations (may depend on each platform)
-	- i2c-gpio,timeout-ms: timeout to get data
-
-Deprecated properties, do not use in new device tree sources:
-	- gpios: sda and scl gpio, alternative for {sda,scl}-gpios
-	- i2c-gpio,sda-open-drain: this means that something outside of our
-	  control has put the GPIO line used for SDA into open drain mode, and
-	  that something is not the GPIO chip. It is essentially an
-	  inconsistency flag.
-	- i2c-gpio,scl-open-drain: this means that something outside of our
-	  control has put the GPIO line used for SCL into open drain mode, and
-	  that something is not the GPIO chip. It is essentially an
-	  inconsistency flag.
-
-Example nodes:
-
-#include <dt-bindings/gpio/gpio.h>
-
-i2c@0 {
-	compatible = "i2c-gpio";
-	sda-gpios = <&pioA 23 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
-	scl-gpios = <&pioA 24 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
-	i2c-gpio,delay-us = <2>;	/* ~100 kHz */
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	rv3029c2@56 {
-		compatible = "rv3029c2";
-		reg = <0x56>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/i2c/i2c-gpio.yaml b/Documentation/devicetree/bindings/i2c/i2c-gpio.yaml
new file mode 100644
index 000000000000..da6129090a8e
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-gpio.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/i2c-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bindings for GPIO bitbanged I2C
+
+maintainers:
+  - Wolfram Sang <wolfram@the-dreams.de>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: i2c-gpio
+
+  sda-gpios:
+    description:
+      gpio used for the sda signal, this should be flagged as
+      active high using open drain with (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)
+      from <dt-bindings/gpio/gpio.h> since the signal is by definition
+      open drain.
+    maxItems: 1
+
+  scl-gpios:
+    description:
+      gpio used for the scl signal, this should be flagged as
+      active high using open drain with (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)
+      from <dt-bindings/gpio/gpio.h> since the signal is by definition
+      open drain.
+    maxItems: 1
+
+  i2c-gpio,scl-output-only:
+    description: scl as output only
+    type: boolean
+
+  i2c-gpio,delay-us:
+    description: delay between GPIO operations (may depend on each platform)
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  i2c-gpio,timeout-ms:
+    description: timeout to get data
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  # Deprecated properties, do not use in new device tree sources:
+  gpios:
+    minItems: 2
+    maxItems: 2
+    description: sda and scl gpio, alternative for {sda,scl}-gpios
+
+  i2c-gpio,sda-open-drain:
+    # Generate a warning if present
+    not: true
+    description: this means that something outside of our control has put
+      the GPIO line used for SDA into open drain mode, and that something is
+      not the GPIO chip. It is essentially an inconsistency flag.
+
+  i2c-gpio,scl-open-drain:
+    # Generate a warning if present
+    not: true
+    description: this means that something outside of our control has put the
+      GPIO line used for SCL into open drain mode, and that something is not
+      the GPIO chip. It is essentially an inconsistency flag.
+
+required:
+  - compatible
+  - sda-gpios
+  - scl-gpios
+
+...
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
