Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1D7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:26:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F5912087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TWe7T1ya";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SpVGQoN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5912087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JHECfXwom+2yDLDJouh3EQ/OMyjl1RvwkBn4Mdhcat0=; b=TWe7T1yaDaN22J
	nzaqZ2+vS/6d/+O9OXNwPCl5vHRDe9jMecNB+Cu5sXiIifNZt+qexsUAwkI3QbPIL6Nn+rUrOJlIa
	tnd0AEhsdFxSMm5KnWJ03hxCFRak+ho8x50nmKQxWG2ffxFxkO+CdjpwycDzzsUnrfgqzbDJLq94J
	Mfc4fQ++I1kMcsE4HZwgQe4auJQ9NK8n3M4HiqVeyeVgLBpgqFuQLaYNjocZAKJSYkUW7zggr1yv1
	n2wjBmA1J6j0jCl256DFGdCO7tV5ySdDz+C41lGyY0HbHgCD+tscASwUXpo5GEUXCUh4/bcq+1mLr
	r76DpG4jkWgPB6J/n3mA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcinH-0007GI-Me; Fri, 28 Dec 2018 03:26:39 +0000
Received: from mail-eopbgr60079.outbound.protection.outlook.com ([40.107.6.79]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcin1-00071s-Fy
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 03:26:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plG2ljvco3nfMRnvaeCKdR7A1pffA/YItylBmxxDd0Q=;
 b=SpVGQoN8vcVcCrVhq+cGthBNYyE3Zu9qjI6T2HFVZ8S0IPHkTmN4FRYTBPo9k8Gl2BFXc0IiMjxBa6Urx5/1wQYSC+DJ4rlWtm92YslrxdSFznMUrZe9HhREWqV7gKfUYV0AWjQwNPuyDTZvWG4i9HoIc10sGzl3QPFw/K0GL0E=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.50.97) by
 VI1PR04MB6047.eurprd04.prod.outlook.com (20.179.24.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Fri, 28 Dec 2018 03:26:10 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::cd3d:ce97:132b:7148]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::cd3d:ce97:132b:7148%3]) with mapi id 15.20.1471.019; Fri, 28 Dec 2018
 03:26:10 +0000
From: BOUGH CHEN <haibo.chen@nxp.com>
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH v2 2/3] mmc: sdhci-esdhc-imx: add SD clock limitation for
 imx6ull
Thread-Topic: [PATCH v2 2/3] mmc: sdhci-esdhc-imx: add SD clock limitation for
 imx6ull
