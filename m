Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE1AC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:35:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4EFB206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pJjLDYKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4EFB206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ow27DbfcfOvzPoS7T/MEQG5ePcVi8zy4YlZi8yitOYQ=; b=pJjLDYKb7PNkyV
	3py7NBTwwilpk2mSikki+oX4RW6+6x0w9sIxWdgfX01cju8HnzdUpBm1U09Wsq9YGFCVTyRxR1zxz
	FeIkReXivkvGHw5A9sunEs1y9ImzIEz42Wc4jzcHnEyiCWLy6N7KOsfIFYLoiHYxN5jCaDf1k7jZk
	Hc+IJciSyzn6NGNCdYbsxKXLw/gNMk4WuAq0qYIHWRmGtbyho4jfd1n0tSOwsTRP9K0gao4sCm18r
	AlxbnrWXhoU+FBZcxhag9MEYQKNY1Kt/yhAXHHMdAIiPVs9W1q/e5ycqxNHBHpppknJQ6nkIbFG9W
	Fiq1vW8jvT5IOqo3bLlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXoZ8-0002G6-Nw; Fri, 14 Dec 2018 14:35:46 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXoY3-0008KH-8R
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 14:34:41 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wBEEVKUY030843; Fri, 14 Dec 2018 15:34:25 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2p85qkm06g-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Fri, 14 Dec 2018 15:34:25 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7668E34;
 Fri, 14 Dec 2018 14:34:24 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 58BC352EC;
 Fri, 14 Dec 2018 14:34:24 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 14 Dec
 2018 15:34:23 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Fri, 14 Dec 2018 15:34:23 +0100
From: Pascal PAILLET-LME <p.paillet@st.com>
To: "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com"
 <lgirdwood@gmail.com>
Subject: [PATCH v8 6/6] watchdog: stpmic1: add stpmic1 watchdog driver
Thread-Topic: [PATCH v8 6/6] watchdog: stpmic1: add stpmic1 watchdog driver
Thread-Index: AQHUk7obvp400PSW2EGDm5K1/VUjMg==
Date: Fri, 14 Dec 2018 14:34:23 +0000
Message-ID: <1544798057-1499-7-git-send-email-p.paillet@st.com>
References: <1544798057-1499-1-git-send-email-p.paillet@st.com>
In-Reply-To: <1544798057-1499-1-git-send-email-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-14_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_063439_762255_80DBDE06 
X-CRM114-Status: GOOD (  15.78  )
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
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Pascal PAILLET-LME <p.paillet@st.com>,
 Alexandre TORGUE <alexandre.torgue@st.com>,
 "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The stpmic1 PMIC embeds a watchdog which is disabled by default. As soon
as the watchdog is started, it must be refreshed periodically otherwise
the PMIC goes off.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
changes in v8: nothing

 drivers/watchdog/Kconfig       |  12 ++++
 drivers/watchdog/Makefile      |   1 +
 drivers/watchdog/stpmic1_wdt.c | 139 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+)
 create mode 100644 drivers/watchdog/stpmic1_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 2d64333..cc5155b 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -817,6 +817,18 @@ config STM32_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called stm32_iwdg.
 
+config STPMIC1_WATCHDOG
+	tristate "STPMIC1 PMIC watchdog support"
+	depends on MFD_STPMIC1
+	select WATCHDOG_CORE
+	help
+	  Say Y here to include watchdog support embedded into STPMIC1 PMIC.
+	  If the watchdog timer expires, stpmic1 will shut down all its power
+	  supplies.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called spmic1_wdt.
+
 config UNIPHIER_WATCHDOG
 	tristate "UniPhier watchdog support"
 	depends on ARCH_UNIPHIER || COMPILE_TEST
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index f69cdff..bdc072c 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -218,3 +218,4 @@ obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
 obj-$(CONFIG_MENF21BMC_WATCHDOG) += menf21bmc_wdt.o
 obj-$(CONFIG_MENZ069_WATCHDOG) += menz69_wdt.o
 obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
