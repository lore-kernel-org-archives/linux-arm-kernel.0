Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC7AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:26:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 826692084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L0O4tP8C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d90oCgr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826692084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7Ts2M8vUvd5AVdUTLC0iTZUvFk5QP0z4RJSqspXzb+Q=; b=L0O4tP8CH1vOKV
	pWzDzfbDUTFt+96EKT6xUUzvDFf6GPykc9m0rj4xaCwtZ7tMIFEzIbiFBPQV2tYdob60RpFmWNm+F
	0oAweRYRuSwf+zzVmtzvUwZ+PiB209SUdYG3W7n+yux4k21MHNe2qiEIWN/wmpEBy0fuRu8M18j/q
	fysIBComJWyN0BjpweZidFrXnKFfJ2niiOWSinPlGu17i8DNstTt1bNQgWPpD9LiIS351vZnNZ1UX
	h/SYap/l9peWiro4qsahpfQcHhSgVY7obj0OzseoMuKnHaAKEjegitnqyrGJK831PUKgM9+IIu8Dw
	sVt6uxoHPBj0JoN9ViPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwt2z-0001GY-VU; Thu, 21 Feb 2019 18:26:13 +0000
Received: from mail-eopbgr10066.outbound.protection.outlook.com ([40.107.1.66]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwt2B-0007AG-IB
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 18:25:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+N670Bxk3Ov1g2JGZgy5kOVGymiHt1Nokz2rT0WpsE=;
 b=d90oCgr6Rh5MjJz4/lChccAWqdAByZYQgn+s9HX4xkC0+e1HYPL38qZWonxVQkTX+Ttlx6FX1wo5ZgxmYV9ZGpROWjGGSJJm02xpZgA4FwAvpGSt156c/5Yq8qiRerfg0vu0mXXSmSb1Vp03xg64OaMZGrvXRO8TLNmz7KtkkLo=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB4846.eurprd04.prod.outlook.com (20.177.49.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Thu, 21 Feb 2019 18:25:09 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 18:25:09 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 05/14] arm64: dts: imx8: add lsio lpcg clocks
Thread-Topic: [PATCH 05/14] arm64: dts: imx8: add lsio lpcg clocks
Thread-Index: AQHUyhLGXx12pwiMDkm+a9JSq80mKw==
Date: Thu, 21 Feb 2019 18:25:09 +0000
Message-ID: <1550773093-13349-6-git-send-email-aisheng.dong@nxp.com>
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
x-ms-office365-filtering-correlation-id: cda4ca95-80ac-4651-73d2-08d69829e8f7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4846; 
x-ms-traffictypediagnostic: VI1PR04MB4846:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB4846;
 23:V74nLIB3AN0p1YJSvFSc5Egt/zmoD1hM+v79gAw?=
 =?iso-8859-1?Q?xmZXgSncmwrqtYl6a7CIRByp3Wh6KSaB/y0RJH3cXZtAv/nwajqV8hmuZf?=
 =?iso-8859-1?Q?FLdloa1hdL8SrbI2peOUpSY5FHCBHkUr2SFCuhIhfTzPgwf67hXXm4Kj/r?=
 =?iso-8859-1?Q?2el/Fn6RTgwiSfsIkc0F/lHwVr5aPLQj+C3Sd5rZLjqJ67rXkWMI8ZwJ/1?=
 =?iso-8859-1?Q?dDp/BYqOzb7euAfCOlxwoJKeR1H71V8jsPx5MLuDPJUqsbihhWNpNm461e?=
 =?iso-8859-1?Q?zI1AP/eJmm2i6BLx96DvVbkwEOQbrDbds4/F6ITnnEq0vhlBk2t0rvYQ7F?=
 =?iso-8859-1?Q?fGaNumIrG39EyqGzs4kei6i1nptxmAAQEfxrtjJeTVVkg1Urfz+GUvgEjM?=
 =?iso-8859-1?Q?8w6obtH3mIhhFvm5sHZmHswKkAapPbCTy7kI8RUGKWZTvNXD/z8+juBp6w?=
 =?iso-8859-1?Q?lX0SJe5ifMjs0Z4Bd1gGVVIHy+R0u9yiM4lJ2lvjUKDyloS7T1ghlvUJKl?=
 =?iso-8859-1?Q?eweiCsXFY140saPU2dR/FLxfRfaVgSnZx9763txG37pQM6P4b6GgTElNY3?=
 =?iso-8859-1?Q?C0pysxv/fFmmyZskFGEX6R02BnK3//8Y/DsWQelvNVxFxkHF+73T/ucDLO?=
 =?iso-8859-1?Q?JTyw/eG5h18/J5Nad7TrIceshAi5nVNVXkjHG7DNc1t4Xh4CLpyy4bY7sT?=
 =?iso-8859-1?Q?VGHSxZYaXCd6BlZsrB6Afbwy9RivnMvfD16JNWPDjyg1QL7Aa+PcL2Tc7Q?=
 =?iso-8859-1?Q?ob/+NzufoGG3f/04OzMCG5Eif8Gby1jQnbOrhaw3JK/z2SVcxkv2sA1lAN?=
 =?iso-8859-1?Q?n18/LrGOWp+7I2wBvb2HVr3got2C1WbSqXl0FHL7M9P+11tJcO5KDjfAJH?=
 =?iso-8859-1?Q?bnETpfxxeVzh19r86ANx5SBZqUZ+jU4DOadjffFJJqW4pCC8ww0smAymtG?=
 =?iso-8859-1?Q?eLE9iEuRQzIVaqO0bY+YIEqXKo1a2KTMPh4uW2oQnlgOROZPY83QGmHSYE?=
 =?iso-8859-1?Q?kxJN31JsE+qyZpgWenRkFJIiTmp0e5PJiuH6r3cEM8hdO3YG3s8d5UBJEu?=
 =?iso-8859-1?Q?U8JM3PwK7rrO9XaCwRmDHEzLj5g963K8cSgpxk7jDWvDyqofQlDOfphd5i?=
 =?iso-8859-1?Q?MV1Sq7s6Eo1nfkuT4HRBDMp8uGOXnMMUjXznYJLoxP1iy2fA3d7LhZwHwE?=
 =?iso-8859-1?Q?65xgxPRAN5VGL8Hw/biqIWBd3Vj7Yp8TwtkGtII7hLr7+Frm0wTO8T7Hvd?=
 =?iso-8859-1?Q?uwQavsfiHmEJsJDcNVHUncl+ZpHFKFAcfdK2mUkSu/Ln2EPG4HHnUBG0fR?=
 =?iso-8859-1?Q?TfoH0YPVXKWe6YAZLo1+t6BXUlDjkKqXZSMK3xg+VkJaA=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB4846B7060C4E5058539976A4807E0@VI1PR04MB4846.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(136003)(346002)(39860400002)(366004)(199004)(189003)(7736002)(2351001)(66066001)(5640700003)(6436002)(25786009)(44832011)(2906002)(486006)(6486002)(53936002)(99286004)(11346002)(52116002)(76176011)(6506007)(97736004)(6512007)(2616005)(476003)(106356001)(446003)(305945005)(4326008)(14444005)(386003)(105586002)(186003)(26005)(478600001)(256004)(86362001)(316002)(102836004)(2501003)(68736007)(6916009)(81166006)(71200400001)(36756003)(8676002)(3846002)(6116002)(50226002)(81156014)(71190400001)(5660300002)(8936002)(54906003)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4846;
 H:VI1PR04MB4222.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hVK1h5qEzMCUC+gvWnxwcN6bpcSFAd/k2/ZYxLQMdqV4iclvbJgLf/XeBTH4Q/WmHwFt5aHk19fgkb/LXd+6WljGxsogsJgEZ8IIWz0cIfVNparHGIlyunG+IevrB1Q4nUgB4I42HgMoxsZgFek2j+50T8nsjiQuGYEUMOXBHY0FEhETfdRql03es4FK+1HBkygEDuv0pdCRXBOQwKjiTTWZoSw1WD3c9MPDC1k9IgPsNE9TLBcXuMrYb6ex3VJuj6mSPSvh4huv4bUyB3dokAvKbuCyKVYbQaPD06cmi4TdDlUS2ugWzYpFidL5e60AW2bH+iStuCJzbuxm6Pfo/lCHy1zdA/rrey+1vsRkqPRKee2QRiZ6TSPeTWydxqQjaqoMlo423J1my69PUKLUA0XgtBFBwEqZsBfBk9sHUdQ=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda4ca95-80ac-4651-73d2-08d69829e8f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 18:25:05.1659 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4846
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_102523_893103_8B845F6B 
X-CRM114-Status: GOOD (  12.60  )
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

Add lsio lpcg clocks

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi | 107 +++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
index 5c4c2fb..cf9223d 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
@@ -132,7 +132,112 @@ lsio_subsys: bus@5d000000 {
 		clock-output-names = "pwm7_clk";
 	};
 
-	lsio_lpcg: clock-controller@5d400000 {
+	/* LPCG clocks */
+	pwm0_lpcg: clock-controller@5d400000 {
+		reg = <0x5d400000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&pwm0_clk>, <&pwm0_clk>, <&pwm0_clk>,
+			 <&lsio_bus_clk>, <&pwm0_clk>;
+		bit-offset = <0 4 16 20 24>;
+		clock-output-names = "pwm0_lpcg_ipg_clk",
+				     "pwm0_lpcg_ipg_hf_clk",
+				     "pwm0_lpcg_ipg_s_clk",
+				     "pwm0_lpcg_ipg_slv_clk",
+				     "pwm0_lpcg_ipg_mstr_clk";
+	};
+
+	pwm1_lpcg: clock-controller@5d410000 {
+		reg = <0x5d410000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&pwm1_clk>, <&pwm1_clk>, <&pwm1_clk>,
+			 <&lsio_bus_clk>, <&pwm1_clk>;
+		bit-offset = <0 4 16 20 24>;
+		clock-output-names = "pwm1_lpcg_ipg_clk",
+				     "pwm1_lpcg_ipg_hf_clk",
+				     "pwm1_lpcg_ipg_s_clk",
+				     "pwm1_lpcg_ipg_slv_clk",
+				     "pwm1_lpcg_ipg_mstr_clk";
+	};
+
+	pwm2_lpcg: clock-controller@5d420000 {
+		reg = <0x5d420000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&pwm2_clk>, <&pwm2_clk>, <&pwm2_clk>,
+			 <&lsio_bus_clk>, <&pwm2_clk>;
+		bit-offset = <0 4 16 20 24>;
+		clock-output-names = "pwm2_lpcg_ipg_clk",
+				     "pwm2_lpcg_ipg_hf_clk",
+				     "pwm2_lpcg_ipg_s_clk",
+				     "pwm2_lpcg_ipg_slv_clk",
+				     "pwm2_lpcg_ipg_mstr_clk";
+	};
+
+	pwm3_lpcg: clock-controller@5d430000 {
+		reg = <0x5d430000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&pwm3_clk>, <&pwm3_clk>, <&pwm3_clk>,
+			 <&lsio_bus_clk>, <&pwm3_clk>;
+		bit-offset = <0 4 16 20 24>;
+		clock-output-names = "pwm3_lpcg_ipg_clk",
+				     "pwm3_lpcg_ipg_hf_clk",
+				     "pwm3_lpcg_ipg_s_clk",
+				     "pwm3_lpcg_ipg_slv_clk",
+				     "pwm3_lpcg_ipg_mstr_clk";
+	};
+
+	pwm4_lpcg: clock-controller@5d440000 {
+		reg = <0x5d440000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&pwm4_clk>, <&pwm4_clk>, <&pwm4_clk>,
+			 <&lsio_bus_clk>, <&pwm4_clk>;
+		bit-offset = <0 4 16 20 24>;
+		clock-output-names = "pwm4_lpcg_ipg_clk",
+				     "pwm4_lpcg_ipg_hf_clk",
+				     "pwm4_lpcg_ipg_s_clk",
+				     "pwm4_lpcg_ipg_slv_clk",
+				     "pwm4_lpcg_ipg_mstr_clk";
+	};
+
+	pwm5_lpcg: clock-controller@5d450000 {
+		reg = <0x5d450000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&pwm5_clk>, <&pwm5_clk>, <&pwm5_clk>,
+			 <&lsio_bus_clk>, <&pwm5_clk>;
+		bit-offset = <0 4 16 20 24>;
+		clock-output-names = "pwm5_lpcg_ipg_clk",
+				     "pwm5_lpcg_ipg_hf_clk",
+				     "pwm5_lpcg_ipg_s_clk",
+				     "pwm5_lpcg_ipg_slv_clk",
+				     "pwm5_lpcg_ipg_mstr_clk";
+	};
+
+	pwm6_lpcg: clock-controller@5d460000 {
+		reg = <0x5d460000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&pwm6_clk>, <&pwm6_clk>, <&pwm6_clk>,
+			 <&lsio_bus_clk>, <&pwm6_clk>;
+		bit-offset = <0 4 16 20 24>;
+		clock-output-names = "pwm6_lpcg_ipg_clk",
+				     "pwm6_lpcg_ipg_hf_clk",
+				     "pwm6_lpcg_ipg_s_clk",
+				     "pwm6_lpcg_ipg_slv_clk",
+				     "pwm6_lpcg_ipg_mstr_clk";
+	};
+
+	pwm7_lpcg: clock-controller@5d470000 {
+		reg = <0x5d470000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&pwm7_clk>, <&pwm7_clk>, <&pwm7_clk>,
+			 <&lsio_bus_clk>, <&pwm7_clk>;
+		bit-offset = <0 4 16 20 24>;
+		clock-output-names = "pwm7_lpcg_ipg_clk",
+				     "pwm7_lpcg_ipg_hf_clk",
+				     "pwm7_lpcg_ipg_s_clk",
+				     "pwm7_lpcg_ipg_slv_clk",
+				     "pwm7_lpcg_ipg_mstr_clk";
+	};
+
+	lsio_lpcg: clock-controller-legacy@5d400000 {
 		reg = <0x5d400000 0x400000>;
 		#clock-cells = <1>;
 	};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