Thread-Index: AQHUnl0Tx2I9di4OK0SPJzvWAKhVnA==
Date: Fri, 28 Dec 2018 03:26:10 +0000
Message-ID: <20181228033323.32308-2-haibo.chen@nxp.com>
References: <20181228033323.32308-1-haibo.chen@nxp.com>
In-Reply-To: <20181228033323.32308-1-haibo.chen@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: HK2PR02CA0141.apcprd02.prod.outlook.com
 (2603:1096:202:16::25) To VI1PR04MB5040.eurprd04.prod.outlook.com
 (2603:10a6:803:59::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haibo.chen@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB6047;
 6:twCR9u+bBrhgOFkwtD0RmO1SY5W809HHH8wgrFhzHyBtiBsitUN9126hE4O0ZSzOlmRfsQN2me+El2HnJRpZyZpHi2osm9fmzNJu0kHJ6Fym9AuBVpTNBovLAp96FK2/adqShYB0fPkCGmLMpHmmGInG+lITiAAjQDQ7AXqtjRYahcBBJUmXOrg6T4MxstEGPfbRtsNVC89XQn3RuQVi47IanIss+0FbZPGUfXjO0USAi1MpOZHB+ix0Jyte2lciLaZMQfnl//mYh6r8DpdmC/MpMvIA8D2EAai3vLAIysLIuBEbwVcdPCJ2LXsrA8lD3NP6xnWLOwPKxAzHwgdpp+uvaD3r+KQ2/b/NmjWQqbwOfPE+UqoAFE/3WGZIynFbEdXWJl4pb7njV2SUUmmwc1P19tz0lLQ1GgSioYYk3BaxdnWGX5xKnETM2z/uHMrs3jXFCoInqRhIuivBF841AA==;
 5:d/Q7gc1bmz1QGQ6wkdSKCDlWOCkQ4jQV1zMjJEBDhdeteVnr8xIoxH8P576CNwamGzY+wbzws574kc6HdzD8zASSwhN5j9l+2i8AxkjbLGgZabyD1IgkXoGp0NToAlV1fS+6PFJphR4N01vg9S5w0XhmTmCAnrA8PakArwTi3s8=;
 7:ChjhmGFqS4hqALCX3Ybevx/u0gWwuugVjwfVmiFxfp2Qg/O+R2FNcyQwjP4NoN5b2wTYa9+bG2196FCA0aDGLsdQSGafCZYQ8aqzUhhIw+efWAjoES/ky+vhUP885JqItnUILbNwPZ+IIUYsQfHzwQ==
x-ms-office365-filtering-correlation-id: ad826683-c679-4060-7e8d-08d66c743631
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB6047; 
x-ms-traffictypediagnostic: VI1PR04MB6047:
x-microsoft-antispam-prvs: <VI1PR04MB6047FF248A7DC7E02518B75790B70@VI1PR04MB6047.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220051)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB6047; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB6047; 
x-forefront-prvs: 09007040D4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(396003)(366004)(39860400002)(346002)(136003)(199004)(189003)(2906002)(68736007)(7736002)(5660300001)(86362001)(36756003)(6116002)(3846002)(102836004)(8936002)(26005)(52116002)(81166006)(81156014)(386003)(6506007)(76176011)(8676002)(186003)(106356001)(105586002)(305945005)(446003)(50226002)(71190400001)(71200400001)(478600001)(66066001)(53346004)(7416002)(25786009)(316002)(11346002)(97736004)(14454004)(1076003)(6436002)(256004)(476003)(14444005)(6486002)(54906003)(99286004)(110136005)(486006)(2201001)(6512007)(4326008)(2616005)(2501003)(53936002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB6047;
 H:VI1PR04MB5040.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k2FRwqp1Mo7rF/xzxjpS24Q3x0DJIbjpWquUcx+3ovZT4aWkjj8Teyf57Jdt9+ZQ2Oa12zgyH3an+RamJZSUwDMo0N4Dhki20txHf6GcHcH8kLOJrm07lFtJOHhV4bQ5m8rEzWnmtZlhq2pfTsceyVErRL7lqr2/ujy6wOq7ECr8wnESsgBDGqFKtCttlh2KP5nmyE+nsn3SP7qQl6RziYLVdjPXlibBUnJ4/Qkvsa7nwYPTxFMkzzpqAV5nGc3h1iqf8ut8AW44xpraWZh++quV88ifdwoC1K5JPSP7gFwFArhXZRWm6eg3UWixF40x
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad826683-c679-4060-7e8d-08d66c743631
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2018 03:26:10.3925 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6047
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_192623_528656_DA67435E 
X-CRM114-Status: GOOD (  14.49  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 7cfcc8618e45..e1d9b2985979 100644
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
 
@@ -177,6 +181,12 @@ static struct esdhc_soc_data usdhc_imx6sx_data = {
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
@@ -227,6 +237,7 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
 	{ .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },
 	{ .compatible = "fsl,imx6sl-usdhc", .data = &usdhc_imx6sl_data, },
 	{ .compatible = "fsl,imx6q-usdhc", .data = &usdhc_imx6q_data, },
+	{ .compatible = "fsl,imx6ull-usdhc", .data = &usdhc_imx6ull_data, },
 	{ .compatible = "fsl,imx7d-usdhc", .data = &usdhc_imx7d_data, },
 	{ /* sentinel */ }
 };
@@ -733,6 +744,14 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 		| ESDHC_CLOCK_MASK);
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
 
+	if (imx_data->socdata->flags & ESDHC_FLAG_ERR010450) {
+		unsigned int max_clock;
+
+		max_clock = imx_data->is_ddr ? 45000000 : 150000000;
+
+		clock = min(clock, max_clock);
+	}
+
 	while (host_clock / (16 * pre_div * ddr_pre_div) > clock &&
 			pre_div < 256)
 		pre_div *= 2;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
