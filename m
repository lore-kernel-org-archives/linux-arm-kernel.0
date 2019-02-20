Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A58DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:39:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2C6220880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oiIaTJw3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XxmOpcnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C6220880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hAwE1UMRNgXtBWo4f3HVMs9AxAq/HpZ6sZBZSR7Ht9g=; b=oiIaTJw3YqW/JX
	Oi+8OS294pcn3knvGUL/tGvzRwW7uCk5WZtkK2VX45f/xs7VbLMYKMxxYFQcSC97EKaJ3kbu68gz5
	xFz/LVrqT7U8bSEKmFwURK/DqF7rtjWzb3rQFfUdGT+Xt/n4Ggu8kuxUcASc4vdV0VFEhqflW3308
	gGbysC8yTaHOH63Q4TdQi3oUppKgCTRvN6T0+3xqq73N8zXEn4STsXMFbL3NR2fgkoWW2pL93eG2W
	uvjTNKOx19UnU80l7Zrfh3LRZ/hdqX5oj5p70atvybDdZt9z7Ij4Db279kbNINcoM4XvOolRcLUmy
	ucAP3z9Vg51kMh+D14uQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwT1a-0004Wm-1j; Wed, 20 Feb 2019 14:39:02 +0000
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwT1A-0003xo-Ji
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 14:38:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ak0QI4FLDmz+3K3gAafFknYubcu67aygP29laHcERRI=;
 b=XxmOpcnEju6ySY82U38YXaIhnDT0q6q/Tn9eMSnnWMZbKyR/FBEA/XcHaM0Xbr5y99pJnDCnOjl0Z+rN8AtCDjAQ1OYJjnyCCXRuAg2h4D6o/i4fCHwA0TjArkTtNJ4+s5UcCUaeDGcf3zD6xHFyQiE1qtc1ilBM6nyKA0FHVFk=
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com (52.135.168.141) by
 AM6PR04MB4917.eurprd04.prod.outlook.com (20.177.33.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Wed, 20 Feb 2019 14:38:32 +0000
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08]) by AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08%5]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 14:38:32 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/3] firmware: imx: scu-pd: add specifying the base of domain
 name index support
Thread-Topic: [PATCH 2/3] firmware: imx: scu-pd: add specifying the base of
 domain name index support
