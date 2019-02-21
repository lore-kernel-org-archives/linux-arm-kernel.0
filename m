Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A26C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:27:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 139AB2083E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ta+z9WBk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xdbs18Td"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139AB2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D0akIAJrWF2xZIrqzLZzrW9RSum1zceyy1LXA6rKsWs=; b=ta+z9WBkgYfXAT
	C0jyhM0y78ep6+sSj4MdRFjE1AJwNpCsvLLR3ebMpP9F4XHFAIzqQnA4ZmvM6hXEzgwzipThWklty
	1CcbuXc45966LfhW2Sd+vHKoK858sEIjeIKIBflJ0OOTFRUMsXkU+PYxkA3VdS5h8B5Fp2CATDhfe
	BqsPwG9651m9CAdkKpIMxcPYNg0wbLY2aUoQn/6fg/DD3gas8Xn9iUG8CXw/jI+56Pb3fegXf6hw5
	eIJbAWP7BB8qCU8PLPHfn65eXExfUV0OE24/rrxVTdd5a+lphdS5iLr/lH1PIyy+E/goAdsu6K1Y4
	KEay6+r0QGXcRrM0EpsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwt4L-0002xd-MK; Thu, 21 Feb 2019 18:27:37 +0000
Received: from mail-eopbgr20046.outbound.protection.outlook.com ([40.107.2.46]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwt2g-0000Km-3U
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 18:26:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUVowzuC6cBVEIXYGx56XT9+Ym10z7hCs0r2M6alVaA=;
 b=Xdbs18TddAYQKkePW+IHk3jdj1+XHg0a/JBnWhC34RcIOQ17YR/6D8TfzMxktRuckzWH7068ET/YhmUxzsiSF+Ru4nypKwIMyvkgZK1nJ+oLnnqTU3KkjM1O0VEVZm7NdYxgp4qsA5ayGBxAyGS+ybFEvgHxwvdDAtDgtfLb5TE=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB5599.eurprd04.prod.outlook.com (20.178.125.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Thu, 21 Feb 2019 18:25:31 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 18:25:31 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 10/14] arm64: dts: imx8qm: add conn ss support
Thread-Topic: [PATCH 10/14] arm64: dts: imx8qm: add conn ss support
Thread-Index: AQHUyhLTjSkPl+mUc0CQCt8nCc+09A==
Date: Thu, 21 Feb 2019 18:25:31 +0000
Message-ID: <1550773093-13349-11-git-send-email-aisheng.dong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 263dd532-c8d7-4e62-57f4-08d69829f605
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5599; 
x-ms-traffictypediagnostic: VI1PR04MB5599:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB5599;
 23:2via7nhEpOo0GcBoXvwJ0dnUG0RN0o3VGt0bgK+?=
 =?iso-8859-1?Q?wiNWAqpoLXDRBEMDHL3RQ+a4PjYQy0Qx0uQmJTVVThFcS8Hi83YYC4ufHT?=
 =?iso-8859-1?Q?Km1QbGXAHnLDNexvpelZb7uF66B8AbB8lG7kXPuthhKu8ncAIiA7LShl6I?=
 =?iso-8859-1?Q?0Rb5NtM1qde9R6xAJ8K53iwefEnvOre6yBvP+S6DfSEvXUufk38/nSwwkw?=
 =?iso-8859-1?Q?t5p1YLcO0CfISN/arv2LH2L3F4RSoOBmS8ypwhIOj3k2yrX8iFc1N7NdGZ?=
 =?iso-8859-1?Q?vX382SUvI45JP8Isam+IRKrxc62Z/2WHGoEv2FXWTM3x/YbX0ayjICP/9K?=
 =?iso-8859-1?Q?BknQPIsC+eXEQyP82ugafdO+TRi9M/JOVTbIbKjwABAlcsiiLa20eMiPRr?=
 =?iso-8859-1?Q?yG8b7MhGGgxuYiOWaK+jHMyFIRL/XzovOcpcqZsk7X/oV5I/0ib7qbFvat?=
 =?iso-8859-1?Q?3QHgpbRhXcp90DewfWNXdA48EqSS4T0L+OfYyPMTxGSpKFVqVUDvymF90W?=
 =?iso-8859-1?Q?6cZNr3T36sMKFgM6NkGbT7LrQnuAnIC2rK/JJqeY4MreJIxi367LnQ64lj?=
 =?iso-8859-1?Q?5TU0DRlsRm9zUJ98Tg/xjhw5mt/YC+96xNerY2gxIRuX4uVCKiUC0lwT9B?=
 =?iso-8859-1?Q?ivWSTFhaEpYrhSO+hThmJV1P6vkw68i0fN8kdEIRIbPNoL0NruMv5YmtmO?=
 =?iso-8859-1?Q?mJiPdfHK9AQISld6csiW+nZpJ2DKyZIUVoWbu2dn4OZcAhBsHeiWUEf7ic?=
 =?iso-8859-1?Q?N4u76iuvqDJNi0eHLX6ViXAFBWNS3F4tky2PL9reMLDnnCCdoMPXHkCDJV?=
 =?iso-8859-1?Q?yv7eZMkxzRWse1FtATHRq69Y0lessf00J5P0jnHbJ78o80FAdyZtSyEhQQ?=
 =?iso-8859-1?Q?Q1CF9Tvs9pLKYBij8zP8eQlI8HpuOv5KlqKtWfVh6+ula6Nm+LgsEwc3QM?=
 =?iso-8859-1?Q?DAoghhKmpMe41Ql6Fz+9R+u4jis8ZUuPYtey/legEYEWBci1Eo3/R6M1Hz?=
 =?iso-8859-1?Q?qxdC6ENh3daeQPyWkRrdfi1BvY9ZDPl1/ESPtDUfDM+bmOlfXoUXyAGmOG?=
 =?iso-8859-1?Q?NWtGsf9wauuNApg2OpwRLyB8p52dmX5336L6KgT9MW1qvqhiBgj1C5pUyj?=
 =?iso-8859-1?Q?iuPvxzUWhRv+uiNtxxiQAu+JQsO6i7OSn/qBdD/Zrr/Z77xDGQd1oHyZc/?=
 =?iso-8859-1?Q?GG+QBWU4dFhgqb9jiBN4iW2HAbB50BEh1+Q+X7VGepFKIxZHTZfuN9QYYY?=
 =?iso-8859-1?Q?J0wh92+OLBiyIgHM5XjTlI3DjK814IeVISIkqXaDpKwNVnAlCiljZDBxTf?=
 =?iso-8859-1?Q?fZ9dxqeXtPykzSFe9r0rLilUw4OD05gVDGKZCxFhVChRhImygFEDhT1Gwr?=
 =?iso-8859-1?Q?NOYmFyVd4KjqrdWflxYY9dgd90HZqNXbZlgu9mJ7fB+qs2nuuVbEo9d5US?=
 =?iso-8859-1?Q?Dl2r7uehXSzOeu/gy7ahCQxMmP+fJh63DUL?=
x-microsoft-antispam-prvs: <VI1PR04MB5599E8E08F92573D122E32BD807E0@VI1PR04MB5599.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(136003)(396003)(366004)(39860400002)(346002)(376002)(189003)(199004)(256004)(53936002)(106356001)(71200400001)(71190400001)(81166006)(2351001)(2906002)(6916009)(446003)(105586002)(81156014)(44832011)(316002)(305945005)(97736004)(2616005)(8676002)(54906003)(6512007)(7736002)(2501003)(68736007)(76176011)(386003)(6506007)(3846002)(486006)(14454004)(5640700003)(86362001)(6486002)(52116002)(6436002)(4326008)(8936002)(102836004)(5660300002)(476003)(26005)(99286004)(478600001)(11346002)(6116002)(25786009)(50226002)(186003)(36756003)(66066001)(32563001)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5599;
 H:VI1PR04MB4222.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GAgiYnOQ+NtVW2Mkpxt6j7ObTGpDJQBEPW1JX9IggxKwHaiKiKgRFWYvjPJ1aW0UqbJBiWREJ4vikmPzcekiYRAcI/QczKg94LnNPjVR6E7dCpzb/lpuqcCvxaZU7y9nsKii2BQqMMC6Qh4NhuJjGoHe3XlZptq1/Ng/aMhJ0auEbSqj46wA4yycI5qESEaXIaIhnVZen8Ysr/H6v7HDFlwv55Do5wq9CgsGhIxGj3mCVJlobMM2lA7Xhvs++WbwRS5uHHxjcqML60V0xRFM6w11HHT8ZrVRQ2/yvPmDaV1RDPC6vO0O4n8iXl+DNgUtdLJxhWOCDUoS40ZRUVhqo3k18HjPNBDdj61m0HUQsqrDqai25yZXbvy+vglSQiH7T0+wUTwCQw86IXJXU95lzdVeKnP9FKfpWAditKDC2EU=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 263dd532-c8d7-4e62-57f4-08d69829f605
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 18:25:27.0683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5599
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_102554_534565_F2E378E1 
X-CRM114-Status: GOOD (  13.38  )
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

The CONN SS of MX8QM is mostly the same as MX8QXP except it has one more
USB HSIC module support. So we can fully reuse the exist CONN SS dtsi.
Add <soc>-ss-conn.dtsi with compatible string updated according to
imx8-ss-conn.dtsi.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi | 93 +++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
new file mode 100644
index 0000000..68eaf7f
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2019 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+&enet0_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&enet0_bypass_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&enet0_rgmii_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&enet1_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&enet1_bypass_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&enet1_rgmii_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&gpmi_bch_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&gpmi_bch_io_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&sdhc0_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&sdhc1_clk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&usb3_aclk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&usb3_bus_aclk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&usb3_lpm_aclk {
+	compatible = "fsl,imx8qm-clock", "fsl,scu-clk";
+};
+
+&sdhc0_lpcg {
+	compatible = "fsl,imx8qm-lpcg", "fsl,imx8qxp-lpcg";
+};
+
+&sdhc1_lpcg {
+	compatible = "fsl,imx8qm-lpcg", "fsl,imx8qxp-lpcg";
+};
+
+&enet0_lpcg {
+	compatible = "fsl,imx8qm-lpcg", "fsl,imx8qxp-lpcg";
+};
+
+&enet1_lpcg {
+	compatible = "fsl,imx8qm-lpcg", "fsl,imx8qxp-lpcg";
+};
+
+&usdhc1 {
+	compatible = "fsl,imx8qm-usdhc", "fsl,imx7d-usdhc";
+};
+
+&usdhc2 {
+	compatible = "fsl,imx8qm-usdhc", "fsl,imx7d-usdhc";
+};
+
+&usdhc3 {
+	compatible = "fsl,imx8qm-usdhc", "fsl,imx7d-usdhc";
+};
+
+&fec1 {
+	compatible = "fsl,imx8qm-fec", "fsl,imx6sx-fec";
+};
+
+&fec2 {
+	compatible = "fsl,imx8qm-fec", "fsl,imx6sx-fec";
+};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
