Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D52C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:13:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C4EB2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VVb5xgZ9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="u9lzrVKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4EB2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+NWdy/BmlSl4ZtPB5d18u7gE5vYTmFp394jpMucudrg=; b=VVb5xgZ9QN4PFP
	QEpTFzdPwW8VUtWaSA38cK12ME2C7ObHWrJmCYuxvuWFxGldFVlryVMN+ZzQUrrLN/rz1K1bBs1Jm
	OY0himLVc2ksmvJWQ3NPd/eq2w8nxi6N/4d7+XdGeA6POYEtsLAJVmSDBua51U4cXdHe4iwhrigyP
	uRtjcyBioKyHmHkZm8t8aggtMb7Uv4v5Uj9ApPYM+UHOK/aa6jki48KHo8hIHNQsyHoqjyKtmcZv2
	Ncaefyuxo+AdKTbzUMbzRr2sSCuvE7VBx2lJlMGy8KBYlS+aj+1wqUYJ6ZxIBbxvY4ctQ3ZjZX5fi
	4wZxKlKnA4rQJ7WBTOwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWjj1-0007WU-Mt; Tue, 11 Dec 2018 15:13:31 +0000
Received: from mail-db5eur03on060a.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::60a]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWjix-0007Vi-Cz
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 15:13:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQsYP653LGPBI40OnJMnnvGyV+zUqMJ/KATAecDmUrE=;
 b=u9lzrVKauu1J7mWb4syHTpYC3R20jP8jVZngAGZUcl/SZTgeWAEVmumC4arUleHM9jFNi5sItMl4DViVrWIPbQ9c8f71XZI9+9oE4UEBqQr5K30367Eu5ptoZPZQYreMzN06lNJaPIhF6PIWtMlPwc2LZGjt+Vy4RkBjV7mgbc8=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5859.eurprd04.prod.outlook.com (20.178.202.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Tue, 11 Dec 2018 15:13:13 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 15:13:13 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH V10 0/7] clk: imx: add imx8qxp clock support
Thread-Topic: [PATCH V10 0/7] clk: imx: add imx8qxp clock support
Thread-Index: AQHUkWQIbRNxBwjK40+nBfx8zhf5nA==
Date: Tue, 11 Dec 2018 15:13:13 +0000
Message-ID: <1544540867-6342-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0081.apcprd03.prod.outlook.com
 (2603:1096:203:72::21) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5859;
 6:vOeAWj1QptLar7KbXs+cF7RWpdCx4rvCPrc8c5zbcGu2bY0T6f/UvMO8WPdiJdPWlbDnmzgcp1AI1MSd5ci/gSlw+SsKTWoK74s6EBR/g0i71bRfoT0y3nmZF+Ynp0xMIvcSXtY2dNVn+68htMZUq7PU8ZEX7+M5iATlBXghrUod9dJqPz2zYqflCS0dX7cr/wUGj7hLFAC1cJOc43y2qAf1vAUQCpymbaQZrGiQ9UEJ+eoBIrIkLRX9nAcYfHC5kn7Z7KFAimPO/33EDBjKB8db/HrcyVCZEp16s4rVhqCuOAukhoG5e7/xKAyFp63gODs0e+7R9QMFhzbBBLSOJlce+FWpz58VtQ6lVZfcWtKuCfoPU5/ak3y3XqquYQP4BLY5xVenn2w8WbT/PkiPPLgyHc5h6DmGvjw6it8UOYzwchx9rk/xTV31Gd8gelTfja+9ha4c/T8gY+PcAsgzHg==;
 5:gtiW8sPt9Jy8RSF9bFxlmStgzaORYY9J29QoaWXyPT+n4YmeFc5zNhyty7UvEW4CHBf/WyYdio9LeJrehaymHQJWbe9OXoBZuPfNIbtZL8UvxlhDEeCsDAHX3BgxW6jWuzrZB+wJwmxorUQNR3//Xlla0N5hkgB7MdrdoJKNEZg=;
 7:+uhGqaJFmavXWfyz0jugW1pC6BCcTP+78+YEfrn9MpwTng4rbLQbPheNM8Y+IHF6PCSq5GAFHaUZq77ViXzHuY8UWrQmXPTlggyfY4CNfeYcYBHNwUk3QcWdUhn3IGPQoIaqC8iRbKYJnb2t4rnGGg==
