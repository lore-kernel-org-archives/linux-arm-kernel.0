Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D66C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:40:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC83B20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="df9/tdlf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="w5DxtiWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC83B20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xoSus7pinvRerjwXTFdHtNXMUuh07UT1zJo47IO8mWI=; b=df9/tdlfUEav7m
	E3lW0CsepadhzvNkGxFUuRQ2Ye3XdmnXe/SQY49Ay/fKhRxcfENgdgWKqTlmyILZ7X+pNLHCf0J08
	DOWdxYS9xXlOUgklz4C0lXfNu38RVNncrDtU9AvG4I90uD42GTUIfD8N5VLh+0t9nJ1PQsNQ1/e7e
	N0TDNWMxA5lve3jdEh7IDTsN1+qWBPw5r88kTklDgp6EPBAje42n66NzjwEO40p7R+lBf6afd6F75
	eS09xYSINxjgVj4OaPlx7IhJDN8lMBaCCGBsW2LicImiQ0TC0wrt2jxXeCVj/xcbuDX+5RvRtjq3G
	h9aAJvOw7ksq1jEVowow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUBrs-0003aC-K8; Tue, 04 Dec 2018 14:40:08 +0000
Received: from mail-eopbgr10081.outbound.protection.outlook.com ([40.107.1.81]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBrM-0002oB-Lf
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:39:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mY1s2WjvTWYBmLcg60w2n1wXtmarG1YmrCjKLUsKrO0=;
 b=w5DxtiWHbj4+M0ZtemPLjga0ClfCOJQQxqHgEhc3FkJbBX5XZ1KYAxq7jJJzuVK0bODLWS74OIvrvEvSa6Ps+R7M0vvgpH64QSqk7FE3ggVdikDw/G/wFmRUH4BPQ/pbkCuQr2/q9M4E8jqGRYUyJJzHZCFLFd0G0VsqE1HahJQ=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5763.eurprd04.prod.outlook.com (20.178.202.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.21; Tue, 4 Dec 2018 14:39:22 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1382.023; Tue, 4 Dec 2018
 14:39:22 +0000
From: Aisheng DONG <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH V9 1/7] clk: imx: add configuration option for mmio clks
Thread-Topic: [PATCH V9 1/7] clk: imx: add configuration option for mmio clks
Thread-Index: AQHUi98lQ6o73Estskm1k5h96wz2og==
Date: Tue, 4 Dec 2018 14:39:22 +0000
Message-ID: <1543934041-12572-2-git-send-email-aisheng.dong@nxp.com>
References: <1543934041-12572-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1543934041-12572-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::27) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5763;
 6:eu4KIusBXKmokaOdst3vLUIxeGpibWOjwp5n1psUjNN9rAJW/Nq+wfhwEEKzz6ne2VTDEXemmVkwAQPf9Y9lRT/cgqp8oktvfVu22MEnLXRb2BlbxyTlv2FkLGxvCVCmmGDla1KrvmK/uYfjowQbAtgJlXoeFbK6K/ao88KtlmCbjx/ruCkbIRNkvSRUu+uM6C0kb9Y5QKC45JS3BZT0FAeccbFTPErMHe2B0F++rX1m9Z1U9EmbhIfo4GBgSJq4t1G4taX/WML9Rh5ZrYNmxiNQxEWQS24rHR9fOMDc1xr3B9A3WUvbWujc50sm5gmZkGcYF4BsAc0AJVI7pxlcpeYQOaJlIeFpnqoycy70hY7VuPhhl8ZN9FSlCwo4pRPB0OBmWo6pXQO+bZr22hHZ0DgCMjv3DaFeHH8dZA0enKpiBEYFqp1f7/UxADaIDWSHX9KC2jxpGFSkdxt+PiJHYg==;
 5:DryZlZ2L41XSvObdoflMZS/M7H0pqS8NwhHPqEKzA/wPBrQ3CRxHNeizDwIL1XGtWssjtSbs0bRl0esxmN29XcrC4njXcj9kNATwcO4N/Ge/PFi4ate1pThtTuTZjxUbXJorKxI9SM7sp3/zgxYpzLAnRIBtbowrg3G5QHzC/OE=;
 7:tPK0XwqBvShWyLsnfZIS8ZksHk3w5QNdjGGnC6HWgSgDAfNoVGeZ6HpdI/jHTKfqFmaAoyqJpaQVXzFfOmBpl7v0EcuRQVg3UpRWKt6ntAnYY2BcFbMa1kS+fMKdT1IkKgxfBjzBIzhjp/c4pIesag==
