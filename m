Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C61CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:39:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35E2620880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kv9DIfS/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MVoegQ3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E2620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZGH88Ou8IXdGY01F5bQBD+DCreKIjXzBa0tH8xbNZa4=; b=Kv9DIfS/k71Bor
	64B274S9+vi2IGMfcn8AX61piH5XYbbBqjFVYSg5P75melQjtSm3SX0Ls6xkOP2MkbDRR7bIQYd38
	ieJnq7NbGIy3v1CrQCoo/BO00+yW7jM7XozhPQmonq1NvqFOU6K14LC8TvrZmNlTE+FP9ESPJIB9r
	Dy8zkkAI+76mVlK2ygXNMO+qnLVxW7RoQUxA5Vih+F6c+N/rE18Byia/jljjYHv0rU3qt7Z34HZdg
	fJ0KPZbn2ULM7fZj5xh8nUEov5bcuk2HORFEp2dWNTYrxQQ99GaVeITV64E07zD7d2IpyvKOpZM+s
	QC8kbpUODdY5/3Q+3wcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwT1j-0004hN-BO; Wed, 20 Feb 2019 14:39:11 +0000
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwT1E-0003xo-Vq
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 14:38:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDhpSEnggYlC4rAniuU47I3jqCrYlqv1+iNpmmAMQCU=;
 b=MVoegQ3YrjtBihRJ0CnhbJB+FpTUAYz8q+tUPtioUXf1EI556UvS4Ae7P8MTy9RGEwq+9btY3QlTkYGcRkjz7t9mkKq6UavySD2hoeAXAG/Aj+dpioxVsx2d/+p0GiRq7qJnipKvi3dUUqIYvNod7XYhDdvNPnVNXSznOkhlkf0=
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com (52.135.168.141) by
 AM6PR04MB4917.eurprd04.prod.outlook.com (20.177.33.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Wed, 20 Feb 2019 14:38:36 +0000
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08]) by AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08%5]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 14:38:36 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 3/3] firmware: imx: scu-pd: decouple the SS information from
 domain names
Thread-Topic: [PATCH 3/3] firmware: imx: scu-pd: decouple the SS information
 from domain names
Thread-Index: AQHUySn2+FLHWnHhe0qpwYe4cxsiAA==
Date: Wed, 20 Feb 2019 14:38:36 +0000
Message-ID: <1550673013-21462-4-git-send-email-aisheng.dong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 8d49c6de-a761-450d-1255-08d697411897
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4917; 
x-ms-traffictypediagnostic: AM6PR04MB4917:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; AM6PR04MB4917;
 23:NBRuCZ/yxqn+58FGUJIQYL4GmzZBBHIDV2zmuqf?=
 =?iso-8859-1?Q?/cAEnZo9hIQeWqxKgI+NUeVolwXljrgcmHcvnu8AYn2bltqsJ95kTUyLDe?=
 =?iso-8859-1?Q?kVwY0KHBoQeRvQJgtNP9E3jlyYemABT0YVnYx97vKTqyUkqERc/6eGxiL6?=
 =?iso-8859-1?Q?FGGITvKkGSPHJj5JMJR2Pb15DAW49PbZ83AqZzQcNBGoZqzkGyo3EE0L3I?=
 =?iso-8859-1?Q?CUsD3itt5q7Psmih1XbjEKj2MPKzuWGrU/L8pasjGL3br7dp8xpNvt1Oe5?=
 =?iso-8859-1?Q?K5fssQ5nDsLcR81u+cr0arEzVYb9mA02aSW8CEa8bAbxHbzgBcFeeUfRYt?=
 =?iso-8859-1?Q?AgyX9LZp9t9UnB3CiZAUZlrvmc3FzPNZkPuVbw7j5YuoJVKHnAW/YQf1Zi?=
 =?iso-8859-1?Q?3s7WF+4pr5hdEiJU8248nXDD6ffKsZi/UJPPstOHN7vPXoa8tR4JP6zMe3?=
 =?iso-8859-1?Q?NmNCEwB3CuvHb864FPezCdbaOzGtccWeIw/C+Fto6epoKawUJMv1z6Dfro?=
 =?iso-8859-1?Q?TEbBz48dP4u4VffbziUHMmdTtiHyt5dGyBF1kU32qFl+MmCDpnCCA7qK4V?=
 =?iso-8859-1?Q?+R/puzuGC9HLIOMFQddEZBeiVkkOFnkGePUneGY7FcpQM23JiQ4zSuwU5n?=
 =?iso-8859-1?Q?XNtlTwYdiM+uiLUrB2kUbm/WkKULXBSrfGN77/cTz83uKVRrn9nmXNnavO?=
 =?iso-8859-1?Q?KqTBlsHWGNnG2YwILro/MGC6JQt7UH6r6F/HHDAATIE+4H78C13Pe0wa/I?=
 =?iso-8859-1?Q?VnKsWJdrwNmqD+H6q7hbkAcn4uT/Der0nw21EkPUvIeIWEVZhtI6YTJkfP?=
 =?iso-8859-1?Q?lDRlVW4vxXWtTpMrxaTiTDfdzacjtGwKUM1M+bndqOJtYeZA4ZF05pFrHY?=
 =?iso-8859-1?Q?3MFrtV59qacmxjW7hSFTpmqMJORoR5wDCro0eX5qOYR7btvYuc4UFV1ZO9?=
 =?iso-8859-1?Q?xE/VEdh0LdhELxe1KeaARwi/OBOYxBRRCkdFdgKdUm5UvK+HHYH+LJUuVm?=
 =?iso-8859-1?Q?ZZUPL80KanceHT71AXkoPtlH76IdWp8DQE6bG25xYWdKXaCMd4LdlXeHL7?=
 =?iso-8859-1?Q?1NpMIT3Dx3ieFOmEZl1fMf0l7GFK4OA4ZwzIG7tBcUVF6dgjw7HFAtxd+r?=
 =?iso-8859-1?Q?TBNiU/UwA/0bRebu2uxts1WVNwEEeHY975XLvPW1reN5EtTIN2+MGE9dhU?=
 =?iso-8859-1?Q?uPbcHbyNkHsSw7DotlrXUJ17ap40rDfor8B7UZhMDYu5IMSPaEo2yqDG8O?=
 =?iso-8859-1?Q?+5BKYtUOGOLXAZ9JdC5kp19kVbtgUGM3h+cUCMgtNy3tQz7GRtjH53+Ijv?=
 =?iso-8859-1?Q?Y2tjB2wT5FHBgw1hPbCcCgu?=
