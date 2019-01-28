Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DCAC282CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:25:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA6352171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bNDNT95+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6352171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yP8ejk0pl8eBd20uEaVrCBQyV5De+OI1I8yaQG+3pm0=; b=bNDNT95+bJh9xI
	ds7bRhYimD6/YbcPk1N6bJTvF1aOxQsyGSXiTovDP5ZbevSL0IqUsmJfukeHkYuxrbuyewswCHnss
	NO5VFE3KcPctttVrpiEQ7y2xpNdTSveFnaa2m9saGwoegPT8YfiAjcwl3OAiBbC6zxmF6LR7fYSWL
	FjPDS7ICWxepCvwvg35M0f3ZM017cBCMAYCHx1DoZQLrF3Uw8awfNaBvHPtbhvdh8udmngXJulAB1
	q0RT/uqAw5fSDoqoglbwa3gEJdyqJFV+b2A/6xqRiDe5v5fB4B0O1hyTYEGXuhcbyKIjNhYI+UEC6
	49E6MoNBsIHQ/TEAgyeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go7qf-0006s1-J5; Mon, 28 Jan 2019 14:25:17 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go7p6-0004ug-5z
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 14:23:43 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0SEL2Nk020045; Mon, 28 Jan 2019 15:23:36 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2q8e71vvew-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Mon, 28 Jan 2019 15:23:36 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 94DBB34;
 Mon, 28 Jan 2019 14:23:34 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 715BA2D38;
 Mon, 28 Jan 2019 14:23:34 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 28 Jan
 2019 15:23:33 +0100
Received: from localhost (10.201.20.122) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 28 Jan 2019 15:23:33
 +0100
From: Benjamin Gaignard <benjamin.gaignard@st.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <arnd@arndb.de>,
 <shawnguo@kernel.org>, <s.hauer@pengutronix.de>, <fabio.estevam@nxp.com>
Subject: [RFC v2 5/7] bus: domainsctrl: Add driver for STM32 ETZPC controller
Date: Mon, 28 Jan 2019 15:23:11 +0100
Message-ID: <20190128142313.17036-6-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190128142313.17036-1-benjamin.gaignard@st.com>
References: <20190128142313.17036-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-28_08:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_062340_692629_E9877A07 
X-CRM114-Status: GOOD (  18.27  )
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
Cc: benjamin.gaignard@linaro.org, loic.pallardy@st.com,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org,
 Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

STM32 Extended TrustZone Protection Controller (ETZPC) got 3 domains:
- secure: hardware blocks are only accessible by software running on trust
  zone.
- non-secure: hardware blocks are accessible by non-secure software (i.e.
    linux kernel).
- coprocessor: hardware blocks are only accessible by the corpocessor.

Each hardware block status is defined by a 2 bits field and all of
them are packed into 32 bits registers. ETZPC can manage up to 94
hardware blocks.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/bus/domains/Kconfig                   |   7 ++
 drivers/bus/domains/Makefile                  |   1 +
 drivers/bus/domains/stm32-etzpc.c             | 140 ++++++++++++++++++++++++++
 include/dt-bindings/bus/domains/stm32-etzpc.h |  25 +++++
 4 files changed, 173 insertions(+)
 create mode 100644 drivers/bus/domains/stm32-etzpc.c
 create mode 100644 include/dt-bindings/bus/domains/stm32-etzpc.h

diff --git a/drivers/bus/domains/Kconfig b/drivers/bus/domains/Kconfig
index 5ba15f750bee..7afd209e8c4f 100644
--- a/drivers/bus/domains/Kconfig
+++ b/drivers/bus/domains/Kconfig
@@ -4,4 +4,11 @@ config DOMAINS_CONTROLLERS
 	bool "Support of bus domains controllers"
 	depends on OF
 
+config STM32_ETZPC
+	bool "STM32 ETZPC Domain Controller"
+	depends on DOMAINS_CONTROLLERS && MACH_STM32MP157
+	help
+	  Select y to enable STM32 Extended TrustZone Protection
+	  Controller (ETZPC)
+
 endmenu
