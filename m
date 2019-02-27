Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50246C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:46:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CD2E218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XzgnCnN/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AO6/+3ld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD2E218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fDNKZ6EXAJ6YTNLihoZUDNDOzk/SkxMqkL2LVY+mr7A=; b=XzgnCnN/AL7cod
	62ul1X88do74mOq+pOGxZSq3R3VHqgST/URqMU+wZR27wQXYZXSr7IQhXVf2dGS8beqMl+Co+jEMJ
	sktVvdLrMT5S8DHjhPj1jq8MG2KzsRrf/pPJ9c4exr8Lzr5oPgnPXwgIb+YRM0Jt9Hx+gfSgZaYFu
	rXtQHPvZb6RVqWfbLFDe0JzcJiWYoBMuxTVQhoZhAEVo35J0oKd5BPR8cwFVCPD9ImJ/cGGcAfFGC
	qbxR2Nxfuzufdls4G/DXzTTq7MjbQJLrNrPaLtFrRkxJF4kQZRuSbrWf2aU0KhUauFhblZ+PCWDqs
	J50R4qMy3UmTFPWdE//Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyurW-0000uR-T8; Wed, 27 Feb 2019 08:46:46 +0000
Received: from mail-vi1eur04on060e.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::60e]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyurT-0000rE-Ek
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 08:46:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yy567eFidfxDK70YtUI0fD4kJQmgUXNVSv8cHNKZYL4=;
 b=AO6/+3ldjoUKZVu68lytL4tjpBDxWxbaI/HmAn3bPojUKZy5xIC/l2HqbXLQ1Ij30Dts3fCr01pjQlfofSW40oMdhL1Cxug3ir/HY8dqjaZRi6IZbTdndZCpJ2l5qj+6o2SxAJ5eu6pLEyyXanC/HFeVOWSn4iRk3o2exNs9S8o=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3643.eurprd04.prod.outlook.com (52.134.66.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Wed, 27 Feb 2019 08:46:22 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 08:46:22 +0000
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
Subject: [PATCH V10 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V10 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHUznjp1VM2Vv0vQ0qLNAgNlgUeAQ==
Date: Wed, 27 Feb 2019 08:46:21 +0000
Message-ID: <1551256894-21954-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0021.apcprd04.prod.outlook.com
 (2603:1096:202:2::31) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70a8abcb-8cca-4858-8ca7-08d69c900c52
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3643; 
x-ms-traffictypediagnostic: DB3PR0402MB3643:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; DB3PR0402MB3643;
 23:3a/Hb9yruw/eb7SI6hp1NdjqAaFO3k8IiG3/z?=
 =?iso-8859-1?Q?55mJYkApoDLizZaaK8fEQei3FbD9ujMS7bVPG0SzwgXcYwWzLCWhHlkCQT?=
 =?iso-8859-1?Q?X7+5hzfr3O5m+gsZKTT9UW3xjd7qAbzF9WNV/F1mbY7i2t+T2dt9pI++ij?=
 =?iso-8859-1?Q?rJ0GJ8hjUL7dReOFEi+7n6fIFYBCgfnyP8e+ncvxPOQtBJapG27ejEDgUB?=
 =?iso-8859-1?Q?MLK3i7RJAA2TUBn2CNBKjAYrdM2IQqQE8y+sq7TTi9gpFN3VuMEAenceQh?=
 =?iso-8859-1?Q?kjAmKnod1k5Bb+6Tw/C/On1knWllIrmHUEcEP+lDBJ1TfecHPMd853Aae5?=
 =?iso-8859-1?Q?bNPc0e34WSH/OO43fSN0791Tz9T5Vtm2orUNPfTeDuqDs2tVnXdWgEXTlC?=
 =?iso-8859-1?Q?RAjhsrgBjfsFM+OGS72E5XQmT8JyfgflLTpogizNtZ4eVtwrnoKZxiGVBp?=
 =?iso-8859-1?Q?SPOeX2rw6o/Mhm9QMwpU80ZslFdlHcH2FEwSE51utwh95AtrVfiRARTqrZ?=
 =?iso-8859-1?Q?h11Gq5hd8oICGsK7r5m18vo8iN1juNPAdXJU4z7lJFemKvIDXRb7rFtFiL?=
 =?iso-8859-1?Q?GSYlUAKzQWvQR5hQGTDls1MOGx7XZZCH6nkD3PPf5bgq1TXQi9N63ehZNy?=
 =?iso-8859-1?Q?u+iNM5sV8xAiGQPJ1BK2u9QpPEZWdc1sYV5YbjO1gX8/lhrx+edUiybcHS?=
 =?iso-8859-1?Q?AAkuj6dDd7I3qdEoMy7sUD0Ngdg3TbZsu7tmpNPhcpHptbB72Ud3bCcP/Q?=
 =?iso-8859-1?Q?cWUhzTe36u+cKRDczCPGN3qEXyOvgLdPOFbURlA17DN+LwFbZAqzDPyOSC?=
 =?iso-8859-1?Q?qvcAromezAjaRHnucqHcpeFrmLJfRa0ghoMiV6RMwKOhoGQZOyMjnhZeKd?=
 =?iso-8859-1?Q?+vm9o7W9ySSkhQDLxTq+n6/wG48TVG4RliCNcel7XRs5smtgI/YgNRvWU3?=
 =?iso-8859-1?Q?2Bx2Dx1j8+lqo8dPaZF9ogPilN6Gzor5SvJmqFZQ+l87pRp65Vn9A/eIzP?=
 =?iso-8859-1?Q?yaZ3TjOS/4zq8FR8HdbkWTqi/FrMDU6dydJsd4zOe8U5N7yAci3gd7YNcx?=
 =?iso-8859-1?Q?2nPyL3TWlDiHGCoikPB6/7oAEo8VkcDUAd8ncykyvpYwqGcaU3ChrucVll?=
 =?iso-8859-1?Q?LHeXaQKLiSkqrYYMjrNRu3zweNsk6vrCj/MuEgPFj8+oI3fPX1DZxEp9Sm?=
 =?iso-8859-1?Q?M0U7aQhTPLYtrW1HsF6O6mDanhLrINA3vaObRuLeml0rhe0dKScJy+FxD/?=
 =?iso-8859-1?Q?J4czYJqbUhDoRZjtgaq?=
x-microsoft-antispam-prvs: <DB3PR0402MB3643C6CBC6D09C1974D4FAABF5740@DB3PR0402MB3643.eurprd04.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(136003)(396003)(39860400002)(346002)(376002)(189003)(199004)(6512007)(99286004)(71200400001)(36756003)(71190400001)(305945005)(7736002)(6116002)(3846002)(105586002)(6486002)(50226002)(106356001)(53936002)(97736004)(68736007)(2201001)(86362001)(14454004)(81156014)(8676002)(5660300002)(25786009)(81166006)(8936002)(4326008)(52116002)(2501003)(478600001)(2906002)(26005)(186003)(102836004)(486006)(7416002)(476003)(66066001)(6436002)(386003)(6506007)(316002)(256004)(2616005)(110136005)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3643;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uY3AaHOC4d7Qt7W8lLtGAXFrKAM2LTaRw3wtTUysAq0sEEldOs0YFoYKoQAT/XNMaRqRZhfcp5Y6Uh++eSyn5+rpTFu/Ld7aH47yA4hOdqJLKyCF78ksp3b0fKaHw4FMYbKUGiJNVfYiO8xG6GWRTUdgO3j8wrc/WGJW12x8qgWn/toRSNyVND6yViipWeZA3URl5DD6CO8a+FwZbfQJH2GUnWhGncYwxtB6LZXFfAEfY0wWBfOEXwLFOB2wv75n+kyWGanGhTg6WcejjqlH+BntA6+7hjt2aLch0Ymy+ZS8bntKaYgKTC36b+yD4MYniWUFf8D1jQ4yiuodGtQfTXtpjxBU+ZTA7cSlunvPy+Xv8agM8g92oi+QLzHzmCDBDgSax3S7rtjEdCoChgR4mTnKmavr4kjD6Aq+emC+dOU=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a8abcb-8cca-4858-8ca7-08d69c900c52
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 08:46:12.7871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3643
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_004643_494260_5DD165B6 
X-CRM114-Status: GOOD (  11.26  )
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
---
Changes since V9:
	- change #thermal-sensor-cells value in example to 1, since there are other
	  thermal sensors inside system controller, it is just because there are still
	  some issue, so system controller does NOT expose them for now, they could
	  be exposed later, so it should be 1 from HW perspective.
---
 .../devicetree/bindings/arm/freescale/fsl,scu.txt   | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 72d481c..855270b 100644
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
+			#thermal-sensor-cells = <1>;
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
