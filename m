Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF555C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:09:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C086521773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aLawEpk7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="wBGy3h/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C086521773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iVVjpHB0PztMW5rxxrFstO7+6DH35j6X17JFjPIE3Nc=; b=aLawEpk75KaLKg
	OIBYzgau6Juj08UvUCk7EKTCdcc3Q0Rkyix16dKvzVe2QiU0Y2ZP1k0Y0gRRp0zviaYUII65kyv9l
	bUZ0brkS0/FX1WvgbSSomxtffOWCnB0YhHST0y5Vycw1N1B0HstcTP1grQ1Ussu2kxZ5W/oN+VsML
	mtTPngZtS/wRwQZLJNLc6kPmbSSGayKzjoRiaKCF0aR6i3JT48AryNw0gE+H8fVxGISeFFnOF2jJt
	BZu4tnaamUxlbfLQSk6Nrv9KCZMTjPor3IFgFf6oeUV+u5yn35e/H/WdyUVUGfrrQMXRNY/1Z+UOF
	gHqt7OFrsN1Uq8NpqNmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw2LU-0005b6-2C; Tue, 19 Feb 2019 10:09:48 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw2Kk-0004iq-Lo
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 10:09:06 +0000
X-IronPort-AV: E=Sophos;i="5.58,388,1544511600"; d="scan'208";a="26786204"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 19 Feb 2019 03:08:59 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 19 Feb 2019 03:08:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHWf+nFCzAuVg05N3yE+Q4lFdjrNbEEt4LD7T+XiPZ8=;
 b=wBGy3h/zpekvT0fka0ECiEQeHwSb8Ib/0WR4y6OYX0dmCi213bwO4iH88OXJ/rgHcRIlGT9P2tuut+F8GgRpoqJu5ABHytd8IFqV/b7eArEWvwxiGTxujhYey+6WRKXlAPpFjFUa1kB0mxWz97feUlkhYmGCzQy7pzfIiNQ0PNI=
Received: from CY4PR11MB1909.namprd11.prod.outlook.com (10.175.61.147) by
 CY4PR11MB1831.namprd11.prod.outlook.com (10.175.60.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 19 Feb 2019 10:08:57 +0000
Received: from CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::1499:c19c:26f1:32f1]) by CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::1499:c19c:26f1:32f1%8]) with mapi id 15.20.1622.020; Tue, 19 Feb 2019
 10:08:57 +0000
From: <Claudiu.Beznea@microchip.com>
To: <thierry.reding@gmail.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>, 
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>
Subject: [PATCH v2 2/4] pwm: atmel: add support for controllers with 32 bit
 counters
Thread-Topic: [PATCH v2 2/4] pwm: atmel: add support for controllers with 32
 bit counters
