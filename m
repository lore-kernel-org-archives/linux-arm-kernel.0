Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC03EC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:20:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB4CC20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GKqzO9Cn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ly6vF3Ql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4CC20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=024j2tT98P371YsHk896ma/MYcfkuBugGzJ1qZQkU14=; b=GKqzO9CnCjmYXW
	NjtGnaziOMKOCwQfrvDn4mS4BgGSVQLAAyIvqOwQLZktsxlJytFpgqGT4j50/nwazn1/+qqepDNoR
	oVp5kMQSqUOtGQmWlmEEIKFQFmRmnv2/fDJC/x62OzziVr0pXD/XRCsQg8HoLwDUJNj78WFTBOmB2
	BJqYpryHVR5tV7xxJZQdESmQjCeYQ22JZ/cRWB3SIbDyGUY/uZ1ktHn7V9xzkCcMPQ+r8H87emUxJ
	kGFrtG/dYjJ97FDxCLJEnnNFRslhFWNW2EqcDLxEQE/iak1wG4lRZ9qNl6ZJrmCuz/wzx+bu6s+kF
	sjUL4sU6FnQh0gtkN12w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUTM0-0003wB-0N; Wed, 05 Dec 2018 09:20:24 +0000
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUTLn-0002Qf-Or
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 09:20:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDHowyfKFUvmvAPFP7LHlCPwUX3stQG17nTW/Hxh1HI=;
 b=ly6vF3QlPtXmgI3oVH8qd+OfGUQ+g/tVrE0zel7h7dIBtWWVyLmc5+RB2z4bw71o6X817yL0FqIMVNvft/edWJrNqE1LiTy5K3KKd29MuocqMPx9Qm9H/CnVxpNTDe7J0tA+4VK3bCA8YzR9nLKWDJP2gr4ioNJZ2Mw218U7QI4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3690.eurprd04.prod.outlook.com (52.134.70.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Wed, 5 Dec 2018 09:19:55 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 09:19:55 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] ARM: dts: imx6qdl-sabresd: add magnetometer sensor support
Thread-Topic: [PATCH 2/3] ARM: dts: imx6qdl-sabresd: add magnetometer sensor
 support
Thread-Index: AQHUjHutIsFNW2Zsn0GVxolgXFx7JQ==
Date: Wed, 5 Dec 2018 09:19:52 +0000
Message-ID: <1544001240-18622-2-git-send-email-Anson.Huang@nxp.com>
References: <1544001240-18622-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544001240-18622-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0049.apcprd03.prod.outlook.com
 (2603:1096:203:52::13) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB3PR0402MB3690;
 6:jeYNGsDGhZbkkNngauNa8u7Ym8pvBGzPNIMIoxZYB5knmFyaFbt5ld4E/XFF2Cf6GhosYhlufeW9R58e32fBmav+NXyfiOokSAweVTdprVYmlaU5KazzwRKwd86WQQbRe782IXhYezRpR5jYjDFSrxd2p/cKWdj8PsWQuJGNE188pLMUhITJunxJywJBAC6UIrZWuDQRICDBQ0ah9sIbOywANi34UPtqjUCbPhGzGg8mQuBPhRbahjJl2dK8T3Zep7MFq00l6JjKkpyLLXjY6Tm+F/PVwd2JS+JYCgc9rr7lkrbEtDdy0p89HHFWVA5QIqrwXQOTumzeVmn0z5cuZTpGsc5zWoBzJqoCGQr3nxYjCVR97x7WUBzKeuokFND4ho1qazvTLybF4bJcWSyA6xwRNh7g0OLu0ndBKLHuwdq1YOfM8ZVqYZKvZ0KDqoVhjr2p0ELXwSLNlLxvZ2JEBw==;
 5:LxHvx1gUFwOfvQIy1HACc6VLsPW28XNpTdcz0kOnWO/05UuzIw+yYr9F02xPVTMaxocu2kr3zxFLs7YlEJng8Hkod+y9PFsh9gUXNGSuklPy6wXDNTiBID7c+etHPlVPytFG2SCV+Yfu9AKtSZ/Y8L9Aw3s+yVzWw0lhNGhDjV4=;
 7:un8umLygD8E//EMmYotc4SmZh01EJ9PfOfZhES3SUmivKW1rfpZo4taK1nJpuQYI0IO9uele/+4QWwWC0WxDrUQS22tWpeZzZxTo8t/IUvb0S9ZVR04OM2dxDzcvIDvaQmUhM6M5VGl+fiQK613Vfg==
x-ms-office365-filtering-correlation-id: 37360c33-53ec-4b63-2c09-08d65a92d002
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3690; 
x-ms-traffictypediagnostic: DB3PR0402MB3690:
x-microsoft-antispam-prvs: <DB3PR0402MB3690734EEB4E19ED76241387F5A80@DB3PR0402MB3690.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231455)(999002)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:DB3PR0402MB3690; BCL:0; PCL:0; RULEID:; SRVR:DB3PR0402MB3690; 
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(396003)(366004)(136003)(39860400002)(199004)(189003)(8676002)(102836004)(316002)(97736004)(81156014)(8936002)(2616005)(11346002)(446003)(6486002)(81166006)(106356001)(476003)(386003)(105586002)(6506007)(6666004)(4326008)(99286004)(71200400001)(71190400001)(186003)(26005)(5660300001)(110136005)(50226002)(14454004)(2906002)(2501003)(36756003)(2201001)(6512007)(52116002)(6116002)(3846002)(7736002)(66066001)(86362001)(575784001)(68736007)(305945005)(76176011)(256004)(53936002)(25786009)(486006)(478600001)(6436002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3690;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HdWvywxtmdmXLADwgCzhV44ZSGCcuUbchz6NZic6y+2sp22WSftcwUTrGvNtwVvteWyoLPe/w+RYn8ZdsLNntmaPYF3GeVxC97x6mB/q3KE22w+9yaCkgBZcTI4KaEFfPg3oxT8i7mgb7zZpZ5JInIo4D9T+LM3qs7V42uQdeHSn6cMtA0y7vZCt92UcVYNS0L9Pgb0oZIW2G8mRAq4TvZNF6z49d4m4DhGPelELv8COUKEU1erhcJ3EXdbo90W9wRQCV7z6mgdo1OQ9ItUWZ3Krxn0p2vACwKt3eqPfWCsB+uTm57hxPYJInjDFsz8A4R1jmgR6UNlXno+gQQ8E7l8szDRluSPuAqfwsWjFL74=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37360c33-53ec-4b63-2c09-08d65a92d002
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 09:19:52.5815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3690
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_012011_817189_129CEA81 
X-CRM114-Status: GOOD (  11.57  )
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

Add magnetometer sensor mag3110 support on i2c3 bus.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index f96ae54..141550a 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -434,6 +434,15 @@
 		wakeup-gpios = <&gpio6 7 0>;
 	};
 
+	magnetometer@e {
+		compatible = "fsl,mag3110";
+		reg = <0x0e>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c3_mag3110_int>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <16 IRQ_TYPE_EDGE_RISING>;
+	};
+
 	isl29023@44 {
 		compatible = "isil,isl29023";
 		reg = <0x44>;
@@ -549,6 +558,12 @@
 			>;
 		};
 
+		pinctrl_i2c3_mag3110_int: i2c3mag3110intgrp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D16__GPIO3_IO16		0xb0b1
+			>;
+		};
+
 		pinctrl_ipu1_csi0: ipu1csi0grp {
 			fsl,pins = <
 				MX6QDL_PAD_CSI0_DAT12__IPU1_CSI0_DATA12    0x1b0b0
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
