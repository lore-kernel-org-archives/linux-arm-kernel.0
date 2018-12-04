Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44435C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:58:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A02A20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jPdYNwTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A02A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=bkEO/C3Hy0bCNZcPeiMIFdOsE5MxaV5szS4niI/uExo=; b=jPd
	YNwTulKTR9uZontpDgENSu0UMVM7lfGW9gn7ZrYfnVuM1TeVatZNLbbXNfXLP6Rb+kl5JRjzCqdQf
	EOcX9HO5RuUULOnOGAi5fqmDkVd7hvRSuzZNBfls2/evG29JheqRE0QLtONqyRBEyQZzZ6dlvCsIr
	IN7dFjMtRBOpvBp70W3xeDyEtcTcnHwGJhXgwE1BqG+k/0/D/k/7KSQpEBt+C8Va9WpcUi6I2NnrM
	SmydN8lPXVfdDm8Aq/YnmXPGPw0IQuJDTf6VEgSF+behP0WStb8Vfeuiw0AA3uQKticROAc7tTYiS
	4BE0GX1kJNNY8v0HJdQhagJaS4VejoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUEy5-0007gb-Pw; Tue, 04 Dec 2018 17:58:45 +0000
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUEy1-0007bf-Vb
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 17:58:43 +0000
Received: from localhost.localdomain (85-76-96-200-nat.elisa-mobile.fi
 [85.76.96.200])
 by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 5012CB0059;
 Tue,  4 Dec 2018 19:58:30 +0200 (EET)
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org
Subject: [PATCH] ARM: OMAP1: add MMC configuration for Palm Tungsten E
Date: Tue,  4 Dec 2018 19:58:12 +0200
Message-Id: <20181204175812.2678-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_095842_283172_3C058DA0 
X-CRM114-Status: UNSURE (   9.14  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Aaro Koskinen <aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add initial MMC configuration for Palm Tungsten E to allow using a proper
rootfs on the device. This still assumes the bootloader enabling the MMC,
and that the card is always present and writeable.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/board-palmte.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 2dc5deb19803..d4d8a32e57eb 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -43,6 +43,7 @@
 #include <mach/hardware.h>
 #include <mach/usb.h>
 
+#include "mmc.h"
 #include "common.h"
 
 #define PALMTE_USBDETECT_GPIO	0
@@ -208,6 +209,33 @@ static void __init palmte_misc_gpio_setup(void)
 	gpio_direction_input(PALMTE_USB_OR_DC_GPIO);
 }
 
+#if IS_ENABLED(CONFIG_MMC_OMAP)
+
+static struct omap_mmc_platform_data _palmte_mmc_config = {
+	.nr_slots			= 1,
+	.slots[0]			= {
+		.ocr_mask		= MMC_VDD_32_33|MMC_VDD_33_34,
+		.name			= "mmcblk",
+	},
+};
+
+static struct omap_mmc_platform_data *palmte_mmc_config[OMAP15XX_NR_MMC] = {
+	[0] = &_palmte_mmc_config,
+};
+
+static void palmte_mmc_init(void)
+{
+	omap1_init_mmc(palmte_mmc_config, OMAP15XX_NR_MMC);
+}
+
+#else /* CONFIG_MMC_OMAP */
+
+static void palmte_mmc_init(void)
+{
+}
+
+#endif /* CONFIG_MMC_OMAP */
+
 static void __init omap_palmte_init(void)
 {
 	/* mux pins for uarts */
@@ -228,6 +256,7 @@ static void __init omap_palmte_init(void)
 	omap_register_i2c_bus(1, 100, NULL, 0);
 
 	omapfb_set_lcd_config(&palmte_lcd_config);
+	palmte_mmc_init();
 }
 
 MACHINE_START(OMAP_PALMTE, "OMAP310 based Palm Tungsten E")
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