x-microsoft-antispam-prvs: <AM6PR04MB49170A10C35C02A58BF64720807D0@AM6PR04MB4917.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(136003)(346002)(366004)(39860400002)(189003)(199004)(8676002)(305945005)(97736004)(71190400001)(7736002)(14454004)(81166006)(8936002)(256004)(52116002)(2906002)(81156014)(2501003)(478600001)(6512007)(50226002)(5660300002)(71200400001)(53936002)(68736007)(316002)(54906003)(6486002)(6506007)(6436002)(106356001)(44832011)(86362001)(36756003)(5640700003)(2616005)(486006)(6916009)(186003)(3846002)(476003)(4326008)(25786009)(6116002)(26005)(99286004)(102836004)(2351001)(446003)(11346002)(386003)(105586002)(66066001)(76176011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4917;
 H:AM6PR04MB4215.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kffireKtF0YuodszUh3QrxhnweAXS/5rIemMk8eoI8M62swxREBd/+TM1KUYT8oT39+C5U/YYzpAgqzD5faSK+Zoy/gD0osZINloywuGadPsghgF8kM4YEWsmQE25FIbQ0ygFVozTEpv2J/oRB/ZQZijVmqAuCBorNX0NoBakG6yG1RhT9+yttZ+YhV4ZJAsKv9nO9gJsT0euF/6sLtgG+FLg3fRjzhn2PaswZCKVmIooecJbQOzs/ZUD2bpjjBus8EOR11MmrqmYqFyovoMjAwQb+4MHyd8mW4ouTHb/pP75H5ulr/OlVISVeYk1D0Q0yl+1yHeSrZTJEBSid+UCYnYK001SQpyCZFtbn+kZD39zRyifQkqGdGCUlBavmzZevlvTKC6DpZ0dQ2gZjwjNO/R3MXa/8IHIF+iVNQGd7Q=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d49c6de-a761-450d-1255-08d697411897
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 14:38:32.6031 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4917
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_063841_229290_DFE25BAA 
X-CRM114-Status: GOOD (  12.30  )
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

As resource power domain service is provided by SCU firmware, no
SS information required. So we can remove the SS indicator from
the domain names, then the domains defined can be better shared
among different SCU based platforms.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 92 ++++++++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 44 deletions(-)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index 48f49f8..cd745b9 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -87,49 +87,51 @@ struct imx_sc_pd_soc {
 
 static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	/* LSIO SS */
-	{ "lsio-pwm", IMX_SC_R_PWM_0, 8, true, 0 },
-	{ "lsio-gpio", IMX_SC_R_GPIO_0, 8, true, 0 },
-	{ "lsio-gpt", IMX_SC_R_GPT_0, 5, true, 0 },
-	{ "lsio-kpp", IMX_SC_R_KPP, 1, false, 0 },
-	{ "lsio-fspi", IMX_SC_R_FSPI_0, 2, true, 0 },
-	{ "lsio-mu", IMX_SC_R_MU_0A, 14, true, 0 },
+	{ "pwm", IMX_SC_R_PWM_0, 8, true, 0 },
+	{ "gpio", IMX_SC_R_GPIO_0, 8, true, 0 },
+	{ "gpt", IMX_SC_R_GPT_0, 5, true, 0 },
+	{ "kpp", IMX_SC_R_KPP, 1, false, 0 },
+	{ "fspi", IMX_SC_R_FSPI_0, 2, true, 0 },
+	{ "mu", IMX_SC_R_MU_0A, 14, true, 0 },
 
 	/* CONN SS */
-	{ "con-usb", IMX_SC_R_USB_0, 2, true, 0 },
-	{ "con-usb0phy", IMX_SC_R_USB_0_PHY, 1, false, 0 },
-	{ "con-usb2", IMX_SC_R_USB_2, 1, false, 0 },
-	{ "con-usb2phy", IMX_SC_R_USB_2_PHY, 1, false, 0 },
-	{ "con-sdhc", IMX_SC_R_SDHC_0, 3, true, 0 },
-	{ "con-enet", IMX_SC_R_ENET_0, 2, true, 0 },
-	{ "con-nand", IMX_SC_R_NAND, 1, false, 0 },
-	{ "con-mlb", IMX_SC_R_MLB_0, 1, true, 0 },
-
-	/* Audio DMA SS */
-	{ "adma-audio-pll0", IMX_SC_R_AUDIO_PLL_0, 1, false, 0 },
-	{ "adma-audio-pll1", IMX_SC_R_AUDIO_PLL_1, 1, false, 0 },
-	{ "adma-audio-clk-0", IMX_SC_R_AUDIO_CLK_0, 1, false, 0 },
-	{ "adma-dma0-ch", IMX_SC_R_DMA_0_CH0, 16, true, 0 },
-	{ "adma-dma1-ch", IMX_SC_R_DMA_1_CH0, 16, true, 0 },
-	{ "adma-dma2-ch", IMX_SC_R_DMA_2_CH0, 5, true, 0 },
-	{ "adma-asrc0", IMX_SC_R_ASRC_0, 1, false, 0 },
-	{ "adma-asrc1", IMX_SC_R_ASRC_1, 1, false, 0 },
-	{ "adma-esai0", IMX_SC_R_ESAI_0, 1, false, 0 },
-	{ "adma-spdif0", IMX_SC_R_SPDIF_0, 1, false, 0 },
-	{ "adma-sai", IMX_SC_R_SAI_0, 3, true, 0 },
-	{ "adma-amix", IMX_SC_R_AMIX, 1, false, 0 },
-	{ "adma-mqs0", IMX_SC_R_MQS_0, 1, false, 0 },
-	{ "adma-dsp", IMX_SC_R_DSP, 1, false, 0 },
-	{ "adma-dsp-ram", IMX_SC_R_DSP_RAM, 1, false, 0 },
-	{ "adma-can", IMX_SC_R_CAN_0, 3, true, 0 },
-	{ "adma-ftm", IMX_SC_R_FTM_0, 2, true, 0 },
-	{ "adma-lpi2c", IMX_SC_R_I2C_0, 4, true, 0 },
-	{ "adma-adc", IMX_SC_R_ADC_0, 1, true, 0 },
-	{ "adma-lcd", IMX_SC_R_LCD_0, 1, true, 0 },
-	{ "adma-lcd0-pwm", IMX_SC_R_LCD_0_PWM_0, 1, true, 0 },
-	{ "adma-lpuart", IMX_SC_R_UART_0, 4, true, 0 },
-	{ "adma-lpspi", IMX_SC_R_SPI_0, 4, true, 0 },
-
-	/* VPU SS  */
+	{ "usb", IMX_SC_R_USB_0, 2, true, 0 },
+	{ "usb0phy", IMX_SC_R_USB_0_PHY, 1, false, 0 },
+	{ "usb2", IMX_SC_R_USB_2, 1, false, 0 },
+	{ "usb2phy", IMX_SC_R_USB_2_PHY, 1, false, 0 },
+	{ "sdhc", IMX_SC_R_SDHC_0, 3, true, 0 },
+	{ "enet", IMX_SC_R_ENET_0, 2, true, 0 },
+	{ "nand", IMX_SC_R_NAND, 1, false, 0 },
+	{ "mlb", IMX_SC_R_MLB_0, 1, true, 0 },
+
+	/* AUDIO SS */
+	{ "audio-pll0", IMX_SC_R_AUDIO_PLL_0, 1, false, 0 },
+	{ "audio-pll1", IMX_SC_R_AUDIO_PLL_1, 1, false, 0 },
+	{ "audio-clk-0", IMX_SC_R_AUDIO_CLK_0, 1, false, 0 },
+	{ "dma0-ch", IMX_SC_R_DMA_0_CH0, 16, true, 0 },
+	{ "dma1-ch", IMX_SC_R_DMA_1_CH0, 16, true, 0 },
+	{ "dma2-ch", IMX_SC_R_DMA_2_CH0, 5, true, 0 },
+	{ "asrc0", IMX_SC_R_ASRC_0, 1, false, 0 },
+	{ "asrc1", IMX_SC_R_ASRC_1, 1, false, 0 },
+	{ "esai0", IMX_SC_R_ESAI_0, 1, false, 0 },
+	{ "spdif0", IMX_SC_R_SPDIF_0, 1, false, 0 },
+	{ "sai", IMX_SC_R_SAI_0, 3, true, 0 },
+	{ "amix", IMX_SC_R_AMIX, 1, false, 0 },
+	{ "mqs0", IMX_SC_R_MQS_0, 1, false, 0 },
+	{ "dsp", IMX_SC_R_DSP, 1, false, 0 },
+	{ "dsp-ram", IMX_SC_R_DSP_RAM, 1, false, 0 },
+
+	/* DMA SS */
+	{ "can", IMX_SC_R_CAN_0, 3, true, 0 },
+	{ "ftm", IMX_SC_R_FTM_0, 2, true, 0 },
+	{ "lpi2c", IMX_SC_R_I2C_0, 4, true, 0 },
+	{ "adc", IMX_SC_R_ADC_0, 1, true, 0 },
+	{ "lcd", IMX_SC_R_LCD_0, 1, true, 0 },
+	{ "lcd0-pwm", IMX_SC_R_LCD_0_PWM_0, 1, true, 0 },
+	{ "lpuart", IMX_SC_R_UART_0, 4, true, 0 },
+	{ "lpspi", IMX_SC_R_SPI_0, 4, true, 0 },
+
+	/* VPU SS */
 	{ "vpu", IMX_SC_R_VPU, 1, false, 0 },
 	{ "vpu-pid", IMX_SC_R_VPU_PID0, 8, true, 0 },
 	{ "vpu-dec0", IMX_SC_R_VPU_DEC_0, 1, false, 0 },
@@ -139,14 +141,16 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "gpu0-pid", IMX_SC_R_GPU_0_PID0, 4, true, 0 },
 
 	/* HSIO SS */
-	{ "hsio-pcie-b", IMX_SC_R_PCIE_B, 1, false, 0 },
-	{ "hsio-serdes-1", IMX_SC_R_SERDES_1, 1, false, 0 },
+	{ "pcie-b", IMX_SC_R_PCIE_B, 1, false, 0 },
+	{ "serdes-1", IMX_SC_R_SERDES_1, 1, false, 0 },
 	{ "hsio-gpio", IMX_SC_R_HSIO_GPIO, 1, false, 0 },
 
-	/* MIPI/LVDS SS */
+	/* MIPI SS */
 	{ "mipi0", IMX_SC_R_MIPI_0, 1, false, 0 },
 	{ "mipi0-pwm0", IMX_SC_R_MIPI_0_PWM_0, 1, false, 0 },
 	{ "mipi0-i2c", IMX_SC_R_MIPI_0_I2C_0, 2, true, 0 },
+
+	/* LVDS SS */
 	{ "lvds0", IMX_SC_R_LVDS_0, 1, false, 0 },
 
 	/* DC SS */
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
