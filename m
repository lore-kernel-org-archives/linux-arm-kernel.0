Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416C3C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:07:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0790221901
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L/KQw2Ac";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XUUDFDYg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CHN9rPZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0790221901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Zwakj6JCWjZS0t7BXd/fXQ+mj65zae9t0M7RDxaAc4U=; b=L/KQw2AcRC/HF/
	9FVTim/BPsEoF5dM66JiK68Hb5HWa7sYuFBNtQx29apGkPiJZ5W/6x3IL3LJNTX4unDYwc960q6oY
	ZcRvvgFXoKKAiEucSsWm4vnX5YvRN/rTLj2FayiZV5nm4gI5/01LN0Yl0wxREk4LYTfmsYiJQ3g7p
	ozjD8oJhYvG6GsJD+fHOpmPEGjGJ3x16uKCQHazWO1/XVedulDMSq80nNbgbbPE87aX7zn7n9NH18
	DRxJZ+GXqYlG0JclB0Tzwrc9lqFFQ0vdzsfswv0OjwF08f/wDSr7Uop7kffasireSDZyFU2mrL3W7
	ZN2uJ230nTXNNsJQ07qw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grgao-0000ig-LL; Thu, 07 Feb 2019 10:07:39 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grgaL-0008HE-Vs
 for linux-arm-kernel@bombadil.infradead.org; Thu, 07 Feb 2019 10:07:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lcm5ZlTwO5wdHB/lVH6FfmYaGpNpwLQ3C2M5tTV98f8=; b=XUUDFDYg0nmu/QKt0B4g/8UF99
 OLIi+8nN1uIsy9GUqar4LFddxIhBC2u4BJIqiJCMLXgbqXUcRQ3ezhfhOHkCZa4fY92klvHYw3jWX
 hg7snej7AXk+eWlK/xqr4Haoyb7p9LFzTBtlx/EzueYHNHrO94qGF4e8uy001zUTuyxld4d1eq2tx
 hzkMd8GcvSUi6F+rERlKj7l18QIXU8Dx2nUkzdrgnDUQS0VKvM5bVZ0eFLw0qZOypl7SjmEBxx/25
 G0pgQlGMh/JRNC3V8Tkz2b2fi20Cuy9SCxt/LZSqttv0DhNitIjw6R7Hu0hXS9bfQD6Esb2r+RyUO
 ltQNM9vw==;
