Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BE6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:02:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8483421873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cFndtg5B";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r6om3BFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8483421873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aTHETCotLNrAGLowffSboep125W/6Lia9QYUy4rdIYM=; b=cFndtg5B7uiPvW
	lIsfjhaz+Mkuqra6X7ZovnQYU2x7PUwYi4z3MhBY1ZQ/NdIwUvSaIVxjM7f5f8BzRbNBqSffamJWu
	6jz1uRwP6liNukoBY+/z++aUvxYB8DIWF9BR1dEi/kaYqjMXsJq/83O3MdzPXLsxG5ry/TDEWXMOM
	VolpVdA8CNrV280kaae6YoNAiKxDEvkboSppggEM8w1mLGC6b+h3dwn6LUbwYLlQYsDwwdcnbNlB7
	/mF0pvZJfi98MLmjvFCjTce4aWI9Lri9DeYgyKKiFSCwFzMtpwfXTdw4VAmDQb0oz6D02RswiDvNP
	mHYekTDHP6CKXe78iaTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHof-0006dK-Ce; Tue, 18 Dec 2018 16:01:53 +0000
Received: from mail-he1eur04on060c.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::60c]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZHoR-0006OS-K3
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 16:01:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LnOqKKs7UXhiaxemdSE8WqTX/EK9l7hgmAKdZ4HkPM=;
 b=r6om3BFxNZuHBQ2xSPRIEndURZmqBpBjv9uiY3jEcQtm9WC91GuJ/UB0w5SY/qgJOT9MKVjztruqt6v0bxXfsYT1tGO5H8L1SHji1jM60jXd2rYOAfMe++aeWyUxU7U87UmJbYHodQStJB3mCMAjx8GhUz29SahENxASQ0ZqZOE=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4084.eurprd04.prod.outlook.com (52.134.125.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Tue, 18 Dec 2018 16:01:25 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%6]) with mapi id 15.20.1425.023; Tue, 18 Dec 2018
 16:01:25 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/3] dt-bindings: fsl: scu: add imx8qm scu power domain support
Thread-Topic: [PATCH 2/3] dt-bindings: fsl: scu: add imx8qm scu power domain
 support
Thread-Index: AQHUlurt40Wz50SraUOJwjQlFd5TMg==
Date: Tue, 18 Dec 2018 16:01:25 +0000
Message-ID: <1545148524-658-3-git-send-email-aisheng.dong@nxp.com>
References: <1545148524-658-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1545148524-658-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:203:36::28) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4084;
 6:dVZWJYzObeZRbTPDKafTlZKN5bRDecdJ/GNSrdntHW3focEmL6zei2DwEPta97KuGG1kiDm+kcaWf45vHf8dhj8q9Tf2kVduF2BQTRJ0FuZZYN9eCgy8NnMJm0+k/qnNHma5ekYDpZD91BtPYywMSzTw18D9r12bk4cQM8FWdsRRLpgEjX8dozj1J4TyN/7NdvRenQo+x+MzJClcs5RFRfuCNegsnIQpVKwo3fX3nIN/NP80ZP9hmVuUjE4uULuKu20RRjtby2Ss1tQSMqEtdT7UQuxp+IWH0qXj55pcjtvcxbJKpl9HF6EkdwyMbH1rSdCFLDMnmc/3cbMD8bGyCa54CZGdSO4TPI6IPF/Kyj0pA8IVtEUNzG0U/4nJECJoqeVUMa6xc7OQIFMXvJ+mnF7m+nHw4ualI/655T+JqY/gJkbzaizVjDVow47GWi3qzze8+S3Yx9qjoC5Io9Pr9g==;
 5:f4ZL//rBlGltJCxUA8PD4BctQ/hilyjCD51Rzt+qPfOoMhFMR9Qy6fVHHlhY7Z8kN0nz3Z4nfM5MXxSRmkt+tuTTvtXHNzIzyjLrNppIK0Kx6NwnyCQ5KbEhzLij6QTbQBIS0lZAg4tbTiuOxfvxc1HX4Hxxi54trWB7z6iz4cQ=;
 7:VMMoOrBVC0GlK3RnBUr3UFYZITVpVfcwx5TRikEMSVgyCiEbq/kuGCQaQqs2BdcIvF5C9Ib6tB4dsCOsVBjI0JY/Xgf1OHJ6LcFGQx2BeCjhY0aZ5/6aLa/XzHOLdX2v+44i14+rQGLA8th8rdJipg==
x-ms-office365-filtering-correlation-id: b6b915ca-ba49-44bc-69f5-08d665020fb9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4084; 
x-ms-traffictypediagnostic: AM0PR04MB4084:
x-microsoft-antispam-prvs: <AM0PR04MB408468ABA874D4D08BC8FF5680BD0@AM0PR04MB4084.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4084; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4084; 
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(136003)(366004)(376002)(346002)(199004)(189003)(52116002)(14454004)(71200400001)(106356001)(6916009)(7736002)(71190400001)(11346002)(5660300001)(2616005)(97736004)(99286004)(446003)(4326008)(105586002)(76176011)(256004)(6486002)(39060400002)(36756003)(6512007)(54906003)(53936002)(316002)(25786009)(81156014)(186003)(478600001)(81166006)(2501003)(50226002)(2906002)(7416002)(8936002)(386003)(6506007)(5640700003)(102836004)(26005)(6436002)(68736007)(86362001)(486006)(66066001)(476003)(2351001)(6116002)(3846002)(8676002)(44832011)(305945005)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4084;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bJNmhGlEgA82zgRoqb5k/a6+vATkcwxjfQESy4TSnWifJ27ELho8BjYfbCAJfFfM6+xO0DGFtFje507eGlcUhgIe2xquI4G+FDj3yeUyBjhhso42mWmhWt9NIAFY/c8qjxzwg+MzmMuWWJN8RfytpFKtorB0oIGL5r40WaQdcrAXuRr4Cw9Fbulq+ilZm++56nlPYGXhjLTH2N2sECClE8KSURr6SzYgWhUDtPHbmFR7Gw298YtVTWdG5QloTUbyj9iKiuxYcSgknSaa2KjBjsGeM6bu6Mk0QIa0XQO7l0KWFiiXQeBSct2MH1Zy5zxC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b915ca-ba49-44bc-69f5-08d665020fb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 16:01:25.2341 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4084
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_080139_947160_A60F97C9 
X-CRM114-Status: GOOD (  12.88  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "khilman@kernel.org" <khilman@kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add imx8qm scu power domain support

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 849b671..b9b8eb6 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -59,6 +59,7 @@ domain binding[2].
 
 Required properties:
 - compatible:		Should be one of:
+			  "fsl,imx8qm-scu-pd",
 			  "fsl,imx8qxp-scu-pd"
 			followed by "fsl,scu-pd"
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
