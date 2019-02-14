Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB760C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:15:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8848021900
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ek9nnb0C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="3HrhAFuu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8848021900
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dTZsetJr664vYZNdUqgHEZniDhe9feOprYqvA4nVo18=; b=Ek9nnb0C4l8Pib
	m1jWjoJKci5+UrGzx+3FY3JLzYlOwAN03y/vHDgBcjcTe01dg4dDMcerF8fnnVu+cWzmgsZ9S6SRR
	eO7yHrA7a9ZA+Rr7UppI2H37qae29jdJL92WRUGNHssSdlqZFW+a5ARpv+Sn6JmIVm+nUPmvsbFnc
	M2BFsnKqTpDUSrXFPiYjE6qltewB+Y1H8eXOSrh0u6HWfnEzCRBqc7ea72e8IrZ9QASon8ytZUDBt
	sFL3wc9nThfGyjRms4fHh0HN3ARGgLGzYz4Rr3Uj/j6oEPav607x0u2wie2w9kyDp1q8Q7CK7hOHZ
	GV5/6nkV4zw2bJ4ee9qA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guFvE-0002dz-LB; Thu, 14 Feb 2019 12:15:20 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guFuh-0000rB-7E
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 12:14:57 +0000
X-IronPort-AV: E=Sophos;i="5.58,368,1544511600"; d="scan'208";a="26555765"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 14 Feb 2019 05:14:30 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 14 Feb 2019 05:14:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dodt25BBBfLd4ZQZOR8HaYEIztLbD+qOT5lurzPxLMM=;
 b=3HrhAFuu1xRwzgT3UlvQhqqNj3cE/BT6MAMm3A9o8R2RvhAEyXR927RBiHMEDtPLCKYcW2K8rgd6KyNdf2b2SLFcMRoKU6Yku210fJU2TNwEscSNSxkxHVtQalt/OO3R6VxLbKqEN/UsPfKur+/+/r6vzYWRH3in7/ZMfDrZ8Is=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1518.namprd11.prod.outlook.com (10.172.54.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 14 Feb 2019 12:14:28 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 12:14:28 +0000
From: <Claudiu.Beznea@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
 <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
Subject: [PATCH v2 1/3] clk: at91: sckc: add support to specify registers bit
 offsets
Thread-Topic: [PATCH v2 1/3] clk: at91: sckc: add support to specify registers
 bit offsets
Thread-Index: AQHUxF7V9nqwlEcieUmVG7K88z/Dxw==
Date: Thu, 14 Feb 2019 12:14:28 +0000
Message-ID: <1550146447-1441-2-git-send-email-claudiu.beznea@microchip.com>
References: <1550146447-1441-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550146447-1441-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0502CA0024.eurprd05.prod.outlook.com
 (2603:10a6:803:1::37) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [213.233.85.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29cf747f-2013-4cfa-062c-08d69275f75d
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1518; 
x-ms-traffictypediagnostic: MWHPR11MB1518:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; MWHPR11MB1518;
 23:PWfDB9xt2hGoL1O8bVxJ2JLic51vqRF7Lz4t1iJ?=
 =?iso-8859-1?Q?+Ve0vsI05XXdg0mmdkIizyeEAw6p38Gj4SB4KEi9Ss4InghKWGn89hMqEv?=
 =?iso-8859-1?Q?uppYrX9qxF1s94tr1dFt3qOM8EEaOTp1slCSTvoHGMdHC61sRcBl0ObAox?=
 =?iso-8859-1?Q?Pq+z3XZM9xyDUTWp0NMp1XQlcwScoNYOmHAcRzO0dGexHqY33cg2zOzK5X?=
 =?iso-8859-1?Q?kiYWPHroByIjpYfQTbIcjESu9xXUI+dpj9VjSNlfaO9K0reH+2OSpP+NwJ?=
 =?iso-8859-1?Q?Bs5aj9zQwANmu794/sQ9NMv4fxKIe+j6oEuTSpKEQYT3zERGIB6UyLAsQu?=
 =?iso-8859-1?Q?4BXhcaBj4uzh4EeHqWdNyMKCH+QaKB8+JpjiUQDJbV6ZjSyO6CWJknpTI2?=
 =?iso-8859-1?Q?hKIvNNuYHZlDBDkYKqz7BdpMqB3MaHUffm+zoKyamGeUlDlYmG+2NBc2U1?=
 =?iso-8859-1?Q?jo00o8g/RIrPbkuYitZLsnossVZ+1ceMN5Rzf6J3bZI90QqqLd8PNIc5zR?=
 =?iso-8859-1?Q?3rYa3sPeFTZb3SxV1S5FA4Klfz6Grf1KiR87eM9jG2yPpcfrDaIRfccUI/?=
 =?iso-8859-1?Q?vZsUeEnJ58wq7kdQCJck1+B9gK183PI7cidWaMzuEI1Nr4hO+gE1ftcsWP?=
 =?iso-8859-1?Q?TZp1QlnKDWkkdrZ6oeyUAyF7PG2uZszJwN69A5Y6+0YJOQLPVyB/YgA+9o?=
 =?iso-8859-1?Q?q+Tvu+9KVT+Fu/JfMBPrx/x9pcQ8Xtkx1gctqnhC6MQA1nLyCYLfDqN1qK?=
 =?iso-8859-1?Q?FVW+hlVyWL3xt4tP3iyKfquNz/LnkGEK24sW3Bzgikj10f1S05Maxp47NB?=
 =?iso-8859-1?Q?r1PP3xa84dinn7+53Zkn9nrZUbcS6Qx6TKiEBpqTVTr6PaZS+kfULApWin?=
 =?iso-8859-1?Q?/akU9oKvof05wz2T8I978usf41x6MOkpsbAQO/7gXCghbDNMh3j13Z8zmQ?=
 =?iso-8859-1?Q?epJ1SKTkkSflNz3ZMfePE+8bZfr2CMIXn/8NFbGttAItEj6yJ3kKRd7Sn6?=
 =?iso-8859-1?Q?1LVv4UIVFA+tlRwJl3tZQ8Xkgl2MOZSAv9RaSOwgUdreCvBRij+gZJ0jQe?=
 =?iso-8859-1?Q?EmCFILPB6imPCoIByQktMGsF6VVLUKh5jREFJi+DxelB3qV0+4e4uSep4i?=
 =?iso-8859-1?Q?dXqhhEQIY7X4tpAw3WI1Gw8gxgBIY8AZRCvl4THZf27FaFte7vPIKLIxR/?=
 =?iso-8859-1?Q?x0rF062COwrWk/Cf3MEBS7RA2W0B6WV6KNpR5i6Mrk4t1/a+j632YUzo+r?=
 =?iso-8859-1?Q?SsgUMjzY5NPNOHoc1AQevDxnN47nwaWh2ZfEq03ti4qiEAWbxAiMJe+QPh?=
 =?iso-8859-1?Q?K3T+1qT9A0RWQQC1vm5zw7O?=
x-microsoft-antispam-prvs: <MWHPR11MB1518058A2B935857800C83EC87670@MWHPR11MB1518.namprd11.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(136003)(366004)(346002)(376002)(199004)(189003)(72206003)(11346002)(107886003)(476003)(25786009)(4326008)(52116002)(486006)(6512007)(14454004)(6636002)(478600001)(446003)(36756003)(3846002)(2616005)(6116002)(97736004)(8936002)(76176011)(50226002)(54906003)(110136005)(99286004)(7736002)(256004)(186003)(71200400001)(2501003)(316002)(71190400001)(106356001)(68736007)(26005)(81166006)(105586002)(81156014)(2906002)(305945005)(66066001)(6486002)(53936002)(86362001)(6436002)(386003)(102836004)(30864003)(6506007)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1518;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YhK5yjYQ6tBsxAEsMUvvOShwBsKNPsyIQztJ1xcCCgc8+IGYY6Cd4suUzpro/wOZ+sXZOz+Y/Ep/GEcw8eYB2xcBB2E4MtdpSeL5mFIWKhJlQY68n6fZIbYgOLJnoSgdi8VUmCT1paT2LYEtWwkI24ZqgDI+/9Vu/GnEQ8HGCGkZNXWtTx1oUjOtEBCmIKDWCz9+xsLOe+whrXUUf7d5KC4EmR+vQE2ZEAB4rXgj5Fad1QMAjwsx8Bv15MQik7gNIusxChFiOhlURHYr8plE6Mjh0OmttI4YtSTBopGiKLBTHXM/mx8pucndOtclr0l7x661e9VSG8/94mvFbJWde/FnrzwCC5/CwCVwqeB0ywlyiw34tlNsRn/X66MGS4TS4XN1j0/KKgdY5heYmCvos2zsR/eun8aTQe54zZ76Z9U=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 29cf747f-2013-4cfa-062c-08d69275f75d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 12:14:24.3613 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1518
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_041447_912548_18FCBA4E 
X-CRM114-Status: GOOD (  13.86  )
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

Different IPs uses different offsets in registers for the same
functionality, thus adapt the driver to support this.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sckc.c | 112 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 77 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index ab6ecefc49ad..b7163d3a2269 100644
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
 
@@ -421,7 +453,7 @@ static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
 		if (!clk_id)
 			continue;
 		clk_setup = clk_id->data;
-		clk_setup(childnp, regbase);
+		clk_setup(childnp, regbase, &at91sam9x5_offsets);
 	}
 }
 CLK_OF_DECLARE(at91sam9x5_clk_sckc, "atmel,at91sam9x5-sckc",
@@ -438,7 +470,7 @@ static int clk_sama5d4_slow_osc_prepare(struct clk_hw *hw)
 	 * Assume that if it has already been selected (for example by the
 	 * bootloader), enough time has aready passed.
 	 */
-	if ((readl(osc->sckcr) & AT91_SCKC_OSCSEL)) {
+	if ((readl(osc->sckcr) & AT91_SCKC_OSCSEL(osc->offsets))) {
 		osc->prepared = true;
 		return 0;
 	}
@@ -461,6 +493,13 @@ static const struct clk_ops sama5d4_slow_osc_ops = {
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
@@ -498,9 +537,11 @@ static void __init of_sama5d4_sckc_setup(struct device_node *np)
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
@@ -509,7 +550,8 @@ static void __init of_sama5d4_sckc_setup(struct device_node *np)
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