Thread-Index: AQHUyDsg4pV/PQZmmkCr3+x+PakMUQ==
Date: Tue, 19 Feb 2019 10:08:57 +0000
Message-ID: <1550570914-26391-3-git-send-email-claudiu.beznea@microchip.com>
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
x-ms-office365-filtering-correlation-id: 04f00035-2f1d-4df9-d921-08d696524297
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR11MB1831; 
x-ms-traffictypediagnostic: CY4PR11MB1831:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; CY4PR11MB1831;
 23:6wnJne4xtlNafMRDryygQuIR8AFx0bH4VAWwV+a?=
 =?iso-8859-1?Q?hi0LZgOEuRjL44Ks/S4bRpj3KCrCZaFRhmaVSTH4FwJ+LVdzC3+T1KSnJq?=
 =?iso-8859-1?Q?nGnbkwk1XVN5PdggZLV9MWjdg0Y9MdUa69xTM5XJ1Up5HMjfoea4acBz7j?=
 =?iso-8859-1?Q?gWr3I2LqkMJgGimAWIx61AOsDdAAqLbo8ZWUrSlWNe6MSojRCucFGwH19F?=
 =?iso-8859-1?Q?ZLrKIImCFOd98SAO18P5e6ERdMKanq1ZSQhY4+Ka1R0cdiBEEcXgtMX52B?=
 =?iso-8859-1?Q?0idr0ZbHzuVA0icKX0k7mxwm7o6d2A7dThf1Pi8kLNnjg/SL1CKq+9CrXY?=
 =?iso-8859-1?Q?AYYNOUV9Gp2gAEFhahfEJpcAcdpXRTx50IsFC1vpICIuJBfer+SNEcBxUp?=
 =?iso-8859-1?Q?osMnBPWjmYlImP6AFAW2CV0sPVqUlrseBxNf5mRVzRJmWWanOi041Far2P?=
 =?iso-8859-1?Q?Huz5hsY10hj6UD93m5HHvObAug5R70/C4uuqssQGpiai5NzH8UqfMebvQh?=
 =?iso-8859-1?Q?Y/8V5QW5sqw/XiA7s+jBlwBPw5HU8s0YzE86gfrPLD9AEq73HmypZj1G47?=
 =?iso-8859-1?Q?5lhXoS/QeYvrY6gJtqkTyZkfnmiMciwhoavtKRkRSPCLLAqzksdOC2Togu?=
 =?iso-8859-1?Q?eqgriiAMV9+QBz6ANrxKZCKbhxDo2c70F3qykAb2jmcHcFX72HeBoxMC6L?=
 =?iso-8859-1?Q?JW7YdeyFz89hw5/T6qqZ+8MmW+sv++DiYApRj++whugVUHnWd9pvpZ58km?=
 =?iso-8859-1?Q?xRfI1bPOz2oIiMdTdvs8hsFriD7OuOJOyXFmcmrZyL/0cNOZa0R2gpTuaq?=
 =?iso-8859-1?Q?og09zcIMOcv2RnmxsoKLg0rCI4yX4SkEEjmGY5c69LtnvlyIC6AtYuvYjA?=
 =?iso-8859-1?Q?KUPvjB2xbLswboOg/VhlhVQ17RQmcYpY1Wfc6BSRrN//62SJZlPq2rTCWd?=
 =?iso-8859-1?Q?XXLp4Hn4TKFaXXHziRQN0QNucniYGUwaiix5fuqBqqvXHBDp+lf4vfYnXO?=
 =?iso-8859-1?Q?2MZYxVjVu7Dq4bJVveLb85aihr6B01etori8pAkyfvznmM6dLJiBYFEgq3?=
 =?iso-8859-1?Q?+Mq+7lb9x2r/nuaz3b64rDR1iPjJPRKggcy5IyjumdcXiHI1wEXaknd74j?=
 =?iso-8859-1?Q?a0EvZqU5zh6nyI0iY7hwAKbQlx5+lMEQ0kbSMjfozY1Qq828/RCJwNnMUZ?=
 =?iso-8859-1?Q?thPHiyii8YV/wtsXP5j09dWA+VXIO/+UaAVC2vUszqdMUkpXEEVgao/7mp?=
 =?iso-8859-1?Q?qpvPtXhscHVb5eKrVNFO6pfpyJCvX6T5E8Uzqlq8Xt88Ajg0bNcja3aGTT?=
 =?iso-8859-1?Q?gQwI2bQHTjfFnl1QmXd6ket?=
x-microsoft-antispam-prvs: <CY4PR11MB1831867F42A602DD52B42B77877C0@CY4PR11MB1831.namprd11.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(136003)(39860400002)(366004)(396003)(346002)(199004)(189003)(6486002)(53936002)(446003)(11346002)(2616005)(26005)(486006)(97736004)(4326008)(76176011)(14454004)(6436002)(186003)(25786009)(2501003)(6116002)(99286004)(6506007)(476003)(102836004)(386003)(3846002)(6512007)(52116002)(107886003)(5660300002)(71200400001)(71190400001)(305945005)(8676002)(81166006)(81156014)(36756003)(7736002)(66066001)(8936002)(106356001)(478600001)(110136005)(50226002)(54906003)(2906002)(256004)(68736007)(6636002)(105586002)(72206003)(86362001)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR11MB1831;
 H:CY4PR11MB1909.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aH3+9ltN9D5wo/jFWq4tvOyVpU9KA1q09WwEt2Q7hn03rxsZGzEEWFikHRPZCmoYMTgnnHmb23Ep08WMtPDrI1x35X8u+Ungrh8NLptVlTck/MNyylDrdWQMZVr23G2gqAl6qTW8mLcNtNSp2CSqFKFanuSGUXPaHEhY1Eci9a34iaXQoCrqfvAqhgrgdIMxG3TIk9DfQXrjXxCK9m8GYtimTEEARePPwuATq4WJL25n7/xCn4C9hjrXZKd6Seh0wSVvXGfRkFbH5+11LYoPFSfAdCHJNZLZ6mS/gPUHBoShvXNlWSJ7kATmkF8AuLLgrHF9J7eIwKQZrXf7UI1y6zYL8GfUjnELmpq3l+pJKL5OeNG9UKvCCTTsX/REQj/JzKRlKlFU/uKnCAj3lKJ8UgyR3cUfaUz3DcwkvKWuhdg=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f00035-2f1d-4df9-d921-08d696524297
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 10:08:54.2054 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1831
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_020902_945785_355CBDB8 
X-CRM114-Status: GOOD (  14.00  )
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

