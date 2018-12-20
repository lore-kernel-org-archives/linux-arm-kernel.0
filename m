Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619CFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:50:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7ED21720
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QC3B44hK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pzlIRktV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7ED21720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7MVOApCcWsj7Mly8n60t/UGFqilKodAvbXOR6ezgU6Q=; b=QC3B44hKnm2aWc
	xoAOX1DY0annbFT76gOf+FTBq7oV4K5SXubUu/5N+guwFlU2hMwDLDRFUHeHxTDVT3p69YrXbOkRm
	HhIzHXV1dKGox41wbDNvQpfUepQN8a0zSHSbDFv2yPexisPRDuq+BPCinas7MACybZ6AUzVwUfefV
	v1LetcrQai17On4Pu9X5oeDD8dntOM6xH+SG/V39yL7C81aZss8LugyZhmh1D0XZJqg6GsEDpktNN
	Vkd7Y46tresk/vrpE0HWgkgO/DW7OvkyiEciLqndvjwdSrVoYQmMG5LTJ7iFKvJao3ZCIu9S2tjJg
	RBpAfbKYs6gui1WIFexA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZt60-0001YA-05; Thu, 20 Dec 2018 07:50:16 +0000
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZt5l-0000Uc-FF
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 07:50:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eyy/MrXmAaSLJse9sJv3PoitvJZRCIrqVlFD9uN0f0=;
 b=pzlIRktVwM6TgmBiuYavKd1KqiC15vCV56MYbcSnfXI5Dew1j2CSBtZqEzszyIvTSKecTD0X5JZhV4nLEaIg/jfTen1cdc2nrTJrSNSoQtgMNNPO7sXjv4A6Z3u3Br1yymLBPFxzPiznAX9/vc13h4gsMnxmPMnymXtLhtwPgnA=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.50.97) by
 VI1PR04MB4319.eurprd04.prod.outlook.com (52.134.122.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Thu, 20 Dec 2018 07:49:46 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::cd3d:ce97:132b:7148]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::cd3d:ce97:132b:7148%3]) with mapi id 15.20.1446.018; Thu, 20 Dec 2018
 07:49:46 +0000
From: BOUGH CHEN <haibo.chen@nxp.com>
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, "adrian.hunter@intel.com"
 <adrian.hunter@intel.com>
Subject: [PATCH 2/3] mmc: sdhci-esdhc-imx: add SD clock limitation for imx6ull
Thread-Topic: [PATCH 2/3] mmc: sdhci-esdhc-imx: add SD clock limitation for
 imx6ull
