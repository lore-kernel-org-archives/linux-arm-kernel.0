Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA74C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:40:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA0A2229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cEfBYKw2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="kNSP2nFq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA0A2229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qbrG+VqwFyom3jABQ9XLzEO7gz/ZwO8Kmb5jnFJ/Zs8=; b=cEfBYKw23RKDuu
	YWOaOWuo0uMiKKt9WXe2BBS8+k5JLDLVsz/3sFJBmc4G1P0gYNmuhLiws8ZLIHoWohNcjAmCAAjKU
	jApAc+oSbq2eVwbxkjwyOFS+U7k8cEVT7+cwFCVEo/m7UfTcvNJxVOFFqlJWFiTqcNA1ytPOcHzpi
	+BO+cHHwruQ4bKr1KSfTnGrv2cQwBPUosSTEEdgPctEKxDGV+5AlzfZaso64rA1OGGg0eJGxGg2Li
	xzLf+radJxYFoPYhSiajvyWt4V6hbUtqSDhUT3zMWiVEXvvnlvALqkCfrsIiwy+OJJ/pr/wlYRk7R
	Y+f4915X3HYHcE7wRlYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guERX-0001l0-7Y; Thu, 14 Feb 2019 10:40:35 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guEQm-00087S-Nq
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 10:39:54 +0000
X-IronPort-AV: E=Sophos;i="5.58,368,1544511600"; d="scan'208";a="26727443"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 14 Feb 2019 03:39:45 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 14 Feb 2019 03:39:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9pEge9jHPRkIpmmp6f9i13eKcs7W6QUdW+IVcEz4j0=;
 b=kNSP2nFqU9+RE0pj18ZX+8HLp44bWNhxXBTOU7BCfpPu+hVwiuyjY9hLUhKh7ulIFHWiOmb9fyX5AbqxbYsxOkZr23IIU2arjPYaUDteVufNQBdDgH+ZBQqP0GNsm7zB88Qo2HOClvhXbkSkkBlQS0KZYJ7wUgjy9Ob7fdmxYao=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1311.namprd11.prod.outlook.com (10.169.237.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Thu, 14 Feb 2019 10:39:41 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 10:39:41 +0000
From: <Claudiu.Beznea@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
 <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
Subject: [PATCH 1/2] clk: at91: sckc: adapt sckc driver to work for SAM9X60
Thread-Topic: [PATCH 1/2] clk: at91: sckc: adapt sckc driver to work for
 SAM9X60
Thread-Index: AQHUxFGXuEaJzr2tUEWTZnavtTCZMw==
Date: Thu, 14 Feb 2019 10:39:41 +0000
Message-ID: <1550140748-21714-2-git-send-email-claudiu.beznea@microchip.com>
References: <1550140748-21714-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550140748-21714-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0131.eurprd07.prod.outlook.com
 (2603:10a6:802:16::18) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [213.233.85.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69b9de97-123a-4ce7-4825-08d69268b982
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1311; 
x-ms-traffictypediagnostic: MWHPR11MB1311:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; MWHPR11MB1311;
 23:BS1rIMHOAFK0BUF5n2Xb3DlwsClX0chBrqld71K?=
 =?iso-8859-1?Q?MczTkxUapSALHXTt4YOFYgJGmlxd82LwrKjmXEPUbTQ/8a/lJG9nwWyJ1M?=
 =?iso-8859-1?Q?nUltvExIhaa8wrgNd/2OXSLgjsiXooVkIRysPKhFixopRnujNQjhhFvEtc?=
 =?iso-8859-1?Q?khp+RBdINtcB93o2q4oSEq1M7K6AOQZMa6tBapx+zUlxI65HgUxmV/X6fI?=
 =?iso-8859-1?Q?+Q8eMAo9cc85Zv5FOJoai7DtL55Xi9mPSmw2BhObN6k3BosPsIOhdcWlXG?=
 =?iso-8859-1?Q?tgMF+brGYqSCr9v0p/kZpX98VOeoSiR3fnt4oMg5l8Hutw+NRIIdR4U9Po?=
 =?iso-8859-1?Q?UmAwjqGiwdmu/3WcQrGvLQonqWnjiTIo/GTfauD5T50WKXq3jJw4RQTSNf?=
 =?iso-8859-1?Q?ZuN6U8qz5DstNQjmRnerKSfwJWzjHex/MFjMuo0CJuocABdGOzGGcynQCy?=
 =?iso-8859-1?Q?zQHEeDa0dsCpIA8BvcaU449lpjQliNXd3gAOClDlENuexJCu671nVdgbQA?=
 =?iso-8859-1?Q?1Fzc9vQz4AtMErcRf+n6Y2I2G3o1iOJBMegwH+wKjNnvy53oRDdPAy3PjX?=
 =?iso-8859-1?Q?KUu0McDWjLxiFRErpcKoKH04bCdJROsjnmnxckEYXMRaR1FC6BVGrRA6Ib?=
 =?iso-8859-1?Q?gnAsAQrnklhbOzym7KLvE7qKJdSxXdNtT8Ic8RdiWORoCei1dFQC0SEmNo?=
 =?iso-8859-1?Q?jz5IO7rRTShWzob61FSHHTD1kIjLj+TyfkW8/ukJlz+Ss4gz/0Z+rHNCIG?=
 =?iso-8859-1?Q?vYAXNMemVE60pzzwrOQxNpHXtaK+qbEq5EmcaGBVXzLL0Zo5Y8KFg3oign?=
 =?iso-8859-1?Q?C9qFy8PhL8dwjReGrVzK0SvWBzVt8KYX3AwLMEW0jelAKZZBqjBbFq2bNF?=
 =?iso-8859-1?Q?bZY9p00ltgb1JI8wwH8RREPtD61ifVmI51e7doiZYjpTTTS+/kDFa6pNKb?=
 =?iso-8859-1?Q?racCSGXyz1+4cua9TuHW8pugWEkCipdVF/xRO5NWbktKNtVTRiAjGz0cqj?=
 =?iso-8859-1?Q?m6DHrri9uiHIwaWpVNW8EWIvcq78omQQA58Rq8NLvxQdRJjqOO6xwVPBQ6?=
 =?iso-8859-1?Q?wHnvWMwzMYZGt5Pmw21TVqieshZikaX3Nul+MHerCcGbc/L2U8aEAkti2E?=
 =?iso-8859-1?Q?FZp37fZVJJxqEs6jdd7waHBw4xLOzch647OZ4U22WAOs0p7W4JzAlrv6M6?=
 =?iso-8859-1?Q?dhaFOiEtxja+RMii2hv2HG3bgjygH4uQ4yWJZTXTF4w9sWTkpe/1xDv4U+?=
 =?iso-8859-1?Q?GGN+AQQMHRCilXUJFUlUuNGHhXVTTNfTxHIssv8sEV8bM19+H7AO6PM69Z?=
 =?iso-8859-1?Q?6XTlmM9cZ33DN/QLvp+C+Zz?=
x-microsoft-antispam-prvs: <MWHPR11MB13119F5DC2F09745AAD0CF4087670@MWHPR11MB1311.namprd11.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(396003)(376002)(136003)(39860400002)(189003)(199004)(53936002)(110136005)(105586002)(106356001)(72206003)(97736004)(3846002)(6436002)(478600001)(6116002)(86362001)(36756003)(6512007)(2501003)(2906002)(25786009)(68736007)(14454004)(50226002)(81166006)(81156014)(8676002)(99286004)(71190400001)(66066001)(4326008)(486006)(7736002)(30864003)(305945005)(71200400001)(8936002)(76176011)(26005)(256004)(386003)(6506007)(52116002)(6486002)(6636002)(446003)(476003)(316002)(2616005)(11346002)(54906003)(102836004)(186003)(107886003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1311;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A3mkm/pun9YCdTlnadrlCsUzkIr7D37/mSJnsAwYl+UQPPji4NcY/dP/ckw4A42MnWX2+/Bk9dgBNuHY3oeJwPMKiUmT17U2J795DJwDj7V5/I3G/FurW19T+4yRps5HPlNqX9yevRCUi1Q7Ns6A9YKIuPjJ6hicm2XpBlCV8ZnjwWk17FbdTefw9oDljWbgJvg7Im05KumcqVad4liBCq9gMGM5dM9pg2dMnWWk9H9sOxr3Y8yYBkjwe07ecPlxF/6drjimmC8Of7GoU4lQcpv0O6Mj4wKJsR9/T0EJzycxJyb+E0RXdZXSwtvdu0Nh2QD/ubpb39zG9kfO5X+w0AVNHGYZHcYkdEe/HIt/QTgFi26gLNtlt3jjJncVmV5iXnEF24tqTxynMgQC4OmcjCB1EHz68FniarEbn9tThXI=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b9de97-123a-4ce7-4825-08d69268b982
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 10:39:37.0381 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1311
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_023949_321375_342BDE7F 
X-CRM114-Status: GOOD (  13.46  )
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
Cc: devicetree@vger.kernel.org, Claudiu.Beznea@microchip.com,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

SAM9X60 uses different bit offsets in registers. Adapt the driver to work
also for SAM9X60.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sckc.c | 142 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 107 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index ab6ecefc49ad..aaef29dacbb5 100644
--- a/drivers/clk/at91/sckc.c
+++ b/drivers/clk/at91/sckc.c
@@ -22,15 +22,25 @@
 #define SLOWCK_SW_TIME_USEC	((SLOWCK_SW_CYCLES * USEC_PER_SEC) / \
 				 SLOW_CLOCK_FREQ)
 
-#define	AT91_SCKC_CR			0x00
-#define		AT91_SCKC_RCEN		(1 << 0)
-#define		AT91_SCKC_OSC32EN	(1 << 1)
-#define		AT91_SCKC_OSC32BYP	(1 << 2)
-#define		AT91_SCKC_OSCSEL	(1 << 3)
+#define	AT91_SCKC_CR		0x00
+#define		AT91_SCKC_RCEN(off)	(1 << (off)->cr_rcen)
+#define		AT91_SCKC_OSC32EN(off)	(1 << (off)->cr_osc32en)
+#define		AT91_SCKC_OSC32BYP(off)	(1 << (off)->cr_osc32byp)
+#define		AT91_SCKC_OSCSEL(off)	(1 << (off)->cr_oscsel)
+
+#define AT91_SCKC_OFFSET_INVALID        (32)
+
+struct clk_slow_offsets {
+	u8 cr_rcen;
+	u8 cr_osc32en;
+	u8 cr_osc32byp;
+	u8 cr_oscsel;
+};
 
 struct clk_slow_osc {
 	struct clk_hw hw;
 	void __iomem *sckcr;
+	const struct clk_slow_offsets *offsets;
 	unsigned long startup_usec;
 };
 
@@ -39,6 +49,7 @@ struct clk_slow_osc {
 struct clk_sama5d4_slow_osc {
 	struct clk_hw hw;
 	void __iomem *sckcr;
+	const struct clk_slow_offsets *offsets;
 	unsigned long startup_usec;
 	bool prepared;
 };
@@ -48,6 +59,7 @@ struct clk_sama5d4_slow_osc {
 struct clk_slow_rc_osc {
 	struct clk_hw hw;
 	void __iomem *sckcr;
+	const struct clk_slow_offsets *offsets;
 	unsigned long frequency;
 	unsigned long accuracy;
 	unsigned long startup_usec;
@@ -58,6 +70,7 @@ struct clk_slow_rc_osc {
 struct clk_sam9x5_slow {
 	struct clk_hw hw;
 	void __iomem *sckcr;
+	const struct clk_slow_offsets *offsets;
 	u8 parent;
 };
 
@@ -69,10 +82,11 @@ static int clk_slow_osc_prepare(struct clk_hw *hw)
 	void __iomem *sckcr = osc->sckcr;
 	u32 tmp = readl(sckcr);
 
-	if (tmp & (AT91_SCKC_OSC32BYP | AT91_SCKC_OSC32EN))
+	if (tmp & (AT91_SCKC_OSC32BYP(osc->offsets) |
+		   AT91_SCKC_OSC32EN(osc->offsets)))
 		return 0;
 
-	writel(tmp | AT91_SCKC_OSC32EN, sckcr);
+	writel(tmp | AT91_SCKC_OSC32EN(osc->offsets), sckcr);
 
 	usleep_range(osc->startup_usec, osc->startup_usec + 1);
 
@@ -85,10 +99,10 @@ static void clk_slow_osc_unprepare(struct clk_hw *hw)
 	void __iomem *sckcr = osc->sckcr;
 	u32 tmp = readl(sckcr);
 
-	if (tmp & AT91_SCKC_OSC32BYP)
+	if (tmp & AT91_SCKC_OSC32BYP(osc->offsets))
 		return;
 
-	writel(tmp & ~AT91_SCKC_OSC32EN, sckcr);
+	writel(tmp & ~AT91_SCKC_OSC32EN(osc->offsets), sckcr);
 }
 
 static int clk_slow_osc_is_prepared(struct clk_hw *hw)
@@ -97,10 +111,10 @@ static int clk_slow_osc_is_prepared(struct clk_hw *hw)
 	void __iomem *sckcr = osc->sckcr;
 	u32 tmp = readl(sckcr);
 
-	if (tmp & AT91_SCKC_OSC32BYP)
+	if (tmp & AT91_SCKC_OSC32BYP(osc->offsets))
 		return 1;
 
-	return !!(tmp & AT91_SCKC_OSC32EN);
+	return !!(tmp & AT91_SCKC_OSC32EN(osc->offsets));
 }
 
 static const struct clk_ops slow_osc_ops = {
@@ -114,7 +128,8 @@ at91_clk_register_slow_osc(void __iomem *sckcr,
 			   const char *name,
 			   const char *parent_name,
 			   unsigned long startup,
-			   bool bypass)
+			   bool bypass,
+			   const struct clk_slow_offsets *offsets)
 {
 	struct clk_slow_osc *osc;
 	struct clk_hw *hw;
@@ -137,9 +152,11 @@ at91_clk_register_slow_osc(void __iomem *sckcr,
 	osc->hw.init = &init;
 	osc->sckcr = sckcr;
 	osc->startup_usec = startup;
+	osc->offsets = offsets;
 
 	if (bypass)
-		writel((readl(sckcr) & ~AT91_SCKC_OSC32EN) | AT91_SCKC_OSC32BYP,
+		writel((readl(sckcr) & ~AT91_SCKC_OSC32EN(osc->offsets)) |
+					AT91_SCKC_OSC32BYP(osc->offsets),
 		       sckcr);
 
 	hw = &osc->hw;
@@ -153,7 +170,8 @@ at91_clk_register_slow_osc(void __iomem *sckcr,
 }
 
 static void __init
-of_at91sam9x5_clk_slow_osc_setup(struct device_node *np, void __iomem *sckcr)
+of_at91sam9x5_clk_slow_osc_setup(struct device_node *np, void __iomem *sckcr,
+				 const struct clk_slow_offsets *offsets)
 {
 	struct clk_hw *hw;
 	const char *parent_name;
@@ -167,7 +185,7 @@ of_at91sam9x5_clk_slow_osc_setup(struct device_node *np, void __iomem *sckcr)
 	bypass = of_property_read_bool(np, "atmel,osc-bypass");
 
 	hw = at91_clk_register_slow_osc(sckcr, name, parent_name, startup,
-					 bypass);
+					bypass, offsets);
 	if (IS_ERR(hw))
 		return;
 
@@ -195,7 +213,7 @@ static int clk_slow_rc_osc_prepare(struct clk_hw *hw)
 	struct clk_slow_rc_osc *osc = to_clk_slow_rc_osc(hw);
 	void __iomem *sckcr = osc->sckcr;
 
-	writel(readl(sckcr) | AT91_SCKC_RCEN, sckcr);
+	writel(readl(sckcr) | AT91_SCKC_RCEN(osc->offsets), sckcr);
 
 	usleep_range(osc->startup_usec, osc->startup_usec + 1);
 
@@ -207,14 +225,14 @@ static void clk_slow_rc_osc_unprepare(struct clk_hw *hw)
 	struct clk_slow_rc_osc *osc = to_clk_slow_rc_osc(hw);
 	void __iomem *sckcr = osc->sckcr;
 
-	writel(readl(sckcr) & ~AT91_SCKC_RCEN, sckcr);
+	writel(readl(sckcr) & ~AT91_SCKC_RCEN(osc->offsets), sckcr);
 }
 
 static int clk_slow_rc_osc_is_prepared(struct clk_hw *hw)
 {
 	struct clk_slow_rc_osc *osc = to_clk_slow_rc_osc(hw);
 
-	return !!(readl(osc->sckcr) & AT91_SCKC_RCEN);
+	return !!(readl(osc->sckcr) & AT91_SCKC_RCEN(osc->offsets));
 }
 
 static const struct clk_ops slow_rc_osc_ops = {
@@ -230,7 +248,8 @@ at91_clk_register_slow_rc_osc(void __iomem *sckcr,
 			      const char *name,
 			      unsigned long frequency,
 			      unsigned long accuracy,
-			      unsigned long startup)
+			      unsigned long startup,
+			      const struct clk_slow_offsets *offsets)
 {
 	struct clk_slow_rc_osc *osc;
 	struct clk_hw *hw;
@@ -252,6 +271,7 @@ at91_clk_register_slow_rc_osc(void __iomem *sckcr,
 
 	osc->hw.init = &init;
 	osc->sckcr = sckcr;
+	osc->offsets = offsets;
 	osc->frequency = frequency;
 	osc->accuracy = accuracy;
 	osc->startup_usec = startup;
@@ -267,7 +287,8 @@ at91_clk_register_slow_rc_osc(void __iomem *sckcr,
 }
 
 static void __init
-of_at91sam9x5_clk_slow_rc_osc_setup(struct device_node *np, void __iomem *sckcr)
+of_at91sam9x5_clk_slow_rc_osc_setup(struct device_node *np, void __iomem *sckcr,
+				    const struct clk_slow_offsets *offsets)
 {
 	struct clk_hw *hw;
 	u32 frequency = 0;
@@ -281,7 +302,7 @@ of_at91sam9x5_clk_slow_rc_osc_setup(struct device_node *np, void __iomem *sckcr)
 	of_property_read_u32(np, "atmel,startup-time-usec", &startup);
 
 	hw = at91_clk_register_slow_rc_osc(sckcr, name, frequency, accuracy,
-					    startup);
+					   startup, offsets);
 	if (IS_ERR(hw))
 		return;
 
@@ -299,14 +320,14 @@ static int clk_sam9x5_slow_set_parent(struct clk_hw *hw, u8 index)
 
 	tmp = readl(sckcr);
 
-	if ((!index && !(tmp & AT91_SCKC_OSCSEL)) ||
-	    (index && (tmp & AT91_SCKC_OSCSEL)))
+	if ((!index && !(tmp & AT91_SCKC_OSCSEL(slowck->offsets))) ||
+	    (index && (tmp & AT91_SCKC_OSCSEL(slowck->offsets))))
 		return 0;
 
 	if (index)
-		tmp |= AT91_SCKC_OSCSEL;
+		tmp |= AT91_SCKC_OSCSEL(slowck->offsets);
 	else
-		tmp &= ~AT91_SCKC_OSCSEL;
+		tmp &= ~AT91_SCKC_OSCSEL(slowck->offsets);
 
 	writel(tmp, sckcr);
 
@@ -319,7 +340,7 @@ static u8 clk_sam9x5_slow_get_parent(struct clk_hw *hw)
 {
 	struct clk_sam9x5_slow *slowck = to_clk_sam9x5_slow(hw);
 
-	return !!(readl(slowck->sckcr) & AT91_SCKC_OSCSEL);
+	return !!(readl(slowck->sckcr) & AT91_SCKC_OSCSEL(slowck->offsets));
 }
 
 static const struct clk_ops sam9x5_slow_ops = {
@@ -331,7 +352,8 @@ static struct clk_hw * __init
 at91_clk_register_sam9x5_slow(void __iomem *sckcr,
 			      const char *name,
 			      const char **parent_names,
-			      int num_parents)
+			      int num_parents,
+			      const struct clk_slow_offsets *offsets)
 {
 	struct clk_sam9x5_slow *slowck;
 	struct clk_hw *hw;
@@ -353,7 +375,8 @@ at91_clk_register_sam9x5_slow(void __iomem *sckcr,
 
 	slowck->hw.init = &init;
 	slowck->sckcr = sckcr;
-	slowck->parent = !!(readl(sckcr) & AT91_SCKC_OSCSEL);
+	slowck->offsets = offsets;
+	slowck->parent = !!(readl(sckcr) & AT91_SCKC_OSCSEL(slowck->offsets));
 
 	hw = &slowck->hw;
 	ret = clk_hw_register(NULL, &slowck->hw);
@@ -366,7 +389,8 @@ at91_clk_register_sam9x5_slow(void __iomem *sckcr,
 }
 
 static void __init
-of_at91sam9x5_clk_slow_setup(struct device_node *np, void __iomem *sckcr)
+of_at91sam9x5_clk_slow_setup(struct device_node *np, void __iomem *sckcr,
+			     const struct clk_slow_offsets *offsets)
 {
 	struct clk_hw *hw;
 	const char *parent_names[2];
@@ -382,7 +406,7 @@ of_at91sam9x5_clk_slow_setup(struct device_node *np, void __iomem *sckcr)
 	of_property_read_string(np, "clock-output-names", &name);
 
 	hw = at91_clk_register_sam9x5_slow(sckcr, name, parent_names,
-					    num_parents);
+					   num_parents, offsets);
 	if (IS_ERR(hw))
 		return;
 
@@ -406,10 +430,18 @@ static const struct of_device_id sckc_clk_ids[] __initconst = {
 	{ /*sentinel*/ }
 };
 
+static const struct clk_slow_offsets at91sam9x5_offsets = {
+	.cr_rcen = 0,
+	.cr_osc32en = 1,
+	.cr_osc32byp = 2,
+	.cr_oscsel = 3,
+};
+
 static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
 {
 	struct device_node *childnp;
-	void (*clk_setup)(struct device_node *, void __iomem *);
+	void (*clk_setup)(struct device_node *np, void __iomem *io,
+			  const struct clk_slow_offsets *offsets);
 	const struct of_device_id *clk_id;
 	void __iomem *regbase = of_iomap(np, 0);
 
@@ -421,12 +453,42 @@ static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
 		if (!clk_id)
 			continue;
 		clk_setup = clk_id->data;
-		clk_setup(childnp, regbase);
+		clk_setup(childnp, regbase, &at91sam9x5_offsets);
 	}
 }
 CLK_OF_DECLARE(at91sam9x5_clk_sckc, "atmel,at91sam9x5-sckc",
 	       of_at91sam9x5_sckc_setup);
 
+static const struct clk_slow_offsets at91sam9x60_offsets = {
+	.cr_rcen = AT91_SCKC_OFFSET_INVALID,
+	.cr_osc32en = 1,
+	.cr_osc32byp = 2,
+	.cr_oscsel = 24,
+};
+
+static void __init of_at91sam9x60_sckc_setup(struct device_node *np)
+{
+	struct device_node *childnp;
+	void (*clk_setup)(struct device_node *np, void __iomem *io,
+			  const struct clk_slow_offsets *offsets);
+	const struct of_device_id *clk_id;
+	void __iomem *regbase = of_iomap(np, 0);
+
+	if (!regbase)
+		return;
+
+	for_each_child_of_node(np, childnp) {
+		clk_id = of_match_node(sckc_clk_ids, childnp);
+		if (!clk_id)
+			continue;
+		clk_setup = clk_id->data;
+		clk_setup(childnp, regbase, &at91sam9x60_offsets);
+	}
+}
+
+CLK_OF_DECLARE(at91sam9x60_clk_sckc, "microchip,at91sam9x60-sckc",
+	       of_at91sam9x60_sckc_setup);
+
 static int clk_sama5d4_slow_osc_prepare(struct clk_hw *hw)
 {
 	struct clk_sama5d4_slow_osc *osc = to_clk_sama5d4_slow_osc(hw);
@@ -438,7 +500,7 @@ static int clk_sama5d4_slow_osc_prepare(struct clk_hw *hw)
 	 * Assume that if it has already been selected (for example by the
 	 * bootloader), enough time has aready passed.
 	 */
-	if ((readl(osc->sckcr) & AT91_SCKC_OSCSEL)) {
+	if ((readl(osc->sckcr) & AT91_SCKC_OSCSEL(osc->offsets))) {
 		osc->prepared = true;
 		return 0;
 	}
@@ -461,6 +523,13 @@ static const struct clk_ops sama5d4_slow_osc_ops = {
 	.is_prepared = clk_sama5d4_slow_osc_is_prepared,
 };
 
+static const struct clk_slow_offsets at91sama5d4_offsets = {
+	.cr_rcen = AT91_SCKC_OFFSET_INVALID,
+	.cr_osc32en = AT91_SCKC_OFFSET_INVALID,
+	.cr_osc32byp = AT91_SCKC_OFFSET_INVALID,
+	.cr_oscsel = 3,
+};
+
 static void __init of_sama5d4_sckc_setup(struct device_node *np)
 {
 	void __iomem *regbase = of_iomap(np, 0);
@@ -498,9 +567,11 @@ static void __init of_sama5d4_sckc_setup(struct device_node *np)
 	osc->hw.init = &init;
 	osc->sckcr = regbase;
 	osc->startup_usec = 1200000;
+	osc->offsets = &at91sama5d4_offsets;
 
 	if (bypass)
-		writel((readl(regbase) | AT91_SCKC_OSC32BYP), regbase);
+		writel((readl(regbase) | AT91_SCKC_OSC32BYP(osc->offsets)),
+		       regbase);
 
 	hw = &osc->hw;
 	ret = clk_hw_register(NULL, &osc->hw);
@@ -509,7 +580,8 @@ static void __init of_sama5d4_sckc_setup(struct device_node *np)
 		return;
 	}
 
-	hw = at91_clk_register_sam9x5_slow(regbase, "slowck", parent_names, 2);
+	hw = at91_clk_register_sam9x5_slow(regbase, "slowck", parent_names, 2,
+					   &at91sama5d4_offsets);
 	if (IS_ERR(hw))
 		return;
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
