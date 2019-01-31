Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA4AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:29:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58FE1218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cX04hw2q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="qzdiwi0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FE1218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HvRC8bXXkUwpxlCjY5EerGRk3naC9+/r3Z84V2EacRM=; b=cX04hw2qkOYOqk
	sZwgST1m63U4x3az3afjZDz3ltkI54wkCCssNKngWJKSjDdtYBezZqJdIt/ncn1GprULq/0TnRGov
	3a9RLzaLF7JpzNX3LdYgL7BZxch+qPGB4FksEkMoRgBZ4ZiiDM938e+6GwCT70Gb4WP+wrWg+xPDi
	V5BRxII9WJDRFLCy3e1XB5ysUfiv0TNU5ae7U5E91GNGhEc+eerWEVrUabXld8keAHOmafK8psi52
	R1otJ6PywVcxFJXeurJGNtdtcBcRwBZZvqU2H8TsjpWRfC5joQJF1NP+7LcdHJhAa+t/ck2BjM5Ce
	5SQOrG4nXWidRgIbrOzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpBTc-0003d2-7E; Thu, 31 Jan 2019 12:29:52 +0000
Received: from esa5.microchip.iphmx.com ([216.71.150.166])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpBTK-0003MA-0c
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 12:29:36 +0000
X-IronPort-AV: E=Sophos;i="5.56,544,1539673200"; d="scan'208";a="24062165"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 31 Jan 2019 05:29:32 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 31 Jan 2019 05:29:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4Ga2fY3zoh6/qABHNgGKl5/+WQqxOLIrxnx0O2SzP0=;
 b=qzdiwi0vjDa91d6vATCkquK4paOANjTGxcJlgqe3sMCWzuu+FuIg5LJedOPhV9ViY/UJgFCIkgK/zZtmtt0wtv4wDRudHHuESR1oNB04L1BitUMFkKK3z92/NE6WARmQVfHHHW5EHIRSIC+2Ne6vE1jW+Fa0HwKe2sySX+TzAsc=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1454.namprd11.prod.outlook.com (10.172.53.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.19; Thu, 31 Jan 2019 12:29:29 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 31 Jan 2019
 12:29:29 +0000
From: <Claudiu.Beznea@microchip.com>
To: <linus.walleij@linaro.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>, 
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>
Subject: [PATCH 2/7] pinctrl: at91: add drive strength support for SAM9X60
Thread-Topic: [PATCH 2/7] pinctrl: at91: add drive strength support for SAM9X60
Thread-Index: AQHUuWCctaPaeseFvkeBTARPuR922g==
Date: Thu, 31 Jan 2019 12:29:29 +0000
Message-ID: <1548937733-20189-3-git-send-email-claudiu.beznea@microchip.com>
References: <1548937733-20189-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1548937733-20189-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0036.eurprd07.prod.outlook.com
 (2603:10a6:800:90::22) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB1454;
 6:k2HdXHavV4eoxWYE7NYIb5va6R25eI2I32o/1Bixs7BgT9QxFop+plFb0JPahI0c1nV3kNoZLA+lZSArVbN+wPxwOtyWbM6T1Ht4zKBrnTaXokM//0/rlzBI9XGTf70vtRc0DlrWwq8VZuYpblXELt+6RmzNSbdk63zNHcHis7u6gSiaqOmMCnGtnnwYb9HnUYXq4k1eyIr6O72Ib6iTKo09Q4fClfGrTjlipyEaIEijLpuZGenGPvYOslvSQ4ecZTxGl8nbcP0fRVlJY37dn+tWOW1W+EJHtaBPOyd7G6K7h3Artio+wPm2rvVGISMy3vBlIGGzX5EzT3LwvBhteBwE/fQ5lh20rnljxQ2YtjAsUrr1JSRXz1RGGbHdpuKD6JDfgOYveTSubqtjbN2kunXeiWhs3gwAtaVmavF39B3HGXw+apd/rTS6DfHGbecW1z8SGVqyCK/9MKr1vnYD0A==;
 5:Thoh/hZAlXt45b228Do+Fq842jlXGM4sE/5UJ7NAltR7xjF2TCXnyWAm1UAFlDjMU1tCJaJzLovYuipDuKVdYyyIjqv6re9MmOq0mbcTMb24b+AvP++Om3XbVSJK2W9dH1dINlzwTd7XYYlwFpC48u+V9ZvcJIACLFj19NcFDK//GC5x7ynuAOIkeDXOsLu/y0Pii+EYrKZpC6+v7TzL1g==;
 7:8k393G4A9LikaC+O8il/sy85UiW/cY39LyOgFTyr4+sGhOdJ3kmcUaFkvlfO5kxfjSLLRES2MI+CTH2BKo3S9c6jjGmkQwa47hz4OV4Y8qOX1JJN2WwtLt/XYmdF6PCwKiYlpRbMPsm8yLQQuUsy/g==
x-ms-office365-filtering-correlation-id: 95a03f55-c0d2-4a5f-2772-08d68777beb6
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1454; 
x-ms-traffictypediagnostic: MWHPR11MB1454:
x-microsoft-antispam-prvs: <MWHPR11MB145416CC6DE3AC3D3D81FC2D87910@MWHPR11MB1454.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(136003)(199004)(189003)(2906002)(110136005)(186003)(8936002)(50226002)(4326008)(11346002)(25786009)(6116002)(2616005)(97736004)(476003)(305945005)(66066001)(3846002)(36756003)(8676002)(7736002)(14454004)(72206003)(81156014)(478600001)(68736007)(486006)(81166006)(107886003)(52116002)(99286004)(6436002)(316002)(6486002)(446003)(86362001)(54906003)(2501003)(256004)(105586002)(6636002)(76176011)(53936002)(106356001)(26005)(71190400001)(6506007)(386003)(71200400001)(102836004)(6512007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1454;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AZc6mxOCUai9JU+UDvbGE7quhdFmw1W2JpVj5AfN+wSIuz2zy8Di/4DnAbQk85NiiUO2Aswf3zOzQmAPIR2VU4wDReu89/YveUV3NmtWF7AO2bsDxEHiGABayy+TzQsB7jsKhxIJHIlw2+NT/dGJ/aWPoZE0HwphsTOcnPkblAbaZMDUEQL7zyveiHNdv82SFMLmu1c6JHPawAoNmzXBckHp3mHa1JY9CjY5JmKELsDoiZ1YEtB+Eq/qDiWG3d9XJ8k9rhe4kgewKeJxxjPks8kYDyZVLOCAcKMngzUkn93n7MX965esSXUlp6QD+szABFxjOLmao2FUL37MOPB5FhVnN9FmHqgnWumyLepMGZe8vtzTC+4pqj4/UdpqYErFyGlNplSLD5JSHhSpleLDQ43sgerHVknVQDaX1NWn1VA=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a03f55-c0d2-4a5f-2772-08d68777beb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 12:29:16.1106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1454
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_042934_296515_E9E68597 
X-CRM114-Status: GOOD (  10.30  )
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
