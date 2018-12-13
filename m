Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE19C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:17:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F43520879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QfkmJAqA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mU6C0RXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F43520879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=U0Ms7Efb2yH9rR99BHrwh8/K5ZQtkH68IaFGn9JYdPg=; b=QfkmJAqAukwwVD
	r1zUdxdNq2DyHANtNy73UbwVJFp05daNGf9MCgdy7FZXqLp6//Pmxr2dtD87MdSVSyEdpj2ZI6fX0
	QBYq0DdtJJhHtnQq1GWBy+YtuqJlnVOAmwwgnqRqqdSJWwe83VrAVnXfVfk65/Z2Qdg8cgx7+rCKR
	pOqGdw87j8utZ7dfYr1ahRbuEs9lNnZ5RnTFRdxZY7w3xN53xntxgcKt8FAcEUQKx/GLrxWofrxgl
	9eEC9p5h1jgWgnpFFGQYalQVdq4WBfZRn5McSNUSnLEUlQ7qFhgI/flmK/wguZI4N+EmAll2HxvC8
	83IAhYOSsTHRg6PHp8IA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXTft-0006cr-Lq; Thu, 13 Dec 2018 16:17:21 +0000
Received: from mail-am5eur02on0605.outbound.protection.outlook.com
 ([2a01:111:f400:fe07::605]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXTfp-0006Xh-Gg
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 16:17:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmJAN4wtHXV/dUPVh8AOAa0trKBJo4xPO46NdtfRh1U=;
 b=mU6C0RXqRGLb+3fa0f7pjvVe/jhrODRCckJbMVoIiNNTk9ho1QyMTKhdWG1CmBt+z8rKD/Pl6TOUGFr8GGJbqL2LqA7LUQvXwO20eRx5/2f5jqnIpeOS8hd423rFvED6MKiAacNitcQ3ETWqKxxj3GES2e+sw+Wl26bgBaPXHLI=
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com (52.134.65.28) by
 DB3PR0402MB3659.eurprd04.prod.outlook.com (52.134.66.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 16:17:02 +0000
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb]) by DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb%5]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 16:17:02 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Aisheng
 Dong <aisheng.dong@nxp.com>
Subject: [PATCH] clk: imx: Make the i.MX8MQ CCM clock driver CLK_IMX8MQ
 dependant
Thread-Topic: [PATCH] clk: imx: Make the i.MX8MQ CCM clock driver CLK_IMX8MQ
 dependant
Thread-Index: AQHUkv9IB3KEsUBSeEGaC3/cu+N6Cw==
Date: Thu, 13 Dec 2018 16:17:02 +0000
Message-ID: <1544717789-27388-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::32) To DB3PR0402MB3658.eurprd04.prod.outlook.com
 (2603:10a6:8:2::28)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB3PR0402MB3659;
 6:1C/wncVESe1HewFEHUPS52r9qXDpVmEbVIACds9u8bOLSMN1jaUXevM7QQIadYNC+4eI8FiISlMxkbNwvNPtCozbz07+4waAnpJRhWSoeAJZ64I9XNM4XFKVFugwo6AxC73Pn8z4MYHWoxYzUpIiMUUgcZ1jApvzJg2VfRL2NN/WzH2GO0BUV5zMdMdMMUnfaNg4NsxzocmjKV6gieEh8Fud0QyQ8E6O5KoepwCylufx0F8pmMKX+D6LqGxL/if4oZtqNuIWH4lHZguEB3gaaN61jyKvmEe4xMASPCGb1OQGAfgxCmKFSWrzw2Brimmsuxfe/24bNn0V/QypQeQZCnKggVAQuVlqqDEnsgDSJiVwwGU/1LKgpoaHj2/azVWQjEEjjepfB+oyRBZmy1tmw1+SZ1Bdcx+LLh9feqrxWhgnbQEC2YIGES5acCz943Ezy1Eo25f6VcFsNW7zKcDJhQ==;
 5:/CZ9KUayzXi5C077Y7lcjeV6nZ50lm0CSgbkYg8rD7NPo9lUT2zNMcKHIbzzuSYWqc2ZlmlJdaoHk0dps31sSu+dj9fZUt+njb7DJkFbe6zgGTqrTOkCWasbYcVrJxEhQleFMYQpBhuIGi5Qe1ce4DfQatSj3NzJTJbGgDHUcuQ=;
 7:NkCFlwIHyWvu1rq5YLySgonRY2iMfTVFg4o9LOytt6li0ktdKa+mGOvELhYpW1pF8GoGC6E33DSCArQipqLnJVGfw8zj0CPpsEFU5jmkN2+gAiN1QiCiaYvW/TaSG6bkfs8BohSQtyW4GkA+sUsBMg==
