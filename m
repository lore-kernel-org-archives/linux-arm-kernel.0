Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A2DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:48:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D61B620823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JJuSj4pQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GAGkl1aM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61B620823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FtQzo+8KxFGcbYWvprNfB6D9gS34pd9MmdEZSYFIjvQ=; b=JJuSj4pQ0vU0/Z
	KVIBOzGZklL+CKDyU3WahccMw1Fh8tfVCQkwTx4MXRVfVAe4pTB9p6OgUp43xdy9rX047KaAX0rjF
	kSuL8fsKpnBKmCRfV/5CstxW+SVbQBPn63C5lJnRbSfYp/sQ3Y5A+iNILXSzXid8QJ7p2Cvg/4owq
	xCynxUUMOcdEN/s6wuIxL7zHWuX/EsRZDK3kEe++bFvr8FyRJkqxOb7TV3tJexGicwHnn0/yl/kEZ
	+6vIl9k54ZVq1IG+f390yu+zN4lqB4emXJQi1TBOOJT4CbK7qkibkOsEwlsbmAqaGbwbvNhqirPhK
	D1jekyEBrfOb1HWT4aPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqa4-00089C-P7; Thu, 21 Feb 2019 15:48:12 +0000
Received: from mail-lj1-f195.google.com ([209.85.208.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqXo-0005Xn-EB
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:46:18 +0000
Received: by mail-lj1-f195.google.com with SMTP id j19so23605500ljg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t461vk7LadHLkgQ8qPP8Op2blKaDYcS4Yfr9x5uG6KY=;
 b=GAGkl1aMOScq2DuEcGSEkQ+8Kircrmkucg/OqKXEWz0r+TZupvEMg/xT1r3HvUq2aa
 wJ9c3b+1WIzp9mtbgNbKuuWlAqgGyllewA54i65E9tH0jWTsiNs3MNIfzimHpdUEYCth
 CJLHTBQ4BQxNhjdv4oPMr7CL/V7AmJdSgKnEYDJdKWIyMCgEMD6v5JaxC7/l6WdfZHEP
 uaBEQJEj5To2GPKwLmNmhb4YIrrolWrzb+03ADiTLHhatra49v0G0nre5ZzmSyK0ePZH
 p8qbhjY+qiVfNKm2uRkZkJ1SU+85mfFQF2SqD3rJZUxB+L7nQAqFylXxrjtrqA20umwZ
 PL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t461vk7LadHLkgQ8qPP8Op2blKaDYcS4Yfr9x5uG6KY=;
 b=trPblBNpoS4LFuAKVFWsP5OJFicV/IEjzMY5XL542jKIEdjEwCBIGyoI0OsYxmhhXa
 ieqESGPgNEUDC2U54w5gffz3vIEet868huPNnw7TOvuO4drI/OWWnBxhhXMzIUFHYscX
 40HRQnU6sQiRVWOUcM4i7ALPGNuggVJkVyQnw0nQDx5Kw3m00LW4Il/dD2T8i+Vb/oiM
 oDjYgmQP2jzG/OiHNMsqmDvsTVnp9RSC517fe/Rcwxs11EFEZJP2R26/7beOreTTO9BH
 TwQg/Y3UcvYoJTfVqiSqMXyH4e2nlLCxQZcCFVb9OZSyGnCevsSsuhzM1p2Cv6Z3jRgB
 Q3Eg==
X-Gm-Message-State: AHQUAuYZe7dZX3lKBOESKSmjmmvXZRUg1aMZNc45JdD6O0PBKy8vblAm
 /jEW5NWbSX8vCCsoPzB6WzoVNVQ1Ces=
X-Google-Smtp-Source: AHgI3IbjEze7UwScQx1ENdeOPu0eMQhu16yHr4kkZ7ebaFwyLI7s1AzsjqG8bxgiqKKR2PrFARCzoQ==
X-Received: by 2002:a2e:850a:: with SMTP id j10mr20839401lji.102.1550763949656; 
 Thu, 21 Feb 2019 07:45:49 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.45.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:45:48 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 16/30 v2] ARM: ixp4xx: Add device tree boot support
Date: Thu, 21 Feb 2019 16:44:44 +0100
Message-Id: <20190221154458.23763-17-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154458.23763-1-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_074552_979802_2A9D26E0 
X-CRM114-Status: GOOD (  22.10  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>
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
ChangeLog v1->v2:
- Remap the external bus registers since the feature
  checks for different hardware using
  ixp4xx_read_feature_bits() to determine the system
  configuration needs this static map. We can eventually
  move this to syscon but only if we first move all
  boards to device tree.
---
 arch/arm/mach-ixp4xx/Kconfig             | 14 ++++++
 arch/arm/mach-ixp4xx/Makefile            |  3 ++
 arch/arm/mach-ixp4xx/ixp4xx-of.c         | 60 ++++++++++++++++++++++++
 arch/arm/mach-ixp4xx/ixp4xx_npe.c        |  5 ++
 arch/arm/mach-ixp4xx/ixp4xx_qmgr.c       |  5 ++
 drivers/net/ethernet/xscale/ixp4xx_eth.c | 10 ++++
 drivers/watchdog/ixp4xx_wdt.c            |  9 ++++
 7 files changed, 106 insertions(+)
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
index 000000000000..7449b8319c8a
--- /dev/null
+++ b/arch/arm/mach-ixp4xx/ixp4xx-of.c
@@ -0,0 +1,60 @@
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
+#include <mach/ixp4xx-regs.h>
+
+static struct map_desc ixp4xx_of_io_desc[] __initdata = {
+	/*
+	 * This is needed for runtime system configuration checks,
+	 * such as reading if hardware so-and-so is present. This
+	 * could eventually be converted into a syscon once all boards
+	 * are converted to device tree.
+	 */
+	{
+		.virtual = IXP4XX_EXP_CFG_BASE_VIRT,
+		.pfn = __phys_to_pfn(IXP4XX_EXP_CFG_BASE_PHYS),
+		.length = SZ_4K,
+		.type = MT_DEVICE,
+	},
+#ifdef CONFIG_DEBUG_UART_8250
+	/* This is needed for LL-debug/earlyprintk/debug-macro.S */
+	{
+		.virtual = CONFIG_DEBUG_UART_VIRT,
+		.pfn = __phys_to_pfn(CONFIG_DEBUG_UART_PHYS),
+		.length = SZ_4K,
+		.type = MT_DEVICE,
+	},
+#endif
+};
+
+static void __init ixp4xx_of_map_io(void)
+{
+	iotable_init(ixp4xx_of_io_desc, ARRAY_SIZE(ixp4xx_of_io_desc));
+}
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
