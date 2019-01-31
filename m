Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A69C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:31:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2110D2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rxT0KKqs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="MPP0xCm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2110D2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+90CAHyeYrwM9bjZTxxemZZ4lCEaFsefvLj7mX9HRCI=; b=rxT0KKqsdzDpnv
	nuj63j1gcc4dwC0/vD6+gUX7KjO2vvubGEKl9WMfOGd1nmmgt2GirQjAlLcEUQQ73TR4jsLXilFgn
	tYjgeguVqhEXa9AFfhx6bkno1tuF1cgNb0KdRynOkcYNvlke3L63+5g8iQxp/To9g/MkpBv5CEHoB
	+yv8KCLvrAcDNvF5FvFCp1duf8tDSoPl10/jh8XuG290/B9sBBKNqub17oYFVuLXXvwCJF5hJkmH0
	op+2ZdstFikN6GU+Mcon5xXSr9uZWKZvqK2zL7zIUSlMeuR9+Ki0DTatWbsiUMuBw9DUeSj2mLACV
	Jbdt8Mvbiskb7CSy4YUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpBVL-000662-9A; Thu, 31 Jan 2019 12:31:39 +0000
Received: from esa1.microchip.iphmx.com ([68.232.147.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpBTX-0003XY-77
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 12:30:13 +0000
X-IronPort-AV: E=Sophos;i="5.56,544,1539673200"; d="scan'208";a="27105100"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 31 Jan 2019 05:29:45 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 31 Jan 2019 05:29:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PfdJ3ujXxTpaTf1Ie2vb1Tm/DWA82FKVgaWzd1m7m8=;
 b=MPP0xCm322WLfKnQJF7AR8DcOYQbnuvL26Z8hwVwPTqwLAZpW7k7glWtIogBCuih33xvdbRDjZcZujYiOmeMvsJSBMcDekeP3hicwRWvK3E1PzU5hOi8Hw8dtp0cWk13re/0SBVTRu19uZ/iyLKGXpn6GfdQrYidQin8WSNBT60=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHSPR00MB253.namprd11.prod.outlook.com (10.173.106.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Thu, 31 Jan 2019 12:29:43 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 31 Jan 2019
 12:29:43 +0000
From: <Claudiu.Beznea@microchip.com>
To: <linus.walleij@linaro.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>, 
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>
Subject: [PATCH 6/7] pinctrl: at91: add slewrate support for SAM9X60
Thread-Topic: [PATCH 6/7] pinctrl: at91: add slewrate support for SAM9X60
Thread-Index: AQHUuWCkSvu20P/Y1EWp0R5ORB7lVg==
Date: Thu, 31 Jan 2019 12:29:43 +0000
Message-ID: <1548937733-20189-7-git-send-email-claudiu.beznea@microchip.com>
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
x-microsoft-exchange-diagnostics: 1; MWHSPR00MB253;
 6:f2MkhfOCqIOaVjobisEU4781forAlpSY/+fGemQGfUajRYtT9lrQZDYKhvdfMOgUdKNSW2fqogqUGbYCpEeIhw9OAxj6yUoil/J7vt5bEa+S2AC5hooQq7SzT23TrMX3qzG6TAYfwabgNEB5rkS1cp1ucW0G/AdpGb2HH7PWPci8NPZDU/PlwhpX+pi1I+cxKM8qTbdkCaLdvXUe3/5LwRxfpHBtpdXjH6k8xcjzVE4qyCSBSftpw1ugNzn66qnZs1rXhvF+ZFnp7iMAYMEuDIsbYQchKBWAigEPMui2Ab6UJ3znYws1cP+OMNALJtK7OMETUIjteTudlg/xxHxeFS0/xTeqdzo0fXZKr3b8u5oFxWeoWuqTNve+5/mTvXbXRP8I2c5Kn/XBXvBM4kl0w2LfF8AryXR9v8+QqCpK4e8Ybr7NCVToqmhiS1sA8HNStPcsGd5Uj85AgTnkGo5E0A==;
 5:NfIV3bLEgqy8MhWyxh+aTAHcylMDhNl2RV9mJFe9Hoqh/XMzNYFscHdrSN6J2deder05nbs9eIP208dSRbH47GC3SKa1W07gjs65UtX70IdoexPFZ48UXAke9/BY3ugu/ClymifdoK2oQwqnWQEmSC8x83xGZjGUbllOoWAUA0xMLmWdkjo/7M7uFVCgGuNGb7NCnzW1xdwd8qVaOvP5zg==;
 7:5cpiXAMBE4bp5HPxwTP3kg1OdWFcXzfY0wpBd/xtMvdpFHZmjcbJSqrqJov3Ciwedw2qkqSaXwcWocdeyxaMHrBjrqV3NZBdyseSHyofAMhcQbbF+YG65/dcmK+i4hXnfENthdU2o5/odH8uPyI47A==
x-ms-office365-filtering-correlation-id: 41509d77-d616-49a3-7cfc-08d68777c73b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHSPR00MB253; 
x-ms-traffictypediagnostic: MWHSPR00MB253:
x-microsoft-antispam-prvs: <MWHSPR00MB253463B9B02C2558290893E87910@MWHSPR00MB253.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(366004)(189003)(199004)(86362001)(14454004)(106356001)(8936002)(186003)(8676002)(50226002)(36756003)(6512007)(478600001)(72206003)(105586002)(68736007)(25786009)(81156014)(81166006)(256004)(53936002)(6116002)(3846002)(4326008)(54906003)(107886003)(110136005)(97736004)(2501003)(71190400001)(76176011)(386003)(6506007)(99286004)(26005)(102836004)(71200400001)(11346002)(7736002)(486006)(52116002)(6436002)(446003)(6486002)(316002)(2616005)(305945005)(476003)(66066001)(2906002)(6636002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHSPR00MB253;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 23R9pmoc9TJwWO9FwygdAmOvM0b8TQlZ6DJFptFwZZg0wnDeUHypUWYLHN8S4VZvrosCbJ6V/sgkj/FaGMnC3BlCQoGgWHUNPvBAPD7idwoA2BIH+BA8a184z9wCjMdlyz52NfJ9CEBtktp/MeqXNF/ehp+LHvVBfs/T1Meh45cwOHLGNALggFvb9jYhdTwh4LSToSpFgDXS1qP4hw1nQvRqx7oh/qzOrWiFZuHRAHvqRs1YSRtgJRLRf03eD+0bmV8xriRXeQR4tyk1dvJ2rh9GQ4dZ3eE66cMydGkex2om0XR6Z8WfAmeoiPw2n70QmIG6ieuipokL4V7dQxY749+Q4KWyTynBRQ8q4YF3lJrxntmjgo75rRdJg22TnfPelCAsq7JCaKVZb5KL2rBBtEp1ljmufy1TCM3tqjumt3E=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 41509d77-d616-49a3-7cfc-08d68777c73b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 12:29:40.3962 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR00MB253
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_042948_060105_6912D170 
X-CRM114-Status: GOOD (  12.98  )
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

Add slew rate support for SAM9X60 pin controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pinctrl/pinctrl-at91.c     | 48 ++++++++++++++++++++++++++++++++++++++
 drivers/pinctrl/pinctrl-at91.h     |  1 +
 include/dt-bindings/pinctrl/at91.h |  4 ++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 5456a2692b8c..2c6d3b61951f 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -59,6 +59,9 @@ static int gpio_banks;
 #define OUTPUT		(1 << 7)
 #define OUTPUT_VAL_SHIFT	8
 #define OUTPUT_VAL	(0x1 << OUTPUT_VAL_SHIFT)
+#define SLEWRATE_SHIFT	9
+#define SLEWRATE_MASK	0x1
+#define SLEWRATE	(SLEWRATE_MASK << SLEWRATE_SHIFT)
 #define DEBOUNCE	(1 << 16)
 #define DEBOUNCE_VAL_SHIFT	17
 #define DEBOUNCE_VAL	(0x3fff << DEBOUNCE_VAL_SHIFT)
@@ -82,6 +85,13 @@ enum drive_strength_bit {
 #define DRIVE_STRENGTH_BIT_MSK(name)	(DRIVE_STRENGTH_BIT_##name << \
 					 DRIVE_STRENGTH_SHIFT)
 
+enum slewrate_bit {
+	SLEWRATE_BIT_DIS,
+	SLEWRATE_BIT_ENA,
+};
+
+#define SLEWRATE_BIT_MSK(name)		(SLEWRATE_BIT_##name << SLEWRATE_SHIFT)
+
 /**
  * struct at91_pmx_func - describes AT91 pinmux functions
  * @name: the name of this specific function
@@ -171,6 +181,8 @@ struct at91_pinctrl_mux_ops {
 	unsigned (*get_drivestrength)(void __iomem *pio, unsigned pin);
 	void (*set_drivestrength)(void __iomem *pio, unsigned pin,
 					u32 strength);
+	unsigned (*get_slewrate)(void __iomem *pio, unsigned pin);
+	void (*set_slewrate)(void __iomem *pio, unsigned pin, u32 slewrate);
 	/* irq */
 	int (*irq_type)(struct irq_data *d, unsigned type);
 };
@@ -585,6 +597,16 @@ static unsigned at91_mux_sam9x60_get_drivestrength(void __iomem *pio,
 	return DRIVE_STRENGTH_BIT_LOW;
 }
 
+static unsigned at91_mux_sam9x60_get_slewrate(void __iomem *pio, unsigned pin)
+{
+	unsigned tmp = readl_relaxed(pio + SAM9X60_PIO_SLEWR);
+
+	if ((tmp & BIT(pin)))
+		return SLEWRATE_BIT_ENA;
+
+	return SLEWRATE_BIT_DIS;
+}
+
 static void set_drive_strength(void __iomem *reg, unsigned pin, u32 strength)
 {
 	unsigned tmp = readl_relaxed(reg);
@@ -643,6 +665,24 @@ static void at91_mux_sam9x60_set_drivestrength(void __iomem *pio, unsigned pin,
 	writel_relaxed(tmp, pio + SAM9X60_PIO_DRIVER1);
 }
 
+static void at91_mux_sam9x60_set_slewrate(void __iomem *pio, unsigned pin,
+					  u32 setting)
+{
+	unsigned int tmp;
+
+	if (setting < SLEWRATE_BIT_DIS || setting > SLEWRATE_BIT_ENA)
+		return;
+
+	tmp = readl_relaxed(pio + SAM9X60_PIO_SLEWR);
+
+	if (setting == SLEWRATE_BIT_DIS)
+		tmp &= ~BIT(pin);
+	else
+		tmp |= BIT(pin);
+
+	writel_relaxed(tmp, pio + SAM9X60_PIO_SLEWR);
+}
+
 static struct at91_pinctrl_mux_ops at91rm9200_ops = {
 	.get_periph	= at91_mux_get_periph,
 	.mux_A_periph	= at91_mux_set_A_periph,
@@ -687,6 +727,8 @@ static const struct at91_pinctrl_mux_ops sam9x60_ops = {
 	.disable_schmitt_trig = at91_mux_pio3_disable_schmitt_trig,
 	.get_drivestrength = at91_mux_sam9x60_get_drivestrength,
 	.set_drivestrength = at91_mux_sam9x60_set_drivestrength,
+	.get_slewrate   = at91_mux_sam9x60_get_slewrate,
+	.set_slewrate   = at91_mux_sam9x60_set_slewrate,
 	.irq_type	= alt_gpio_irq_type,
 
 };
@@ -950,6 +992,8 @@ static int at91_pinconf_get(struct pinctrl_dev *pctldev,
 	if (info->ops->get_drivestrength)
 		*config |= (info->ops->get_drivestrength(pio, pin)
 				<< DRIVE_STRENGTH_SHIFT);
+	if (info->ops->get_slewrate)
+		*config |= (info->ops->get_slewrate(pio, pin) << SLEWRATE_SHIFT);
 	if (at91_mux_get_output(pio, pin, &out))
 		*config |= OUTPUT | (out << OUTPUT_VAL_SHIFT);
 
@@ -1001,6 +1045,9 @@ static int at91_pinconf_set(struct pinctrl_dev *pctldev,
 			info->ops->set_drivestrength(pio, pin,
 				(config & DRIVE_STRENGTH)
 					>> DRIVE_STRENGTH_SHIFT);
+		if (info->ops->set_slewrate)
+			info->ops->set_slewrate(pio, pin,
+				(config & SLEWRATE) >> SLEWRATE_SHIFT);
 
 	} /* for each config */
 
@@ -1044,6 +1091,7 @@ static void at91_pinconf_dbg_show(struct pinctrl_dev *pctldev,
 			     DRIVE_STRENGTH_MED);
 	DBG_SHOW_FLAG_MASKED(DRIVE_STRENGTH, DRIVE_STRENGTH_BIT_MSK(HI),
 			     DRIVE_STRENGTH_HI);
+	DBG_SHOW_FLAG(SLEWRATE);
 	DBG_SHOW_FLAG(DEBOUNCE);
 	if (config & DEBOUNCE) {
 		val = config >> DEBOUNCE_VAL_SHIFT;
diff --git a/drivers/pinctrl/pinctrl-at91.h b/drivers/pinctrl/pinctrl-at91.h
index 19fc27e66bfd..223620f14b05 100644
--- a/drivers/pinctrl/pinctrl-at91.h
+++ b/drivers/pinctrl/pinctrl-at91.h
@@ -69,6 +69,7 @@
 #define AT91SAM9X5_PIO_DRIVER1	0x114  /*PIO Driver 1 register offset*/
 #define AT91SAM9X5_PIO_DRIVER2	0x118  /*PIO Driver 2 register offset*/
 
+#define SAM9X60_PIO_SLEWR	0x110	/* PIO Slew Rate Control Register */
 #define SAM9X60_PIO_DRIVER1	0x118	/* PIO Driver 1 register offset */
 
 #endif
diff --git a/include/dt-bindings/pinctrl/at91.h b/include/dt-bindings/pinctrl/at91.h
index eb81867eac77..8dc10e00c627 100644
--- a/include/dt-bindings/pinctrl/at91.h
+++ b/include/dt-bindings/pinctrl/at91.h
@@ -17,6 +17,7 @@
 #define AT91_PINCTRL_DIS_SCHMIT		(1 << 4)
 #define AT91_PINCTRL_OUTPUT		(1 << 7)
 #define AT91_PINCTRL_OUTPUT_VAL(x)	((x & 0x1) << 8)
+#define AT91_PINCTRL_SLEWRATE		(1 << 9)
 #define AT91_PINCTRL_DEBOUNCE		(1 << 16)
 #define AT91_PINCTRL_DEBOUNCE_VAL(x)	(x << 17)
 
@@ -27,6 +28,9 @@
 #define AT91_PINCTRL_DRIVE_STRENGTH_MED			(0x2 << 5)
 #define AT91_PINCTRL_DRIVE_STRENGTH_HI			(0x3 << 5)
 
+#define AT91_PINCTRL_SLEWRATE_DIS	(0x0 << 9)
+#define AT91_PINCTRL_SLEWRATE_ENA	(0x1 << 9)
+
 #define AT91_PIOA	0
 #define AT91_PIOB	1
 #define AT91_PIOC	2
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
