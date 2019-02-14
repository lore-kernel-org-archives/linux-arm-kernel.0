Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90748C10F04
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:15:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E04A222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BNTxB2fr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xaEk+8/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E04A222A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nyaOgljPvPi40a0GHMVpULD/NhNO3MooWLkHwv8uhFE=; b=BNTxB2frttceDr
	+/XcuWd8KO7Dz+K8JJu8cmkYAF14zA2Z4hjYbpAUo0GAl2G6fksd3oVQF6N4vPiNcC78Essr7FQxe
	RsOaXR33a/zd88Fn1pUx3NoUCBLEDt3CBq+GiuTK487cUueP8tLPihUu3zDrWQPccasfGbaZ62mZ7
	1VtFJSX4lINXfDcmgaUpta7SEWkPsqt0BLEFOFHBCbuY62v+R+GYcn++Bu8JIngRvvslDHFe1wx9C
	l7sWdfgz+YejlB27Mu2MxSwhQHO4npfkrkTfNx3QwM4hWYfToZYQdvdBV/2KBaNHdDFXTSVzh7mjr
	2DLNRSLeyjipa1iR3akQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guDkP-0006kq-RT; Thu, 14 Feb 2019 09:56:01 +0000
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guDkJ-0006Xs-Cm
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 09:55:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aFI7o9PaamN2AU70fkmnBLQnt/J0ctj1ZKUp0I5VcA=;
 b=xaEk+8/1j6E3WyfexJR1P/d7lhARXfmJlEn3+iEjAOpoSDHqENyCWkB922lzA5FWaAkVJqKFsv9P6VtcNtu8Fbh07ocoyPGzY7xCnOAPuYGoP2pH0DN0yTmJgySxi2QUAs9VAWVW5a0Sg9Ng4GkOaVzO4n4BylUiqgduZC5HuME=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3818.eurprd04.prod.outlook.com (52.134.71.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Thu, 14 Feb 2019 09:55:51 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 09:55:51 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
 <sboyd@kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>, Daniel Baluta
 <daniel.baluta@nxp.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "viresh.kumar@linaro.org"
 <viresh.kumar@linaro.org>
Subject: [PATCH V6 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Thread-Topic: [PATCH V6 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Thread-Index: AQHUxEt3Dyj538gXXEiBj85l935Pcg==
Date: Thu, 14 Feb 2019 09:55:51 +0000
Message-ID: <1550137826-18531-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0075.apcprd03.prod.outlook.com
 (2603:1096:203:72::15) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b07ef332-4066-4210-0303-08d6926299f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3818; 
x-ms-traffictypediagnostic: DB3PR0402MB3818:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; DB3PR0402MB3818;
 23:Hh1E3ZI5pFwYhQht4yDif0/5FWxc8d2Pd2ckR?=
 =?iso-8859-1?Q?YZlNHzPWJ5PFbgyRNpR5eV++j/o+eK7bAeF25PUK7npJJkrzzq3LsyAvuW?=
 =?iso-8859-1?Q?kxLqkEwo4gKwNRHo7kw0IF+qH1BP4Gg4BeXiAfWH3MvpIVU1dROTSrCyFR?=
 =?iso-8859-1?Q?9qSZtwS3YoFXV6DdrQkKKc5zybOoz105Gr3Ix5Jv28ROzdA0syS/Im6Bn3?=
 =?iso-8859-1?Q?Xulh/ic5ONiK/sfH3uDNV0ObLLtyEK2ajTAK0kRW5tzxgz7U6qabIOGzbG?=
 =?iso-8859-1?Q?qiY/XSqs6/ubtm7LoQXGuphbePu2p55Dq+zTl1iJFeWTkwgf+c7vgr0C1y?=
 =?iso-8859-1?Q?uiaWUNUSsp1liIBGQ1zzBMUV3kZQwWHsSCsnSK6oqSTIyAeN71AQXoj0y/?=
 =?iso-8859-1?Q?KzaOYgyzXJfjyrqbJC1oOwhsrKq4YX/UUXAwgJxL3g5Q1J/tAlul5BT24+?=
 =?iso-8859-1?Q?2AbVEoV4rYCVHgTow6y3ujRmp6BrXzl+YSSBOdARxFcUWMUsZHhaBecPeO?=
 =?iso-8859-1?Q?+nFQrcA68LGDks+lBh4rObaUXKXSU4JtRQFGcXZaE6Yv2CEcvTl8nt/6ke?=
 =?iso-8859-1?Q?UEnOverrS8lRlHfoOIEyk8fJESjnqxjlhzvT18P7ZrwTKng8l/VQx2hpsa?=
 =?iso-8859-1?Q?H8PqEKanzh2Ziztb1S7RYcPxTqpCQzR0IZVvsm/D1NXN42uR2PYX1fPzHN?=
 =?iso-8859-1?Q?WNqCNQjtosjqHgCXmxYiEq7P/vG0+dgMLaIQ4EnLhaBS2PMB79CAH7vfb/?=
 =?iso-8859-1?Q?43pR5sehHY3JDDrT+qwI4xhBx2T3Q4L0FCqO1qUe6O/d8YpS2Bai8uVrWg?=
 =?iso-8859-1?Q?GXzuGAEedf0zk2S/RiVy+gQg8jPz2kdlk6wI+6UxQh7Ad+m9rzlAOSLUm1?=
 =?iso-8859-1?Q?y3FAtAHWWcppIC5434b0NQ31QIpo6AOXBD0ca7AoP7cCd5yMDAPnVECpXm?=
 =?iso-8859-1?Q?bYhJUfVY7uTJn3BhPJu3wgS8QY79RQOlwKCHVxdROB/dKf2LiU4yaonbGH?=
 =?iso-8859-1?Q?tU9LNsgYQ3mLgvm7Y28QbO9MzmN1nkD6CQY4EHuyBWnxRxKWixqemR19dH?=
 =?iso-8859-1?Q?I4OhAFujs6ilo/Kj7QxlnrH2Ve9EgbG94JG6Uz2Vr9IAiWvPzivcDj/0Pc?=
 =?iso-8859-1?Q?+ADIUQ1WhvNuMKGR2dQa3md+9pl4gl4SEu0DC2YLcgvMWr/C4XGDK/RMGl?=
 =?iso-8859-1?Q?Cmg+tpdEv63Oq1nJ7D1qHJuw0Kfu1emEdUQSwWkqeezBAv4xLmU9ysydL5?=
 =?iso-8859-1?Q?UW02GVBSV/DsbtUc+gI?=
x-microsoft-antispam-prvs: <DB3PR0402MB38183228B289763450D9C13EF5670@DB3PR0402MB3818.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(136003)(396003)(39860400002)(376002)(189003)(199004)(97736004)(71200400001)(8676002)(71190400001)(256004)(8936002)(7736002)(2501003)(81166006)(2906002)(81156014)(14454004)(52116002)(110136005)(305945005)(14444005)(53936002)(50226002)(6486002)(316002)(6512007)(68736007)(478600001)(2201001)(6436002)(486006)(476003)(186003)(2616005)(36756003)(6506007)(86362001)(386003)(26005)(106356001)(3846002)(4326008)(102836004)(6116002)(99286004)(7416002)(105586002)(25786009)(66066001)(921003)(32563001)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3818;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ABKvUneXqX5+kVnxzIOwe54D1sd/SIW96DT437en/tYFvkVqxg+W6kJULFmZNLLaaWUi2o9xZkPU2HjeMJlLqUfBB9QXJYXNr/O1TFt7tO/8rSWQMiUSeO6dqf2YfPBJmsvl0jv/fxqhoXuiVwjhauL5zs/tYkqf0wdYAz9C2IIkfaO+zVX/Ymbs/oGXd8wrFL+ihVCbdcPNn3243EAnTY0AqpxhSB7Usdw6VpIfOwL51L+u02vGrwv7a995bbBpRcH/UrJfQNgoiHwHEuNSa6YVodJIPLcBuRv2AUN+kLO8XmK0dpu4FQmQbXPb0xWtqUTLOKe6BmUr0Db6gCwfXj0T+IXHANs5u+Ist6VS7uF2/vumYEfSMq4iafEBg034Tr6O5OGvr5/k4joNfM/FfeStK7XnIq0dwfutG6Qyw+c=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07ef332-4066-4210-0303-08d6926299f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 09:55:45.1668 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3818
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_015555_535753_4A68501D 
X-CRM114-Status: UNSURE (   9.65  )
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

Add i.MX8QXP CPU opp table to support cpufreq.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V5:
	- add clocks for all secondary CPUs too.
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index aea6812..b5b2dc0 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -34,6 +34,9 @@
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&A35_L2>;
+			clocks = <&clk IMX_A35_CLK>;
+			operating-points-v2 = <&a35_0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		A35_1: cpu@1 {
@@ -42,6 +45,9 @@
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			next-level-cache = <&A35_L2>;
+			clocks = <&clk IMX_A35_CLK>;
+			operating-points-v2 = <&a35_0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		A35_2: cpu@2 {
@@ -50,6 +56,9 @@
 			reg = <0x0 0x2>;
 			enable-method = "psci";
 			next-level-cache = <&A35_L2>;
+			clocks = <&clk IMX_A35_CLK>;
+			operating-points-v2 = <&a35_0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		A35_3: cpu@3 {
@@ -58,6 +67,9 @@
 			reg = <0x0 0x3>;
 			enable-method = "psci";
 			next-level-cache = <&A35_L2>;
+			clocks = <&clk IMX_A35_CLK>;
+			operating-points-v2 = <&a35_0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		A35_L2: l2-cache0 {
@@ -65,6 +77,24 @@
 		};
 	};
 
+	a35_0_opp_table: opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <150000>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <150000>;
+			opp-suspend;
+		};
+	};
+
 	gic: interrupt-controller@51a00000 {
 		compatible = "arm,gic-v3";
 		reg = <0x0 0x51a00000 0 0x10000>, /* GIC Dist */
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
