Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451C0C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:22:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10BC02085B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kEq8Gen/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="pzA4u2tD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10BC02085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HvRC8bXXkUwpxlCjY5EerGRk3naC9+/r3Z84V2EacRM=; b=kEq8Gen/n2EERN
	aP+Sv7eChByQTBxE7EkwxVoWzIVvFSnuC8C9+jfyz+DJvtd1Xfee+bY99RcZ6S28npG4mLRShnbqj
	h89Q86WKG5tz85PZNO0l89TpxhqekmYkPiiKd3A3ocdx5Kkf9c9KbL2eSZo2FPd7NXo+paCxrAeS1
	rRX7s/WdTNnDP6kXmGA1+7/CleDgQFJGb74TMJGVsKZJXQoK8lgokHXtE3swReZx2AbfUYgz7CCQq
	1oEUF4eL60/f205+lu/5G1ajvS4qb5Cy3EJubNekTAY05+jjxA1ih0Nc3GCAttdEQEDsz95CtpAYX
	Ch4PhVulE5E3Jg20B60Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpF6H-0001dw-17; Thu, 31 Jan 2019 16:22:01 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpF2a-0005K6-1w
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 16:19:27 +0000
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; d="scan'208";a="26148395"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 31 Jan 2019 09:18:10 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 09:18:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4Ga2fY3zoh6/qABHNgGKl5/+WQqxOLIrxnx0O2SzP0=;
 b=pzA4u2tDO0EWO3Pd6FuBchQmW0Dm9okuOxgls1xQENbFgKjJpTXZUgPEF0ZbUSBcCezFbIZGtgnmODyQlDaf8ZwzIGDxV/mCH9A/ctfc0Ds590MXUMdjhNzi0OsdpLBJ2Kw3u57mVXfbPhodyLMWBxlD3/2COHVXeuLi0b+L714=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1424.namprd11.prod.outlook.com (10.169.234.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Thu, 31 Jan 2019 16:18:08 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 31 Jan 2019
 16:18:08 +0000
From: <Claudiu.Beznea@microchip.com>
To: <linus.walleij@linaro.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>, 
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>
Subject: [PATCH v2 2/7] pinctrl: at91: add drive strength support for SAM9X60
Thread-Topic: [PATCH v2 2/7] pinctrl: at91: add drive strength support for
 SAM9X60
Thread-Index: AQHUuYCNU1mPfwKHU0e2Y52qGSyn9Q==
Date: Thu, 31 Jan 2019 16:18:07 +0000
Message-ID: <1548951466-26297-3-git-send-email-claudiu.beznea@microchip.com>
References: <1548951466-26297-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1548951466-26297-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0116.eurprd09.prod.outlook.com
 (2603:10a6:803:78::39) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB1424;
 6:lXyRyAltsXC34W9cp5YwmAxsshXSKnCbBMeS+IVo9KO7nVAxrx+vq0XrBoxjUYW3QyUmBY5yFxxPhpjUFVpB5OOI7QfK5wbbk/l6dL7gPWIv4ZeeYwK1nCKMf3+aBm7bHaJC9DU7f9FW8SDGnYzuQuDoivF+WHkZauNUhM47GGCq3g5+bDR8fS0p52LX6o0A/XEthRSav2DUEyklFfUlYm8PN0Gr+rveZDPNQJRBNeW1mqyWNnb7Rb3HmbquVP9CpZv3Rzs2NP9t6ZihjJYim6bcZxkAEla7XIUoCdA+Sdo10lywdhXAaYKiwq1304P0HFiAMYRWXmns5c3V2VTBezxGtcRUow5EK1AQdlgvIOkC4RGJF0bgtWqMXn0kY+mlVReNsvZc2DsXtd2B25C7HepkPh/b0u7675niDt+ZjZMvfG73L00asJTu25vs9b+f7bjl16ujCiu2mYw6yQeZzw==;
 5:7RcW4cJ1hsTS1wj4em/TQNoZRU331en8WwlRBDBeoHoRl5r4wP9DJe5aysHxBgTo4RKYIhwhFH8z4Rq68WODkdlpsL1UxfBdX0p88Au73XH9vEokKggQ1qT3VvPAGkKJGNvIzxc79/28bqYiaV6ezGz2n5vNIoOFCRxWSy6FfFufy/8Ekq//y+5DjG8YYaPiIMXbXUZiS5IcuAgDd8XtMA==;
 7:0eRiZJk8GpbUTA1PrLhkJQDu+eghfU29k1rckdLywfk9RabThvW2MHAequzLqZzmV8RGXAHRZKM5OENdaJiXQIzH6ZET7qfxqZ+RNB3YNH2cDG2whLJGxiJBCgjIU1ZCjN+4SGJdplq/NfkNHlfCLA==
x-ms-office365-filtering-correlation-id: d633d2af-e4fb-4497-89eb-08d68797af94
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1424; 
x-ms-traffictypediagnostic: MWHPR11MB1424:
x-microsoft-antispam-prvs: <MWHPR11MB14248926EF77353499A0006487910@MWHPR11MB1424.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(189003)(199004)(71190400001)(186003)(6116002)(81156014)(107886003)(99286004)(86362001)(446003)(8936002)(2906002)(53936002)(66066001)(305945005)(110136005)(72206003)(8676002)(68736007)(81166006)(3846002)(478600001)(25786009)(50226002)(54906003)(97736004)(4326008)(36756003)(14454004)(7736002)(316002)(52116002)(102836004)(256004)(386003)(71200400001)(26005)(6512007)(6436002)(76176011)(6486002)(2501003)(2616005)(6506007)(476003)(11346002)(105586002)(6636002)(486006)(106356001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1424;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AeGagU03lcDyGq9UgzMqmJtIqFYqtl+0RXtn8Dka4x+QhvkYopZmAB2fGsmJwAuo4na1k0Kh1cZ3PlxhqG//iySDiPvAiXzJ/nJ1TMf6BZa/pdtfV1zNA7ZLmX4rp77mZyjGy6Xc+ujGlYwo7AcS0H/VQaBgbIC+lNFYkgLxSvxvC/j5P40tD/XgAIyuiM9xPFeQELWj9skxn49lATGUB6mC9YANDtVdCO3vliJqi1ZHf35SZ2beZ7/ED1zewRQApITM8A8whB+rD+hditrvlrYRrIkpEz+meAKHaYIGRHbmrssFClTmDnvGIhBGgVowWqjxDJrlR4mNowqXu/hwhc8/FCjLempf+KuJ9R+W42tDmc/kYOD9u70AIO6j21LEx8xmq07ubzXBzxv1nqQnH7LEucaD5wz365xxgJ/9M98=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d633d2af-e4fb-4497-89eb-08d68797af94
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:18:04.4267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1424
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_081813_139557_6C751D5B 
X-CRM114-Status: GOOD (  10.52  )
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
Cc: linux-gpio@vger.kernel.org, Claudiu.Beznea@microchip.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add drive strength support for SAM9X60 pin controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pinctrl/pinctrl-at91.c | 52 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pinctrl/pinctrl-at91.h |  2 ++
 2 files changed, 54 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 31f06dafca2e..46443b97d811 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -574,6 +574,17 @@ static unsigned at91_mux_sam9x5_get_drivestrength(void __iomem *pio,
 	return tmp;
 }
 
+static unsigned at91_mux_sam9x60_get_drivestrength(void __iomem *pio,
+						   unsigned pin)
+{
+	unsigned tmp = readl_relaxed(pio + SAM9X60_PIO_DRIVER1);
+
+	if (tmp & BIT(pin))
+		return DRIVE_STRENGTH_BIT_HI;
+
+	return DRIVE_STRENGTH_BIT_LOW;
+}
+
 static void set_drive_strength(void __iomem *reg, unsigned pin, u32 strength)
 {
 	unsigned tmp = readl_relaxed(reg);
@@ -611,6 +622,27 @@ static void at91_mux_sam9x5_set_drivestrength(void __iomem *pio, unsigned pin,
 				setting);
 }
 
+static void at91_mux_sam9x60_set_drivestrength(void __iomem *pio, unsigned pin,
+					       u32 setting)
+{
+	unsigned int tmp;
+
+	if (setting <= DRIVE_STRENGTH_BIT_DEF ||
+	    setting == DRIVE_STRENGTH_BIT_MED ||
+	    setting > DRIVE_STRENGTH_BIT_HI)
+		return;
+
+	tmp = readl_relaxed(pio + SAM9X60_PIO_DRIVER1);
+
+	/* Strength is 0: low, 1: hi */
+	if (setting == DRIVE_STRENGTH_BIT_LOW)
+		tmp &= ~BIT(pin);
+	else
+		tmp |= BIT(pin);
+
+	writel_relaxed(tmp, pio + SAM9X60_PIO_DRIVER1);
+}
+
 static struct at91_pinctrl_mux_ops at91rm9200_ops = {
 	.get_periph	= at91_mux_get_periph,
 	.mux_A_periph	= at91_mux_set_A_periph,
@@ -639,6 +671,26 @@ static struct at91_pinctrl_mux_ops at91sam9x5_ops = {
 	.irq_type	= alt_gpio_irq_type,
 };
 
+static const struct at91_pinctrl_mux_ops sam9x60_ops = {
+	.get_periph	= at91_mux_pio3_get_periph,
+	.mux_A_periph	= at91_mux_pio3_set_A_periph,
+	.mux_B_periph	= at91_mux_pio3_set_B_periph,
+	.mux_C_periph	= at91_mux_pio3_set_C_periph,
+	.mux_D_periph	= at91_mux_pio3_set_D_periph,
+	.get_deglitch	= at91_mux_pio3_get_deglitch,
+	.set_deglitch	= at91_mux_pio3_set_deglitch,
+	.get_debounce	= at91_mux_pio3_get_debounce,
+	.set_debounce	= at91_mux_pio3_set_debounce,
+	.get_pulldown	= at91_mux_pio3_get_pulldown,
+	.set_pulldown	= at91_mux_pio3_set_pulldown,
+	.get_schmitt_trig = at91_mux_pio3_get_schmitt_trig,
+	.disable_schmitt_trig = at91_mux_pio3_disable_schmitt_trig,
+	.get_drivestrength = at91_mux_sam9x60_get_drivestrength,
+	.set_drivestrength = at91_mux_sam9x60_set_drivestrength,
+	.irq_type	= alt_gpio_irq_type,
+
+};
+
 static struct at91_pinctrl_mux_ops sama5d3_ops = {
 	.get_periph	= at91_mux_pio3_get_periph,
 	.mux_A_periph	= at91_mux_pio3_set_A_periph,
diff --git a/drivers/pinctrl/pinctrl-at91.h b/drivers/pinctrl/pinctrl-at91.h
index 79b957f1dfa2..19fc27e66bfd 100644
--- a/drivers/pinctrl/pinctrl-at91.h
+++ b/drivers/pinctrl/pinctrl-at91.h
@@ -69,4 +69,6 @@
 #define AT91SAM9X5_PIO_DRIVER1	0x114  /*PIO Driver 1 register offset*/
 #define AT91SAM9X5_PIO_DRIVER2	0x118  /*PIO Driver 2 register offset*/
 
+#define SAM9X60_PIO_DRIVER1	0x118	/* PIO Driver 1 register offset */
+
 #endif
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
