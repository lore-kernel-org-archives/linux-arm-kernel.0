Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BE2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:09:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B671F2176F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u67X+2fa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZydM2PQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B671F2176F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NFrmwELcXuGU7m/0dvJ27qAy+Mp5Huxa3iVPSBYy1r4=; b=u67X+2fanxmrHR
	PsVxohhXQ83IVV8uYBOkNCmG4I6G8SwaZeND9LWu88HyXvyif8ffx70QfVLywXKe9hKrWnyNx4KFf
	OW9FimtmTedIgTQrYGzHYGa+GI4nk3QCObxqCMh5Mbgv8J8/YxNVK0/TSJu0ah0sGLQjrQRFSJItx
	YoDQCvKWShT2ARQpUFxQIK9XHuE/imLsaFsizJRDn7b/AvHgBYvfZiwzNRKwsFJeG+oIE0BecSShl
	R1CojFU9VrL5fl/uGwWGe70WhahR7aSidaYHFu3Lhcf0o1EK2KG1mMdFzvBVTxotBRML36qxVTXuG
	Xbx2Ixb52ObA+gbgyvzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZuKu-0001jq-1y; Thu, 20 Dec 2018 09:09:44 +0000
Received: from mail-eopbgr00043.outbound.protection.outlook.com ([40.107.0.43]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZuKN-0000tq-Gc
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 09:09:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1rSEyn6q7CwN3d37p/rkghbsaXb0Fy33oZ+lBx6sDM=;
 b=ZydM2PQm1O5udcQ8y6XkMxiaawN/L3E1GejMNjdBiM9RuyPSW0tGat0YcvYjUDrsoQaS2r5fO7Bxnk4v44jZg/8uiGgDlaSBUE/HZ/B6u15gkZl1wThy3vmLnSVG2IAdU27k+1EDTlXdkTPuB3RLjaHIjsnB+7OUEcidGiScDhM=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3687.eurprd04.prod.outlook.com (52.133.28.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Thu, 20 Dec 2018 09:08:52 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::987c:cb59:96c9:6b71]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::987c:cb59:96c9:6b71%2]) with mapi id 15.20.1425.025; Thu, 20 Dec 2018
 09:08:52 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>, "rui.zhang@intel.com"
 <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Aisheng Dong
 <aisheng.dong@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, Andy Gross
 <andy.gross@linaro.org>, "arnd@arndb.de" <arnd@arndb.de>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>, "heiko@sntech.de"
 <heiko@sntech.de>, "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>, 
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
 "ezequiel@collabora.com" <ezequiel@collabora.com>, "olof@lixom.net"
 <olof@lixom.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>
Subject: [PATCH V5 4/4] ARM64: dts: imx: add i.MX8QXP thermal support
Thread-Topic: [PATCH V5 4/4] ARM64: dts: imx: add i.MX8QXP thermal support
Thread-Index: AQHUmEOgvuU29LOpJkKytGq5wKJFBw==
Date: Thu, 20 Dec 2018 09:08:51 +0000
Message-ID: <1545296609-20477-5-git-send-email-Anson.Huang@nxp.com>
References: <1545296609-20477-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1545296609-20477-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0091.apcprd03.prod.outlook.com
 (2603:1096:203:72::31) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR0402MB3687;
 6:WwnwXerYnL77V+PPgxL7sjQULRy6OVvrkQXPajM0vaDa4mXuLgIaxpix/09I89Oevv7Yob9vf3I7UmWv6raXa6i14uxaPAJ39SX/xSV8A4UFZ25tWnIjmywma4ylmYdP7QAUGdyQxswMt/QuJiI828d5G8QHmLGkQQQOlNFkNldmV+5mpC9tp75Y1KrbYnjySaQ5cyBqteYIYbx0LW8JwMUd62rS/pryEISgKVgM+CgjDPkjwUGJ372nXJhvFKmFZhjNUgZRZ43i0qAPjPpg4DAMLpPCOcE/5zhhEq//3VWgS9XkWLEnS1bb2N5ums24tLclRFsljsvEwhzTK4uKfZuFmkNaVerOlhp6t2+SATb4uHr1hyyjiMtIO5JMNsNYIRUfZQNLq1k9VLOHQVoLmskZi0OVBqM4MZPxU0jwHOy2uW625dpNH90f8nTmA3HODrQWY9xJXkxbEsIjRL0S8Q==;
 5:jb6276LG7k2YA9/ZTy5xyIBzOPTLHIocdeO1kuPJZSmNywaZXTkkR6bkgfnYbVgxTP/3XUbgnM4tWS785ArjMgYf7Rt4nbU/ngXBH53n3T0Izm6MMvz/UEufnT15DeocK+vDMu/EYzopfCkYSyMZHL3Zr7qAQJgrEjQavCHY3Yg=;
 7:Cjm0vUHQ2t+KT9yyqildJzHiV+tEwvdM/PERorCiXUidkHMd5NmwZeSMIuYK+9IySedGn/hfCHTLOEcCTjrMFxJJ9SfIzv+oArASMpzYmL+rBpL7lhOd6+i7KfDVRB/IrM8PsalDDGykyNcpg7YZcg==
