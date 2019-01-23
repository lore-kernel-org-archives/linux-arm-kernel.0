Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6EFC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:17:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F613217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FTNtdi0V";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sksD1Jfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F613217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HPsmR2VuGmVKypmKHjir05W/f1Pgi/HmpdPC0Pu86EM=; b=FTNtdi0VGAkBZH
	hCqpXcy/ctrV+9nPB91c/GrcgfPxKElF0SZxwL1cdGQ2cYPMbPAZGc6Rw5nt/LpeUz8kMSFAJyaMW
	Seh2PVOr+RtBTWfHK1yVqJELCQBxcwqbQg7mkimJZQ/2qHXuUAb9cy43E2j+YI40riaoIMltZ2jNT
	k6wW7cH2aJ4zDXoJvnlOShfgxhavC7xMHuoaDxIPkIfh3gtEY39LLVx9Ve2ipy65ef2dlOSnmVvTg
	kdnLVib7kNOjA2uFqhWsEbdn8r3lJcb3CkfEd3MRXhdcHxmxaLBu4U2RslOyFq8omrbBnn4RIFaoh
	7WagORbLyc62pUtbcEbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmDin-000549-4w; Wed, 23 Jan 2019 08:17:17 +0000
Received: from mail-ve1eur03on061b.outbound.protection.outlook.com
 ([2a01:111:f400:fe09::61b]
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmDiO-0004YX-WA
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 08:16:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ys6mu1Ibz5SI6qFInUSDmmjwhAHT2+USmTN32C3cG2o=;
 b=sksD1Jfyr3dn6VYJAX59BeoBbm331ySF7bMK/Obno9Jg2rZLXHlZ0Hb46DT8oI4dscVpaJiiwTfdCI1AY8HNYNv6iw7u02tEqukbcf/sCUoyMFEnTvyuRJWrbL89pnqtjf/Cc9yITr2Z+blBWU72SyRPiFRFXioizDl2ZaBVDrI=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5027.eurprd04.prod.outlook.com (20.177.40.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Wed, 23 Jan 2019 08:16:48 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1558.016; Wed, 23 Jan 2019
 08:16:48 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH V2 2/5] dt-bindings: fsl: scu: add imx8qm scu clock support
Thread-Topic: [PATCH V2 2/5] dt-bindings: fsl: scu: add imx8qm scu clock
 support
Thread-Index: AQHUsvP8X/dhlMUaA0qet1jV/9hRHg==
Date: Wed, 23 Jan 2019 08:16:48 +0000
Message-ID: <1548231044-4344-3-git-send-email-aisheng.dong@nxp.com>
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
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5027;
 6:KPxnFgE7cVQhx6DaL0DoGXwZbjxCxAoG0QwU5TG57CuWik9j5KgK9Hm8UQBSm8hrQ+bAWbvS+qDSJoVRTVv/EqaPj2mQ4TLgp5gA/EEmBrXagws6jgAVZE6ypvyehn8MHDd8KtXej2v2AWISmnNzGkGwEZ0IioYG9tlH52mkjIpTiuFL9TcEqfoixYljkY2TebDrEAA26aPUi2mH0QrnxzIinWbxUWoMEE6UQx6w5SpLnkv38h1JGjWfLyGCn9KhbfETvuoDLj/7ZVrAdbSnstCrs1zMzRWn9t51ZnV+02paM5576DMtezDYg6Qu0Jv5/MVB1Cq9Gmc/ujlTT8DQ8q0TmLgODLPMaw/9t4D+auWI3lGQGUoH3Agte1lOlPK3WPMm/Ub+095FGkBE/P2s/n3fXKg+YSqS4jDoO8XbEyHjH/QO5EsUnx+A8hKZCnQzxzSHJlKoUKM+DwYQVR5Wmw==;
 5:pQMRP7q4ebqA/zOXEyyB1A7+8N56ZVu/Hdj76bPXFQAryiEWDE0UV6n00slxY6g+QIvWgvUjUfAJVQd8hRpdSWza7BS6LzrWQyjqd9+02Of5chS/dKnGqH4vX685P8zsxsyKX2RddFi+qrakBut2W9Mqsgblsfc+i/2mCobQfgwwS95JHXt1xm9HHWz17RIIC9Fyoz32f5S+hiMaSXVwkg==;
 7:4jVYsc6Zzi8elva84xbjwgi+yJAdTfeTzl1BaKH9d84yp0omJOcPlfOJ6e0LwjAH5Qk84OC3ChNN9XKNAbx4NzD1kq+prurl8bUby0SwtXAUX9FRHNqDJ+eBdcso3QlOZsNStBLbEBPWeYBQkbpY9Q==
x-ms-office365-filtering-correlation-id: 3e2742fc-435f-4b89-cbea-08d6810b1eb1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5027; 
x-ms-traffictypediagnostic: AM0PR04MB5027:
x-microsoft-antispam-prvs: <AM0PR04MB50272902FEF92DD4C6C93B3E80990@AM0PR04MB5027.eurprd04.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(366004)(136003)(39860400002)(396003)(189003)(199004)(478600001)(8936002)(50226002)(11346002)(106356001)(105586002)(2906002)(486006)(99286004)(97736004)(44832011)(68736007)(36756003)(305945005)(54906003)(446003)(81166006)(81156014)(66066001)(102836004)(316002)(5640700003)(6436002)(8676002)(26005)(7736002)(186003)(2616005)(386003)(6506007)(6486002)(86362001)(4326008)(3846002)(6116002)(53936002)(14454004)(52116002)(71200400001)(256004)(6512007)(76176011)(2501003)(71190400001)(4744005)(25786009)(6916009)(476003)(2351001)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5027;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ohxa50whz/2G5qAA7vXGfjbQk9SG6Rwy8Sr/l3My2VAtUl7g9vvLWT0u97RHa6lBa9mBeyJ1dbAW/FvEE5CZbI0IiINd9Jnkqp1FUATZaL+/JWiuR5+qwaDyJBtyHzbBFRYfUD/5Mr4QSwtisd2yVZZYfIK5peBAt99OHibPoIaJt6MYP9IYz0tNFR1V5AXG72OLF6oyObcaH/DyXtTPrQL/Wkth6upEHqGg+pdEiu0iX+Swq4zGUfd2RsDjT2QwJaySEzEt0J1vsN/PC28lU2YUECUfUiqdRBt7gXmPvAUVS7RGBiMZYWiDK6HEqPvL/lNv9pauiWk48gYHjzG/hBURabRFCfDScBFvEPaJwi9ploWISw+Y4UlbGzH24mdtMnrMREqCKEIFbYaAZtUtFdStwuE3LfTRsDrMZ8ecWfk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2742fc-435f-4b89-cbea-08d6810b1eb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 08:16:44.3090 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5027
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_001653_580154_5FDA4A8C 
X-CRM114-Status: GOOD (  11.75  )
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
