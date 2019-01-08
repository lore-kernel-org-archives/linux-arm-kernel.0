Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A30C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:58:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E9C2146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rl8hFY8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E9C2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=VpFJ5khcGXmF+e6p1URlOsa4W0FBDnIeWdw5vLa4pyM=; b=Rl8hFY8RxW/NK3y4rC9541yLqL
	AQ599d/rOjChVsZmPx+zy2Xs+v4aXCemw2CUSXiImjEEV8+QY9FH0R7CnfjPz7utpn2r7aKUyiPJT
	TaQNG3c+uPo7cU/vdSi3AZZIR9IvbQJm1gPwSeW3rJWEYzS5gPgeaex6+NaO8vjOTdEaP25LaoY1+
	+Rlcp3td7DerdYercay8WtWe8EJhx09/nsvybvMYKzugIgP0s2tgllpMN985e3RSF/x+qEA0MVV+i
	5FJlqUFKTr4hhc46xDFxxooRaGm5zKA59oqYNrL1p+qjVGj7dpNJgsiCPxk7eWN/Hy2dKAXVPOPKy
	9eFSj+yA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggzNk-00042r-Mg; Tue, 08 Jan 2019 21:57:56 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggzNa-0003rC-Q1; Tue, 08 Jan 2019 21:57:51 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61C151596;
 Tue,  8 Jan 2019 13:57:46 -0800 (PST)
Received: from DESKTOP-VLO843J.lan (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DE3163F5AF;
 Tue,  8 Jan 2019 13:57:44 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: heiko@sntech.de
Subject: [PATCH 2/5] arm64: dts: rockchip: Add DT for NanoPi M4
Date: Tue,  8 Jan 2019 21:57:24 +0000
Message-Id: <324b75bbeef2552ddde62f4e1834ac908a45bebd.1546981251.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1546981251.git.robin.murphy@arm.com>
References: <cover.1546981251.git.robin.murphy@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_135747_258872_AC760E08 
X-CRM114-Status: GOOD (  16.75  )
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
Cc: linux-rockchip@lists.infradead.org, tomeu.vizoso@collabora.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
MIME-Version: 1.0
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

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 .../devicetree/bindings/arm/rockchip.yaml      |  5 +++++
 arch/arm64/boot/dts/rockchip/Makefile          |  1 +
 .../boot/dts/rockchip/rk3399-nanopi-m4.dts     | 18 ++++++++++++++++++
 3 files changed, 24 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index bcc60c492a12..b4756e0cb7d0 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -92,6 +92,11 @@ properties:
           - const: friendlyarm,nanopc-t4
           - const: rockchip,rk3399
 
+      - description: FriendlyElec NanoPi M4
+        items:
+          - const: friendlyarm,nanopi-m4
+          - const: rockchip,rk3399
+
       - description: GeekBuying GeekBox
         items:
           - const: geekbuying,geekbox
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
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
