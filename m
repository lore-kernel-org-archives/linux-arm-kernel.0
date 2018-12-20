Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F12AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:30:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0568218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ednxPir5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRerkV01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0568218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=xvDpEXpK/+KlYLMoMKFs6G7qXazZE9TRGFGtQnv/Dog=; b=ednxPir5Xsz1ZDdwbkEvX9g17i
	EI+Dt2TKqYGBawf+mim0qAAOwXCixRTN4NV3y237mVzPC83Y5QNLlPsLTApIDOpj1RGwmGQ1utwob
	8ZVPbeEFQfgwax7b+tJhyjuIMzanGY8xNE880mQl45uyyYFtHPSpPUSSkYslDcUiGh6H+L2Zj/dwW
	khy5oLF5HGcxGas3ONPnO8lWNUmsNMOF8NmzFHgo7xvJ+rl9TEzla1I0aseUDUg85klsV9M3Z9HDZ
	vYbtnW1ZHwsQ8y+672gH098M2OYLkX6/0leyVH8IoL2WH/PpM9m7xHLX0CMoDJ0XsdaAkx+c+C/fq
	glSjeh4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZzL0-0007CV-77; Thu, 20 Dec 2018 14:30:10 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZzKe-0006Ez-OX
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 14:29:51 +0000
Received: by mail-wm1-x330.google.com with SMTP id m22so2423629wml.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 06:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vT1sWeVsPMNkJ3RO4LaZ23x0ML1tPQ7tsa15fK1zqgo=;
 b=oRerkV01GRSJi02w54DRo15/jjw6ped5LlNwe+W0w2guiQRUYMUCZT5QVmxzBBffDA
 oGDdj3vGWxbdvuPlU3YIOIwGUPGbe89GgkeNbwtUxgexIjUlB7iU3XidceP8SKn9NUAg
 vfN3BwD+EbMdy8alNvkXFIMN/vmI7cPzz19wTLDE/2eCKjl1jBxEcHD+ZYUOIAxbtHBM
 MMrMdfKXUcX7w/dehTHGR6RnJpV6hiv7m7n47oddRKQtIYRbkcOf++2NNggeAidWLQoW
 Kli+8Q37er6LvxAb/PbkA7jfpUZTJzbYVfIZPqjoDgXfx72OIAMyhlTsR0JFXQsD5+lv
 dZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vT1sWeVsPMNkJ3RO4LaZ23x0ML1tPQ7tsa15fK1zqgo=;
 b=hl/qjCnvQwBStoSh/j1nWwcfO2f3gz9JrAwltSHRmRoYaKDcZW53K73bALej9yIxw+
 EigW4UY/Bvu2JbG6Iy5sevPHiZ3JDSkLBEdXWpZ5nuOBUBtk3c468dbflkuDSjbhwV/a
 WpeDx0FV3I534VfMqmBw4NnGoFTMib6qJXZoEQodwFGWl/q/hx2Lur5lMHJ9P9KVV5z4
 n4ib5hynhG5b0Zouv9NI2hFbxe9yvqGGm/E4w5c5lChrOkHdicR42v9GFdcRyWOfOi70
 I4RS5UTE5wVrRwZWCMwCiGn/tfU6rPlb35I7CsBVoYPPox54RU0eNBtNu2mgy7H9HFs9
 zZnQ==
X-Gm-Message-State: AA+aEWaWBZovu9zAU+hsjLoyc9IoxyzhhS59xKC+jffNnVOkD6H3MI2q
 WJf+kOgnkIpZOpkXZMEjAxjrO9Cm0Ig=
X-Google-Smtp-Source: AFSGD/X97RglXuXW95FqZmMrivU7F35ZVvEk2SJr8pYUQhxQGTK8zt8DX9JezE/ZFKrAeElmJI7tSQ==
X-Received: by 2002:a1c:3905:: with SMTP id g5mr11387805wma.30.1545316176430; 
 Thu, 20 Dec 2018 06:29:36 -0800 (PST)
Received: from localhost (ip1f11b9d6.dynamic.kabel-deutschland.de.
 [31.17.185.214])
 by smtp.gmail.com with ESMTPSA id v19sm14429204wrd.46.2018.12.20.06.29.35
 (version=TLS1_2 cipher=AES128-SHA bits=128/128);
 Thu, 20 Dec 2018 06:29:35 -0800 (PST)
From: Oliver Graute <oliver.graute@gmail.com>
X-Google-Original-From: Oliver Graute <oliver2000@gmx.net>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] ARM: dts: Add imx6ul-var-dart-nand-wifi.dtb
Date: Thu, 20 Dec 2018 15:28:39 +0100
Message-Id: <1545316119-18459-3-git-send-email-oliver2000@gmx.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545316119-18459-1-git-send-email-oliver2000@gmx.net>
References: <1545316119-18459-1-git-send-email-oliver2000@gmx.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_062949_068388_7AB2326C 
X-CRM114-Status: GOOD (  15.90  )
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
Cc: s.hauer@pengutronix.de, Oliver Graute <oliver.graute@gmail.com>,
 linux-imx@nxp.com, kernel@pengutronix.de, fabio.estevam@nxp.com,
 shawnguo@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Oliver Graute <oliver.graute@gmail.com>

added imx6ul-var-dart-nand-wifi.dts
updated Makefile

Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
---
 arch/arm/boot/dts/Makefile                      | 1 +
 arch/arm/boot/dts/imx6ul-var-dart-nand-wifi.dts | 9 +++++++++
 2 files changed, 10 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-var-dart-nand-wifi.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 78551c4..9c0c77c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -564,6 +564,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-tx6ul-0010.dtb \
 	imx6ul-tx6ul-0011.dtb \
 	imx6ul-tx6ul-mainboard.dtb \
+	imx6ul-var-dart-nand-wifi.dts \
 	imx6ull-14x14-evk.dtb \
 	imx6ull-colibri-eval-v3.dtb \
 	imx6ull-colibri-wifi-eval-v3.dtb \
diff --git a/arch/arm/boot/dts/imx6ul-var-dart-nand-wifi.dts b/arch/arm/boot/dts/imx6ul-var-dart-nand-wifi.dts
new file mode 100644
index 0000000..3fa5985
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-var-dart-nand-wifi.dts
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: (GPL-2.0)
+/*
+ * Copyright (C) 2015-2016 Variscite Ltd. - http://www.variscite.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "imx6ul-var-dart.dtsi"
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
