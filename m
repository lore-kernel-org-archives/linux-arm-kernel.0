Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95968C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:17:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F7D21726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M9GYW+Qq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K6EBjYH4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F7D21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NwXe0Bg4OMAqSLbCYPoA3TgKLzyxO/ofQ6QY7GnTrf4=; b=M9GYW+QqG1nh2U
	7RtqPHiMAXCw+6qdDv1Z1Iz7eGBnpYuorBtYHQyqhHAMjtGfgm55k52ku8AQ5tzqySbfa1qUgGSXG
	clAmv8E7jNzYSXehrxD/0n0M0b6hiE3ZfAXXH3+D8JvZAHRShpvXqIM+91C4Y+qqn9Ehjah/+9YKr
	K6RXnldfSjIVpafAlBDeS1591/zhzw94EcwEWcSs99fic+zpQAaKMmUnXpNXK4DqNfs9hIB+bI7Qw
	6X8nIN4Z1Wp4wh8T43J+/g0pQy44mpw44f1g6IBDJEQMY+c3d1tQ5j2XH2StSWIMSgi784m726ZZz
	2XNutZU7+J80DdOrubJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmDiZ-0004qh-9L; Wed, 23 Jan 2019 08:17:03 +0000
Received: from mail-ve1eur01on0606.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::606]
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmDiH-0004LZ-RV
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 08:16:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=my6PkXqEDL51lPUB4QH1PsIQooA6ziS1Wj4ZvbZdUnM=;
 b=K6EBjYH46kXNJv+Ara6Yhkr7flG0Fo1+Po095FO0SfI6hanGeBG7ktgkZ6f5IEORAXyPzgUZA8Np7yOiMTZGRb+vbxXylB+GSYfsacgkLXWpFfSazv6eoYtIcpmLONaDH8CYFcBajiIMNYBJtWFBYugPovdhI8D7xN9bQUKY2aM=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4482.eurprd04.prod.outlook.com (52.135.148.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.30; Wed, 23 Jan 2019 08:16:44 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1558.016; Wed, 23 Jan 2019
 08:16:44 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH V2 1/5] dt-bindings: fsl: scu: add fallback compatible string
 for clock
Thread-Topic: [PATCH V2 1/5] dt-bindings: fsl: scu: add fallback compatible
 string for clock
Thread-Index: AQHUsvP5vkju9pZWG0y0vnLUJ2sC7A==
Date: Wed, 23 Jan 2019 08:16:43 +0000
Message-ID: <1548231044-4344-2-git-send-email-aisheng.dong@nxp.com>
References: <1548231044-4344-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1548231044-4344-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0020.apcprd03.prod.outlook.com
 (2603:1096:202::30) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4482;
 6:7NgtfLy45HsZbDr+x2jEdj6rOrtCcmiCmRM43+2zSIzrx6eki1q5gu1Ny8yw71iTJ+NMZrb41DWgibL+YTj+Xb7WCEUHl4Bxf23LQS4TJY4JpituKUv7YAgdLotLKoVRLvr/5fcMWaQk/I8sFBImrADKiM277KlHPkYhBoxLcXWc4QF4qJrL4/tNc1ZN8lOQjEgtLQq8W7t2X4qKwiW//evJKM+kdfGTF/BYCXJBeno9LieXgYW3LwG8XwwOi2ZoI9VE6ZDsgA9XT8ED3EWtPGK+1u+0hFLSsL9dLoIpxBIeSKO7jWlPlkHK/mAp3Bk/QGs+9OiP9FWvHzGxmM/GP/e/8rATW6I7WyIUuaOS5/eObp4xiovgmrH+VVDiF3TQaGWHnPJQY2CWiqtBsqSPOjhWHBukWPNZFqxWIaKUQvl1ZADFr/8blt7C2hohWzexAk+2MhfsVOHuTLBiVaJJPw==;
 5:KXZ7NALBSfUh5vLd3rkbfWqQvSsihSeIgmt3Z2QyouvSuz+G+5OPQ1xnZZWEkNMB0Bsq2WbsCpd0xGU6nK9vxlPgCtm4BaZNkYAMeyOzITaj4cxgIboXwWJH2AezU55lyHbvmuBV5hHaTvFi41W7Mz5IbyhWPNWNyUS613hBAA8G90PldpCEW+0V1RIXuhn6JMyH68/tyBbbJDUG5Y3vbw==;
 7:Sy6TdyHt08vaq6WFf/qdpWC9DHx2l/Ml3nEBDHuioBv4dApCMkc19ZPklCT4zmEaze6Z0XODi7ukVp5Y9rmHbj1wqBBeittEu81CvkTknrOkknXTayAtvvPmOQZgdidEdgWWavGVtbtTfHxobSA83A==
x-ms-office365-filtering-correlation-id: 76582ca3-7188-4cf2-3573-08d6810b1c35
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4482; 
x-ms-traffictypediagnostic: AM0PR04MB4482:
x-microsoft-antispam-prvs: <AM0PR04MB4482C60FAFD90417FD2F426980990@AM0PR04MB4482.eurprd04.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(39860400002)(346002)(376002)(396003)(366004)(189003)(199004)(8936002)(2501003)(50226002)(86362001)(81166006)(81156014)(8676002)(305945005)(7736002)(478600001)(14454004)(66066001)(25786009)(4326008)(97736004)(6916009)(6512007)(53936002)(106356001)(6116002)(3846002)(386003)(6506007)(105586002)(2351001)(26005)(102836004)(54906003)(68736007)(256004)(99286004)(446003)(2616005)(6346003)(76176011)(71200400001)(71190400001)(52116002)(6436002)(476003)(6486002)(316002)(44832011)(2906002)(486006)(11346002)(36756003)(5640700003)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4482;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lhMr/XSPUFLZrQQLrVaoLpXgS/gBlM0G3ys0LebYWl5stLvxEvPNBBgr8KtioIgVbQED/Z7JYDS4EtqUrnrlvNGfKKmqrGVFaP3H7elOD2hXRyjcThXEQYGziOH89njOiyuU7qcWiAUyRede9YLTkSrRiceIZJj9dzUx3PJVPHXnY/izcUGUYQ5PqZdRT/yMHGO06QL8ufiDVVEIgjClKEwAHY9EC6pVXIEFakaAV/0A0HsC1rmxEu8J83lta4w8IMGjAGwuomEH6Ar0w4YrJIAe9ZjXEVWhAnxjtGFbiu87D49YQ92q/SjLq06bI21AEe6VpBOUH8C/hLMm+2mZD4wv4TDiCAG8fnQZXlgAfIYHEzmJGEhvin80UpWVKVLYU/2hsQoHY4ZovP89FkSyFZq4t1Z1CUt8ODiVTNnS/TU=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76582ca3-7188-4cf2-3573-08d6810b1c35
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 08:16:39.8979 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4482
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_001645_887876_F1736450 
X-CRM114-Status: GOOD (  12.32  )
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

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index fd2bed2..6b4e24a 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -74,7 +74,9 @@ Clock bindings based on SCU Message Protocol
 This binding uses the common clock binding[1].
 
 Required properties:
-- compatible:		Should be "fsl,imx8qxp-clock".
+- compatible:		Should be one of:
+			  "fsl,imx8qxp-clock"
+			followed by "fsl,scu-clk"
 - #clock-cells:		Should be 1. Contains the Clock ID value.
 - clocks:		List of clock specifiers, must contain an entry for
 			each required entry in clock-names
@@ -141,7 +143,7 @@ firmware {
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