New SAM9X60's PWM controller use 32 bits counters thus it could generate
signals with higher period and duty cycles than the old ones. Prepare the
current driver to be able to work with old controllers (that uses 16 bits
counters) and with the new SAM9X60's controller, by providing counters
information based on compatible.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-atmel.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 7e86a5266eb6..647d063562db 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -48,15 +48,11 @@
 #define PWMV2_CPRD		0x0C
 #define PWMV2_CPRDUPD		0x10
 
-/*
- * Max value for duty and period
- *
- * Although the duty and period register is 32 bit,
- * however only the LSB 16 bits are significant.
- */
-#define PWM_MAX_DTY		0xFFFF
-#define PWM_MAX_PRD		0xFFFF
-#define PRD_MAX_PRES		10
+/* Max values for period and prescaler */
+
+/* Only the LSB 16 bits are significant. */
+#define PWM_MAXV1_PRD		0xFFFF
+#define PRD_MAXV1_PRES		10
 
 struct atmel_pwm_registers {
 	u8 period;
@@ -65,8 +61,14 @@ struct atmel_pwm_registers {
 	u8 duty_upd;
 };
 
+struct atmel_pwm_config {
+	u32 max_period;
+	u32 max_pres;
+};
+
 struct atmel_pwm_data {
 	struct atmel_pwm_registers regs;
+	struct atmel_pwm_config cfg;
 };
 
 struct atmel_pwm_chip {
@@ -125,10 +127,10 @@ static int atmel_pwm_calculate_cprd_and_pres(struct pwm_chip *chip,
 	cycles *= clk_get_rate(atmel_pwm->clk);
 	do_div(cycles, NSEC_PER_SEC);
 
-	for (*pres = 0; cycles > PWM_MAX_PRD; cycles >>= 1)
+	for (*pres = 0; cycles > atmel_pwm->data->cfg.max_period; cycles >>= 1)
 		(*pres)++;
 
-	if (*pres > PRD_MAX_PRES) {
+	if (*pres > atmel_pwm->data->cfg.max_pres) {
 		dev_err(chip->dev, "pres exceeds the maximum value\n");
 		return -EINVAL;
 	}
@@ -288,6 +290,11 @@ static const struct atmel_pwm_data atmel_pwm_data_v1 = {
 		.duty		= PWMV1_CDTY,
 		.duty_upd	= PWMV1_CUPD,
 	},
+	.cfg = {
+		/* 16 bits to keep period and duty. */
+		.max_period	= PWM_MAXV1_PRD,
+		.max_pres	= PRD_MAXV1_PRES,
+	},
 };
 
 static const struct atmel_pwm_data atmel_pwm_data_v2 = {
@@ -297,6 +304,11 @@ static const struct atmel_pwm_data atmel_pwm_data_v2 = {
 		.duty		= PWMV2_CDTY,
 		.duty_upd	= PWMV2_CDTYUPD,
 	},
+	.cfg = {
+		/* 16 bits to keep period and duty. */
+		.max_period	= PWM_MAXV1_PRD,
+		.max_pres	= PRD_MAXV1_PRES,
+	},
 };
 
 static const struct platform_device_id atmel_pwm_devtypes[] = {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
