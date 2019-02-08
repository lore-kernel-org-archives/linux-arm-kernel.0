Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4925FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:14:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18A6620863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jNPmiegr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="djCdGF8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A6620863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=gn9tYrcvRqxtQiTChCsF0KezCmrZW1NKV9OhlURVawA=; b=jNPmiegrrHRqXAnJ7+4IA+sv/J
	hXdTE+nXAN9oqZtTnT5Wjkz2WzLMEuQnKNpP1clQsLa7c4BRJBC3F/yL50AJyoZXcgOSj27oMUBeF
	37NXChGVzpxfh8Z1kosKme7tkBuAi8NyfJ+mwQtKaxDNoE77CvoalAOQy8YSWISCzK+Ugb73ZHKlb
	wIBy9TpUyGemklrEj0/a/jb7+7idtfTs7Zl2HAGfupEu/8NKa78yA1ehvIxJtQ/0+mjKKlikcxzhe
	O5sgPX1ROu8ZqT77GdZ3pt/fhG3UDqArzODTBC72gIghQOA3Rzs9toQWGD7hiyYTu8d1QGLWQdlWr
	ZwGyto/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs47L-0000fy-0j; Fri, 08 Feb 2019 11:14:47 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs46g-00084G-Mk
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 11:14:24 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 733AB25BED6;
 Fri,  8 Feb 2019 22:13:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1549624404; bh=15KWov1EF/G2e8s25EdjV5X7YCM773DVx8yUIYTIzOQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=djCdGF8wDOYgbUlhXBsGmBZ0YrAFycDg+ytpBfDDDU+isEKs1YgKBEltjtyzzr9HZ
 Pxg5yovb2MhAi8pnIaC8SKqpR29JjAvFq83LRO0l300iyWYRJ5vZry17q1ABhR60BG
 SqeUX2WY+6ueIdl6NB91W+TX/FtoRq/iouYt4Qo8=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id BDB36940171; Fri,  8 Feb 2019 12:13:22 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 02/12] arm64: dts: renesas: Add Si-Linux EK874 board support
Date: Fri,  8 Feb 2019 12:13:11 +0100
Message-Id: <4e8776657dd92854d063658b42440673edd995ae.1549623801.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1549623801.git.horms+renesas@verge.net.au>
References: <cover.1549623801.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_031407_368011_16BC608E 
X-CRM114-Status: GOOD (  13.65  )
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
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
 Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Biju Das <biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

The EK874 development kit from Silicon Linux is made of CAT874 (the main
board) and CAT875 (the sub board that goes on top of CAT874).

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/Makefile           |  2 +-
 arch/arm64/boot/dts/renesas/cat875.dtsi        | 10 ++++++++++
 arch/arm64/boot/dts/renesas/r8a774c0-ek874.dts | 14 ++++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/renesas/cat875.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774c0-ek874.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 11997d752e57..6cde526547e4 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_ARCH_R8A774C0) += r8a774c0-cat874.dtb
+dtb-$(CONFIG_ARCH_R8A774C0) += r8a774c0-cat874.dtb r8a774c0-ek874.dtb
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-salvator-x.dtb r8a7795-h3ulcb.dtb
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-h3ulcb-kf.dtb
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-salvator-xs.dtb
diff --git a/arch/arm64/boot/dts/renesas/cat875.dtsi b/arch/arm64/boot/dts/renesas/cat875.dtsi
new file mode 100644
index 000000000000..a41d0d81f649
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/cat875.dtsi
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the Silicon Linux sub board for CAT874 (CAT875)
+ *
+ * Copyright (C) 2019 Renesas Electronics Corp.
+ */
+
+/ {
+	model = "Silicon Linux sub board for CAT874 (CAT875)";
+};
diff --git a/arch/arm64/boot/dts/renesas/r8a774c0-ek874.dts b/arch/arm64/boot/dts/renesas/r8a774c0-ek874.dts
new file mode 100644
index 000000000000..e7b6619ab224
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a774c0-ek874.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the Silicon Linux RZ/G2E evaluation kit (EK874)
+ *
+ * Copyright (C) 2019 Renesas Electronics Corp.
+ */
+
+#include "r8a774c0-cat874.dts"
+#include "cat875.dtsi"
+
+/ {
+	model = "Silicon Linux RZ/G2E evaluation kit EK874 (CAT874 + CAT875)";
+	compatible = "si-linux,cat875", "si-linux,cat874", "renesas,r8a774c0";
+};
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
