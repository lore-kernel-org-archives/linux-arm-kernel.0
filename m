Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19888C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:09:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBF6E20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GSVxeqkY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MHAelTA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF6E20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xojpjFWlO2vbw+0lRe3ko38AMqyVdgXxRQo2Vy/agAo=; b=GSVxeqkY+GAtD7
	oRTHMBx2hhFAi3T4zuONgKOPgcLK3eVUlhmpzBdcd7I6ValKzTSFrkpDrlVRI7aSqxsqWxCZKvIxA
	UtZqRBVvlvexMfj/8kPYDBfBZVZQ94US7dgZ98Sq5nZ1/LqHWpWjO5j0335rK8Gmhd6nTkD8pcoxv
	CxALX0VjtLCfWCoRy8Xqck6KmIEJYify/g/OzD4AArNH0ObJPsHnRoEDc9r9/2mb6bPDcH8rGlWzX
	aiPs+mabiEo0n35STG5fNOPREgNofi93eT+4JsQgzgxVTYujVlr8z1xi2S2AGzwc/rT77R4SQwS8d
	V7W5+bFqcYJbvycZBc1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXFVC-0005IX-Hu; Thu, 13 Dec 2018 01:09:22 +0000
Received: from mail-he1eur02on062f.outbound.protection.outlook.com
 ([2a01:111:f400:fe05::62f]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXFUB-0004Em-5j
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 01:08:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCZ/uDcPHLnMtrVNX4txskBNq7Hngbov6osVkrtL85Y=;
 b=MHAelTA45LvoIgsATguTq4JJ8AMsV/8Y4I5DyFv2Ym3UPda3odhdfXTGj76fQ4Wprg6wdK9JEjnT4wObIICA1/mo9jWIz9nb/JdOKeb7rmK+6TynhjMV/K5qwXffPFQ8G10KF1HSBKEQpjVGJboWhAPK5FPoofUE5i2sJPHFvU4=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4852.eurprd04.prod.outlook.com (20.176.215.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.23; Thu, 13 Dec 2018 01:08:03 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Thu, 13 Dec 2018
 01:08:03 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH V11 4/7] clk: imx: add imx8qxp clk driver
Thread-Topic: [PATCH V11 4/7] clk: imx: add imx8qxp clk driver
Thread-Index: AQHUkoBLVnfkRkWS+kGxRgubcDr22Q==
Date: Thu, 13 Dec 2018 01:08:02 +0000
Message-ID: <1544662938-5020-5-git-send-email-aisheng.dong@nxp.com>
References: <1544662938-5020-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1544662938-5020-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To AM0PR04MB4211.eurprd04.prod.outlook.com (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4852;
 6:P9f37clG+e9MtpfoYO2T2f2PAvSrciuT3EAHwrM5f+w0+bLZJcZvsXw/TuW+Zxs+9/4+TvNBPOFoaDOWyPOw1hOVkwX3sxahfJB9xAogMT0EhuJhIuzWkO/g3DoaI8GMqlpu0T+CxSpiwBU8xfnPca0x0qDefH47IW8iZIHU6YREfrP3te9DQUDxKhI+SgwNTXmSRXPdnSayJs97Y4aPSP4b5MMrxAUtyoecsx3dD89jroknYGO5Uw8PsENGvSM9W6g8Z7KNdXG9Bz204ko+GekB3xRu4DtdjjBEI81Vz9Bm/f/5bXf7uccpgo3QixH7eHhxkPqTz1b3IKP0W/njohxRpNVNXbDh+X0lwvkllr/l2BNI5I5g4fca1+y/fFP7vhN65BFjEOsStrp177Gae2o5ptfNmyFaqUJMf8GmrPUNvyMRx2xwny8JfDsNKFODYghBSpAwyUeCVtP0bF00SA==;
 5:o/Z7UKCBmDeEypue9aqtE2LM76IftbFMLyuv06fmaTY3pHQdXrerelByBo2474EfW9vC0Nxd7ayt9022/CQ2HLOFvG0f67uZbFzYhJfoGIcqRTYw8WfQXAWXFNR5MVAAuiXdjWNCQutsvgvZ41Bh26xxstL05NlXpIJ/I1xyrg4=;
 7:tM2XTCR2QzeESqzdcPv1s5DCivALmAQpgM7bB+qdtX8EjIUfU643Tt/EpnmX1cbHifE53w7649YqemxsQWfvZfu/neuWZYvMT0mPwYU4Ul0CyhyZMZaDYDvDunJsPR1Sqy+o8CvQxS3/GRNat8Jp7w==
x-ms-office365-filtering-correlation-id: 7157a076-7782-4455-75aa-08d660976e4d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4852; 
x-ms-traffictypediagnostic: AM0PR04MB4852:
x-microsoft-antispam-prvs: <AM0PR04MB48528C3CABC5C25DF5F08FC580A00@AM0PR04MB4852.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4852; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4852; 
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(376002)(366004)(346002)(396003)(54534003)(199004)(189003)(53936002)(186003)(2616005)(2501003)(11346002)(71200400001)(44832011)(4744004)(476003)(5640700003)(6506007)(3846002)(52116002)(71190400001)(66066001)(486006)(7736002)(305945005)(6116002)(50226002)(14444005)(6486002)(8936002)(81166006)(14454004)(68736007)(81156014)(6436002)(8676002)(256004)(316002)(36756003)(86362001)(25786009)(54906003)(6512007)(26005)(106356001)(6916009)(76176011)(446003)(478600001)(386003)(2351001)(97736004)(2906002)(102836004)(105586002)(5660300001)(4326008)(99286004)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4852;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MXaHcNuUcWl604oab620bmU3VdnJmwnAMtQk5bvzOydHyrGR5GcP21LaHt55j1KKmJBy2w/Ctt9ydkmsmWeUrNjc7dolHWDWmNsU1EbN0vyI6t3e55wnydGU9yOkdsd+ZCnBW1QfQwGH1zPiJtC7NjX1sj1+gMaaiqkGrQFO59pmbRMqAkGpD2mVCp3wBwm3v23oK3QmcvgoDlA0R5CeRkWEOqNAvtQEJ7F2JxrubCpAAaBPM6mf+AO9oAKGaje+WyuIKo+V26PPfL8NKlZRUZVZNmrm8rloluCmneQV1eQr5ZGpFWGF9wRmHyICNA/A
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7157a076-7782-4455-75aa-08d660976e4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 01:08:02.9444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4852
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_170819_569872_4CBF4ADF 
X-CRM114-Status: GOOD (  17.60  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add imx8qxp clk driver which is based on SCU firmware clock service.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v9->v10:
 * fix a typo of SPI1 clock
v8->v9:
 * no changes
v7->v8:
 * move dt headfiles after normal linux headfiles according to
   Stephen's former suggestions
v6->v7:
 * use struct_size()
 * remove MODULE_ macros
 * add suppress_bind_attrs
v5->v6:
 * changed to new scu clock type imx_clk_scu
   clk number is reduced signifcantly
 * moved lpcgs clock out into separate driver
v4->v5:
 Address all comments from Stephen
 * more unique name for clk_data
 * remove void __iomem * cast for LPCG physical address
 * move out external fixed clk definition
 * drop using of imx_clk_hw_fixed and imx_check_clk_hws wrappers
 * remove i'm alive message
 * move scu clk files into imx top directory
v3->v4:
 * scu headfile path update
v2->v3:
 * enum name update
v1->v2:
 * no changes except headfile name updated
---
 drivers/clk/imx/Makefile      |   2 +
 drivers/clk/imx/clk-imx8qxp.c | 153 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 155 insertions(+)
 create mode 100644 drivers/clk/imx/clk-imx8qxp.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 4abed37..75312fb 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -39,3 +39,5 @@ obj-$(CONFIG_SOC_IMX7D)  += clk-imx7d.o
 obj-$(CONFIG_SOC_IMX7ULP) += clk-imx7ulp.o
 obj-$(CONFIG_SOC_IMX8MQ) += clk-imx8mq.o
 obj-$(CONFIG_SOC_VF610)  += clk-vf610.o
+
+obj-$(CONFIG_SOC_IMX8QXP)	+= clk-imx8qxp.o
diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
new file mode 100644
index 0000000..33c9396
--- /dev/null
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "clk-scu.h"
+
+#include <dt-bindings/clock/imx8qxp-clock.h>
+#include <dt-bindings/firmware/imx/rsrc.h>
+
+static int imx8qxp_clk_probe(struct platform_device *pdev)
+{
+	struct device_node *ccm_node = pdev->dev.of_node;
+	struct clk_hw_onecell_data *clk_data;
+	struct clk_hw **clks;
+	int ret, i;
+
+	ret = imx_clk_scu_init();
+	if (ret)
+		return ret;
+
+	clk_data = devm_kzalloc(&pdev->dev, struct_size(clk_data, hws,
+				IMX8QXP_SCU_CLK_END), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
+	clk_data->num = IMX8QXP_SCU_CLK_END;
+	clks = clk_data->hws;
+
+	/* Fixed clocks */
+	clks[IMX8QXP_CLK_DUMMY]			= clk_hw_register_fixed_rate(NULL, "dummy", NULL, 0, 0);
+	clks[IMX8QXP_ADMA_IPG_CLK_ROOT] 	= clk_hw_register_fixed_rate(NULL, "dma_ipg_clk_root", NULL, 0, 120000000);
+	clks[IMX8QXP_CONN_AXI_CLK_ROOT]		= clk_hw_register_fixed_rate(NULL, "conn_axi_clk_root", NULL, 0, 333333333);
+	clks[IMX8QXP_CONN_AHB_CLK_ROOT]		= clk_hw_register_fixed_rate(NULL, "conn_ahb_clk_root", NULL, 0, 166666666);
+	clks[IMX8QXP_CONN_IPG_CLK_ROOT]		= clk_hw_register_fixed_rate(NULL, "conn_ipg_clk_root", NULL, 0, 83333333);
+	clks[IMX8QXP_DC_AXI_EXT_CLK]		= clk_hw_register_fixed_rate(NULL, "dc_axi_ext_clk_root", NULL, 0, 800000000);
+	clks[IMX8QXP_DC_AXI_INT_CLK]		= clk_hw_register_fixed_rate(NULL, "dc_axi_int_clk_root", NULL, 0, 400000000);
+	clks[IMX8QXP_DC_CFG_CLK]		= clk_hw_register_fixed_rate(NULL, "dc_cfg_clk_root", NULL, 0, 100000000);
+	clks[IMX8QXP_MIPI_IPG_CLK]		= clk_hw_register_fixed_rate(NULL, "mipi_ipg_clk_root", NULL, 0, 120000000);
+	clks[IMX8QXP_IMG_AXI_CLK]		= clk_hw_register_fixed_rate(NULL, "img_axi_clk_root", NULL, 0, 400000000);
+	clks[IMX8QXP_IMG_IPG_CLK]		= clk_hw_register_fixed_rate(NULL, "img_ipg_clk_root", NULL, 0, 200000000);
+	clks[IMX8QXP_IMG_PXL_CLK]		= clk_hw_register_fixed_rate(NULL, "img_pxl_clk_root", NULL, 0, 600000000);
+	clks[IMX8QXP_HSIO_AXI_CLK]		= clk_hw_register_fixed_rate(NULL, "hsio_axi_clk_root", NULL, 0, 400000000);
+	clks[IMX8QXP_HSIO_PER_CLK]		= clk_hw_register_fixed_rate(NULL, "hsio_per_clk_root", NULL, 0, 133333333);
+	clks[IMX8QXP_LSIO_MEM_CLK]		= clk_hw_register_fixed_rate(NULL, "lsio_mem_clk_root", NULL, 0, 200000000);
+	clks[IMX8QXP_LSIO_BUS_CLK]		= clk_hw_register_fixed_rate(NULL, "lsio_bus_clk_root", NULL, 0, 100000000);
+
+	/* ARM core */
+	clks[IMX8QXP_A35_CLK]			= imx_clk_scu("a35_clk", IMX_SC_R_A35, IMX_SC_PM_CLK_CPU);
+
+	/* LSIO SS */
+	clks[IMX8QXP_LSIO_PWM0_CLK]		= imx_clk_scu("pwm0_clk", IMX_SC_R_PWM_0, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_LSIO_PWM1_CLK]		= imx_clk_scu("pwm1_clk", IMX_SC_R_PWM_1, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_LSIO_PWM2_CLK]		= imx_clk_scu("pwm2_clk", IMX_SC_R_PWM_2, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_LSIO_PWM3_CLK]		= imx_clk_scu("pwm3_clk", IMX_SC_R_PWM_3, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_LSIO_PWM4_CLK]		= imx_clk_scu("pwm4_clk", IMX_SC_R_PWM_4, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_LSIO_PWM5_CLK]		= imx_clk_scu("pwm5_clk", IMX_SC_R_PWM_5, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_LSIO_PWM6_CLK]		= imx_clk_scu("pwm6_clk", IMX_SC_R_PWM_6, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_LSIO_PWM7_CLK]		= imx_clk_scu("pwm7_clk", IMX_SC_R_PWM_7, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_LSIO_GPT0_CLK]		= imx_clk_scu("gpt0_clk", IMX_SC_R_GPT_0, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_LSIO_GPT1_CLK]		= imx_clk_scu("gpt1_clk", IMX_SC_R_GPT_1, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_LSIO_GPT2_CLK]		= imx_clk_scu("gpt2_clk", IMX_SC_R_GPT_2, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_LSIO_GPT3_CLK]		= imx_clk_scu("gpt3_clk", IMX_SC_R_GPT_3, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_LSIO_GPT4_CLK]		= imx_clk_scu("gpt4_clk", IMX_SC_R_GPT_4, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_LSIO_FSPI0_CLK]		= imx_clk_scu("fspi0_clk", IMX_SC_R_FSPI_0, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_LSIO_FSPI1_CLK]		= imx_clk_scu("fspi1_clk", IMX_SC_R_FSPI_1, IMX_SC_PM_CLK_PER);
+
+	/* ADMA SS */
+	clks[IMX8QXP_ADMA_UART0_CLK]		= imx_clk_scu("uart0_clk", IMX_SC_R_UART_0, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_ADMA_UART1_CLK]		= imx_clk_scu("uart1_clk", IMX_SC_R_UART_1, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_ADMA_UART2_CLK]		= imx_clk_scu("uart2_clk", IMX_SC_R_UART_2, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_ADMA_UART3_CLK]		= imx_clk_scu("uart3_clk", IMX_SC_R_UART_3, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_ADMA_SPI0_CLK]		= imx_clk_scu("spi0_clk",  IMX_SC_R_SPI_0, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_ADMA_SPI1_CLK]		= imx_clk_scu("spi1_clk",  IMX_SC_R_SPI_1, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_ADMA_SPI2_CLK]		= imx_clk_scu("spi2_clk",  IMX_SC_R_SPI_2, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_ADMA_SPI3_CLK]		= imx_clk_scu("spi3_clk",  IMX_SC_R_SPI_3, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_ADMA_CAN0_CLK]		= imx_clk_scu("can0_clk",  IMX_SC_R_CAN_0, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_ADMA_I2C0_CLK]		= imx_clk_scu("i2c0_clk",  IMX_SC_R_I2C_0, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_ADMA_I2C1_CLK]		= imx_clk_scu("i2c1_clk",  IMX_SC_R_I2C_1, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_ADMA_I2C2_CLK]		= imx_clk_scu("i2c2_clk",  IMX_SC_R_I2C_2, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_ADMA_I2C3_CLK]		= imx_clk_scu("i2c3_clk",  IMX_SC_R_I2C_3, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_ADMA_FTM0_CLK]		= imx_clk_scu("ftm0_clk",  IMX_SC_R_FTM_0, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_ADMA_FTM1_CLK]		= imx_clk_scu("ftm1_clk",  IMX_SC_R_FTM_1, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_ADMA_ADC0_CLK]		= imx_clk_scu("adc0_clk",  IMX_SC_R_ADC_0, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_ADMA_PWM_CLK]		= imx_clk_scu("pwm_clk",   IMX_SC_R_LCD_0_PWM_0, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_ADMA_LCD_CLK]		= imx_clk_scu("lcd_clk",   IMX_SC_R_LCD_0, IMX_SC_PM_CLK_PER);
+
+	/* Connectivity */
+	clks[IMX8QXP_CONN_SDHC0_CLK]		= imx_clk_scu("sdhc0_clk", IMX_SC_R_SDHC_0, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_CONN_SDHC1_CLK]		= imx_clk_scu("sdhc1_clk", IMX_SC_R_SDHC_1, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_CONN_SDHC2_CLK]		= imx_clk_scu("sdhc2_clk", IMX_SC_R_SDHC_2, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_CONN_ENET0_ROOT_CLK]	= imx_clk_scu("enet0_clk", IMX_SC_R_ENET_0, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_CONN_ENET0_BYPASS_CLK]	= imx_clk_scu("enet0_bypass_clk", IMX_SC_R_ENET_0, IMX_SC_PM_CLK_BYPASS);
+	clks[IMX8QXP_CONN_ENET0_RGMII_CLK]	= imx_clk_scu("enet0_rgmii_clk", IMX_SC_R_ENET_0, IMX_SC_PM_CLK_MISC0);
+	clks[IMX8QXP_CONN_ENET1_ROOT_CLK]	= imx_clk_scu("enet1_clk", IMX_SC_R_ENET_1, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_CONN_ENET1_BYPASS_CLK]	= imx_clk_scu("enet1_bypass_clk", IMX_SC_R_ENET_1, IMX_SC_PM_CLK_BYPASS);
+	clks[IMX8QXP_CONN_ENET1_RGMII_CLK]	= imx_clk_scu("enet1_rgmii_clk", IMX_SC_R_ENET_1, IMX_SC_PM_CLK_MISC0);
+	clks[IMX8QXP_CONN_GPMI_BCH_IO_CLK]	= imx_clk_scu("gpmi_io_clk", IMX_SC_R_NAND, IMX_SC_PM_CLK_MST_BUS);
+	clks[IMX8QXP_CONN_GPMI_BCH_CLK]		= imx_clk_scu("gpmi_bch_clk", IMX_SC_R_NAND, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_CONN_USB2_ACLK]		= imx_clk_scu("usb3_aclk_div", IMX_SC_R_USB_2, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_CONN_USB2_BUS_CLK]		= imx_clk_scu("usb3_bus_div", IMX_SC_R_USB_2, IMX_SC_PM_CLK_MST_BUS);
+	clks[IMX8QXP_CONN_USB2_LPM_CLK]		= imx_clk_scu("usb3_lpm_div", IMX_SC_R_USB_2, IMX_SC_PM_CLK_MISC);
+
+	/* Display controller SS */
+	clks[IMX8QXP_DC0_DISP0_CLK]		= imx_clk_scu("dc0_disp0_clk", IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC0);
+	clks[IMX8QXP_DC0_DISP1_CLK]		= imx_clk_scu("dc0_disp1_clk", IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC1);
+
+	/* MIPI-LVDS SS */
+	clks[IMX8QXP_MIPI0_I2C0_CLK]		= imx_clk_scu("mipi0_i2c0_clk", IMX_SC_R_MIPI_0_I2C_0, IMX_SC_PM_CLK_MISC2);
+	clks[IMX8QXP_MIPI0_I2C1_CLK]		= imx_clk_scu("mipi0_i2c1_clk", IMX_SC_R_MIPI_0_I2C_1, IMX_SC_PM_CLK_MISC2);
+
+	/* MIPI CSI SS */
+	clks[IMX8QXP_CSI0_CORE_CLK]		= imx_clk_scu("mipi_csi0_core_clk", IMX_SC_R_CSI_0, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_CSI0_ESC_CLK]		= imx_clk_scu("mipi_csi0_esc_clk",  IMX_SC_R_CSI_0, IMX_SC_PM_CLK_MISC);
+	clks[IMX8QXP_CSI0_I2C0_CLK]		= imx_clk_scu("mipi_csi0_i2c0_clk", IMX_SC_R_CSI_0_I2C_0, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_CSI0_PWM0_CLK]		= imx_clk_scu("mipi_csi0_pwm0_clk", IMX_SC_R_CSI_0_PWM_0, IMX_SC_PM_CLK_PER);
+
+	/* GPU SS */
+	clks[IMX8QXP_GPU0_CORE_CLK]		= imx_clk_scu("gpu_core0_clk",	 IMX_SC_R_GPU_0_PID0, IMX_SC_PM_CLK_PER);
+	clks[IMX8QXP_GPU0_SHADER_CLK]		= imx_clk_scu("gpu_shader0_clk", IMX_SC_R_GPU_0_PID0, IMX_SC_PM_CLK_MISC);
+
+	for (i = 0; i < clk_data->num; i++) {
+		if (IS_ERR(clks[i]))
+			pr_warn("i.MX clk %u: register failed with %ld\n",
+				i, PTR_ERR(clks[i]));
+	}
+
+	return of_clk_add_hw_provider(ccm_node, of_clk_hw_onecell_get, clk_data);
+}
+
+static const struct of_device_id imx8qxp_match[] = {
+	{ .compatible = "fsl,imx8qxp-clk", },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver imx8qxp_clk_driver = {
+	.driver = {
+		.name = "imx8qxp-clk",
+		.of_match_table = imx8qxp_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = imx8qxp_clk_probe,
+};
+builtin_platform_driver(imx8qxp_clk_driver);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