Thread-Index: AQHUySnzT3LuEyPLMk+uBr46yFYt2Q==
Date: Wed, 20 Feb 2019 14:38:32 +0000
Message-ID: <1550673013-21462-3-git-send-email-aisheng.dong@nxp.com>
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
x-ms-office365-filtering-correlation-id: dc9a5663-8058-4c5a-f6bb-08d697411602
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4917; 
x-ms-traffictypediagnostic: AM6PR04MB4917:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; AM6PR04MB4917;
 23:f7ai5DYNf+/XIU9CWXWldulaNYG8KhIGNfxCmaO?=
 =?iso-8859-1?Q?9Gf1b5PlT+AUHyCwPdaF5NVX1uYTFbA6jJYB8d5evujQD2CxIiCBmMTNcn?=
 =?iso-8859-1?Q?yuHia5I2LRvsCgKE71koJrmT5ISxrR+P2bwMv8c3GfO1Rp9JyX++XfQrzq?=
 =?iso-8859-1?Q?OxBwPHjNRLQIkJrBw84f86bMv1r0bneRGTBlstMuU+SAvQdGRUIMZOJhuR?=
 =?iso-8859-1?Q?VSFLcHla6DpMwZmawzcPoTs60GPdCiwTazwaIe7OBPkmJwAeAeGnqECE+x?=
 =?iso-8859-1?Q?0hkeETJE9baZJRJ9/UVYS/iyQkxFV/BYjEHwF8KXrkbvJroe5pqfJkLg1R?=
 =?iso-8859-1?Q?Zamt054lG7mHCyOfriTMuNHP1wnTHsUy3hM6C7hhr36PiFzXe7LH3KBIzH?=
 =?iso-8859-1?Q?nqfp1W9WY6P0F366ORrJkGNo9geDwDWNVl/lxKpfABn4z5qevhIYtKYpAz?=
 =?iso-8859-1?Q?rwGcd1vxUughYHBUKeghMVq926MZBaD5aUANuNhUDT1gsl2MAUQ6VEz0pU?=
 =?iso-8859-1?Q?QTJPU8AnlRpWEbmOxsHzb4w2/n4NxLG6WoZM2X9CC4hbRsmUX2lczCgFFC?=
 =?iso-8859-1?Q?Wo3ZXLnUgs3LisTJDGDPe0Wql0YJ0Szb0K1KEPDgfkt2gh+qG967UJ7clG?=
 =?iso-8859-1?Q?GiyNQXxmRif4CRx4nP1VEIZVgpnXjnAIxw1FzK92lGiLmjGqTWLW202FiH?=
 =?iso-8859-1?Q?PQzagaueN8UKcW3JisJWsR9DjkxQTC+tVs+4F9GwKN59Lm6s0y+fP8idZI?=
 =?iso-8859-1?Q?TPmfdfdy+JDnHwLKrMlrAfupoBeD6ku/X0Df918nEhTaFdDztzYE6RDQ64?=
 =?iso-8859-1?Q?B06W0POoOgeRQM8d1Pg2hWTYWSuYQ9h/J4zkkflXruIXoLo4XpbptlH8Is?=
 =?iso-8859-1?Q?zv4kgy3JlrBKFhhfF7XVcrEk2+U/Qa1KLfJgh2kEC3ebrTE19KDqXvEEt9?=
 =?iso-8859-1?Q?JE6k6+/tLCLuDVCP7WfBajWLn2olrS7OXF30dhAVt0KHIy8ub7Bf+dSfJv?=
 =?iso-8859-1?Q?zmue99r1pWA9FcylPD7OCosSvgfdKBJKFtTmd2r8E8wfKRn/B+NvKVA7k2?=
 =?iso-8859-1?Q?QmfGRuUCjeNRb4ihLDl1++r9vSryZyYlQl0sEDSILe5ErSVmBNEL/k//MJ?=
 =?iso-8859-1?Q?NzGaX5Wi05/cIq9PRUqNSccMqK6lAFH9COgR8SyNUFwie8yh/t1LYx039E?=
 =?iso-8859-1?Q?0DVmsEtrF0p6QrXWnVquS+OKcqQ1skQdX+hRM9diDRmSNJRt+Zy4KIx+AX?=
 =?iso-8859-1?Q?eJPxFXB/m4DnDdzxHUCM/eosrYH/MMpdOTDM0ezShxeKXvvnZZ89vWxx1i?=
 =?iso-8859-1?Q?K/tX6Cvg+mvm0e4k0vxaC8Z?=
