Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC59CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:03:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B7802146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FUhxfrFN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Cz6X50K6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7802146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZJtoh10wC+FUhyLM/cwLD4Bf+S2umWRfchT/cG5X2ac=; b=FUhxfrFN6avYCy
	BJj2Div6vpAEScSRQHTrsldpkys+MKprJr8qD5vg9RMN54CoeKMKgnh2F2kOw+z1pa27WccW0Yucz
	HOAFMZkFwxilF/PbKxd5mkQiPL3K3HY8QRVijAcxWVa6WdEqqd6RlagPF5WSCMsRHBJrNeqrIfBsZ
	a6NZAO5tUflYbW2QgJDaADxV0yAn0CdsBVAYufRODewqJov7DP+go6Zm4VlI0g//IsdvoNCQiBhRS
	Ix7ZoACPsLIrn2bWVpZoHi4EWOyPzYmiprMvje3Gt9HDiM5fgHc86MbPGJfdvmj2uyKDSmB1lKMrQ
	x7HZgnh2XHvCNgiqFhEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYtUg-0001O1-P0; Mon, 17 Dec 2018 14:03:38 +0000
Received: from esa1.microchip.iphmx.com ([68.232.147.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYtUU-0001Cp-GC
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 14:03:29 +0000
X-IronPort-AV: E=Sophos;i="5.56,365,1539673200"; d="scan'208";a="25348242"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 17 Dec 2018 07:03:25 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Mon, 17 Dec 2018 07:03:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgevUhPYg5Bh3SNVnyZSPjukuIyPbHAlU740fVrcAwU=;
 b=Cz6X50K6oM/LABC2Dx4jhugYEtpNr175xkcIN11jY3/Lol5fXSjwkzd/KT7hk9pcsRjft/RUONsilWhZf4qSOXE8pdMKoyCaKj988aXC+np2c0tWYPKG3t3Qn2AwMw4DF5lXVs3/ZvgxHr7tuQAUaI/ZByA5iyKR8XWFb+v7fYk=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0504.namprd11.prod.outlook.com (10.163.158.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Mon, 17 Dec 2018 14:03:22 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 14:03:22 +0000
From: <Claudiu.Beznea@microchip.com>
To: <thierry.reding@gmail.com>, <corbet@lwn.net>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <robh@kernel.org>
Subject: [PATCH v6 3/6] pwm: atmel: add pwm capabilities
Thread-Topic: [PATCH v6 3/6] pwm: atmel: add pwm capabilities
Thread-Index: AQHUlhFFiWApEZCL3E6bEM7Gu1fkXQ==
Date: Mon, 17 Dec 2018 14:03:22 +0000
Message-ID: <1545055368-23338-4-git-send-email-claudiu.beznea@microchip.com>
References: <1545055368-23338-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1545055368-23338-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP123CA0118.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:5f::34) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BY2PR11MB0504;
 6:Fv+6MSa98QTSk0WjdyRQCj8/wfs89NG1Sq8F16j1IfMyvchAxl/bKOJCrzoBhx0zuSMP5YGm/OxBx1WNO/iV9c+WYL4J8+xD8ELFEAYvK6SuBXa+cr0TZxk2zpA9qHp9r7IdtQ1F9ttJx41izL8dmw+9/37rj7gHaTgN6zmdmTBqO4MPdJQt6LCXuCB/UrhteCwu/BySqpAbEaYF9Qt/4311TcqPZbie++KOzvbCFv/9/5PZR5zTZVxzoCGSa4pMS+rFwaDHuSVH1hL/fAcX622Gs2+23WyammxC12PGlYspz3wdFlCcFZD1uALDHWC4l6ybzzLWeAopKrkwvtFQnLemle21+kZDBlcJzgjPYQ2A1JLNv+8kPeauAXSjsZK9Hizr+fq56Zd+jBt4iS1crEAvFoZqBJMOiON+DXepXgsJcPwapMVMvQjDOdcCe2fcebHGdvC+UInTRDVyCm4hZw==;
 5:8bsieWR8tHkmoi/q5CoxySfAHjWc82KHMn7/DHRh/1bMYdeOeNytZy6Ky1jpgr8CLTU88F/lrowlEZG6BmEG3RdERxWdL+z2lVgadSDsSDtb7IGNUquGBtM+WElHuBDcGzpjJqEpqZsdK+Fj9nzmDRxwDTzty++3sdoovEmAYlA=;
 7:5w+425Odx5IlsYcq5gRqIkRAcQPuqboY1kunsAYMEjlMQfTHGTg8EB72Rpkmm51+b0bBPpjj1ZsKkMnliDIJd5za0jPcPbvRiggX5tNtrcfNm/weGiTCnbHp79K/PHfncrrdlA+8C4UDpSgbjM95+Q==
x-ms-office365-filtering-correlation-id: 0eb8dcd3-4520-4081-77a6-08d6642867b4
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:BY2PR11MB0504; 
x-ms-traffictypediagnostic: BY2PR11MB0504:
x-microsoft-antispam-prvs: <BY2PR11MB050442F97B42121F88B7AD2287BC0@BY2PR11MB0504.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:BY2PR11MB0504; BCL:0; PCL:0; RULEID:; SRVR:BY2PR11MB0504; 
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(366004)(39860400002)(396003)(136003)(199004)(189003)(52116002)(476003)(186003)(106356001)(14454004)(5660300001)(2906002)(97736004)(99286004)(25786009)(86362001)(11346002)(2616005)(71200400001)(71190400001)(6436002)(6486002)(3846002)(6116002)(316002)(110136005)(54906003)(66066001)(486006)(26005)(6512007)(8936002)(81166006)(8676002)(446003)(36756003)(105586002)(102836004)(53936002)(72206003)(81156014)(305945005)(6506007)(76176011)(386003)(68736007)(39060400002)(478600001)(107886003)(7736002)(14444005)(256004)(4326008)(2501003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY2PR11MB0504;
 H:BY2PR11MB0744.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uM8RteFdGqqNYzGs/rlOemQ/OXzaXhISL4UrvulsF64jYxQRXSFX+k6vhIQFN40L9OjKDxLBMpVhHse4+zj4lI4GsXyj59K08fDiLe+rmTjqlNYCBDfOaIV7uJ/PYkpI1GDpPJu63AqaivXUD2OAmTyktjTyBpM5v+SgeYLn8qAFTHC3NehZpXwuERlb7smfvUEXcZ8pZxFLRzra0qFa+8SrH0s8Tlp7CpWZMGh86Ttrcv2JGrVSK3BuWzPe65sTzNpxXhBAkSJD4pZWqBuh5+dtwPQfCJ2bKhogSyM4E/XbttxdkqydiDEyS0qb8mnj
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb8dcd3-4520-4081-77a6-08d6642867b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 14:03:22.8320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0504
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_060326_660238_84B84923 
X-CRM114-Status: GOOD (  13.36  )
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
Cc: linux-pwm@vger.kernel.org, Claudiu.Beznea@microchip.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add pwm capabilities for Atmel/Microchip PWM controllers.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-atmel.c | 86 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 29 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 530d7dc5f1b5..b72cacd5dca3 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -65,18 +65,23 @@ struct atmel_pwm_registers {
 	u8 duty_upd;
 };
 
+struct atmel_pwm_data {
+	struct atmel_pwm_registers regs;
+	struct pwm_caps caps;
+};
+
 struct atmel_pwm_chip {
 	struct pwm_chip chip;
 	struct clk *clk;
 	void __iomem *base;
-	const struct atmel_pwm_registers *regs;
+	const struct atmel_pwm_data *data;
 
 	unsigned int updated_pwms;
 	/* ISR is cleared when read, ensure only one thread does that */
 	struct mutex isr_lock;
 };
 
-static inline struct atmel_pwm_chip *to_atmel_pwm_chip(struct pwm_chip *chip)
+static inline struct atmel_pwm_chip *to_atmel_pwm_chip(const struct pwm_chip *chip)
 {
 	return container_of(chip, struct atmel_pwm_chip, chip);
 }
@@ -150,15 +155,15 @@ static void atmel_pwm_update_cdty(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
 	u32 val;
 
-	if (atmel_pwm->regs->duty_upd ==
-	    atmel_pwm->regs->period_upd) {
+	if (atmel_pwm->data->regs.duty_upd ==
+	    atmel_pwm->data->regs.period_upd) {
 		val = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
 		val &= ~PWM_CMR_UPD_CDTY;
 		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
 	}
 
 	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm,
-			    atmel_pwm->regs->duty_upd, cdty);
+			    atmel_pwm->data->regs.duty_upd, cdty);
 }
 
 static void atmel_pwm_set_cprd_cdty(struct pwm_chip *chip,
@@ -168,9 +173,9 @@ static void atmel_pwm_set_cprd_cdty(struct pwm_chip *chip,
 	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
 
 	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm,
-			    atmel_pwm->regs->duty, cdty);
+			    atmel_pwm->data->regs.duty, cdty);
 	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm,
-			    atmel_pwm->regs->period, cprd);
+			    atmel_pwm->data->regs.period, cprd);
 }
 
 static void atmel_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -225,7 +230,7 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		    cstate.polarity == state->polarity &&
 		    cstate.period == state->period) {
 			cprd = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm,
-						  atmel_pwm->regs->period);
+						  atmel_pwm->data->regs.period);
 			atmel_pwm_calculate_cdty(state, cprd, &cdty);
 			atmel_pwm_update_cdty(chip, pwm, cdty);
 			return 0;
