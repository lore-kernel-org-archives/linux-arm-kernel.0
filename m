Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC8FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:44:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0463B2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CJI3c0vM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b71CLaUy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GtE8m/zJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0463B2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nMPvwmNaAJv1RlJ4tDrJXGOQD2nv6GCaeD870qqDZj4=; b=CJI3c0vM2lbnkE
	cyXJleQojsol+IhfDFSGKeE+fwq3V+KxCYLFoHXdBndOgzgNOcAPnLDO4m06yL9ST9txmWuQrd2M2
	h1Y+6S79tN4k+DlmqLCssTKdzkaKVmu+jZcmGgZKZV8uGEfVJeY1a6fUyQtYBLqCt13XENw+KiCu7
	7UdxsRukqXUwXjummqagse6+wcqF50zN4wCX/PvP//9XFN/9FzPxgU3Ig2s7sGq7mzAFjCZ2hSgsc
	8X+FOECGlyldsXLo7zdg0fz4hGGimWoYvHWgS5p7t8Zac2sroPnCTCjGdtlzDVKEZhDOnfMTGLd4d
	Wfrcn/X+a0sdYcEt/CDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqPZ9-0001s4-Ck; Sun, 03 Feb 2019 21:44:39 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqPXa-0000KL-HV
 for linux-arm-kernel@bombadil.infradead.org; Sun, 03 Feb 2019 21:43:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Zx/5JxMVusTMHFnhLbV8UPjk17nKNBSljoA6c483QbE=; b=b71CLaUyIOA6hsXnGbOTUlXL4u
 F6fdrYgFAmdaO09QXCxVJ0kbZOLWKCF0YuhwFqxvw5kviI9sYe3Zar83wMGrtyO9noP25CNSexLXi
 FHko1kF1AFWF1pLQ9/bvslQ3OY+DktO+C10A8REuwgMbgP45wYcr4SgNqoAqPVCuMYp/2ah0hRNIl
 ipmIav1vHBAdXACkRAt0VhzVpvGJS/5C2uDjLlpdzvYWMOTCE1etASWRspERhzi2qBib0fP+39Lxe
 qx9i5rLjxuZz4Ji/KM8RwEFjvbgyQt9n7ghUG24jziUgIhZeBeoIwDYQjQiLZWfhCr77c6AaYitqi
 +5l7hXaA==;
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqPXX-0001yM-1I
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 21:43:01 +0000
Received: by mail-lf1-x144.google.com with SMTP id z26so3156796lfj.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 13:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Zx/5JxMVusTMHFnhLbV8UPjk17nKNBSljoA6c483QbE=;
 b=GtE8m/zJPBYqDbyQ6xxa7TJ3hsPqf9Arbp3S5rRRsHaL4+LxJucySgxiXUlapOkRXy
 hg1FHFp4pndHUtcduDVeOIzQxzuBwiwvRc0q1uzSdzWJRFxKuzynRmEyfye8jzzY0dCr
 wR8igw7Zh04bLs2e28KDIFCufdllSYIjcpw5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Zx/5JxMVusTMHFnhLbV8UPjk17nKNBSljoA6c483QbE=;
 b=QJWlzFoVDWvb12GNra+X+i6RA2UI2h/HEtzs3uuOvthCQf4IMfevE7av3+YEZjXb3g
 u1qOo277Jv36O9Qqzzd59ag13cdV/wKHYnvcZHf5lOTvBlQI49DbboX3/tNsbiyk1gpM
 y3lKPax+VFtUhGqp7nNeQXpxXleswpiRQKEER8J4ZOhKWzl1i9B9X2NSTIOU6YfxDw/m
 GPeAKAFMsNjLFg6nxNPKNNzJvLwB38d+GSVrJJyL0ffC0A9OYwlwVlZHsnSgF+zjEyFl
 syuBLUesZlDTovqbYXgu8Ldpi7ZabWjaIzf75oPGojz+dj7Q0XNrTq2yq/wmpkCJ4zY4
 oKmw==
X-Gm-Message-State: AHQUAuYDCaySog+Db+TWTwXSEQnC1Iwu7iFS0h/C5jyd0Xi6jp8nu61Q
 j4eQ432oC9DPGGK5W5dj7HIW+Hq1JkA=
X-Google-Smtp-Source: AHgI3IZZhBn61wDmJWEHSk8LtGfvhjU3UR/V+5IftNV/PcnykGOVP3igq48v0VDDYkz9KH5YdDphfQ==
X-Received: by 2002:a19:9bc2:: with SMTP id d185mr2045768lfe.21.1549230174671; 
 Sun, 03 Feb 2019 13:42:54 -0800 (PST)