x-ms-office365-filtering-correlation-id: f9c98633-180f-48d6-754d-08d661166aa6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3659; 
x-ms-traffictypediagnostic: DB3PR0402MB3659:
x-microsoft-antispam-prvs: <DB3PR0402MB36597B536540A7F63B3E3E42F6A00@DB3PR0402MB3659.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:DB3PR0402MB3659; BCL:0; PCL:0; RULEID:; SRVR:DB3PR0402MB3659; 
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(366004)(376002)(346002)(396003)(199004)(189003)(52116002)(102836004)(6486002)(6436002)(36756003)(186003)(6636002)(14444005)(256004)(6512007)(2616005)(486006)(99286004)(476003)(71190400001)(26005)(44832011)(71200400001)(66066001)(53936002)(8936002)(81166006)(86362001)(575784001)(81156014)(8676002)(4326008)(478600001)(7736002)(105586002)(97736004)(106356001)(14454004)(110136005)(54906003)(305945005)(2906002)(25786009)(386003)(6506007)(316002)(68736007)(5660300001)(3846002)(6116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3659;
 H:DB3PR0402MB3658.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1rpAgoBNNPY5vVr2M7NKIQbmGHPNooi4kRN3EFRhujJu2EIvXyCUt6KpjyAhOX9qK8LLiAh4N3Z/ZK0EqgS3EaSvK5dVbR3PTgU6pZ5YN4m36ZsqPn3YN1g+oruRxZtd0pCz+7WkhEAo/D/cm8ZomFsgc5heEj4oh/+GBLOHHp0nLRJh59u8CLvO7FJYex3HOXLhQFzvutQr08zEK9XK3Uqx1FMWCyFh4e2xDeq2R09V4w8ocvUFxxZPHb6wfEssvldeYHsdtBX2Pix5YFA2HE7dg6PpwUL2cyiQ9hu1R6jJV0MMPHYkLsOgs3JIDEGb
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c98633-180f-48d6-754d-08d661166aa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 16:17:02.8684 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_081717_551750_31412A70 
X-CRM114-Status: GOOD (  14.95  )
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
Cc: Abel Vesa <abel.vesa@nxp.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Olof Johansson <olof@lixom.net>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Remove the dependency between the i.MX8MQ CCM clock driver
and the CONFIG_SOC_IMX8MQ and use CONFIG_CLK_IMX8MQ instead.
CONFIG_CLK_IMX8MQ depends on ARCH_MXC && ARM64.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/Kconfig      | 1 +
 drivers/clk/imx/Kconfig  | 5 +++++
 drivers/clk/imx/Makefile | 3 ++-
 3 files changed, 8 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/Kconfig

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 2dc12bf..833353c 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -293,6 +293,7 @@ config COMMON_CLK_BD718XX
 source "drivers/clk/actions/Kconfig"
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
+source "drivers/clk/imx/Kconfig"
 source "drivers/clk/imgtec/Kconfig"
 source "drivers/clk/ingenic/Kconfig"
 source "drivers/clk/keystone/Kconfig"
diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
new file mode 100644
index 0000000..98ede6a
--- /dev/null
+++ b/drivers/clk/imx/Kconfig
@@ -0,0 +1,5 @@
+config CLK_IMX8MQ
+	bool "IMX8MQ CCM Clock Driver"
+	depends on ARCH_MXC && ARM64
+	help
+	    Build the driver for i.MX8MQ CCM Clock Driver
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 5c0b11e..01e5f55 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -34,5 +34,6 @@ obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) += clk-imx6ul.o
 obj-$(CONFIG_SOC_IMX7D)  += clk-imx7d.o
 obj-$(CONFIG_SOC_IMX7ULP) += clk-imx7ulp.o
-obj-$(CONFIG_SOC_IMX8MQ) += clk-imx8mq.o
 obj-$(CONFIG_SOC_VF610)  += clk-vf610.o
+
+obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