Thread-Index: AQHUmDiTyHn+7tGsDkmINmEMtso26w==
Date: Thu, 20 Dec 2018 07:49:46 +0000
Message-ID: <1545292612-14471-2-git-send-email-haibo.chen@nxp.com>
References: <1545292612-14471-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1545292612-14471-1-git-send-email-haibo.chen@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR03CA0025.apcprd03.prod.outlook.com
 (2603:1096:203:2f::13) To VI1PR04MB5040.eurprd04.prod.outlook.com
 (2603:10a6:803:59::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haibo.chen@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB4319;
 6:86MvgBe15WyCYE21Sk8qKGmCnLRqo+GXSt2dXbaM3GXtQaRakN5xv1yJlnRPtMQavqCoujFMME8h5b2QoyO/NHoWwGSgya+rGjzZ2gQFwjixwqbaSX2La7MRYSBEGHmADcppP4W00H3lKoSCWr+qW97iZO6rZ6hDaNYFe6CUX55gK69EK/jIu1YMP2MQg3ByHSyhRsL8fQZsFFYBuR8gGso64eZ8olknm7cUK5S62ly9eiWRI86RlcBOxmrT5QQ4CcJn55/4G6o+O8PJIFmjFu4zdhYuQLegJ0iMzwTKLAnJnxnpxomufmM+nZeCPmKE/KFhaMOmPr8I/ajTp2qD2TFWiWDWTB1Z+I9NNtieoJ8ZjvH0YX5PXEn+SgnbCMyjcj0U2IgXNGmt+fgbCqx5NXPjQYNd8CLeKG6l9CBUdbzaOEtIn77Rv8MHLFYTs0+zOpgRVJE+s9Ivr//SzFrYqA==;
 5:uK8JaU1YwF/XU6GtKmNmhvkxZvkiWJqp0tJZYkIXscWJIwd7XxGT/1DF7bjKQ96p59WYNaAYefnEFvrM0rx8yMJUbDG6rcqBU2oPEDRVw+mpo4UUTLfJ4wi6CQVKJ39nemRZbwGtB3/AqcXjoMEDaEn7WeNASdurv/U+UbIXOPg=;
 7:OG8m4uu30oBtc0pMIxtWXZsPe0+tAan64dO0oxGsKwD0KbU5ywU9IREbRa7vKwDIhBVpdRwGdNKsRP4MSF9mD2YTlNkoyPh5H+XLd9O9YW72pHZ2NDiOT7rUrsvutplHYIbeMoE1F+j5NANduq/Qmg==
x-ms-office365-filtering-correlation-id: 5d3c1ed6-b6a0-477e-59b8-08d6664fb615
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4319; 
x-ms-traffictypediagnostic: VI1PR04MB4319:
x-microsoft-antispam-prvs: <VI1PR04MB4319B93AA488C92231C8E8A090BF0@VI1PR04MB4319.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB4319; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB4319; 
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(396003)(366004)(39860400002)(376002)(136003)(199004)(189003)(305945005)(6436002)(6486002)(7416002)(105586002)(7736002)(106356001)(386003)(6506007)(2501003)(14444005)(76176011)(52116002)(3846002)(6116002)(102836004)(54906003)(110136005)(316002)(256004)(53936002)(53346004)(86362001)(446003)(8936002)(476003)(575784001)(5660300001)(66066001)(478600001)(81166006)(99286004)(6512007)(2616005)(8676002)(11346002)(486006)(4326008)(81156014)(68736007)(71190400001)(97736004)(186003)(2201001)(26005)(71200400001)(50226002)(14454004)(2906002)(25786009)(36756003)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4319;
 H:VI1PR04MB5040.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kmgNAxu8nXe8xiG7ddzW9MoNVYfq9gA/NhiBOIGeDLbkpzb7ID60BSCtWdh3TEoEYr7nPNdsd+ytdDdrhq0AHhKAjYpgCAd7nyNKharzmvRmGvDjuc48/g8UICmNED8FpcK9lhvZ7BGRL7x+bOQJiduhyggMzJIWk/oSVJHebvwZIUk8gt90l739nA4GwAm18YLwm0RlW+EKD2wNPx555QsGpvYzC7yFb6+F5ASBWfHoGUWQ14iqcZbWi4VvgOiKZFqX2w4JxboQZy7rJTHMeFjywHmtCmpO8TeznSEIy3AHdWLFgG/m13NdJIW8qqsQ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3c1ed6-b6a0-477e-59b8-08d6664fb615
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 07:49:46.9030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4319
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_235002_219555_36596D00 
X-CRM114-Status: GOOD (  15.46  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

i.MX6ULL has errata ERR010450, point out that due to SOC I/O
timing limitation, for eMMC HS200 and SD/SDIO 3.0 SDR104, the
clock rate can't exceed 150MHz. And for eMMC DDR52 and SD/SDIO
DDR50 mode, the clock rate can't exceed 45MHz.

This patch add this limit for imx6ull.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index d0d3193..75a2484 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -138,7 +138,11 @@
 #define ESDHC_FLAG_HS200		BIT(8)
 /* The IP supports HS400 mode */
 #define ESDHC_FLAG_HS400		BIT(9)
-
+/* The IP has errata ERR010450
+ * uSDHC: Due to the I/O timing limit, for SDR mode, SD card clock can't
+ * exceed 150MHz, for DDR mode, SD card clock can't exceed 45MHz.
+ */
+#define ESDHC_FLAG_ERR010450           BIT(10)
 /* A clock frequency higher than this rate requires strobe dll control */
 #define ESDHC_STROBE_DLL_CLK_FREQ	100000000
 
@@ -177,6 +181,12 @@ struct esdhc_soc_data {
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,
 };
 
+static struct esdhc_soc_data usdhc_imx6ull_data = {
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
+			| ESDHC_FLAG_ERR010450,
+};
+
 static struct esdhc_soc_data usdhc_imx7d_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
@@ -227,6 +237,7 @@ struct pltfm_imx_data {
 	{ .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },
 	{ .compatible = "fsl,imx6sl-usdhc", .data = &usdhc_imx6sl_data, },
 	{ .compatible = "fsl,imx6q-usdhc", .data = &usdhc_imx6q_data, },
+	{ .compatible = "fsl,imx6ull-usdhc", .data = &usdhc_imx6ull_data, },
 	{ .compatible = "fsl,imx7d-usdhc", .data = &usdhc_imx7d_data, },
 	{ /* sentinel */ }
 };
@@ -733,6 +744,12 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 		| ESDHC_CLOCK_MASK);
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
 
+	if (imx_data->socdata->flags & ESDHC_FLAG_ERR010450) {
+		if (imx_data->is_ddr)
+			clock = clock > 45000000 ? 45000000 : clock;
+		else
+			clock = clock > 150000000 ? 150000000 : clock;
+
 	while (host_clock / (16 * pre_div * ddr_pre_div) > clock &&
 			pre_div < 256)
 		pre_div *= 2;
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
