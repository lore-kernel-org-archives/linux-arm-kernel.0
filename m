Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27250C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:56:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED6172064C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cX2oTau6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FCqHuUvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6172064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cwI6qL/j/X3EzSpbqC27VwtYhj6VASI+Rjsj4t5smbs=; b=cX2oTau6xQ/cYH
	5ddKxnuZutHiwoJiyjURIW/b9jXYfR3Fwco/T/0AkMMnviaiZYBk2vWidcACcHNid/9SCoZUh/+a7
	AVeJoPG0AUaGmz2MaEiJtmA+5xWDjt6O35iNjP2yrdANOUTzEexAL4PAY+Np4KVFZdsYbjjkBVr0z
	dVzB7uAOn2YY+N2Vp2i4KzLEAGp/aKXp0NOEGBpBY4CX5Mgs8f03S/0XPpCc2tMHcceNlo474UDRk
	+cBENIh+nqpMgU+HZtEegABqqB92Fp8gErnlsqDLX+LcbWbOJKF/V/N4oNFJXxl7Ijna8SSccN7Fd
	gnCvZx3Wb9A4fbb8Spqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghvQL-0005YF-1U; Fri, 11 Jan 2019 11:56:29 +0000
Received: from mail-eopbgr30042.outbound.protection.outlook.com ([40.107.3.42]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghvPv-00056h-PP
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 11:56:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBAptFk6e8pShXlMBsateOWHrrcALuqlDnDlN5NfSrc=;
 b=FCqHuUvtCWUNJLP3Ql2PcYOfkLkNvMmouOhjQHHaiSuTCD5qlutJR4Uw3FVYbIMZrPZTjW78RQNXArDajkLTFSmjxguuDQUeICWOkisl1HQoDD8wsCatkV7IW8PBv3MDrzca1fOpG1spGk0QdcNWWsmtHngxH4BGX/IUYscfWzo=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5281.eurprd04.prod.outlook.com (20.177.42.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Fri, 11 Jan 2019 11:56:01 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 11:56:01 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH RESEND v1 2/4] dt-bindings: fsl: scu: add imx8qm scu clock
 support
Thread-Topic: [PATCH RESEND v1 2/4] dt-bindings: fsl: scu: add imx8qm scu
 clock support
Thread-Index: AQHUqaSfloWwjzPfcU69BMY7ob8z+A==
Date: Fri, 11 Jan 2019 11:56:00 +0000
Message-ID: <1547207400-28307-3-git-send-email-aisheng.dong@nxp.com>
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
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5281;
 6:L5QmZLImakqgJV0pJvi56mGnRrm3hC/WW2mevO5uLowsSgvsu4jKemFVp33oI+Vj5ljmukDOla4QGHnQfU/RAjo6TbwfmyExK2cYfiCnc8Syz2H//ceUP9R6e0oVozky2qBNzRsaMDkRL7DyYyRDMJlgzBl1Edbx8ChKGkWx1LN5a2sl6XMm7c7aRhq5Dym2OEBmGmWuJ1ras0+098TFNSyXXnvljMUzAjf4PnstCWMd0J/s36LQVlZ2PP4mxr4zsJZEq6UxIhMbg5XuAxmHOsj35trTsigGlI+GBtexOWk5lbJ8RVyEglA0dxll1Z4WWaWDt8RMLSB0RNshvzvriCYadoaI/w3PivGdcBKiqD4VZnb+FbrxjgCHwe7GN+VaGN5ZhgqrYp7g9NgxKuaYu3fPKdoIjO3SGVgxmeNU477cFIcngojoTtapjnLKc9gLdhDYxv6F+MT9oGhsttcmnw==;
 5:dcrBLHX3zqbWHsdxmzuHloxX801EHPG5PAt9T2S1aUgFrjSeciD2sZKz0Kmkblvm5fm29ew0Jresw2hG1BY926I7kygkBtckdMFnKQIiEAJf3ZZHyPZJjLQmh5PGZaFY+HqKnyBihuuDh4q+mxtzg+wmEcmSYC4MiAeIXPkhUNvvJQ2sc80LXIEEB1g3Ehnq87/3U8x+OaO5VrqirVLECQ==;
 7:ozqQABjuZC4x/gHouwEfF3UvHLYFH29uXikIPEYKWSKX4V8RgN2ZDLw94iGUMkXAUTYIsAmTx1B8kr2NHP98QBIhOuDDt2y25E3duEUYeBi0RlaOOw9WI2g6NdbBzuzvimq3OGeU+uCRcth/vCwaaw==
x-ms-office365-filtering-correlation-id: 6435f977-42ed-4e23-5343-08d677bbc14f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5281; 
x-ms-traffictypediagnostic: AM0PR04MB5281:
x-microsoft-antispam-prvs: <AM0PR04MB5281486A05024D996F46EC0E80850@AM0PR04MB5281.eurprd04.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(366004)(39860400002)(346002)(136003)(376002)(189003)(199004)(105586002)(106356001)(7736002)(2501003)(305945005)(71190400001)(71200400001)(4326008)(5640700003)(25786009)(50226002)(8936002)(81166006)(81156014)(8676002)(54906003)(6506007)(6346003)(97736004)(186003)(52116002)(316002)(76176011)(68736007)(217873002)(11346002)(14444005)(36756003)(2906002)(4744005)(476003)(486006)(3846002)(2616005)(446003)(26005)(6116002)(44832011)(386003)(102836004)(53936002)(478600001)(86362001)(6486002)(66066001)(256004)(99286004)(6512007)(2351001)(14454004)(5660300001)(6916009)(6436002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5281;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p11ucBd2Wktxdlx2Chk4VViSwkzXB/dG0IQ3ZAIv6fs5ogDy+rqcb9bRNscfUSAybHVp01U3+AClMXJiCEmL30ihFjQiCU5KLoZwBOIF9n+kMjt+ysZHXpG6DIefNSW7oMolqSAfMc5QkgxTH0T/8Jya2aNHRyZiz+ZDGRmSeFI1n5cGR8dKEnc2gB4oQNAqahU4EijzcLn1rhcMNf8oDzzt3oA3jYtMik1t3L7ai9fWroFU4TUvjBko4TzyfaaCYn8UuXgJp0Dab89DzIGi3Ho6n6Pg7/1L3hust9qwszH7wwiwlqUzz8Z62A91wOaLtJSMcy+6tYLErE0UOPFj9BQ9v90l83HaInvK4li1TgDb0AlGrmxeyRowWqh7XBhdyFiXJy522AIBGxQT7FoscLfyh/qi3vt8pHfibvGzrBg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6435f977-42ed-4e23-5343-08d677bbc14f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 11:55:57.0089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5281
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_035604_529336_09A6E33A 
X-CRM114-Status: GOOD (  13.15  )
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

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 5ec6dca..b6a883e 100644
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
