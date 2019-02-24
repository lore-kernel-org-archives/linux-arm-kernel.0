Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D694C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 02:50:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB231206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 02:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kHjmuJjf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dbWTEkmT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB231206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=J3uFz67gmc7g15xZ87TbneNBO+tvArvTnfHGeWy53vI=; b=kHjmuJjff7ZT4E
	uqnZaWwn6H/+DwsPblIuIdjOtVEdCMWkodYIa/GF037GmGdNcu+Ts4JnZ9Ysk15jIwNwG5a75cRYm
	rArzuX0sOIoXG14rD+c8qSYjCaM0SC0UjUEjaENy97dNSYQk5cX3I9ZPmAGJLRrd9dFWro0+XxAUK
	3XcpRuYKgZjC9bh7yQX0IIyD4nSQpeGxoLGIt0GImcnawo12pa9fMrOqlafBb5KvnIH8omYFONjS4
	F10yLgilRI+fCHjRa3DoVr9Spn+ao1YlZ3GraZi7BUnaAKwPMqwCrggqXIamPxWucv1fSfxp2+A/n
	0zC1zxx0HX7zk1J1Zi6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxjrt-00028U-J2; Sun, 24 Feb 2019 02:50:17 +0000
Received: from mail-eopbgr130054.outbound.protection.outlook.com
 ([40.107.13.54] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxjrp-000228-JO
 for linux-arm-kernel@lists.infradead.org; Sun, 24 Feb 2019 02:50:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHxbR+mGL8fczXmbRc4w/D8IqC0OPND8gOUarj9FHws=;
 b=dbWTEkmTVLmxbXCuXImbKqrkBRZwMWE3vaSVHhAbM83R/EulYHd6idm0w37Baorjq9Aq58nfFULItHXWgMs4+nmoEtYYxCA2VSvNfAVR03pibXgEe9dPVM3QBc4+58u0Z4TxDVG7qKdJqg4MkoMcH/f7wSe077DJ21I/WFDnAsU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3865.eurprd04.prod.outlook.com (52.134.73.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Sun, 24 Feb 2019 02:50:04 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Sun, 24 Feb 2019
 02:50:03 +0000
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
Subject: [PATCH V9 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V9 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHUy+ukMWDajCXXzkGf+b3wfa1YNQ==
Date: Sun, 24 Feb 2019 02:50:03 +0000
Message-ID: <1550976319-20216-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0145.apcprd02.prod.outlook.com
 (2603:1096:202:16::29) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 297df944-045d-4a88-8a1c-08d69a02c6b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3865; 
x-ms-traffictypediagnostic: DB3PR0402MB3865:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; DB3PR0402MB3865;
 23:jy8HJ5t1xdLfRMAKOZUN9wf2lKaEMzipItprw?=
 =?iso-8859-1?Q?zyqtIRc+jWar7wXQvajeB89DNOh3xgz0on28xTE44kGDFlBY9MwcVMvNTu?=
 =?iso-8859-1?Q?U0FeEwwcfSj+sV3IWQLs1R3c4bXAy+LIvkqI1AgNjCJb0tR4tQXMSsdW7o?=
 =?iso-8859-1?Q?In2acKywESlLs0f5QSg93CJxpeDpjYV1yYCH6fi2yAOHT6Hre9MSmrsSGo?=
 =?iso-8859-1?Q?RKzTfP4MwbbqPnqH7IGuLsUJQ31Ia3pE5YAOBg9FuVnw4StQ+QIkfTambR?=
 =?iso-8859-1?Q?2GuT6X5xC+qD76HzSIitLrgSQAo7NSsMXyQvonG8GKAhtZ67QEcZagexYs?=
 =?iso-8859-1?Q?/Z3+y/1EJ+ggKYWl0HZQW4sRDhLavc3bQwZKQKcQjtrIcsk66CmCoTIPS7?=
 =?iso-8859-1?Q?cgsCkCisN0y7QQWA4NyxdRgiLU2R1MvahBwBOI071/prx7EJpta07P+A4w?=
 =?iso-8859-1?Q?M0j17iQY29QRmuhe/eVe36m3UUhSTzrZ9oPsVyaQHWtatFztgkjLL4/mBt?=
 =?iso-8859-1?Q?5eOZlUW8/7iyJSJSpMwDJNj0TOmkZTUPAVD9PECBFi08VY5twhRS0MOQDr?=
 =?iso-8859-1?Q?rA226pEApUBY/trapIoVfihO05bIz5RzFgKgB8HkfZ5ZetWhffXW4cb0Zz?=
 =?iso-8859-1?Q?l8BtGy9AyHvO+sRhO6eqLFfqOuUEHmxQ2UOd+tRqWsaSdqu1CAglAnA6m2?=
 =?iso-8859-1?Q?r4RYzligtdf6AV0YxECuqIeVQiCFyErXyJqtIuLo++Jo0bTHbwDF0Jlfpp?=
 =?iso-8859-1?Q?IR6xWv/4TffNYvHH1kxPwKjbAJr87neuqZL9gaacc3yYhrxRIfmJ9wztho?=
 =?iso-8859-1?Q?y+M272LZHgC1S9GHn1VLx3ht1jCEiONZ84Qli+WN+fO0OeLRHRJR+3aYLC?=
 =?iso-8859-1?Q?rB9Tp8Rwf5IIiV/SVhgpnU6u2aCO/b0QObmpVemQ68WD6KfY3wx7woPz9D?=
 =?iso-8859-1?Q?D5UxXjRy1u4kIvv21uEUnsGon19dK9/P2weZKy4YNdyD/dcj9E+ZyDVS/z?=
 =?iso-8859-1?Q?rjveuPBkCT6eMX+1cZYPTTrErbRxttYSYTlRs4rSsBooUJh0Jv2IONQ6zL?=
 =?iso-8859-1?Q?WTcvOR6rW+YQBDwiD2v1TUn90XFvvLFe3qf1WonPmDzjQUOL+TeyRmAgFJ?=
 =?iso-8859-1?Q?/q3GEOD2TknDG6jvL/sN/vt/QcZZ4maBDHzUQP9+K3HpvrmYNFioubwyG6?=
 =?iso-8859-1?Q?E5PGZsZqAl1ynNmgW/9o10yJJ9fmjbW4h2b6JMBSbYOaJAi6u61fEKS78D?=
 =?iso-8859-1?Q?TKuO5ajrpFwdEwSPECG?=
x-microsoft-antispam-prvs: <DB3PR0402MB3865141F0BA2777B37268A1AF5790@DB3PR0402MB3865.eurprd04.prod.outlook.com>
x-forefront-prvs: 09583628E0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(39850400004)(396003)(136003)(346002)(376002)(189003)(199004)(110136005)(478600001)(4326008)(316002)(66066001)(256004)(3846002)(6116002)(36756003)(2501003)(52116002)(7416002)(99286004)(14454004)(6486002)(71200400001)(71190400001)(8676002)(6436002)(53936002)(106356001)(2201001)(6506007)(386003)(86362001)(6512007)(7736002)(305945005)(68736007)(50226002)(97736004)(8936002)(486006)(26005)(81166006)(2906002)(186003)(2616005)(5660300002)(476003)(81156014)(25786009)(102836004)(105586002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3865;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: arisezFOBvbPG9w3E41PRx6cHmq+tJCbxGQ/2PLZ+XLigx9o603aZc/oGmYDg+Cwtt5oNJeb8dj7i8/2xn+N/6sP0+wiPtqBernwDfm5WTTvMH4VbHZLaeNuBwrJS3fd+UnO94dwYmwMh4Lr2sKUjczga/Q2YBTna3Nncvh5UPM7gzLXPPRcLJbMAUg2yjakDvE1wWPoySVm2mwxZCi0s6/z21L6e6IkfDd2+WDY4+OrMsXip1ZRU1L+wmpSXDzq+Y5IBo4qAjwyV+MYWFVVRmVe8pkn3dbFlJ3BM0rFeogu+z29GbHSyjbXdi6dTo99FaM3Fsmz+EXTwgSOw7KEAlgb9TQt2v6cto66xXnIOmSef7aMJWoajIQYnKMpHLKktW9g2C2XyLSQqMKk/zEFixqKQUF1bASUBzDLj2jbxkU=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297df944-045d-4a88-8a1c-08d69a02c6b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2019 02:49:54.8095 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3865
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_185013_637463_A716CEB7 
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
Changes since V8:
	- improve "imx,sensor-resource-id" description to cover single and multiple thermal zones.
---
 .../devicetree/bindings/arm/freescale/fsl,scu.txt   | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 72d481c..2e310ac 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -122,6 +122,21 @@ RTC bindings based on SCU Message Protocol
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
+- imx,sensor-resource-id: 	A single integer for single thermal zone's resource ID or
+				an array of integers to specify each thermal zone's sensor
+				resource ID.
+
 Example (imx8qxp):
 -------------
 lsio_mu1: mailbox@5d1c0000 {
@@ -168,6 +183,12 @@ firmware {
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
