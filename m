Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614FFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:03:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33FC421A4C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nE5mgkgw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NAISE6rM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33FC421A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=8VSq56Ys/mAldNAQDsbcsXNbzoIkEFbcBTBuYIMJDFw=; b=nE5mgkgwu8/b2c
	TtOEGpXQkx5Vlw0CRGhddwkB2PR0Eitbc2I2HlIpzA/k1+IwUeFWBVIijKBbOwLm6p2BiYuWXZSqN
	s9l9f0FzEtz7r3P4iHgAj9c4LO4SbBTpibK+RUKtlUWFE0cFc2o/ntsQLg4xeejDJlD1qV3mmoCkN
	o+8Z6pW5oEPG3jxW+TgfUb+kkbeR+A6azrm4M3Hpm2rZ3EhBdRPsIn4+kDqBwdwCW0P9egnjyKcQA
	Ynv6y9LPFt7iVNb4EfR7pKpl6rHNGQ8Zw9rRdMR6A9FgS5CABzW/H0aLgOnZYBKFBLYb7Z87Oi4wk
	v9ZuzY15kGiXssST7uGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guhpV-0007EN-7H; Fri, 15 Feb 2019 18:03:17 +0000
Received: from mail-eopbgr40045.outbound.protection.outlook.com ([40.107.4.45]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guhpR-0007Do-KA
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 18:03:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4KfwxHDjJUUFs8FvHHcNAwIf4GY4effT1telFKP1kI=;
 b=NAISE6rM1t3cXIjlzaFpN142nK0jHrACoIGJcce3+KStXAz8l+e/mhCRtQJfRwBzTfyuRCYUrh0kXtH6IoMnqJK54lMNjfvpoO5O2lioF/yT3nZ6pt/3qnb/naR+GfAm6ugTHWDr2/acXUqfsfauwx/8v/f3Gf432sywDc2G0T4=
Received: from VI1PR04MB4910.eurprd04.prod.outlook.com (20.177.49.159) by
 VI1PR04MB4893.eurprd04.prod.outlook.com (20.177.49.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Fri, 15 Feb 2019 18:03:08 +0000
Received: from VI1PR04MB4910.eurprd04.prod.outlook.com
 ([fe80::6cc7:b375:76f7:b849]) by VI1PR04MB4910.eurprd04.prod.outlook.com
 ([fe80::6cc7:b375:76f7:b849%5]) with mapi id 15.20.1601.023; Fri, 15 Feb 2019
 18:03:08 +0000
From: Frank Li <frank.li@nxp.com>
To: "mark.rutland@arm.com" <mark.rutland@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 dl-linux-imx <linux-imx@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "lznuaa@gmail.com" <lznuaa@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V4 1/4] dt-bindings: perf: imx8-ddr: add imx8qxp ddr
 performance monitor
Thread-Topic: [PATCH V4 1/4] dt-bindings: perf: imx8-ddr: add imx8qxp ddr
 performance monitor
Thread-Index: AQHUxVi0ykTl7DQMoU+RsFEws0qNyg==
Date: Fri, 15 Feb 2019 18:03:08 +0000
Message-ID: <1550253761-26841-1-git-send-email-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0008.prod.exchangelabs.com (2603:10b6:804:2::18)
 To VI1PR04MB4910.eurprd04.prod.outlook.com (2603:10a6:803:56::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=frank.li@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.5.2
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a5e1119-2fb8-47e8-b070-08d6936fd707
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4893; 
x-ms-traffictypediagnostic: VI1PR04MB4893:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB4893;
 23:ezX6hye3bWQT3GDZ4vOreIq0iG8sdXexldItRD8?=
 =?iso-8859-1?Q?Np9M/ekNDw4VfuEJSn//kSy25K4L3LKKaJQ18/GrR96Gy36Ut8pkKEid0f?=
 =?iso-8859-1?Q?TrNen4ALDpSycp8S8kTJb/o+g+93/ij8+ZhCdtoegd4lPh2/8IfzAOQE5k?=
 =?iso-8859-1?Q?mzuF4UnoZOO4yfqPS0/vLnJXtXpsNLYY8SlTiSPXo1aFpPo9UWxWSyE6zo?=
 =?iso-8859-1?Q?Kb0gf28Y42iyMxMNjnExHNCvyzPOBof0bluceJ0uGywRz+VdBsIfPXOYUA?=
 =?iso-8859-1?Q?sQGzNUjNEbY735hlu/y4n/UisYZH+hbCuvBXwd8TeCAlth4As9LKh+8aLP?=
 =?iso-8859-1?Q?n5leoUPJeNRvGIZAq3nT5CMpQoh4M8wdL4wRcn/famB36QMt/6YX4gg0ba?=
 =?iso-8859-1?Q?ztPDfUVCp3ruDTfK385YcFCXfSxIRtyKY7xgufthJytWD1u8vYXLxwPev5?=
 =?iso-8859-1?Q?TyVVu61fTzHLKxlrmT9NieLhILC4aJZKJVIfRO9iiqi9WNxXPKxbLWzqZn?=
 =?iso-8859-1?Q?qN4RggKMIXWhAKJ0vFWHk6MIm1g6zABBJam+K/N2FKkWDjEWAafB8ZST6T?=
 =?iso-8859-1?Q?jCWCl9LdGJ40ag/iXyjXGGB1L9qtQDg4uKw/5aUROQuP/fZeasPqfn1Vm7?=
 =?iso-8859-1?Q?Q5Fkdk+P9faur8auMn4F6Yjp2sbgIP2ScvvFj86LucQSFg2dJTpaimr+7J?=
 =?iso-8859-1?Q?0wYv+vvZMxW2708/Zo/DBGil0vwdC6B/WxzubjhZP0uN73U82Dueunbmjr?=
 =?iso-8859-1?Q?cVjt+zIG3w0iSFgGly4HXKK0p+muBueSZHt0eBo7aMO0z9p3VkXv4ZZYDG?=
 =?iso-8859-1?Q?6U+CSUDWvdiyFn0u7/Ehr3coMY3pMhMQPphWqhZc5uiSPC4bMGvXh59g4I?=
 =?iso-8859-1?Q?SJcA/uyUfTDab0OeQAvwhNbqz71mny4QAiassRtpUP/bZNoIUeBL/F84la?=
 =?iso-8859-1?Q?lj6PV+rTdpHmh618cnSTd8/O8tpFJybMUfrujVvz4vpc3LcmXOTwZRKFmM?=
 =?iso-8859-1?Q?OtQVrelHxETCF2PbRdyalvnTVSkiUeiV7cEwW7/iP1ndjCtLgG2FeyUcXN?=
 =?iso-8859-1?Q?wlI/j0u/0p7M/Qi0s/04Afl33WRY0AeLvt23eQ/t/UW0rPdjSJTFNc03wb?=
 =?iso-8859-1?Q?mr/ujEklax0se2zFB7GY1OE4GbSJpaYangJORA8Ninoxt24QLqjP+SbO3X?=
 =?iso-8859-1?Q?81C/kwSlvGLQwRz4Cd75sEpgPE9Lycii86qQZlaxTipccq6vp++wGvDTRH?=
 =?iso-8859-1?Q?1GJJNDzRhW9Kc2CzEJdqkywdi/llHm/Y58zJxeg=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB4893EB53FFB46FC4F32A8D9788600@VI1PR04MB4893.eurprd04.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(366004)(189003)(199004)(36756003)(7736002)(2501003)(86362001)(110136005)(105586002)(186003)(6512007)(6116002)(66066001)(106356001)(68736007)(316002)(476003)(305945005)(6486002)(3846002)(4326008)(486006)(2616005)(25786009)(99286004)(7416002)(6436002)(52116002)(50226002)(97736004)(256004)(2906002)(81166006)(81156014)(2201001)(26005)(478600001)(102836004)(8936002)(386003)(8676002)(6506007)(53936002)(71200400001)(71190400001)(14454004)(21314003)(32563001)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4893;
 H:VI1PR04MB4910.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YVjBW1CmpODGkjdJS2mKcgqThZIKoUWgGqhUj8tXAPiWMi96Lx3vK0tZ2+EMChL9gbxZnbVOE9rugV1/YjNLh/Q16GHiA0tT43bYtRYjNoujtZ6a3+ndyNlPD7NPabDbFLlZ7BMZGuwGh5uz9zzzXbI+1im/ockxDKcBHxIgePOdmRHEfj0aVCU7HS/4SNmJl1zxfooe+6dL8Xjf2e5CspFAYva9FjQoznVAxTh3vl3VrqPJ+YczJxX1wnVaNsGtNuDNd7usg3kY9D0a6u0sQmD62p8o103JIK+vWhG1LR2RdkHoaFWBGuK4h4CQ8sR//r9KwOQzEa3amm3xvk7IV7mmRfBxpZBdR9GyoRGwlt9gAIQTqaUcw+Iwv2lMfYwFiK0csW7m3sIjDqxjVPAvAat5STTXgJqfIVkqS79baGM=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5e1119-2fb8-47e8-b070-08d6936fd707
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 18:03:05.6657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4893
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_100313_662439_F831DAA8 
X-CRM114-Status: UNSURE (   8.38  )
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
Cc: Frank Li <frank.li@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Added binding doc for imx8qxp ddr performance monitor

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v4 to v4
* remove "standard xxx"

Change from v2 to v3
* ddr_pmu0 -> ddr-pmu

 .../devicetree/bindings/perf/fsl-imx-ddr.txt       | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt

diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
new file mode 100644
index 0000000..c667b87
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
@@ -0,0 +1,22 @@
+* Freescale(NXP) IMX8 DDR performance monitor
+
+Required properties:
+
+- compatible: should be one of:
+	"fsl,imx8-ddr-pmu"
+	"fsl,imx8m-ddr-pmu"
+
+- reg: physical address and size
+
+- interrupts: single interrupt
+	generated by the control block
+
+Example:
+
+	ddr-pmu@5c020000 {
+		compatible = "fsl,imx8-ddr-pmu";
+		reg = <0x0 0x5c020000 0x0 0x10000>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
-- 
2.5.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
