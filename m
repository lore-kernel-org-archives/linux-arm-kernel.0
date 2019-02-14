Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC783C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:03:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6F96222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UHPkqGK0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hRW6AJUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F96222A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JTsCpDLX2h1Eqdg2lyBeY/QIRFdgMwDz+3dd/yBNrnk=; b=UHPkqGK0nxuYF5
	i2aB17jdoNwfCM8Cg5ZoLN8nMWletptSgeVzGE9K1mzNmUl9BCihpIy4PKYocg1Q/b1yvbVxg1P7U
	kQITrEoHz6oXsFjOfkpZEPLII6EwIVgMENLfoxzDZjguE3HnVLlTcppVJV0WN0gBicn46iUnONSqM
	94Ji59m3HHIOLnhcxBBffcg8um4mofvnymITF74aA4GY0pBB9ssczvd2Ju1pciQO/X6azpUffyGWl
	gywNStqKvVmMHcrvYbR+42jAOHHrWO2cAptnTGN4ZhBTvjdhYeBqwvekymnjATEUDgd1DGSiIISBc
	IDs2ne4tvLhv7m7DiJMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guBz2-00073y-1l; Thu, 14 Feb 2019 08:03:00 +0000
Received: from mail-db5eur01on0626.outbound.protection.outlook.com
 ([2a01:111:f400:fe02::626]
 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guByx-00073P-Qq
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 08:02:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqJaJvdeE+4hT+VaB9T3/XPm2pYhcHOuY8fRiGt/6NY=;
 b=hRW6AJUDnVfxm0+PcfcHw+rNPOwNzBQxcCEOG2+j5HlGNFgZkYjoKrB/qrPvz4mFwxIKlDgfqkfbL8QfTOXauMq32GvUB8Yl05YqOoipo8LgzHyQIp86IKJGBODBRc7xMOmcmVKFweUhPH9ItN9uHLxMtBnU32F75jmgZaS1BZE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3881.eurprd04.prod.outlook.com (52.134.73.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 14 Feb 2019 08:02:51 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 08:02:51 +0000
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
Subject: [PATCH V5 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Thread-Topic: [PATCH V5 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Thread-Index: AQHUxDuuhaCLw8pC3kmWnqf7p/Ku5w==
Date: Thu, 14 Feb 2019 08:02:51 +0000
Message-ID: <1550131046-2069-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0202.apcprd02.prod.outlook.com
 (2603:1096:201:20::14) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72e178b7-29c1-4bb5-588c-08d69252d0c5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3881; 
x-ms-traffictypediagnostic: DB3PR0402MB3881:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; DB3PR0402MB3881;
 23:yflqBq1HmDbSsIogpCi0plDHEhoJ+Uoc3mOvP?=
 =?iso-8859-1?Q?uQot1KnrMECvJ+b3lX8qaGjyB0CU9pq6bwB4xvkcVmLC2dRmM/gLCQrt84?=
 =?iso-8859-1?Q?4HpGzRD+6tzKyxmQ54OKXj22sNP3EYO2cd6Th7ok6GWHSIbS0bLb03rEEh?=
 =?iso-8859-1?Q?HD8yOKV4plSdj0oXE29fNvEcYYR2i6Quonxehdi3j7Sz+6qEM6EUtUjnVW?=
 =?iso-8859-1?Q?aDcTWgIMlZHlJ3iHOIpmDH1IH+D99iIfUCsZimt+bGLHILzfy8f2HpG5S/?=
 =?iso-8859-1?Q?VofFsdm9Jc1uXflXwKrj6sdpzSaVc0wlxyESBxwD9C7W08zVej0RpNSpOF?=
 =?iso-8859-1?Q?cV7XXtwU69LKrTYaFmfwPDnZmhjgfK8v0rURJWFhxnbftX5yN8paXVR9Ar?=
 =?iso-8859-1?Q?pIHs0xeRfG7Im93a9og12sOjHUkl2bvR5z4mlniXADhv6fQLPxXiTzmacc?=
 =?iso-8859-1?Q?NO8Um2xqpEG6C6d//+wJ+9oT5Jzd+9FTN3C048FrcPUsnlTXBzpjDlg71m?=
 =?iso-8859-1?Q?nY61EdO7OzUNNmfKZOSNlkbNLDaPfMvWw3SU/I67RxS6Ay+MRr4LuYNGAi?=
 =?iso-8859-1?Q?kEh2JNzXs3LpOClWGCLkGM3qZ15Ve6ezWew08B0WPCOFCc3WuAYIH9LIAb?=
 =?iso-8859-1?Q?7DALCLND5IWXYTRxckMGJiv8J3e2aPANfpzeSa3TgGXxfgQUB4uAwAyWZb?=
 =?iso-8859-1?Q?wheraDba+rmTDRGLZKWFjnJdxjSIoUaGZGpFuFIfxgWQ2fPE9kzzYEzamH?=
 =?iso-8859-1?Q?Mfa4U77pSAkwa4AUvxjceE24XZg9MVfeBNafMZ9UYvSgH6prPJIdHL1BAM?=
 =?iso-8859-1?Q?Xf+WB88ohK6Gv8NjbSnKHU71AwdfdUmIHwH2UU2KpkZAWnSpnFyqTVp7vQ?=
 =?iso-8859-1?Q?iEMbrjJldDjF8qs/UQyEkLA6hI3Tqc9kL2r890qxSh5iU0o5/WlZDaOoML?=
 =?iso-8859-1?Q?bv0tBhkqH06mELbBrg1VKi0EL7aCl13cYpTChHoF8LBK1cbKCHMGOIfDv7?=
 =?iso-8859-1?Q?A2tYRDMk/9R8GcMEMzOJe7JzzzJFVJPEoi1NUYWkhkXxc8Coxn1yQt0hSY?=
 =?iso-8859-1?Q?hz9QCMjYJ0+6z7EmzEtD/ztOZEhocphyNeywQalAvIs/+xthQ86nF7xBYn?=
 =?iso-8859-1?Q?1CY/J8PlZJ/WzGF3hxdXv3qmyg18v4OUZR4YlkXw6mHHsXiwy+JuZt6J4V?=
 =?iso-8859-1?Q?Kgdm0H3Ax4YAS+doPbqYGRKTt2BDzQRow0g/r/B1txyjhGj6UXdPwFfUX6?=
 =?iso-8859-1?Q?frQ1CdMlxIQKefvkUUo?=
x-microsoft-antispam-prvs: <DB3PR0402MB388195045F2AA1120DE6A20BF5670@DB3PR0402MB3881.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(25786009)(2201001)(50226002)(71200400001)(71190400001)(81166006)(3846002)(305945005)(97736004)(68736007)(105586002)(106356001)(6116002)(86362001)(8936002)(486006)(4326008)(81156014)(2616005)(7416002)(8676002)(476003)(36756003)(6512007)(99286004)(2501003)(52116002)(14444005)(256004)(53936002)(2906002)(478600001)(186003)(7736002)(386003)(6506007)(26005)(102836004)(6486002)(14454004)(6436002)(110136005)(316002)(66066001)(32563001)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3881;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DLKUjKYdBZht/rZ8eiX9W27q2xs0nE3+Ef8OH+GZCpb7yuYssp8MLNKiZsc7HjwksabR+aduIreEMWtAN1CiLbdQZdeOas1knFeHFRI8uaCBDpjuMU4SSVTkE/Ozuw7KHKEJBFmX/cB4FQgkNjx3dMpJf4GyWZYs+2O2yScc22yzMkzDxpiWZjplpV4WZZuvaPNKmPieDZPYMl6tnsQgzrwjfYEzPh2VTTs3mBOpLLQOf8L6SYOH+4J8a5mGXh1NF/AMHMsIhLw765FUrT3/M/u6j+Uv0lRKqN/El0F8NdJFoNAvV7NOxNTgeN1d0jj6Z5MKl6mLZykjvZCEtOZ8TS7l9v/hb5G+mjI2XW5kNpxE/OcAQDvM1d0TsTCD1iPz2dnvS7St0877zwjlJafhbPP/4cveIVAkcsuDQo+CBtk=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e178b7-29c1-4bb5-588c-08d69252d0c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 08:02:45.7456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3881
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_000255_875528_87621DC8 
X-CRM114-Status: UNSURE (   9.93  )
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
Changes since V4:
	- remove redundant clock-latency property in A35_0;
	- add #cooling-cells for all A35 core.
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 4021f25..fad1259 100644
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
@@ -42,6 +45,8 @@
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			next-level-cache = <&A35_L2>;
+			operating-points-v2 = <&a35_0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		A35_2: cpu@2 {
@@ -50,6 +55,8 @@
 			reg = <0x0 0x2>;
 			enable-method = "psci";
 			next-level-cache = <&A35_L2>;
+			operating-points-v2 = <&a35_0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		A35_3: cpu@3 {
@@ -58,6 +65,8 @@
 			reg = <0x0 0x3>;
 			enable-method = "psci";
 			next-level-cache = <&A35_L2>;
+			operating-points-v2 = <&a35_0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		A35_L2: l2-cache0 {
@@ -65,6 +74,24 @@
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