+obj-$(CONFIG_STPMIC1_WATCHDOG) += stpmic1_wdt.o
diff --git a/drivers/watchdog/stpmic1_wdt.c b/drivers/watchdog/stpmic1_wdt.c
new file mode 100644
index 0000000..ad431d8
--- /dev/null
+++ b/drivers/watchdog/stpmic1_wdt.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) STMicroelectronics 2018
+// Author: Pascal Paillet <p.paillet@st.com> for STMicroelectronics.
+
+#include <linux/kernel.h>
+#include <linux/mfd/stpmic1.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/watchdog.h>
+
+/* WATCHDOG CONTROL REGISTER bit */
+#define WDT_START		BIT(0)
+#define WDT_PING		BIT(1)
+#define WDT_START_MASK		BIT(0)
+#define WDT_PING_MASK		BIT(1)
+#define WDT_STOP		0
+
+#define PMIC_WDT_MIN_TIMEOUT 1
+#define PMIC_WDT_MAX_TIMEOUT 256
+#define PMIC_WDT_DEFAULT_TIMEOUT 30
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+struct stpmic1_wdt {
+	struct stpmic1 *pmic;
+	struct watchdog_device wdtdev;
+};
+
+static int pmic_wdt_start(struct watchdog_device *wdd)
+{
+	struct stpmic1_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	return regmap_update_bits(wdt->pmic->regmap,
+				  WCHDG_CR, WDT_START_MASK, WDT_START);
+}
+
+static int pmic_wdt_stop(struct watchdog_device *wdd)
+{
+	struct stpmic1_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	return regmap_update_bits(wdt->pmic->regmap,
+				  WCHDG_CR, WDT_START_MASK, WDT_STOP);
+}
+
+static int pmic_wdt_ping(struct watchdog_device *wdd)
+{
+	struct stpmic1_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	return regmap_update_bits(wdt->pmic->regmap,
+				  WCHDG_CR, WDT_PING_MASK, WDT_PING);
+}
+
+static int pmic_wdt_set_timeout(struct watchdog_device *wdd,
+				unsigned int timeout)
+{
+	struct stpmic1_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	wdd->timeout = timeout;
+	/* timeout is equal to register value + 1 */
+	return regmap_write(wdt->pmic->regmap, WCHDG_TIMER_CR, timeout - 1);
+}
+
+static const struct watchdog_info pmic_watchdog_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+	.identity = "STPMIC1 PMIC Watchdog",
+};
+
+static const struct watchdog_ops pmic_watchdog_ops = {
+	.owner = THIS_MODULE,
+	.start = pmic_wdt_start,
+	.stop = pmic_wdt_stop,
+	.ping = pmic_wdt_ping,
+	.set_timeout = pmic_wdt_set_timeout,
+};
+
+static int pmic_wdt_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct stpmic1 *pmic;
+	struct stpmic1_wdt *wdt;
+
+	if (!pdev->dev.parent)
+		return -EINVAL;
+
+	pmic = dev_get_drvdata(pdev->dev.parent);
+	if (!pmic)
+		return -EINVAL;
+
+	wdt = devm_kzalloc(&pdev->dev, sizeof(struct stpmic1_wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	wdt->pmic = pmic;
+
+	wdt->wdtdev.info = &pmic_watchdog_info;
+	wdt->wdtdev.ops = &pmic_watchdog_ops;
+	wdt->wdtdev.min_timeout = PMIC_WDT_MIN_TIMEOUT;
+	wdt->wdtdev.max_timeout = PMIC_WDT_MAX_TIMEOUT;
+	wdt->wdtdev.parent = &pdev->dev;
+
+	wdt->wdtdev.timeout = PMIC_WDT_DEFAULT_TIMEOUT;
+	watchdog_init_timeout(&wdt->wdtdev, 0, &pdev->dev);
+
+	watchdog_set_nowayout(&wdt->wdtdev, nowayout);
+	watchdog_set_drvdata(&wdt->wdtdev, wdt);
+
+	ret = devm_watchdog_register_device(&pdev->dev, &wdt->wdtdev);
+	if (ret)
+		return ret;
+
+	dev_dbg(wdt->pmic->dev, "PMIC Watchdog driver probed\n");
+	return 0;
+}
+
+static const struct of_device_id of_pmic_wdt_match[] = {
+	{ .compatible = "st,stpmic1-wdt" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, of_pmic_wdt_match);
+
+static struct platform_driver stpmic1_wdt_driver = {
+	.probe = pmic_wdt_probe,
+	.driver = {
+		.name = "stpmic1-wdt",
+		.of_match_table = of_pmic_wdt_match,
+	},
+};
+module_platform_driver(stpmic1_wdt_driver);
+
+MODULE_DESCRIPTION("Watchdog driver for STPMIC1 device");
+MODULE_AUTHOR("Pascal Paillet <p.paillet@st.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
