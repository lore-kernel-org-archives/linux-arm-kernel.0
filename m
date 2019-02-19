Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC7CC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:09:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97B9521773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pIwIZAEp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="LgoHMmdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B9521773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pnC7fNn5aqSe4ehjibUl9MVM43ZAE7c8l5fQx1JZEKo=; b=pIwIZAEp1mGyke
	07/vvsGMfEmXDcaxg59Nz+fZJqrJRi+uxT6GCNjHjia2JbhgEYjIRlcPGoyi7cyEK1FjT5kgWJMlc
	Z2uIiiM9ylkGVIvwjeOllmkuq9HP2Do0Jr2OT5DIm+6x5eNNlkEC2qdY3koXguVldHDHtcb36Zm0L
	FL7hdrXL2H14WzvBmg4EOGYUhnwHJVqNkp4nI3lu96fDWZMtAGNkg6jvm09mrEGwvnTYauhdg+L43
	l7SmsvsYx/h/1mWNMHIks9pAGDPAbgBTptP2+FcQZO5TwK+Fiz635qhejw0j0u3+/1rO3+2XNeU9+
	JJYgGx0bkHK11UOt0MNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw2Ki-0004ho-LD; Tue, 19 Feb 2019 10:09:00 +0000
Received: from esa1.microchip.iphmx.com ([68.232.147.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw2Ke-0004gj-Od
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 10:08:58 +0000
X-IronPort-AV: E=Sophos;i="5.58,388,1544511600"; d="scan'208";a="27948382"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 19 Feb 2019 03:08:55 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Tue, 19 Feb 2019 03:08:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9lIBio+d1I8a0cqfMF/qq8HbRXrUVc1eb2t+KSG708=;
 b=LgoHMmdh+ExGW2teqEq7zRThajO0ph68W/73aEVrxG5GZHMJ4+96luuqV0N6g18dVGgepX+6OYEfdYKu1uRLhkYqabXz0VCiUxhedqjmN/HPZlxx1ofFglIKnJ7Pu5EPl7prsLGIFLU0pZm5ChMyn7HiB6TWwqs/KDhR8AzfBY8=
Received: from CY4PR11MB1909.namprd11.prod.outlook.com (10.175.61.147) by
 CY4PR11MB1831.namprd11.prod.outlook.com (10.175.60.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 19 Feb 2019 10:08:53 +0000
Received: from CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::1499:c19c:26f1:32f1]) by CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::1499:c19c:26f1:32f1%8]) with mapi id 15.20.1622.020; Tue, 19 Feb 2019
 10:08:53 +0000
