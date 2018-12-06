Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10A4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:06:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7267C21479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cSI0EGJ/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="O3MteB6T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7267C21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=evFtHW+SKhOGRHflQuwZUzLOuAKiqgAUuGIu2uy2kmg=; b=cSI0EGJ/x4xWbdG95Ua20Bs5Rf
	7gGunvUpiuO+IiKHh6U2Z86FEv7l8jv3J9+3ZGHgGrWBb72MfqCzxuuoLz1/NelR5UBSQFHmqs4QE
	tXmB3XPYQl/s5/eXpWB5jWxoYkmwaAoyhVUbUoSXN4MNXrm5sbv4xGqQHw5lWRQQmUCNPU5c6xFef
	S/v6/7H6c61k/ZbEqPCsgdwSPsiMaHpJYadAvs7VWczxFZHPkKbkxlyU6CLtgOiwe6LoBfxRqN42I
	l1b5EnclJAnnnkEM3twC70SG6tzcXi1cqkIhzF5rSWJAL5EPdf1nQaH7QEwE4+2k1e9PANLqrTLbF
	y0k4AvzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1mk-0000nI-Ni; Thu, 06 Dec 2018 22:06:18 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1mD-0004aB-N3
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:06:15 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 0EF1525BEFE;
 Fri,  7 Dec 2018 08:58:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133515; bh=Lq7QkUtK8hXFUDpyjkL/5YOa7aYJc5D77mr02izromk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=O3MteB6TuVTmARWzAma5lDgvR745t1A1A3aI21GUHYSSw9puBjeTbeKMi6pJY6HFa
 1oJSfvx8LhOu1Xa74IjdMMJ4zDOD1qPYVfIe0xxm5fJm0w83qaOx83mQGtyh9eu1kQ
 veg8j8Mj5ZyO0GZeAOF4GdhkAqnx+ZkUXBTBkILw=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 8A4F4E232B3; Thu,  6 Dec 2018 13:58:31 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 28/34] ARM: dts: r8a7744-iwg20d-q7-dbcm-ca: Add device tree
 for camera DB
Date: Thu,  6 Dec 2018 13:58:23 -0800
Message-Id: <7fbbfe07b588cd81c1046a1846345a5cf614589a.1544125558.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1544125558.git.horms+renesas@verge.net.au>
References: <cover.1544125558.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_140546_481443_017074A7 
X-CRM114-Status: GOOD (  13.43  )
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
Cc: Simon Horman <horms+renesas@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Biju Das <biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

This patch adds support for the camera daughter board which is
connected to iWave's RZ/G1N Qseven carrier board.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile                      |  1 +
 arch/arm/boot/dts/r8a7744-iwg20d-q7-dbcm-ca.dts | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7744-iwg20d-q7-dbcm-ca.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index aba5a25b7eac..9cf6fdfd1f3a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -830,6 +830,7 @@ dtb-$(CONFIG_ARCH_RENESAS) += \
 	r8a7743-iwg20d-q7-dbcm-ca.dtb \
 	r8a7743-sk-rzg1m.dtb \
 	r8a7744-iwg20d-q7.dtb \
+	r8a7744-iwg20d-q7-dbcm-ca.dtb \
 	r8a7745-iwg22d-sodimm.dtb \
 	r8a7745-iwg22d-sodimm-dbhd-ca.dtb \
 	r8a7745-sk-rzg1e.dtb \
diff --git a/arch/arm/boot/dts/r8a7744-iwg20d-q7-dbcm-ca.dts b/arch/arm/boot/dts/r8a7744-iwg20d-q7-dbcm-ca.dts
new file mode 100644
index 000000000000..3e58c2e92e03
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7744-iwg20d-q7-dbcm-ca.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the iWave Systems RZ/G1N Qseven board development
+ * platform with camera daughter board
+ *
+ * Copyright (C) 2018 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r8a7744-iwg20m.dtsi"
+#include "iwg20d-q7-common.dtsi"
+#include "iwg20d-q7-dbcm-ca.dtsi"
+
+/ {
+	model = "iWave Systems RZ/G1N Qseven development platform with camera add-on";
+	compatible = "iwave,g20d", "iwave,g20m", "renesas,r8a7744";
+};
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
