Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CFCC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:39:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E292820675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uEd1ze/s";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lXy2vKnl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E292820675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=wTidcEIc4aylj1XGHWv93nUwCgKdXZKCNbGPHj+BJEs=; b=uEd1ze/s9kQkML
	FJH8RH81qYTAfuV5b85RULiXxA1VxHwCF4zUCSYhaTvrlGAiW4YYbahm5phfzWF7verHPI+74WOeh
	q0Gwc4peFQf7jsVmpW0fCdYlhoDNMZJPW4XzB9auvm9ECvlAeA8Z0F5tTWdNJcTGsAGsE1M6lpSC4
	K3JGvUtx0jNuafNnni+k02ut7JAtMEs6ve3eCJFj+W0gXSVokn3XAg0Ybn8Rl/SkFOzRRXk39Wwju
	wmZQkvN2Q3dCgFeEp2YYBpY9qEBH0p/adhFAd8unjeVWoAX9dcd7z32/eULsqU4KNI5qmfxoj9bGs
	Vw4zRa8XcTQbvPgSIXew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwi0I-0007s3-Kv; Thu, 21 Feb 2019 06:38:42 +0000
Received: from mail-eopbgr50055.outbound.protection.outlook.com ([40.107.5.55]
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwi0F-0007rZ-8f
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 06:38:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uIf5/BCzdYmNrHTzX4wEXj81QQkIXzS9ewzSz75O6k=;
 b=lXy2vKnl1VdGBgtxULcHtz0XLVv1wCrVgvZCfWBW9OWvocHX5Gr/ofUlBdqTT2J08RNwGmKjyKiw3Pw0pquKHybVbmEl1//tEJpQb0inC6OwnEuzsd7101tXaWfMmIA6DQ1W26fofL0hfEucji8d9gR/cLgC+wIwr5EJgy+xSM0=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3863.eurprd04.prod.outlook.com (52.133.29.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Thu, 21 Feb 2019 06:38:30 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1%4]) with mapi id 15.20.1622.018; Thu, 21 Feb 2019
 06:38:30 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
 "edubezval@gmail.com" <edubezval@gmail.com>, "daniel.lezcano@linaro.org"
 <daniel.lezcano@linaro.org>, Aisheng Dong <aisheng.dong@nxp.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "sboyd@kernel.org"
 <sboyd@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>, Andy Gross
 <andy.gross@linaro.org>, "horms+renesas@verge.net.au"
 <horms+renesas@verge.net.au>, "heiko@sntech.de" <heiko@sntech.de>,
 "arnd@arndb.de" <arnd@arndb.de>, "maxime.ripard@bootlin.com"
 <maxime.ripard@bootlin.com>, "bjorn.andersson@linaro.org"
 <bjorn.andersson@linaro.org>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>, "enric.balletbo@collabora.com"
 <enric.balletbo@collabora.com>, "marc.w.gonzalez@free.fr"
 <marc.w.gonzalez@free.fr>, "olof@lixom.net" <olof@lixom.net>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>
Subject: [PATCH V8 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V8 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHUybAPUmnoI6Ce/UqIMDTlZO/oOg==
Date: Thu, 21 Feb 2019 06:38:30 +0000
Message-ID: <1550730831-14995-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0069.apcprd03.prod.outlook.com
 (2603:1096:203:52::33) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0567e44-a19b-49de-e90d-08d697c73148
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR0402MB3863; 
x-ms-traffictypediagnostic: AM6PR0402MB3863:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; AM6PR0402MB3863;
 23:mMtUhZy1XLYnwGPhlj836SUdvyQtOiiYt3nxC?=
 =?iso-8859-1?Q?ZTvIU9bhg/IT1gLElBEbWbD569LcjkQNrN37rBmq1IZ2AJPRJB1FHje3j1?=
 =?iso-8859-1?Q?w7/qx6tD0g0QlimyUm9NX4MRCP0GqKUUOuxucGtRhS8RnLzCOm/x6fLCAt?=
 =?iso-8859-1?Q?r47NFbCR/tGBAkjnuqqcp6iSvkETzm55gtVfqNBy3riHnnhMu1JEmlZI8s?=
 =?iso-8859-1?Q?yQk3MwSq3xzzJunoXFkEsJp63AOWvOKoyHSk8hiJO2+jruaj4l+AL7x6zD?=
 =?iso-8859-1?Q?bQUo42JsN/Qq1i2QPgOm1ZjCzXdjlEZrhJUfDMlfETJ70eYS/fGvqIc58C?=
 =?iso-8859-1?Q?/scdgi2L9MaiZptqU86ybslnB+KMqIbK8CSIHKDgkPSNKeX/EoUdNmiJhE?=
 =?iso-8859-1?Q?d5v1iQ2QrzsiKAIhW9CY0K3TEpUKbO7Ng9YfvQGLb0vMGZB8XGmgLXBnpn?=
 =?iso-8859-1?Q?1t0SpZ021MAjY+w5//bkEn5+1nxlxnMxAMzRHKkz89ZYPo/ICMO9JgZkdH?=
 =?iso-8859-1?Q?SOGhpjlHeZiYIii4/RAzRCCe7qNQUn7nquiuNT3txzc7PKH7MMSIx+m/hc?=
 =?iso-8859-1?Q?82J2QvjqNdw4zxSW9W///VKar0jQ+TXozL+TA/gkKa8Eg0BhHkf4YB2jKr?=
 =?iso-8859-1?Q?Dgp2Ef4e7+j/Psk6J6y29tU5wJ/UBoooOy4CmdMKcLnst3dIUe0itoHq0L?=
 =?iso-8859-1?Q?BK19EbxfFSD2NPniVrBV+/xhhs7RX1cioPsWE6liLAjHAZ1Q7GmoMNSPPC?=
 =?iso-8859-1?Q?5Dm8QSj9apoQeHKizOsm12dk0iwk/yQeW0clHChcExz+d2+aOKcdM6lNaR?=
 =?iso-8859-1?Q?iVBCYS8PpEgjDRbZaQ8fGiOwDV5ld/UZk8Ffx7zlv10OryGlHJe8VO5+3F?=
 =?iso-8859-1?Q?6LaQcOqTZDRxceD+ZABN1sdhcqrFe3hmNZBLR6wHOrUlvXMwfw7pdhsBVi?=
 =?iso-8859-1?Q?hBRB9VQBVF8FhjfX5mNNuw5knU0Io+jv5OcLuvdiDnRy5tzAcnKa4OtKRL?=
 =?iso-8859-1?Q?fnfvHgRPI/hhVtDkypeUKrGid4hCCj/s/mqyFwGRMxKIyeVEBsAZUkluQM?=
 =?iso-8859-1?Q?5LX0JJxUIyMgI/Y5YMxMIo0tZHs3pg87CZRVPrmDpuoe53cLqTd1FNVRIj?=
 =?iso-8859-1?Q?7MJabccGSaaSCSxy0UL8TTY4JTP/iu5MWPDkbsKjqrtMZcR1ynGKVfDEjF?=
 =?iso-8859-1?Q?ZkiUYmKqYSDBnQzPvsrBlBjib7RWmSup3aKVxc6munRaO52BaKYx6XZueW?=
 =?iso-8859-1?Q?sskc4VYqMzytF8AGUV9eDS4d2csPdpezfCJXigh2w=3D=3D?=
x-microsoft-antispam-prvs: <AM6PR0402MB3863ABD56A061F954F6CDD16F57E0@AM6PR0402MB3863.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(366004)(136003)(376002)(346002)(396003)(199004)(189003)(478600001)(71200400001)(5660300002)(6486002)(97736004)(6512007)(2906002)(86362001)(36756003)(66066001)(2201001)(71190400001)(53936002)(4326008)(486006)(25786009)(68736007)(305945005)(14454004)(6436002)(316002)(386003)(8676002)(6116002)(3846002)(110136005)(186003)(7736002)(2616005)(26005)(256004)(81166006)(102836004)(50226002)(7416002)(14444005)(476003)(2501003)(81156014)(8936002)(6506007)(52116002)(106356001)(99286004)(105586002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR0402MB3863;
 H:AM6PR0402MB3911.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wEEgAq0a6i5lalWkd4zfvsrl0Nvjkan9wEsBkxI7YFJHqOzRB1BKDXoE/NmvQptva6mzFcvey+OsPMV3HWFzZmtiTgDn0nFnrtfWPYWaIxS96Zu6HlFPANStojCC9HrS1u+GLI7jq2O2Iu6sNuD88QaWrUv1wz7S+dYksII5DtUfbtYyy7d4EZYbFpL84G53zb8LwDxafd8jxokpweKQme41jMxjYk6ABD5FJ39tTfPPrSTQi+Tj03HdqY6c9oY2i2dt68QamQKWZXuB2l12l1f5Qic5q6xEiYvJ7dVBDWUxUE1x9La5AuQJmjz9c7Vd/BMSNjubjqo8zIlV6u9oKVsASO872msEZ0VwnCYvwNtY7GcmI1AR7iqKiT/t/KfUIl2BSzxeEeEGGbBXR3hcGLfUedzOA0MFNdeWZB/VJgw=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0567e44-a19b-49de-e90d-08d697c73148
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 06:38:21.8202 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3863
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_223839_380529_1BDDF6D9 
X-CRM114-Status: GOOD (  10.64  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
system controller, the system controller is in charge of system
power, clock and thermal sensors etc. management, Linux kernel
has to communicate with system controller via MU (message unit)
IPC to get temperature from thermal sensors, this patch adds
binding doc for i.MX system controller thermal driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes since V7:
        - remove unused property "tsens-num";
        - improve the compatible description;
        - update examples according to latest dts file.
---
 .../devicetree/bindings/arm/freescale/fsl,scu.txt     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 72d481c..d89147e 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -122,6 +122,19 @@ RTC bindings based on SCU Message Protocol
 Required properties:
 - compatible: should be "fsl,imx8qxp-sc-rtc";
 
+Thermal bindings based on SCU Message Protocol
+------------------------------------------------------------
+
+Required properties:
+- compatible:			Should be :
+				  "fsl,imx8qxp-sc-thermal"
+				followed by "fsl,imx-sc-thermal";
+
+- #thermal-sensor-cells:	See Documentation/devicetree/bindings/thermal/thermal.txt
+				for a description.
+
+- imx,sensor-resource-id: 	Property array to specify each thermal zone's sensor resource ID.
+
 Example (imx8qxp):
 -------------
 lsio_mu1: mailbox@5d1c0000 {
@@ -168,6 +181,12 @@ firmware {
 		rtc: rtc {
 			compatible = "fsl,imx8qxp-sc-rtc";
 		};
+
+		tsens: thermal-sensor {
+			compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
+			#thermal-sensor-cells = <0>;
+			imx,sensor-resource-id = <IMX_SC_R_SYSTEM>;
+		};
 	};
 };
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
