Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB1BC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:34:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79CEF20864
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kDgl3oJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CEF20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eZIBTutv37H5JWWo4bjuxen0gTSG2H15d0ot0P78S7k=; b=kDgl3oJkYY2c/d
	QcJRfUJ7gRuzkaZcIoINZqNyJaDVSb8vRh/P0PO5pBOb3zGjCtUyD55r38faleILl4dEZ+rABnwG+
	xTTpXPJdmeG/0teQyLbYZLYN/4oXdSw2ixyjQ6eNygPrzkCBJUomMCwVUXkzvyFgfYY1YnojtzAk+
	Q6/3buEiqyNFDT7UK3mwJlnOsaREIXhVDzh2YJwwJEzSz2gz8GL31Zfekj4yRmg+bfTkgKxL3kJ82
	CB2rHmo1yiUERxkXW4gTivyLeRECXBloWKBWcTaSBMZYdLL6NS/sgQ42y8AJwByf9JWfnPVNngvrp
	MVC7PnS4UZZLk+Qtw9wA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvrN-0003w8-9G; Mon, 03 Dec 2018 21:34:33 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvpZ-00021Y-PC
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:32:47 +0000
Received: by mail-ot1-f65.google.com with SMTP id 32so13090362ota.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:32:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EX5Bbxszue3VcY0+K5Qoq6qRkzYBy/6q4QLJhvS89M4=;
 b=pH7RSJjU5T4ThZJ8uhodFNWDpIBs5x0b4ir45RPKKHEYaInLY1PFqZ9PLa3t1CuggJ
 IZZr7OyexXGh0/DUxLvhMvwwE2K09gYaF2ORTKsKd2sGmxxcACOX8eaOzXHa9pjbchY8
 AD5LvFtj9n96bPxPDLzT7EY1KvIZP5QMS6wg2hr/TeELMXGxdXGw16+uwPSJPyygPpm7
 ZOmVnR8UtFiKL3qQwarStTilGV3nn4Ih+sUzhDZ2OIb++o84wvKYhyu0B2iMdJEr/n2p
 OroNkOTjwBIWf0nXULW4ejX7vjkMgOl6q8PMjowJ1Htz57Kuxa+XMGruJ1OzOwKCmg+W
 ixeg==
X-Gm-Message-State: AA+aEWbdoN0u9oONB7XKCXULU3Hr/mJ0K8IHCI+MBVQWUmLi8TjncOpq
 RemSu1dwK4wagYdgeaXRIQ==
X-Google-Smtp-Source: AFSGD/WF7Nq4RjBpubQE0Mk/6Ek/fXuMo1qgUM9lgqyh9+USAP97rjhkkMqgQM4pcehTN+upRXCy0Q==
X-Received: by 2002:a9d:620f:: with SMTP id g15mr10489610otj.296.1543872750861; 
 Mon, 03 Dec 2018 13:32:30 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:32:29 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/34] dt-bindings: altera: Convert clkmgr binding to
 json-schema
Date: Mon,  3 Dec 2018 15:31:53 -0600
Message-Id: <20181203213223.16986-5-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_133242_482768_711F1C8A 
X-CRM114-Status: GOOD (  13.96  )
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

Convert Altera clkmgr to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../arm/altera/socfpga-clk-manager.txt        | 11 -------
 .../arm/altera/socfpga-clk-manager.yaml       | 31 +++++++++++++++++++
 2 files changed, 31 insertions(+), 11 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.txt
 create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.yaml

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.txt
deleted file mode 100644
index 2c28f1d12f45..000000000000
--- a/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.txt
+++ /dev/null
@@ -1,11 +0,0 @@
-Altera SOCFPGA Clock Manager
-
-Required properties:
-- compatible : "altr,clk-mgr"
-- reg : Should contain base address and length for Clock Manager
-
-Example:
-	 clkmgr@ffd04000 {
-		compatible = "altr,clk-mgr";
-		reg = <0xffd04000 0x1000>;
-	};
diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.yaml b/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.yaml
new file mode 100644
index 000000000000..e4131fa42b26
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/altera/socfpga-clk-manager.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera SOCFPGA Clock Manager
+
+maintainers:
+  - Dinh Nguyen <dinguyen@kernel.org>
+
+description: test
+
+properties:
+  compatible:
+    items:
+      - const: altr,clk-mgr
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+
+examples:
+  - |
+    clkmgr@ffd04000 {
+      compatible = "altr,clk-mgr";
+      reg = <0xffd04000 0x1000>;
+    };
+
+...
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
