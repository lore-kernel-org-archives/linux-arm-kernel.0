Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D62C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:01:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C21972146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GepiB8i3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nhi5kcgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21972146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q+ivk/Y+7FmNwIbO0jNnGSI+yooGzu5v+NWY5pAghNw=; b=GepiB8i3DoWD9i
	aGEGx8vCqaiN7tJSAiuy+VuWB7JbQZWJ5dP6xsbaCQ9vl6mILUSIEQ2OpIRxRkj8JQMYw87Xzpole
	h9UyBvLoMa7ojl57FC8MSCiS30RlObKalwEIrsS7HBc/ieXCAj5X1YIJUy1QC2rrxPsKM1eqt2gfo
	iRZh2jxwazvvUVoGJMyoM3yTP0aEzmZR1C6wMNZ3Aid5oVgi8fGEyF5/oZh53+UBqUaPWW61cI2xQ
	dOhKeyihh7cNllXDEtphZsFYypDhSBBxlMhfuGaKFWcuYlcgH50qNehSgIbM7lFl8kh+CSzS1ZzUK
	u/6wawvMl46mtHBmqNtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghvQ4-0005GZ-1n; Fri, 11 Jan 2019 11:56:12 +0000
Received: from mail-eopbgr20078.outbound.protection.outlook.com ([40.107.2.78]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghvPr-00054A-76
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 11:56:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvChuRwk1T3WH0IZydd5m0qOvbed2iqMx8njoq2D8Qg=;
 b=Nhi5kcgYRwW0HKJf9Zf9EurxrG91B2fLJMvMzLIfSP4ymozdkfxepoohX5iLkxeYo4UiSnxMwU64K9zZjJfn2EHV0b7tfh7TCPZ0QqFVeso8slRmDgYHfuWvtMDuvDyOZtAHJ7TUH+moR3oN04rr5kponKfaXsB0FbdTuRmFlGM=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4659.eurprd04.prod.outlook.com (52.135.149.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Fri, 11 Jan 2019 11:55:56 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 11:55:56 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH RESEND v1 1/4] dt-bindings: fsl: scu: add fallback compatible
 string for clock
Thread-Topic: [PATCH RESEND v1 1/4] dt-bindings: fsl: scu: add fallback
 compatible string for clock
Thread-Index: AQHUqaScouu+rHXVuEW5bMOSXvrk/g==
Date: Fri, 11 Jan 2019 11:55:56 +0000
Message-ID: <1547207400-28307-2-git-send-email-aisheng.dong@nxp.com>
References: <1547207400-28307-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1547207400-28307-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0063.apcprd03.prod.outlook.com
 (2603:1096:203:52::27) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4659;
 6:/OztD89ox2kzO3ZcQSdALTBMKOC59352+0ayoI51q7Yb1w1ic/mSOt3KR3PZzEfN4FWCwLlZ79TPA85of94bP+fBahrrCKtYjbOVQccZy5KtASGlBPk7CQSKpl3q9s1vC3y1yvUmulLOnfqtAXUqvwRjs35oxErBzIp72Z2XABpm+lbZSF0lZyl5sfPZ+LXfDL2d7sNCb+OI8bS7uXHML+7gYvePBuu5c4qgORM4ZLG/RPzt4eCHTarKjxPlUBI5S1GtFAEhjRWK+iKjswpa1Jr41f4XwwyIycyt9AAd/3GUGiRGb/4441XlURVsdH1SHxioLgQNCsH3T91GKSUDQgf1FYNFn6OJDVFcMeOyTlA8weGCpVozJItV8HYABiSyY+GkSum10p1jEginGA1DNMDwsIj5qX0UJuKo+fsYqQL8gs3WpBrlrqJmxwGQ9SbAP6tJHEZSBm2r6Khynd71ww==;
 5:GtkoA43BbTLCcVcwqrQ1SO/a0nnEC1IvCHCB39+6E388rwHsVkQnDqPphrqYYdv2hDxovJ2DpwKtoN4l4AUfQQUKyER3g+oqrwNJEP1GvBppftj1KQoJxIS1Mlm763XDjxaS0l9GwLa4/Cze+gTn35uPR4+DXKDO4AqB9Q1CsTZ230eWggbQVtYx5zKXQYbPA2VJ7hJh/UdaKBgiVu+C9Q==;
 7:jXaIHM9h+mzIFG+eCAFSRC+EIEvlWZjuc00FLZXCY9a/5W9DClAb21ho9Zket4x7EnhBaRx/QxVZv3H5rsEzgK4tlgB/HBL+R8zRaUdVuOjUwg1PLo4XkOVkFp6KcU3JejPuco8n1hrGnsHiZ7As3w==
x-ms-office365-filtering-correlation-id: 431fc9ea-ba6e-4096-c6ac-08d677bbbeeb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4659; 
x-ms-traffictypediagnostic: AM0PR04MB4659:
x-microsoft-antispam-prvs: <AM0PR04MB4659D3381C1919720F8CB42080850@AM0PR04MB4659.eurprd04.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(376002)(39860400002)(346002)(366004)(199004)(189003)(478600001)(316002)(2351001)(54906003)(14454004)(68736007)(186003)(105586002)(106356001)(86362001)(4326008)(71190400001)(71200400001)(6486002)(76176011)(52116002)(53936002)(5640700003)(25786009)(6436002)(2501003)(6512007)(5660300001)(97736004)(44832011)(256004)(99286004)(102836004)(6916009)(217873002)(26005)(6506007)(6346003)(386003)(11346002)(305945005)(7736002)(36756003)(50226002)(2616005)(486006)(66066001)(2906002)(476003)(446003)(6116002)(3846002)(81166006)(81156014)(8676002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4659;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FdHuVlgagPrpZ16iOYbsD3BZ4XaBMsKTZe8ehF0+p7NMUNfarVZO72OyrM7tHPuxwkWgVokPwsFao9BGXC975xHLOSf0qHY32z5y563t19C0E3n1aan/kzCWEIKHN786DQZnY82BZ1D7Hdcjvyt41qJFjOELlIOpCUNUIvglBceTyo7BZL9QmQvbg5ZBb6iU2vH3cum4tJ4+pbtywtfQdLpLPz9G4wU6V34ZOVSgDrKDazedaAf/czgF/orI0gAvMl9nIVomuhQqmFImvAhoi4B8A4OCGqHHBzucfIvQxGhMbpk/dTD3Xf03mIkCeCG3btlELm2OPfyGvHvjQXxGNz56CrEpO6s5Y/Nt4CjXQXNLkwEilR227DjCJGtg2W43MGJpCwfWey704AG8bGpItwNc1S4vYCKI7cikemICrI4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 431fc9ea-ba6e-4096-c6ac-08d677bbbeeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 11:55:52.9991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4659
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_035559_266410_9894AE60 
X-CRM114-Status: GOOD (  14.56  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SCU clock can be used in a similar way by IMX8QXP and IMX8QM SoCs.
Let's add a "fsl,scu-clk" fallback compatible string to allow other
SoCs to reuse the common part.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 27784b6..5ec6dca 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -70,7 +70,9 @@ Clock bindings based on SCU Message Protocol
 This binding uses the common clock binding[1].
 
 Required properties:
-- compatible:		Should be "fsl,imx8qxp-clock".
+- compatible:		Should be one of:
+			  "fsl,imx8qxp-clock"
+			followed by "fsl,scu-clk"
 - #clock-cells:		Should be 1. Contains the Clock ID value.
 - clocks:		List of clock specifiers, must contain an entry for
 			each required entry in clock-names
@@ -137,7 +139,7 @@ firmware {
 			  &lsio_mu1 1 3>;
 
 		clk: clk {
-			compatible = "fsl,imx8qxp-clk";
+			compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
 			#clock-cells = <1>;
 		};
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