diff --git a/drivers/bus/domains/Makefile b/drivers/bus/domains/Makefile
index 262338b7cad5..8000de6023a5 100644
--- a/drivers/bus/domains/Makefile
+++ b/drivers/bus/domains/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_DOMAINS_CONTROLLERS) += domainsctrl.o
+obj-$(CONFIG_STM32_ETZPC) += stm32-etzpc.o
diff --git a/drivers/bus/domains/stm32-etzpc.c b/drivers/bus/domains/stm32-etzpc.c
new file mode 100644
index 000000000000..8a03128a8715
--- /dev/null
+++ b/drivers/bus/domains/stm32-etzpc.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
+ * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
+ */
+
+#include <linux/device.h>
+#include <linux/domainsctrl.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/bus/domains/stm32-etzpc.h>
+
+#define ETZPC_DECPROT	0x010
+#define ETZPC_NUM_LOCKS	94
+
+struct stm32_etzpc {
+	struct regmap_field *fields[ETZPC_NUM_LOCKS];
+};
+
+static int stm32_etzpc_set_config(struct device *dev,
+				  struct of_phandle_args *out_args)
+{
+	struct stm32_etzpc *etzpc = dev_get_drvdata(dev);
+	int index = out_args->args[0];
+	unsigned int value = out_args->args[1];
+	u32 status;
+
+	if (out_args->args_count != 2)
+		return -EINVAL;
+
+	if (index >= ETZPC_NUM_LOCKS)
+		return -EINVAL;
+
+	if (value > STM32_ETZPC_NON_SECURE)
+		return -EINVAL;
+
+	regmap_field_force_write(etzpc->fields[index], value);
+
+	/* Hardware could denied the new value, read it back to check it */
+	regmap_field_read(etzpc->fields[index], &status);
+
+	if (value != status) {
+		dev_info(dev, "failed to set configuration: index %d, value %d\n",
+			 index, value);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct domains_ctrl_ops stm32_etzpc_ops = {
+	.set_config = stm32_etzpc_set_config,
+};
+
+static const struct regmap_config stm32_etzpc_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = sizeof(u32),
+	.max_register = 0x3FF,
+	.fast_io = true,
+};
+
+static int stm32_etzpc_probe(struct platform_device *pdev)
+{
+	struct stm32_etzpc *etzpc;
+	struct resource *res;
+	void __iomem *mmio;
+	struct regmap *regmap;
+	int i;
+
+	etzpc = devm_kzalloc(&pdev->dev, sizeof(*etzpc), GFP_KERNEL);
+	if (!etzpc)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mmio = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(mmio))
+		return PTR_ERR(mmio);
+
+	regmap = devm_regmap_init_mmio(&pdev->dev, mmio,
+				       &stm32_etzpc_regmap_cfg);
+
+	for (i = 0; i < ETZPC_NUM_LOCKS; i++) {
+		struct reg_field field;
+
+		/*
+		 * Each hardware block status is defined by
+		 * a 2 bits field and all of them are packed into
+		 * 32 bits registers. Do some computation to get
+		 * register offset and the shift.
+		 */
+		field.reg = ETZPC_DECPROT + (i >> 4) * sizeof(u32);
+		field.lsb = (i % 0x10) << 1;
+		field.msb = field.lsb + 1;
+
+		etzpc->fields[i] = devm_regmap_field_alloc(&pdev->dev,
+							   regmap, field);
+	}
+
+	platform_set_drvdata(pdev, etzpc);
+
+	return domainsctrl_register(&pdev->dev, &stm32_etzpc_ops);
+}
+
+static int stm32_etzpc_remove(struct platform_device *pdev)
+{
+	domainsctrl_unregister(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id stm32_etzpc_of_match[] = {
+	{ .compatible = "st,stm32-etzpc" },
+	{ /* end node */ }
+};
+MODULE_DEVICE_TABLE(of, stm32_etzpc_of_match);
+
+static struct platform_driver stm32_etzpc_driver = {
+	.probe  = stm32_etzpc_probe,
+	.remove = stm32_etzpc_remove,
+	.driver = {
+		.name = "stm32-etzpc",
+		.of_match_table = stm32_etzpc_of_match,
+	},
+};
+
+static int __init stm32_etzpc_init(void)
+{
+	return platform_driver_register(&stm32_etzpc_driver);
+}
+arch_initcall(stm32_etzpc_init);
+
+MODULE_AUTHOR("Benjamin Gaignard <benjamin.gaignard@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics STM32 Bus Dommains Controller");
diff --git a/include/dt-bindings/bus/domains/stm32-etzpc.h b/include/dt-bindings/bus/domains/stm32-etzpc.h
new file mode 100644
index 000000000000..93190fa29a9c
--- /dev/null
+++ b/include/dt-bindings/bus/domains/stm32-etzpc.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
+ * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
+ */
+
+#ifndef _STM32_ETZPC_H_
+#define _STM32_ETZPC_H_
+
+/* ETZPC domains: secure, non-secure or coprocessor*/
+#define STM32_ETZPC_SECURE	1
+#define STM32_ETPCZ_COPRO	2
+#define STM32_ETZPC_NON_SECURE	3
+
+/* ETZPC hard blaokcs index */
+#define STM32_ETZPC_USART1	3
+#define STM32_ETZPC_SPI6	4
+#define STM32_ETZPC_I2C4	5
+#define STM32_ETZPC_RNG1	7
+#define STM32_ETZPC_HASH1	8
+#define STM32_ETZPC_CRYP1	9
+#define STM32_ETZPC_I2C6	12
+#define STM32_ETZPC_CEC		38
+
+#endif /* _STM32_ETZPC_H_ */
-- 
2.15.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
