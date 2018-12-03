Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6FEC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:31:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD2662087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q4jOPOLH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mUky7qus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2662087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a+Yrmbsslkb8mqoZXzPs+7LAVhnLISupjLVHoLzj5fI=; b=q4jOPOLHK4BDl0
	SOsPa3Wo3rgqv6p5KZlsEB3VI5cNv6i1u3WVDvzLNThNxCGGcnlNzXZ6gUbuV+hMAUK5Ez66TshRF
	yesudGgz99SgMOfpfE+/yvYzb31ymsiYC8QV7mrxrsRnD9qPs0GJ7+xYXnPZjkQT6FwL9ERzlTvLz
	NIWnhECqjCwMDvQBUPUPy02aW/V+eztxwHr9MLIIN2SjC6kP3nSgyMJIiLFVdufME+BRQQnts+zlP
	4Ne00ofTPCCh1vjD3fqVUZodoROBMxuoeZlgwM3B35ilojtE51D0eJEUzUNOKe2aa5epwz7s2QCvH
	+9aLYL5N5e94Ktf0TSWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTwkQ-0007bA-Nk; Mon, 03 Dec 2018 22:31:26 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTwkO-0007ax-GC
 for linux-arm-kernel@bombadil.infradead.org; Mon, 03 Dec 2018 22:31:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aP/9dUo4g9hl89aQ4HR1/ZsNrOfnag/55wppWEa93Hs=; b=mUky7qusw7x3CNHrqMP3oF6aq0
 l3x+hp2uiFPw1AJgG/tINRyovyBm1seW33LViA2qTkbsydnHU59h8XGUViiMdDgifoQxqCsDd8U3k
 q2qoVLrS6G7o/+GLyBJXv0rE1Wysty6OVYoDkVNPkDess+YofPngOoNNhhSDNXmKpgp7vC6lIXV6s
 Wh5+o1EwQdCgWfhQroTOkJleYSgKRcGGb7iexjnFIoad2j2YTPIuulMrjoL+QiODqzGnZqnrHdyYg
 dxfmLidKN8XEKSmbAabp5GyR3ZGXQ/cuvD/+lG1q/S5LKJ1MiccrfKYRdX8MeJwdh4v75xa3XzWMk
 RM5m6C+Q==;
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvq5-00036T-4X
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:33:14 +0000
Received: by mail-oi1-f195.google.com with SMTP id c206so12387634oib.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aP/9dUo4g9hl89aQ4HR1/ZsNrOfnag/55wppWEa93Hs=;
 b=M3X9wKegmJ3C/uz7XkLfLaVGYchZTv31SljL6HCmLI/9S/xgWW+UMfx1c6hEQlPoEq
 RF0yEHN7TyjAsC7jGx7effD7vrEAJpsG+0yExqQMD5mMhRwq0oCw1Cvrl48UW5UeEiNS
 GwvSnxriDFqT6H50ndkknEJ+iP+JGhlJdzt5Iq6LAwykJ+w+j2YzuJS3OyLYU6ZHoVNh
 FvtNd2cWH48C+xTDdobwdUZ0rSEJJvM0G+fG6QCvfcuwXx1wnAUx0YAN5nBokpNWT2tR
 QP2tPYuCkIzVB8z7HwgZvZoClZHpUtIBQxvOJV2YspXPKInOjo2IxQKDWO1jCm/vpFO3
 fONQ==
X-Gm-Message-State: AA+aEWaQGGiHZA3GaJMTguSRfSqKNI4DYK1NZcFaerN4puNaqln6CsM3
 NThEZ6VS5pUFOOMne2s2aw==
X-Google-Smtp-Source: AFSGD/VhMeuopsbMmjg3NZLwFCs0tf0JJupxZWjP7qjvPqX37CBQlTeEBpKCQomqRSwKem5n5kBGeg==
X-Received: by 2002:aca:ad53:: with SMTP id w80mr10279520oie.148.1543872782048; 
 Mon, 03 Dec 2018 13:33:02 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.33.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:33:01 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 30/34] dt-bindings: arm: Convert Tegra board/soc bindings
 to json-schema
Date: Mon,  3 Dec 2018 15:32:19 -0600
Message-Id: <20181203213223.16986-31-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_163313_263267_4F84FEC1 
X-CRM114-Status: GOOD (  15.62  )
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
 Frank Rowand <frowand.list@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Grant Likely <grant.likely@arm.com>, Thierry Reding <thierry.reding@gmail.com>,
 linux-tegra@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert Tegra SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: devicetree@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/tegra.txt         |  65 -----------
 .../devicetree/bindings/arm/tegra.yaml        | 101 ++++++++++++++++++
 2 files changed, 101 insertions(+), 65 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/tegra.txt
 create mode 100644 Documentation/devicetree/bindings/arm/tegra.yaml

diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentation/devicetree/bindings/arm/tegra.txt
deleted file mode 100644
index c59b15f64346..000000000000
--- a/Documentation/devicetree/bindings/arm/tegra.txt
+++ /dev/null
@@ -1,65 +0,0 @@
-NVIDIA Tegra device tree bindings
--------------------------------------------
-
-SoCs
--------------------------------------------
-
-Each device tree must specify which Tegra SoC it uses, using one of the
-following compatible values:
-
-  nvidia,tegra20
-  nvidia,tegra30
-  nvidia,tegra114
-  nvidia,tegra124
-  nvidia,tegra132
-  nvidia,tegra210
-  nvidia,tegra186
-  nvidia,tegra194
-
-Boards
--------------------------------------------
-
-Each device tree must specify which one or more of the following
-board-specific compatible values:
-
-  ad,medcom-wide
-  ad,plutux
-  ad,tamonten
-  ad,tec
-  compal,paz00
-  compulab,trimslice
-  nvidia,beaver
-  nvidia,cardhu
-  nvidia,cardhu-a02
-  nvidia,cardhu-a04
-  nvidia,dalmore
-  nvidia,harmony
-  nvidia,jetson-tk1
-  nvidia,norrin
-  nvidia,p2371-0000
-  nvidia,p2371-2180
-  nvidia,p2571
-  nvidia,p2771-0000
-  nvidia,p2972-0000
-  nvidia,roth
-  nvidia,seaboard
-  nvidia,tn7
-  nvidia,ventana
-  toradex,apalis_t30
-  toradex,apalis_t30-eval
-  toradex,apalis_t30-v1.1
-  toradex,apalis_t30-v1.1-eval
-  toradex,apalis-tk1
-  toradex,apalis-tk1-eval
-  toradex,apalis-tk1-v1.2
-  toradex,apalis-tk1-v1.2-eval
-  toradex,colibri_t20
-  toradex,colibri_t20-eval-v3
-  toradex,colibri_t20-iris
-  toradex,colibri_t30
-  toradex,colibri_t30-eval-v3
-
-Trusted Foundations
--------------------------------------------
-Tegra supports the Trusted Foundation secure monitor. See the
-"tlm,trusted-foundations" binding's documentation for more details.
diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
new file mode 100644
index 000000000000..66493892ffc1
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/tegra.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra device tree bindings
+
+maintainers:
+  - Marcel Ziswiler <marcel.ziswiler@toradex.com>
+  - Peter De Schrijver <pdeschrijver@nvidia.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - compal,paz00
+              - compulab,trimslice
+              - nvidia,harmony
+              - nvidia,seaboard
+              - nvidia,ventana
+          - const: nvidia,tegra20
+      - items:
+          - enum:
+              - ad,medcom-wide
+              - ad,plutux
+              - ad,tec
+          - const: ad,tamonten
+          - const: nvidia,tegra20
+      - items:
+          - enum:
+              - toradex,colibri_t20-eval-v3
+              - toradex,colibri_t20-iris
+          - const: toradex,colibri_t20
+          - const: nvidia,tegra20
+      - items:
+          - enum:
+              - nvidia,beaver
+          - const: nvidia,tegra30
+      - items:
+          - enum:
+              - nvidia,cardhu-a02
+              - nvidia,cardhu-a04
+          - const: nvidia,cardhu
+          - const: nvidia,tegra30
+      - items:
+          - const: toradex,apalis_t30-eval
+          - const: toradex,apalis_t30
+          - const: nvidia,tegra30
+      - items:
+          - const: toradex,apalis_t30-eval-v1.1
+          - const: toradex,apalis_t30-eval
+          - const: toradex,apalis_t30-v1.1
+          - const: toradex,apalis_t30
+          - const: nvidia,tegra30
+      - items:
+          - enum:
+              - toradex,colibri_t30-eval-v3
+          - const: toradex,colibri_t30
+          - const: nvidia,tegra30
+      - items:
+          - enum:
+              - nvidia,dalmore
+              - nvidia,roth
+              - nvidia,tn7
+          - const: nvidia,tegra114
+      - items:
+          - enum:
+              - nvidia,jetson-tk1
+              - nvidia,venice2
+          - const: nvidia,tegra124
+      - items:
+          - const: toradex,apalis-tk1-eval
+          - const: toradex,apalis-tk1
+          - const: nvidia,tegra124
+      - items:
+          - const: toradex,apalis-tk1-v1.2-eval
+          - const: toradex,apalis-tk1-eval
+          - const: toradex,apalis-tk1-v1.2
+          - const: toradex,apalis-tk1
+          - const: nvidia,tegra124
+      - items:
+          - enum:
+              - nvidia,norrin
+          - const: nvidia,tegra132
+          - const: nvidia,tegra124
+      - items:
+          - enum:
+              - nvidia,p2371-0000
+              - nvidia,p2371-2180
+              - nvidia,p2571
+          - const: nvidia,tegra210
+      - items:
+          - enum:
+              - nvidia,p2771-0000
+          - const: nvidia,tegra186
+      - items:
+          - enum:
+              - nvidia,p2972-0000
+          - const: nvidia,tegra194
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
