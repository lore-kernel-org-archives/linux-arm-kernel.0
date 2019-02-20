Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78E9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:53:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9381721773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W/s4pVxj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wRkLR5MA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9381721773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=yxDcINTeo1knmf3eDGttpSNrPBvYL8tytH2NshPCIMI=; b=W/s4pVxjXIni0S
	cpcugpDtInteKZROS2WN70YwVNm0J70lRPBLyMxdxtI1Jcs1Pjg09PCxI57xU5quzkb1xmRDHihpV
	KOUwXKkmBM9QBJ0TpiC0u8/QfUi0QpFEJ8bTX4wtD2hPzlVPe8WHB4lNNz3/FsO8zH6LR04spvZW5
	9+w5/3T2GCQqVRJXTdInlWh7NOr/PLjuPcYXyaAWtLGefbCBSc2X07AtGBxveYAOqelTAgXZGVP/q
	sWU4HF/80+IGwymNy4Lbj/qqjFr+295yKo/RereLdzGsim2UKJBxhfK3Z1GNIa0KxCji9I3obrOHW
	29aiDGlcRbjgJoFJrvnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwLlB-0001w7-FB; Wed, 20 Feb 2019 06:53:37 +0000
Received: from mail-eopbgr40049.outbound.protection.outlook.com ([40.107.4.49]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwLl7-0001vn-PQ
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 06:53:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dS5zUboiKPw4qU2HHyzEt1BifVQG/vsJUKuiUePMSHw=;
 b=wRkLR5MANUVGvZQfJdo90GsEtK78QhfLYXsIEognjI35MtOjYKSK2N0dhYAXspqrXTPeQA9dy3NtH6qvTVTaWMlIHlun5yvRVDbuJCFkqBopp2o5tQgW4Ugodt6CZRSfpaecUVyN2bynCoRJwUGrqSZrqcVPxey6awzU7mo58qE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3883.eurprd04.prod.outlook.com (52.134.71.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 06:53:30 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Wed, 20 Feb 2019
 06:53:30 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org"
 <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
 <festevam@gmail.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>, "rui.zhang@intel.com"
 <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Aisheng Dong
 <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 Daniel Baluta <daniel.baluta@nxp.com>, "horms+renesas@verge.net.au"
 <horms+renesas@verge.net.au>, Andy Gross <andy.gross@linaro.org>,
 "heiko@sntech.de" <heiko@sntech.de>, "arnd@arndb.de" <arnd@arndb.de>,
 "olof@lixom.net" <olof@lixom.net>, "bjorn.andersson@linaro.org"
 <bjorn.andersson@linaro.org>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>, "enric.balletbo@collabora.com"
 <enric.balletbo@collabora.com>, "marc.w.gonzalez@free.fr"
 <marc.w.gonzalez@free.fr>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>
Subject: [PATCH V7 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V7 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHUyOj9eEW+Gy1rWUqASm4hcJoqZA==
Date: Wed, 20 Feb 2019 06:53:30 +0000
Message-ID: <1550645332-2907-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0050.apcprd04.prod.outlook.com
 (2603:1096:202:14::18) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01b0fdd1-97a0-44a3-f5dc-08d697001f7f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3883; 
x-ms-traffictypediagnostic: DB3PR0402MB3883:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; DB3PR0402MB3883;
 23:sj96NVC2+JYEDRawjFL3QwxWXyftRElQtIdcH?=
 =?iso-8859-1?Q?tj5dwL9mCl4ak0FBDifut1tYrwTF3oKuRPmzmSoyfSTz01Be+mcpBNdqMV?=
 =?iso-8859-1?Q?NI4W7R+e5YpaiFXwKiQ0BnLa5z4NZV39E+6SZXutxdcl3IOkkUqU1ZTS7/?=
 =?iso-8859-1?Q?z0hLcNAaod/Z/GDa33ATiCXjImSL0KFDMJcMEuc6+0gAUhXldAz0q+/Xxe?=
 =?iso-8859-1?Q?NjmXFylF6RfX5UalR4rHYeC4d6G+rw0b969TVeqoxTwOz+3afJ9r1KEtMT?=
 =?iso-8859-1?Q?0aZ4raiopSTpZc2KkzrNY/6G2M2sYKBiXeI080ouvw8m+xbvDMiS+19oOE?=
 =?iso-8859-1?Q?8MpwxJia3bF4Ciy9uGMl7H+NDyupORihRUzWuQhScg4G1aG8UYR6XGgii8?=
 =?iso-8859-1?Q?b3jT7ipbFt9ekDMYMhsZsIlOMM85kziMhHM4wTGnDbOFHjTI1pJNcGEijd?=
 =?iso-8859-1?Q?DCUpsah6AsLK31A+tj/IcpRmHveTKj3kB1thzRXJLSs06N29uEVDjwVSYM?=
 =?iso-8859-1?Q?PIT4+umc8Y8jG4/6c5jAEyZ8yS+mai7WnfT0efjyR4/ZF5nm/gBbUspgqY?=
 =?iso-8859-1?Q?LwWRnscqJ1KtEcVtChLCWz7qQDba+PWGMpbqOfk9iFhcZdSVRxOffI6SmD?=
 =?iso-8859-1?Q?BvAr39bQoZT+vjylL+CexuyobilGe2nRMxJ+XSqJW70XpQc4WbI2dD7g8l?=
 =?iso-8859-1?Q?07O1Yq7BfprLMvDykKeWlFiPsyLtJS3+h8BUfdw3F5QT/Og402VZbl/xMw?=
 =?iso-8859-1?Q?j4emmYFZNrZNv2XgziiycCY3RfE0+bdmeQS/QnodIMGO1j9q5GyjKY8lzs?=
 =?iso-8859-1?Q?yOUEJo9M7bS4HwmJQuoXkiYoP3Z7hy0G93UW3rIieJyBwquIMkjaL6hJpS?=
 =?iso-8859-1?Q?VETsXzj1+JlhIsBtGtrLoA3pgyeBktP8h1UHqHc6xg0y7yfwqa4M1G0ouu?=
 =?iso-8859-1?Q?5mg+5rHSvHHxhsng1KZT5ur1/BuP3yfewvMdUQMmkoNAI6sudThOC1+zP+?=
 =?iso-8859-1?Q?WR592YDcHIiLpldwGJYD27+fm72VCY0kYOLkvbETvAIsq4yDxPLRXlabpg?=
 =?iso-8859-1?Q?tPLEECjmwgXcx8E6xii1GegnjMV3zmD+ZXhSAbylBQLr/ZVJz2DDJUI9Tx?=
 =?iso-8859-1?Q?ULEHyjDHlZ+GwO6OBG1/8C9zAWdH6PiMHIDXEnVskLKLuVowGiLz8FSJiu?=
 =?iso-8859-1?Q?2X4zrEu6zO6G9sOQ2TvvrU3eIqf2tqKZLxpHMlt6DXtAjDpgwFdHHOBa14?=
 =?iso-8859-1?Q?CSXZ+/mWZxLTCOrF/7V?=
x-microsoft-antispam-prvs: <DB3PR0402MB38837437FCA05850840CBFF5F57D0@DB3PR0402MB3883.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(396003)(346002)(366004)(39860400002)(136003)(199004)(189003)(7736002)(53936002)(6436002)(6512007)(256004)(14454004)(26005)(305945005)(6486002)(36756003)(7416002)(66066001)(97736004)(478600001)(186003)(102836004)(106356001)(8676002)(6506007)(5660300002)(81166006)(50226002)(386003)(105586002)(2906002)(81156014)(8936002)(2501003)(2201001)(110136005)(486006)(316002)(68736007)(86362001)(4326008)(2616005)(476003)(99286004)(3846002)(6116002)(71190400001)(71200400001)(52116002)(25786009)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3883;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uIMoVOCpKo2SHyqme1Z9fzSCI23pau3gwnqE/PoH+J8sSBP2/MlKcoUBBM5IQODlp3dbMq0ja4BrNPaQVL5Ulb4x7GzslKGTeePOX7cfqg2NrdgO/ucFXQhYqJd0DoZhmsaw6E1gwSv0L3q47yEmq1a1kCNfi/xhXP484e8s0Zbt1qEc4Gb7R2cs0+2Lt5QzfFcYWRw4CmeG29fQB6fiokfnC78AxRYwt5BJa7UeDMaoVV4MTGwaNy/IqVj37qqjifaDxEmQHWCFDBvB5qnL3C02QKmxCmxRTXiAjsSFRjG24B0gaTL6c7T8ugp1QBzNut64JqOPcMb8vQ75lOG2JGKgBv2bZjmS+fGW53CgHCagxToaDffCPSdgyTKJzqcYx8ybphk1Qzid2Fqz54SV3e26wHln9/E2Y2dOm8EP8AY=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b0fdd1-97a0-44a3-f5dc-08d697001f7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 06:53:22.0538 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3883
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_225333_827798_3EDE6A7D 
X-CRM114-Status: UNSURE (   9.57  )
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

NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
system controller, the system controller is in charge of system
power, clock and thermal sensors etc. management, Linux kernel
has to communicate with system controller via MU (message unit)
IPC to get temperature from thermal sensors, this patch adds
binding doc for i.MX system controller thermal driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes since V6:
	- put "imx,sensor-resource-id" property in thermal zone nodes.
---
 .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 72d481c..ad96881 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -122,6 +122,27 @@ RTC bindings based on SCU Message Protocol
 Required properties:
 - compatible: should be "fsl,imx8qxp-sc-rtc";
 
+Thermal bindings based on SCU Message Protocol
+------------------------------------------------------------
+
+Required properties:
+- compatible : Must be "fsl,imx-sc-thermal";
+- tsens-num : Total number of thermal sensors supported;
+- #thermal-sensor-cells : Should be 1. See
+			  Documentation/devicetree/bindings/thermal/thermal.txt
+			  for a description.
+
+Required properties for thermal zone nodes:
+- imx,sensor-resource-id : This property should be defined in each thermal zone
+			   of thermal-zones node, it passes each thermal zone's
+			   resource id for thermal driver to get temperature via
+			   SCU IPC.
+
+			   For thermal zone nodes, please refer to below binding
+			   doc for details:
+
+[1] Documentation/devicetree/bindings/thermal/thermal.txt
+
 Example (imx8qxp):
 -------------
 lsio_mu1: mailbox@5d1c0000 {
@@ -168,6 +189,12 @@ firmware {
 		rtc: rtc {
 			compatible = "fsl,imx8qxp-sc-rtc";
 		};
+
+		tsens: thermal-sensor {
+			compatible = "fsl,imx8qxp-sc-thermal";
+			tsens-num = <1>;
+			#thermal-sensor-cells = <1>;
+		};
 	};
 };
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
