Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16237C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:33:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC5AF2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RdxyIF3m";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QagPSgNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5AF2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HDd0CK3HjLU0i/DkEixUHQUw/uXbmKwTzj1nVVQhjbA=; b=RdxyIF3mRe+Nko
	FqqMxAkhqRTPfyufL/NJg6OuEYrjAlguPD2ETtE1Hhtzw9a25006tBJlaKkbG/wqHIjbD7fY7Q3Da
	cmw+ZrEMTlPfya3/FQD9BDeAdYLkpohjz5CwrV5IvCQktY0HZiWzZ2++/m1Nz/gIY95I7B7gjr52R
	sH0sTkl2ZC3NSCTvRlaSsZFXCAw9UigTTxZ/TfXJkt4uUygpmcXla7oLn3wGUj/o8GYxNwM092AH7
	oBURnNHbC5/zD0SDehm3GuJnlctYIJU8QLimsqzLZwZZnuZtFrzBAOpzzJYhwNwDvkHegKJXS+RzX
	Gx4Qut1aVkiaNfHCvnaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTwlt-0000fH-Rv; Mon, 03 Dec 2018 22:32:57 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTwkY-0007ax-0R
 for linux-arm-kernel@bombadil.infradead.org; Mon, 03 Dec 2018 22:31:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rQZ8kmJGiAe3meOL8n5CuJdjh4Pdt4Z51xZK+7KE3Xk=; b=QagPSgNxvWVQFpJyMF9rX+rPyX
 sNHaVck/tcCs8Abfzhwb/SohwmLP6eU4DSZeOEEtlKZb85g+MUjbD4rNS3gCr5NtuHeQN0LmTq7vU
 L8MfY7H0s8VPf2AgLacQ2xz/N5cqZzVkLNCBoidfS5OeTimcvItOzc9u3djVZ9DC1bIXJMC7qF0vY
 /92wPnWqqmWt98mYDJIhFcw9UZjw10x4hGanY5MyYgpAZ5kyEh/RyPHhKZBhw/KJm/HA0j0P/Go05
 amRCy+WM6vPEbcwU4Q+Azx+Ja3Wc/6hnAuMVqZg2TEU0PoDWyv4EfNmP+CIPDlLKrS5VKg6m9Tuwg
 6cV2F2Ug==;
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvpx-000366-QC
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:33:07 +0000
Received: by mail-ot1-f65.google.com with SMTP id f18so13096504otl.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rQZ8kmJGiAe3meOL8n5CuJdjh4Pdt4Z51xZK+7KE3Xk=;
 b=XR9A081Y+1QYX51e35h6t5eSFEhhg+O1hqtJH5+b4+FF/+O+MNlSqOBPKr74K6nCQm
 sph0+ovwlJJYXEJbdeTPSwDFF8zEYZrEyxJFZf8kdNtMqOx0Lt6wzMZ3JNFcCBsZWDTw
 XCiOhUNS5+iOQ0YqHGBU7OpxkameGqhSHA9cDUDATPb8fbQfyXuoAb1uU7yF6/pAFG+u
 tpeb3Yb8N5q1019Lb110hokW3LkpH3c5hY224BnbPvVp1/sNUJ0QnFi9onL0f5cxWaCr
 NP+VXtxRfIRp2PSgL8CX/omcMmR359KYxM1eUQHTkthWlg9d7V61L9EBN2IhkZmBnQMY
 RS9g==
X-Gm-Message-State: AA+aEWZUFIW+Gfyp0Qfifyze5SqEaANSmOGA+Bru45+RMFu53WCtYiaM
 Mo4iTBJnC2RBYW2nnb69Gw==
X-Google-Smtp-Source: AFSGD/XMa0kBRnoWR5AxYuedsAPrfI6e6I59G8+Z57rVk564hdCQ0IkmYLCjev7urA2vAx9c/b5eXA==
X-Received: by 2002:a9d:346:: with SMTP id 64mr11642597otv.90.1543872772572;
 Mon, 03 Dec 2018 13:32:52 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:32:51 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/34] dt-bindings: arm: Convert QCom board/soc bindings to
 json-schema
Date: Mon,  3 Dec 2018 15:32:11 -0600
Message-Id: <20181203213223.16986-23-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_163305_861716_DB667650 
X-CRM114-Status: GOOD (  17.30  )
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
 Frank Rowand <frowand.list@gmail.com>, David Brown <david.brown@linaro.org>,
 Grant Likely <grant.likely@arm.com>, Andy Gross <andy.gross@linaro.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert QCom SoC bindings to DT schema format using json-schema.

Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/qcom.txt          |  57 --------
 .../devicetree/bindings/arm/qcom.yaml         | 125 ++++++++++++++++++
 2 files changed, 125 insertions(+), 57 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/qcom.txt
 create mode 100644 Documentation/devicetree/bindings/arm/qcom.yaml

