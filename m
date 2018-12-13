Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27591C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:18:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEDB220870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vxa00Dyb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N3UtBjpC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEDB220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=89SUKMz08q4OOZwfIJ1qD7AmtdxXoPOvcDW6cmue7ck=; b=Vxa00DybroEWLp
	o+8lWmixUXcMUMnnFGBjf/rp2M3ekbzMasgQlGM1Uj06ETmFQNxAcbR57yp2vlP80YrJGsPS8wSGI
	5buou7KIgy4UJIuHIgipbBsnBv0APhODw8eGI4mTF5pH90DXa8v8ZcLOlakzreYb4YSSAc2SQtQx0
	AMhLEWhuhQmvQCQx5OAaO+ZAQJVAraAt/skbT+Etmw6Ab4KDNvSn5swz5fhMLqy4RdOuq22Fu8Nw0
	XU8mun0RsnBZRT74/1j8XMkNTyk2X4DJtfc1sBqpMwxvgzIc+v0TILuOUT3bmcwFOgxccbXsbM1f8
	Dv/CvkbMQVUdzvVMZDjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQsT-0005nG-Ru; Thu, 13 Dec 2018 13:18:09 +0000
Received: from mail-eopbgr30070.outbound.protection.outlook.com ([40.107.3.70]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQsG-0005ZT-Kk
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 13:17:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RK0QJmFLLb+/mOmqghkFzKuFINjDA4RGK/1WxLeJN/s=;
 b=N3UtBjpC82VEN/0PTtbzrvGI2/DsCbsoA9NXbSrQNnz1IC6c5yNQbRGp4KkFFf7Am38EF/zOMMDWLcJDNLddb4Fj6U7TKSaZ3giJ5edVIxu3fdtTwajlRKjuq7W27X4gpPsobTL+vpRoJhE9pfvcQmuAL/wU80fL9p90jPtBfyE=
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com (52.134.65.28) by
 DB3PR0402MB3692.eurprd04.prod.outlook.com (52.134.65.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 13:17:42 +0000
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb]) by DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb%5]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 13:17:42 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Aisheng
 Dong <aisheng.dong@nxp.com>
Subject: [PATCH 1/3] arm64: Remove CONFIG_SOC_IMX8MQ and use ARCH_MXC instead
Thread-Topic: [PATCH 1/3] arm64: Remove CONFIG_SOC_IMX8MQ and use ARCH_MXC
 instead
Thread-Index: AQHUkuY6nb3Z7jYWIkKip6q0zf3chA==
Date: Thu, 13 Dec 2018 13:17:42 +0000
Message-ID: <1544707047-4417-2-git-send-email-abel.vesa@nxp.com>
References: <1544707047-4417-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1544707047-4417-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P192CA0103.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::44) To DB3PR0402MB3658.eurprd04.prod.outlook.com
 (2603:10a6:8:2::28)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB3PR0402MB3692;
 6:IIrsa3VnmE83UL81ePEvly9z2rBCTQuW8Dn/ajQwDDXDeoy0K0mZ/mt1xh+ap9eUGBgNCvHLzlOnUso3DUB3WVCFRB/fgR3RH3vMilS99Wa6RrnjRpUsmxEAmzIMz52VcUtRw/KqHGQPwG92vmoQSbvUVywqqiw8KR+dWsEDOZmBZ20/NWtiU7m+RBsjxS0XdRh1va4NZottzY6vPwnWk4g7O0Jrxtv3s1yBAJehTlJ3b8blEURzG05bl3boPOC6QVIRrXb24Fj6xY1qek9VLV+5fSkNGUNV5UbnijMHEiU8m4b6q9uM7aztjWZjF91kHyETOUdmXQWoKyy3KI81AZsxKUImlgS0fldoDOjq3YfASKjmgXrvB02JiA5m69LyTUaF9JVXIBP2ZkdvcDdhJK/rnUF9vPRPgeYnO1eLTQjkuUWWgwpfn2AVc0TmZtjcdl5xtp/akjJkXH5XnsPMnA==;
 5:POIBQLSjX4C5pDpKoUSz0A/jmMP0w4tAjvuFxhTdUycHRT51tamX564FvnBEfo3+JTnAvMQHrPKNxWfAvHxy6mDL4JPghQzhgUut/ut3mh7AzqXKzN7WDQZThjR60yzzBKZ8jE9qsqw+ZooIOALF/v2IhH7NVT7hScBv3YGeDxA=;
 7:DONEcichQytrVGsop3wIxG1afwBlj6ErzntSbdd6vori70lw2Y1YEOlbuJhvIMpr7d+r/J/RK46FCpNdEbcrrkBtoUeRRtp600xSPHnbZLp4k/V3Fqt0wWWzYu853TH39JAGCE+yoakT4ljb9MhyMw==
