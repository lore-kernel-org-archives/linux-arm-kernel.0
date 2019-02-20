Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC67C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:53:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFAFD2086A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="anLRX1xh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jmum4kAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFAFD2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IC+d0RVFV/55cJVdI7mbwI8qoNz1mEBHwF+B1du9l7s=; b=anLRX1xhfiftVP
	kKW7iQEHCvvGDHLDQKcf5q40+PsJqrr/akWDriWr+kERVc8ktnnN/AJjT/Yfxiv9rRiNbSmqv05Ib
	mC8Ubq1SYoERCsKq4untqiOpBqsdNg05afs9yIgDBKhCQJ7I3V6UwjYwDYDxQigSktwp5MhoNeOSj
	9JoG0XJGuB1bULbcVc2Fuizf1vAnz93pma/UDPXe5zpB8lEA+H+GC99BTO2t4NrSUq5KwD8tbMtEk
	oiVg20hFmuEyfPW8ySkAY0PTV0oMATvLHbmkoNmxZf0GBEOb/zvyqjQdidZRUs+tRTDLj+iaDVomg
	A/julzY7KA18I6owggNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwLlQ-0002Bc-TD; Wed, 20 Feb 2019 06:53:53 +0000
Received: from mail-eopbgr40088.outbound.protection.outlook.com ([40.107.4.88]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwLlG-00020e-TN
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 06:53:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSQ8pOAHt058EKDAjw2SZchjsLA+FH+6SjHk0KW9IkU=;
 b=jmum4kAH/ngkzxXPTVl6sGEgadvs3JX++DEG8A8HPNyNRz4j+P6hQlINVTfLrDn71Fv09BacfN45K9llC6xnAG/KqwfUr95HVim+zgHJedpaguhCgXQ6l8YC5OiTxrTncQ9vceNKcKQl6DBbf69WMEG5XqF7oAHHFFJTifD48S4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3883.eurprd04.prod.outlook.com (52.134.71.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 06:53:40 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Wed, 20 Feb 2019
 06:53:40 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org"
 <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
 <festevam@gmail.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>, "rui.zhang@intel.com"
 <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Aisheng Dong
 <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 Daniel Baluta <daniel.baluta@nxp.com>, "horms+renesas@verge.net.au"
 <horms+renesas@verge.net.au>, Andy Gross <andy.gross@linaro.org>,
 "heiko@sntech.de" <heiko@sntech.de>, "arnd@arndb.de" <arnd@arndb.de>,
 "olof@lixom.net" <olof@lixom.net>, "bjorn.andersson@linaro.org"
 <bjorn.andersson@linaro.org>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>, "enric.balletbo@collabora.com"
 <enric.balletbo@collabora.com>, "marc.w.gonzalez@free.fr"
 <marc.w.gonzalez@free.fr>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>
Subject: [PATCH V7 2/4] thermal: imx_sc: add i.MX system controller thermal
 support
Thread-Topic: [PATCH V7 2/4] thermal: imx_sc: add i.MX system controller
 thermal support
Thread-Index: AQHUyOkCJi1D1PctWEiIEjd3xAtVuw==
Date: Wed, 20 Feb 2019 06:53:40 +0000
Message-ID: <1550645332-2907-2-git-send-email-Anson.Huang@nxp.com>
References: <1550645332-2907-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550645332-2907-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0050.apcprd04.prod.outlook.com
 (2603:1096:202:14::18) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36afb88b-a342-45dc-980b-08d697002520
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3883; 
x-ms-traffictypediagnostic: DB3PR0402MB3883:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; DB3PR0402MB3883;
 23:w/nq0Ewb1K+Myi0ddpk05MxJ9VxakHC0InuA2?=
 =?iso-8859-1?Q?QNfFv2Kqro7oYlpU3WeFRsAUBaulGPBXlgcziiD+TnAe3skM1KgXVUxsbU?=
 =?iso-8859-1?Q?90e+GK7xuSusG8I5H0/73WoZRfw64ijuBLiwosVceWtT+U6CtcSmqtZS4I?=
 =?iso-8859-1?Q?5nAB9cIqoHnDSu7dnLqUtE+sWKb/OAHYIG0OoEjDOajBAe03NH6maofWYa?=
 =?iso-8859-1?Q?DwlRwtEAXaXFlg41JSnsQOUeTOlcLS3/Io6eFD+PAgvx00YFdQMUU73qTY?=
 =?iso-8859-1?Q?A2zInV00w8s6FRD3ZxQQH3OzcFYGYcjgYFKFheKL0zqC9QfHORKLVMtjVO?=
 =?iso-8859-1?Q?+tSai4MENyCmmKzP0lYQiGaV8hyc04lVDDcYxLGOA/mmWw3217yFtbpj7u?=
 =?iso-8859-1?Q?UhN9ICAxd+VmiY+mFiksqJ2/YSeS4LWsQMOEzSqf+ezGxCXEvnsOQiXap+?=
 =?iso-8859-1?Q?t0tS5eKdzXqZqXS0Zo82BxISPMiBKW/saT4Je7MPmkNJNOyvHoJdzSCC1O?=
 =?iso-8859-1?Q?YpMXXZA1PtZ2uoXFfhHrnG8P6wMSKa/ek+1TsO5Cr8bqBxh9BJEhz+ygg6?=
 =?iso-8859-1?Q?oY8Qw51nLLMD41TrW3oTa78hrC6p8znIwtZiAMdTaQiIp2G8frBOeWieZw?=
 =?iso-8859-1?Q?3ykM0Ylu+9onEwEoNx5V/oCyPTrWEF3rxxKWuu2EAynHvdfvXRrZQ911Yh?=
 =?iso-8859-1?Q?ykGb2RFuKNbaqxdIni7RH+jVO5++M06Xd6xsn4jG6HSdd2lRPa7usKhcRE?=
 =?iso-8859-1?Q?sdsjv5T2tbwpXlUJOx2JCZAuYdgRGoiEAd8q6asiN6wuTjUTWTrqCjWl96?=
 =?iso-8859-1?Q?tg3sXTzCFM0GQDIHBDiHZpeybwUqX8Ow4BD+YlkQ8QMAGwWep0n8vQWNZq?=
 =?iso-8859-1?Q?h7cglQymCvVgQuvvhb+ru3v73UDJOS9zPNxnUogGgmsqE761+mBrLeiQkh?=
 =?iso-8859-1?Q?AbkJc7WXh45QOgCvfBagmbNsRDI4tQkQdcNn6C1BjHOARQFGXR9LYjprqD?=
 =?iso-8859-1?Q?Rz512g6rJNQDYU5IDt8/lG1VRlI1C/2urnN5fMs3WGmYEiFAgfoMX8zy15?=
 =?iso-8859-1?Q?M0aSKvS5GBEldD+VoJeSFSDBKiZ7wqfCcU9fPmihVlqntFPUtaHhRzI9yO?=
 =?iso-8859-1?Q?hIjTz0G+UOoubZFOLCQoYgvJDUBZ4IVuJlreX2Qz4VDnycIzJh+rHWC2GU?=
 =?iso-8859-1?Q?ABP9TXddzMuRa/6slbABLK6JxtojB9tR+0P6xA6j9Mz4Hi/E6/Ygc+Ureq?=
 =?iso-8859-1?Q?u3FG/HbUzZ8hgcM1UDtw2r366BmB9eGrHPWvJfYWD8HYOCGoe+pUtUWYsM?=
 =?iso-8859-1?Q?F26I=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3883CDF663FE43D3F7020743F57D0@DB3PR0402MB3883.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(396003)(346002)(366004)(39860400002)(136003)(199004)(189003)(7736002)(53936002)(6436002)(6512007)(256004)(14454004)(26005)(305945005)(6486002)(36756003)(7416002)(66066001)(97736004)(478600001)(186003)(102836004)(106356001)(8676002)(6506007)(5660300002)(81166006)(50226002)(386003)(105586002)(2906002)(81156014)(8936002)(2501003)(2201001)(110136005)(486006)(316002)(68736007)(76176011)(86362001)(4326008)(2616005)(476003)(99286004)(3846002)(11346002)(6116002)(446003)(71190400001)(71200400001)(52116002)(25786009)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3883;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MLPLVMkBmU70sgKHXpJN/zAMgM4GeTMMm/9ZQbEXoOGEx5kQgtVqebTf7bPkORWuVShW0Fv3AdxNB1/tG2QmIMjJpccHCj9aCHC0vedIYO65oKlpAzRwUrpXGlpC3DikKzE74VXZdJ+u6V4QKVArUkKPOFF7fMck0nMi1KqNPPNRvy4uhMTRENBbzn3x3Btkh50nl/2j6XtSqjMv6gd+NSoyPi+Sf1qj2TEt+idvazjRHwlqS6uN5PHhqAoL2FMu3mPEbkcagp+njMIRQ/hVN1icURxCxzBvzLU/n5wI0nLKYimCayVz06joxOUPjapnuk6YDELKyKMW0PvlJL3QxyduELddTxqtdvS9bh9z4QtEsJIHRDhdOxB7rPQfOImx8RZSJx7iMiELH2SXuQxeO5gRwTIYO3atA4TkZbF8+18=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36afb88b-a342-45dc-980b-08d697002520
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 06:53:30.9962 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3883
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_225343_056486_ADFBA57C 
X-CRM114-Status: GOOD (  19.53  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
inside, the system controller is in charge of controlling power,
clock and thermal sensors etc..

This patch adds i.MX system controller thermal driver support,
Linux kernel has to communicate with system controller via MU
(message unit) IPC to get each thermal sensor's temperature,
it supports multiple sensors which are passed from device tree,
please see the binding doc for details.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V6:
	- use "fsl,imx-sc-thermal" compatible to make SC thermal driver more generic for other i.MX8 SoCs
	  with system controller inside.
---
 drivers/thermal/Kconfig          |  11 +++
 drivers/thermal/Makefile         |   1 +
 drivers/thermal/imx_sc_thermal.c | 161 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 173 insertions(+)
 create mode 100644 drivers/thermal/imx_sc_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 58bb7d7..fec0ef5 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -223,6 +223,17 @@ config IMX_THERMAL
 	  cpufreq is used as the cooling device to throttle CPUs when the
 	  passive trip is crossed.
 
+config IMX_SC_THERMAL
+	tristate "Temperature sensor driver for NXP i.MX SoCs with System Controller"
+	depends on (ARCH_MXC && IMX_SCU) || COMPILE_TEST
+	depends on OF
+	help
+	  Support for Temperature Monitor (TEMPMON) found on NXP i.MX SoCs with
+	  system controller inside, Linux kernel has to communicate with system
+	  controller via MU (message unit) IPC to get temperature from thermal
+	  sensor. It supports one critical trip point and one
+	  passive trip point for each thermal sensor.
+
 config MAX77620_THERMAL
 	tristate "Temperature sensor driver for Maxim MAX77620 PMIC"
 	depends on MFD_MAX77620
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 486d682..4062627 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_DB8500_THERMAL)	+= db8500_thermal.o
 obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
 obj-$(CONFIG_TANGO_THERMAL)	+= tango_thermal.o
 obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
+obj-$(CONFIG_IMX_SC_THERMAL)	+= imx_sc_thermal.o
 obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
 obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
 obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
new file mode 100644
index 0000000..1a8b978
--- /dev/null
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018-2019 NXP.
+ */
+
+#include <linux/err.h>
+#include <linux/firmware/imx/sci.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+
+#include "thermal_core.h"
+
+#define IMX_SC_MISC_FUNC_GET_TEMP	13
+#define IMX_SC_C_TEMP			0
+
+static struct imx_sc_ipc *thermal_ipc_handle;
+
+struct imx_sc_sensor {
+	struct thermal_zone_device *tzd;
+	u32 resource_id;
+};
+
+struct imx_sc_thermal_data {
+	struct imx_sc_sensor *sensor;
+};
+
+struct req_get_temp {
+	u16 resource_id;
+	u8 type;
+} __packed;
+
+struct resp_get_temp {
+	u16 celsius;
+	u8 tenths;
+} __packed;
+
+struct imx_sc_msg_misc_get_temp {
+	struct imx_sc_rpc_msg hdr;
+	union {
+		struct req_get_temp req;
+		struct resp_get_temp resp;
+	} data;
+} __packed;
+
+static int imx_sc_thermal_get_temp(void *data, int *temp)
+{
+	struct imx_sc_msg_misc_get_temp msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	struct imx_sc_sensor *sensor = data;
+	int ret;
+
+	msg.data.req.resource_id = sensor->resource_id;
+	msg.data.req.type = IMX_SC_C_TEMP;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_MISC;
+	hdr->func = IMX_SC_MISC_FUNC_GET_TEMP;
+	hdr->size = 2;
+
+	ret = imx_scu_call_rpc(thermal_ipc_handle, &msg, true);
+	if (ret) {
+		pr_err("read temp sensor %d failed, ret %d\n",
+			sensor->resource_id, ret);
+		return ret;
+	}
+
+	*temp = msg.data.resp.celsius * 1000 + msg.data.resp.tenths * 100;
+
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops imx_sc_thermal_ops = {
+	.get_temp = imx_sc_thermal_get_temp,
+};
+
+static int imx_sc_thermal_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *sensor_np = NULL;
+	struct imx_sc_thermal_data *data;
+	struct imx_sc_sensor *sensors;
+	u32 sensor_num;
+	int ret, i;
+
+	ret = imx_scu_get_handle(&thermal_ipc_handle);
+	if (ret)
+		return ret;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	ret = of_property_read_u32(np, "tsens-num", &sensor_num);
+	if (ret || !sensor_num) {
+		dev_err(&pdev->dev, "failed to get valid temp sensor number!\n");
+		return -EINVAL;
+	}
+
+	sensors = devm_kzalloc(&pdev->dev, sizeof(*data->sensor) * sensor_num,
+			       GFP_KERNEL);
+	if (!sensors)
+		return -ENOMEM;
+
+	data->sensor = sensors;
+
+	np = of_find_node_by_name(NULL, "thermal-zones");
+	if (!np)
+		return -ENODEV;
+
+	for (i = 0; i < sensor_num; i++) {
+		struct imx_sc_sensor *sensor = &data->sensor[i];
+
+		sensor_np = of_get_next_child(np, sensor_np);
+		ret = of_property_read_u32(sensor_np, "imx,sensor-resource-id",
+			&sensor->resource_id);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"failed to get valid sensor resource id: %d\n",
+				ret);
+			break;
+		}
+
+		sensor->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
+								   i,
+								   sensor,
+								   &imx_sc_thermal_ops);
+		if (IS_ERR(sensor->tzd)) {
+			dev_err(&pdev->dev, "failed to register thermal zone\n");
+			ret = PTR_ERR(sensor->tzd);
+			break;
+		}
+	}
+
+	of_node_put(np);
+	of_node_put(sensor_np);
+
+	return ret;
+}
+
+static const struct of_device_id imx_sc_thermal_table[] = {
+	{ .compatible = "fsl,imx-sc-thermal", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, imx_sc_thermal_table);
+
+static struct platform_driver imx_sc_thermal_driver = {
+		.probe = imx_sc_thermal_probe,
+		.driver = {
+			.name = "imx-sc-thermal",
+			.of_match_table = imx_sc_thermal_table,
+		},
+};
+module_platform_driver(imx_sc_thermal_driver);
+
+MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
+MODULE_DESCRIPTION("Thermal driver for NXP i.MX SoCs with system controller");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
