Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CECCC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:07:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C67421872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iWzoXq0+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iRYKvDTi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EuQlpGI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C67421872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E68ahEj+ygz1IC8rPz0+yC3+bADUD6odqJmLi5s9sSc=; b=iWzoXq0+tOcFSf
	WPppmT9sOS6fsaRI7jn14MK2eDMw1bxNwXh4Uhige6kQdYBXUilAKjb/wexRX4IPoxEeI+6pONIhy
	SWSSVrfzBZBbHJw68KhBAeC784c4S8aaYJSeLg0Sq6sXfVsHu7Xs+YHZuw0f6wzb/4Z+yhHQL7BN2
	VdIWkfduvqxMAHMiNXFjmfMYhSGzoKn/FqbpdMP2uPOMWuS+7jQaj6d9ymtz4D8x0WX12ib2r9SgM
	LjwH62eOFvUIrTZFZl8eBfGxfoBjL4jj4XVOVIgOBMNw/rXhEQ8dN5WnbudXQwOQISc0Xs+n09/EB
	tIu+hD3ZeCqFK9QvFypQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grgaW-0000SR-Jr; Thu, 07 Feb 2019 10:07:20 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grgaK-0008OX-27
 for linux-arm-kernel@bombadil.infradead.org; Thu, 07 Feb 2019 10:07:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=akL6azETByb8lpJJz81E9Yxs+TgFx/7v00NFRGnk8R0=; b=iRYKvDTiKQhDTy+VsYQperA6RG
 +dEwG+RjTzzKJ8bz4h3b32VKskJT6l2MZ1c2IySWBoQVExWNELpxE3x7fQmCvISo1/X27oqOOgsQn
 3BjjZHzxb/3gZ8/n/CFwRH2gM5SQZVqApZ6LEXAqaP7yT8XKZM9GkT9zmWwg6dbAGOUoZenjzvErK
 U8+ybefNdN1AvUBInmr4N568xiOalIp7olLG82hKTx0PJ2v8xQ2dIcSFEbhFgpKX5ZPpO5fDbCsdR
 b8guf4cxU1WWiXB/P9f3DGgOP0gPR+aT6kH4j8NwLPd5uZGecaH31Vp6JqWGmdpvu+yHG3iZaQzaF
 HNx4lPBg==;
