Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6C5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:21:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78F69206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h1kqihXX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="otaTfd+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F69206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ipn+gkjI6ortGZ+LEV//+NfmELGLEEBI4X7UfhOhAk8=; b=h1kqihXXkVkJ+R
	+OGe4b74/4t1XQg6/G7W3+h+9LrHwugrkryWS9rybn+dOZ0XFLyj05pP8ByLytaVenhmeKZWIgKDu
	KTswqB6sQk5FfEDUKfhJQyn0/VVZIaB0xbJUHN94YgJZc+4jG5KrjT8lG1mTGvvfjpuzGIY3cvbGI
	es2dIn4ifgTESJ5MaNgYuEoEMhc3LuBcOIFIJr4bEaN4ySHVm5aN1IGgEpTrSA9YYHCATm5rsWrBV
	7u+gbsA7mQ7Sox/cOUlSDWXcm4VNHW43HHw/eQ40LprPxy/2iPAw4cBr/hvLYFKoCWj99V5RF6l4b
	CmwsShNfpdN+vb5+95Jw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjl8a-0000DR-IP; Wed, 16 Jan 2019 13:21:44 +0000
Received: from mail-vi1eur04on062a.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::62a]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjl8X-0000Cx-6U
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 13:21:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FhTNNMGl06GKrhzfdZ7UeZW0ETplLk8BD/R7JSIuic=;
 b=otaTfd+depZM2zjIsh/1J/E3E6fFsqmE9hAE9rUpAZa1MmK0AlZqp/mWcTYSurDfSvdf7sh88BUvnHn0ZRNi7TGuQstydK4xCmYfYdd9f3J9SqKzEociBjtV9iFYMgquUHGvGvHBUq9BAA0IJwaI1BMLWiUVj1f8UTXXbRRSN0A=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Wed, 16 Jan 2019 13:21:36 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::a8aa:5f09:1d1c:7b57]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::a8aa:5f09:1d1c:7b57%3]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 13:21:36 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: [PATCH v2] arm64: dts: imx8qxp: Fix MU4_INT number
Thread-Topic: [PATCH v2] arm64: dts: imx8qxp: Fix MU4_INT number
Thread-Index: AQHUrZ5o76DkAvPevEK4JwTurBqFmg==
Date: Wed, 16 Jan 2019 13:21:36 +0000
Message-ID: <20190116132124.4383-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0002.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:d0::12) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0402MB2800;
 6:JZ7UJCC0bodwKxKrB5SqJ6q6jbPkeRjxpnz8ak3fpQyYlfZI36ysHFH5D4uefTReBMHWMCZ0g25P10Yt5Ep4cfCyvjxOOadLkLJnhwwS36Y7bZia+A8pxXPdmJLTwCXRPNrWKoyWHEqHsIKVLudC51MbY9ZqUR7QYSAJJbFtL6k4UASsq4l2iQVuFi2yIgLAy0yghQMB6fUkHke63JDbBdRwzDDDdcVAtUcJooEgvJUHegFU6mDf6Hiyajw+aYiaMKRvs5cscBS1eceGGJvdakQNOFpZCEsXAQA28zJ+VfdVjkGHFEyBwkMFzShhNxgj8zK2kjO3deqPE41CQNcS89zAayyz3wiwZG1bSEgMXFTOCBAdh9lg+3w0h7eV/LeIEweubWQouNx4nnujNftqANvoOmo5OchnKF+cNuMtCVAWewEWeKsix/ogznuElo+Xrz3AWQVuAKyKm2u3Oo2NUw==;
 5:m6TKgm+FkmCZsRiodCrbwfxnz9PyFHl6F9ytEBaiQuDka5LBbpmBXXBn6JlNp4cERdHXlpErI6SRRixEDbUmhv2X4cVJCIjSpQWB9lVrEYb8DnlB5A++ZDMLgThiBFL8lXTgmJ/dVYGLIyhD+phqMM6hU2av+TNs/9B7yDHdBgl7OfDAMfPDUR4oPzUVw1bTvBbTHsNmrrxkTbVyYVKWEQ==;
 7:MmDDA3xeMSKmvLHXqIrOmtFYKBv9De24PhG+oNob7kSgrBN971egQeu1+msPM0/yvpYw/TjS2HxL35XHmQO1C0oJSPv1d83QooFs+prUTf0vKJypk1pvnJnz4fTC7UnqEf8JE0EfvJ3fFRzSU89zqg==
x-ms-office365-filtering-correlation-id: dea30276-a446-4026-025d-08d67bb58a61
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB2800; 
x-ms-traffictypediagnostic: VI1PR0402MB2800:
x-microsoft-antispam-prvs: <VI1PR0402MB2800B57F941680A46F8B011CF9820@VI1PR0402MB2800.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(376002)(396003)(39860400002)(136003)(199004)(189003)(106356001)(26005)(5640700003)(53936002)(6506007)(486006)(316002)(7736002)(1076003)(86362001)(6916009)(44832011)(14444005)(386003)(66066001)(4326008)(6436002)(476003)(2616005)(305945005)(186003)(2351001)(68736007)(102836004)(105586002)(4744005)(6486002)(256004)(97736004)(14454004)(2501003)(5660300001)(8676002)(52116002)(71200400001)(81156014)(81166006)(1730700003)(71190400001)(3846002)(25786009)(6116002)(8936002)(54906003)(50226002)(36756003)(6512007)(99286004)(478600001)(2906002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB2800;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GwwpLL0kJfCNRrPyUM+PGOciP43gd5P6kA9oOIjhBYjWf1JJyottf4znFUKPK5nQdK4PF0dFwKDIWZEsItwTEsq6qTfAZi39hkdhTb9EZeC0VWHZ2gzS3JiQElRxMNjYaFFOnfKFnynDjtI6prAiigT+hLQr8OudfK7C9DQ+QaIu8xqeBlhrObH8QzXvRZZuSfQEdDS3zjooIneYBMeLj/b4fbM6/mrm558F8s3Z2HMbSTrAW/S53hMD72UUER9L9V0VqPDz2kFR+eZSSyGk97pLEkofBjGKjFRmS4xi66NPOQNhcLlyLw8loxMJNVrWpdy3WC8dYUQzIpIYJvMcXlkn0gmEdktjtkNSmaK4JIjs6cwVOddLpRUp3+enqH8/QMRMNOUFl4eelLg4CEL3pWP0Emnpdv5E2we+yAyBEXE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea30276-a446-4026-025d-08d67bb58a61
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 13:21:35.3969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_052141_316434_2E4DAF09 
X-CRM114-Status: GOOD (  11.91  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 Anson Huang <anson.huang@nxp.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>,
 "S.j. Wang" <shengjiu.wang@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

MU4_INT correct number is 180, while 179 is for MU3_INT.

Fixes: 3d91ba65fec ("arm64: dts: imx: add imx8qxp support")
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
Changes since v1:
	- fix subject prefix 'arm64: dts: imx' -> 'arm64: dts: imx8qxp'
	- added 'Fixes' tag

 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index bb877cf25edc..4c3dd95ed488 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -350,7 +350,7 @@
 		lsio_mu4: mailbox@5d1f0000 {
 			compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
 			reg = <0x5d1f0000 0x10000>;
-			interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
 			#mbox-cells = <0>;
 			status = "disabled";
 		};
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
