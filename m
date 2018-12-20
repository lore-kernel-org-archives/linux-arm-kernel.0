Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6098C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:50:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74BF521720
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G//fzAe7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lEdP5tBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74BF521720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=rFWPgeoXFMwajvw5Do4yys9mooFudo9UZIs+c/E6qhQ=; b=G//fzAe7CrUUHP
	Effu5gQ4jpxq/rBU1aekDl4aDHp0Xs38ZjGagZs8H2SL4n2CHgiTuf/j5tuJzh2QXkDS3FzcEmRM6
	ctDSq20HcyAlD6LVwdCN78am86KGDnhVoXT1D7AeLLThTB2qdC3Gn7QLB/rh697zNHnwk7H6LCQJN
	9nvRdshTv1hgQCROcbIfSyKdR7Ox6wuVSkHUu9DJT63m2jbnj6Bt0DwbwD5aE++PB3c2YWu2qcWQw
	MzbAHpJPWQv0outkZVsL1UwIb4sEj9RWcj0GyKEulSBwC/0seJyK4wWn+9c95a0oduKvV0Tfw38b/
	udMyFgKpOz4yHAf57I1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZt5k-0000VE-9F; Thu, 20 Dec 2018 07:50:00 +0000
Received: from mail-he1eur01on0622.outbound.protection.outlook.com
 ([2a01:111:f400:fe1e::622]
 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZt5f-0000TV-7W
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 07:49:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQ0pFpsAui/9mayKVhjO95qkzPU9HoYx7HCHfcpuOKc=;
 b=lEdP5tBVXv+8xIJNEVQ4UP86sBH663OfcavC7qm7W53AUY48+peLnhMUNlIEpeRBuHRro6LKmdawDXDwq69xdoXaVqCERUKYpp+AMj0a7sAfCRkDdMd2PPnFrMMNbZfrgzOwkebMpIegvaNMhWknN+AfT3P9FzTv2qxhQHu81kc=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.50.97) by
 VI1PR04MB2158.eurprd04.prod.outlook.com (10.166.43.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Thu, 20 Dec 2018 07:49:38 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::cd3d:ce97:132b:7148]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::cd3d:ce97:132b:7148%3]) with mapi id 15.20.1446.018; Thu, 20 Dec 2018
 07:49:38 +0000
From: BOUGH CHEN <haibo.chen@nxp.com>
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, "adrian.hunter@intel.com"
 <adrian.hunter@intel.com>
Subject: [PATCH 1/3] dt-bindings: mmc: fsl-imx-esdhc: add imx6ull compatible
 string
Thread-Topic: [PATCH 1/3] dt-bindings: mmc: fsl-imx-esdhc: add imx6ull
 compatible string
Thread-Index: AQHUmDiOtUFXPIG7hEqnrPtukWPVZQ==
Date: Thu, 20 Dec 2018 07:49:37 +0000
Message-ID: <1545292612-14471-1-git-send-email-haibo.chen@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR03CA0025.apcprd03.prod.outlook.com
 (2603:1096:203:2f::13) To VI1PR04MB5040.eurprd04.prod.outlook.com
 (2603:10a6:803:59::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haibo.chen@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB2158;
 6:yzcpPIIyZUHD8px/fStJ09LNlWL/jGkuCxNetubXEkOBoHhMHdKWdttTfnza6RhNpSivAvybBurj0pNzo0QJsrr+lEncPJRv4XYGVZmd8+Mlx0F9aF4LTMo8hSKBXuaDzx9ajIdeklws5FF+Srx7ZBomw7KF1KjD0AD8O3MIuLIY+zmwZDMZfQuV2fE2bRWvv8L0N6L/zeRyIxSBkswAjIkEBuQy7PEwov9TLkuxdGlXQeTxly9HaC7YPAHcZVRkswfSFw4yHHXkbrLDmcYBj8nyf1zMiRiap5e0Ix4V9u3LcJfYUEyY51iLb/Y/YNgVQgHAa/D/J0kPWtZp9ALIjLBdaiFSSfcI5UBDEBpooh3Pv+apiSRm/CltO8kLUld7P+3eh7kjlBaiYR14jG4RJCuRRIymF1VErSzTrXuFYhx2Dr9a+SaZ6RH1VmwEllQgmxZ/oFot5k/HYoN7CqGCIA==;
 5:fC7okjicp7Tzu5NVfi8rLIMCjjVdz9c0gf8taGLAD9ILFi4OwT9fcyEBYJj/utzN3Iw6XeOwvGM6luV2BavcQ/guZAAKhT5hzE+3K7Ve5dBCABYZwCIMKgwSWBchjZOsOJCV0C2Une7JBsGq41etMO1AvvqlfhVqzDxZ2ILvmkI=;
 7:ag15dB8as5lYJFT1624AMpMWzaRgn3gpg0mrLtQh5rl7F2SliLFxmC7AgO5xc2fsg+0848OEGKMBiIB47JdOkZavJyFTY3QJDQNtSkgDgjvhVHVpbilwWdd8XKbonRMG7zeYw9SokgjU9lgHg56zCg==
x-ms-office365-filtering-correlation-id: 240c5be4-fbad-4ddb-d155-08d6664fb0b0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB2158; 
x-ms-traffictypediagnostic: VI1PR04MB2158:
x-microsoft-antispam-prvs: <VI1PR04MB21584FE6D2A82E4A9281242B90BF0@VI1PR04MB2158.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB2158; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB2158; 
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(366004)(376002)(136003)(346002)(189003)(199004)(50226002)(2501003)(71200400001)(71190400001)(81166006)(25786009)(316002)(6116002)(36756003)(3846002)(386003)(2616005)(476003)(486006)(256004)(102836004)(99286004)(14454004)(6506007)(66066001)(26005)(97736004)(7416002)(7736002)(186003)(105586002)(81156014)(8676002)(6486002)(2906002)(8936002)(5660300001)(106356001)(53936002)(6512007)(305945005)(52116002)(86362001)(110136005)(478600001)(68736007)(6436002)(53346004)(54906003)(2201001)(4326008)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB2158;
 H:VI1PR04MB5040.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cdAP+INcz/xZVN3gP4pTBy9BedyDUjdLe138IgtUNtr+ZoXTy+tOea2lJGzThodoILzyKiEm1kzDfM31gCM2+WFJyrd7k0EZ8Zw5BGrD5CJciSzkh4qa00BBoW1jVyGhwryxNcNA+5kQZ/JLYgcv4cNJEYHThkr/OQ8GxATofh6iloWjLEH4yIg9WvniogsmfvQEzvV14sQZhpLRFj5LLCHGPGS8+MsxcZbdKSObQmoqinnpkcCtBSE558RDLgEAynKBClzoRsJoLbeiJBK+ASmzTICbQgf64ZmiuyexjBrFZ/kdQvbpCgslk/x+JIA/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240c5be4-fbad-4ddb-d155-08d6664fb0b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 07:49:38.0086 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2158
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_234955_276049_74E4EEB4 
X-CRM114-Status: GOOD (  11.02  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
index 9201a7d..540c65e 100644
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
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
