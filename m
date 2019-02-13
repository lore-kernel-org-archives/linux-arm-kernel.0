Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5A4C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:12:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C408218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WV1iBENn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AL39GY7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C408218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EAzMTtI83TjZ4dyq2CKBLs+dzfZMISQnZvdrTLmYZ9Y=; b=WV1iBENn3j12oL
	LjAyCw/opJ5ydumUb0TRSit9LPpakJLunDgHx6JSE2n3idEDTh2fc380CG/ye/m7fqKm9tLA7/4c8
	+dPm0ZuCwbASMd1WX04NNbp4rakrnyzK3+Ut1vTu9xuRTpYScjtstRLYNwZSZIVTjwdghYz+E/Beq
	6GgbyMX8Xw01DR1ohvZSJmuYusKTutedG0/X4ucF5Vf2Rw+XyxYgnWIKWXMRQ3tBAakVu8ZRX3Czy
	5WxDgQ+Kd6dktm/j9MmlrdTB+EcTTzZonF1ifZ+HErYkxqDUFe9KSia3JrXXuPRGDJxKCYgtJ5iQk
	0MPVlDyj5QEBRSFCKoqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtz1c-0004rt-DL; Wed, 13 Feb 2019 18:12:48 +0000
Received: from mail-eopbgr30044.outbound.protection.outlook.com ([40.107.3.44]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtz1P-0004dy-Q3
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 18:12:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPHgNsWwa/DJhADfpJLRIY4NTN6Q6Z4J6NQ+oZ8IpiE=;
 b=AL39GY7sRAGqiK/oKFn6FsXr1vg8lC8g65lAVbPectdAo7yojxt4d4VR/5oC2gse+AoD70cK1sxakuVoHeBlBqpdbGtCnu6d5evaZbNzjBR1GGebn4Q/YZmJHPXRggaJbuN4yhhvxnA7xz7m3sFwt25lqZ902FSk++H+Nc9J5lE=
Received: from VI1PR04MB4910.eurprd04.prod.outlook.com (20.177.49.159) by
 VI1PR04MB6223.eurprd04.prod.outlook.com (20.179.26.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 18:12:30 +0000
Received: from VI1PR04MB4910.eurprd04.prod.outlook.com
 ([fe80::6cc7:b375:76f7:b849]) by VI1PR04MB4910.eurprd04.prod.outlook.com
 ([fe80::6cc7:b375:76f7:b849%5]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 18:12:30 +0000
From: Frank Li <frank.li@nxp.com>
To: "mark.rutland@arm.com" <mark.rutland@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 dl-linux-imx <linux-imx@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "lznuaa@gmail.com" <lznuaa@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V3 2/4] arm64: dts: imx8qxp: added ddr performance monitor
 nodes
Thread-Topic: [PATCH V3 2/4] arm64: dts: imx8qxp: added ddr performance
 monitor nodes
Thread-Index: AQHUw8ev0RuwG91nDky0zDG0XgUhrg==
Date: Wed, 13 Feb 2019 18:12:30 +0000
Message-ID: <1550081533-25000-2-git-send-email-Frank.Li@nxp.com>
References: <1550081533-25000-1-git-send-email-Frank.Li@nxp.com>
In-Reply-To: <1550081533-25000-1-git-send-email-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:805:3e::49) To VI1PR04MB4910.eurprd04.prod.outlook.com
 (2603:10a6:803:56::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=frank.li@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.5.2
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab05d4b4-dd9e-448a-5665-08d691ded173
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB6223; 
x-ms-traffictypediagnostic: VI1PR04MB6223:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB6223;
 23:Qg6MVFm3m7f1Btne9PiEPc7bLkYrucoqhy2a7h6?=
 =?iso-8859-1?Q?vtMnrYSgHRzuWCpHV/1axXXzL1U9Y8xAwM+DL3Hd9nsyAEaMdjAKuRCXNR?=
 =?iso-8859-1?Q?gzomz/Aw87W5yXQ+lBD0o5YEKoBAALRL5/snAmG8KvQQeVXYjDZAjQ3YSG?=
 =?iso-8859-1?Q?7GYURqNHdHNhEKU7vpDtIK2Hlv8uAI7T0+MMqueU7kEUuGF5K54N9Uf9JJ?=
 =?iso-8859-1?Q?zK/8KNHxPICi6CFB16eHICxCDKdsQS1ZDqRz8uSLlpclQFZuWyqyjHRZUL?=
 =?iso-8859-1?Q?G7zWZYiguwbo2k7FaPhHre31AejczVbTC0gtTATTjdny4gKybeLzcvOmJD?=
 =?iso-8859-1?Q?irvR8p3ev0Gz41rWaM/Jlb+vB8JJIbhe5LSAVwc7KdVsg5hCrH5on7ECMO?=
 =?iso-8859-1?Q?XbHCoeTDfZB7b6BrtrEfLG1f41HsG8YTut+U/SQc/Jsu2AodVZ8mvhzKjX?=
 =?iso-8859-1?Q?D+JTA4Hyw+fMaY9kJt6JDaCWTyHffs0Q/BYnM+8Lr4rHrhQxSG9DtIa3S4?=
 =?iso-8859-1?Q?pyfDFjejzzomuiZfDuHqY3pm6z8CIdRKl+8aTxn6k9BghDAzRN0atDo3xu?=
 =?iso-8859-1?Q?X7aGGX/5cJUcWMLbbZ9i1NoLCxq/jxJY11kjSO+BgzWUUHvq/x9gGHF/tq?=
 =?iso-8859-1?Q?NMICEC1HcqC7fDjRnlC/lNfobK08XLNLxnKt20AYhJlkdv8H4uP4eMRVUE?=
 =?iso-8859-1?Q?uDancjFDThGnJc1qSL2yHhq+xHJy22ste/5XK9DHlb/Esr+O9abu9XWfhJ?=
 =?iso-8859-1?Q?1H+l12jrcKtTcyEkFImzYw+Kan6y03hsRRGT4yIfX9fsDPNaoxFqG9fmxl?=
 =?iso-8859-1?Q?+vcsyctlTc+456Z3wn6KwIXGXyVE/GZdaa+0o1KMvznwISNKokqURPl4S9?=
 =?iso-8859-1?Q?Cl3TDVZP/AfrGfgQqXaSEShISdEFiilZuFR3R3lN0sIGLXXTcRIZy2vBj2?=
 =?iso-8859-1?Q?R1SWEgzaRJvBa/dvSuQeF7312VEmaywnZbb1l9zd9bmmTg0pKbbBmuyxLZ?=
 =?iso-8859-1?Q?fAIQd9HcraWSpcYJdYGVizosOiYTcsOajUIACdq2k7pyviELKSvmdw/olL?=
 =?iso-8859-1?Q?3YhWs4frWZKhUqgjVf2xkO0HkuDdV0We1epuVLtdlJRGaTvDvtQd9RY/0t?=
 =?iso-8859-1?Q?4VnA6Mzxz5IdBTTwOiYY4OTu3DVWHG6gH8GeQD0dMjBA3ZT1UY/WBn9Z03?=
 =?iso-8859-1?Q?CYNhWYgjL5i8LTfKnN9jBpfko0i9h8kR008MCnD+GvxcOtBymBtQzkw2Fm?=
 =?iso-8859-1?Q?NUGXa8hed6GHWzeB5W+zBjD3EV1ab7+ub6YoaUb1WkPJumSa4hB07l6bST?=
 =?iso-8859-1?Q?OlyuCvCGb9mag4N9hnn6yyr?=
x-microsoft-antispam-prvs: <VI1PR04MB62235414CC8E7E824471A7EE88660@VI1PR04MB6223.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(376002)(346002)(366004)(39860400002)(199004)(189003)(6436002)(2616005)(66066001)(76176011)(52116002)(2906002)(99286004)(6486002)(386003)(478600001)(102836004)(256004)(26005)(186003)(53936002)(6506007)(7416002)(36756003)(2501003)(110136005)(316002)(476003)(486006)(68736007)(446003)(6512007)(11346002)(105586002)(14454004)(4744005)(106356001)(86362001)(25786009)(2201001)(50226002)(8936002)(71190400001)(71200400001)(4326008)(305945005)(7736002)(8676002)(97736004)(81156014)(6116002)(81166006)(3846002)(921003)(32563001)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB6223;
 H:VI1PR04MB4910.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hpNJ7XUCkS9SOPEHNlKjrg02PjIW2WtRyXIV5R6MRxKARPofSpOvVZw8/BNZmCaC8na5t9KqjCgStA2BgZa+QGKDOQ+bI8Brja9wfKLCBXxa0w8G733nqKf4Njt/MZ2ro7RwIYOqCWJFCi88gC3n7jF1sSxm6bm6amL0irQiCz6kIpAqu0Yxxn/o7xCQKSsDijFTbIh7O0KKv1YkudkbakoVJfqWo22X1yF5KvjphwxV+KZc0tHzEqX/gG9/QTXC/2l3LRbdALto6owbYkeBj8D8PDZoh/dFFeJmiLrYgNI8DTOv8EuENqsjCDHunVUlVaS7f+eWNvk3NwQEQL5Oi2CJpVaMoRBfyZoUw9z39TB4757rZwr7u3Msma8GwCSkYZ9BXgIJcvJWbJbXbM/AK9QcUT/Ber9Q78aegagrGzY=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab05d4b4-dd9e-448a-5665-08d691ded173
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 18:12:28.1113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6223
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_101235_842608_F9CBB3C7 
X-CRM114-Status: UNSURE (   8.92  )
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

Add ddr performance monitor

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
ddr_pmu0 -> ddr-pmu

 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 4c3dd95..ac0691e 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -79,6 +79,13 @@
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	ddr-pmu@5c020000 {
+		compatible = "fsl,imx8-ddr-pmu";
+		reg = <0x0 0x5c020000 0x0 0x10000>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
-- 
2.5.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
