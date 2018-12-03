Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA93C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:32:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB652087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sUGDwC5I";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C1sna6TH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB652087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9zcP8Ouh5z50zA3CmHBEYP8EQeRKxvDcDkZbbvas4Po=; b=sUGDwC5I7BrPfK
	UdCRz1GtqApEzJn2wPmQaLRCBqU9eLkTZZG5Z92FswdZ6DTgUjhgfZv/itlcFotJXxpksrzvEXDiL
	hJb8DKio6+G3s3HA/m/Q5GS//FP88TPn+GM+CPbU7Owa6eK7FAFVNzav6WIm5rP+KeE0Pi4h4NCQT
	7iBEaXwb+Gylk7c1BXd3n6oG+jyP1woO5p87HSkr8H2FOwZ0XAOEXrT9frKKJlPfnyNqa2A2q2SOB
	H6qUgWMpxynBU2w4WRcnhnJorY4exnpn+iBzvfilfCy/5naS0cttjdYn75Yp//e03pBtTsnEhXyIW
	uqGzbGW+Skbfo2ieBU6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTwlP-00009G-Q7; Mon, 03 Dec 2018 22:32:27 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTwkU-0007ax-Tq
 for linux-arm-kernel@bombadil.infradead.org; Mon, 03 Dec 2018 22:31:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A1DZ7qanLgT6TNvZv+UGgnb7e+rg6Vx6EWDRxaGp6rc=; b=C1sna6TH2wLwCgt1/AMHyfsWDv
 JMdNXjV+R29Qz7hWWwvP6z6JJ5nk5GXvyYWSiubnTlYuREERgdVX/dPiDIHR7lrWJTOE9JLMg8nA0
 lQ3qqYjDvgsArJLjeXgHYpXdUYlICCI7HXMK2+ltcY6DkxKDagQVUDOiy+q5xVJG3cBszDxjvJuTc
 iQmW8nvyNNWBjeZAeZzARHVe/SQPogfdZEgfgaKz9I/eRQIa/qegbnqsLu9tHEES5OY0Fa/kl+DKH
 /eGsruWvudXdBRaJxxR2yy9n2iT+rII2cgST71HkKRbsfl/6xNjG7/eDkkFF6KURfYD/+1x/yRkth
 RNO7STHw==;
Received: from mail-oi1-f193.google.com ([209.85.167.193])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvq2-00036H-PX
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:33:11 +0000
Received: by mail-oi1-f193.google.com with SMTP id x202so12313417oif.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:33:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A1DZ7qanLgT6TNvZv+UGgnb7e+rg6Vx6EWDRxaGp6rc=;
 b=XSY9pcWpeFXTL46ql1KZX5GPyS7K/oeMXO5ybmrcPhiFcOb1xqtH43D9+BNBJ1R8Ef
 cdUtb0S5mafElVJbOWXWnOuU/IVS4XpV4Wa8Nk4Oex/amL4tDrp2hN1x7mOlzmEHLQVd
 HeAOWJEgCb8FLjbGmtNNc1PBZgyvHZhuP9ksCmFdRjtkPEklNIcx255oaoK58DY5YLay
 R//VtRJ5RTwhdlYMQi3vz8nNcbWf3LysdfJMv6rZZThXMJYYJy2MI5Or2quU95CjUnez
 SQM4v5TEcwUsE/hTPbZCH0trxcA2WNCeMvtT4UJbf6Vq1HZ4aM3935FOMmgvSZ6+F/9e
 fWcw==
X-Gm-Message-State: AA+aEWY9Aok+YmAq6AvdB135rngU8H1RqeI8XXVw/liQ+Omj7hdI//K/
 aMOItk06hNhytESedzCnMg==
X-Google-Smtp-Source: AFSGD/VXUJP/+4/TsKC9atq6RJWaovkxUtpJGDI/LJRj2Z98TIHCTl1R/TP0ERzJIps1ROa6KSijxA==
X-Received: by 2002:aca:d00a:: with SMTP id h10mr10413699oig.316.1543872778504; 
 Mon, 03 Dec 2018 13:32:58 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:32:57 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 27/34] dt-bindings: arm: Convert CSR SiRF board/soc
 bindings to json-schema
Date: Mon,  3 Dec 2018 15:32:16 -0600
Message-Id: <20181203213223.16986-28-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_163310_887535_E9FEDD40 
X-CRM114-Status: GOOD (  14.72  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Barry Song <baohua@kernel.org>,
 Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 Grant Likely <grant.likely@arm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert CSR SiRF SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/sirf.txt          | 11 --------
 .../devicetree/bindings/arm/sirf.yaml         | 27 +++++++++++++++++++
 2 files changed, 27 insertions(+), 11 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/sirf.txt
 create mode 100644 Documentation/devicetree/bindings/arm/sirf.yaml

diff --git a/Documentation/devicetree/bindings/arm/sirf.txt b/Documentation/devicetree/bindings/arm/sirf.txt
deleted file mode 100644
index 7b28ee6fee91..000000000000
--- a/Documentation/devicetree/bindings/arm/sirf.txt
+++ /dev/null
@@ -1,11 +0,0 @@
-CSR SiRFprimaII and SiRFmarco device tree bindings.
-========================================
-
-Required root node properties:
-    - compatible:
-    - "sirf,atlas6-cb" : atlas6 "cb" evaluation board
-    - "sirf,atlas6" : atlas6 device based board
-    - "sirf,atlas7-cb" : atlas7 "cb" evaluation board
-    - "sirf,atlas7" : atlas7 device based board
-    - "sirf,prima2-cb" : prima2 "cb" evaluation board
-    - "sirf,prima2" : prima2 device based board
diff --git a/Documentation/devicetree/bindings/arm/sirf.yaml b/Documentation/devicetree/bindings/arm/sirf.yaml
new file mode 100644
index 000000000000..0b597032c923
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/sirf.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/sirf.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CSR SiRFprimaII and SiRFmarco device tree bindings.
+
+maintainers:
+  - Binghua Duan <binghua.duan@csr.com>
+  - Barry Song <Baohua.Song@csr.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - const: sirf,atlas6-cb
+          - const: sirf,atlas6
+      - items:
+          - const: sirf,atlas7-cb
+          - const: sirf,atlas7
+      - items:
+          - const: sirf,prima2-cb
+          - const: sirf,prima2
+...
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