Received: from linux.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id 85-v6sm2456868lja.16.2019.02.03.13.42.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 03 Feb 2019 13:42:53 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 16/17 v1] ARM: ixp4xx: Add device tree boot support
Date: Sun,  3 Feb 2019 22:42:04 +0100
Message-Id: <20190203214205.13594-17-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203214205.13594-1-linus.walleij@linaro.org>
References: <20190203214205.13594-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_214259_101125_9A6944FE 
X-CRM114-Status: GOOD (  27.79  )
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
Cc: Olof Johansson <olof@lixom.net>, Tim Harvey <tharvey@gateworks.com>,
 Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds a minimal support for booting IXP4xx systems
from device tree.

We have to add hacks to the QMGR, NPE and notably also
ethernet and watchdog drivers so that they don't crash
the platform: these drivers are unconditionally starting
to grab regions of statically remapped IO space with no
concern of the device model or other platforms.

We will go in and properly fix these drivers as we go
along but for now this hack gets us to a place where we
can start working on proper device tree support for these
platforms.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ixp4xx/Kconfig             | 14 +++++++
 arch/arm/mach-ixp4xx/Makefile            |  3 ++
 arch/arm/mach-ixp4xx/ixp4xx-of.c         | 49 ++++++++++++++++++++++++
 arch/arm/mach-ixp4xx/ixp4xx_npe.c        |  5 +++
 arch/arm/mach-ixp4xx/ixp4xx_qmgr.c       |  5 +++
 drivers/net/ethernet/xscale/ixp4xx_eth.c | 10 +++++
 drivers/watchdog/ixp4xx_wdt.c            |  9 +++++
 7 files changed, 95 insertions(+)
 create mode 100644 arch/arm/mach-ixp4xx/ixp4xx-of.c

diff --git a/arch/arm/mach-ixp4xx/Kconfig b/arch/arm/mach-ixp4xx/Kconfig
index fea008123eb1..0973270f4863 100644
--- a/arch/arm/mach-ixp4xx/Kconfig
+++ b/arch/arm/mach-ixp4xx/Kconfig
@@ -4,6 +4,20 @@ menu "Intel IXP4xx Implementation Options"
 
 comment "IXP4xx Platforms"
 
+config MACH_IXP4XX_OF
+	bool
+	prompt "Devce Tree IXP4xx boards"
+	default y
+	select ARM_APPENDED_DTB # Old Redboot bootloaders deployed
+	select I2C
+	select I2C_IOP3XX
+	select PCI
+	select SERIAL_OF_PLATFORM
+	select TIMER_OF
+	select USE_OF
+	help
+	  Say 'Y' here to support Device Tree-based IXP4xx platforms.
+
 config MACH_NSLU2
 	bool
 	prompt "Linksys NSLU2"
diff --git a/arch/arm/mach-ixp4xx/Makefile b/arch/arm/mach-ixp4xx/Makefile
index f09994500a34..5f63b3012826 100644
--- a/arch/arm/mach-ixp4xx/Makefile
+++ b/arch/arm/mach-ixp4xx/Makefile
@@ -6,6 +6,9 @@
 obj-pci-y	:=
 obj-pci-n	:=
 
+# Device tree platform
+obj-pci-$(CONFIG_MACH_IXP4XX_OF)	+= ixp4xx-of.o
+
 obj-pci-$(CONFIG_ARCH_IXDP4XX)		+= ixdp425-pci.o
 obj-pci-$(CONFIG_MACH_AVILA)		+= avila-pci.o
 obj-pci-$(CONFIG_MACH_IXDPG425)		+= ixdpg425-pci.o