x-microsoft-antispam-prvs: <AM6PR04MB4917A312A5FF6D556443A671807D0@AM6PR04MB4917.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(136003)(346002)(366004)(39860400002)(189003)(199004)(8676002)(305945005)(97736004)(71190400001)(7736002)(14454004)(81166006)(8936002)(256004)(52116002)(2906002)(81156014)(2501003)(478600001)(6512007)(50226002)(5660300002)(71200400001)(53936002)(68736007)(316002)(54906003)(6486002)(6506007)(6436002)(106356001)(44832011)(86362001)(36756003)(5640700003)(2616005)(486006)(6916009)(186003)(3846002)(476003)(4326008)(25786009)(6116002)(26005)(99286004)(102836004)(2351001)(446003)(11346002)(386003)(105586002)(66066001)(76176011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4917;
 H:AM6PR04MB4215.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /C6bTEAhdNO9hy2kv8daxTjKLl2NXhGl7JzLz7FGo4xFzO9wnFcwmHV53NswuHkGUA/Kgh82DCnp6cikGX2rTPXVr5TyH26hkfgZCAB4Zvssje1AORRE9xQ7UG4gDxvlaS3GQ1A2PTEsvSNrM3OkAxLiI7gTTc11rsZUwGc1SU9iEKC1rJ05MV274NKupMQeG9mRM3g5SzLxs9S5WwgEBfBNgzZQw1W/grpftrrT+NVnnieAYed+hkzYMNjIBOS+0ZI5FakqQvrZJ7yU70kf6b4ql//7VlkHK6BuRYBt1XPaANAAFqIRlAK0Nva1tpIocvDHdfiv5id4onhPvmM9fpvDrRYTTRZTqJDcGFowXSSbv9ECYd0SoMoU1m0dnMUhXZ6bhVAHlKeMt/o6dZYMWwDnFGNcJSFwLAktE7Yi3r0=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9a5663-8058-4c5a-f6bb-08d697411602
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 14:38:28.2280 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4917
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_063836_961054_EE835350 
X-CRM114-Status: GOOD (  12.69  )
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

As the domain resource id in the same type may not be continuous, so it's
hard to describe all such power domains with current struct imx_sc_pd_range.

Adding the optional base for domain name index to address this issue.
Then we can add the discrete domains easily later.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 107 ++++++++++++++++++++++--------------------
 1 file changed, 55 insertions(+), 52 deletions(-)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index d1d39d9..48f49f8 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -74,7 +74,10 @@ struct imx_sc_pd_range {
 	char *name;
 	u32 rsrc;
 	u8 num;
+
+	/* add domain index */
 	bool postfix;
+	u8 start_from;
 };
 
 struct imx_sc_pd_soc {
@@ -84,71 +87,71 @@ struct imx_sc_pd_soc {
 
 static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	/* LSIO SS */
-	{ "lsio-pwm", IMX_SC_R_PWM_0, 8, true },
-	{ "lsio-gpio", IMX_SC_R_GPIO_0, 8, true },
-	{ "lsio-gpt", IMX_SC_R_GPT_0, 5, true },
-	{ "lsio-kpp", IMX_SC_R_KPP, 1, false },
-	{ "lsio-fspi", IMX_SC_R_FSPI_0, 2, true },
-	{ "lsio-mu", IMX_SC_R_MU_0A, 14, true },
+	{ "lsio-pwm", IMX_SC_R_PWM_0, 8, true, 0 },
+	{ "lsio-gpio", IMX_SC_R_GPIO_0, 8, true, 0 },
+	{ "lsio-gpt", IMX_SC_R_GPT_0, 5, true, 0 },
+	{ "lsio-kpp", IMX_SC_R_KPP, 1, false, 0 },
+	{ "lsio-fspi", IMX_SC_R_FSPI_0, 2, true, 0 },
+	{ "lsio-mu", IMX_SC_R_MU_0A, 14, true, 0 },
 
 	/* CONN SS */
-	{ "con-usb", IMX_SC_R_USB_0, 2, true },
-	{ "con-usb0phy", IMX_SC_R_USB_0_PHY, 1, false },
-	{ "con-usb2", IMX_SC_R_USB_2, 1, false },
-	{ "con-usb2phy", IMX_SC_R_USB_2_PHY, 1, false },
-	{ "con-sdhc", IMX_SC_R_SDHC_0, 3, true },
-	{ "con-enet", IMX_SC_R_ENET_0, 2, true },
-	{ "con-nand", IMX_SC_R_NAND, 1, false },
-	{ "con-mlb", IMX_SC_R_MLB_0, 1, true },
+	{ "con-usb", IMX_SC_R_USB_0, 2, true, 0 },
+	{ "con-usb0phy", IMX_SC_R_USB_0_PHY, 1, false, 0 },
+	{ "con-usb2", IMX_SC_R_USB_2, 1, false, 0 },
+	{ "con-usb2phy", IMX_SC_R_USB_2_PHY, 1, false, 0 },
+	{ "con-sdhc", IMX_SC_R_SDHC_0, 3, true, 0 },
+	{ "con-enet", IMX_SC_R_ENET_0, 2, true, 0 },
+	{ "con-nand", IMX_SC_R_NAND, 1, false, 0 },
+	{ "con-mlb", IMX_SC_R_MLB_0, 1, true, 0 },
 
 	/* Audio DMA SS */
-	{ "adma-audio-pll0", IMX_SC_R_AUDIO_PLL_0, 1, false },
-	{ "adma-audio-pll1", IMX_SC_R_AUDIO_PLL_1, 1, false },
-	{ "adma-audio-clk-0", IMX_SC_R_AUDIO_CLK_0, 1, false },
-	{ "adma-dma0-ch", IMX_SC_R_DMA_0_CH0, 16, true },
-	{ "adma-dma1-ch", IMX_SC_R_DMA_1_CH0, 16, true },
-	{ "adma-dma2-ch", IMX_SC_R_DMA_2_CH0, 5, true },
-	{ "adma-asrc0", IMX_SC_R_ASRC_0, 1, false },
-	{ "adma-asrc1", IMX_SC_R_ASRC_1, 1, false },
-	{ "adma-esai0", IMX_SC_R_ESAI_0, 1, false },
-	{ "adma-spdif0", IMX_SC_R_SPDIF_0, 1, false },
-	{ "adma-sai", IMX_SC_R_SAI_0, 3, true },
-	{ "adma-amix", IMX_SC_R_AMIX, 1, false },
-	{ "adma-mqs0", IMX_SC_R_MQS_0, 1, false },
-	{ "adma-dsp", IMX_SC_R_DSP, 1, false },
-	{ "adma-dsp-ram", IMX_SC_R_DSP_RAM, 1, false },
-	{ "adma-can", IMX_SC_R_CAN_0, 3, true },
-	{ "adma-ftm", IMX_SC_R_FTM_0, 2, true },
-	{ "adma-lpi2c", IMX_SC_R_I2C_0, 4, true },
-	{ "adma-adc", IMX_SC_R_ADC_0, 1, true },
-	{ "adma-lcd", IMX_SC_R_LCD_0, 1, true },
-	{ "adma-lcd0-pwm", IMX_SC_R_LCD_0_PWM_0, 1, true },
-	{ "adma-lpuart", IMX_SC_R_UART_0, 4, true },
-	{ "adma-lpspi", IMX_SC_R_SPI_0, 4, true },
+	{ "adma-audio-pll0", IMX_SC_R_AUDIO_PLL_0, 1, false, 0 },
+	{ "adma-audio-pll1", IMX_SC_R_AUDIO_PLL_1, 1, false, 0 },
+	{ "adma-audio-clk-0", IMX_SC_R_AUDIO_CLK_0, 1, false, 0 },
+	{ "adma-dma0-ch", IMX_SC_R_DMA_0_CH0, 16, true, 0 },
+	{ "adma-dma1-ch", IMX_SC_R_DMA_1_CH0, 16, true, 0 },
+	{ "adma-dma2-ch", IMX_SC_R_DMA_2_CH0, 5, true, 0 },
+	{ "adma-asrc0", IMX_SC_R_ASRC_0, 1, false, 0 },
+	{ "adma-asrc1", IMX_SC_R_ASRC_1, 1, false, 0 },
+	{ "adma-esai0", IMX_SC_R_ESAI_0, 1, false, 0 },
+	{ "adma-spdif0", IMX_SC_R_SPDIF_0, 1, false, 0 },
+	{ "adma-sai", IMX_SC_R_SAI_0, 3, true, 0 },
+	{ "adma-amix", IMX_SC_R_AMIX, 1, false, 0 },
+	{ "adma-mqs0", IMX_SC_R_MQS_0, 1, false, 0 },
+	{ "adma-dsp", IMX_SC_R_DSP, 1, false, 0 },
+	{ "adma-dsp-ram", IMX_SC_R_DSP_RAM, 1, false, 0 },
+	{ "adma-can", IMX_SC_R_CAN_0, 3, true, 0 },
+	{ "adma-ftm", IMX_SC_R_FTM_0, 2, true, 0 },
+	{ "adma-lpi2c", IMX_SC_R_I2C_0, 4, true, 0 },
+	{ "adma-adc", IMX_SC_R_ADC_0, 1, true, 0 },
+	{ "adma-lcd", IMX_SC_R_LCD_0, 1, true, 0 },
+	{ "adma-lcd0-pwm", IMX_SC_R_LCD_0_PWM_0, 1, true, 0 },
+	{ "adma-lpuart", IMX_SC_R_UART_0, 4, true, 0 },
+	{ "adma-lpspi", IMX_SC_R_SPI_0, 4, true, 0 },
 
 	/* VPU SS  */
-	{ "vpu", IMX_SC_R_VPU, 1, false },
-	{ "vpu-pid", IMX_SC_R_VPU_PID0, 8, true },
-	{ "vpu-dec0", IMX_SC_R_VPU_DEC_0, 1, false },
-	{ "vpu-enc0", IMX_SC_R_VPU_ENC_0, 1, false },
+	{ "vpu", IMX_SC_R_VPU, 1, false, 0 },
+	{ "vpu-pid", IMX_SC_R_VPU_PID0, 8, true, 0 },
+	{ "vpu-dec0", IMX_SC_R_VPU_DEC_0, 1, false, 0 },
+	{ "vpu-enc0", IMX_SC_R_VPU_ENC_0, 1, false, 0 },
 
 	/* GPU SS */
-	{ "gpu0-pid", IMX_SC_R_GPU_0_PID0, 4, true },
+	{ "gpu0-pid", IMX_SC_R_GPU_0_PID0, 4, true, 0 },
 
 	/* HSIO SS */
-	{ "hsio-pcie-b", IMX_SC_R_PCIE_B, 1, false },
-	{ "hsio-serdes-1", IMX_SC_R_SERDES_1, 1, false },
-	{ "hsio-gpio", IMX_SC_R_HSIO_GPIO, 1, false },
+	{ "hsio-pcie-b", IMX_SC_R_PCIE_B, 1, false, 0 },
+	{ "hsio-serdes-1", IMX_SC_R_SERDES_1, 1, false, 0 },
+	{ "hsio-gpio", IMX_SC_R_HSIO_GPIO, 1, false, 0 },
 
 	/* MIPI/LVDS SS */
-	{ "mipi0", IMX_SC_R_MIPI_0, 1, false },
-	{ "mipi0-pwm0", IMX_SC_R_MIPI_0_PWM_0, 1, false },
-	{ "mipi0-i2c", IMX_SC_R_MIPI_0_I2C_0, 2, true },
-	{ "lvds0", IMX_SC_R_LVDS_0, 1, false },
+	{ "mipi0", IMX_SC_R_MIPI_0, 1, false, 0 },
+	{ "mipi0-pwm0", IMX_SC_R_MIPI_0_PWM_0, 1, false, 0 },
+	{ "mipi0-i2c", IMX_SC_R_MIPI_0_I2C_0, 2, true, 0 },
+	{ "lvds0", IMX_SC_R_LVDS_0, 1, false, 0 },
 
 	/* DC SS */
-	{ "dc0", IMX_SC_R_DC_0, 1, false },
-	{ "dc0-pll", IMX_SC_R_DC_0_PLL_0, 2, true },
+	{ "dc0", IMX_SC_R_DC_0, 1, false, 0 },
+	{ "dc0-pll", IMX_SC_R_DC_0_PLL_0, 2, true, 0 },
 };
 
 static const struct imx_sc_pd_soc imx8qxp_scu_pd = {
@@ -236,7 +239,7 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
 
 	if (pd_ranges->postfix)
 		snprintf(sc_pd->name, sizeof(sc_pd->name),
-			 "%s%i", pd_ranges->name, idx);
+			 "%s%i", pd_ranges->name, pd_ranges->start_from + idx);
 	else
 		snprintf(sc_pd->name, sizeof(sc_pd->name),
 			 "%s", pd_ranges->name);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
