Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4499DC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:26:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED05320844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b7ZX9ajd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="aGKriZkc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED05320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bQGBp5KQTI6AoJoslQJfzWjU7aInb2tP7ncYnYJU8RQ=; b=b7ZX9ajdNZEQWe
	xkt4t6sLVsgUCxlDk7ezkHId5SqcODvfh262F+l8IN3G9G4ZTlUqoYhgFgVyvNNrrA+G1rXG2V5ur
	Qf8TzQhWcYTI1whjyxrJzGt8l3aKpGuoNKpc1ffvIpirZpR6olrDu3Ue9FcaGvakP1bspIASFpTUB
	8JiZEHiJpi/o/klonvmaNH1SbsDW3HwY8zujg/03DcPSBWBF5d5G9vleLWGL1eKqhQ4cBLuncFbV3
	M4i4jEWqVjVcglBqu9adoYX9t+CzP0C6wsd2IJTefeMZpkI3Dta3lUDW+dcMwJooCJ3HyJEjMDIiO
	ERVcSPBSFw7bZBiRXHDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grfwV-0003J7-48; Thu, 07 Feb 2019 09:25:59 +0000
Received: from esa4.microchip.iphmx.com ([68.232.154.123])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grfvZ-0001BO-Ll
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 09:25:10 +0000
X-IronPort-AV: E=Sophos;i="5.58,342,1544511600"; d="scan'208";a="25951392"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 07 Feb 2019 02:24:51 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 7 Feb 2019 02:24:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsqFGmrkxMOuMDQMM+iopajYEgoCPwLOzczGpTOw8Dk=;
 b=aGKriZkccGTacF/BR/lF1TD8vPCE3NiFdNyWYeeWZWIwMgaqJjsqS0T4wkSulguZp4QhAwVWi/AKVOKcYXv6tezVU0grOcwPrkpXzKsBG+om6yvMm+Y2M9TVypzMuq29R6NxnUZVvStjYq6cp7KLBiCHL/2FqaVUrN6/mT3QC94=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1757.namprd11.prod.outlook.com (10.175.53.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 7 Feb 2019 09:24:49 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 7 Feb 2019
 09:24:49 +0000
From: <Claudiu.Beznea@microchip.com>
To: <linus.walleij@linaro.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>, 
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>
Subject: [PATCH v3 2/7] pinctrl: at91: add drive strength support for SAM9X60
Thread-Topic: [PATCH v3 2/7] pinctrl: at91: add drive strength support for
 SAM9X60
Thread-Index: AQHUvsb5aQfjaUldQUGWIwrkwE/hiA==
Date: Thu, 7 Feb 2019 09:24:49 +0000
Message-ID: <1549531468-1676-3-git-send-email-claudiu.beznea@microchip.com>
References: <1549531468-1676-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1549531468-1676-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP265CA0350.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:5a::26) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB1757;
 6:CV7iBHToKEWXPPb+HNkBHscIvpey6p/v6sqS0F3nxnKmftDkb1uiwJhXhjOEk4whOGoUtGVkgG2CEGucigLRQRL+Z1ctKjj+7OWc3qmSdcTolnJZ/rDtJxpLutcFluXV2ZItZC1SiyCjLeW5pc6i/UDLooKM2ae3K5WBs5ecKPc5YEB5elRhlP5OAqyffzQZRHP/EvzfMcC+xIKTlfNViyWj6RF5XnWOuB2L/bvOThZ7NR/duxCVI9gnZ6pznX+eS/B5AhtTcB0lfIcF80M4nCNbbYZv+MAJgjXaUMytwZII+TvPm0lmyL55G310uuiuWJi11AalOBjXC+SCK28nRil7nMPXf6Hk0+FP3W4XlaS+zsXaSczyCm5kVGe6Sl2YO4Uq/T5giTG7oH+UUhaKBWCJNXD6JbS8bLYIFUBEvZG2U30fQuKO7VQn1USS8EUNv7rTm6rKm3n4FBOCPTgqpQ==;
 5:n20SwJyGV3gIGik9DP3f5q9+4Qw+0faKWe2DL00wOBdOr6ZC5/CUVW5HrC5JOOfHGXViuxg5y67cvbmipIpIKI56hCjO7fgFJ94OFd915VQ/ISgIwCk48NwUXn1ycDMDrxyoiIZSn4q2ZqNvsB46D+/6ni38M5hiMwOcjPOhjaf8wMuJHHH5y3RJcy6tW5xvUUhwiQxz0++6Cs9sAtmLDw==;
 7:tGgQtE4ZHl55pzycx3VVDixAkPPnlDfWMkyPSnVXpAOFRyf8z0JKyahTpd5jXL616HdNHoVv6ai06ujAkJI5fyR8uY1evJvnmUCetl2Y+gMGPvlWkqSvLQCsItXiggbCbGoRlhbEqDSG/7sNRGAENQ==
x-ms-office365-filtering-correlation-id: 139f51ac-8a01-40c1-33ed-08d68cde1b8a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1757; 
x-ms-traffictypediagnostic: MWHPR11MB1757:
x-microsoft-antispam-prvs: <MWHPR11MB1757370B6F7722EF9D9974AF87680@MWHPR11MB1757.namprd11.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(396003)(366004)(136003)(39860400002)(189003)(199004)(53936002)(66066001)(72206003)(6486002)(256004)(71190400001)(71200400001)(99286004)(26005)(102836004)(386003)(6506007)(4326008)(25786009)(478600001)(2906002)(76176011)(186003)(52116002)(68736007)(316002)(14454004)(50226002)(97736004)(8676002)(8936002)(86362001)(6436002)(81166006)(81156014)(2501003)(2616005)(6512007)(107886003)(446003)(11346002)(476003)(6116002)(486006)(305945005)(3846002)(6636002)(106356001)(54906003)(105586002)(110136005)(36756003)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1757;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: l/941DDXJzuxu/zdQ1KHLFgBmY7CqaXnUr6zlhmAZ7YAv+/z4dp0n3ScC66tYFeT6iyg5w0ZTAGAlN3+jbvjggunwhDzwvLsDiFe+yWvekV5pozcsubsUn/sCtYH9VSYkKmXNgGr1+gfUkOxYrgiCiOga3Ov/y7/LXe6ftZUbuZRZuIig3i3L1y6qsKTdMYWAHqIXznfvGne6usm1MnkznoTupvcNE9nuds9viI0Q20pjN6iNE5sHRjZyVIHdKGr0ppNTpdwe7tcjKQxjR978XTSaGn/ARx4Gd3SvB14tJqBu8/pv5swLYbmcGwqGpuFk9i2+ZQjAQyZpJx50bY7Gjk+fvGIdsf5/1m9qusRVQraAwozP2areCsmDeuRHaioEWS1UxMAv0qdNnA1qh98A/FpKtFf4y5cszSIDOclylY=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 139f51ac-8a01-40c1-33ed-08d68cde1b8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 09:24:46.5823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1757
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_012502_560760_916A6F2B 
X-CRM114-Status: GOOD (  10.78  )
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
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
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
