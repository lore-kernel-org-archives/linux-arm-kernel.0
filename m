Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7018CC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:34:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1C520645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nCAP2W85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1C520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BBP1FADATfc8vklaHY7Z2v7VmYFO2CVPZLARYEVdEq0=; b=nCAP2W85KB+ctR
	ubx9vJ3/KVUFoFbAs7ItL4s07aSb+Ap1RKK9DJltrJrXF1AdgsEEelELDSaCJ0nZ91d4ZvpwARDCU
	o1tFuP/22iem7+NwHyfHp+T2y9LHO8JI4HvKO1ArvMBKQUmAh6ZQ1LKzZG8VYQRrC0f7kLHQRnzk/
	bQIlpFCcyjRH8K/d91wsND6QU5+CpSYPekesZRJmoQghGBCxxbNtDhxBgH4lxzeaTIG2r0Am/7Wh6
	VaVy0qxGGKDT+dvf4limyxb10rb0GxXwVIifa2yvx6fgEZGF21Vx5tWuaZz66CTtfB2nR/NBqn4uy
	bsIf+mKDrLgv+98B2t9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQCb-0001ez-3j; Thu, 13 Dec 2018 12:34:53 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQCI-0001G7-95
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 12:34:36 +0000
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7]
 helo=dude.pengutronix.de.)
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <p.zabel@pengutronix.de>)
 id 1gXQBv-0005iT-FJ; Thu, 13 Dec 2018 13:34:11 +0100
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Dinh Nguyen <dinguyen@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 1/2] reset: sunxi: declare sun6i_reset_init in a header file
Date: Thu, 13 Dec 2018 13:33:57 +0100
Message-Id: <20181213123358.24391-2-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213123358.24391-1-p.zabel@pengutronix.de>
References: <20181213123358.24391-1-p.zabel@pengutronix.de>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_043434_477036_620C0446 
X-CRM114-Status: GOOD (  13.73  )
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
Cc: Olof Johansson <olof@lixom.net>, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Avoid declaring extern functions in c files. To make sure function
definition and usage don't get out of sync, declare sun6i_reset_init
in a common header.

Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/mach-sunxi/sunxi.c | 2 +-
 drivers/reset/reset-sunxi.c | 1 +
 include/linux/reset/sunxi.h | 7 +++++++
 3 files changed, 9 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/reset/sunxi.h

diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index de4b0e932f22..88680e80c166 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -14,6 +14,7 @@
 #include <linux/clocksource.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/reset/sunxi.h>
 
 #include <asm/mach/arch.h>
 #include <asm/secure_cntvoff.h>
@@ -37,7 +38,6 @@ static const char * const sun6i_board_dt_compat[] = {
 	NULL,
 };
 
-extern void __init sun6i_reset_init(void);
 static void __init sun6i_timer_init(void)
 {
 	of_clk_init(NULL);
diff --git a/drivers/reset/reset-sunxi.c b/drivers/reset/reset-sunxi.c
index db9a1a75523f..b06d724d8f21 100644
--- a/drivers/reset/reset-sunxi.c
+++ b/drivers/reset/reset-sunxi.c
@@ -18,6 +18,7 @@
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
+#include <linux/reset/sunxi.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
diff --git a/include/linux/reset/sunxi.h b/include/linux/reset/sunxi.h
new file mode 100644
index 000000000000..1ad7fffb413e
--- /dev/null
+++ b/include/linux/reset/sunxi.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_RESET_SUNXI_H__
+#define __LINUX_RESET_SUNXI_H__
+
+void __init sun6i_reset_init(void);
+
+#endif /* __LINUX_RESET_SUNXI_H__ */
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
