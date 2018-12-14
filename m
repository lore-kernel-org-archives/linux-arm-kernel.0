Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FA5C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:05:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA91F2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kAkBKI7f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pn1smicX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA91F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=NKQaLjoUDycLWJsoEAeTbmfSO1bTp/7QPpzJsao2Yrk=; b=kAkBKI7fPBGnOG
	IzCuIhF7KbuZ0upr+kls0EJ5ulnPwpKCvkCa0OKH9o3NrQ/xpI8nKsgvj/tMslQGuhsgWhujIMxT1
	3OM2/JoLqFxnVSwnpb6HENFNgkzLxQyLhXzZhX9mHaidMl0u2cdUVfAXIxDM4t1Fc1H8CBE9u93Jc
	FgMiTvydx0OB/dYPWElGrqxxe+Bmai98a1PyQ9UShII9Sy8KyaBldrkntfaekzj9d27g0nFCJ5uS6
	p+xCLjYYSPYkGWkWNee29anVNqk2eDSNYhPc96cBZhewdBggSUSAgg7Z3TxBvSOGrUr6c5Tb1fZBc
	UyG3HQoNqJsOElqTE5oA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXkLJ-0007KO-1m; Fri, 14 Dec 2018 10:05:13 +0000
Received: from mail-eopbgr140078.outbound.protection.outlook.com
 ([40.107.14.78] helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXkL9-00065J-Tt
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 10:05:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uUZl/ciXVQ6JPnCZNoe8bbbCArsavKEHzO5Zes6mU4=;
 b=Pn1smicXq+xzDaUHAoW4s+uo3nw9P2Md3CP48dMMlKrlnhBGcDWjY80hzfHHUEs6DDr5c53DdmU/JgnhuL/UgBtPPyNYLAt2AzmBnmyr5D6rVqiz0qLrsrJ9nnewX4/MQulDjWpEjKJRjG7Xu6JO8Npk03Jewdmd458grn8kq7g=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB6226.eurprd04.prod.outlook.com (20.179.34.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Fri, 14 Dec 2018 10:04:51 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.028; Fri, 14 Dec 2018
 10:04:51 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: [PATCH 1/1] pinctrl: imx8qxp: break the dependency on SOC_IMX8QXP
Thread-Topic: [PATCH 1/1] pinctrl: imx8qxp: break the dependency on SOC_IMX8QXP
Thread-Index: AQHUk5RzpHWNi9ZgMEORjkQlr8lhQQ==
Date: Fri, 14 Dec 2018 10:04:50 +0000
Message-ID: <1544781567-18040-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::14) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB6226;
 6:f3/lYtsCDrFtLX8/Ca3xlr4hSninMTydu6ARKUvn13+bxqaiU+iZWob1wOAMxQVoqBfdRsW0A26HLbc4q+4eR7059lS06qHnefpjD4ElD+tpIV9wbZj/+/HVcWhOqNeFJiyy1WVJmILw15uwLQUJJRGNtc1Jzn2CCPASXpzDAMfRtJmGXNZeZ6akFT8ckDsJOTFE49run4BUkn9Xpfz6a5NiFKNfN05hvGSJ5QDcXzQYhX6WpswGxlubJQVb/xND3WpIXSyODTjpkq34HLstK1YWibho6jd1tEjnSVvLSr2RmFDbsOJ4mY6U0Z9jW6MbcplBmjb8bm5cG+96NzZoIV+669e+utuWB83KhgRh5bXw5YjINeGryqK5xcJr2YSS1ryyEtgWo4wAH1qf4IbHkreCEg8FFBrk0Bb3QMsQXkn6eJ+cB6qUcNGWcOrbOGbNIeirUn+LfGcsydhAyVvKyA==;
 5:hNZyGma3u+EJjr2ZZ2bT+dYW+m/8RbnnThhu1KeC8wQ+YIVsv20FlaDdAbw0sqRNCS+eLBQM2SLZs8RaWiRKH+foMPORazvGOGO/++2mlKLHpWJYSH9XTXZU/9+HYdq5NPGa2DR0uZ+LWCqNKBH04GNcSvr3VYLFP3kwMLsShY8=;
 7:gLDiDmHPQ6Iml8r8cBTc36Xds2VutMF6GwebF+DW4q8XEVo2oZWKI6tpQDaoZ/po6+cmlxbGKuOfPQNHz478Nz/8gKTIh344H/XDq38LIkqex/kh2JSg7w4++dfS4qbczZr4k8Hf7G18gjgB0P9ajA==
x-ms-office365-filtering-correlation-id: 89dac704-d484-42d0-64ce-08d661ab9606
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB6226; 
x-ms-traffictypediagnostic: AM0PR04MB6226:
x-microsoft-antispam-prvs: <AM0PR04MB6226E9BF7074A453D94AAD1980A10@AM0PR04MB6226.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB6226; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB6226; 
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(396003)(39860400002)(366004)(136003)(199004)(189003)(2501003)(39060400002)(99286004)(102836004)(6486002)(6506007)(386003)(106356001)(105586002)(97736004)(2351001)(186003)(3846002)(316002)(8936002)(6436002)(54906003)(4326008)(6116002)(5640700003)(2906002)(6512007)(50226002)(6916009)(53936002)(14444005)(8676002)(256004)(2616005)(476003)(81166006)(81156014)(7736002)(66066001)(5660300001)(68736007)(52116002)(305945005)(26005)(486006)(71190400001)(71200400001)(36756003)(86362001)(44832011)(14454004)(478600001)(25786009)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB6226;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TMMhloi63jzpC3fOom71oEMGoix1STADmoyL4Z0TdkEUzYfo2EqwKnyreeyJkMMdff26SNZcXaAsuXcYt8Va4oFqw2zwxstPPlBAL80LIdKJGKAz33Ouo4Brh5wa4gjNptPAkadQbDmvu+6K6nlnBwS3HtFCltgkwFanYm5juGCOcDDuHe8b+bOiJj6QpghMXzF6MMsRkOOXUcF6A4ZuZ0KBbV40g5QT3XG7qHvnQ3QDWPPPqGOfrjmP7rWSEOvkvjYQi+CmbkcQoM8oWWDqqYVyXjrLdRcmh/KHPe6Jv9/h+iec4hCfIXwTPxQ95fUv
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89dac704-d484-42d0-64ce-08d661ab9606
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 10:04:51.1262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6226
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_020504_029157_F1CD000A 
X-CRM114-Status: GOOD (  14.92  )
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
So this patch aims to break the dependency on SOC_IMX8QXP which
will be removed later.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
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