Received: from mail-eopbgr10050.outbound.protection.outlook.com ([40.107.1.50]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grgMN-0007m1-Rx
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 09:52:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcm5ZlTwO5wdHB/lVH6FfmYaGpNpwLQ3C2M5tTV98f8=;
 b=CHN9rPZ9kDDqLwgHlSaMthocayDXQkJ21/WYaC4YhdWpiUwvDyMAldA8OG27XK6Xci85QjN3m3srvK4l9FajqHzTWMutCh9by0VntB3stQP2Nea1v+vNHW8kTCKrr8z2GpJFZI3XI+tes0ERtu5ByWRYBt0k1No1hLWCOrHPEt4=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3589.eurprd04.prod.outlook.com (52.133.20.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Thu, 7 Feb 2019 09:52:38 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1%4]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 09:52:38 +0000
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
Subject: [PATCH V6 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V6 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHUvsrbmfXgtz1KZEeItOtlZ1aFAg==
Date: Thu, 7 Feb 2019 09:52:37 +0000
Message-ID: <1549532838-27025-1-git-send-email-Anson.Huang@nxp.com>
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
x-microsoft-exchange-diagnostics: 1; AM6PR0402MB3589;
 6:JIFkyQTlIX39VKAk5yWZtZVY7KA/TaGA+Bh6uErlIQy1Wl5rD3cnK2MNpzoyoYvzepoEACL83qSY3qWlFZxzg41iNDJD1Twz7LVGKlnIQ6WyQVeELyD8xaqTLnfrOheFvy+h0nJcXU4I5DeOo4uVloEJlKiUn96zzr4ZQfxtqY12+ParvDQt/9bxIm5q+9N8W91rvBArVYl0opzw8ZPOPsqooQZ5RIOi6omJUx9awm3hfJZOydaeoaJxrBlh6BFLMG8eUBBqWbAyXvR++uY88jTknc5PIr79ppg0oE8GqPJCKjROhpkt91IinIunOEF0P7h3KPfAIhqvtvbOZCGvf7xZXMyTVSgbH9JdGdP/JGgyGfVl7zr4Z65Koup7rG/PyuZeLbOkjXXi4tRtwQGDK8reD9jXe9yKqblZ1Om8TZxVdpzKfQ3LzNN7VNS4he7eeA6iyDrlSROSHd4abaNO4w==;
 5:hKDkY7jhxPBoJn8aef+4JcfJQM/V1mv2smGGRJiaWOJA6NHkZ/A+LYxWyCjtB5rmavxx21FCgXXBkQjN0IRqXoqzQ+dPr6TmYtedJ4xf8UFjw626SqRK1Sn/JH1qJ5dkIDxHxMbltKfYtU+mdqw0c4MjaQbuMxRKQFRvFfh+25I9/pMrKk8DxORDbzNwMB0SIN8bvxQcIj25ddmsEhr8SQ==;
 7:GhJAyFmMuvsN4hN9+ODB6kgJT1L9FDw3nd/XDkz3Lc981PuJV8moiKnTS4hTlw/4FQNxaBFmf+JUoR5GAJDO6k/ONLp2EHdBMDV/wUn/K4R+XgF1i8/xSMm71cSeOdGU9R5XZfZOG2kVzDRD/5+SBA==
x-ms-office365-filtering-correlation-id: c01e64f1-e2b4-4f80-4528-08d68ce1fdd0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR0402MB3589; 
x-ms-traffictypediagnostic: AM6PR0402MB3589:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR0402MB3589917F10D99B0FA6103CB2F5680@AM6PR0402MB3589.eurprd04.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(136003)(366004)(39860400002)(346002)(376002)(54534003)(189003)(199004)(106356001)(36756003)(2201001)(81156014)(8936002)(86362001)(4326008)(6116002)(71200400001)(81166006)(256004)(6512007)(71190400001)(66066001)(53936002)(105586002)(8676002)(68736007)(386003)(6506007)(97736004)(476003)(3846002)(486006)(14454004)(7416002)(50226002)(2616005)(478600001)(6486002)(25786009)(186003)(26005)(6436002)(99286004)(316002)(110136005)(7736002)(305945005)(2501003)(102836004)(52116002)(2906002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR0402MB3589;
 H:AM6PR0402MB3911.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: er8HVtngzUtySUJ0xH+t4VPq5Uomh39tU/KDEvszrOJMIkwsTdw+ValULYczGsyyBuUgi+oj4PLxN0IxfI7Jfh8WHpPlPd1X/ksvln9zMg6AmKq9bYItH1TrVmBpS9X9Di+wrlv/eOWeYs++nh/g63xfbWoOX7+FaC/WNdmbqRQQDdRhYte+retNUqaiXC1MqIuU4e446WGvak9fAVsOS6X+A6KKKX3+KDKMulvpzrn0wvdqheJkVCGR9kCVLx63a3qwaNbh6T/CplmIVW7RT/I7DpsQoEE+VjvzLs0e8mxabd0oU1WqcgkP+CnzXzM0DzkJmgQERAdZ96M26D6il++AbPr3veMJt9STupRUe/jjc0kvC2GHFe23XPuGNq5Eyjirj5IOp9AOsC5VC9d0cBLpHoDPtdduG278DVBdJmw=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c01e64f1-e2b4-4f80-4528-08d68ce1fdd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 09:52:28.9999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3589
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_095243_974569_AF7CF444 
X-CRM114-Status: GOOD (  13.51  )
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
ChangeLog since V5:
	- add "imx,sensor-resource-id" in each thermal zone to pass resource ID for thermal driver.
---
 .../devicetree/bindings/arm/freescale/fsl,scu.txt    | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 72d481c..4b79751 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -122,6 +122,20 @@ RTC bindings based on SCU Message Protocol
 Required properties:
 - compatible: should be "fsl,imx8qxp-sc-rtc";
 
+Thermal bindings based on SCU Message Protocol
+------------------------------------------------------------
+
+Required properties:
+- compatible : Must be "fsl,imx8qxp-sc-thermal";
+- tsens-num : Total number of thermal sensors supported;
+- #thermal-sensor-cells : Should be 1. See
+			  Documentation/devicetree/bindings/thermal/thermal.txt
+			  for a description.
+- imx,sensor-resource-id : This property should be defined in each thermal zone
+			   of thermal-zones node, it passes each thermal zone's
+			   resource id for thermal driver to get temperature via
+			   SCU IPC.
+
 Example (imx8qxp):
 -------------
 lsio_mu1: mailbox@5d1c0000 {
@@ -168,6 +182,12 @@ firmware {
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
 };
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
