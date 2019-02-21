Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA99EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:26:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A85E82083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kP3ZxvRM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Iw17uOPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A85E82083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Clspg5S1BwCNTB5vsV9qvuFJ5ZHq7DeutOt9Dbp9n/M=; b=kP3ZxvRMxBGhbd
	QpCqR9tO5RZMO3MNb0yHxqOClVNwi4/Torivp8bUmD87J+MjviOYFLMv+khYJoG636itymkeVFsmH
	bg+sBT8mxnKR80EV7bXd0ErIpqZvnHrrRRFO/grn50ufmGzNAqN15macO9tMQv8UhIZwZ9O5ezw+o
	rUrO+umXOONKSMmHKZMn8x9GK0yvWF2Yek6zwqFWhGFY9OOl1ckKXUx0JeQIFi1JO754lSgq+8nBG
	WFbLs6/kE2WMGB4vtGLGqDka8s1Zc3H0AyiLSyYXTgicstC2p6pV4TmutyyOF47OWOLj3Pq8LGjOg
	wQCoQxSgARlFCm9aQwEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwt3M-0001kP-VS; Thu, 21 Feb 2019 18:26:36 +0000
Received: from mail-eopbgr10066.outbound.protection.outlook.com ([40.107.1.66]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwt2H-0007AG-Tc
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 18:25:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZZGrKu5025olm4u3V6e7w6gCpQcTSk0BLbSRooVh7Q=;
 b=Iw17uOPT5Un9FC0dR8wc37XbwC0r1SNzw4xb32LeapsFNkcIIbk8PvPMZ3EFWqbpaK6yORY3G4umUO1JwgyfyVF1yfH89mVOWOj60U8a2mfPs2h7xnCR5dqddDPPp3+eOBOpj7a4qFl9elU7HvAfQrQokyAd74HqW/jtMVEdRSo=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB4846.eurprd04.prod.outlook.com (20.177.49.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Thu, 21 Feb 2019 18:25:13 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 18:25:13 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 06/14] arm64: dts: imx8: add conn lpcg clocks
Thread-Topic: [PATCH 06/14] arm64: dts: imx8: add conn lpcg clocks
Thread-Index: AQHUyhLJfhYJrFh22EaWIZwHCl+AYA==
Date: Thu, 21 Feb 2019 18:25:13 +0000
Message-ID: <1550773093-13349-7-git-send-email-aisheng.dong@nxp.com>
References: <1550773093-13349-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1550773093-13349-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0051.apcprd03.prod.outlook.com
 (2603:1096:202:17::21) To VI1PR04MB4222.eurprd04.prod.outlook.com
 (2603:10a6:803:3e::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a34b0e95-ee1f-40a4-04ac-08d69829eb81
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4846; 
x-ms-traffictypediagnostic: VI1PR04MB4846:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB4846;
 23:0v94JPved6adfD+aQA8H5YRnPvRQR9QA/Lx+aWt?=
 =?iso-8859-1?Q?QoHEjf5NQUgRMBMQoRGIxm+C3L/247rvrLl25i089VLWe4dfRo07YZXVX2?=
 =?iso-8859-1?Q?Xupu6veKVhdGGuaQB6haBB5v6ptMOa41CLFj1gCMGgj20hkuUGHfi47n9f?=
 =?iso-8859-1?Q?pAd1J3biLqk2Ud4DBpOW5ruuZ8yWnxr9m2iw0kja3TTEdOg8yS24qS32+T?=
 =?iso-8859-1?Q?pSzTqK2qmz+nMAk5HeuEaSYn9aJaFo8Kcyfk9Pl/uIOLhUv2W/WUFWM/z6?=
 =?iso-8859-1?Q?lun+AKw+/sD3a85ner9BsxyIUfgyU9DzYYTHEE/4pwqgV/afZ9c5Clm5nw?=
 =?iso-8859-1?Q?v8djr9UbrK5jv+ZMCSUeIp0d/ypqJvlhgJEhbAjFYIORwb7NJ2vH/TEeKk?=
 =?iso-8859-1?Q?3xwPDfys5G9wWIayOppw2qMvsIlTYInRpckvUu2ogxMnh3LQf4T1tSTfKL?=
 =?iso-8859-1?Q?WIVAcSGdPY3VH2IT6G0ON12JqLZqGvClWft84r+taRgj5B/RSsbqh96NCU?=
 =?iso-8859-1?Q?d4MDfmwCR72MzHhINdgEnBQouO3g+2wSBu5xba96e527OcqG8iarfaP5MG?=
 =?iso-8859-1?Q?9m3y0nv7EhKaAylnnuFkV7fUabVPR/gks1tbdvjfW+w399/K2LIZMe47yx?=
 =?iso-8859-1?Q?GISFpmoDtkez5Udq0hLMtTdSEi048PZkP8dLvqMS8AYaKkDiU2FcyHKwQh?=
 =?iso-8859-1?Q?rRfnQoBKQ2ARSvYQqC25xTYZ++y5ngNMv4a2IDPentfMsnpzpjcaV4/fhb?=
 =?iso-8859-1?Q?mMSh5O9Fl/XArtj57qf/2h5zgnfQ/Im9Uuov8YcD3FxKgCSbXXCLv+Okm3?=
 =?iso-8859-1?Q?2LsPNXCMhFAHGx5v7GtAhXG1T2trzPmuueUDltQcxMdVRGB+nwpbacnZVf?=
 =?iso-8859-1?Q?nkayajdoyA8esMp++PHb3VMhzhoh9ED/I686VWA/Q/VcIeQmxa7qoq5q01?=
 =?iso-8859-1?Q?BqKfn/gNn9Z4/PzxI8c172FwQIqSV8IgqxxSCZjfZKWW8F1gzCLQvU8M3G?=
 =?iso-8859-1?Q?ch+Qw5bO03JrBH93C5809H4Bjl8P6qpfRzHXNLlNZoOUh8yCtgNJToxKhY?=
 =?iso-8859-1?Q?Gb8TJ8YQb6kRFWDasCr3nCTqRGf2eLlRA3Q5KMVFIWe/D6mhEj6ikdswgS?=
 =?iso-8859-1?Q?F00bTb9OkE/8F2MFpep8ryGsXlcbE00YtFFZjCSH3vwzP9ttM2HTmDEB9b?=
 =?iso-8859-1?Q?pS7XqPRR4rP/MVG/LHAI9rNhihIPDDQsqEFY/P8ghzApimaXQWYSfu26c6?=
 =?iso-8859-1?Q?w1I+tPlRBchOZqV8QHymyt1QHeaEhxzPJMo6AJwXhkww0S+D6hSlnSAm3e?=
 =?iso-8859-1?Q?U+WRDhywwR6r2rtA2gOJoxNFnBSgQdBbue8a2l+xWayHg=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB484682BD06E3BC98F94EE283807E0@VI1PR04MB4846.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(136003)(346002)(39860400002)(366004)(199004)(189003)(7736002)(2351001)(66066001)(5640700003)(6436002)(25786009)(44832011)(2906002)(486006)(6486002)(53936002)(99286004)(11346002)(52116002)(76176011)(6506007)(97736004)(6512007)(2616005)(476003)(106356001)(446003)(305945005)(4326008)(14444005)(386003)(105586002)(186003)(26005)(478600001)(256004)(86362001)(316002)(102836004)(2501003)(68736007)(6916009)(81166006)(71200400001)(36756003)(8676002)(3846002)(6116002)(50226002)(81156014)(71190400001)(5660300002)(8936002)(54906003)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4846;
 H:VI1PR04MB4222.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U2cjuH8Xumj4su0x0CLLa0VvQ8VwJSnp+C8ree+Af1g0Pn6MCaqknWFe+B/jXQj8QXbTUeFjLVNnJRBVcnqrGtp/M41jqat2y2Z/bnipmEZlFyYoyo60mmKYvrZNlY+dkrrXp9LHzquMwtLE7f7cRyVxcMH+/MVgjeTMzyWzLrTOemRn8opn5k6G8Nr237byHcTelpR1qdPQYhC/Th7BMSD10xifxvd1uaHOfc7uDHYS0vxUJPR1wnUTHpJEtwMePkKFLcwE+w4t77kjBq4KHYacl6mVf5nWFBb87bq/SLuL08gMlFKd3UnP27JoT49IvtVa0TFTCeQtzJpQHCfGyXzEae5WbujaK1MTAQs5vzrAGF/0w0hdrO9RKYV3+YoML+8ctHWkzy64290EsKkKU5dqyOKOrqOn4t/vVWGKpjk=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34b0e95-ee1f-40a4-04ac-08d69829eb81
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 18:25:09.4209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4846
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_102530_714838_DB0B875F 
X-CRM114-Status: GOOD (  12.59  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add conn lpcg clocks

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi | 59 ++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index 0765cb2..33a3584 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -132,7 +132,64 @@ conn_subsys: bus@5b000000 {
 		clock-output-names = "usb3_lpm_aclk";
 	};
 
-	conn_lpcg: clock-controller@5b200000 {
+	/* LPCG clocks */
+	sdhc0_lpcg: clock-controller@5b200000 {
+		reg = <0x5b200000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&sdhc0_clk>, <&conn_ipg_clk>, <&conn_axi_clk>;
+		bit-offset = <0 16 20>;
+		clock-output-names = "sdhc0_lpcg_per_clk",
+				     "sdhc0_lpcg_ipg_clk",
+				     "sdhc0_lpcg_ahb_clk";
+	};
+
+	sdhc1_lpcg: clock-controller@5b210000 {
+		reg = <0x5b210000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&sdhc1_clk>, <&conn_ipg_clk>, <&conn_axi_clk>;
+		bit-offset = <0 16 20>;
+		clock-output-names = "sdhc1_lpcg_per_clk",
+				     "sdhc1_lpcg_ipg_clk",
+				     "sdhc1_lpcg_ahb_clk";
+	};
+
+	sdhc2_lpcg: clock-controller@5b220000 {
+		reg = <0x5b220000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&sdhc2_clk>, <&conn_ipg_clk>, <&conn_axi_clk>;
+		bit-offset = <0 16 20>;
+		clock-output-names = "sdhc2_lpcg_per_clk",
+				     "sdhc2_lpcg_ipg_clk",
+				     "sdhc2_lpcg_ahb_clk";
+	};
+
+	enet0_lpcg: clock-controller@5b230000 {
+		reg = <0x5b230000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&enet0_clk>, <&enet0_clk>, <&conn_axi_clk>,
+			 <&conn_ipg_clk>, <&conn_ipg_clk>;
+		bit-offset = <0 4 8 16 20>;
+		clock-output-names = "enet0_ipg_root_clk",
+				     "enet0_tx_clk",
+				     "enet0_ahb_clk",
+				     "enet0_ipg_clk",
+				     "enet0_ipg_s_clk";
+	};
+
+	enet1_lpcg: clock-controller@5b240000 {
+		reg = <0x5b240000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&enet1_clk>, <&enet1_clk>, <&conn_axi_clk>,
+			 <&conn_ipg_clk>, <&conn_ipg_clk>;
+		bit-offset = <0 4 8 16 20>;
+		clock-output-names = "enet1_ipg_root_clk",
+				     "enet1_tx_clk",
+				     "enet1_ahb_clk",
+				     "enet1_ipg_clk",
+				     "enet1_ipg_s_clk";
+	};
+
+	conn_lpcg: clock-controller-legacy@5b200000 {
 		reg = <0x5b200000 0xb0000>;
 		#clock-cells = <1>;
 	};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