x-ms-office365-filtering-correlation-id: 72c8a71e-6cfa-446c-88ed-08d659f647b3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5763; 
x-ms-traffictypediagnostic: AM0PR04MB5763:
x-microsoft-antispam-prvs: <AM0PR04MB5763F272028B52E63C12546480AF0@AM0PR04MB5763.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231455)(999002)(944501493)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5763; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5763; 
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(366004)(136003)(396003)(346002)(39860400002)(189003)(199004)(305945005)(386003)(14444005)(102836004)(25786009)(97736004)(52116002)(186003)(36756003)(76176011)(478600001)(256004)(6116002)(2501003)(8936002)(86362001)(26005)(81166006)(3846002)(6506007)(8676002)(81156014)(4326008)(50226002)(316002)(486006)(53936002)(2616005)(476003)(106356001)(99286004)(2906002)(5660300001)(6512007)(7736002)(11346002)(6486002)(446003)(6436002)(2351001)(6916009)(68736007)(105586002)(575784001)(14454004)(54906003)(5640700003)(66066001)(71200400001)(71190400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5763;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: In4wad0Ym9pBXrZJQyJt4gn4xo4m+5YdCXxOKHCMLFGeUKKOdaFyJuSeRS/C6iu+ZfQk8YzcWk4DLIIEqPkRoHeQck3ppZ9qCZwl/gRI7ILNAa2xTSjB1DLMfLcJxdMtHdJJ8+pSCCulVrwl3vgw3HKJ78Sx2Z+fpyja4Dxz5lwk/w8XtgXbhXLpX2M07RUfEXcXim2B4GO29GtwpQJ8rItbaap8NZYjUYlLnJkT5coEAvDtq7cdob70sakW10VKMEK7pJ/qfAG/99XnVywBJfp9CmLssMNHLETNm9FEOk9EDCCvcPPEt0qA+hOR+5tMVp1FjVHraaJuWX7K0fYEiECZoSilcGSZHSCJx8D/GYY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c8a71e-6cfa-446c-88ed-08d659f647b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 14:39:22.3392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5763
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_063936_908426_FC24BB52 
X-CRM114-Status: GOOD (  16.62  )
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
Cc: Aisheng DONG <aisheng.dong@nxp.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
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
 arch/arm/mach-imx/Kconfig | 11 +++++++++++
 drivers/clk/Kconfig       |  1 +
 drivers/clk/imx/Kconfig   |  5 +++++
 drivers/clk/imx/Makefile  |  2 +-
 4 files changed, 18 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/Kconfig

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index c12a05c..303082c 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -57,23 +57,27 @@ config SOC_IMX21
 	select CPU_ARM926T
 	select IMX_HAVE_IOMUX_V1
 	select MXC_AVIC
+	select MXC_CLK
 
 config SOC_IMX27
 	bool
 	select CPU_ARM926T
 	select IMX_HAVE_IOMUX_V1
 	select MXC_AVIC
+	select MXC_CLK
 	select PINCTRL_IMX27
 
 config SOC_IMX31
 	bool
 	select CPU_V6
 	select MXC_AVIC
+	select MXC_CLK
 
 config SOC_IMX35
 	bool
 	select ARCH_MXC_IOMUX_V3
 	select MXC_AVIC
+	select MXC_CLK
 	select PINCTRL_IMX35
 
 if ARCH_MULTI_V5
@@ -417,6 +421,7 @@ config SOC_IMX1
 	bool "i.MX1 support"
 	select CPU_ARM920T
 	select MXC_AVIC
+	select MXC_CLK
 	select PINCTRL_IMX1
 	help
 	  This enables support for Freescale i.MX1 processor
@@ -430,6 +435,7 @@ config SOC_IMX25
 	select ARCH_MXC_IOMUX_V3
 	select CPU_ARM926T
 	select MXC_AVIC
+	select MXC_CLK
 	select PINCTRL_IMX25
 	help
 	  This enables support for Freescale i.MX25 processor
@@ -442,6 +448,7 @@ comment "Cortex-A platforms"
 config SOC_IMX5
 	bool
 	select HAVE_IMX_SRC
+	select MXC_CLK
 	select MXC_TZIC
 
 config	SOC_IMX50
@@ -478,6 +485,7 @@ config SOC_IMX6
 	select HAVE_IMX_MMDC
 	select HAVE_IMX_SRC
 	select MFD_SYSCON
+	select MXC_CLK
 	select PL310_ERRATA_769419 if CACHE_L2X0
 
 config SOC_IMX6Q
@@ -545,10 +553,12 @@ config SOC_IMX7D_CA7
 	select HAVE_IMX_MMDC
 	select HAVE_IMX_SRC
 	select IMX_GPCV2
+	select MXC_CLK
 
 config SOC_IMX7D_CM4
 	bool
 	select ARMV7M_SYSTICK
+	select MXC_CLK
 
 config SOC_IMX7D
 	bool "i.MX7 Dual support"
@@ -570,6 +580,7 @@ config SOC_IMX7ULP
 config SOC_VF610
 	bool "Vybrid Family VF610 support"
 	select ARM_GIC if ARCH_MULTI_V7
+	select MXC_CLK
 	select PINCTRL_VF610
 
 	help
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 81cdb4e..1dbfcc2 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -287,6 +287,7 @@ source "drivers/clk/actions/Kconfig"
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
 source "drivers/clk/imgtec/Kconfig"
+source "drivers/clk/imx/Kconfig"
 source "drivers/clk/ingenic/Kconfig"
 source "drivers/clk/keystone/Kconfig"
 source "drivers/clk/mediatek/Kconfig"
diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
new file mode 100644
index 0000000..43a3ecc
--- /dev/null
+++ b/drivers/clk/imx/Kconfig
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+# common clock support for NXP i.MX SoC family.
+config MXC_CLK
+	bool
+	depends on ARCH_MXC
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
