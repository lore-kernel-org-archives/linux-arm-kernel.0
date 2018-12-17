Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FEBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:38:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0681206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JdJ7d4MY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nQ8q9Ule"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0681206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GrAoPUswaNdb0H4r+YsrfWukI1NrIjJ8eUjVyVyThI8=; b=JdJ7d4MYEEpPJG
	wmYke2P894RE7GwhwUTDnE1G74YUtHllJlnI9YcAFYFUVmJwasYHlDfH08kNGo+6v7wP9vz8S27Yb
	7xelzLm3jTsn5XKV+lraNc3wRqdsDbQzhDJkHFqN7fBh15kulH8tGBEjCLTjkYnLskGe9XHKG+WMf
	jKhHxfrM7CEjrrD+z0JYJ7hCOetDQIaznIqqJyvG1eeAvEeCQoAsTqgRCKf3tXv6VnWIfpNSkA+m1
	fIeNoh7UvAWUr8uyI5woBXp85iNpBRjM7AH4jiCvBTsr23ZTiMgJ4EDgzm2yRSi0ez7uuoyGGIx46
	GBB0v5A4jJoz94EhKTlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYuyX-0007Wl-Qt; Mon, 17 Dec 2018 15:38:33 +0000
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYuyT-0007NL-Nt
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 15:38:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+74HekCcoEcYiAxJUA4b+mkBdfCjaaH9YLUjRF2cJ8=;
 b=nQ8q9Ule6KQ3+wE8FhmipEWRrSvZzeBY5TaUXIXfo1lT9VNDW2bRmCvbZRRom0MzhNNatbeE8N0wi56rqQb+09JRiz/qg8jUnPeeJDku/a9JcrjVuECZPh40+j1mfSWFZ7IivK9X2e2N6Uo6SzvLNd2+lLDJTP0sfJNO4QW0Q/w=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5587.eurprd04.prod.outlook.com (20.178.117.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Mon, 17 Dec 2018 15:38:15 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%6]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 15:38:15 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: [PATCH V2 1/1] pinctrl: imx8qxp: break the dependency on SOC_IMX8QXP
Thread-Topic: [PATCH V2 1/1] pinctrl: imx8qxp: break the dependency on
 SOC_IMX8QXP
Thread-Index: AQHUlh6GL3fnHE7BUke7TLLuCsGipw==
Date: Mon, 17 Dec 2018 15:38:15 +0000
Message-ID: <1545060770-19191-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0079.apcprd04.prod.outlook.com
 (2603:1096:202:15::23) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5587;
 6:WygUt4wFdlcFBEKlCxzx8vvuYBxy3wtJjPnVcwlQXHQ2cB6JDY9vLcjce69MqPWLMtXYxAVtBzpggAUG/vVrQzxraBUo8MaE0dqPIw598wh9fZu4JpQIn9EuVySHvzmZ0qe66ITDSZy72SALwgkZySGbW7oQsVa2MnMy27XAwwKOxY+NVZAWGbCXLA5Coxe8A4mnzg4AjLVq5GWw7Sd4Fu3oHmpPqrPmxYlazHFKgf2PGSguSrAeqGCEoQw+wEpUqjuquAHVaCRoGGv1eee14TP6z7S8p7HPma+rY5rpI1OdpqOxO5rBE6XpvchjZLS/0NIlEnSZ1Yh/sZWIUaX9RoP9OAuKhjCUHahuob1+/J6NeMzwbhSpDFou1B7S03Oc1evIuMy+TIqV+qXSIelZfJfwsT6Fe+sEYe6CuGhpzPS2yz9nBKd0V1JswweCe90vWxIIpSIjR7s1g5Nhm3ay2Q==;
 5:AWpjiHuVKVn7nG8KDQcxvtZR9BWiKq0pez4KdRAMatASVT4fD5FGKclz4ZJH4GD/qxdshUnV+MUavEWqJUUDh3uT6OdpDeCAH8ZNy3YJBteg8aVgVteQqdO0IUPbGsMXUSyo1Gy/nXEYHCcSnZrkm3x4hti0O7rJVbgeM2inqv8=;
 7:qAF8EBaGIMOV68Kpu0YMmtC1y3BQqv9Wg7cJ0C+8hRuTJG0gmDOf7TYrru1T8xlp5zSs7XRMxa2UhXhN2llurw5qt1Q9Xozy59dHYP0JcnlsiM2Bwqa5L2GjOLFe3YYqrNcvEKMFIRn+cx0oJkSG5A==
x-ms-office365-filtering-correlation-id: 00c1866b-27b4-49d5-8178-08d66435a8b8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5587; 
x-ms-traffictypediagnostic: AM0PR04MB5587:
x-microsoft-antispam-prvs: <AM0PR04MB5587FA30D7F857587DCA913E80BC0@AM0PR04MB5587.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5587; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5587; 
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(86362001)(6506007)(386003)(52116002)(102836004)(8936002)(50226002)(14454004)(81166006)(81156014)(5660300001)(26005)(36756003)(6116002)(3846002)(68736007)(186003)(2906002)(99286004)(7736002)(305945005)(4326008)(39060400002)(53936002)(66066001)(6916009)(6512007)(14444005)(54906003)(256004)(6486002)(2351001)(8676002)(316002)(105586002)(2501003)(476003)(106356001)(71200400001)(6436002)(2616005)(478600001)(71190400001)(25786009)(44832011)(486006)(97736004)(5640700003)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5587;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UVDhwfAxTDAgcA0k6S5Keb+L+Ktu2QZm+fWZB47JjoVbEBmy4Ah2Z8sJqL7LyM55fxn0Nrl3lKE+9JWBWr1M/M5TgJJI7C89nfTridBDgDE/UOJCTQ8WrVNIOP5uH0bdD7vMIokdAlV2TtTO6ORNUjs+yXmfh2pnpta1JKIMFZHBLwrLAJRqKoPMCAphIKdfvDmJ/mNbySqrB7z3CNEl20OZCST9YBqhyTxZJEAc2xksmtJXR/rCxGyYaXJAR+jSQ7u1JApDbRiTloEFwhpcuqMEBSUv4+nu0mXdf4O9+CawvFQQ+9O3jshqrM2sFHK9
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c1866b-27b4-49d5-8178-08d66435a8b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 15:38:15.1056 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5587
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_073829_773217_5A0F343C 
X-CRM114-Status: GOOD (  15.40  )
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
 "dongas86@gmail.com" <dongas86@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "stefan@agner.ch" <stefan@agner.ch>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

ARM64 SoC does not encourage people to add more finegrained SoC
config options rather than a single ARCH_<family> in arch Kconfig.
So this patch aims to break the dependency on SOC_IMX8QXP.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Acked-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v1->v2:
 * do not mention the deletion of SOC_IMX8QXP as it's still not
   hit mainline
---
 drivers/pinctrl/freescale/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/Kconfig
index 2d6db43..f7d3579 100644
--- a/drivers/pinctrl/freescale/Kconfig
+++ b/drivers/pinctrl/freescale/Kconfig
@@ -130,7 +130,7 @@ config PINCTRL_IMX8MQ
 
 config PINCTRL_IMX8QXP
 	bool "IMX8QXP pinctrl driver"
-	depends on SOC_IMX8QXP
+	depends on ARCH_MXC && ARM64
 	select PINCTRL_IMX_SCU
 	help
 	  Say Y here to enable the imx8qxp pinctrl driver
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