From: <Claudiu.Beznea@microchip.com>
To: <thierry.reding@gmail.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>, 
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>
Subject: [PATCH v2 1/4] pwm: atmel: add struct atmel_pwm_data
Thread-Topic: [PATCH v2 1/4] pwm: atmel: add struct atmel_pwm_data
Thread-Index: AQHUyDsebhaDcxSAbUmBr7QjyOMlmQ==
Date: Tue, 19 Feb 2019 10:08:53 +0000
Message-ID: <1550570914-26391-2-git-send-email-claudiu.beznea@microchip.com>
References: <1550570914-26391-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550570914-26391-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0090.eurprd09.prod.outlook.com
 (2603:10a6:802:29::34) To CY4PR11MB1909.namprd11.prod.outlook.com
 (2603:10b6:903:11f::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10dba0f0-56de-48a4-c93f-08d69652407a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR11MB1831; 
x-ms-traffictypediagnostic: CY4PR11MB1831:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; CY4PR11MB1831;
 23:jqltpSTVzzV4DaFNJFBfh6cuwrhc+j9vmhigvSv?=
 =?iso-8859-1?Q?IRzYunLBMvWuIiIojRtYt5bh1iGK0AmO98QkxaNuQosJhWJmFHkamLM0YK?=
 =?iso-8859-1?Q?+jXJo0JHcH9h12317123wb4lNuxlV6FkhdA9eJYglXBzTmH0znJoBzVMKr?=
 =?iso-8859-1?Q?oiQ/m76sc2z8Fq+srW0NloyDvD9UMGEYLogMkA6eMBo7EVzN7DbsTBYili?=
 =?iso-8859-1?Q?UOSssgdlDLVQNWeDfCYo8gbbuOfvECHIUfElFQPPGDjUT4TGt/wBaQYIzQ?=
 =?iso-8859-1?Q?V1zbmKM2ryRP1Iohm1zYuVXNHdNQumXN/E1FDzr+uYEoLIGh7yYa37vsox?=
 =?iso-8859-1?Q?YUbondTW1nYuCKlhrcYec3PqYQG3eCoA+NiLBBWo9ITOXFCUzU3Nczeaq6?=
 =?iso-8859-1?Q?UnIZxpeqNvCL9MQeQs7RQuq9RjgvdBl61P3it81u8gRi8VxZFU6D2vgA9F?=
 =?iso-8859-1?Q?mH6Z4r0vcyO163iRaKhCRxbnQE+8RtsKN04KhoQzE3OswqrjOqOONC/cdt?=
 =?iso-8859-1?Q?0z+yb8X/bN420be6Qhtwovum2l3EPyewYljdy2HN6aC10y2/wzOVYMvOsM?=
 =?iso-8859-1?Q?yJWyRUQdXhL5SUjqCzNcCbY7kFBl4RXJtgMt2/nmukXlLW7ZyMlCuPJUc/?=
 =?iso-8859-1?Q?spGxKVEmv+QHfC4I7SUdN41yp7HHzuL/hQ3CjwzOZT0zxzq7noj8eX7TCq?=
 =?iso-8859-1?Q?5BzsuobxiA13wTLqv95BmF7+k7j4l4zzYn2kxvWTAhNP+PYtpCApWTMFaa?=
 =?iso-8859-1?Q?TSLlcw9q1rJSMqEFZPmpK4rNCy91mw7M8tZXMLJGCSDdDk2Z+RGIAfXQjD?=
 =?iso-8859-1?Q?7miWKm1/RV8wirB2wY9sSNR1Z/kZKBG+5iHcVIZUnPy2S1/BX6S/3BSKD7?=
 =?iso-8859-1?Q?/9Op9BIgOkE9ecX8v2fysjVV8EbNM4GJ0bUPff+TyKgpYG1cVEWYznhiiP?=
 =?iso-8859-1?Q?sAOMNS42h2bRREJUuIwiIudxY5JenRI3dl2AJdY8B8HQusLgyrrR6fZS/3?=
 =?iso-8859-1?Q?npIk8g1dxijrelS6aIYVKyatjz3TpIR51od2cNQhwkUtUBHkq+hKD2CphF?=
 =?iso-8859-1?Q?iSxpIJuDire1PZTesuPd8JSRQavWN/2MtimpmuO/tjPSN5OfxwNmFA0Qf5?=
 =?iso-8859-1?Q?RprLi61yAKlh6/GjkYNuRL5Bhdci8WccILcf/BuHMQvWMAM9WZZDJRcKeI?=
 =?iso-8859-1?Q?Lw5GGQ3pBz//ZTzEKLLhrSCfA6Dk2R+utgjmoOO5H9VTVNFBSXW51q7ZEN?=
 =?iso-8859-1?Q?1tZyPT8j4BKSJCAvd70r/l14daQ4fxGuHpxKu2GOEWZyn2L4o1ItsnTTUb?=
 =?iso-8859-1?Q?mCele0jCiq8VJwKspLayvyclyARcRwKwQhzrG8bLFSoBA=3D=3D?=
x-microsoft-antispam-prvs: <CY4PR11MB1831EFD514EAECB84935CC06877C0@CY4PR11MB1831.namprd11.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(136003)(39860400002)(366004)(396003)(346002)(199004)(189003)(6486002)(53936002)(446003)(11346002)(2616005)(26005)(486006)(97736004)(4326008)(76176011)(14454004)(6436002)(186003)(25786009)(2501003)(6116002)(99286004)(6506007)(476003)(102836004)(386003)(3846002)(6512007)(52116002)(107886003)(5660300002)(71200400001)(71190400001)(305945005)(8676002)(81166006)(81156014)(36756003)(7736002)(66066001)(8936002)(106356001)(478600001)(110136005)(50226002)(54906003)(2906002)(14444005)(256004)(68736007)(6636002)(105586002)(72206003)(86362001)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR11MB1831;
 H:CY4PR11MB1909.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YXvD4TP+Pnfe+uFniSQ0tOLhF00e/3cu447VMKAdgn59Vi3+VMMxjw6zTGZ0idqk6xVLYc0270tMOWk0mN3kV9Xyna8rT0qY/GAtqwg4Qk/C0C5SyiygIxaVn5jlrQgHt8H6lDzG1uZ+VEu/jC6pP9CGWtkBryrm3FSioiFHyBz74d/UBgdqclGV+ei7GVgkaLD3ovWMcw5q0Q0KbuzuXJkjLIjXkletnPqxt/OQX8eFBpGqxEnfmzXMWJUDG8D6GHFvMjTOR//Wvn2F1BPMTQvFUXqJbzPiFlsg3SK5OvxcONxsYamOeQboGbU5WQpF1LoLZKJzGMjigu/GcJdUw/lKHqa6ZC/74aUwZI9knNdl5qKsT0HJLZ6UXawsoyktaCMfk9AXnfQttSy4yHxfcfTG8MUs8vrhmqiXaAdVM9c=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 10dba0f0-56de-48a4-c93f-08d69652407a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 10:08:50.4203 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1831
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_020856_911105_A4C678B4 
X-CRM114-Status: GOOD (  12.27  )
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
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add struct atmel_pwm_data to embed different per controller information. At
this stage, embed a member of type struct atmel_pwm_registers in it.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-atmel.c | 64 +++++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 530d7dc5f1b5..7e86a5266eb6 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -65,11 +65,15 @@ struct atmel_pwm_registers {
 	u8 duty_upd;
 };
 
+struct atmel_pwm_data {
+	struct atmel_pwm_registers regs;
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
@@ -150,15 +154,15 @@ static void atmel_pwm_update_cdty(struct pwm_chip *chip, struct pwm_device *pwm,
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
@@ -168,9 +172,9 @@ static void atmel_pwm_set_cprd_cdty(struct pwm_chip *chip,
 	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
 
 	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm,
-			    atmel_pwm->regs->duty, cdty);
+			    atmel_pwm->data->regs.duty, cdty);
 	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm,
-			    atmel_pwm->regs->period, cprd);
+			    atmel_pwm->data->regs.period, cprd);
 }
 
 static void atmel_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -225,7 +229,7 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		    cstate.polarity == state->polarity &&
 		    cstate.period == state->period) {
 			cprd = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm,
-						  atmel_pwm->regs->period);
+						  atmel_pwm->data->regs.period);
 			atmel_pwm_calculate_cdty(state, cprd, &cdty);
 			atmel_pwm_update_cdty(chip, pwm, cdty);
 			return 0;
@@ -277,27 +281,31 @@ static const struct pwm_ops atmel_pwm_ops = {
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
@@ -307,20 +315,20 @@ MODULE_DEVICE_TABLE(platform, atmel_pwm_devtypes);
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
@@ -330,18 +338,18 @@ atmel_pwm_get_driver_data(struct platform_device *pdev)
 
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
@@ -373,7 +381,7 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 
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
