Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64EFC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:43:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 664D220879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EFv2W0pO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o1OnrPHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664D220879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xM920BggMihUvwpsrt9WlECb/BJ+Gn7QXsqKQ2TgQd0=; b=EFv2W0pO2HOK5M
	jbzaXYXM2llnmTv/uc+oIUUc7FIoDzb+J8kEfWx48WgghKxUzhkugI+S78pP3vey4tQzycJLljFbF
	EMbAF93nmNFwEBkQ/HeJDEix9Nawv5ulDsycHpIpq6aS4hDfubT1/GP9dbxtisZrYrZWSXCBQU2Y1
	kmMc0OwZaTuaWKtuAhJu2HPg1qiiYugq7zpquqbaMuNQSGwbd80AgVjMXt03C0rv5gmJVrXDX6ts2
	VVw0sm/MgduX1jvHpEe3enJJdpdVGwi1VuCFiVI0a/WPEtY7/dm1ghHPubPRJ6W5HeyTNZDP+eZ06
	wtVXIn0wViK0IhuRDZtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXT98-0008Or-40; Thu, 13 Dec 2018 15:43:30 +0000
Received: from mail-eopbgr70085.outbound.protection.outlook.com ([40.107.7.85]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXT8i-0007xM-NU
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 15:43:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHV9FbUxQ1DjKXC7n7OhKg/jPqCDJBc1IypfSqL/iDg=;
 b=o1OnrPHR5rwVWQhoB7z9BoMy9hphMmPz8jsvQsNw6NZAYTJAxN9/7tToxP0Am7jd11ZcB3bFV3YtIG5Wwfhpp2nts7KOfAoRFF5018S/TiZoeLrH2J/ZG692hoiiipeMCule9pCBXSR4zu6NQZCsD5QyrUOIdQpaWbL1/HwEzsU=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5843.eurprd04.prod.outlook.com (20.178.118.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Thu, 13 Dec 2018 15:42:50 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Thu, 13 Dec 2018
 15:42:50 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH V12 1/5] clk: imx: add configuration option for mmio clks
Thread-Topic: [PATCH V12 1/5] clk: imx: add configuration option for mmio clks
Thread-Index: AQHUkvqAhS9Chp4YBUKBhWLvXgDNIQ==
Date: Thu, 13 Dec 2018 15:42:50 +0000
Message-ID: <1544715442-8902-2-git-send-email-aisheng.dong@nxp.com>
References: <1544715442-8902-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1544715442-8902-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0086.apcprd04.prod.outlook.com
 (2603:1096:202:15::30) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5843;
 6:NbvNd1SDZTnu2+DAygYpto1VknJI/GT2prncUA+N25Dsil+t8sJwBXFwoaORpDKzjhabip9LaYIgrRBnARW3VI0xFiOKnISW29/bD7TDDosOGJO2pEeHuLB2ZocWpdx3KHMrRJNqR4epJs9ewgbzCJpOiQD4F2Vp2D4c/d2trpJtU6RvZks7r8KYoNmu8E41xBH8nHJPvGbvOPcmoWzB3UjdnRa6DZMlVlDfG/HeiOm9l0Zmdo6iCIHnThTZmbLWIxCtKzIEG4eaIzmP9UNseQPGwlVz0l9RHDrmU2Ny+S3cGeQZqXu8Tr2z4d3NB5VYVmQIckXgJucW6pdJ+z5FnANC6ZDRaKS/2ZpPrOeuQBP3sYile6TgsEef+69weBA4oc89OHYompZVa70M8avm/SXwqbp4n18Nt0mpEUlnJ/iDpckgq06jsUOJy6wwp4c/3jDP3uAhBFh33sz02jCCCw==;
 5:cTQ2nEdmfgt7s7EMQ0wdF8tJgmYYAQNxLo1HR26A9DlraxW8Yc/y8f7vzm4qnZ5wMcx5pgUfbKyEDhEfzst1my829oQ0+qJTzk0+vv/mOAo4/HPnajpleb/D/RkUVlRqDek6+6j1h7upaNzjXihp2w9GTWca7Fg4DNDVN0AnkPA=;
 7:MlhS6Mmq2yO3Epyo5oxEjalwd75XIxP6P5wSTNIriYvhKsCUb2WYmN16zUJuPljWYBG/F9XcCnYfXypuo3iE7qqw/xaBbwR1LDWjXNPa6uxopb5YF1aWjl8b19olPAPv+wHyTJg2NOkQI2/eTSIzUQ==
x-ms-office365-filtering-correlation-id: c06c2daf-516d-4151-154e-08d66111a33c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5843; 
x-ms-traffictypediagnostic: AM0PR04MB5843:
x-microsoft-antispam-prvs: <AM0PR04MB584324788FC47A17BAC7C76C80A00@AM0PR04MB5843.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5843; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5843; 
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(376002)(136003)(346002)(366004)(199004)(189003)(71190400001)(71200400001)(6916009)(6436002)(6486002)(97736004)(478600001)(14454004)(54906003)(4326008)(256004)(44832011)(5640700003)(8676002)(106356001)(105586002)(2351001)(25786009)(8936002)(316002)(36756003)(81166006)(81156014)(2616005)(11346002)(53936002)(476003)(486006)(446003)(2906002)(50226002)(68736007)(7736002)(99286004)(76176011)(2501003)(305945005)(5660300001)(52116002)(3846002)(6116002)(186003)(86362001)(575784001)(6512007)(102836004)(66066001)(386003)(26005)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5843;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HCT/U442UOjDEp0d7IXCm8d36ey00KZUiwLHeC5HMZBqmdEdgZFBCPElKumxQD8Sx4Yx0seuJkh5Rnl0m+ZmyG+7dHRIVTOeXBu8Bk7lCjRTBycyUSXnbl4isK0FaOthDaaWnQ1+Blq9SBBczs9e/4+p01DgSb+OSy0NmbkAwbER5zASHXMPmJW8a2WHszcbdQjtBvs69WQ6iSyFOh/+JRGCwqo/j/CLPO4i0lwb8C1WNjIm97X4z6ztHBFfqWRV9njLZMDGWlALm1B3Qll74dVHbL9v56z1dT/Y07wg+RJZPB0kfu4uJazmjT/DIbhQ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c06c2daf-516d-4151-154e-08d66111a33c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 15:42:50.4268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5843
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_074305_202000_C03CCDF1 
X-CRM114-Status: GOOD (  16.26  )
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
v11->v12:
 * make MXC_CLK a simple def_bool of ARCH_MXC (remove IMX8MQ dependency)
   In the future, we will make MXC_CLK selectable after transition.
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
index 0000000..bdd85b89
--- /dev/null
+++ b/drivers/clk/imx/Kconfig
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+# common clock support for NXP i.MX SoC family.
+config MXC_CLK
+	bool
+	def_bool ARCH_MXC
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