Received: from mail-eopbgr20050.outbound.protection.outlook.com ([40.107.2.50]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grgMn-0007nU-9X
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 09:53:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akL6azETByb8lpJJz81E9Yxs+TgFx/7v00NFRGnk8R0=;
 b=EuQlpGI7xMwqr/uXFXgsHuvnzuxBHH3bRiY5sqW7Z0z4gP04WTQvU1DKl0rzmHqP6ABnaEkev6YeSbbS+RVy/G/0h3VkDFCtybhwZCT330NM6j1qiieJy70+DDuF83EiiA/Y2pMAA9rVTNIP29/erZxBGZJ3CaYTVYC1O8kE3io=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3623.eurprd04.prod.outlook.com (52.133.20.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Thu, 7 Feb 2019 09:53:05 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1%4]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 09:53:05 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
 "edubezval@gmail.com" <edubezval@gmail.com>, "daniel.lezcano@linaro.org"
 <daniel.lezcano@linaro.org>, Aisheng Dong <aisheng.dong@nxp.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Daniel Baluta
 <daniel.baluta@nxp.com>, "horms+renesas@verge.net.au"
 <horms+renesas@verge.net.au>, Andy Gross <andy.gross@linaro.org>,
 "heiko@sntech.de" <heiko@sntech.de>, "arnd@arndb.de" <arnd@arndb.de>,
 "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>, "olof@lixom.net"
 <olof@lixom.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>
Subject: [PATCH V6 4/4] arm64: dts: imx: add i.MX8QXP thermal support
Thread-Topic: [PATCH V6 4/4] arm64: dts: imx: add i.MX8QXP thermal support
Thread-Index: AQHUvsrro3gZQGWeX0+f2u2qQHzVZw==
Date: Thu, 7 Feb 2019 09:53:04 +0000
Message-ID: <1549532838-27025-4-git-send-email-Anson.Huang@nxp.com>
References: <1549532838-27025-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1549532838-27025-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0190.apcprd02.prod.outlook.com
 (2603:1096:201:21::26) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR0402MB3623;
 6:lEaihKE5dmqEN87GsSxlyTNVRTBC3r6OFvEO0yP5AR3jUGghtLQ8StJm9Vtgi4Jej3Phlg8iVmlrwQuUBzHoGnlJvWQ+V81IOHMjjYdYVz6G8SvdZx3fq5MNQ1F82S1e/uavoahifp0EWjJiYLHaXn1nkMIpAv5BnnkCzvVf9mXc08LrjK1qiOA6hDmv3rErvOHaN0i+8Bm7+J2G0KOvxv6K4U5N2rSjvxevx3EgtbGawcXC61418dR06+LJiy2ACyv+v4J3i7wwB25FRW8J8Ty7GuaYV+Ov+6+oCy8uacSOxnpvNL2Gigmz61CAje+FWLDevndUztzwEehs502KCSCFz77YVWuSx/U3CdPgbSQKcxW4ugAEHc4eIJjDFHv2M/+LurToTlP4RLwFk9afWAxmVGLlk2qYnceBNbWrWPYQiixhgwcgy5pbdKVUAVx/luw1KABZHoMZE+oKNeWtJQ==;
 5:57ekaKTfQ7DhtSNx07GtfwWzpdH23ftkXwN3c0L13pnMe8KVzkyy3o8fIf0P6+9pMR3SdMa0oBwpYEa8NmSyInGP2Tc/zeZ9EL0VaqTsAt2c/6/u1KsorYJgFW5+lxaV1DtpZxyYOTv79eBeAwsjBY6IrEIja/OMjRnslE9e6Uku0sJaLdgjshEj0d6DzcpGbjNolCA07KFIE8ENy+F3xw==;
 7:vKDfX/790mKKHRfirimajZUlvAjEhL37UH+bK5cW4fLL9FQgnsiKI9Tfznlyzm95VlYN6iUVTtKtQArqOB69vf3WsQhSxtQnBFKDNfzjmwHUgnSv7YUY7tQm3Lfpsa4Y1hNxagV+t41EWRTqcbEi/g==
x-ms-office365-filtering-correlation-id: d2a3a13f-a2a2-43b3-1b2a-08d68ce20e1a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR0402MB3623; 
x-ms-traffictypediagnostic: AM6PR0402MB3623:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR0402MB362317C7AD621C5B45014672F5680@AM6PR0402MB3623.eurprd04.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(366004)(346002)(39860400002)(136003)(54534003)(199004)(189003)(8676002)(106356001)(50226002)(2906002)(68736007)(7736002)(76176011)(256004)(97736004)(86362001)(36756003)(2616005)(186003)(26005)(110136005)(81166006)(81156014)(476003)(99286004)(486006)(8936002)(11346002)(102836004)(2201001)(71190400001)(52116002)(6506007)(386003)(71200400001)(316002)(6486002)(2501003)(7416002)(6116002)(6436002)(4326008)(66066001)(53936002)(446003)(14454004)(305945005)(6512007)(478600001)(105586002)(3846002)(25786009)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR0402MB3623;
 H:AM6PR0402MB3911.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Iu3uzaHocuv3Y5uK4K3DCIR2vZYaS7w1l6F9fHTUXBCuvYonLszeCxrpQGRWQ3uDeZqJXXLt7a6+g+0ISYuXPlFBTBzsxIuxCfWuRQB5BytBrB95iBwm9vZYeGVFq2PnU4cm9677KMRslS3A7ZcgQnm2o21zRtDfDFMM6JtuiIyu05y6c2jgf13SA6i92bFvEnKIjLNqWJUW5Wd0uSeQ406qrFsyDInF2lj/clES1Ndv6IUwZSuLbQOjUzjK2lG54RzRsBMTflpRsIyqUpDrSInRNiciPoxrF1LM0nSdGZSoAUJJ5OoFmN2QJzjKupghj8j0xfp30GPTaLQvg62GSj4vRTIhvAiyMrJCLk0HSZ0fs1r1Ge8ANhF4buz79gC9Om5BG1h9sPAEqbffCbbyiEUgGuTSRDQOHYRwIgfzMac=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a3a13f-a2a2-43b3-1b2a-08d68ce20e1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 09:52:56.3564 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3623
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_095309_342097_1116CFA1 
X-CRM114-Status: GOOD (  12.61  )
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

Add i.MX8QXP CPU thermal zone support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
ChangeLog since V5:
	- add a property in each thermal zone to pass resource ID for thermal driver.
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 4c3dd95..88eb04b 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/pads-imx8qxp.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -116,6 +117,12 @@
 		rtc: rtc {
 			compatible = "fsl,imx8qxp-sc-rtc";
 		};
+
+		tsens: thermal-sensor {
+			compatible = "fsl,imx8qxp-sc-thermal";
+			tsens-num = <1>;
+			#thermal-sensor-cells = <1>;
+		};
 	};
 
 	timer {
@@ -443,4 +450,25 @@
 			power-domains = <&pd IMX_SC_R_GPIO_7>;
 		};
 	};
+
+	thermal_zones: thermal-zones {
+		cpu-thermal0 {
+			polling-delay-passive = <250>;
+			polling-delay = <2000>;
+			thermal-sensors = <&tsens 0>;
+			imx,sensor-resource-id = <355>;
+			trips {
+				cpu_alert0: trip0 {
+					temperature = <107000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu_crit0: trip1 {
+					temperature = <127000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
 };
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