@@ -272,32 +277,55 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
+static int atmel_pwm_get_caps(const struct pwm_chip *chip,
+			      const struct pwm_device *pwm,
+			      struct pwm_caps *caps)
+{
+	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
+
+	*caps = atmel_pwm->data->caps;
+
+	return 0;
+}
+
 static const struct pwm_ops atmel_pwm_ops = {
 	.apply = atmel_pwm_apply,
+	.get_caps = atmel_pwm_get_caps,
 	.owner = THIS_MODULE,
 };
 
-static const struct atmel_pwm_registers atmel_pwm_regs_v1 = {
-	.period		= PWMV1_CPRD,
-	.period_upd	= PWMV1_CUPD,
-	.duty		= PWMV1_CDTY,
-	.duty_upd	= PWMV1_CUPD,
+static const struct atmel_pwm_data atmel_pwm_data_v1 = {
+	.regs = {
+		.period		= PWMV1_CPRD,
+		.period_upd	= PWMV1_CUPD,
+		.duty		= PWMV1_CDTY,
+		.duty_upd	= PWMV1_CUPD,
+	},
+	.caps = {
+		.modes_msk = PWM_MODE_BIT(NORMAL),
+	},
 };
 
-static const struct atmel_pwm_registers atmel_pwm_regs_v2 = {
-	.period		= PWMV2_CPRD,
-	.period_upd	= PWMV2_CPRDUPD,
-	.duty		= PWMV2_CDTY,
-	.duty_upd	= PWMV2_CDTYUPD,
+static const struct atmel_pwm_data atmel_pwm_data_v2 = {
+	.regs = {
+		.period		= PWMV2_CPRD,
+		.period_upd	= PWMV2_CPRDUPD,
+		.duty		= PWMV2_CDTY,
+		.duty_upd	= PWMV2_CDTYUPD,
+	},
+	.caps = {
+		.modes_msk = PWM_MODE_BIT(NORMAL) |
+			     PWM_MODE_BIT(COMPLEMENTARY),
+	},
 };
 
 static const struct platform_device_id atmel_pwm_devtypes[] = {
 	{
 		.name = "at91sam9rl-pwm",
-		.driver_data = (kernel_ulong_t)&atmel_pwm_regs_v1,
+		.driver_data = (kernel_ulong_t)&atmel_pwm_data_v1,
 	}, {
 		.name = "sama5d3-pwm",
-		.driver_data = (kernel_ulong_t)&atmel_pwm_regs_v2,
+		.driver_data = (kernel_ulong_t)&atmel_pwm_data_v2,
 	}, {
 		/* sentinel */
 	},
@@ -307,20 +335,20 @@ MODULE_DEVICE_TABLE(platform, atmel_pwm_devtypes);
 static const struct of_device_id atmel_pwm_dt_ids[] = {
 	{
 		.compatible = "atmel,at91sam9rl-pwm",
-		.data = &atmel_pwm_regs_v1,
+		.data = &atmel_pwm_data_v1,
 	}, {
 		.compatible = "atmel,sama5d3-pwm",
-		.data = &atmel_pwm_regs_v2,
+		.data = &atmel_pwm_data_v2,
 	}, {
 		.compatible = "atmel,sama5d2-pwm",
-		.data = &atmel_pwm_regs_v2,
+		.data = &atmel_pwm_data_v2,
 	}, {
 		/* sentinel */
 	},
 };
 MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
 
-static inline const struct atmel_pwm_registers *
+static inline const struct atmel_pwm_data *
 atmel_pwm_get_driver_data(struct platform_device *pdev)
 {
 	const struct platform_device_id *id;
@@ -330,18 +358,18 @@ atmel_pwm_get_driver_data(struct platform_device *pdev)
 
 	id = platform_get_device_id(pdev);
 
-	return (struct atmel_pwm_registers *)id->driver_data;
+	return (struct atmel_pwm_data *)id->driver_data;
 }
 
 static int atmel_pwm_probe(struct platform_device *pdev)
 {
-	const struct atmel_pwm_registers *regs;
+	const struct atmel_pwm_data *data;
 	struct atmel_pwm_chip *atmel_pwm;
 	struct resource *res;
 	int ret;
 
-	regs = atmel_pwm_get_driver_data(pdev);
-	if (!regs)
+	data = atmel_pwm_get_driver_data(pdev);
+	if (!data)
 		return -ENODEV;
 
 	atmel_pwm = devm_kzalloc(&pdev->dev, sizeof(*atmel_pwm), GFP_KERNEL);
@@ -373,7 +401,7 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 
 	atmel_pwm->chip.base = -1;
 	atmel_pwm->chip.npwm = 4;
-	atmel_pwm->regs = regs;
+	atmel_pwm->data = data;
 	atmel_pwm->updated_pwms = 0;
 	mutex_init(&atmel_pwm->isr_lock);
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
