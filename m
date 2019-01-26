Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A638C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 04:11:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A328218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 04:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QMVF8Dry";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G7oDI9X0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A328218CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Dv8+HiZmiB8QsB72Az+LHUpkUR0h9aTEKX+pqztLfFM=; b=QMVF8DryZboHYuvl0Tg2VGfifh
	Fbo0sgmOB8t5tyxD+K3aYVWxdOfha+a1OTiNR6/MUhRZXQfRAv52tjyGSc0W5z2CEDEU/p+noy017
	SS/HOgF5rdbLSpoiC1+TBnhpN972yQThmjWHtQqeheHq+3crBqJyVo1sEgPu9DDbaTdtneCLmq01r
	Z/6ism7+C1o79Rqvt1wc/6eZWcVrbGTCwDpzLCeeDO6Gy5BBmDhfz5xr4ln6Hyw86PBki7Ll4bii8
	DNkAd2/BEbo/YzrNJVsUusmIogavgAmhIfVrY3WR9Rb+WQbbBzysWg1HGx/VVB2j4JCYMFd1zDaR8
	2ZoF0Mvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnFJT-0003Ku-Cj; Sat, 26 Jan 2019 04:11:23 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnFJE-00035x-Eb
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 04:11:11 +0000
Received: by mail-pg1-x542.google.com with SMTP id j10so5021045pga.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 20:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zwq/fMdcgA58BB2frt4nPrnsexnAJmLHano6hGtPJbI=;
 b=G7oDI9X02JXb5jWSWxHginc5z5PpTZe/xrxwjBKLhB78MYbePD8X7Bu+Z+tK1tTj2l
 lysZ3mIJrhkuxary1Sa7nAfEonzfZAHrZe92lsxyx3APOyZ55xBZfLAzKalDv2/IvBBg
 eEspoYqd7XF6MWuAHV6rJjGVCnHaVvVQ2U5k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zwq/fMdcgA58BB2frt4nPrnsexnAJmLHano6hGtPJbI=;
 b=ginQ83SPRb4h2EvrmGhziWBHzVbU4+sIpJ/Yld7pjkRNLsdzKQqYyJWAinAJUKIJhH
 5p1ZlovU2v6kWIxl12vQ8ZQS1g1VQuHu1jc2++nIqvLAE20DvP+S9piFHOw1LkL2/xO6
 +/Mp8JJrdAmmKWuA2CID/d/PIUlESydDoZzvV3E6SRHJP4Vq6I8xKdXb/jUc1zrXF9vr
 qHbkavcCb3KxxlB4aLk/LUqE93xc41C/wV2sotca/DUhgRiaxhBBt0paIWAhQVzbNdQU
 TDU09MrNPsmZHEmMqReaX5wtW3Sp7f9+Pfp7EmRB03YkWNd8wtfrmz/Zq36h6TlDlJ9y
 693Q==
X-Gm-Message-State: AJcUukc3R8+/Mi6z4Kb7hiMCHNBX6fXusRqapPCMM8a7ODdwAnXx+OhA
 B3A+iRf/E2+658sk3jetcoig
X-Google-Smtp-Source: ALg8bN7UGiTX9YWgAr5DhxHGCDm6EWH4q0Wf/Hgsw8kXDcT/m3LeTfkX0A2It+loKCaNLT9iSGko3Q==
X-Received: by 2002:a63:ec13:: with SMTP id j19mr12323766pgh.6.1548475866371; 
 Fri, 25 Jan 2019 20:11:06 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:905:e69d:b1bd:9891:c622:302d])
 by smtp.gmail.com with ESMTPSA id h129sm75099676pfb.110.2019.01.25.20.11.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 20:11:05 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: robh+dt@kernel.org,
	arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/5] dt-bindings: arm: Document Bitmain BM1880 SoC
Date: Sat, 26 Jan 2019 09:40:37 +0530
Message-Id: <20190126041041.13173-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
References: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_201108_725225_C2C96235 
X-CRM114-Status: GOOD (  11.12  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, darren.tsao@bitmain.com,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 haitao.suo@bitmain.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Document Bitmain BM1880 SoC from Bitmain Technologies Ltd along with the
Sophon Edge board.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/arm/bitmain.yaml       | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bitmain.yaml

diff --git a/Documentation/devicetree/bindings/arm/bitmain.yaml b/Documentation/devicetree/bindings/arm/bitmain.yaml
new file mode 100644
index 000000000000..0efdb4ac028e
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bitmain.yaml
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/bitmain.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bitmain platform device tree bindings
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - bitmain,sophon-edge
+      - const: bitmain,bm1880
+...
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
