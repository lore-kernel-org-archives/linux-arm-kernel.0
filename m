Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CED5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:27:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1F792083E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i2DPbRI8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OImsn2+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F792083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lMyFGKgJ0A3CGwXt4giOONg5hzckBmwEU3PLQuPq4zA=; b=i2DPbRI8TBGPyD
	Yc+dPbAwSVbNWPNJnzWu/WhHJdYcD27yJIqM3WoxAcgj6OLnLiIlzYWPfWODZx7zu6Tjzo4FIrUWf
	/oHggXoPJovnthBhw9queo2WaozJMJkocSbtyRNnMrY7A+C/ljk5WHFOoicwW5bdBipQ+qF3Vno4D
	s86Ne6v8KljTNCbTpbt5amRoqeH5jf9uZx4TUA2Pog7/ttiOAX88de9R2fyca2c2f0uOVX7FJR7/y
	s+zIt8MtAzpI/hginIKEheazn/hqHAb/UU0fAS3BydDvNpedaQgdhxv6sAsdBrhqwRQ3wAP9WhB8L
	nHUkDCE4qe2pJ9KT/9hw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwt40-0002Xh-Pc; Thu, 21 Feb 2019 18:27:16 +0000
Received: from mail-eopbgr20046.outbound.protection.outlook.com ([40.107.2.46]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwt2X-0000Km-Cb
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 18:25:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fdbEtPnV92zAUROJj7NUG2j3FLRI798/bQgr7mW0Uk=;
 b=OImsn2+kHSq7Dsk9bQjRXPtlM7gSKd5en+rrU0jm4njm1R6nwI7WMaSrY9NFYvLjLhqDDNgabn0VAXU+GY3oHM5U5IyoNXYVEV03RmyWYp2pHrDCC26tsLZvXCHWyBqnaK8SSaLj6++J0QohzWBpJCUyO5wDwDlkH2k07HChaTw=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB5599.eurprd04.prod.outlook.com (20.178.125.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Thu, 21 Feb 2019 18:25:27 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 18:25:26 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 09/14] arm64: dts: imx8qm: add lsio ss support
Thread-Topic: [PATCH 09/14] arm64: dts: imx8qm: add lsio ss support
Thread-Index: AQHUyhLR2j01ec8330qg1uIxC4/xMQ==
Date: Thu, 21 Feb 2019 18:25:26 +0000
Message-ID: <1550773093-13349-10-git-send-email-aisheng.dong@nxp.com>
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
x-ms-office365-filtering-correlation-id: abf26679-5ae8-4bab-6977-08d69829f350
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5599; 
x-ms-traffictypediagnostic: VI1PR04MB5599:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB5599;
 23:36lhxo45ZX2gvj6VHvtogBVxBUDbbuJYjqnLaW8?=
 =?iso-8859-1?Q?KDVxcioka2f2t2M5JlYwNCi96n3d3+gxckRK0mqzmIv5ZN4kGZ2brC0lDA?=
 =?iso-8859-1?Q?FguMQbFFIjtc5y8I0Ev2Gk8piVF0dIrNhs1jlYMLT07giLGuEpR3iFqQRl?=
 =?iso-8859-1?Q?HEvKplwTrwi1nxzrG8zETrUAmdrpDc7epDHu7UMYvm/zPAzk/OpzFM6KD4?=
 =?iso-8859-1?Q?6PtuxLO3bf7c71TWqFHMiPGjV4Pxm/f8z8XZpM4W0Rcrqvw6sL/+Y0WFPc?=
 =?iso-8859-1?Q?f7fJ9dTL1DGhukADBeFXEAGCayrSyeUT++MkLTqBbBfblLpPsttw2N7A/k?=
 =?iso-8859-1?Q?fWU7B46ovrP3jJwBcYgb+4qwAl8K7aoyFQ4CPyoL+7NuLOXVQUE18j8NKu?=
 =?iso-8859-1?Q?Bu5n36GGfBj6YeRK9VqKn60sihvb5b1PAsi1zaM+3jkBU1mgmaFjUSfoCE?=
 =?iso-8859-1?Q?M5M9ZIUNULbTgx8c9p/cHNoRK+b7Xm9qKJ/VpMXJ85H2WpQwKpi1IFKiWy?=
 =?iso-8859-1?Q?BIgYGMoZhiHeiK+nWtId3I8kYRBzcZjgTTgzSc5cflIdUCOB7Ui/k5/5pa?=
 =?iso-8859-1?Q?Mbx47VOwZfMUn+yjD4Cu70VnOcHNDsB2EwyHH+zbZx4Us4lAYD4Nm+2/JD?=
 =?iso-8859-1?Q?ECK8KEf3dPo31BJ4j7zqrTzvJXthi3F26M2nei9NZkFuiT6uIBMaD1hUey?=
 =?iso-8859-1?Q?XAkT6vJx28pTERGba9CWb+2QwUX3jvCo1+5L9+4jRzBgujsHnLLn3S+JBu?=
 =?iso-8859-1?Q?g6FWpe07Mxrm8p0SwXUYiXY7FZecmZIyKlA7B26Xi+N/XXNgwejEUR8quy?=
 =?iso-8859-1?Q?25vBmf0HYZhD7BqYfBLMmi+emJlzRJZeDB0qdrM/hFHfRSxKYzUY36bZTb?=
 =?iso-8859-1?Q?erfwKlnS25P2wEYJ3VTIAyqrrVmTPPinK0wwqc5eCaMU9x5rQezkd4ZCqs?=
 =?iso-8859-1?Q?emwO04mJsgdppwpz3Dg6SvfnM7JZlj6/pVY200NohUGzRyjlDiQILYLTzE?=
 =?iso-8859-1?Q?L4VpF8dJXiCnfWmc4R5g9/QoeGefQr6bcprP/p2Tc3TbbGq7tZ+Z/4xI5K?=
 =?iso-8859-1?Q?35PLsuPfyPvsU2jHlRjXOoIMzRwUTm81UQqoenHIzARzsgscTqWwXPSAZv?=
 =?iso-8859-1?Q?Shc6lTG+HqLhaEFxuE+9PMQAt6kowOlebcacSIWZTKHsin7NcwMmWK2zxj?=
 =?iso-8859-1?Q?jwGV9+f5zbcKfH+hf1Enow5KqDQVmYCn1gbO8JJxwrghgtaz2zKQaIRW08?=
 =?iso-8859-1?Q?6tb5vTznDIPmU+XqUHQsnFJqw5S5qrpDgzePZbOnWCSip0njE6UiTlbcko?=
 =?iso-8859-1?Q?c6mRLR2OXgaIcRUwYvju79xE4i/JbZmSc3P7vYJVFcxkQ=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB5599B5A6FAF9548BC256E89B807E0@VI1PR04MB5599.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(366004)(39860400002)(346002)(376002)(189003)(199004)(256004)(53936002)(106356001)(71200400001)(71190400001)(81166006)(2351001)(2906002)(6916009)(446003)(105586002)(81156014)(44832011)(316002)(305945005)(97736004)(2616005)(8676002)(54906003)(6512007)(7736002)(2501003)(68736007)(76176011)(386003)(6506007)(3846002)(486006)(14454004)(5640700003)(86362001)(6486002)(52116002)(6436002)(4326008)(8936002)(102836004)(5660300002)(476003)(26005)(99286004)(478600001)(11346002)(6116002)(25786009)(50226002)(186003)(36756003)(66066001)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5599;
 H:VI1PR04MB4222.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8INS9SumSeDvzxij1zy65/BLn8A6cpkstWpa7FMxPYyFMkhjLnnssevxdt3okr+agJ/FZsuLGuiM3MkRvkGtnon3K5gJ0gkJJS+7acMT7p2GscMilRoaGT1CjH4o2aKLXgv2RsjV6EDOckpbyXgDLIxcfTD4EvPES88fncrH+3MVyM+pcfnOXTQOmkPPGFsKObjD0RI6JF0FeRQQAO1jUbCKghvr9lT1WMW3zbG6i6W2xOly+5z02kkUjIBpmYIm/knpaFNT/RGKqe09mAwockYRmN4aKqU1iKrmoNt1ayTuKQI/NEcmqP1+ZE51yaorNEgFsMCwWGeoKm8swYgjAM3zh16ByL2okD/+OtHE5GfQQ5yGsRSJEj6kRIYZfMfeFQpyp7CBeGgHHsUVFZqek56d0kk0aTBvu0Te8q0js80=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf26679-5ae8-4bab-6977-08d69829f350
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 18:25:22.5151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5599
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_102545_532798_09DA2250 
X-CRM114-Status: GOOD (  13.53  )
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

The LSIO SS of MX8QM is exactly the same as MX8QXP. So we can fully
reuse the exist LSIO SS dtsi. Add <soc>-ss-lsio.dtsi with compatible
string updated according to imx8-ss-lsio.dtsi.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi | 145 ++++++++++++++++++++++
 1 file changed, 145 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi
new file mode 100644
index 0000000..9ea772b
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2019 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+&fspi0_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&fspi1_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&gpt0_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&gpt1_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&gpt2_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&gpt3_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&gpt4_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&pwm0_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&pwm1_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&pwm2_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&pwm3_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&pwm4_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&pwm5_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&pwm6_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&pwm7_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&pwm0_lpcg {
+	compatible = "fsl,imx8qm-lpcg", "fsl,imx8qxp-lpcg";
+};
+
+&pwm1_lpcg {
+	compatible = "fsl,imx8qm-lpcg", "fsl,imx8qxp-lpcg";
+};
+
+&pwm2_lpcg {
+	compatible = "fsl,imx8qm-lpcg", "fsl,imx8qxp-lpcg";
+};
+
+&pwm3_lpcg {
+	compatible = "fsl,imx8qm-lpcg", "fsl,imx8qxp-lpcg";
+};
+
+&pwm4_lpcg {
+	compatible = "fsl,imx8qm-lpcg", "fsl,imx8qxp-lpcg";
+};
+
+&pwm5_lpcg {
+	compatible = "fsl,imx8qm-lpcg", "fsl,imx8qxp-lpcg";
+};
+
+&pwm6_lpcg {
+	compatible = "fsl,imx8qm-lpcg", "fsl,imx8qxp-lpcg";
+};
+
+&pwm7_lpcg {
+	compatible = "fsl,imx8qm-lpcg", "fsl,imx8qxp-lpcg";
+};
+
+&lsio_mu0 {
+	compatible = "fsl,imx8m-mu", "fsl,imx6sx-mu";
+};
+
+&lsio_mu1 {
+	compatible = "fsl,imx8qm-mu", "fsl,imx6sx-mu";
+};
+
+&lsio_mu3 {
+	compatible = "fsl,imx8qm-mu", "fsl,imx6sx-mu";
+};
+
+&lsio_mu4 {
+	compatible = "fsl,imx8qm-mu", "fsl,imx6sx-mu";
+};
+
+&lsio_gpio0 {
+	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio1 {
+	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio2 {
+	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio3 {
+	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio4 {
+	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio5 {
+	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio6 {
+	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+};
+
+&lsio_gpio7 {
+	compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
