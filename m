Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2655BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:26:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A672F2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UW8aonX7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F9FZYO2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A672F2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nRJ9RAjMs69vD1fMhbKkvnwyk1Ri/YO0LPShq/T+jw8=; b=UW8aonX7t63j3Y
	iJDBN8pUbex+bK6GLsOQvEvScca/Yq8jWIqE+5/sBez9AkeGxX2y5XBLcn+W5kJ59vEqWWs9FcGu5
	r755cuZUqCfgX9XOsLrVIUD38/E3J9HbQN5CCS8Sx86i/h5qiF846ZtRRtHYzNm2OFJm04NRRh1ae
	xRewMQxSQbA8pDqK+ziwe7btxQYCILqT6iA3bRvGpvFG99YroZ6eEJPREYSon2V/rq+qbiAePXJuf
	7x/CRx7vWJgS6oKQx9UEp5qrkpB5Nv0OeRii7kqud43lna0p5shm0+OAk3IsD52YiyViIRd/LtazJ
	Zh4ZZk//7w4oT6EWEWrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcin3-00072j-0B; Fri, 28 Dec 2018 03:26:25 +0000
Received: from mail-eopbgr60079.outbound.protection.outlook.com ([40.107.6.79]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcimz-00071s-Hy
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 03:26:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0iSe9y5AS0B1OtkN47pomV626BFa1lDY1arvnlcNuw=;
 b=F9FZYO2/64ETECylncajzOD6Pp+Ui0Fn3VrhMFvh1ClXK9Uz4Qn/zBYED8dJy6NzHeSFVjuH9kcP0CWFCEfaawxR6iNlTexKpmloBp5BOTucJySF6k5hniTM53Sb1Mn1v9FyTCxu+qF7R981hzAT10u8S6VS+XPLXGANCmTFj00=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.50.97) by
 VI1PR04MB6047.eurprd04.prod.outlook.com (20.179.24.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Fri, 28 Dec 2018 03:26:04 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::cd3d:ce97:132b:7148]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::cd3d:ce97:132b:7148%3]) with mapi id 15.20.1471.019; Fri, 28 Dec 2018
 03:26:04 +0000
From: BOUGH CHEN <haibo.chen@nxp.com>
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH v2 1/3] dt-bindings: mmc: fsl-imx-esdhc: add imx6ull
 compatible string
Thread-Topic: [PATCH v2 1/3] dt-bindings: mmc: fsl-imx-esdhc: add imx6ull
 compatible string
Thread-Index: AQHUnl0QX2S2IOSkb0K6pA5VMcybrw==
Date: Fri, 28 Dec 2018 03:26:04 +0000
Message-ID: <20181228033323.32308-1-haibo.chen@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: HK2PR02CA0141.apcprd02.prod.outlook.com
 (2603:1096:202:16::25) To VI1PR04MB5040.eurprd04.prod.outlook.com
 (2603:10a6:803:59::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haibo.chen@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB6047;
 6:wjsVxaak5YwioKYAhPcpLtjtQf77STnAl3K8FEFPLtaNSjy2lMapyZhjAfPCK5UrYpeasm2kyxZVsOb8GjeTRp7oL+6hPkFR/pqj2wENVGpLPkaUQtRy+9pXnAdKx/ehtXLPZARJSVkj4i/tcmGYjLh0yg2N9DP4gunoTUVUepmc5RwrTCvpxPpo14MoGKXBvvMTMJ6wCpYknmtybVkzda2IXHwiOBqXNuu94fvFJfRvxZEs1yJMM33Z6mLeeOhNhpW+15+Lc4J/bNEQWTfBKT0Zw6PD0RYucj1JYjUM70e8JeZc/fW+iX+Mditq7jM46GSUDCTA6FrF3CnyM0KPdrh004+Y7N94qgdyPie8aUnAdY3sKNJBEtnZeCtx8+KL/m50T41dX3cnR4D6v4tAVwRo5scOUgK4V4vLAReeS8a9Cp4iz3xquskfHZmwyURVNjNYu2LcYZ4HPaOOZ7KZ/w==;
 5:oaU5fhzs1TWMZRz5IWPrCmnQ2ugK0R2rV7avf1ETs/7NmVqn9utzOvytJKpBZzjxKhMKIYnnxdJDKGD65GeYogyowr8R3NK2IBChbiqO9T/iKZxn5FtcSgc50r7nHFUOeFZw2In4AJGk+Z2QdKbpjCtBf4d0sg4VrwcXw1ztOtI=;
 7:DDv1juMPG8XWBnGriKtOCHaTlyDG9g7/cWQoKa7PNVg58/uvgIKIJowfai/zwCblBTb73nil8w5I3Bos+TZt+M0Q9BMx0UPhEFR/FueySXr3qRy9WDMxQF9igpMsntN7O8sOE3a3obAiynwlSQIsNg==
x-ms-office365-filtering-correlation-id: 49ff9528-2ae6-4313-c253-08d66c7432aa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB6047; 
x-ms-traffictypediagnostic: VI1PR04MB6047:
x-microsoft-antispam-prvs: <VI1PR04MB6047D940B788965D99A8881390B70@VI1PR04MB6047.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220051)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB6047; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB6047; 
x-forefront-prvs: 09007040D4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(396003)(366004)(39860400002)(346002)(136003)(199004)(189003)(2906002)(68736007)(7736002)(5660300001)(86362001)(36756003)(6116002)(3846002)(102836004)(8936002)(26005)(52116002)(81166006)(81156014)(386003)(6506007)(8676002)(186003)(106356001)(105586002)(305945005)(50226002)(71190400001)(71200400001)(478600001)(66066001)(53346004)(7416002)(25786009)(316002)(97736004)(14454004)(1076003)(6436002)(256004)(476003)(6486002)(54906003)(99286004)(110136005)(486006)(2201001)(6512007)(4326008)(2616005)(2501003)(53936002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB6047;
 H:VI1PR04MB5040.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lhe6RReqAyUmOD7HZKnadT6t8qRn7hkpyks05UAM3kmVTYliDOAOocOgVC5+4ZbFA4FUeaOXsWMU/m/1APXDwLRDYvk6AEEhHDHdCxAOu8RAiGNuF8E4UHg+WUtE7v069xAp3BQS6544IfOJNZB6rHMrvRvzuJI0U0/Q9mG9T5G2wZYBNjNwu+vkbuQ8r4PBGG/tRcGDdWIyDI00exoV0KGwFAUNZexT3GkQ2JvVAGOdWvOO34F4WoBGk2iKZ18/tdWny4qg+kBQ/ZCsseg8FNKerf5suDQX2pgpOa61DxPqqrvde3LG39GCCKLAF6DI
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ff9528-2ae6-4313-c253-08d66c7432aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2018 03:26:04.8246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6047
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_192621_600228_6A72054F 
X-CRM114-Status: GOOD (  10.61  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add imx6ull compatible string

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
index 9201a7d8d7b0..540c65ed9cba 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
@@ -15,6 +15,7 @@ Required properties:
 	       "fsl,imx6q-usdhc"
 	       "fsl,imx6sl-usdhc"
 	       "fsl,imx6sx-usdhc"
+	       "fsl,imx6ull-usdhc"
 	       "fsl,imx7d-usdhc"
 	       "fsl,imx8qxp-usdhc"
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
