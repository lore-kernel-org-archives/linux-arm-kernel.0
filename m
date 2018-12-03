Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAA8C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:39:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6A5920672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qEXtddfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A5920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lZMzupoXzUq9CZoxrGzIiglzMJLJKqx76qeuuaaQ2Ic=; b=qEXtddfM2631G9
	wWqE2b1QmtR2iKt9/l1BfTx3RNVrrRxR9eWfpiKl5X0VJEbk3/HKfImuG3lvkV/plZaG6tBp2m1qs
	5AZmLtVbG/qNr8CY9muZsbfCMpRLyncDT031FDS1RgOuXLq4hBNMyeobELIuhwSJMp/H1Q8LR+iba
	MLsPS5BokO0VVwo08WKrc+ULxjyuqQlj7Hzpv4o+oY6SwQLFJVa8W1XgYExJaoFKLRxmCIz9Y12UP
	wCB9Uf+AEXizo8JynjAV5lwE55AtYKTRy2+WWHozAYea3VNf9WVj7quoysf9vmS5K664zVm8ZidIp
	KXE+yo+samyJ6WfKTLWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvvj-00016g-Tn; Mon, 03 Dec 2018 21:39:03 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvq9-0002Vo-AQ
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:33:40 +0000
Received: by mail-oi1-f194.google.com with SMTP id u18so12339960oie.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:33:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bmY97rqmVLH/aYhI9MMshRrLQb1X3srsPldhSeApmNY=;
 b=CGwBGLtqTw8xdz1Rs3+8NwxngosFsB9eJihk4UARJ1W1vr6IbYhyakHK2yM34uQBgk
 lx5hpemLrkNkh69COi4JLS+zNJnpBlFDOIjsc2M+6cvnll9EE+YZbdxU6S5dspC+Sw4e
 w+osUJxXecr0ucE2Wy5IPSk8L4k/fQKbaPMClMgX+DQgpUHJ85GcMUh6iTD8JrO17sRi
 echVJx7DBcv6wk71JviOI5wQSTr3OOJRpZ+DAVCqSxrrPid+0J5nGLWo0fzF1g5xQfP4
 bNqWy6QvSx4Ldsuth/lGNgDdkF0HJLn6yrpEFvzFp0Fr7aZA8g2D9US5DQVMn1y6UDnp
 ThAg==
X-Gm-Message-State: AA+aEWYYkUl2tBeKMdH5BbjJOwvPHVcTSK/nz/k794a24xuS21uzPI9a
 F9iJ8A08Qk4WOm860jYDcg==
X-Google-Smtp-Source: AFSGD/VCt7hGvmZxKqKvQyo6sGAvlI0gmsrPJbiXunL2+nUrFgxM5xIaK1eaMkx9Ocdoag5aHiHaLQ==
X-Received: by 2002:a05:6808:287:: with SMTP id
 z7mr8198529oic.233.1543872786508; 
 Mon, 03 Dec 2018 13:33:06 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.33.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:33:05 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 34/34] dt-bindings: arm: Convert ZTE board/soc bindings to
 json-schema
Date: Mon,  3 Dec 2018 15:32:23 -0600
Message-Id: <20181203213223.16986-35-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_133318_039765_62FA6473 
X-CRM114-Status: GOOD (  13.82  )
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
 Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@arm.com>,
 Shawn Guo <shawnguo@kernel.org>, Jun Nie <jun.nie@linaro.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert ZTE SoC bindings to DT schema format using json-schema.

Cc: Jun Nie <jun.nie@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Acked-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/zte.txt | 14 ----------
 .../devicetree/bindings/arm/zte.yaml          | 26 +++++++++++++++++++
 2 files changed, 26 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/zte.txt
 create mode 100644 Documentation/devicetree/bindings/arm/zte.yaml

diff --git a/Documentation/devicetree/bindings/arm/zte.txt b/Documentation/devicetree/bindings/arm/zte.txt
deleted file mode 100644
index 340612794a37..000000000000
--- a/Documentation/devicetree/bindings/arm/zte.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-ZTE platforms device tree bindings
-
----------------------------------------
--  ZX296702 board:
-    Required root node properties:
-      - compatible = "zte,zx296702-ad1", "zte,zx296702"
-
----------------------------------------
--  ZX296718 SoC:
-    Required root node properties:
-      - compatible = "zte,zx296718"
-
-ZX296718 EVB board:
-      - "zte,zx296718-evb"
diff --git a/Documentation/devicetree/bindings/arm/zte.yaml b/Documentation/devicetree/bindings/arm/zte.yaml
new file mode 100644
index 000000000000..2d3fefdccdff
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/zte.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/zte.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ZTE platforms device tree bindings
+
+maintainers:
+  - Jun Nie <jun.nie@linaro.org>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - zte,zx296702-ad1
+          - const: zte,zx296702
+      - items:
+          - enum:
+              - zte,zx296718-evb
+          - const: zte,zx296718
+
+...
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
