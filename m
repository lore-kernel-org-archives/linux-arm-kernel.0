Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF04C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:20:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37CF42087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WkSye4WR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qib7UyP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CF42087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7nSxYgQJjk20Yul7/z1Xo1QBAuzH+qDiIwMPMmnRfh4=; b=WkSye4WRNlwa8W
	/53+q2wbqq/mG7VL922AVF8mQGs5mf/LYvENDIvcK9/0ZAcLybGxvKdFCaMtY2nEcuqLxp7LTOw01
	ZkyiY06ECher/mMeEd9nGPiSctvwo5zP8ySr64H3691e8I+lnSQkdtGctW1zusLRiVBKFRZPEiIbU
	pwOnezLVg4vCEGI2e1CqrQhg6+/odybiThEecKtd2dNUzba5bgZk47974I6NdGu/ejZU2IEXXoAiH
	8kzNQtR6leWjBTDcAF5jPYkkqUPCjuEtdmNJeVq79Xs2h9F1+j+bSm/fSLx27IHTL8V0rBZ5EDiPj
	iZX+7Bu4wPcpC/LEfedw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy5sO-0000tU-Fx; Mon, 25 Feb 2019 02:20:16 +0000
Received: from mail-eopbgr00071.outbound.protection.outlook.com ([40.107.0.71]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy5re-0007e0-D5
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 02:19:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeT7FfPJpys5UUZ9rS9lRHaHUYKaBKZ25Cj2r0hGzO0=;
 b=Qib7UyP7wDrrMu+umoJh0/GwuiniPkfURs47+qZ/H+bn6/N/q6/jX/KUpezCydPfMxgNDcCM94HvDqfMY5YU2qnAViOwTyFCzGNjYfqDm+xdSHIDH25Z2UEexrC9oZeENrOuNISHK4XZZGoO2zjTGGD8uINTCFfeCRyDJe4IH5k=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3674.eurprd04.prod.outlook.com (52.134.66.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Mon, 25 Feb 2019 02:19:28 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 02:19:28 +0000
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
 <heiko@sntech.de>, "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net"
 <olof@lixom.net>, "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-watchdog@vger.kernel.org"
 <linux-watchdog@vger.kernel.org>
Subject: [PATCH V3 4/4] arm64: dts: freescale: imx8qxp: add watchdog support
Thread-Topic: [PATCH V3 4/4] arm64: dts: freescale: imx8qxp: add watchdog
 support
Thread-Index: AQHUzLCI6HpdI9ZYI0mFamm1LbwegQ==
Date: Mon, 25 Feb 2019 02:19:28 +0000
Message-ID: <1551060850-22553-5-git-send-email-Anson.Huang@nxp.com>
References: <1551060850-22553-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551060850-22553-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0078.apcprd03.prod.outlook.com
 (2603:1096:203:72::18) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a699b7a0-0f96-42c6-582b-08d69ac7ab14
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3674; 
x-ms-traffictypediagnostic: DB3PR0402MB3674:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; DB3PR0402MB3674;
 23:1vEUUZKXNLmdCufrYSUtjeGkBO+faRao6t/R9?=
 =?iso-8859-1?Q?3iRALnsT3nmoanUNAmXJSl7JGW1b8WbS5cPW9ipLk1yWBxWf6jlf5XOlso?=
 =?iso-8859-1?Q?Ib5HtUZtTA9CbPVlwDS0NnVitCw19uoBhRB4vuXFkQ1jiG8LCo8ah3KKsl?=
 =?iso-8859-1?Q?V7ycXjrfQ04AKQQ0DJYfsdm9jZjHThiAnxOCVw+5F3dUYXS3t8+COlhIAg?=
 =?iso-8859-1?Q?mA8aqY90hXpmgBGEY/kwkM0A7p1t5IZEiz0HleIjbT87gYuDFUdBjC/9KS?=
 =?iso-8859-1?Q?tJI0IGmNwdl6L+M7RAL6t1XPSWOsNytRKNS3GyfcyB4ibpOKgj0NEJ+pQK?=
 =?iso-8859-1?Q?qhISxXf5Gon+x/TzD6M0+DS0ovV4nY04wVd4tvBrBZxW5cHlUgYgMkw/Mr?=
 =?iso-8859-1?Q?Yp8uXbTCcRk0+3HT/0VdhaiM8OE0WsOyU+o/dOrultGjFHohNHUmMm0U4l?=
 =?iso-8859-1?Q?5NYZZgNHr5nFJpvN9hjcZ5ARaESE/N5RGtwD2zp4CGB8RctsvBvCDrfHcy?=
 =?iso-8859-1?Q?8CqImr1cGp1HVTEDVU4GSd/z8WXbzhZ2M8wDsmWhjMMoufY5eRQIQQZZCi?=
 =?iso-8859-1?Q?kSlJOoQ9CCohhYHSKBsSG0pPYXzkoi6dv49ftp/Z8A+qSvz6iQZuxc9tXH?=
 =?iso-8859-1?Q?4WqzmxDnOmyjzQOWEhOnJlRW6mGbdiis6TqQ8aB8wAmdArvknxQmP07wzc?=
 =?iso-8859-1?Q?PhyFqWVrTHMJ5hZmruK7EYSt/hRtrqGgzl/tNV6QEei5ag7APMA8H9Q3mI?=
 =?iso-8859-1?Q?la0dGLqOt4EGIQrW9PeLsvQ1Y4Uf9RNIEuhvBDMB7wm3JzToTgDscK7hTU?=
 =?iso-8859-1?Q?WqV6MyqoRj4W8iqrfXqrkxSYpQJskr4RVs7m5de5CWsw5N9Pn9psMCl8at?=
 =?iso-8859-1?Q?U7bGLuGipPgQpHNOnwX0196e7JZL82YmC2hkbHDpvDUgFosWG3f1bcS9QM?=
 =?iso-8859-1?Q?5dkoX83MWb/f/hBxSh1rfIj4KRTX/LuTn2nnqJPyEJf+V5AkTZ0jTn84ha?=
 =?iso-8859-1?Q?eD/pjKgKkCEreui977EVEw/W4MGoTjC95qgUUh+b2bWsSDil3z54rLpZdn?=
 =?iso-8859-1?Q?sCUVHIg7VjNcL4IocG90LVuniTAaTaCtKsXFBrLnnhcmCmI7tbuWqV43qw?=
 =?iso-8859-1?Q?Bpnhs15Z69ewJ+jdujAR8ybNL5b1IhtW4iPMvEfCwNU2WYybfixkxWCxIP?=
 =?iso-8859-1?Q?9JOwgeECRCPqRT9AQfUikmV0jDBe40bg4twap9WhewPheG3big9Gz8pq/I?=
 =?iso-8859-1?Q?74waU+pBGIwMX6KbvLGEJs/BmMRN0ShIRJJmpBDoRZXflXJGLX7nOLOYI2?=
 =?iso-8859-1?Q?AY1b+svsLJZtVFTw83ix8nXnE5QCT5gjCMJCIsDfUEDGODE0/LK+AHjX4I?=
 =?iso-8859-1?Q?mW940zfIHuEe07ETMLoXCOen0QTPZmC?=
x-microsoft-antispam-prvs: <DB3PR0402MB3674DC6E8300DB145080FDBCF57A0@DB3PR0402MB3674.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(366004)(136003)(346002)(376002)(189003)(199004)(66066001)(305945005)(2201001)(52116002)(486006)(7736002)(316002)(110136005)(256004)(476003)(50226002)(106356001)(2616005)(53936002)(76176011)(446003)(86362001)(105586002)(99286004)(11346002)(97736004)(7416002)(966005)(81156014)(3846002)(6116002)(478600001)(68736007)(6436002)(8936002)(186003)(2906002)(4326008)(25786009)(102836004)(8676002)(4744005)(81166006)(36756003)(71200400001)(71190400001)(26005)(6486002)(5660300002)(6512007)(14454004)(6506007)(6306002)(386003)(2501003)(921003)(32563001)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3674;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: isyV/oLbcq0bCU1ZoVhdWzKa3HSLNp4xgt93AmRhWlLYgjRkTVAw71R6sYOOAFVXgHjYMXfMCFhCGw6VKm4rsqDmdx0J8v7TOvEXbSn7woGSafkCwEsVmjnUI6HZ6SjqJhUDm6SqLwS39uxZYa7sZsxua8mwPLlP3bOWWLyn20h62liYWtNwd43AJa8W2H/ekBsOjlx+3v0mWv6WDDuMed5YYhqIOMKY+UFv39a1gCzmoH9c/x21P3gsRg/jkwNYN+zMQU2QyLWyWpg8y27wDwRaT6ZoxlU3YwFl0KgUY69uGnmlpreBD3WvRjFFTuu14ts8UJ0fTCf5RUL05+sdTVFF6PpK0sH3dRl7DvINfA0IhCDxaHuBRgTooyT/laFhA5u2EKQJGrFHl0kQ3KbFQpZVQCzxx9OXe7vvqeATDRI=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a699b7a0-0f96-42c6-582b-08d69ac7ab14
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 02:19:19.9524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3674
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_181930_541943_A7317CCD 
X-CRM114-Status: UNSURE (   9.92  )
X-CRM114-Notice: Please train this message.
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

Add i.MX8QXP system controller watchdog support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V2:
	- add fallback compatilbe "fsl,imx-sc-wdt" for other i.MX platforms with system
	  controller watchdog available;
	- this patch depends on my thermal patch series: https://patchwork.kernel.org/patch/10827673/
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 85c90e0..514432c7 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -123,6 +123,10 @@
 			#thermal-sensor-cells = <0>;
 			imx,sensor-resource-id = <IMX_SC_R_SYSTEM>;
 		};
+
+		watchdog: watchdog {
+			compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
+		};
 	};
 
 	timer {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
