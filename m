Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25944C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:06:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E97F220656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T+pynvt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97F220656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uQA/za8fHnyu4gnAwn5UdkqKkT69WWxwVnQTF+p24xE=; b=T+pynvt4IB8Jtm
	tQ9J7544bLU37/1fup4qpmJNnL+UBp2+KJdTtckLA5BA57u1qVXR5s2LXfI11zx2nr8nfGK/4iRup
	LrlMU6rjwH0n4U7ZeBHWTV5H0kFao9uKA1aZCsv4G2gU1tl2BBQX+7RBzz67jMvDNhxkKU3jfhco4
	Yb3tOJxW6B6fZh8xA+LaQIRUFx5+/ZAYYUOH01l20Q2DJlO134ueKiqOBXGQbnaRQ2uQuWtduXiYn
	GQqACHEQepTsGjFeSejuwdSWEnd1TuozMH5kZKCYEHiTk8QpVIBx56ppHXSQQuizFcgBm3x+KZ7NV
	/jRHkzyrfJFJikvMWA+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj10F-0006xJ-Pu; Mon, 14 Jan 2019 12:06:03 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj100-0006h4-4A; Mon, 14 Jan 2019 12:05:51 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECC0880D;
 Mon, 14 Jan 2019 04:05:47 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
 [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BA1A13F5BD;
 Mon, 14 Jan 2019 04:05:46 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: heiko@sntech.de
Subject: [PATCH v2 1/4] arm64: dts: rockchip: Add DT for NanoPi M4
Date: Mon, 14 Jan 2019 12:05:31 +0000
Message-Id: <a96995cfa599792b24e740ce46d53bd68ef1d462.1547466003.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.20.1.dirty
In-Reply-To: <cover.1547466003.git.robin.murphy@arm.com>
References: <cover.1547466003.git.robin.murphy@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_040548_574912_28686667 
X-CRM114-Status: GOOD (  20.00  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-rockchip@lists.infradead.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

There are a number of subtle differences between the nanopi4 variants,
and where they disagree, the common DTSI currently follows the details
of NanoPi M4. In order to improve matters even more, let's add a
separate DTS for the M4 to which we can start splitting things out
appropriately. The third variant, NanoPi NEO4, is a lot closer to the M4
than either is to the larger T4, so arguably could get away with just
sharing the M4 DT for now (plus I have neither of the smaller boards to
actually test with).

CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Fix the copy-paste binding thinko

 .../devicetree/bindings/arm/rockchip.yaml      |  6 ++++--
 arch/arm64/boot/dts/rockchip/Makefile          |  1 +
 .../boot/dts/rockchip/rk3399-nanopi-m4.dts     | 18 ++++++++++++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index bcc60c492a12..fb46fecab542 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -87,9 +87,11 @@ properties:
           - const: firefly,roc-rk3399-pc
           - const: rockchip,rk3399
 
-      - description: FriendlyElec NanoPC-T4
+      - description: FriendlyElec NanoPi4 series boards
         items:
-          - const: friendlyarm,nanopc-t4
+          - enum:
+              - friendlyarm,nanopc-t4
+              - friendlyarm,nanopi-m4
           - const: rockchip,rk3399
 
       - description: GeekBuying GeekBox
diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 1c7406111dfd..91a669378605 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -17,6 +17,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-kevin.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-scarlet-inx.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-scarlet-kd.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopc-t4.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-m4.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts
new file mode 100644
index 000000000000..8d3f0ba29c72
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * FriendlyElec NanoPi M4 board device tree source
+ *
+ * Copyright (c) 2018 FriendlyElec Computer Tech. Co., Ltd.
+ * (http://www.friendlyarm.com)
+ *
+ * Copyright (c) 2018 Collabora Ltd.
+ * Copyright (c) 2019 Arm Ltd.
+ */
+
+/dts-v1/;
+#include "rk3399-nanopi4.dtsi"
+
+/ {
+	model = "FriendlyElec NanoPi M4";
+	compatible = "friendlyarm,nanopi-m4", "rockchip,rk3399";
+};
-- 
2.20.1.dirty


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