x-ms-office365-filtering-correlation-id: 85394ec9-38db-4e20-bc86-08d65f7b2b2e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5859; 
x-ms-traffictypediagnostic: AM0PR04MB5859:
x-microsoft-antispam-prvs: <AM0PR04MB5859CCA8E66051F5ECC51EA680A60@AM0PR04MB5859.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231472)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5859; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5859; 
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(54534003)(106356001)(44832011)(256004)(14444005)(2616005)(476003)(54906003)(68736007)(7736002)(102836004)(486006)(2351001)(316002)(26005)(8936002)(50226002)(25786009)(2501003)(4326008)(3846002)(6116002)(97736004)(478600001)(53936002)(186003)(81166006)(81156014)(6512007)(105586002)(2906002)(8676002)(6486002)(86362001)(386003)(71190400001)(66066001)(99286004)(14454004)(6916009)(5660300001)(6506007)(5640700003)(52116002)(36756003)(6436002)(305945005)(71200400001)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5859;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bjeflr3658yQmSmxDWrymE/xvPEQivQ/q7XXpmnojMl2ftPeghQybvlJR7+zoETaF0Vs8butuZnsuXo2Snjs1cCaKA86+dmwb2IExFQR8JfqSbx2ldygbJDKR485Pmcj2hVxQA1EWD1nZZ9e1129XJbQVstphREgLEGeenB9rDlORpz4a/7EvVLdVOTR9KtVct8mTQ9pwEvn6HWLfJ0iC0+JPL5RQ9zD+H+XQun6rh3TAXuwGvshzcQMynEuPV72bWB/B2iC63zq3aPxQd6tWQzpnW2j3jJ+3pZcBTQ/ji1jDJawIohPD125mistPTm4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85394ec9-38db-4e20-bc86-08d65f7b2b2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 15:13:13.3495 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5859
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_071327_509015_B048B999 
X-CRM114-Status: GOOD (  14.75  )
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

This patch series adds i.MX8QXP clock support which is based
on the clock service provided by SCU firmware.

Note: It depends on SCU driver which has already been merged by Shawn.
So this patch series could go through Shawn's tree as well.

ChangeLog:
v9->v10:
 * a small clean up of PATCH 2
   remove ccm_ipc_handle from headfile as no other users need it now
   and move imx_clk_scu_init() implementation into driver accordingly.
 * a typo fix of Patch 10
v8->v9:
 * add __le32 and __le16 for SCU message structure members as it's little endian
 * use readl_relaxed() as it does not need insert barrier
 * a small code logic improvement suggested by Stephen
v7->v8:
 * add more kernel doc for lpcg and scu clock structures
 * remove one unneccessry reg checking
v6->v7:
 * use struct_size()
 * remove MODULE_ macros
 * add more kernel docs/code comments
 * other small improvements
 * update reviewed-by tags
 * add the missing PATCH 1 in V6
v5->v6:
 * simply the driver a lot by re-orgnizing the driver into a few clock types:
   scu clock (merge scu divider/gate/mux) and scu gpr lock which accessing is
   through SCU protocol and LPCG clock which is directly accessible by CPU.
 * LPCG clock is separate from SCU clock, gpr clock is still not used
   and will be added later.
 * remove old year license as the code is totally rewritten
 * scu mux support will be added later as it's also still not used.
v4->v5:
 Address all Stephen and Sascha's review comments, see details in each patch
v3->v4:
 * scu headfile path update
 * no functionality change
v2->v3:
 * structures/enums name update with imx_sc prefix
 * no functionality change
v1->v2:
 * structure and enums name update
 * api usage update due to api change
 * no functionality change

Dong Aisheng (7):
  clk: imx: add configuration option for mmio clks
  clk: imx: add scu clock common part
  dt-bindings: clock: imx8qxp: add SCU clock IDs
  clk: imx: add imx8qxp clk driver
  dt-bindings: clock: add imx8qxp lpcg clock binding
  clk: imx: add lpcg clock support
  clk: imx: add imx8qxp lpcg driver

 .../devicetree/bindings/clock/imx8qxp-lpcg.txt     |  51 ++++
 arch/arm/mach-imx/Kconfig                          |  11 +
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/imx/Kconfig                            |   9 +
 drivers/clk/imx/Makefile                           |   8 +-
 drivers/clk/imx/clk-imx8qxp-lpcg.c                 | 216 +++++++++++++++
 drivers/clk/imx/clk-imx8qxp-lpcg.h                 | 102 ++++++++
 drivers/clk/imx/clk-imx8qxp.c                      | 153 +++++++++++
 drivers/clk/imx/clk-lpcg-scu.c                     | 114 ++++++++
 drivers/clk/imx/clk-scu.c                          | 270 +++++++++++++++++++
 drivers/clk/imx/clk-scu.h                          |  18 ++
 include/dt-bindings/clock/imx8qxp-clock.h          | 289 +++++++++++++++++++++
 12 files changed, 1241 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt
 create mode 100644 drivers/clk/imx/Kconfig
 create mode 100644 drivers/clk/imx/clk-imx8qxp-lpcg.c
 create mode 100644 drivers/clk/imx/clk-imx8qxp-lpcg.h
 create mode 100644 drivers/clk/imx/clk-imx8qxp.c
 create mode 100644 drivers/clk/imx/clk-lpcg-scu.c
 create mode 100644 drivers/clk/imx/clk-scu.c
 create mode 100644 drivers/clk/imx/clk-scu.h
 create mode 100644 include/dt-bindings/clock/imx8qxp-clock.h

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
