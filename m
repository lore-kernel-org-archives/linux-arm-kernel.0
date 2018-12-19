Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F762C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:28:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2CEC20643
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N05QAmiC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SH864fl6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2CEC20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jB901hj52jtSm2BrJeaudTzTwlemy8LcngmARHDBOi0=; b=N05QAmiCc9icCo
	aqfzZrByUJcYaoRmx5GpsWcumRRrla2IcTMULEa+JKupB5bk3d7aLlJagk6Jr79iMv3yJ3wMC33DJ
	E2ehsFd3wDtghSf5NWMVZOMWLRRswugb9gXMLuDPKpsLtL5JEVTaLV78OvhorT/R+OM7NtK/e64wS
	8HYearBlDWlZRilR8A1t+PC2+SsBvIxa9ij5oM2ZfJriB0v+fECO4JMkZRMsAjLbclcjX9ziKt5P8
	w7lfwqWFprLNdeURQAAbJrKmYrJnZb62TQh6FZou4kKz1F+GijY9gjuBphQIFaZGV70u9agb5b/Xu
	DCsjytXgaVRuA2rdgnzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZdlX-00088x-2s; Wed, 19 Dec 2018 15:28:07 +0000
Received: from mail-eopbgr30085.outbound.protection.outlook.com ([40.107.3.85]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZdko-0007KE-Eo
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 15:27:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dDZ7Miqhb0IUTJHyxTppb0zZKNGW2LePEovVohzDno=;
 b=SH864fl6s5FCzt6c6xo3/RDGs/e5qxQ8MwDh3bsV4bFZynfjNJ7pGiAhaTiPZekErWB7xI7vM9tUbSG9mpTV5nCZV8bphXLEIdu6bD9/HyrUsSJefyZSBFlVbpdLhM5q1BCq+bHgvPnpYSwHimUfaw55uzXZVRwCU7cXIC2YNkU=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5633.eurprd04.prod.outlook.com (20.178.118.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 19 Dec 2018 15:27:05 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%6]) with mapi id 15.20.1425.024; Wed, 19 Dec 2018
 15:27:05 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH 1/5] dt-bindings: fsl: scu: add fallback compatible string for
 clock
Thread-Topic: [PATCH 1/5] dt-bindings: fsl: scu: add fallback compatible
 string for clock
Thread-Index: AQHUl69MU8pBs3xjkky4hVIAq3dwIg==
Date: Wed, 19 Dec 2018 15:27:05 +0000
Message-ID: <1545232888-9302-2-git-send-email-aisheng.dong@nxp.com>
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
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5633;
 6:5SzM/32P+EyZcu3BNjRL/jWsbld7SLtJO7KkAlYwKVyAGioxyGTWKhzuFgIThyB1zngeajk7EU+0QH/pJ2LSAmXzpY1m1iC73JP7Eon/fPf/ca9WTHUx84cSKc6qMspLqq9VVme8CQxGvVPqO/MXiRKs/9bC3msW6+4PiRAG04gbtmIQFvX8Ug1/2wZ6WtA+/3kj/1EPzgqE5I2K7i5QTdhaDOpEa4ER+Rw8TCpaBkA90K0ig0wF6Rb1lrpwQ9QLgkoAvk9SS29Od4Vu4y2metDcfWwwuLWBxvAMj/dpljlsNKw1SZHzh0s3m3ViTeDbJs8YYltlFuGalf8b3U+1HlSSXqWKPfuoOyQERerSjh0jo5nvzLyKI/73SXrUJkx6MNwVRGQ+nns2TwCY/geDH4X4nGmHV1xPYCJ1nKeqIvWcXBcwEM4O66AAL4Amrr/BT2D67JAdh1cXib3kgO7mSg==;
 5:DxFbDW0s7fQJq9tzxSRaQb1NT852FvnPCcIFrAseRjU2ZV9UYRUt/MKe4vCS8K0rZBpz5SiiUjvJ8hNm0yifco+X1+/gb8zwMYMapk7FAQhxPpEGpZUMRgTTl0tAXudyMl/Z5bKnALjd+xjjJHcP9HMu/BlFjBHJanQP2n2b0gk=;
 7:MAWnMtsE+lr/KoAnNcsz9kK1xdpyxyHAiIGP9YDIeR/AHJqt6dYoTwBs/r8X01yuAY/oAZlvRzUn6Oa6kyNXtCKtilucwsOjrr8am271CU1iJ323OPqjXlgEhvx38w1jZFrU664rqixrMvAWKXUoQQ==
x-ms-office365-filtering-correlation-id: d0063a59-d44f-4538-76a1-08d665c66eae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5633; 
x-ms-traffictypediagnostic: AM0PR04MB5633:
x-microsoft-antispam-prvs: <AM0PR04MB56332F0A23DC88FAB08463B480BE0@AM0PR04MB5633.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5633; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5633; 
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(366004)(136003)(39860400002)(396003)(189003)(199004)(2906002)(305945005)(7736002)(6486002)(256004)(66066001)(4326008)(6116002)(86362001)(6512007)(44832011)(3846002)(54906003)(97736004)(102836004)(186003)(5640700003)(2501003)(53936002)(50226002)(68736007)(11346002)(5660300001)(476003)(81156014)(2616005)(386003)(8676002)(26005)(81166006)(105586002)(8936002)(6436002)(486006)(36756003)(52116002)(106356001)(25786009)(71190400001)(478600001)(76176011)(6916009)(99286004)(446003)(71200400001)(6506007)(2351001)(316002)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5633;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7yhaj6nvTECoduDsO45NFosmO/oZcNomGNyUiFJ7rmkoJjwPlQjNJCip7J/Pq2j7WYMgKeYI3xrv7nFbFN05LsO+8Np/s8RXOVx+A3KQ4938hz1ubzt/Jl3hIwUpv+KpkCAAao7VgRe5jA5AME6TeI+5AVo8MZZNCD8PO3zFmUdy0GwI2Oc41K7YaTswXcnHtEAzbXI9DK08avnqO/LzINvp1R50J+R2Jgi5WUTo8tRgB+oipCtbqZN5UG4GI/mokAYHH1IqS5eqPad7rj4muthWUvkc2n8H32WabEyT6XvwMU8PBq3c8kM1MUdAKgJf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0063a59-d44f-4538-76a1-08d665c66eae
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 15:27:05.7798 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5633
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_072722_579310_AEEFF63F 
X-CRM114-Status: GOOD (  15.06  )
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

SCU clock can be used in a similar way by IMX8QXP and IMX8QM SoCs.
Let's add a "fsl,scu-clk" fallback compatible string to allow other
SoCs to reuse the common part.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index c20f38e..b8ae529 100644
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
@@ -128,7 +130,7 @@ firmware {
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