x-ms-office365-filtering-correlation-id: 97cccc6f-3284-4dc4-834c-08d6665ac29a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR0402MB3687; 
x-ms-traffictypediagnostic: AM6PR0402MB3687:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR0402MB3687D2C41DC7FBA0BDC9736EF5BF0@AM6PR0402MB3687.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:AM6PR0402MB3687; BCL:0; PCL:0; RULEID:; SRVR:AM6PR0402MB3687; 
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(366004)(39860400002)(376002)(346002)(396003)(189003)(199004)(6512007)(316002)(66066001)(97736004)(110136005)(3846002)(106356001)(105586002)(5660300001)(478600001)(2201001)(476003)(4326008)(186003)(446003)(11346002)(39060400002)(486006)(14454004)(2616005)(7416002)(53936002)(256004)(86362001)(99286004)(50226002)(8676002)(6436002)(71200400001)(71190400001)(2501003)(386003)(6506007)(81166006)(36756003)(25786009)(2906002)(305945005)(26005)(52116002)(81156014)(6116002)(76176011)(7736002)(8936002)(6486002)(102836004)(68736007)(6346003)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR0402MB3687;
 H:AM6PR0402MB3911.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-microsoft-antispam-message-info: u9CfbeyH3qPEFES41JaMGqUglYLHOwUFUP7r4uv6fZWJUa4rKuPf24QNyjMeTtOkXOvQFWYdS2crhU0f8zTBPFNuw/yOwlZ6UuJKV+N6FwIHIviOQTvlLa3zc7rZ+D/FUBhRmxHHoykncAmVtI9yXJw1YSm0gIBRDK4l+q/cYnshh0NZ7fXX/6AEkhQctDm23IjIvKhcPV9ABaSsxsF+8aW/lE4KQzl9ctOtDjPk3KcL2unrKW0Fm5q8gCQONnXoAwHHEUR+3VgLVxaWxZmftG38tju6SYndVRMzWciUbFzIWxolysLC1X2CoVs0tvgu
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cccc6f-3284-4dc4-834c-08d6665ac29a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 09:08:52.0631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3687
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_010912_025924_34152248 
X-CRM114-Status: GOOD (  11.65  )
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
No change since V4.
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 9b08688..48f622c 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/firmware/imx/rsrc.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/pads-imx8qxp.h>
+#include <dt-bindings/thermal/thermal.h>
 
 #include "imx8-ca35.dtsi"
 
@@ -87,6 +88,12 @@
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
 
 	adma_subsys: bus@59000000 {
@@ -410,4 +417,24 @@
 		#size-cells = <1>;
 		ranges = <0x5f000000 0x0 0x5f000000 0x1000000>;
 	};
+
+	thermal_zones: thermal-zones {
+		cpu-thermal0 {
+			polling-delay-passive = <250>;
+			polling-delay = <2000>;
+			thermal-sensors = <&tsens 355>;
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
