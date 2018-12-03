Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A33AC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:35:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18F3220851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tzK7XpYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F3220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uYYG06vnKZv78pDxb1A21fbompEB9E6L+NVWE3QApcw=; b=tzK7XpYulE8TTr
	Mf9ONPet1K8v/0TDhr6Xeo6vugpdTWa/021sSMVCsAVBEQ9qN0QQ6EHRufXhzTdoCDagW414sDWG2
	IKMtcXJIuNmR3t6X1xpNjxYxDenrF+Q40oGnLK1seMvpuowl3K96cV6XyzT63cwMgBUg6rOqQU6J7
	9u0+BnNV0ez7zRYDqhekfsYAxLzNc29CJAfypAyobbrllNjsKt5S5cerAJn4Rg/G3F6hfISNcrMwb
	WLye8m08Aq2EdS8CZUvTh/Kh7cyZe1lYOikqJKeefomc59sesBgTta2Rll5u6q5bjWT6+vuQ4zP/G
	TagSxGWRHon0Qq6eNGDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvsG-0005y9-P5; Mon, 03 Dec 2018 21:35:28 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvpe-00027z-1t
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:32:54 +0000
Received: by mail-oi1-f194.google.com with SMTP id m6so12331147oig.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:32:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TWELqPwXjCqkhQiWQTIVxmpoPf+1qSnx8/GOPVWjztw=;
 b=H2F9LCYONFxTxBKQdoLcUtGzaCdUIINtaCxicJctfEPGNDQeO+8lGF3ae5n1ApCXqR
 9KfU1CQE1/JCfPVYYINaZzeRbwQuoFoxs5eVsl61YAoTinLRYLlq6O1T6gR3PpBU3M4q
 o5Wu6xZEyYlGx36RBUpRB6e4xM4yNDEiRQQBF0BMf4kIVaZTU/q3UCN6TnxE/5viZ+rt
 PfFVJblsHWrnrf9IZA1SsFN8zwDhVOwmNCVZhqPRHvEqKtDuV+iVtMEkAnHyoA6H86Uh
 ugENri9txb5xKFudvesuEOVtmtBa88AnUvwOylOItBZpoSXlYYvgLXPBBVTCuyHNvDGP
 tXng==
X-Gm-Message-State: AA+aEWb/FL0dL6HmSjDrC3v1fDX948VysdgD870J5YbgBeV09ad5Gtlf
 SXkZTwjC/VEkwkyhH4K0dw==
X-Google-Smtp-Source: AFSGD/Xw0J/aF8gf6B59Zok0SLOSeIwBWjs7aOXS4v3+j1aMd8Qau4+dAhIQFP+IbvJRjTsf/9zUiw==
X-Received: by 2002:a05:6808:287:: with SMTP id
 z7mr8197663oic.233.1543872765086; 
 Mon, 03 Dec 2018 13:32:45 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:32:44 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/34] dt-bindings: arm: Convert Calxeda board/soc bindings
 to json-schema
Date: Mon,  3 Dec 2018 15:32:05 -0600
Message-Id: <20181203213223.16986-17-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_133246_676152_3C879565 
X-CRM114-Status: GOOD (  12.98  )
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
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert Calxeda SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/calxeda.txt       | 15 -------------
 .../devicetree/bindings/arm/calxeda.yaml      | 22 +++++++++++++++++++
 2 files changed, 22 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/calxeda.txt
 create mode 100644 Documentation/devicetree/bindings/arm/calxeda.yaml

diff --git a/Documentation/devicetree/bindings/arm/calxeda.txt b/Documentation/devicetree/bindings/arm/calxeda.txt
deleted file mode 100644
index 25fcf96795ca..000000000000
--- a/Documentation/devicetree/bindings/arm/calxeda.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-Calxeda Platforms Device Tree Bindings
------------------------------------------------
-
-Boards with Calxeda Cortex-A9 based ECX-1000 (Highbank) SOC shall have the
-following properties.
-
-Required root node properties:
-    - compatible = "calxeda,highbank";
-
-
-Boards with Calxeda Cortex-A15 based ECX-2000 SOC shall have the following
-properties.
-
-Required root node properties:
-    - compatible = "calxeda,ecx-2000";
diff --git a/Documentation/devicetree/bindings/arm/calxeda.yaml b/Documentation/devicetree/bindings/arm/calxeda.yaml
new file mode 100644
index 000000000000..aa5571d23c39
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/calxeda.yaml
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/calxeda.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Calxeda Platforms Device Tree Bindings
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+description: |+
+  Bindings for boards with Calxeda Cortex-A9 based ECX-1000 (Highbank) SOC
+  or Cortex-A15 based ECX-2000 SOCs
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+          - calxeda,highbank
+          - calxeda,ecx-2000
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
