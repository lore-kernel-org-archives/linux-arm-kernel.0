Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1373C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:27:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 896BF20818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rZwjRHtq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vx1UFptA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896BF20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=titUXR8nu30LoCyXJFKRKbR2EW7WrJUdnICsTKnMWx4=; b=rZwjRHtqonCvt7
	sEfe3aPWQMty2sQCDXNyj0GxtPM+2CW2mhX0idlFTV2xtyLTB6mHSfqx1EaGm5MIa9obxyVRAnyLc
	5vBVNutJkc/j2fzHBdTG4rtm78EIjUYZDzCpo8CZmqM2J3dLraR0IOqoGE0uXWZ7XOx1sBeECchwr
	R2bWZY0iEPxGTMCwDqVXN6fAbW3AZxXxSfejNI+nBQzRhiZVaHDjbCisCMUZE4dgvVNwczsoGEqTl
	NbTu4+vEXOVrwni2fYXiEVAlQnGrBgy/mY8ZK1I6UsmCYgnpZs1I5gQqsf5aeirM/NRQQx/dZ8phP
	i//eRlKzrYJoDWU4QaxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwt4A-0002iN-FA; Thu, 21 Feb 2019 18:27:26 +0000
Received: from mail-eopbgr10066.outbound.protection.outlook.com ([40.107.1.66]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwt2d-0007AG-Eq
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 18:26:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwaHhAT11G84EfwEjjhL+41AqU3cDN0K17RfrhVd2n0=;
 b=vx1UFptAnfR8Z2tm1fUleI8M/B2YeLofAi5KPXG05DzRU/tmp7SGWlmeaQWX5z0DJxkpgv57PDNyhusou7uLKl8yI1e4PejsnPpjccMYZVD4CiDg9z92Qh2IqnFTN1x/66pRVIYf0IHRE+n9XqpcM61ePBt/3KtrOkeGMx4LbVU=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB4846.eurprd04.prod.outlook.com (20.177.49.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Thu, 21 Feb 2019 18:25:43 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 18:25:43 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 13/14] arm64: dts: imx: add imx8qm common dts file
Thread-Topic: [PATCH 13/14] arm64: dts: imx: add imx8qm common dts file
Thread-Index: AQHUyhLbEShqIVvu9kuBjzGwBA2PnQ==
Date: Thu, 21 Feb 2019 18:25:43 +0000
Message-ID: <1550773093-13349-14-git-send-email-aisheng.dong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 8b3f0853-c781-416f-083d-08d69829fd66
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4846; 
x-ms-traffictypediagnostic: VI1PR04MB4846:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB4846;
 23:/7yXZsBtJMMdcME4RxsOMLKzNXr65UOs2ZnVt9/?=
 =?iso-8859-1?Q?6Vj+U9MFZe7rgOXTRTSyRXExvIsWkLwH/Btux02TpM0Vz0nncjRpIzl2xT?=
 =?iso-8859-1?Q?0nCgcpT2PeVR8F8Agml4+FfxQRtqtqyMmtImxf7XaIyd89PQR0P1V9WDWF?=
 =?iso-8859-1?Q?CPs6InkF36y5VOIXUbDMK4f9Br+uGJwNzYjfLvT32fUavnqs69EkCmdi1I?=
 =?iso-8859-1?Q?1CKwiiRtGfTX0ucrPMYMOtZtx+MhD5bUeYW9k3sL00t4GUNw5BbasCsrou?=
 =?iso-8859-1?Q?lZ3RVGGIQ9u5m9BwFDBsVcmMDsh7UIsu/B30VvVva1MpopB817ceI2g4Zv?=
 =?iso-8859-1?Q?6DWGAo7cOE6R3vjMJA5y1uiBSnm2y5wESlTHTkoIIoHWy9uWgNiK2g7y/d?=
 =?iso-8859-1?Q?ajERUdTjeoFQfgVQ0+tJEOPcNtsFfzOLU7blAmm0t9A4ri2xyXacf9R8M9?=
 =?iso-8859-1?Q?arA581VMm1gJQCV+06aTcCe6FGMja7h6+uGbyug/kQUg6ZC7/GNwVHF2w6?=
 =?iso-8859-1?Q?h35oVM2hFZyjnuWH6ddnYtSDhQw5HTOR81ooM0a3z85YX4mOxkgGYx+qu+?=
 =?iso-8859-1?Q?ePdLiDJu1gC0AKFrPYJfbTbDJY4bWeR0S1K4KIe4lVG0e/mypNmujkqY5H?=
 =?iso-8859-1?Q?cWTh9E0vV6meUNuNwTyD2RJ4kR4KWOdseMuDTxKggj9zDBCf9oFDuDv8n0?=
 =?iso-8859-1?Q?Iex4VFl5tmOxgShb+u/H6RW0xg1fHbdFc1ucC5hVsw0sqX2G8knQ/NGFzz?=
 =?iso-8859-1?Q?x2MqhNVlTbAKC8ppYWMl0i1N2I3y6vZrA9qas/KAqID9scTqdMUBd/PR1r?=
 =?iso-8859-1?Q?XzRwARZtRK8m39Bk1s1ORDkgIOG5iuwoOV+kRyHiD6NcgtJtp+1I7dbSvW?=
 =?iso-8859-1?Q?CUNrFACT0ZYGq4rT+IvCBH4qDvOFAubqvQq7cRGEQD+etlCBCYxl9CR0gT?=
 =?iso-8859-1?Q?onvVbOtEKBAsMbUmDEBYMdLsJAvclF9j+F9msUJHUTIhZT7TwxeAS7Akw3?=
 =?iso-8859-1?Q?fFZoO6WvcmchqO5QglHj5H5ClZlmz/v1noVdvizawdhLvn5zSSdE6iswCd?=
 =?iso-8859-1?Q?SBWQePpU4isw5hCe0cCxEVBQNHlwLq5fIkSjDJW0siZF8jiYtgi1yE+WHs?=
 =?iso-8859-1?Q?Qvmn7/jgNUWa0qKgc0s1Mzip7z9tgB2bOLudVdNBFwWVf77kcdEDNHwP5e?=
 =?iso-8859-1?Q?ooUxYkod2YEqef8uoy8h0mu7cIU80mjAmKosONjxttGZyV3n+Y9QAFQFVC?=
 =?iso-8859-1?Q?7RIHK5/SsG00pgcxpVQMXz4qvHYNmgE1l034pMguo/qzatwETresSIpcqZ?=
 =?iso-8859-1?Q?slrvjJjHNWOPqJWFC1LUbvOM+jaQOtvC2rsaXEK1I31WA=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB4846C9EC2DA0640CEE59F318807E0@VI1PR04MB4846.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(136003)(346002)(39860400002)(366004)(199004)(189003)(7736002)(2351001)(66066001)(5640700003)(6436002)(25786009)(44832011)(2906002)(486006)(6486002)(53936002)(99286004)(11346002)(52116002)(76176011)(6506007)(97736004)(6512007)(2616005)(476003)(106356001)(446003)(305945005)(4326008)(386003)(105586002)(186003)(26005)(478600001)(256004)(86362001)(316002)(102836004)(2501003)(68736007)(6916009)(81166006)(71200400001)(36756003)(8676002)(3846002)(6116002)(50226002)(81156014)(71190400001)(5660300002)(8936002)(54906003)(14454004)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4846;
 H:VI1PR04MB4222.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /L15Ce66vMnm1zU3V4MCrnoMFIo0UtGNLHbQDRLbZ7KeUGLqJ7/eQqIclwfc3mJ2xRBuIefhqaW62Y0tq6gJuRCl4m5nXlEEBJhPVWLnSLUPnIYqhqPb3qzPT7k/qkyM11t1F+6T/XnaMjcE0BFyTqo795Kp/fUv+sHCCJ9PyyaUXX6DijieiCJ/MV+ypfVJXSerJAdxpsC/JCK0CNmHQTjYiP+B9RmjY7XdWGVcbs7NX1hYUBUmSI12Mp1xd1ZWjpUEcEiL9JlQUywlKlhsfmR8aPmDnZN/WkMUrke9kuh7LdxuM7EwXw9Q/Ey5EHkUWdQsw7gu/TwKZxKsJdPsEXsEXt+OHeqqjgFj/5ZCLKpgsFIzyh6sywNlC/Isgb5B9ufFWcTXU0enHMD+hVJlnsXjutYPEcArYWL73Dv3v74=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3f0853-c781-416f-083d-08d69829fd66
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 18:25:39.4210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4846
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_102551_732385_2DD27B43 
X-CRM114-Status: GOOD (  15.08  )
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

The i.MX8QuadMax is a Dual (2x) Cortex-A72 and Quad (4x) Cortex-A53
proccessor with powerful graphic and multimedia features. It uses
the same architecture as MX8QXP, so many SS can be reused.
This patch adds i.MX8QuadMax SoC dtsi file.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 173 ++++++++++++++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
new file mode 100644
index 0000000..526cbbd
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018-2019 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#include <dt-bindings/firmware/imx/rsrc.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pinctrl/pads-imx8qm.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		mmc2 = &usdhc3;
+		serial0 = &dma_lpuart0;
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&A53_0>;
+				};
+				core1 {
+					cpu = <&A53_1>;
+				};
+				core2 {
+					cpu = <&A53_2>;
+				};
+				core3 {
+					cpu = <&A53_3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&A72_0>;
+				};
+				core1 {
+					cpu = <&A72_1>;
+				};
+			};
+		};
+
+		A53_0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			next-level-cache = <&A53_L2>;
+		};
+
+		A53_1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+			next-level-cache = <&A53_L2>;
+		};
+
+		A53_2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+			next-level-cache = <&A53_L2>;
+		};
+
+		A53_3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
+			next-level-cache = <&A53_L2>;
+		};
+
+		A72_0: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72", "arm,armv8";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+			next-level-cache = <&A72_L2>;
+		};
+
+		A72_1: cpu@101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72", "arm,armv8";
+			reg = <0x0 0x101>;
+			enable-method = "psci";
+			next-level-cache = <&A72_L2>;
+		};
+
+		A53_L2: l2-cache0 {
+			compatible = "cache";
+		};
+
+		A72_L2: l2-cache1 {
+			compatible = "cache";
+		};
+	};
+
+	gic: interrupt-controller@51a00000 {
+		compatible = "arm,gic-v3";
+		reg = <0x0 0x51a00000 0 0x10000>, /* GIC Dist */
+		      <0x0 0x51b00000 0 0xC0000>, /* GICR */
+		      <0x0 0x52000000 0 0x2000>,  /* GICC */
+		      <0x0 0x52010000 0 0x1000>,  /* GICH */
+		      <0x0 0x52020000 0 0x20000>; /* GICV */
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* Physical Secure */
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* Physical Non-Secure */
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* Virtual */
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* Hypervisor */
+	};
+
+	scu {
+		compatible = "fsl,imx-scu";
+		mbox-names = "tx0", "tx1", "tx2", "tx3",
+			     "rx0", "rx1", "rx2", "rx3";
+		mboxes = <&lsio_mu1 0 0
+			  &lsio_mu1 0 1
+			  &lsio_mu1 0 2
+			  &lsio_mu1 0 3
+			  &lsio_mu1 1 0
+			  &lsio_mu1 1 1
+			  &lsio_mu1 1 2
+			  &lsio_mu1 1 3>;
+
+		iomuxc: pinctrl {
+			compatible = "fsl,imx8qm-iomuxc";
+		};
+
+		pd: imx8qx-pd {
+			compatible = "fsl,imx8qm-scu-pd", "fsl,scu-pd";
+			#power-domain-cells = <1>;
+		};
+	};
+
+	/* sorted in register address */
+	#include "imx8-ss-dma.dtsi"
+	#include "imx8-ss-conn.dtsi"
+	#include "imx8-ss-lsio.dtsi"
+};
+
+#include "imx8qm-ss-dma.dtsi"
+#include "imx8qm-ss-conn.dtsi"
+#include "imx8qm-ss-lsio.dtsi"
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
