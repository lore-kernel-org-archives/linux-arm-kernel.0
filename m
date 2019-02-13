Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F76C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:32:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 806702075D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JQ6PY4Hs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iXAPXXK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806702075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=u4cwJRZh8ECypTiiZcPw+/lNPoyWA0OB+gQQP08dVhU=; b=JQ6PY4HsAASo7r
	FB+WAvDbxwBddver8MLF0dD11F7KVVqF67NGZcll5VFaOQCkFbR0iSiz1Emx1HxNrotAEvkQfyvAb
	MNnyl/a3xS2GFY3groSn9V3qm/g+ri3ShYAbHc0Vuz420S4KsSZeAOKN6q8ceXdlfoGhhUyOb6a2i
	kJiWYnmyTwRS55+MyJU64dnt82NRiVGXL2GnYAUNqBOwfDcHEmxn33QEh9nE6Vk1EhYINwDIyEyZU
	7AGgQzPGiGTiofn9cI4juHhi5Q4MkwczKGCJr8Yxo36t+aRK+m1UXIOZHCymnkfhtpcTJ2pRC0l2C
	AOtd6jklyb/qFis2qcgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtueR-0001Aj-9V; Wed, 13 Feb 2019 13:32:35 +0000
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtueN-0001AA-4a
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 13:32:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnBsWXN8cRyqzWI7BjB9+N/yYL+mv7luZ+JlIn1qYfg=;
 b=iXAPXXK6tBm5lUkJuMSE1CKIEmx5nbcssVP1KEvInEiZSBgjVUc6HJoTGDXt2L8FrsT4t2EoC0y+8iP5fxddRgjGrh+AEtwaDpxrRCQ4xgLQWJZ0dJlfh2XPgrstapqu9cPgfX5It42KFMPj31dUVln6mt5CbuvI7XkxmQ08Nac=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3657.eurprd04.prod.outlook.com (52.134.69.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Wed, 13 Feb 2019 13:32:23 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 13:32:23 +0000
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
Subject: [PATCH V2 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Thread-Topic: [PATCH V2 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Thread-Index: AQHUw6CMS+2RedgPGkSlnUsit+2mig==
Date: Wed, 13 Feb 2019 13:32:22 +0000
Message-ID: <1550064410-28417-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0045.apcprd04.prod.outlook.com
 (2603:1096:202:14::13) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 008f6d53-a053-4309-f0fb-08d691b7abe8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3657; 
x-ms-traffictypediagnostic: DB3PR0402MB3657:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; DB3PR0402MB3657;
 23:FfA1vrrxaj8UHKp83DMQEyeW+myqZBixz+483?=
 =?iso-8859-1?Q?A4oeEFoZBQ/RX6z68PBWVF9Nk6NZzH9OjQ93bTq8BFSFpCh+UUa8XTVB35?=
 =?iso-8859-1?Q?ZpQCo2vyytYmamGCBwj6bleG9KCdobzcnPyu3JNrKThuuQL4QAR0CMJ76s?=
 =?iso-8859-1?Q?MwEcoS7BOv+jGQLGrNe5DS83pMSFSyEn+6Ey2Ij0Jm/lBC84bqm5MYPlYu?=
 =?iso-8859-1?Q?k4ZDAg8U+Qr6YOuayOesOhCKToXMjjnODRAm1/8sVqKQlyCTlAmt7VWB/7?=
 =?iso-8859-1?Q?uu4HjvH7AXiwmpSqD5geQW/jOQOwCwKUevK9nSrrWo3rQZi1HFzhOWApzJ?=
 =?iso-8859-1?Q?ZSUMK6UH4O3g7EtrmqZruB8cKnfjam/qKph6REoML8nCLIgqMWVQaxsYKN?=
 =?iso-8859-1?Q?N00sWnMXAOv1HTvJ9jQ+B2CQnac/loKigg81b9VXnFZZ5YB98fIVMxHvtr?=
 =?iso-8859-1?Q?5GmTbk5gBSZannXc9f92wnshdRhNisv7g58t5V9R9da9w54LCUznn+NQyH?=
 =?iso-8859-1?Q?v7hWwWcuvEzySk2WHCafBcNHH9OYQyy0HOCLuro+mRjsvsnSlVmi/+yhY9?=
 =?iso-8859-1?Q?YBJThUO4eYpYG8NpevmJdhK4LAOqaj4eEHVw7mj8qPVDY6id3JMlbiGTWc?=
 =?iso-8859-1?Q?ewY7QTqovrwMVlpJ9joDSC0aRNWtGm0f4tW1ZkHKHXjQTS41EPzetvuvWP?=
 =?iso-8859-1?Q?qIdF/cgAEJzdHKrh6I5LtIOdqLD4JmL3dFkJqw1WZkaSgg5IE3yX1Pzut1?=
 =?iso-8859-1?Q?aTdgwE4DMAZLZDGz6gRzQUI1smiAJkdsZsExl1FC4SyWkqDnHTlonZ1N1x?=
 =?iso-8859-1?Q?JNocFoZtU+NmwndBPikwhI/T1Fy4eDBz+dybdiNwmTeQn8LsxOiNr1L8WQ?=
 =?iso-8859-1?Q?NfHf/FeRjzaxVyve1JK+XxKBGIdMN3cSCta2+pLSTJ2vqt6Qyp2EBIRsF/?=
 =?iso-8859-1?Q?wUl0F1vljmhVy1+63o5XdgegrFUhaeVAS4sEaEa/8MmCLPpRpOoqtTKl5O?=
 =?iso-8859-1?Q?FhfgSridtWmOHigN+8vgmdv4eQEwT058U2OwnFBPW8+NypwLEyj2SpQikd?=
 =?iso-8859-1?Q?3Mg6LUIy15xvrVy69jIDLeTAxePbXGZsNbfq81YqHsHNCecf7h+sMeyae8?=
 =?iso-8859-1?Q?d65XJi1rTFtSelpXz0P43baT3TdJuaEILqdCvEcEU9ir0aLWRj40FhsHFw?=
 =?iso-8859-1?Q?S4s4ZsFW+YHoK+0zkG0+IwvvZVGWUVy/g7J8oCb/aL5J5JmW9SShx6zfGA?=
 =?iso-8859-1?Q?L3nMgbNR1oPp2aKZT6De7bamX+jpjj/0FUXkfSwqw=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3657D7B3FC1D63D7AE8B05B9F5660@DB3PR0402MB3657.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(376002)(366004)(346002)(396003)(39860400002)(199004)(189003)(54534003)(6436002)(486006)(6486002)(106356001)(478600001)(2616005)(53936002)(476003)(26005)(25786009)(52116002)(105586002)(14454004)(2201001)(4326008)(186003)(8676002)(8936002)(50226002)(99286004)(256004)(81166006)(110136005)(86362001)(14444005)(81156014)(316002)(305945005)(7736002)(68736007)(6512007)(6116002)(3846002)(386003)(71190400001)(102836004)(6506007)(71200400001)(2906002)(36756003)(7416002)(66066001)(97736004)(2501003)(921003)(32563001)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3657;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KpSThe+fNZCcDME3xmBUCBzymDHUVUVMFxeSRwEmMDiabD0pm3p9fV2v2If7wj4V4Qnv2nvGibd9gDeukdw7bZwPuYTHSjAuwNDoA2RttOiDf9JY7FCJaTRny687RAd6gZftvnW3JEbys466Irwwb/7qRQjrP7BKJf1suhr0iVnjfq0z0+Dg140B18i5Txyr2//HAsP85lUQiw6ru/1Q6ORCMQUzH6fdPwovCMzL/CkIwAv4jI7YX+sYD1jDRPmHsNWHss5yZ3NAPW2Evh/4TyGxkwdi1hyAXEJzPlJYO5pA6ag2I4HuW1zC4BDAenmv0dbWvxD14iv6pVT3g4JUkdPXeOJRIWMHR0a2eRQ/tuL5Fx8qo2BaX4QjDDh78T2Ge91PZbA9G/UuVwRQgqVik3ou/mjRrD2E4Zgo2WrCAaY=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 008f6d53-a053-4309-f0fb-08d691b7abe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 13:32:11.8080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3657
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_053232_193766_432D1EFD 
X-CRM114-Status: GOOD (  10.32  )
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
ChangeLog since V1:
	use operating-points-v2 for OPP table to better fit cpufreq-dt driver;
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 4c3dd95..1e08387 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -34,6 +34,10 @@
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&A35_L2>;
+			clocks = <&clk IMX_A35_CLK>;
+			clock-latency = <61036>;
+			#cooling-cells = <2>;
+			operating-points-v2 = <&a35_0_opp_table>;
 		};
 
 		A35_1: cpu@1 {
@@ -42,6 +46,7 @@
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			next-level-cache = <&A35_L2>;
+			operating-points-v2 = <&a35_0_opp_table>;
 		};
 
 		A35_2: cpu@2 {
@@ -50,6 +55,7 @@
 			reg = <0x0 0x2>;
 			enable-method = "psci";
 			next-level-cache = <&A35_L2>;
+			operating-points-v2 = <&a35_0_opp_table>;
 		};
 
 		A35_3: cpu@3 {
@@ -58,6 +64,7 @@
 			reg = <0x0 0x3>;
 			enable-method = "psci";
 			next-level-cache = <&A35_L2>;
+			operating-points-v2 = <&a35_0_opp_table>;
 		};
 
 		A35_L2: l2-cache0 {
@@ -65,6 +72,24 @@
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
