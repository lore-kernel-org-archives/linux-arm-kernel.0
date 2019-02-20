Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA0EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:38:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A53D521902
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OKKf0csl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vVsGzdKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53D521902
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8nxd+8mwWPji4K5n/5lpxip5PTFS+vXgraBO7yT8Pmg=; b=OKKf0csljLJodz
	5udeAqgElMSr7RM6gosGkMKv8cgZ7D48wfS04tF99LIGDMwNxh10t4txqSC9Lb66D71ZIEf62l0X4
	MSjUSlzt+05HJbtYnkUVfDaLw/wy/Lf4e2gY4RNFl/G+o+pAzHOkRGB0C8Lq2FWTbBz2UnrOSDh2V
	eGeVq9cDGfb/IDbGkRqC15ae6DF0/XocJqXeOK8pRcipZQ7IhI4JNWxSHHvgZS3hVPTko7QgzpORo
	ubD0JbXQ6hfQk0K1RQ0CgrxTleErf6Kx9+WRXD+rJPk9WFAxCbBw367WVHORyz+hgt2SL1odDxzdA
	wBLYUfmCBuKLsacDWJCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwT1J-000496-5Z; Wed, 20 Feb 2019 14:38:45 +0000
Received: from mail-eopbgr40080.outbound.protection.outlook.com ([40.107.4.80]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwT14-0003s6-W6
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 14:38:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImlPL++Ze5JgeXO94Xnqh8KZLVcQxh57Jqg+8PMw3AY=;
 b=vVsGzdKI9ERgwZArtni4COP+YsYdjvfJZpkf5sVrm1pnIgFUDuk4d511c7yoo0Z0eSIS9ChqxCEMXCPdoPiEwRYHykXqDmKyz//iDCoGSsuOr9jGcmhJwBdH66Nt5ADnSSRETiFtBSPyG9pt/2LfV+WfmSFCxU21qMMQjUi+zkA=
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com (52.135.168.141) by
 AM6PR04MB5975.eurprd04.prod.outlook.com (20.178.94.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 14:38:28 +0000
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08]) by AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08%5]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 14:38:28 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/3] firmware: imx: scu-pd: use bool to set postfix
Thread-Topic: [PATCH 1/3] firmware: imx: scu-pd: use bool to set postfix
Thread-Index: AQHUySnxVCOrqemBmEKJcTp5KCZLeg==
Date: Wed, 20 Feb 2019 14:38:27 +0000
Message-ID: <1550673013-21462-2-git-send-email-aisheng.dong@nxp.com>
References: <1550673013-21462-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1550673013-21462-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0074.apcprd03.prod.outlook.com
 (2603:1096:203:72::14) To AM6PR04MB4215.eurprd04.prod.outlook.com
 (2603:10a6:209:4f::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9dd5250f-3caf-4286-bd5b-08d697411392
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB5975; 
x-ms-traffictypediagnostic: AM6PR04MB5975:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; AM6PR04MB5975;
 23:gfbW8dVSRGDBuGi3zTcXfGAxBrkI/Aw4/Igjk27?=
 =?iso-8859-1?Q?L8Ys8oDwmheInvkCHo3f5GKN6iS32FTt6ILHmnjMCX0+/WuNPt/JMdRjdc?=
 =?iso-8859-1?Q?KUXEtxsXl/8lkZKDqGHGDHeLZmm2gXM0sbk+yeSObqK528jNFZyiMRiF/Y?=
 =?iso-8859-1?Q?AexZvjcJEu1hlMDHkE4fwv60sdbW1H0VCF4xNslWjATknQm674tjU1NP5Z?=
 =?iso-8859-1?Q?hxGKqrxpqEj9QniLsechrpXtTj0YUSiRmxtAwHY1K2VynUfQ7qF1KrIBzl?=
 =?iso-8859-1?Q?JQOzJdda1WmHM5irhetEJwhgo3j+pk0gypgthO45CLM4X3UhMYkduRkeQM?=
 =?iso-8859-1?Q?21+4L/OIwbk/KLBcPSK/a6GpjBxEN9aZ6nXJbiUDruMPSVjvBOCTA62MJI?=
 =?iso-8859-1?Q?q5sQaVa9JViQTMRaxCrQL5ncXJKnaMIaGcG3bTd2NrcPgGiQ45wXkIADZS?=
 =?iso-8859-1?Q?FoyinxlMeQFGgE3b/fBo05Pw1IHcrIUfnj+SiHhnJ3dSKZlrRIL7eJ4L5h?=
 =?iso-8859-1?Q?VevoJuq4VJH9kd4f2kg2AIF5Yie80G8SEyxHy4cDn9sZ708VWw6f1Z2/WJ?=
 =?iso-8859-1?Q?HRpq8uKmPzVwK3ioKktQR2t4jT+DqCKO9HqDmLsmWpZs1rlzBPUTPIZrGb?=
 =?iso-8859-1?Q?cMDJZ4tCPiOkJjz29/rfAv8gYKIh3SBuEwkKqrr52kgaMKdPWrnmjFUFeO?=
 =?iso-8859-1?Q?bCNNH1LR+Pygfa7M5lQH5TGUNNk3jO8QP+rNUJUUNQU1xucQ2yigT0gx0x?=
 =?iso-8859-1?Q?wbGN3PumWGw2xMLUuRT8DZs/drkNTZB51TizpTScWXTDl4RzGYdHbMXiun?=
 =?iso-8859-1?Q?6+v7VJctj288sx8ji0lW6T7chxYV+Cl27ERmSxi+kgTA/gDrCWWFznX0Wd?=
 =?iso-8859-1?Q?jVDlqTrzTEIOoMNvMQWQatxx1jCeQzec0x2nt2Z0bk3mwEpQ36KPrF5u/D?=
 =?iso-8859-1?Q?c1m4j9UlDpT9zkNfIISpwmY+/TGCQAuGcgbfSjwrU6K1aR+wMhao2OQi16?=
 =?iso-8859-1?Q?/wVhvK6i+xeiwS950doRFUyP4AMPWUDU90ereOiKt4u+ouj87jhyAsqjtF?=
 =?iso-8859-1?Q?rSJrJ6sR8ZI6leo7e2xn/wBxmEFiRdE6x7XjN+eqC+AY58pTBmQVFhNzoB?=
 =?iso-8859-1?Q?rMB8YNyuhlwfLRd6BTjmZgKLgoiasn68WR66wh9RfbpDyt5RMPyvt4n5E9?=
 =?iso-8859-1?Q?zU6vvYpZQLY4+JAyqTNRhlA/55NV85jJsZfOlg+OqemXiPk9gwgw3aG6OE?=
 =?iso-8859-1?Q?9nnPPlMDkkT65BzIKzbnd23S6NfvD1r1DH3x6S5QKFO5su0cJ9O8F9LinD?=
 =?iso-8859-1?Q?jbcLNWlq76UqfUP2foBLVRP?=
x-microsoft-antispam-prvs: <AM6PR04MB5975696F5C8C9EB699C68B7B807D0@AM6PR04MB5975.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(366004)(39860400002)(136003)(396003)(189003)(199004)(14454004)(4326008)(81166006)(476003)(81156014)(6916009)(25786009)(186003)(2616005)(105586002)(8936002)(102836004)(66066001)(86362001)(71200400001)(446003)(11346002)(3846002)(2501003)(54906003)(71190400001)(68736007)(6116002)(52116002)(6486002)(106356001)(486006)(6436002)(386003)(316002)(305945005)(478600001)(50226002)(6506007)(7736002)(5640700003)(8676002)(256004)(6512007)(2906002)(53936002)(26005)(99286004)(44832011)(76176011)(5660300002)(36756003)(97736004)(2351001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB5975;
 H:AM6PR04MB4215.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8K9eryVmMg6iDC7etoOPAovGThFZYKYHN/UxVNBzu3NfGzifL21cayip0s/fGV1QUDae3FxJe9deLxTFvImTilAQZOGWlM7GFHczWzfv1mUIROAlHuaUL5siQNSTS9CYB6n2V5d5EUKkdX4v9K3juXRbDhZnZx3fGpYwpeyn7Vg57U5KIFpbNaWCMCFRBKTcajSsLfBVya0xxg/MzkXIENo6Bd3f9VrmDFLyec1Bk1I/Y5Y+HJD2d8dr3TumlpvSA92O7JMop+c/ttOtGMr5kA7+O/VuSBCDDGtHQRZhBbs9ce5CiDJYfAwmq2V4GKubeNT3ttV46MxN3mY1qxsFoNxpTFe++Fh6Z9LS5UZom1Crj8/btjiaB/8PKfsu8ARIwHO0mmvYigDECZIWgmU3es2bXMGxSUfpraKDmkVlqvk=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd5250f-3caf-4286-bd5b-08d697411392
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 14:38:24.1861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5975
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_063831_304928_26342C68 
X-CRM114-Status: GOOD (  10.79  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "khilman@kernel.org" <khilman@kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Using bool instead 0/1 to indicate whether adding a postfix for domain
names which can improve the code readability and less confusing.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 102 +++++++++++++++++++++---------------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index 407245f..d1d39d9 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -84,71 +84,71 @@ struct imx_sc_pd_soc {
 
 static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	/* LSIO SS */
-	{ "lsio-pwm", IMX_SC_R_PWM_0, 8, 1 },
-	{ "lsio-gpio", IMX_SC_R_GPIO_0, 8, 1 },
-	{ "lsio-gpt", IMX_SC_R_GPT_0, 5, 1 },
-	{ "lsio-kpp", IMX_SC_R_KPP, 1, 0 },
-	{ "lsio-fspi", IMX_SC_R_FSPI_0, 2, 1 },
-	{ "lsio-mu", IMX_SC_R_MU_0A, 14, 1 },
+	{ "lsio-pwm", IMX_SC_R_PWM_0, 8, true },
+	{ "lsio-gpio", IMX_SC_R_GPIO_0, 8, true },
+	{ "lsio-gpt", IMX_SC_R_GPT_0, 5, true },
+	{ "lsio-kpp", IMX_SC_R_KPP, 1, false },
+	{ "lsio-fspi", IMX_SC_R_FSPI_0, 2, true },
+	{ "lsio-mu", IMX_SC_R_MU_0A, 14, true },
 
 	/* CONN SS */
-	{ "con-usb", IMX_SC_R_USB_0, 2, 1 },
-	{ "con-usb0phy", IMX_SC_R_USB_0_PHY, 1, 0 },
-	{ "con-usb2", IMX_SC_R_USB_2, 1, 0 },
-	{ "con-usb2phy", IMX_SC_R_USB_2_PHY, 1, 0 },
-	{ "con-sdhc", IMX_SC_R_SDHC_0, 3, 1 },
-	{ "con-enet", IMX_SC_R_ENET_0, 2, 1 },
-	{ "con-nand", IMX_SC_R_NAND, 1, 0 },
-	{ "con-mlb", IMX_SC_R_MLB_0, 1, 1 },
+	{ "con-usb", IMX_SC_R_USB_0, 2, true },
+	{ "con-usb0phy", IMX_SC_R_USB_0_PHY, 1, false },
+	{ "con-usb2", IMX_SC_R_USB_2, 1, false },
+	{ "con-usb2phy", IMX_SC_R_USB_2_PHY, 1, false },
+	{ "con-sdhc", IMX_SC_R_SDHC_0, 3, true },
+	{ "con-enet", IMX_SC_R_ENET_0, 2, true },
+	{ "con-nand", IMX_SC_R_NAND, 1, false },
+	{ "con-mlb", IMX_SC_R_MLB_0, 1, true },
 
 	/* Audio DMA SS */
-	{ "adma-audio-pll0", IMX_SC_R_AUDIO_PLL_0, 1, 0 },
-	{ "adma-audio-pll1", IMX_SC_R_AUDIO_PLL_1, 1, 0 },
-	{ "adma-audio-clk-0", IMX_SC_R_AUDIO_CLK_0, 1, 0 },
-	{ "adma-dma0-ch", IMX_SC_R_DMA_0_CH0, 16, 1 },
-	{ "adma-dma1-ch", IMX_SC_R_DMA_1_CH0, 16, 1 },
-	{ "adma-dma2-ch", IMX_SC_R_DMA_2_CH0, 5, 1 },
-	{ "adma-asrc0", IMX_SC_R_ASRC_0, 1, 0 },
-	{ "adma-asrc1", IMX_SC_R_ASRC_1, 1, 0 },
-	{ "adma-esai0", IMX_SC_R_ESAI_0, 1, 0 },
-	{ "adma-spdif0", IMX_SC_R_SPDIF_0, 1, 0 },
-	{ "adma-sai", IMX_SC_R_SAI_0, 3, 1 },
-	{ "adma-amix", IMX_SC_R_AMIX, 1, 0 },
-	{ "adma-mqs0", IMX_SC_R_MQS_0, 1, 0 },
-	{ "adma-dsp", IMX_SC_R_DSP, 1, 0 },
-	{ "adma-dsp-ram", IMX_SC_R_DSP_RAM, 1, 0 },
-	{ "adma-can", IMX_SC_R_CAN_0, 3, 1 },
-	{ "adma-ftm", IMX_SC_R_FTM_0, 2, 1 },
-	{ "adma-lpi2c", IMX_SC_R_I2C_0, 4, 1 },
-	{ "adma-adc", IMX_SC_R_ADC_0, 1, 1 },
-	{ "adma-lcd", IMX_SC_R_LCD_0, 1, 1 },
-	{ "adma-lcd0-pwm", IMX_SC_R_LCD_0_PWM_0, 1, 1 },
-	{ "adma-lpuart", IMX_SC_R_UART_0, 4, 1 },
-	{ "adma-lpspi", IMX_SC_R_SPI_0, 4, 1 },
+	{ "adma-audio-pll0", IMX_SC_R_AUDIO_PLL_0, 1, false },
+	{ "adma-audio-pll1", IMX_SC_R_AUDIO_PLL_1, 1, false },
+	{ "adma-audio-clk-0", IMX_SC_R_AUDIO_CLK_0, 1, false },
+	{ "adma-dma0-ch", IMX_SC_R_DMA_0_CH0, 16, true },
+	{ "adma-dma1-ch", IMX_SC_R_DMA_1_CH0, 16, true },
+	{ "adma-dma2-ch", IMX_SC_R_DMA_2_CH0, 5, true },
+	{ "adma-asrc0", IMX_SC_R_ASRC_0, 1, false },
+	{ "adma-asrc1", IMX_SC_R_ASRC_1, 1, false },
+	{ "adma-esai0", IMX_SC_R_ESAI_0, 1, false },
+	{ "adma-spdif0", IMX_SC_R_SPDIF_0, 1, false },
+	{ "adma-sai", IMX_SC_R_SAI_0, 3, true },
+	{ "adma-amix", IMX_SC_R_AMIX, 1, false },
+	{ "adma-mqs0", IMX_SC_R_MQS_0, 1, false },
+	{ "adma-dsp", IMX_SC_R_DSP, 1, false },
+	{ "adma-dsp-ram", IMX_SC_R_DSP_RAM, 1, false },
+	{ "adma-can", IMX_SC_R_CAN_0, 3, true },
+	{ "adma-ftm", IMX_SC_R_FTM_0, 2, true },
+	{ "adma-lpi2c", IMX_SC_R_I2C_0, 4, true },
+	{ "adma-adc", IMX_SC_R_ADC_0, 1, true },
+	{ "adma-lcd", IMX_SC_R_LCD_0, 1, true },
+	{ "adma-lcd0-pwm", IMX_SC_R_LCD_0_PWM_0, 1, true },
+	{ "adma-lpuart", IMX_SC_R_UART_0, 4, true },
+	{ "adma-lpspi", IMX_SC_R_SPI_0, 4, true },
 
 	/* VPU SS  */
-	{ "vpu", IMX_SC_R_VPU, 1, 0 },
-	{ "vpu-pid", IMX_SC_R_VPU_PID0, 8, 1 },
-	{ "vpu-dec0", IMX_SC_R_VPU_DEC_0, 1, 0 },
-	{ "vpu-enc0", IMX_SC_R_VPU_ENC_0, 1, 0 },
+	{ "vpu", IMX_SC_R_VPU, 1, false },
+	{ "vpu-pid", IMX_SC_R_VPU_PID0, 8, true },
+	{ "vpu-dec0", IMX_SC_R_VPU_DEC_0, 1, false },
+	{ "vpu-enc0", IMX_SC_R_VPU_ENC_0, 1, false },
 
 	/* GPU SS */
-	{ "gpu0-pid", IMX_SC_R_GPU_0_PID0, 4, 1 },
+	{ "gpu0-pid", IMX_SC_R_GPU_0_PID0, 4, true },
 
 	/* HSIO SS */
-	{ "hsio-pcie-b", IMX_SC_R_PCIE_B, 1, 0 },
-	{ "hsio-serdes-1", IMX_SC_R_SERDES_1, 1, 0 },
-	{ "hsio-gpio", IMX_SC_R_HSIO_GPIO, 1, 0 },
+	{ "hsio-pcie-b", IMX_SC_R_PCIE_B, 1, false },
+	{ "hsio-serdes-1", IMX_SC_R_SERDES_1, 1, false },
+	{ "hsio-gpio", IMX_SC_R_HSIO_GPIO, 1, false },
 
 	/* MIPI/LVDS SS */
-	{ "mipi0", IMX_SC_R_MIPI_0, 1, 0 },
-	{ "mipi0-pwm0", IMX_SC_R_MIPI_0_PWM_0, 1, 0 },
-	{ "mipi0-i2c", IMX_SC_R_MIPI_0_I2C_0, 2, 1 },
-	{ "lvds0", IMX_SC_R_LVDS_0, 1, 0 },
+	{ "mipi0", IMX_SC_R_MIPI_0, 1, false },
+	{ "mipi0-pwm0", IMX_SC_R_MIPI_0_PWM_0, 1, false },
+	{ "mipi0-i2c", IMX_SC_R_MIPI_0_I2C_0, 2, true },
+	{ "lvds0", IMX_SC_R_LVDS_0, 1, false },
 
 	/* DC SS */
-	{ "dc0", IMX_SC_R_DC_0, 1, 0 },
-	{ "dc0-pll", IMX_SC_R_DC_0_PLL_0, 2, 1 },
+	{ "dc0", IMX_SC_R_DC_0, 1, false },
+	{ "dc0-pll", IMX_SC_R_DC_0_PLL_0, 2, true },
 };
 
 static const struct imx_sc_pd_soc imx8qxp_scu_pd = {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
