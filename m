Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E7FC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:23:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60BD521855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rb+yAAj4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a7j+AODH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60BD521855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HPsmR2VuGmVKypmKHjir05W/f1Pgi/HmpdPC0Pu86EM=; b=rb+yAAj4A4Q3o/
	ULNUO3iLnvpOShaIY5YMNB7U+d8aydXcQ6of3f1N+XAj9747kR4ZrF9CUPeFQniSo4UQFZxEb3CXa
	xRMqCS6Y+P89unOQ2gaSYshjn+Xsc9scUfQr/JiAYCdUPIkz0wDxnjuI9S/3T+eaHpL9DdFEWdW/c
	lhXPJSUB/TNpeEDJtdmTjByfEz0MxaU1OhrSolglrrS+Eit+L7uPtYs7SOzONw9sfAmT44Cwo5Yph
	LE9g4YHBiwLIBdcf3iM9K9aPZW8kTIb1UNff+XQVC7UoA0SRmXh4m8A10sdkNEqGpv+0BPYQNIc1k
	u7PcbnD6/jaPST4dkx2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmeyL-0005KE-RB; Thu, 24 Jan 2019 13:23:09 +0000
Received: from mail-db3eur04on0600.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::600]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmexs-0004rG-6a
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 13:22:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ys6mu1Ibz5SI6qFInUSDmmjwhAHT2+USmTN32C3cG2o=;
 b=a7j+AODHjSLbfR9tHcHX5SOfWVeD5ywaqsz5mACgUVT7PB4P52kyvdav2Vtvu3egnH0GfP1OJMJbiQiwKRvx5ZMRA3cSTkupEIVXzSuAW0tl3m2melWzZr5n5Sdlzj2u4ZPbzX+M1c75e3bdF15gCUcQOTzQD7eT+6D7boG8k2E=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB6290.eurprd04.prod.outlook.com (20.179.35.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Thu, 24 Jan 2019 13:22:36 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1558.016; Thu, 24 Jan 2019
 13:22:36 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH V3 2/5] dt-bindings: fsl: scu: add imx8qm scu clock support
Thread-Topic: [PATCH V3 2/5] dt-bindings: fsl: scu: add imx8qm scu clock
 support
Thread-Index: AQHUs+ffHdBhiC9Ai0WQGG7Cay5QWA==
Date: Thu, 24 Jan 2019 13:22:36 +0000
Message-ID: <1548335800-6438-3-git-send-email-aisheng.dong@nxp.com>
References: <1548335800-6438-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1548335800-6438-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0041.apcprd03.prod.outlook.com
 (2603:1096:203:2f::29) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB6290;
 6:Lv5L09umfxdXKWm8RuzqMmkehnUCPFupxOW1cz1KbOp/KpBM2OYDGeiZU8Jb/mdjpeX3oDb/7PMqsYwaUg0hI+B4Z9xbptbBm3rp7EacNCv0szHklEqbhofakUoJfGJ1YlvEs7oU1+OVeXuSu3Tck2XCnmA1CFtD0E4ZZQvgJlR8aXshBFOdnnPjdAjawiFT8+yPAlJ7hvBTsFmHb4LwDkIX8tSKn0rpiX6VOqtXyBOZsGRm+K2EeYk8im7y/xz0NHBmsweixiPyLU+8T8C1tVhc1iLqQfLXLju7pzogu6PhMHGB9sxyELBrGSbinb8aLvpHhw51yZ2UrhC06GRP5vXY5maV5dTSdLR1Y03kdFq+PM6GUDQN+u4a5DkrucRzLExjvXldVFu4pJNijlvvllatbr+bXlg/xxp+VsfFCu/+lTAk/5bPMzSQU6ZjDNkPWflB3Lg9Y9Xg7FS04pCw7w==;
 5:yzc8OYi+F6YgU+hGRc4D+JUAno5t47v7WpKj4qYNxm0vrgwdpunxgSZKmsV33j28xE3p84xsYAynuHAJ05KnaxkMV9lIAGJj8W6YMhU245cZvjuXqyQiBWtGMpP/VPCLJH1gwKvexhjABlo8+fKtUIjXj4HDQOHyVtwpixP5ROTVDJqujwrGHEkEF8qw/q/RifewMJIatV8/aCIAQZlC3A==;
 7:vxfMJqsXVtDp6XLp75hbHO0uqMth+QoiJARfi3OJCfNj0pAs16OklQ4Nbx0mTV2uBy7lZ/6ey4yLMulwIsM+4qCk19v1apOIJ10qpg5nQAnakohnfUrZnXNepCdN4CWv4mjEldwsfCWalrBNfQmSVQ==
x-ms-office365-filtering-correlation-id: 6451c386-9ce2-473a-8b5e-08d681ff0186
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB6290; 
x-ms-traffictypediagnostic: AM0PR04MB6290:
x-microsoft-antispam-prvs: <AM0PR04MB6290505AB3DC87025233AEAB809A0@AM0PR04MB6290.eurprd04.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(376002)(346002)(366004)(39860400002)(396003)(189003)(199004)(446003)(2616005)(476003)(2351001)(97736004)(478600001)(68736007)(256004)(6916009)(25786009)(11346002)(71190400001)(71200400001)(14454004)(4326008)(99286004)(3846002)(6436002)(44832011)(105586002)(76176011)(52116002)(6116002)(81156014)(8676002)(81166006)(6486002)(53936002)(8936002)(2906002)(86362001)(50226002)(186003)(26005)(2501003)(305945005)(66066001)(7736002)(54906003)(102836004)(486006)(6506007)(6512007)(316002)(106356001)(386003)(5640700003)(36756003)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB6290;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cP/BzxGim9zkZlz3g+YrgZPKLs5vRDs3bz0xZNmcFt6Je2g6H5n6Hmi2thMSMzzGwMVN2xsHh0f8BzpXOsjK8pLh8YlePMvsc+wsdB9uk9V6Kf0tVfpvZHQ3O4ghnZd5jx+Xn96ZIYF6R6z2tgjUMjzV/vPRQtcoi/7AlLCtpClcOgLrlnlwsSicz06tO4RnpVrQk3eCNcnjMFznYnRmpwfUlk2IRwGvL6aiKAQR5zALJRBQFocgVTw7CzOPxqs1Oeq2EKOHQ9u5fg7iyr5UbG92nr2OvWiLEA/AwMQSsS2lV/euF5EkmZBBxF/vcyZi749yzpIgtvwAuewiYpY/r2bPdcb+MUKwej9CcBLYNe4nm85GZr7kZxKsUgkJuJBdX2sfzDgsDr2wXslh/BtZ3k1VrQtWayhQTRRhgWyqi0M=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6451c386-9ce2-473a-8b5e-08d681ff0186
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 13:22:32.6927 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6290
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_052240_593546_AE7FF3C4 
X-CRM114-Status: GOOD (  10.57  )
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

Add imx8qm scu clock support

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 6b4e24a..72d481c 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -75,6 +75,7 @@ This binding uses the common clock binding[1].
 
 Required properties:
 - compatible:		Should be one of:
+			  "fsl,imx8qm-clock"
 			  "fsl,imx8qxp-clock"
 			followed by "fsl,scu-clk"
 - #clock-cells:		Should be 1. Contains the Clock ID value.
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