diff --git a/arch/arm/mach-ixp4xx/ixp4xx-of.c b/arch/arm/mach-ixp4xx/ixp4xx-of.c
new file mode 100644
index 000000000000..17540fb9b5e7
--- /dev/null
+++ b/arch/arm/mach-ixp4xx/ixp4xx-of.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IXP4xx Device Tree boot support
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <mach/hardware.h>
+
+#ifdef CONFIG_DEBUG_UART_8250
+/* This is needed for LL-debug/earlyprintk/debug-macro.S */
+static struct map_desc ixp4xx_of_io_desc[] __initdata = {
+	{
+		.virtual = CONFIG_DEBUG_UART_VIRT,
+		.pfn = __phys_to_pfn(CONFIG_DEBUG_UART_PHYS),
+		.length = SZ_4K,
+		.type = MT_DEVICE,
+	},
+};
+
+static void __init ixp4xx_of_map_io(void)
+{
+	iotable_init(ixp4xx_of_io_desc, ARRAY_SIZE(ixp4xx_of_io_desc));
+}
+#else
+#define ixp4xx_of_map_io NULL
+#endif
+
+/*
+ * We handle 4 differen SoC families. These compatible strings are enough
+ * to provide the core so that different boards can add their more detailed
+ * specifics.
+ */
+static const char *ixp4xx_of_board_compat[] = {
+	"intel,ixp42x",
+	"intel,ixp43x",
+	"intel,ixp45x",
+	"intel,ixp46x",
+	NULL,
+};
+
+DT_MACHINE_START(IXP4XX_DT, "IXP4xx (Device Tree)")
+	.map_io		= ixp4xx_of_map_io,
+	.dt_compat	= ixp4xx_of_board_compat,
+MACHINE_END
diff --git a/arch/arm/mach-ixp4xx/ixp4xx_npe.c b/arch/arm/mach-ixp4xx/ixp4xx_npe.c
index d4eb09a62863..e0ce22cd9bfc 100644
--- a/arch/arm/mach-ixp4xx/ixp4xx_npe.c
+++ b/arch/arm/mach-ixp4xx/ixp4xx_npe.c
@@ -20,6 +20,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <mach/npe.h>
 
 #define DEBUG_MSG			0
@@ -688,6 +689,10 @@ static int __init npe_init_module(void)
 
 	int i, found = 0;
 
+	/* This driver does not work with device tree */
+	if (of_have_populated_dt())
+		return -ENODEV;
+
 	for (i = 0; i < NPE_COUNT; i++) {
 		struct npe *npe = &npe_tab[i];
 		if (!(ixp4xx_read_feature_bits() &
diff --git a/arch/arm/mach-ixp4xx/ixp4xx_qmgr.c b/arch/arm/mach-ixp4xx/ixp4xx_qmgr.c
index 4c7c960e1b4c..2665347a2c6f 100644
--- a/arch/arm/mach-ixp4xx/ixp4xx_qmgr.c
+++ b/arch/arm/mach-ixp4xx/ixp4xx_qmgr.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <mach/qmgr.h>
 
 #include "irqs.h"
@@ -289,6 +290,10 @@ static int qmgr_init(void)
 	int i, err;
 	irq_handler_t handler1, handler2;
 
+	/* This driver does not work with device tree */
+	if (of_have_populated_dt())
+		return -ENODEV;
+
 	mem_res = request_mem_region(IXP4XX_QMGR_BASE_PHYS,
 				     IXP4XX_QMGR_REGION_SIZE,
 				     "IXP4xx Queue Manager");
diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
index aee55c03def0..7ad3c3b56a77 100644
--- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
+++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
@@ -31,6 +31,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/net_tstamp.h>
+#include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
 #include <linux/ptp_classify.h>
@@ -1497,6 +1498,15 @@ static struct platform_driver ixp4xx_eth_driver = {
 static int __init eth_init_module(void)
 {
 	int err;
+
+	/*
+	 * FIXME: we bail out on device tree boot but this really needs
+	 * to be fixed in a nicer way: this registers the MDIO bus before
+	 * even matching the driver infrastructure, we should only probe
+	 * detected hardware.
+	 */
+	if (of_have_populated_dt())
+		return -ENODEV;
 	if ((err = ixp4xx_mdio_register()))
 		return err;
 	return platform_driver_register(&ixp4xx_eth_driver);
diff --git a/drivers/watchdog/ixp4xx_wdt.c b/drivers/watchdog/ixp4xx_wdt.c
index f20cc53ff719..a80449bb36f0 100644
--- a/drivers/watchdog/ixp4xx_wdt.c
+++ b/drivers/watchdog/ixp4xx_wdt.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
+#include <linux/of.h>
 #include <linux/watchdog.h>
 #include <linux/init.h>
 #include <linux/bitops.h>
@@ -176,6 +177,14 @@ static int __init ixp4xx_wdt_init(void)
 {
 	int ret;
 
+	/*
+	 * FIXME: we bail out on device tree boot but this really needs
+	 * to be fixed in a nicer way: this registers the MDIO bus before
+	 * even matching the driver infrastructure, we should only probe
+	 * detected hardware.
+	 */
+	if (of_have_populated_dt())
+		return -ENODEV;
 	if (!(read_cpuid_id() & 0xf) && !cpu_is_ixp46x()) {
 		pr_err("Rev. A0 IXP42x CPU detected - watchdog disabled\n");
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
