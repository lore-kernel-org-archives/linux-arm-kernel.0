Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBE9C2F3A0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:31:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54F1E2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KFUqucPZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="RAH8TM3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F1E2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ir7vyEW5gwDc+JJq3R9FKFP1wWJ8byy//bWikO3VaMM=; b=KFUqucPZ4+whUX
	eE86LEBDJXzgIyfsag962l80dUYCOzUHdKOlcBc9mXTdAPw0LdEegHLQ7SzmKFnQWl6/5L0wsdCIr
	ezVWHMvhvPgdPdvEJrtFkAjnk8PuVxOA+pfNQMLAaG5kg5jLdgmz2/T9JKTdXkmpSq3pFWm5EyR4V
	H7ipxwIaZmw/uudXjbqebKel0GyM9si0nB2p3fbVHgpwo7GkPUaergQhcrrXAWl459K42ZVC3inKB
	sNvYji2YlO4/qK/74vy3XdcE6HGT/t6TmxMkidaryYhByKsFDeChebxgoRDO/J65Pmhq6mm7IuDN8
	K6XuGLpx4V8bmWkz7qXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glYjf-0001Xy-S0; Mon, 21 Jan 2019 12:31:27 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glYjB-000177-Ao
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 12:31:00 +0000
X-IronPort-AV: E=Sophos;i="5.56,503,1539673200"; d="scan'208";a="22851348"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 21 Jan 2019 05:30:55 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Mon, 21 Jan 2019 05:30:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yk9tvWEnTdoQoiaEQle4D7cOt7vzy5Or+S4iQ1m8vsQ=;
 b=RAH8TM3Kx80cmC3I9MgiNHbDr8bBBLXfMUE42VKlxz/43CM3ha5M7N6tK52LWesD0TwIjWXYV/IvhbLWZOj6Nm1p7rjOZ0GQWkYa/mtsde8ul3scyllHQXJaFSkbes7Dn4Gf1xmNVuRYKhlssz0P1q3RCxB/tqAA5MxORxpwq5I=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB2064.namprd11.prod.outlook.com (10.169.236.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Mon, 21 Jan 2019 12:30:53 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%8]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 12:30:53 +0000
From: <Claudiu.Beznea@microchip.com>
To: <thierry.reding@gmail.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>, 
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>
Subject: [PATCH 2/4] pwm: atmel: add support for controllers with 32 bit
 counters
Thread-Topic: [PATCH 2/4] pwm: atmel: add support for controllers with 32 bit
 counters
Thread-Index: AQHUsYUm31frJ/4ukkWUPCYXEQw2XQ==
Date: Mon, 21 Jan 2019 12:30:53 +0000
Message-ID: <1548073783-22640-3-git-send-email-claudiu.beznea@microchip.com>
References: <1548073783-22640-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1548073783-22640-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0038.namprd07.prod.outlook.com
 (2603:10b6:a03:60::15) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB2064;
 6:wV8k4V9TUZ7AGqQ9PyhReBhUoF1TGd+gFoMwuc0K6pMyuRCQkVb4UMebW2GAHSr5UxnX/pLz/OmZG54h95FPlE7FUctO90GzBW/8Ohy86PdgaFqWz2WFhJ+aopiIHmfNoyq+EaWDGtuiGZW7PrEGz1IPT0GVw6Ufxz0WUQIGCv5H0PSkI5bnKc/Cm6EpQkh1Pe6YgUsMWJ0Mx60SPzob0K4O5DPnUyuXqa6jN2cFUuljM0uYEuSMyrE0LdbPH8x3OhhpRtzHeQV8C9QuW1z0NTOCmACFGVMD1evx5sBg7dfQsqyZUoW73mGmPMj5BbjuvApn7RozOPNplj92KxVP5nsPRC3lrOZMunaUK/twix50WN6ujsxdsvkRHcJtnu4I9AIgqvDtAL5lcrFzyrnw6Oscv4IUu52/YfWtnSXcyM8AeeYXyHk3wmdLJ8kjPGnUuK1F77ezqh5UsYXspfyVTA==;
 5:UQQ21KBLEn4cgm+NzjHP4iWVOif8baTt3I2bRdjkPfQphYmutU2ITJlieETLfe3N+CcM2qAO+anywxJFXuuZuyVqlQOt/ylhzS0gNOVHKvMCjn7kulS9iiki8hqxvGA+gX/EgMrc1KOCrHcpFv7jKBC8zfxEKJ0KRGj2tY04KNtiJx24eOony81KXv7UtGH7Hr2gNgJISOJfRI7usgFQ8Q==;
 7:HvqdrgedOAMGZzqG4pKVuWs3oMPYorDtSgRgCuY8WxAJrbrOq6YsiImDMGBuIqknMUNEYA38Hs1apf6dA28vsScAZXvvyUsivVOcZuLzxgh9BjuD8GD8F9wCCs2Q4uBmX7BFJWwkGmAAIda/423N3A==
