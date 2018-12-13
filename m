Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9B1C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:08:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E294620811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G2rgGt8J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C87cBvgc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E294620811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=muqLdFpo+DOCCg1Ys7kvG9NCVTFJ6Bcsd0qRuN4UZe4=; b=G2rgGt8JNT/dbE
	pJum4pcQcPs/FP3Q2de92ZWVLZIMGd2QVSwIVHyLpYgtWo4atkua3nGAuoDo7AyIz+azOcleKpAx9
	tTkV14daDV0wIJ0xOHwHI2ktCuTIHlfpiaHNv/DNC8Hf6UhzS7G4vJDsCvfsiOTz1CMKCuX9RbonA
	ksMeF/nOpU1gEU0Diyk8S1s3nMTKUfMLVn9vfePb567EEzFi15Lr/z5D2PRcnwhaEyKL1YZMON+WL
	3MmIRFKOjiC4XyVkEfrkQx4Wsk8PL1nJVPX+gescyk/po8OzDYVvIZZbPDgQWtRqMZLlz5OxackQx
	4UJxKK5lez880SsA37cA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXFUC-0004Sc-Ng; Thu, 13 Dec 2018 01:08:20 +0000
Received: from mail-eopbgr150055.outbound.protection.outlook.com
 ([40.107.15.55] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXFTx-0004Dx-Po
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 01:08:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0doExu2QuZqTtgqAYl7O6u99KG7TaLXDBS6SHyLE7g=;
 b=C87cBvgc7wPZM0KnOFg2Qk20OGx+4TX+BeEk/S/43/2S1BpDqjxd4m5YeJVNJdncLGCjP/KwtFFBihhz3Ub8hN3hwfZGFrU97pwDlHQzE05cVTeUr1bXeH1p/++oxDIbX2e9/Sig04YKOl6yFPPjzrdWdY5dJZbV64TmIU2+Ngc=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4308.eurprd04.prod.outlook.com (52.134.126.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Thu, 13 Dec 2018 01:07:52 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Thu, 13 Dec 2018
 01:07:52 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH V11 1/7] clk: imx: add configuration option for mmio clks
Thread-Topic: [PATCH V11 1/7] clk: imx: add configuration option for mmio clks
Thread-Index: AQHUkoBFxXjd98YyekOIqi1bO3Y7gw==
Date: Thu, 13 Dec 2018 01:07:52 +0000
Message-ID: <1544662938-5020-2-git-send-email-aisheng.dong@nxp.com>
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
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4308;
 6:KCi6+uum4/GTizTp7tR+zy8UIoWQAfGNQ45m7dSsi4Rih/dJF9RgkkoRXt13f/6p8A+JiCTwc9pyabCEvKIU0nQqIOPyN4yYtVBF0Ktyzyswvs52ae7UltMg49UbUvss3Ew1N97dDv2UONv38VjWVPD2BgJR+L6Gi+zGpP4LfLL4CZNBlzoFqzWBEfdpNg/A+cjLWVgJbXcLFGH97lkZ6Wi+B7Ak/kda3X8HlXEuLYPU1NISUFynoHQFbcLQSPljNUv2WoEsrcFwJH2lRjLZzErK1mcVjofi7MwrL/+JPtS6b2qU6nnv+7ebakbkNNtgNeQNbYsdzC3ZFNY2o7hi5YsvluUREkwhmOVGcpzg+0ASpxwLAw+1VtH1ddZ7sfyDA/AZ10osrHv4SalsiuutvtSGr3aJVVAQX2XF5SU3ZXvPF6zsIgRGB+lqfaGXchpsk7ZKO8xX+JLZENlIodR6FQ==;
 5:rZmnpAVnQKwoGFfuo5tf7Rp1MeN7gLdb+sx0vT6vVEJWaavU5UAltNl1EnhMKoK3HLCrRdIVszd0SDZ9gicQq+niCVKZ5+WR+QvKOomvAhHOpIwPej2QuiNN7/RSFzUAWl5dkqMRSFz9Sh6RXAAnQ1PZrR6Fb+cBUeqXNmmsSHU=;
 7:FlTi8Ne9aVftsyA0TiNokbZyyO44MRtUFcPrrxddULXWDyJSJX7bb/eTnKV4l34HuLCVUem5eF7SnNW1UZMa1a0aS+FCr42fmO5YCxzi9eV5Qniti7mXoe6LleAlVVWHAYTmZ+jjen/rqFbtuU84xw==
x-ms-office365-filtering-correlation-id: dffdfff8-f2ba-479a-5d51-08d6609767e5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4308; 
x-ms-traffictypediagnostic: AM0PR04MB4308:
x-microsoft-antispam-prvs: <AM0PR04MB4308B5001BDA508E2DA282D080A00@AM0PR04MB4308.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4308; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4308; 
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(346002)(396003)(366004)(39860400002)(376002)(199004)(189003)(105586002)(106356001)(97736004)(76176011)(102836004)(6506007)(386003)(26005)(52116002)(2351001)(186003)(4326008)(2501003)(66066001)(6512007)(5660300001)(53936002)(7736002)(305945005)(316002)(54906003)(6916009)(478600001)(99286004)(44832011)(25786009)(36756003)(6436002)(6486002)(5640700003)(68736007)(256004)(476003)(486006)(71190400001)(71200400001)(3846002)(6116002)(2906002)(14454004)(81166006)(8676002)(50226002)(8936002)(86362001)(575784001)(11346002)(446003)(81156014)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4308;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SBuX+c7CTLmH1iwidCZr3eeGW8YRD9/h/Jp3r3xeGvSuHTo2Ocx1wmvHodNyb38015hc0QCld5QWnpurwjcanYXTPhVaPqI8kjD1amDA5BaHO1N3xJ9YRvnpnLAGzuMFtBTMG8Eb9+o+rN1loz8aNAO8ZuQnnxhJDQ7Zq78/P+gbx6pWDhfEltE/yrkIphakiuDuEWw0uVHzgcpEsubiDyG0bB/adYSr6MDQUdiw689UVowyZUyTPctzDUSTm1/IhK7iva+dd6zJ4fnly4FMy/5gfhOIhOauK2oxbOhiYsICuypRAg92Y1SXn4dWWq8N
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dffdfff8-f2ba-479a-5d51-08d6609767e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 01:07:52.2209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4308
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_170805_833406_374B9735 
X-CRM114-Status: GOOD (  15.92  )
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

The patch introduces CONFIG_MXC_CLK option for legacy MMIO clocks,
this is required to compile legacy MMIO clock conditionally when adding
SCU based clocks for MX8 platforms later.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v10->v11:
 * break the dependency on the arch Kconfig
v1->v10: no changes
---
 drivers/clk/Kconfig      | 1 +
 drivers/clk/Makefile     | 2 +-
 drivers/clk/imx/Kconfig  | 5 +++++
 drivers/clk/imx/Makefile | 2 +-
 4 files changed, 8 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/imx/Kconfig

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 2dc12bf..d2f0bb5 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -294,6 +294,7 @@ source "drivers/clk/actions/Kconfig"
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
 source "drivers/clk/imgtec/Kconfig"
+source "drivers/clk/imx/Kconfig"
 source "drivers/clk/ingenic/Kconfig"
 source "drivers/clk/keystone/Kconfig"
 source "drivers/clk/mediatek/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index a47430b..8a9440a 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -72,7 +72,7 @@ obj-$(CONFIG_ARCH_DAVINCI)		+= davinci/
 obj-$(CONFIG_H8300)			+= h8300/
 obj-$(CONFIG_ARCH_HISI)			+= hisilicon/
 obj-y					+= imgtec/
-obj-$(CONFIG_ARCH_MXC)			+= imx/
+obj-y					+= imx/
 obj-y					+= ingenic/
 obj-$(CONFIG_ARCH_K3)			+= keystone/
 obj-$(CONFIG_ARCH_KEYSTONE)		+= keystone/
diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
new file mode 100644
index 0000000..37478ba
--- /dev/null
+++ b/drivers/clk/imx/Kconfig
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+# common clock support for NXP i.MX SoC family.
+config MXC_CLK
+	bool
+	def_bool (ARCH_MXC && !ARM64) || (ARCH_MXC && ARM64 && SOC_IMX8MQ)
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 5c0b11e..f850424 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y += \
+obj-$(CONFIG_MXC_CLK) += \
 	clk.o \
 	clk-busy.o \
 	clk-composite-8m.o \
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
