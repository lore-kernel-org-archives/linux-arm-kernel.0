Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED765C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:10:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE5B720811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rrNYtX8l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="k/ehb1+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5B720811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AUvCgEIM80PmK4S9wsS/pup6nZr8B9iaIPsexPX4t1o=; b=rrNYtX8lc1oELx
	7IpItcjdwN52zWBTgRa6Hg8gKqifS6EVURGETk2Uohz0ZbVIrUtd93bcVsmV7qlkUelferYBDZG7s
	eCLzizrphG2NDby2NG+3kj4xptagPT9EUhIDO/9yeW9O0OY7zn/k53tFKUDhA38sQK6ZF/sIPFOX5
	zZE3ACDmOArSw++D6d7ZUCAs0zdLHkJglEXJAa2LsV8RsLsMTo2Yo3iprPonts4z4LB3b3G9NCDNe
	x0oYX+IJX1Wk392jEqbjFSQVhUKb4GEEnBRRffDatPJhsis9XLsh0hezkjwDih12UV4w88u+dyYpt
	PUq+Zp9vmW7oFnfpKTjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXFW2-0006PF-S1; Thu, 13 Dec 2018 01:10:14 +0000
Received: from mail-he1eur02on062f.outbound.protection.outlook.com
 ([2a01:111:f400:fe05::62f]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXFUz-0004Em-R5
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 01:09:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK4NoP9rf6f/ot0orsY+e3Y6aW94ajTwoENXJE/zSc0=;
 b=k/ehb1+L0OFy+X0qsgTrsW+GRgXZV1TOoJFEqo9PU3Kmjs9S46H363GofhKgm/UCzJT4CD6rdnknMCx4w03yJXLsBe6D85OSx99LjTf2UgTWfD8sRJ0fQkYzMFdn1HOHkc9g7uBf2Zp1or3503hT0Fp8Aat11FvUIhZHowRQWZ0=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4852.eurprd04.prod.outlook.com (20.176.215.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.23; Thu, 13 Dec 2018 01:08:13 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Thu, 13 Dec 2018
 01:08:13 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH V11 7/7] clk: imx: add imx8qxp lpcg driver
Thread-Topic: [PATCH V11 7/7] clk: imx: add imx8qxp lpcg driver
Thread-Index: AQHUkoBStY3lg2uiiUWWvG9wcsV+xA==
Date: Thu, 13 Dec 2018 01:08:13 +0000
Message-ID: <1544662938-5020-8-git-send-email-aisheng.dong@nxp.com>
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
 6:o2c8+z1uOdhvf+/2iEtP654w/TQgXOyUUSCqgbd1zK+xcR5j5IhY5ja7wEdq6MPEP5HFPCCz1/N31SufOvQ+KlMJXB5MoAEjSlUKy5sx46u9zZ/pPyk4FzGlyl4nWyS/ZUvKNEZ0zjPGJBAmkNVI0fe73BkMWLy1h0OdPu9VQHNK1n04mjrhjDFgBw39FuMmdHKLytoMzT75xyV1etNm7v7qRa+sILzotTS+XtBvjtt5dHzSg2LHrxXeN+VaIMnhERDiDLLO7EERPlhGfPQtWxvcVMBS/5ZsFXkgcu37xOR/a+zWjPaoRK+98MgLsHwa+CESEVSea4jk8FS0nYXBwriENhwjIKrlFlv6GEl2uHMrVzZmy14Q+9TDRmyfL79W0TCam1vaoIQVsFH0GUn/kTD4y2Das2RHm8Lu2ii1AJO5gxvndqwQo2tl2mZ9PjYUP8RbB2Pw/92rm4LN9S1ZsA==;
 5:d3VOrUTF0fGi824KAiCMALBOLf5+WyfWmqOFkoksVgy50r0W2AlFCM0pxjTIv5Y1GryqIkJG8Yao8oBhuDaAjKLcHM/velbP12Jl3lD/eLY6qPEQymDCZsflaGaR0FMiXkk7j+1/HxLXLhHI46PdSetkWWm7WJnYAasOmGheQfc=;
 7:ZzhAHMLMylqVc6+znoKcY9MBmhmk41X1hMswplH8wivLLd1Ake3REtVD3iRRG3eyIYXBYYdgBbkqdIwoWBqgOS5N7k/i8w74z6Cu8HzH8H021Vx4t+/9eBZLzw5p+5oaF3h+aikEBptGj3Pg7RCUYg==
x-ms-office365-filtering-correlation-id: 9caa14c0-b7f4-4cfb-4e76-08d660977499
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4852; 
x-ms-traffictypediagnostic: AM0PR04MB4852:
x-microsoft-antispam-prvs: <AM0PR04MB48526D88AFCD81C3F4E1F7BB80A00@AM0PR04MB4852.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4852; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4852; 
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(376002)(366004)(346002)(396003)(54534003)(199004)(189003)(53936002)(186003)(2616005)(2501003)(11346002)(71200400001)(44832011)(53946003)(4744004)(476003)(5640700003)(6506007)(3846002)(52116002)(71190400001)(66066001)(486006)(7736002)(305945005)(6116002)(575784001)(50226002)(14444005)(6486002)(8936002)(81166006)(14454004)(68736007)(81156014)(6436002)(8676002)(256004)(316002)(36756003)(86362001)(25786009)(54906003)(6512007)(26005)(106356001)(6916009)(76176011)(446003)(478600001)(386003)(2351001)(97736004)(2906002)(102836004)(105586002)(5660300001)(4326008)(99286004)(32563001)(473944003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4852;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wmhDTTMdhuS9aAprqEGUM93OoQpAVUI00Tk6VtPyKBT+WZbbUuuaK9brzR/XQkYhtVMz98ZtL4w8b/THrTd71mfKv3cspMW4cmDaSkGvOiis2lQHkozqlMUYv1SrlYhtR5RBpkscHFRDIESLKsSb+SYheE2TRaDJiVL9voIbBxP/FbhBOokOVXhdQtJw3JFM5ubAixp8ltnAImxaDs+vJycldy62P3iJKnPe3oJnrnoWqYmQjC7VdC4gAfWOI0nR6POqRcUSD5v/eDRNK40y421/YnRpJayflmYMgtLW7klrs7jUdHaSQoanXAAow1pJ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9caa14c0-b7f4-4cfb-4e76-08d660977499
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 01:08:13.5138 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4852
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_170910_084662_ABCC3DC5 
X-CRM114-Status: GOOD (  17.85  )
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

Add imx8qxp lpcg driver support

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v7->v10:
 * no changes
v6->v7:
 * use resource_size()
 * add kernel doc for structs
 * Include this after <linux/*> and before locals
 * remove MODULE_ macros
 * add suppress_bind_attrs
v6:
 * new patch, separate from scu gate driver
---
 drivers/clk/imx/Makefile           |   2 +-
 drivers/clk/imx/clk-imx8qxp-lpcg.c | 216 +++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk-imx8qxp-lpcg.h | 102 ++++++++++++++++++
 3 files changed, 319 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/clk-imx8qxp-lpcg.c
 create mode 100644 drivers/clk/imx/clk-imx8qxp-lpcg.h

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 4f72163..ba6521c 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -41,4 +41,4 @@ obj-$(CONFIG_SOC_IMX7ULP) += clk-imx7ulp.o
 obj-$(CONFIG_SOC_IMX8MQ) += clk-imx8mq.o
 obj-$(CONFIG_SOC_VF610)  += clk-vf610.o
 
-obj-$(CONFIG_SOC_IMX8QXP)	+= clk-imx8qxp.o
+obj-$(CONFIG_SOC_IMX8QXP) += clk-imx8qxp.o clk-imx8qxp-lpcg.o
diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8qxp-lpcg.c
new file mode 100644
index 0000000..dcae1dd
--- /dev/null
+++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
@@ -0,0 +1,216 @@
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
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "clk-scu.h"
+#include "clk-imx8qxp-lpcg.h"
+
+#include <dt-bindings/clock/imx8qxp-clock.h>
+
+/*
+ * struct imx8qxp_lpcg_data - Description of one LPCG clock
+ * @id: clock ID
+ * @name: clock name
+ * @parent: parent clock name
+ * @flags: common clock flags
+ * @offset: offset of this LPCG clock
+ * @bit_idx: bit index of this LPCG clock
+ * @hw_gate: whether supports HW autogate
+ *
+ * This structure describes one LPCG clock
+ */
+struct imx8qxp_lpcg_data {
+	int id;
+	char *name;
+	char *parent;
+	unsigned long flags;
+	u32 offset;
+	u8 bit_idx;
+	bool hw_gate;
+};
+
+/*
+ * struct imx8qxp_ss_lpcg - Description of one subsystem LPCG clocks
+ * @lpcg: LPCG clocks array of one subsystem
+ * @num_lpcg: the number of LPCG clocks
+ * @num_max: the maximum number of LPCG clocks
+ *
+ * This structure describes each subsystem LPCG clocks information
+ * which then will be used to create respective LPCGs clocks
+ */
+struct imx8qxp_ss_lpcg {
+	const struct imx8qxp_lpcg_data *lpcg;
+	u8 num_lpcg;
+	u8 num_max;
+};
+
+static const struct imx8qxp_lpcg_data imx8qxp_lpcg_adma[] = {
+	{ IMX8QXP_ADMA_LPCG_UART0_IPG_CLK, "uart0_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPUART_0_LPCG, 16, 0, },
+	{ IMX8QXP_ADMA_LPCG_UART0_BAUD_CLK, "uart0_lpcg_baud_clk", "uart0_clk", 0, ADMA_LPUART_0_LPCG, 0, 0, },
+	{ IMX8QXP_ADMA_LPCG_UART1_IPG_CLK, "uart1_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPUART_1_LPCG, 16, 0, },
+	{ IMX8QXP_ADMA_LPCG_UART1_BAUD_CLK, "uart1_lpcg_baud_clk", "uart1_clk", 0, ADMA_LPUART_1_LPCG, 0, 0, },
+	{ IMX8QXP_ADMA_LPCG_UART2_IPG_CLK, "uart2_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPUART_2_LPCG, 16, 0, },
+	{ IMX8QXP_ADMA_LPCG_UART2_BAUD_CLK, "uart2_lpcg_baud_clk", "uart2_clk", 0, ADMA_LPUART_2_LPCG, 0, 0, },
+	{ IMX8QXP_ADMA_LPCG_UART3_IPG_CLK, "uart3_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPUART_3_LPCG, 16, 0, },
+	{ IMX8QXP_ADMA_LPCG_UART3_BAUD_CLK, "uart3_lpcg_baud_clk", "uart3_clk", 0, ADMA_LPUART_3_LPCG, 0, 0, },
+	{ IMX8QXP_ADMA_LPCG_I2C0_IPG_CLK, "i2c0_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPI2C_0_LPCG, 16, 0, },
+	{ IMX8QXP_ADMA_LPCG_I2C0_CLK, "i2c0_lpcg_clk", "i2c0_clk", 0, ADMA_LPI2C_0_LPCG, 0, 0, },
+	{ IMX8QXP_ADMA_LPCG_I2C1_IPG_CLK, "i2c1_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPI2C_1_LPCG, 16, 0, },
+	{ IMX8QXP_ADMA_LPCG_I2C1_CLK, "i2c1_lpcg_clk", "i2c1_clk", 0, ADMA_LPI2C_1_LPCG, 0, 0, },
+	{ IMX8QXP_ADMA_LPCG_I2C2_IPG_CLK, "i2c2_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPI2C_2_LPCG, 16, 0, },
+	{ IMX8QXP_ADMA_LPCG_I2C2_CLK, "i2c2_lpcg_clk", "i2c2_clk", 0, ADMA_LPI2C_2_LPCG, 0, 0, },
+	{ IMX8QXP_ADMA_LPCG_I2C3_IPG_CLK, "i2c3_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPI2C_3_LPCG, 16, 0, },
+	{ IMX8QXP_ADMA_LPCG_I2C3_CLK, "i2c3_lpcg_clk", "i2c3_clk", 0, ADMA_LPI2C_3_LPCG, 0, 0, },
+};
+
+static const struct imx8qxp_ss_lpcg imx8qxp_ss_adma = {
+	.lpcg = imx8qxp_lpcg_adma,
+	.num_lpcg = ARRAY_SIZE(imx8qxp_lpcg_adma),
+	.num_max = IMX8QXP_ADMA_LPCG_CLK_END,
+};
+
+static const struct imx8qxp_lpcg_data imx8qxp_lpcg_conn[] = {
+	{ IMX8QXP_CONN_LPCG_SDHC0_PER_CLK, "sdhc0_lpcg_per_clk", "sdhc0_clk", 0, CONN_USDHC_0_LPCG, 0, 0, },
+	{ IMX8QXP_CONN_LPCG_SDHC0_IPG_CLK, "sdhc0_lpcg_ipg_clk", "conn_ipg_clk_root", 0, CONN_USDHC_0_LPCG, 16, 0, },
+	{ IMX8QXP_CONN_LPCG_SDHC0_HCLK, "sdhc0_lpcg_ahb_clk", "conn_axi_clk_root", 0, CONN_USDHC_0_LPCG, 20, 0, },
+	{ IMX8QXP_CONN_LPCG_SDHC1_PER_CLK, "sdhc1_lpcg_per_clk", "sdhc1_clk", 0, CONN_USDHC_1_LPCG, 0, 0, },
+	{ IMX8QXP_CONN_LPCG_SDHC1_IPG_CLK, "sdhc1_lpcg_ipg_clk", "conn_ipg_clk_root", 0, CONN_USDHC_1_LPCG, 16, 0, },
+	{ IMX8QXP_CONN_LPCG_SDHC1_HCLK, "sdhc1_lpcg_ahb_clk", "conn_axi_clk_root", 0, CONN_USDHC_1_LPCG, 20, 0, },
+	{ IMX8QXP_CONN_LPCG_SDHC2_PER_CLK, "sdhc2_lpcg_per_clk", "sdhc2_clk", 0, CONN_USDHC_2_LPCG, 0, 0, },
+	{ IMX8QXP_CONN_LPCG_SDHC2_IPG_CLK, "sdhc2_lpcg_ipg_clk", "conn_ipg_clk_root", 0, CONN_USDHC_2_LPCG, 16, 0, },
+	{ IMX8QXP_CONN_LPCG_SDHC2_HCLK, "sdhc2_lpcg_ahb_clk", "conn_axi_clk_root", 0, CONN_USDHC_2_LPCG, 20, 0, },
+	{ IMX8QXP_CONN_LPCG_ENET0_ROOT_CLK, "enet0_ipg_root_clk", "enet0_clk", 0, CONN_ENET_0_LPCG, 0, 0, },
+	{ IMX8QXP_CONN_LPCG_ENET0_TX_CLK, "enet0_tx_clk", "enet0_clk", 0, CONN_ENET_0_LPCG, 4, 0, },
+	{ IMX8QXP_CONN_LPCG_ENET0_AHB_CLK, "enet0_ahb_clk", "conn_axi_clk_root", 0, CONN_ENET_0_LPCG, 8, 0, },
+	{ IMX8QXP_CONN_LPCG_ENET0_IPG_S_CLK, "enet0_ipg_s_clk", "conn_ipg_clk_root", 0, CONN_ENET_0_LPCG, 20, 0, },
+	{ IMX8QXP_CONN_LPCG_ENET0_IPG_CLK, "enet0_ipg_clk", "enet0_ipg_s_clk", 0, CONN_ENET_0_LPCG, 16, 0, },
+	{ IMX8QXP_CONN_LPCG_ENET1_ROOT_CLK, "enet1_ipg_root_clk", "enet1_clk", 0, CONN_ENET_1_LPCG, 0, 0, },
+	{ IMX8QXP_CONN_LPCG_ENET1_TX_CLK, "enet1_tx_clk", "enet1_clk", 0, CONN_ENET_1_LPCG, 4, 0, },
+	{ IMX8QXP_CONN_LPCG_ENET1_AHB_CLK, "enet1_ahb_clk", "conn_axi_clk_root", 0, CONN_ENET_1_LPCG, 8, 0, },
+	{ IMX8QXP_CONN_LPCG_ENET1_IPG_S_CLK, "enet1_ipg_s_clk", "conn_ipg_clk_root", 0, CONN_ENET_1_LPCG, 20, 0, },
+	{ IMX8QXP_CONN_LPCG_ENET1_IPG_CLK, "enet1_ipg_clk", "enet0_ipg_s_clk", 0, CONN_ENET_1_LPCG, 16, 0, },
+};
+
+static const struct imx8qxp_ss_lpcg imx8qxp_ss_conn = {
+	.lpcg = imx8qxp_lpcg_conn,
+	.num_lpcg = ARRAY_SIZE(imx8qxp_lpcg_conn),
+	.num_max = IMX8QXP_CONN_LPCG_CLK_END,
+};
+
+static const struct imx8qxp_lpcg_data imx8qxp_lpcg_lsio[] = {
+	{ IMX8QXP_LSIO_LPCG_PWM0_IPG_CLK, "pwm0_lpcg_ipg_clk", "pwm0_clk", 0, LSIO_PWM_0_LPCG, 0, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM0_IPG_HF_CLK, "pwm0_lpcg_ipg_hf_clk", "pwm0_clk", 0, LSIO_PWM_0_LPCG, 4, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM0_IPG_S_CLK, "pwm0_lpcg_ipg_s_clk", "pwm0_clk", 0, LSIO_PWM_0_LPCG, 16, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM0_IPG_SLV_CLK, "pwm0_lpcg_ipg_slv_clk", "lsio_bus_clk_root", 0, LSIO_PWM_0_LPCG, 20, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM0_IPG_MSTR_CLK, "pwm0_lpcg_ipg_mstr_clk", "pwm0_clk", 0, LSIO_PWM_0_LPCG, 24, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM1_IPG_CLK, "pwm1_lpcg_ipg_clk", "pwm1_clk", 0, LSIO_PWM_1_LPCG, 0, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM1_IPG_HF_CLK, "pwm1_lpcg_ipg_hf_clk", "pwm1_clk", 0, LSIO_PWM_1_LPCG, 4, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM1_IPG_S_CLK, "pwm1_lpcg_ipg_s_clk", "pwm1_clk", 0, LSIO_PWM_1_LPCG, 16, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM1_IPG_SLV_CLK, "pwm1_lpcg_ipg_slv_clk", "lsio_bus_clk_root", 0, LSIO_PWM_1_LPCG, 20, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM1_IPG_MSTR_CLK, "pwm1_lpcg_ipg_mstr_clk", "pwm1_clk", 0, LSIO_PWM_1_LPCG, 24, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM2_IPG_CLK, "pwm2_lpcg_ipg_clk", "pwm2_clk", 0, LSIO_PWM_2_LPCG, 0, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM2_IPG_HF_CLK, "pwm2_lpcg_ipg_hf_clk", "pwm2_clk", 0, LSIO_PWM_2_LPCG, 4, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM2_IPG_S_CLK, "pwm2_lpcg_ipg_s_clk", "pwm2_clk", 0, LSIO_PWM_2_LPCG, 16, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM2_IPG_SLV_CLK, "pwm2_lpcg_ipg_slv_clk", "lsio_bus_clk_root", 0, LSIO_PWM_2_LPCG, 20, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM2_IPG_MSTR_CLK, "pwm2_lpcg_ipg_mstr_clk", "pwm2_clk", 0, LSIO_PWM_2_LPCG, 24, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM3_IPG_CLK, "pwm3_lpcg_ipg_clk", "pwm3_clk", 0, LSIO_PWM_3_LPCG, 0, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM3_IPG_HF_CLK, "pwm3_lpcg_ipg_hf_clk", "pwm3_clk", 0, LSIO_PWM_3_LPCG, 4, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM3_IPG_S_CLK, "pwm3_lpcg_ipg_s_clk", "pwm3_clk", 0, LSIO_PWM_3_LPCG, 16, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM3_IPG_SLV_CLK, "pwm3_lpcg_ipg_slv_clk", "lsio_bus_clk_root", 0, LSIO_PWM_3_LPCG, 20, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM3_IPG_MSTR_CLK, "pwm3_lpcg_ipg_mstr_clk", "pwm3_clk", 0, LSIO_PWM_3_LPCG, 24, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM4_IPG_CLK, "pwm4_lpcg_ipg_clk", "pwm4_clk", 0, LSIO_PWM_4_LPCG, 0, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM4_IPG_HF_CLK, "pwm4_lpcg_ipg_hf_clk", "pwm4_clk", 0, LSIO_PWM_4_LPCG, 4, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM4_IPG_S_CLK, "pwm4_lpcg_ipg_s_clk", "pwm4_clk", 0, LSIO_PWM_4_LPCG, 16, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM4_IPG_SLV_CLK, "pwm4_lpcg_ipg_slv_clk", "lsio_bus_clk_root", 0, LSIO_PWM_4_LPCG, 20, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM4_IPG_MSTR_CLK, "pwm4_lpcg_ipg_mstr_clk", "pwm4_clk", 0, LSIO_PWM_4_LPCG, 24, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM5_IPG_CLK, "pwm5_lpcg_ipg_clk", "pwm5_clk", 0, LSIO_PWM_5_LPCG, 0, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM5_IPG_HF_CLK, "pwm5_lpcg_ipg_hf_clk", "pwm5_clk", 0, LSIO_PWM_5_LPCG, 4, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM5_IPG_S_CLK, "pwm5_lpcg_ipg_s_clk", "pwm5_clk", 0, LSIO_PWM_5_LPCG, 16, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM5_IPG_SLV_CLK, "pwm5_lpcg_ipg_slv_clk", "lsio_bus_clk_root", 0, LSIO_PWM_5_LPCG, 20, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM5_IPG_MSTR_CLK, "pwm5_lpcg_ipg_mstr_clk", "pwm5_clk", 0, LSIO_PWM_5_LPCG, 24, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM6_IPG_CLK, "pwm6_lpcg_ipg_clk", "pwm6_clk", 0, LSIO_PWM_6_LPCG, 0, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM6_IPG_HF_CLK, "pwm6_lpcg_ipg_hf_clk", "pwm6_clk", 0, LSIO_PWM_6_LPCG, 4, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM6_IPG_S_CLK, "pwm6_lpcg_ipg_s_clk", "pwm6_clk", 0, LSIO_PWM_6_LPCG, 16, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM6_IPG_SLV_CLK, "pwm6_lpcg_ipg_slv_clk", "lsio_bus_clk_root", 0, LSIO_PWM_6_LPCG, 20, 0, },
+	{ IMX8QXP_LSIO_LPCG_PWM6_IPG_MSTR_CLK, "pwm6_lpcg_ipg_mstr_clk", "pwm6_clk", 0, LSIO_PWM_6_LPCG, 24, 0, },
+};
+
+static const struct imx8qxp_ss_lpcg imx8qxp_ss_lsio = {
+	.lpcg = imx8qxp_lpcg_lsio,
+	.num_lpcg = ARRAY_SIZE(imx8qxp_lpcg_lsio),
+	.num_max = IMX8QXP_LSIO_LPCG_CLK_END,
+};
+
+static int imx8qxp_lpcg_clk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct clk_hw_onecell_data *clk_data;
+	const struct imx8qxp_ss_lpcg *ss_lpcg;
+	const struct imx8qxp_lpcg_data *lpcg;
+	struct resource *res;
+	struct clk_hw **clks;
+	void __iomem *base;
+	int i;
+
+	ss_lpcg = of_device_get_match_data(dev);
+	if (!ss_lpcg)
+		return -ENODEV;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!base)
+		return -ENOMEM;
+
+	clk_data = devm_kzalloc(&pdev->dev, struct_size(clk_data, hws,
+				ss_lpcg->num_max), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
+	clk_data->num = ss_lpcg->num_max;
+	clks = clk_data->hws;
+
+	for (i = 0; i < ss_lpcg->num_lpcg; i++) {
+		lpcg = ss_lpcg->lpcg + i;
+		clks[lpcg->id] = imx_clk_lpcg_scu(lpcg->name, lpcg->parent,
+						  lpcg->flags, base + lpcg->offset,
+						  lpcg->bit_idx, lpcg->hw_gate);
+	}
+
+	for (i = 0; i < clk_data->num; i++) {
+		if (IS_ERR(clks[i]))
+			pr_warn("i.MX clk %u: register failed with %ld\n",
+				i, PTR_ERR(clks[i]));
+	}
+
+	return of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
+}
+
+static const struct of_device_id imx8qxp_lpcg_match[] = {
+	{ .compatible = "fsl,imx8qxp-lpcg-adma", &imx8qxp_ss_adma, },
+	{ .compatible = "fsl,imx8qxp-lpcg-conn", &imx8qxp_ss_conn, },
+	{ .compatible = "fsl,imx8qxp-lpcg-lsio", &imx8qxp_ss_lsio, },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver imx8qxp_lpcg_clk_driver = {
+	.driver = {
+		.name = "imx8qxp-lpcg-clk",
+		.of_match_table = imx8qxp_lpcg_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = imx8qxp_lpcg_clk_probe,
+};
+
+builtin_platform_driver(imx8qxp_lpcg_clk_driver);
diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.h b/drivers/clk/imx/clk-imx8qxp-lpcg.h
new file mode 100644
index 0000000..2a37ce5
--- /dev/null
+++ b/drivers/clk/imx/clk-imx8qxp-lpcg.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2018 NXP
+ *   Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#ifndef _IMX8QXP_LPCG_H
+#define _IMX8QXP_LPCG_H
+
+/*LSIO SS */
+#define LSIO_PWM_0_LPCG			0x00000
+#define LSIO_PWM_1_LPCG			0x10000
+#define LSIO_PWM_2_LPCG			0x20000
+#define LSIO_PWM_3_LPCG			0x30000
+#define LSIO_PWM_4_LPCG			0x40000
+#define LSIO_PWM_5_LPCG			0x50000
+#define LSIO_PWM_6_LPCG			0x60000
+#define LSIO_PWM_7_LPCG			0x70000
+#define LSIO_GPIO_0_LPCG		0x80000
+#define LSIO_GPIO_1_LPCG		0x90000
+#define LSIO_GPIO_2_LPCG		0xa0000
+#define LSIO_GPIO_3_LPCG		0xb0000
+#define LSIO_GPIO_4_LPCG		0xc0000
+#define LSIO_GPIO_5_LPCG		0xd0000
+#define LSIO_GPIO_6_LPCG		0xe0000
+#define LSIO_GPIO_7_LPCG		0xf0000
+#define LSIO_FSPI_0_LPCG		0x120000
+#define LSIO_FSPI_1_LPCG		0x130000
+#define LSIO_GPT_0_LPCG			0x140000
+#define LSIO_GPT_1_LPCG			0x150000
+#define LSIO_GPT_2_LPCG			0x160000
+#define LSIO_GPT_3_LPCG			0x170000
+#define LSIO_GPT_4_LPCG			0x180000
+#define LSIO_OCRAM_LPCG			0x190000
+#define LSIO_KPP_LPCG			0x1a0000
+#define LSIO_ROMCP_LPCG			0x100000
+
+/* Connectivity SS */
+#define CONN_USDHC_0_LPCG		0x00000
+#define CONN_USDHC_1_LPCG		0x10000
+#define CONN_USDHC_2_LPCG		0x20000
+#define CONN_ENET_0_LPCG		0x30000
+#define CONN_ENET_1_LPCG		0x40000
+#define CONN_DTCP_LPCG			0x50000
+#define CONN_MLB_LPCG			0x60000
+#define CONN_USB_2_LPCG			0x70000
+#define CONN_USB_3_LPCG			0x80000
+#define CONN_NAND_LPCG			0x90000
+#define CONN_EDMA_LPCG			0xa0000
+
+/* ADMA SS */
+#define ADMA_ASRC_0_LPCG		0x400000
+#define ADMA_ESAI_0_LPCG		0x410000
+#define ADMA_SPDIF_0_LPCG		0x420000
+#define ADMA_SAI_0_LPCG			0x440000
+#define ADMA_SAI_1_LPCG			0x450000
+#define ADMA_SAI_2_LPCG			0x460000
+#define ADMA_SAI_3_LPCG			0x470000
+#define ADMA_GPT_5_LPCG			0x4b0000
+#define ADMA_GPT_6_LPCG			0x4c0000
+#define ADMA_GPT_7_LPCG			0x4d0000
+#define ADMA_GPT_8_LPCG			0x4e0000
+#define ADMA_GPT_9_LPCG			0x4f0000
+#define ADMA_GPT_10_LPCG		0x500000
+#define ADMA_HIFI_LPCG			0x580000
+#define ADMA_OCRAM_LPCG			0x590000
+#define ADMA_EDMA_0_LPCG		0x5f0000
+#define ADMA_ASRC_1_LPCG		0xc00000
+#define ADMA_SAI_4_LPCG			0xc20000
+#define ADMA_SAI_5_LPCG			0xc30000
+#define ADMA_AMIX_LPCG			0xc40000
+#define ADMA_MQS_LPCG			0xc50000
+#define ADMA_ACM_LPCG			0xc60000
+#define ADMA_REC_CLK0_LPCG		0xd00000
+#define ADMA_REC_CLK1_LPCG		0xd10000
+#define ADMA_PLL_CLK0_LPCG		0xd20000
+#define ADMA_PLL_CLK1_LPCG		0xd30000
+#define ADMA_MCLKOUT0_LPCG		0xd50000
+#define ADMA_MCLKOUT1_LPCG		0xd60000
+#define ADMA_EDMA_1_LPCG		0xdf0000
+#define ADMA_LPSPI_0_LPCG		0x1400000
+#define ADMA_LPSPI_1_LPCG		0x1410000
+#define ADMA_LPSPI_2_LPCG		0x1420000
+#define ADMA_LPSPI_3_LPCG		0x1430000
+#define ADMA_LPUART_0_LPCG		0x1460000
+#define ADMA_LPUART_1_LPCG		0x1470000
+#define ADMA_LPUART_2_LPCG		0x1480000
+#define ADMA_LPUART_3_LPCG		0x1490000
+#define ADMA_LCD_LPCG			0x1580000
+#define ADMA_PWM_LPCG			0x1590000
+#define ADMA_LPI2C_0_LPCG		0x1c00000
+#define ADMA_LPI2C_1_LPCG		0x1c10000
+#define ADMA_LPI2C_2_LPCG		0x1c20000
+#define ADMA_LPI2C_3_LPCG		0x1c30000
+#define ADMA_ADC_0_LPCG			0x1c80000
+#define ADMA_FTM_0_LPCG			0x1ca0000
+#define ADMA_FTM_1_LPCG			0x1cb0000
+#define ADMA_FLEXCAN_0_LPCG		0x1cd0000
+#define ADMA_FLEXCAN_1_LPCG		0x1ce0000
+#define ADMA_FLEXCAN_2_LPCG		0x1cf0000
+
+#endif /* _IMX8QXP_LPCG_H */
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
