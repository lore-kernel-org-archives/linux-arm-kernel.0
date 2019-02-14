Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED5DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:45:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA092177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="edgtS7ks";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FA9hGyVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA092177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QUI1qGw6gdddtGOHD/6CtHlDearO52mD6brUf3qwSuA=; b=edgtS7ksDwqptv
	CQogFM4GtxNlUGIYKgfH7+dLEZ488uGyoMStDL4L6YJqvJackQ/zmWFpLl1tNYs5HLOxqC1JzabS1
	bUeZqQ750CjkAKKPvxUGvZe2qf8x4hc7rsJK1/j3xZItYcI/wBYfOwdGhhGbViH7lGHKkxj48QjGv
	b7gDd2GI4dJjGiqFD0sdi7lA6XcfkcuXQyhkgp9ppL42jqRhMFnJ+xMwI8ljeIDaaG3x1KuvXZByt
	fcGb0zbPd1Yb75qtZtcneDK/L/mf9fYkQ/sFXKcPaeEUfwogC+RVPOA2ptmyHc3qBhbpXES1MEbKe
	7HTKyZNl3+B6m8vWiwXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guFS5-00070x-RL; Thu, 14 Feb 2019 11:45:13 +0000
Received: from mail-eopbgr150042.outbound.protection.outlook.com
 ([40.107.15.42] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guFS2-0006gK-J9
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 11:45:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ignhn7VL1eC+LLYw7HH6VnLKN3wKr5SIbeB3+0YGmhc=;
 b=FA9hGyVFiTrVQ+o60utLyERiq1jqATND2G95HAoj8AQYeNldXMJvfqjMewzvots814ui6pbwmf+wuk+Xv+1FgZql6VozX8azcaxhrrVIkVIx1/scckqJRPdR/8y0aoEdtfferR3kAGR9HE1QZAeydKlu2T0/umZHrORFLNqYUtA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3676.eurprd04.prod.outlook.com (52.134.70.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Thu, 14 Feb 2019 11:44:47 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 11:44:47 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
 "linux@roeck-us.net" <linux@roeck-us.net>, Aisheng Dong
 <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 Daniel Baluta <daniel.baluta@nxp.com>, Andy Gross <andy.gross@linaro.org>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>, "heiko@sntech.de"
 <heiko@sntech.de>, "arnd@arndb.de" <arnd@arndb.de>,
 "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>, "olof@lixom.net"
 <olof@lixom.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-watchdog@vger.kernel.org"
 <linux-watchdog@vger.kernel.org>
Subject: [PATCH 1/4] dt-bindings: fsl: scu: add watchdog binding
Thread-Topic: [PATCH 1/4] dt-bindings: fsl: scu: add watchdog binding
Thread-Index: AQHUxFqvIZFjEeN+z06PgHmIEdysGQ==
Date: Thu, 14 Feb 2019 11:44:47 +0000
Message-ID: <1550144346-1187-2-git-send-email-Anson.Huang@nxp.com>
References: <1550144346-1187-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550144346-1187-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0087.apcprd04.prod.outlook.com
 (2603:1096:202:15::31) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65070722-5f5a-41ba-2f93-08d69271d1ef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3676; 
x-ms-traffictypediagnostic: DB3PR0402MB3676:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; DB3PR0402MB3676;
 23:wfdeeTbBs+b2T/TRtMj1RqjCVkKQqPBfTyUl5?=
 =?iso-8859-1?Q?D8/+kYjLWH4FDA/yAE8dUG+SsG281W3ltfEd6nI6X6ZWgE8uF8qeWKFxAe?=
 =?iso-8859-1?Q?QviOJlBC42O4n7s8gGqQHuChZsUjuCu1YrQ40j2+Kwqyc2PG00tD30N3PZ?=
 =?iso-8859-1?Q?g7WM5NZvGqyZJsym1xKBEQ/sLOW/O20LDoAKOJwsXv0EtocUipu7dr3cWf?=
 =?iso-8859-1?Q?4qtP6beSTJSGAi9AFt7N3yvbD6FkIjJLC1YNtoH0rbd6AM1sEuE5aK/qsg?=
 =?iso-8859-1?Q?03iyPL0sCSnNLcP/88tMKFRB2/YNMmcHENj+cgsyjPyPAtqs3xbaGV/M10?=
 =?iso-8859-1?Q?nXA2411xPiCFgTsHYzfQOCMhQcM891htDo8bhUTI0yvvC4NIOt5JFsjZCG?=
 =?iso-8859-1?Q?xBn4VCeYBlbpCeYGQf5XSR9i2bcYEOwQKBU9OOINDK66AHBO/IcUcyppqD?=
 =?iso-8859-1?Q?nyDzP/kDIIrU26UP866/Nl1pKDRQuR4dJvqxVCjLnfj1+LIrYUHHAWrouv?=
 =?iso-8859-1?Q?m14yzT+aCegakUyedWS0jP/6DkoMw56rPBRrvvsxOCQdmA4Dsh/FHQTIIU?=
 =?iso-8859-1?Q?xAt+QBCqD/RqkzvLOCmzFUNxea38tFzs+jvCSGjnt4TcoXhS/xJJJAljW3?=
 =?iso-8859-1?Q?7rjMw2mIP2mbNkHWwSMT2xNwoY0oP5UwXqQIptMqjb2PDYUtzeNdINVD0q?=
 =?iso-8859-1?Q?8ZVirkBI2/3TKqNC1mFsBKZ6qIKlqzRHeTwzUYgexUyRZqLVLkpSx+o6wF?=
 =?iso-8859-1?Q?5hGoluMNhMcBKA6f1sRNQvTy0f7gMR0Ii52y+wj6PIf3exNygzqAA5ynYK?=
 =?iso-8859-1?Q?gtN9XO7A79U6TL6zQoiar1T4OIl6exC/UCx4DR6ONGz+YOPocmq1drhOYp?=
 =?iso-8859-1?Q?OoQG3JM/gzaoopBFmEW5U0oEnGBSqxbBolalCvG8ET8MjKN+pCeo44a9/b?=
 =?iso-8859-1?Q?4NdpFYVOryJmjsIuRriZqJzI0IPiUizhllyk7Jd02ySbAZYn+9X7nDaAp1?=
 =?iso-8859-1?Q?9DbDU40ZcBFFBqMIpaVtUSLwqUjKdc0IXt3OwE+AC8nxaYIGTJG/y08M7Y?=
 =?iso-8859-1?Q?JvkiPZHILIhHmQia5seeyAmh7hwDrM8gORqAP+L/wE/A7WMP5jTY7i0kFo?=
 =?iso-8859-1?Q?4Gdq1sHgiQRwRlIcJ3aFP7DUucsEGW24tr/TZ0hCRRMi28n6pDaMGvAFRO?=
 =?iso-8859-1?Q?X7EfzIxluwY+e0b51Zg2g0FOPyms2hjJOEaAfS9tCjqHw10tck8jjtf6oC?=
 =?iso-8859-1?Q?z9SbCGLPqj6vW34dKVkUf5hjoLXYLlEq4NuopR2DdD5H3a/5ZLm0RZ5wiH?=
 =?iso-8859-1?Q?R8y8GwYU7Vp5RCgU6UIfH2tYq?=
x-microsoft-antispam-prvs: <DB3PR0402MB3676A7C55C2296CDF32EEBE9F5670@DB3PR0402MB3676.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(136003)(396003)(366004)(39860400002)(376002)(189003)(199004)(476003)(2616005)(486006)(2201001)(6436002)(36756003)(66066001)(106356001)(7416002)(446003)(25786009)(105586002)(186003)(6506007)(386003)(11346002)(26005)(3846002)(6116002)(4326008)(102836004)(99286004)(256004)(8936002)(81166006)(81156014)(8676002)(2906002)(14454004)(7736002)(97736004)(966005)(305945005)(71200400001)(2501003)(86362001)(316002)(50226002)(68736007)(6512007)(6306002)(478600001)(6486002)(52116002)(76176011)(53936002)(110136005)(71190400001)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3676;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p9aAMeEz3dplEpocf7v2nPNvYCVA4PiwccXV2FocvUhVqZhphHUF85oJYLMiNk+5Lg7jTTzDx+NWnkaPfyLGPYFq96+zbuT+l24clDnixEzW0vnlQcD5H4UvzeCFeJ+icAue27Z/iRKHOHym0OOi/fNQURe3QHkp15FCI3CSbb+juESOHrMIlZzDQ4QHiRfTcJMzeS5gQ+rlaHu1x0O22i1LHAWqN1y/S5lPCUx/8PTLlD4EwJbyKTppyup7r4AutZPats7P7DkEUsrsJXtkt63acp1p/wAezAzbc4HvdjDd+0BWLvivF8DtGSjInP2oWRkNci/DL4imrTQR8uVPHBGR+U4+zz05083AIfTygJoL1hnX5o6N0TGJn73eCjRknkEKL7RIVbzgL6Byg6POr4NYrrdFKG1RmNL8Goctgr0=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65070722-5f5a-41ba-2f93-08d69271d1ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 11:44:38.9579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3676
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_034510_636653_419F5EE7 
X-CRM114-Status: GOOD (  10.73  )
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

Add i.MX8QXP system controller watchdog binding.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Note: this patch is based on my thermal patch series: https://patchwork.kernel.org/patch/10800699/
---
 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 42120cb..a3ef861 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -140,6 +140,12 @@ Required properties:
 			   resource id for thermal driver to get temperature via
 			   SCU IPC.
 
+WatchDog bindings based on SCU Message Protocol
+------------------------------------------------------------
+
+Required properties:
+- compatible: should be "fsl,imx8qxp-sc-wdt";
+
 Example (imx8qxp):
 -------------
 lsio_mu1: mailbox@5d1c0000 {
@@ -194,6 +200,10 @@ firmware {
 			tsens-num = <1>;
 			#thermal-sensor-cells = <1>;
 		};
+
+		wdog: wdog {
+			compatible = "fsl,imx8qxp-sc-wdt";
+		};
 	};
 };
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
