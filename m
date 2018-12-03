Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E75C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:37:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1891C20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M9ZIR3Pc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1891C20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VVmVJ8DiythFQ59PtKKodZi/yiEYZsOQiWhtQ75UsS8=; b=M9ZIR3PcYlQIT9
	hKQeaRyi3pEU/UIAVdbIKTgU0AT3gyjvoPUh2+c1Wq+7OVqucthvL4ECz1+4iLQKVTYC5Rcvc+dee
	8FPFcS9UJIC9nRRQSNlJlStHQKe9HWIL8EWEIbrSLFMh9mh0vW/RB4aztUw03UCZi7fqzbOtKyaHz
	8z/tsE7/9Ext3Ds8X7mVRj6Z8WfdagLNGlNzL1bfZmmcJiuJC3ciMf9fD8bE3Cho1oHa1xOFKySZU
	G0o7Ep2WRokfofDVqQvliayGlEifpHT/vu9PyosX9Un0FdIWlVCow7tic87qmsDH3Jm4Ud8OsPCwn
	KS8ZaHeddYDBU+6/3aCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvuN-0008Hg-E3; Mon, 03 Dec 2018 21:37:39 +0000
Received: from mail-oi1-f193.google.com ([209.85.167.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvph-00022v-Va
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:33:11 +0000
Received: by mail-oi1-f193.google.com with SMTP id v6so12362856oif.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7ekJXPkH8vDQKH6Ka6Zw4d6P9Suv20xxzhFNrwmwfqI=;
 b=IEZZ+GgdBECoi/ycQi/KtYUVDn36rWNN1tpUVjXXFha/bii6TQ9StUSQvNVXcKSyu5
 UW2d2b72qGT2mU/8+Fn2MMDVOzuPBampD6l8n9oQxXbQHeNSk1adQy3JLAoI5jGlxnN/
 nrtNtfbErN8wsqZORKOYBZAUHTTPOoLAxRXf+1WtJPHvGmVvpOSn1AcfK2Pz/ocV0dvE
 XJu5fV66Kx2AZiUWGaBg7CYAmzGkCLJHctt9AZDYdUUZxCG1eN5w5WQJJ0AWctVQOyUo
 wdgNquYlDVVMI0Lo5uuelpRoc+GTGoT4lZvmCw0PSoKJunHyvZYBDtjJLOU9k7ImttbY
 yDog==
X-Gm-Message-State: AA+aEWbfB8pSMoTDUKR7P2O7k36boNjHqDIAy+wNtngc31WcprcE4XPb
 amva2wkFDomlWW+9HTOoQQ==
X-Google-Smtp-Source: AFSGD/VGqOggC/Ka1IFU2DFVSWF9kf0xVvODZsOQESAjd7vG+XHk/5PwWPdPnnsW1F/cu/6lIETVjg==
X-Received: by 2002:aca:c186:: with SMTP id r128mr11602926oif.52.1543872758963; 
 Mon, 03 Dec 2018 13:32:38 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:32:38 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/34] dt-bindings: arm: Convert Alpine board/soc bindings
 to json-schema
Date: Mon,  3 Dec 2018 15:32:00 -0600
Message-Id: <20181203213223.16986-12-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_133250_679917_6F32AE3A 
X-CRM114-Status: GOOD (  13.72  )
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
 Frank Rowand <frowand.list@gmail.com>,
 Antoine Tenart <antoine.tenart@free-electrons.com>,
 Grant Likely <grant.likely@arm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org,
 Tsahee Zidenberg <tsahee@annapurnalabs.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert Alpine SoC bindings to DT schema format using json-schema.

Cc: Tsahee Zidenberg <tsahee@annapurnalabs.com>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/al,alpine.txt     | 16 --------------
 .../devicetree/bindings/arm/al,alpine.yaml    | 21 +++++++++++++++++++
 2 files changed, 21 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/al,alpine.txt
 create mode 100644 Documentation/devicetree/bindings/arm/al,alpine.yaml

diff --git a/Documentation/devicetree/bindings/arm/al,alpine.txt b/Documentation/devicetree/bindings/arm/al,alpine.txt
deleted file mode 100644
index d00debe2e86f..000000000000
--- a/Documentation/devicetree/bindings/arm/al,alpine.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Annapurna Labs Alpine Platform Device Tree Bindings
----------------------------------------------------------------
-
-Boards in the Alpine family shall have the following properties:
-
-* Required root node properties:
-compatible: must contain "al,alpine"
-
-* Example:
-
-/ {
-	model = "Annapurna Labs Alpine Dev Board";
-	compatible = "al,alpine";
-
-	...
-}
diff --git a/Documentation/devicetree/bindings/arm/al,alpine.yaml b/Documentation/devicetree/bindings/arm/al,alpine.yaml
new file mode 100644
index 000000000000..82e2fafdfece
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/al,alpine.yaml
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/al,alpine.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Annapurna Labs Alpine Platform Device Tree Bindings
+
+maintainers:
+  - Tsahee Zidenberg <tsahee@annapurnalabs.com>
+description: test
+
+properties:
+  compatible:
+    items:
+      - const: al,alpine
+  model:
+    items:
+      - const: "Annapurna Labs Alpine Dev Board"
+
+...
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
