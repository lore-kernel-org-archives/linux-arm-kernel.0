Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8FEC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:27:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F4AD20643
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nw5yeqYu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iL9yEtyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4AD20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hunRs6oQWTrkloy2L9VXlcNWrSq4nzrH3Pk3tY1Kwcg=; b=nw5yeqYuKkRkTn
	PsHeu6dSopFU9W7D1rMnBxbVvyrFkrpAP9Sbv4snVlVVImeealqRRIMG05atMre5LlfY15RdZ7S6K
	QavzinLOa3I+xbX53PtWdyZaHSIKsfVKgPd8jb6/IErghq6/ErKehr2T6pvI2H8rj3erNnSRdKEUY
	J0x+hRUoldVg0L1+QK7cEZztH24qbRbTzqZnNUMn9960Q2QPH/gROZc42NnFXfUpvspktpYLwSlej
	AuKcVnFARX//LVRtAC/bOAYdBMyUa8mBX1VBdwqIBOM4Xf+UFqd5xnFd7OIdlLO4v9D9QqtsrFu0e
	suD/CMRcD6BK8TaP2TYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZdl2-0007nW-0f; Wed, 19 Dec 2018 15:27:36 +0000
Received: from mail-eopbgr40052.outbound.protection.outlook.com ([40.107.4.52]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZdko-0007MJ-1S
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 15:27:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ws5XwUrCl+z1jZ5Lt7cmjTBUeO9qQdI7F5kLX1/cDag=;
 b=iL9yEtyF3nP0bjaw2JrEom0uWBroykSsOEAK/Zh/8H23jjuOf3dCtBdhy70ksjeHNVCs3Yk4L0BpQYricIbyx7z9L0+v+/9lt4Ltfskj2TKgMujxV5tqJ5Y6NDPjIe4lex6HdipZXFL4nhxmKsfJoaraVCgH+DxCsqDujtZ8VYs=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4081.eurprd04.prod.outlook.com (52.134.125.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Wed, 19 Dec 2018 15:27:09 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%6]) with mapi id 15.20.1425.024; Wed, 19 Dec 2018
 15:27:09 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH 2/5] dt-bindings: fsl: scu: add imx8qm scu clock support
Thread-Topic: [PATCH 2/5] dt-bindings: fsl: scu: add imx8qm scu clock support
Thread-Index: AQHUl69OwBmF60zG0E2AEzfG5ZkO3g==
Date: Wed, 19 Dec 2018 15:27:09 +0000
Message-ID: <1545232888-9302-3-git-send-email-aisheng.dong@nxp.com>
References: <1545232888-9302-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1545232888-9302-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0070.apcprd03.prod.outlook.com
 (2603:1096:203:52::34) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4081;
 6:GoNry2t6RAStzo4aX3GxGzHHJuefz5+3/+FleBSJdLj+EzMY1CHVHr+eHC2C5tjFI5Nu2d4IfHSVGWHo3K2jZex/KeArvCE7uCyY6A+QofX0R2Nzwd1NHYy2+NSlEbCpU6XB9RayzfxECBibId9A/bGI6wiVEqvwHSwA3YTNRGZcvLbWR+ICTSMJ/zK7ZjOnRguEU9dPnbMaeHENe7DkV5hf42vZr3vR04tu6ftDb4Ut2G3pCIjIgKV2i/xwZyVYI3z440UQXsxJphqKNiD4izNy5CHNfbgH/SLlIC8EJ0WYKcMkCjCixG+7IoNaB0iAgBcRiiqMSsIoDkUdAFiEaMEAiEpk9BtTAuiLiF36H9BzInUl6YoASddP9s+hwoRkbMnzJUaF82KzkOAP5MJKHYg3hOknI+Twpx868TwEmG3RUu00WKyHLwgzZGtZL5hrvnIq74cq8VZEMzjTbR/WUw==;
 5:cVQib1TXrhcWQACgvMX/S9Z7BGgZ4V/tdXVuYvS5YTSkAFr3FLpY6IRXSpQ5D19jpT5Z6gdkZdQT0x12VX2PZdRkM64dVNZKqWfeWxxiYWjaj5pM+VF3QO8fy/OhzVjPvr15crEw1NvYgx+l2Er43OSmERWAVPxRRrDS5CKh75E=;
 7:NaGBq62ZsaJaYcsCYfvccpB1tzaMSiyNMbh/zVFRuAx20M50qU+Z/1E6TYGeNBrOjaVWxfpW4IzJ8MEBmzy/uz9fXuzzYIquFE6z5NMqEC47uiWXdO5fJHiQBLTVRmB3iEaWAlmTkKcDSJMBMcOQAA==
x-ms-office365-filtering-correlation-id: c4d9c376-5b28-4192-e7dc-08d665c670c6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4081; 
x-ms-traffictypediagnostic: AM0PR04MB4081:
x-microsoft-antispam-prvs: <AM0PR04MB4081DAD647F6E81FBC8A3C1D80BE0@AM0PR04MB4081.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4081; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4081; 
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(106356001)(3846002)(53936002)(4326008)(105586002)(2906002)(2351001)(66066001)(6116002)(6512007)(97736004)(2501003)(81156014)(81166006)(14454004)(8936002)(50226002)(86362001)(478600001)(26005)(71190400001)(8676002)(71200400001)(25786009)(6486002)(6436002)(186003)(305945005)(68736007)(7736002)(5640700003)(54906003)(76176011)(102836004)(5660300001)(6916009)(99286004)(316002)(52116002)(446003)(14444005)(256004)(2616005)(6506007)(486006)(386003)(11346002)(44832011)(36756003)(476003)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4081;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XFyE8Sl+72Nb+JopGhe8vqOlw/eSkwbPCD5EImrPvaBR1lkuSJV04DmsiYRh8PybFh6SpJP1efgg7AfsJITY2EXXMG0vixOXkKR8/7gqbgzCJFOp2B4t68p6hAeEEEFkzSE4OOUG9+xTB+Hna567ODb1zha7ns4fdt11iCAHP03DhgkoaC+T4zCL/Gquh3oSMJRAyG48MusWa7vj5Ju5BrxtqYxIcaniTH1+ORtU/WFY86MTNqq8Kp2eFetG9SeqeviYLPOxOfSNpJBgsabgZBt6clWzCllqyS2b9A36rFAi2gWAaMGfKfhAV4xdnpK5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d9c376-5b28-4192-e7dc-08d665c670c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 15:27:09.3423 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4081
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_072722_112719_38BFBC9E 
X-CRM114-Status: GOOD (  13.27  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
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
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index b8ae529..abed97f 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -71,7 +71,8 @@ This binding uses the common clock binding[1].
 
 Required properties:
 - compatible:		Should be one of:
-			  "fsl,imx8qxp-clock"
+			  "fsl,imx8qm-clock",
+			  "fsl,imx8qxp-clock".
 			followed by "fsl,scu-clk"
 - #clock-cells:		Should be 1. Contains the Clock ID value.
 - clocks:		List of clock specifiers, must contain an entry for
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