diff --git a/Documentation/devicetree/bindings/arm/qcom.txt b/Documentation/devicetree/bindings/arm/qcom.txt
deleted file mode 100644
index ee532e705d6c..000000000000
--- a/Documentation/devicetree/bindings/arm/qcom.txt
+++ /dev/null
@@ -1,57 +0,0 @@
-QCOM device tree bindings
--------------------------
-
-Some qcom based bootloaders identify the dtb blob based on a set of
-device properties like SoC and platform and revisions of those components.
-To support this scheme, we encode this information into the board compatible
-string.
-
-Each board must specify a top-level board compatible string with the following
-format:
-
-	compatible = "qcom,<SoC>[-<soc_version>][-<foundry_id>]-<board>[/<subtype>][-<board_version>]"
-
-The 'SoC' and 'board' elements are required. All other elements are optional.
-
-The 'SoC' element must be one of the following strings:
-
-	apq8016
-	apq8074
-	apq8084
-	apq8096
-	msm8916
-	msm8974
-	msm8992
-	msm8994
-	msm8996
-	mdm9615
-	ipq8074
-	sdm845
-
-The 'board' element must be one of the following strings:
-
-	cdp
-	liquid
-	dragonboard
-	mtp
-	sbc
-	hk01
-
-The 'soc_version' and 'board_version' elements take the form of v<Major>.<Minor>
-where the minor number may be omitted when it's zero, i.e.  v1.0 is the same
-as v1. If all versions of the 'board_version' elements match, then a
-wildcard '*' should be used, e.g. 'v*'.
-
-The 'foundry_id' and 'subtype' elements are one or more digits from 0 to 9.
-
-Examples:
-
-	"qcom,msm8916-v1-cdp-pm8916-v2.1"
-
-A CDP board with an msm8916 SoC, version 1 paired with a pm8916 PMIC of version
-2.1.
-
-	"qcom,apq8074-v2.0-2-dragonboard/1-v0.1"
-
-A dragonboard board v0.1 of subtype 1 with an apq8074 SoC version 2, made in
-foundry 2.
diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
new file mode 100644
index 000000000000..f6316ab66385
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/qcom.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QCOM device tree bindings
+
+maintainers:
+  - Stephen Boyd <sboyd@codeaurora.org>
+
+description: |
+  Some qcom based bootloaders identify the dtb blob based on a set of
+  device properties like SoC and platform and revisions of those components.
+  To support this scheme, we encode this information into the board compatible
+  string.
+
+  Each board must specify a top-level board compatible string with the following
+  format:
+
+  	compatible = "qcom,<SoC>[-<soc_version>][-<foundry_id>]-<board>[/<subtype>][-<board_version>]"
+
+  The 'SoC' and 'board' elements are required. All other elements are optional.
+
+  The 'SoC' element must be one of the following strings:
+
+  	apq8016
+  	apq8074
+  	apq8084
+  	apq8096
+  	msm8916
+  	msm8974
+  	msm8992
+  	msm8994
+  	msm8996
+  	mdm9615
+  	ipq8074
+  	sdm845
+
+  The 'board' element must be one of the following strings:
+
+  	cdp
+  	liquid
+  	dragonboard
+  	mtp
+  	sbc
+  	hk01
+
+  The 'soc_version' and 'board_version' elements take the form of v<Major>.<Minor>
+  where the minor number may be omitted when it's zero, i.e.  v1.0 is the same
+  as v1. If all versions of the 'board_version' elements match, then a
+  wildcard '*' should be used, e.g. 'v*'.
+
+  The 'foundry_id' and 'subtype' elements are one or more digits from 0 to 9.
+
+  Examples:
+
+  	"qcom,msm8916-v1-cdp-pm8916-v2.1"
+
+  A CDP board with an msm8916 SoC, version 1 paired with a pm8916 PMIC of version
+  2.1.
+
+  	"qcom,apq8074-v2.0-2-dragonboard/1-v0.1"
+
+  A dragonboard board v0.1 of subtype 1 with an apq8074 SoC version 2, made in
+  foundry 2.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - qcom,apq8016-sbc
+          - const: qcom,apq8016
+
+      - items:
+          - enum:
+              - qcom,apq8064-cm-qs600
+              - qcom,apq8064-ifc6410
+          - const: qcom,apq8064
+
+      - items:
+          - enum:
+              - qcom,apq8074-dragonboard
+          - const: qcom,apq8074
+
+      - items:
+          - enum:
+              - qcom,apq8060-dragonboard
+              - qcom,msm8660-surf
+          - const: qcom,msm8660
+
+      - items:
+          - enum:
+              - qcom,apq8084-mtp
+              - qcom,apq8084-sbc
+          - const: qcom,apq8084
+
+      - items:
+          - enum:
+              - qcom,msm8960-cdp
+          - const: qcom,msm8960
+
+      - items:
+          - const: qcom,msm8916-mtp/1
+          - const: qcom,msm8916-mtp
+          - const: qcom,msm8916
+
+      - items:
+          - const: qcom,msm8996-mtp
+
+      - items:
+          - const: qcom,ipq4019
+
+      - items:
+          - enum:
+              - qcom,ipq8064-ap148
+          - const: qcom,ipq8064
+
+      - items:
+          - enum:
+              - qcom,ipq8074-hk01
+          - const: qcom,ipq8074
+
+...
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
