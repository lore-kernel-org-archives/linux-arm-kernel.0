Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1847C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:11:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAC442087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u2RGx2qI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jZbVQaF7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="KjEkBfW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC442087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+90CAHyeYrwM9bjZTxxemZZ4lCEaFsefvLj7mX9HRCI=; b=u2RGx2qIyUcOEZ
	X1Eb7VCLe0/UDPNxV+/t9t1UYg1uDxxbo96JBMrwEQEFkVT2tumUhPgzCSVj9qshcQz4DjLnZi7fX
	OnxNy+N3lDj1onghNQ0bEl0tACuZCqYH9/x1nADaaAlrqI/7R2PHoYQN9/cD5TpmkLhXzcQjawzgW
	4BDC8OEeS5lECfnhmrBaM68q+LQMjIy++HfnL9F28aPCGE5htaM8cMs0cnRDstrY/SUwtbgf+S47V
	mHeO0SEzuyKIxDqGxZ/Y7rkrko4AriUbPvwIRLB1u29hco/1A4esToITsYNINyzKZ6Fkh/byriWna
	RI4DauFH0AyiukcJisJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpFs6-0007im-2r; Thu, 31 Jan 2019 17:11:26 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpFrR-0007DU-Da
 for linux-arm-kernel@bombadil.infradead.org; Thu, 31 Jan 2019 17:10:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5PfdJ3ujXxTpaTf1Ie2vb1Tm/DWA82FKVgaWzd1m7m8=; b=jZbVQaF70b8eh8y/QzqdUWmRWO
 suBsEuyZLG4ncNS2DlbN0R5NPw9lUoxPOlalO7Yz0CU6CzwS0KFC61OKTrA1iKU3v6VBG7hHEo2ha
 g52Uk+v60kD76PKW4EeaDEEiiz9kzHmP2A0w3CCmrD0ug5wdXKUKrH0mopmEvl2HW/EnPqJ5WHmsQ
 tsbFSF/5d+5nraiDvZ3zC5Ccso3PiMn25Ap4QovNIbkb29AUdBxxegHcDXiLjDfh0oYc/MiKfPVir
 Z1VRHMNqx1aZk3+b4dQ+mDA4z6u8NCNSOVZ/kwlK6eZlz82tw8dGyfZDAU4rdvc954M1Xb4GmR3Nx
 YbG81GfA==;
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpF2u-0008Ho-Ai
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 16:18:33 +0000
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; d="scan'208";a="25990859"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 31 Jan 2019 09:18:23 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 09:18:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PfdJ3ujXxTpaTf1Ie2vb1Tm/DWA82FKVgaWzd1m7m8=;
 b=KjEkBfW6RBV4Ok2yr5aN68R5JjC93dJj07d8UAwC3pQfOagbbKCrSW+zjQH2htTFzGaB4a8RzkGJopaSfDgh7RBETfPWk32LMMwCEMTKwqX4CBWlv9DTS/3lLQkllBXraX/KDc6mtXaf2IsXchERNfCxCAK7CKEzTv0X/myCRCE=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1424.namprd11.prod.outlook.com (10.169.234.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Thu, 31 Jan 2019 16:18:21 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 31 Jan 2019
 16:18:21 +0000
From: <Claudiu.Beznea@microchip.com>
To: <linus.walleij@linaro.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>, 
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>
Subject: [PATCH v2 6/7] pinctrl: at91: add slewrate support for SAM9X60
Thread-Topic: [PATCH v2 6/7] pinctrl: at91: add slewrate support for SAM9X60
Thread-Index: AQHUuYCVvlymv+JlAk2rY81U8yUjmg==
Date: Thu, 31 Jan 2019 16:18:20 +0000
Message-ID: <1548951466-26297-7-git-send-email-claudiu.beznea@microchip.com>
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
 6:gY11OL6wXhPy4lOx05rMNM4ys1bM244j8HfyyDP1lClTyDuZuHcr2vjuKIeFwtidq52YByFOBVnigro6qy3zKC0gM1KdtBnsKHQiuyoGBfoSPM0E75P00rqbnVcmwk3IOO9dff39gTuVuClKEJj4YHsrBxP9sqm/r4iiEJqyv1DNqxkDoRORBP/Pn0VoRm781dv8LRL3Rbt3oatcY1TegvwUZgHvpgCxorIqaOSD4rOfwRhEle4EWIpTkygnRmyduEK7Cs8Xkyuo+6WxaDmdlwCnkmv4MjIP6ZlRrbZHkpDQq7z/tZQZeVJez5KXTQTKF0MmSyS8LpsAW1W72pDfb1t00TwdGV/2nDDLAJGFrRvZ3xnrzeLArUaQgsbEKHfHBCPfdQevuBdc5NB+2A4sTy3v0GzZtyu5+W8EwBYPChSWlhS0dcLZn9bY5xBK7WB0rGqCkh657HORKxaTys4Xxg==;
 5:eax5ZXydOjgBjkyHwjcnqSXQMCM8RHgiRJUlCcvijURmk9fx3x3PlPmHUlwAvsyTQmlMP7hJl11qE3Ff6WZ6sU2kEQ1ZYw01+2VpTolrDXmGEptmJnwFVv/Ha8PcVw/tjLM9XpmAHSg70351jDiG6frtM+3gz972cylSUEo66K3chSXwFRTlfw5tH5UfVLyil238Lc4o/A0r5wUAxDxcEw==;
 7:PMPJxZvKyNJLz3Lm47EQipiLQ07aN11gvK8pGIjbuM7SRg4uLHvaF8dIpYPH/AJ0UkUycZ3cIeRKfJjmFx/HRbkI//m5K/iSEQSmnIkR/soTkcS8YDYkt99Z3pvGfnrRgmsidwqN8JlhYelFD7Uvaw==
x-ms-office365-filtering-correlation-id: 7100f82c-ffe7-414a-4c29-08d68797b76f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1424; 
x-ms-traffictypediagnostic: MWHPR11MB1424:
x-microsoft-antispam-prvs: <MWHPR11MB1424FC940CC2DAF3105C1B8687910@MWHPR11MB1424.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(189003)(199004)(71190400001)(186003)(6116002)(81156014)(107886003)(99286004)(86362001)(446003)(8936002)(2906002)(53936002)(66066001)(305945005)(110136005)(72206003)(8676002)(68736007)(81166006)(3846002)(478600001)(25786009)(50226002)(54906003)(97736004)(4326008)(36756003)(14454004)(7736002)(316002)(52116002)(102836004)(256004)(386003)(71200400001)(26005)(6512007)(6436002)(76176011)(6486002)(2501003)(2616005)(6506007)(476003)(11346002)(105586002)(6636002)(486006)(106356001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1424;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vyaln7ItWp9sqlug01unC1EjrJ5vHz5a643Lxs7pMjlKJdRLjQ8ylVOVs+JKI2CQbyu7oX9G4Wo1/GjxklG3VuNm/ci4ggx6UkBAHxYLF22Nt9GB45gKnViULo1P8+JoCTOtDmm+4gS1/ZZH8jpzjA5ExJBDtvGHLOKFJqQRdhtD1wA/EP6Djw0+Tpt2RreHdPVMpezt7qJ57UU/pX+5/lf+ObXIwSa2ha7bzZ7bzIOJUDXgoQ0o5/66lgBozw4CAFJjl6Wwbw01K5u/gXN+VdMehUkt/kld28sXuk0QPhd/8bLNuS+VZOGvLx78Sr7sVeQ7Vh/xqlYWCFT0p7cjtCL6GUixUoVxTwzSIFvLSWIhml5vKq+C4NUTF7QBMu1Q97CpCPltWjHRzxvvPyXKWoQGXqaneco5KdPzkEYeTH8=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7100f82c-ffe7-414a-4c29-08d68797b76f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:18:17.9737 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1424
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_111832_557360_2AAC91CA 
X-CRM114-Status: GOOD (  14.63  )
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
