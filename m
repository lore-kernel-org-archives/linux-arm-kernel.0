Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419E4C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:43:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FDEF20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CiNDuo1w";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LQBzc8lQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDEF20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+rpBuT/0CFKtkFR4j499P+bIlQNzmOGgLxPXO1X4FZk=; b=CiNDuo1w0YVyho
	qKvjjx+xtjVKiX3FxOn/Cn1rd/DzE2lRHfDn89XEZc++COM8WUmIIcHB8z2ovRq2bXwKLdqMbDc0X
	voL5HIvaeS/scoEYmQBw5IZwBl5Ah0AA1utYfBwEo4PNwHIq1NojlRJNXo/edgzRmcP57s2M98RPw
	0G4hyNmcJ6zoIfvATPpRMlqevo71L9YMFfj94VUssRy+8gw7XPqtXYeuvha/w1EDcPkxT92YXwriF
	z4wdwjGrkkKA5VCsJmwLDkCOSGK7wbyV1UqjTrwOWGYGe3AvCsme4ojf9jyE81Lxp/qitNKiEFH3Q
	/XmmRK/A4LoGuG5aq71w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUigu-0007Zx-Qk; Thu, 06 Dec 2018 01:43:00 +0000
Received: from mail-am5eur02on0601.outbound.protection.outlook.com
 ([2a01:111:f400:fe07::601]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUigj-0007OO-Gi
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 01:42:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+oI3Hz/+iLd6Cqyj84jcC0zczbqzskFcHtazE4TMBY=;
 b=LQBzc8lQeTi0kYX8E6THYP2AAbIaggAyERgN7/0PAGP7WKj7INBaudW+IoYcilDMkg8YJC+azNV4QAbtQwOo+SqaUMpVMDTNfUTbCDw5r+qdudGoP1NELzXNBm/YAhmAgE0Z/vIJrMYXetFmJ2r0fBZ2P6nzU9t93LeZV7RxH0g=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3947.eurprd04.prod.outlook.com (52.134.67.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Thu, 6 Dec 2018 01:42:34 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1382.023; Thu, 6 Dec 2018
 01:42:34 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 2/4] ARM: dts: imx6qdl-sabresd: add light sensor support
Thread-Topic: [PATCH V2 2/4] ARM: dts: imx6qdl-sabresd: add light sensor
 support
Thread-Index: AQHUjQT10rOFzOGhuUqcihFcwbvhiA==
Date: Thu, 6 Dec 2018 01:42:34 +0000
Message-ID: <1544060203-22163-2-git-send-email-Anson.Huang@nxp.com>
References: <1544060203-22163-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544060203-22163-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0051.apcprd04.prod.outlook.com
 (2603:1096:202:14::19) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB3PR0402MB3947;
 6:wmkU0TSBR5EW/o/0NGmTOdM0TfElvjcvPMyagciEt2z827cZwXA14IhIV35YNw0zv1B+/8YlTyVHHartOhoWX3eS4w1j/dNNHqQ5xrARa0vYf/zGfzeMXJslNQ3ExqDvDD1B8BsLnZU1gLBwH9Z+kwWggcP565EIWQUxWnC0oP45XPUElRZu83mXI3X484gh5lYcaOvxv2v12hxtZioHz3emAO5maV4CMeuY/JwpvzO10aZ9+ydfMAVip3EB5znHde16m8ExYqkXzCKTSCXPVo+Jm3urtu4GVDM6DLVDBErf7ep4oSgfOlXq1aR4Qh15WLucmP40zEwvkYpXYWSTf2qzmxVCvShOMDfd0arrCmSXXVb93XQ+ipTcY5lirZ9SfawUKFKohHMt/YQINeqrlR85Fsbv+rSOtBUdtydtqquBthxrn3ZDbSKMrUx9x+LZI2QIYgTMbA4Ta0ymj/XFng==;
 5:CiXqGJ7XyUPSUX0oFe25zvchFXX93ZWgrxsLMB6I0hPn5jNcrH8NLvJKvB3NIH7r7GVCKlLTSLZdGYPrWOzxjJ5V8ZDPJf7YkPqedHzeEzFcBh1obNWELkE1rhsIBvKj6NORtWZ0jir4JtaphgjNmVYbmxIiaAnueMJm5D20HCI=;
 7:+PtwYpGd0Pn2LtXULD5Z1uSZeOKhIMXyZyZo6AtrjHIT+WezKqD6htaQOUj+Oon5TGILtF2MtLlRHG9Cr2xfQmHfB4BnCGB5XEuUGwjmBvb3ctb6oVIIZ0opZSwKhzArHOD9AU7ofMjMYKY0hxFUMA==
x-ms-office365-filtering-correlation-id: 012d45c5-29d5-492c-2fa0-08d65b1c1839
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3947; 
x-ms-traffictypediagnostic: DB3PR0402MB3947:
x-microsoft-antispam-prvs: <DB3PR0402MB39472BC32E6605F84BEEF5BAF5A90@DB3PR0402MB3947.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:DB3PR0402MB3947; BCL:0; PCL:0; RULEID:; SRVR:DB3PR0402MB3947; 
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(376002)(396003)(346002)(136003)(199004)(189003)(102836004)(86362001)(2501003)(76176011)(11346002)(6486002)(97736004)(386003)(52116002)(6506007)(99286004)(3846002)(476003)(6436002)(575784001)(256004)(2906002)(26005)(446003)(486006)(6116002)(186003)(110136005)(106356001)(2616005)(14454004)(2201001)(105586002)(305945005)(478600001)(7736002)(4326008)(66066001)(25786009)(8936002)(50226002)(81166006)(81156014)(71190400001)(71200400001)(5660300001)(6512007)(68736007)(53936002)(36756003)(8676002)(316002)(32563001)(473944003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3947;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CDTtaavNew9SIgMCQLiBoLn4q9TnbNPIKmqnaWeEO6NWIWec5PcDy+WJ8CWZr1VdRyJEkvYuHLJpjMZPbvEj+3HLqNCNJs7GyUaM5zNnTzIS5yRvMVm7EPAMCcyiNlit00j7T27lWy9c+gctHpyQSVEyA7NEUp07tD5LKSoONPz39uLfCqr43zpGb/QUGLABjZWtZUh/8P9uCNOugGgrUbrZFXNg/doYCWBCe4mFyU/Cr8VRqLUBIrHDEZJNH4bHBLL3qO3QmnOZdfA0xBmIpAMXbz05YwEhfg9FVod7hhBstZ11S/uW4yY+rLIf0ENmWrwzwNhxx4BvtrbcH31sSAfRsbwlduYq4YGaYiGXIFs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 012d45c5-29d5-492c-2fa0-08d65b1c1839
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 01:42:34.5438 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3947
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_174249_558173_9C06A6F3 
X-CRM114-Status: GOOD (  14.20  )
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

Add isl29023 light sensor support on i2c3 bus, the light
sensor's power is controlled by a fixed regulator, since
the isl29023 driver and most of other sensors on same
board like mag3110 and mma8451 do NOT support regulator
operation currently, they are all controlled by this
regulator, so this patch also adds the fixed regulator
support and make it always on.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 66972e8..d07c250 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -54,6 +54,18 @@
 		enable-active-high;
 	};
 
+	reg_sensors: regulator-sensors {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sensors_reg>;
+		regulator-name = "sensors-supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 31 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -410,6 +422,15 @@
 		interrupts = <7 2>;
 		wakeup-gpios = <&gpio6 7 0>;
 	};
+
+	light-sensor@44 {
+		compatible = "isil,isl29023";
+		reg = <0x44>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c3_isl29023_int>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
+	};
 };
 
 &iomuxc {
@@ -511,6 +532,12 @@
 			>;
 		};
 
+		pinctrl_i2c3_isl29023_int: i2c3isl29023intgrp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_DA9__GPIO3_IO09		0xb0b1
+			>;
+		};
+
 		pinctrl_ipu1_csi0: ipu1csi0grp {
 			fsl,pins = <
 				MX6QDL_PAD_CSI0_DAT12__IPU1_CSI0_DATA12    0x1b0b0
@@ -559,6 +586,12 @@
 			>;
 		};
 
+		pinctrl_sensors_reg: sensorsreggrp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_EB3__GPIO2_IO31		0x1b0b0
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA	0x1b0b1
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
