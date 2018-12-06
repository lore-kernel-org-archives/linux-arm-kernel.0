Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D20C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:42:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9173620892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BI0XDvlW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lsc2BZTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9173620892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=VpvYhhjMWNA1arxSI7w7KE47XcCikAUK2Pl1ln4gDtI=; b=BI0XDvlWXnv8SA
	TXzvop8W5/wRW/iRvkm0Ua/2qfQgrG6JycOowHvlGL6fODrVBnVPBnBYGNi4s2/ZliIYq+7Hj04L0
	Cls8R6OdoYvkT3mjKEwJPdTHysO5/rycAWJL9cDVhO24n3+DFiuVdvLmvyk9Jjc3V4hiK2RAKeH5w
	OLLz3fkREC+th3jaeJl8n6fE136PG4y/jYGwEQ4gECttOOA5J+Nz1+dtThBUvsdJ07bbTp4Jw0aTQ
	NgHNrofwON9ZVB6VBadtQLfYExsMLfy5qYKvAP7OO/stVaDbww3ka+qu56yHL1UFElfqvi40IQnPK
	HbOnv/jUCrURzDOVxecw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUigk-0007Ps-EH; Thu, 06 Dec 2018 01:42:50 +0000
Received: from mail-am5eur02on0601.outbound.protection.outlook.com
 ([2a01:111:f400:fe07::601]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUige-0007OO-UT
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 01:42:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liR6r9cd0owrn9JDG2OI88carz9Zfyl0ucaK8Z9M//4=;
 b=Lsc2BZTm6gTjqr4nLLK0kmy1xQ2CKnvby5qizYANxEYIsoDNfuLcif/cAf5KcyFZSULDtwVxi49ks2Y3szA7HVbznzg/hNOkndRGpxw2ecswUNZToAi08HzVM9u+tGUsxOn9lsN4lj5G3i56wTpXVUQA4TZOoI6eYeAgtFz2JW8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3947.eurprd04.prod.outlook.com (52.134.67.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Thu, 6 Dec 2018 01:42:31 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1382.023; Thu, 6 Dec 2018
 01:42:30 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 1/4] ARM: dts: imx6qdl-sabresd: Move regulators outside of
 "simple-bus"
Thread-Topic: [PATCH V2 1/4] ARM: dts: imx6qdl-sabresd: Move regulators
 outside of "simple-bus"
Thread-Index: AQHUjQTzAHzf1Vy8wUKFGc7PPt68jg==
Date: Thu, 6 Dec 2018 01:42:30 +0000
Message-ID: <1544060203-22163-1-git-send-email-Anson.Huang@nxp.com>
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
 6:+QlCNd4nbiy4YcG+xfVeiN86bH6Ooi9Ch0+bS9jzHbYEEOj6msHiRpf4+GurqeNuesIM5Djj9eCJt6TQ2S4yGoHG+EmvbibLRZnGkunznQhZD6pbly64nKi8Rr/moakhVixtIuarbVAf549bAzGse8aOWk8TDveMykcd6nzStcFqcy7kb0ka6rExUM79F9z0wddgY9ZyP7pJE0I+xk1bbXJPF6uCoqlX6vLJ4mGFl8sF6m2vQQhKfxUPMxnNa8D8cFAJ+2k+PxUjvAC3SxMyPDFAspB19Rw0a+yiJTLXdtYgA+fi3/f68hHURGyUeTXq5aj/A9WtW6MxWFl4HLjCNwUybHFV0e9Q1TNJpeEKXXgx+ZJHMQXoeoxl6PlC0ka+hZvW7obzaXfRNPtG4OdXCuFuT9n4gThGtcSpgyvFlG55boHKqi+drXvrLa3I/jhey+PFPnCbz0g9d//nISUb7w==;
 5:Lwjgqhv5MurcHq9QMRCkU2wRQDGFDjxKzTmjEZLOOZ/5cs4e1+HV0F/YdlrlkkY1QNZPU7wazZSnZeIcP11gtFkEd1Q71eQMGasKgwoQqrG3GwxqQzpdbsDBSgZ89CakS/Vlg6aj9TJO7iK7+oVQgoPli/eWUO59XiLxDZPTwXA=;
 7:WHtqOfr3CjYZ1WpISdlIZ8l2cgGDwKyoo39lXyLdgIlHTgMxZhvqKBllTsm7Bpi456wv+3s/6HALLjJILLhkH5Mgrx3U5Iv2K23StiTkRpF1oxQ/tDVeGcNxyyoW4XjrY0fnO+uR3TaD4z18c/4Hfg==
x-ms-office365-filtering-correlation-id: cf5457ff-c73e-4c66-78e8-08d65b1c15c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3947; 
x-ms-traffictypediagnostic: DB3PR0402MB3947:
x-microsoft-antispam-prvs: <DB3PR0402MB3947E5E7CA641B29938A2C76F5A90@DB3PR0402MB3947.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:DB3PR0402MB3947; BCL:0; PCL:0; RULEID:; SRVR:DB3PR0402MB3947; 
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(376002)(396003)(346002)(136003)(199004)(189003)(102836004)(86362001)(2501003)(6486002)(97736004)(386003)(52116002)(6506007)(99286004)(3846002)(476003)(6436002)(256004)(2906002)(26005)(486006)(6116002)(186003)(110136005)(106356001)(2616005)(14454004)(2201001)(105586002)(305945005)(478600001)(7736002)(4326008)(66066001)(25786009)(8936002)(50226002)(81166006)(81156014)(71190400001)(71200400001)(5660300001)(6512007)(68736007)(53936002)(36756003)(8676002)(316002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3947;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: X1Rh3Fn1z2RCBFZce6ZKjtAbhBeC3bq8LPycSilDiSY+jz2aQVQt+lTeIGkHWrRT4HJmJpDxScpBa7xwR06vBuZk9gpRi/UWp+mT2UfQl06M0iBw8XLJ4FoOLNfkyIKA2REnp95OikIx+LFIRgM4VR25CMoA9m64ZjnMfacM/N57Ir2ujbk2DXHGt+lQLzvkkUJEAn6pXNYUA2SyJnjhyK7P8xok+cGfMHkrswypTrVx4NVoDBCDa6fkec3cnAvIHLBj9gYjmp2M79tTjQIagBxHbJ3sshvFzjZ+ZV9ulHmzSGa7yfzGwH/mTFHz8r0v5lbxrA9sioWD5A3sP+nngPlmObmaxG0bVBpYGG5Pp+0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf5457ff-c73e-4c66-78e8-08d65b1c15c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 01:42:30.7629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3947
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_174244_983514_64C3E760 
X-CRM114-Status: GOOD (  12.35  )
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

From: Fabio Estevam <festevam@gmail.com>

It is not recommended to place regulators inside "simple-bus", so move
them out to make it cleaner the addition of new regulators.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 82 +++++++++++++++-------------------
 1 file changed, 36 insertions(+), 46 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index d7389b5..66972e8 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -16,52 +16,42 @@
 		reg = <0x10000000 0x40000000>;
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_usb_otg_vbus: regulator@0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "usb_otg_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio3 22 0>;
-			enable-active-high;
-			vin-supply = <&swbst_reg>;
-		};
-
-		reg_usb_h1_vbus: regulator@1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "usb_h1_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio1 29 0>;
-			enable-active-high;
-			vin-supply = <&swbst_reg>;
-		};
-
-		reg_audio: regulator@2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "wm8962-supply";
-			gpio = <&gpio4 10 0>;
-			enable-active-high;
-		};
-
-		reg_pcie: regulator@3 {
-			compatible = "regulator-fixed";
-			reg = <3>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_pcie_reg>;
-			regulator-name = "MPCIE_3V3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio3 19 0>;
-			enable-active-high;
-		};
+	reg_usb_otg_vbus: regulator-usb-otg-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio3 22 0>;
+		enable-active-high;
+		vin-supply = <&swbst_reg>;
+	};
+
+	reg_usb_h1_vbus: regulator-usb-h1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_h1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 29 0>;
+		enable-active-high;
+		vin-supply = <&swbst_reg>;
+	};
+
+	reg_audio: regulator-audio {
+		compatible = "regulator-fixed";
+		regulator-name = "wm8962-supply";
+		gpio = <&gpio4 10 0>;
+		enable-active-high;
+	};
+
+	reg_pcie: regulator-pcie {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcie_reg>;
+		regulator-name = "MPCIE_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 19 0>;
+		enable-active-high;
 	};
 
 	gpio-keys {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