x-ms-office365-filtering-correlation-id: d3501a14-2fc1-4db0-88fb-08d67f9c48b3
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB2064; 
x-ms-traffictypediagnostic: MWHPR11MB2064:
x-microsoft-antispam-prvs: <MWHPR11MB2064699A3B6BAE31E3C98987879F0@MWHPR11MB2064.namprd11.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(346002)(366004)(136003)(39860400002)(189003)(199004)(186003)(6436002)(6636002)(53936002)(4326008)(50226002)(6116002)(105586002)(52116002)(446003)(106356001)(97736004)(3846002)(36756003)(7736002)(305945005)(6486002)(39060400002)(316002)(26005)(6512007)(99286004)(71200400001)(107886003)(71190400001)(86362001)(25786009)(68736007)(256004)(14444005)(14454004)(8936002)(8676002)(2906002)(81156014)(386003)(6506007)(81166006)(476003)(2616005)(2501003)(76176011)(54906003)(11346002)(102836004)(66066001)(72206003)(478600001)(110136005)(486006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB2064;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TcgvEG2xggIg2l+KnByZ7CQxNhtrHjWXgB8reFMVVGH4zQEufWmEcnQTWf4XE+hR1yooeej6v9XxvfrcVtIliuy91KswopoEWAKnO3Lmft4+MsFDhzBIN5fR/1To92U+ZVMni8oJAQnTE2ei4+QJ5bHJ3bqKcZZ04/f7NO2+1bHcrpKGiHKg0X6H1LjoRSqs8Ao+0z4OnAtb6ek3V2VuwuN9+F3rwKkQCu/NRUVjt8hnFG+ePXa9DZMxOYn88tyH5EstBVT9Rkk+rAHPL43huI6GIL3E8rVz7R2Hqecwc1QXG06vSOfv+BZc1AtjdwGciN+236LSumoqX/sDDZJpSdTJPzo8vAFNQUjYPS4N1sPPCRZhGWRyB6RSCXyeDkh1/TRXsoCjmE7VfKFF/JqgRg+f0Zurkymcf62XIDWkawc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d3501a14-2fc1-4db0-88fb-08d67f9c48b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 12:30:50.1324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2064
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_043057_718639_B7DEE8DF 
X-CRM114-Status: GOOD (  14.77  )
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
signals with higher period and duty cycles. Update the current driver
to work with old controller (that uses 16 bits counters) and with the
new SAM9X60's controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-atmel.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 7e86a5266eb6..44f4a1c9f60b 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -48,15 +48,15 @@
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
+
+/* All 32 bits are significant. */
+#define PWM_MAXV2_PRD		0xFFFFFFFF
+
+#define PRD_MAXV1_PRES		10
 
 struct atmel_pwm_registers {
 	u8 period;
@@ -65,8 +65,14 @@ struct atmel_pwm_registers {
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
@@ -125,10 +131,10 @@ static int atmel_pwm_calculate_cprd_and_pres(struct pwm_chip *chip,
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
@@ -288,6 +294,11 @@ static const struct atmel_pwm_data atmel_pwm_data_v1 = {
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
@@ -297,6 +308,11 @@ static const struct atmel_pwm_data atmel_pwm_data_v2 = {
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
