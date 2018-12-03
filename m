Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF40DC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:40:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DD9E20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h8fdB5bj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD9E20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=soH6Y6ylds2lkU5kV/VNR8bvlQ1Eo4tjauFJhL3qMX0=; b=h8fdB5bjLJn6n2
	fK2YQ919VIFRcxYBJufVEs2joXHgtShJnIsC5faAhfaKw2zb8qCchu4pQ11i5O5X+hJOMp5xhQ9gw
	ZWZFbOAzMzgoNsX/UdSO1ITozXMYBkzw1KBxmKpm7WH4t0FBL3TeM4jqhA0tHqU05NH4jmVgFVy3O
	NEse9js4DkNhUIfDInG9SiABPnHSQY3+dWS2gb4TnXr4k4U3mgcAP5N7ge8VbBLBoEJc3HcXQM/gj
	mzs5ZHuW3AI10RxDLvDOcUQH1SrbhjejVWNwvb5gU7Zxw11xoLuiAijIiwkwKzi2fHVdAjXzDadSo
	4bZn0yklNlzNK+aqVS8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvxR-00038d-06; Mon, 03 Dec 2018 21:40:49 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvq4-0002Ps-3Y
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:33:25 +0000
Received: by mail-ot1-f67.google.com with SMTP id i20so13136516otl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:33:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8cE1v9dL0zvH+rxZgt//TElW5sNm8BLRK/4XdbU5h9c=;
 b=TGZQOwZ/IzOIZpK7RY6zH0TnQXKuUxEtq3U7m1JhxDTZ+c7ZWE4BLL+/IQ2R+lsi5e
 iEQ5DuN5i1bFVSf11ix+W8YMPKOAnLb+9zRQ3oKvFhdjnZ8GRX1cuOn3KE5vrqmFCo8Q
 LiOnkeqT9XafQSVGYKIfMN37SyRIKh8T78meIi4Dmj2aXK+/6lP6rfy9hIbaWvO6xjZW
 MoiyFi55uWwoH2Sse3vfTlX/MLl0GYYsZw6P3cBiLC7wKGFcZh6gGbGdeqcbDFzyye4R
 /sb+5EivUKPuCY1xlzl0S4aKpna4Qp2Ry0g9Rv7TmZSzZqS0nPB5FzuNiZ81Y+V7ieq/
 D7gA==
X-Gm-Message-State: AA+aEWY8SVd1nDokCOZJZzPFKYyUTfQ/tzVyXE8zgf6BB1dFWu2pq+QG
 gZOzn8bN7zeFlKJ+XY0hQWO5P0Q=
X-Google-Smtp-Source: AFSGD/V4E2Kn34tHeytd72/r5PH7r5wPiTkquvmlJoSQYBqXc4+jB9QkvqYvGiHgfP6dVkM51GiUrA==
X-Received: by 2002:a9d:784a:: with SMTP id c10mr11686907otm.175.1543872780957; 
 Mon, 03 Dec 2018 13:33:00 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:33:00 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 29/34] dt-bindings: arm: Convert ST STi board/soc bindings
 to json-schema
Date: Mon,  3 Dec 2018 15:32:18 -0600
Message-Id: <20181203213223.16986-30-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_133313_645537_4C73AE52 
X-CRM114-Status: GOOD (  13.10  )
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
 Patrice Chotard <patrice.chotard@st.com>, Grant Likely <grant.likely@arm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert ST STi SoC bindings to DT schema format using json-schema.

Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/sti.txt | 23 -------------------
 .../devicetree/bindings/arm/sti.yaml          | 23 +++++++++++++++++++
 2 files changed, 23 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/sti.txt
 create mode 100644 Documentation/devicetree/bindings/arm/sti.yaml

diff --git a/Documentation/devicetree/bindings/arm/sti.txt b/Documentation/devicetree/bindings/arm/sti.txt
deleted file mode 100644
index 8d27f6b084c7..000000000000
--- a/Documentation/devicetree/bindings/arm/sti.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-ST STi Platforms Device Tree Bindings
----------------------------------------
-
-Boards with the ST STiH415 SoC shall have the following properties:
-Required root node property:
-compatible = "st,stih415";
-
-Boards with the ST STiH416 SoC shall have the following properties:
-Required root node property:
-compatible = "st,stih416";
-
-Boards with the ST STiH407 SoC shall have the following properties:
-Required root node property:
-compatible = "st,stih407";
-
-Boards with the ST STiH410 SoC shall have the following properties:
-Required root node property:
-compatible = "st,stih410";
-
-Boards with the ST STiH418 SoC shall have the following properties:
-Required root node property:
-compatible = "st,stih418";
-
diff --git a/Documentation/devicetree/bindings/arm/sti.yaml b/Documentation/devicetree/bindings/arm/sti.yaml
new file mode 100644
index 000000000000..47f9b8eebaa0
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/sti.yaml
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/sti.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST STi Platforms Device Tree Bindings
+
+maintainers:
+  - Patrice Chotard <patrice.chotard@st.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+          - st,stih415
+          - st,stih416
+          - st,stih407
+          - st,stih410
+          - st,stih418
+...
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