x-ms-office365-filtering-correlation-id: 7c823e72-c56a-4651-dd5b-08d660fd5cb7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3692; 
x-ms-traffictypediagnostic: DB3PR0402MB3692:
x-microsoft-antispam-prvs: <DB3PR0402MB3692A38DB4CCC22E659AFAC9F6A00@DB3PR0402MB3692.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231475)(944501520)(52105112)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:DB3PR0402MB3692; BCL:0; PCL:0; RULEID:; SRVR:DB3PR0402MB3692; 
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(376002)(136003)(39860400002)(396003)(199004)(189003)(81166006)(36756003)(8936002)(486006)(186003)(25786009)(305945005)(2616005)(11346002)(446003)(76176011)(476003)(26005)(2906002)(68736007)(8676002)(81156014)(6486002)(14454004)(386003)(7416002)(478600001)(6436002)(6636002)(5660300001)(6506007)(256004)(6512007)(86362001)(575784001)(66066001)(106356001)(105586002)(7736002)(54906003)(110136005)(102836004)(316002)(71190400001)(71200400001)(44832011)(52116002)(3846002)(6116002)(53936002)(97736004)(99286004)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3692;
 H:DB3PR0402MB3658.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pLuR6CNpQlBIjbTu4sBsO70e4SvgGwbsjMZ+HVP5iBtELZJ0InG20BB79wCX97Kgly3omUJaLDYO/YHPCfdCMqzwvux4SkBTqLu0Hk+iTN7t8Do4JrGNjZXhxa8TxlgGx4TjLl6TJ6AortXzulh6rAh37WRFK3kvvw/W1Ci6fNG+9ZyELcsOUKTxpGVpE5BEgT5ooPUkvaRU35z2vX3uhCMNhSMrQTc83YqaO3HJCUNQxbo5IIP6JVPPDyAhWvy2jy2K8+JrWboDwXcqUO/+/zr23AgCQkqlHf60X+tJanf/PVjCIBZewcrxhP1VtihR
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c823e72-c56a-4651-dd5b-08d660fd5cb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 13:17:42.1272 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3692
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_051756_679836_D849A763 
X-CRM114-Status: GOOD (  15.63  )
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
Cc: Rob Herring <robh@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
 Will Deacon <will.deacon@arm.com>,
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

To keep aligned with arm64, remove the unnecessary SOC_IMX8MQ and use
ARCH_MXC instead.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/Kconfig.platforms           | 8 --------
 arch/arm64/boot/dts/freescale/Makefile | 2 +-
 drivers/clk/imx/Makefile               | 3 ++-
 drivers/phy/freescale/Kconfig          | 2 +-
 drivers/pinctrl/freescale/Kconfig      | 2 +-
 drivers/soc/imx/Kconfig                | 2 +-
 6 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 7e1545a..318dbb9 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -148,14 +148,6 @@ config ARCH_MXC
 	  This enables support for the ARMv8 based SoCs in the
 	  NXP i.MX family.
 
-config SOC_IMX8MQ
-	bool "i.MX8MQ support"
-	depends on ARCH_MXC
-	select ARM64_ERRATUM_843419
-	select ARM64_ERRATUM_845719
-	help
-	  This enables support for the i.MX8MQ SoC.
-
 config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 0001361..f9be242 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -19,4 +19,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
 
-dtb-$(CONFIG_SOC_IMX8MQ) += imx8mq-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mq-evk.dtb
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 5c0b11e..62a1882 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -34,5 +34,6 @@ obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) += clk-imx6ul.o
 obj-$(CONFIG_SOC_IMX7D)  += clk-imx7d.o
 obj-$(CONFIG_SOC_IMX7ULP) += clk-imx7ulp.o
-obj-$(CONFIG_SOC_IMX8MQ) += clk-imx8mq.o
 obj-$(CONFIG_SOC_VF610)  += clk-vf610.o
+
+obj-$(CONFIG_ARCH_MXC) += clk-imx8mq.o
diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kconfig
index f050bd4..923c0ef 100644
--- a/drivers/phy/freescale/Kconfig
+++ b/drivers/phy/freescale/Kconfig
@@ -2,4 +2,4 @@ config PHY_FSL_IMX8MQ_USB
 	tristate "Freescale i.MX8M USB3 PHY"
 	depends on OF && HAS_IOMEM
 	select GENERIC_PHY
-	default SOC_IMX8MQ
+	default ARCH_MXC
diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/Kconfig
index 2d6db43..9874a16 100644
--- a/drivers/pinctrl/freescale/Kconfig
+++ b/drivers/pinctrl/freescale/Kconfig
@@ -123,7 +123,7 @@ config PINCTRL_IMX7ULP
 
 config PINCTRL_IMX8MQ
 	bool "IMX8MQ pinctrl driver"
-	depends on SOC_IMX8MQ
+	depends on ARCH_MXC
 	select PINCTRL_IMX
 	help
 	  Say Y here to enable the imx8mq pinctrl driver
diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index 2112d18..7ffbb6b 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -2,7 +2,7 @@ menu "i.MX SoC drivers"
 
 config IMX_GPCV2_PM_DOMAINS
 	bool "i.MX GPCv2 PM domains"
-	depends on SOC_IMX7D || SOC_IMX8MQ || (COMPILE_TEST && OF)
+	depends on SOC_IMX7D || ARCH_MXC || (COMPILE_TEST && OF)
 	depends on PM
 	select PM_GENERIC_DOMAINS
 	default y if SOC_IMX7D
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
