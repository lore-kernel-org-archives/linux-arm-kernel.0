Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC521C67872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:08:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A504820811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WuJ+E03r";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="APbOPpAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A504820811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=MwVomDv4fBujVdzX/RVGTniVNeu0jlFI3si3L2jW2LI=; b=WuJ+E03rdEjoQD
	uaBE9oh9EgPKnL2gSbWOYkmA7etPerK0jmfdjgf/+pgWtUig4N2gqIshN8uAxapuzfoJl8u+QtRVv
	c/AhkI2LyY+c3dpya+X/CkcI28hZ9eakx7KqndX0KGBdtht/ESjZUdaPlepn/gzRbTPgPwME4RCbj
	ypQu2LQSzQyM0UYJni4/DReCrsGfZS1wc2xuGcryzGUMAtMyi/IljIB0mLzOQSEWwS52KLVTnFhBG
	vZtR75Z3JMb2vqn92A8AnJbq8VsW1ob3W+xqqTPCURRK6vmgmd6w5+IPQzucASTBnJ3fnivmk0zgE
	jl8pgC5hJQ+kET10IbKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXFTy-0004F2-Ee; Thu, 13 Dec 2018 01:08:06 +0000
Received: from mail-eopbgr150055.outbound.protection.outlook.com
 ([40.107.15.55] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXFTv-0004Dx-SD
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 01:08:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cl6bcf18fuzY4kmVeiNlLY+hh6V3oSvNU51U89+MIh0=;
 b=APbOPpAiZLgc1+4Wg3PJMBIEmflLpnIcgryFALtuR/s4VZEpykG66QspXux6K+2Zon8DHcRUuRwTifQjIY0jzJ4GFrJ4+RZFyBHkIK0tue6n6wWkISf585tSQfbwtuIbdCi87eoXahoSlxlXO1HpKk9OhdHkBlBv+NLplZoH/bQ=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4308.eurprd04.prod.outlook.com (52.134.126.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Thu, 13 Dec 2018 01:07:48 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Thu, 13 Dec 2018
 01:07:48 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH V11 0/7] clk: imx: add imx8qxp clock support
Thread-Topic: [PATCH V11 0/7] clk: imx: add imx8qxp clock support
Thread-Index: AQHUkoBD+gWfa+wC30CVm0g2j4YYRg==
Date: Thu, 13 Dec 2018 01:07:48 +0000
Message-ID: <1544662938-5020-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To AM0PR04MB4211.eurprd04.prod.outlook.com (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4308;
 6:bdCxfytZLioQy7zi1732RB58DsWu7KD5eY1Q/Hz5oG/MmcLa72NwPWmHux3SETVVO8NxqJHyfy1JpqiEV/eH8dAdgXAg1mpDll2Bxvr58R1dv5qYnC3Ixd++IfhiP4U7lYEL+wertqucoAlDfeQ14IAOXP0iVSvQHHGXcl1OVdoclW3tiGvqklLaiEf6jqgUeNUBWg3fhLkIkYVnAuqK/bfFR8u5qsdy8avh4UFQiKSdxVQdP5gh6UNIa4kDC/+CVZayWmeRGyj1MlayK0tCACntziCmHYil0cxbMjYM6322MNZgNTyX2f4uQe5u3AaxC3LMYTQ3MaQnwAvmST2WtYQNrYTpaGvJ6VNNcUSHkv+wymWW/3K/2OR+UfMjXcBfwnazIpdr6bhP/+S2zL3O/H14sE/vnmA0hGzjs7vM0l4cfJV2kYVBjTqCtwyT75ZNWhKLAe/GABUEAmpxS/l0aw==;
 5:rl7mXQJ2d+Wsd2KhpDxs9MIdu6IDci1XMGuIoHTsu/LhW7BECRvdF78YJS4fH1HP9B5txwaXf4XQEASmelF/D4AJtLgP4h1mMneQknTTNlocPq1ZHNUzVlmi36I+HKbl3f54TsxheUGnWkHwM79J6+xIdRnJaqwkVO3nFWhJy6U=;
 7:z4JUKigUrdCROSzS6k0dlBhnvJdRuRpInjDFP0Rkdqx5s/Q2c7Lg2XPZQWZ1upo3WEg5jgd4acvqWjZeorkGBnCZmGAxtb1zIchqSTabPdqt5ILelmVDJxP37GCbLGFpROvrkyRwkLaQkBLEMytUhg==
x-ms-office365-filtering-correlation-id: 0307df9c-08bb-475f-e4a9-08d6609765c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4308; 
x-ms-traffictypediagnostic: AM0PR04MB4308:
x-microsoft-antispam-prvs: <AM0PR04MB43089FEA66967CF49899A1C980A00@AM0PR04MB4308.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4308; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4308; 
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(346002)(396003)(366004)(39860400002)(376002)(54534003)(199004)(189003)(105586002)(106356001)(97736004)(102836004)(6506007)(386003)(26005)(52116002)(2351001)(186003)(4326008)(2501003)(66066001)(6512007)(5660300001)(53936002)(7736002)(305945005)(316002)(54906003)(6916009)(478600001)(99286004)(44832011)(25786009)(36756003)(6436002)(6486002)(5640700003)(68736007)(14444005)(256004)(476003)(486006)(71190400001)(71200400001)(3846002)(6116002)(2906002)(14454004)(81166006)(8676002)(50226002)(8936002)(86362001)(81156014)(2616005)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4308;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6eHQiJtPvOPCMo/qHQzCZi+wDxJAm80sVibTWF039JfxMNmUhSt5fbBYF/mmMQ8tBSp1ABP/QYOFEvmUtGAZNlvGHaSyjeAsC2jxBXOLBROuc+FCfvzvuCz3etuFmKde9jKYIRQrAZ4TCkFXxPtwxC7bbSgm0rzNcukFrmYgoQsj6e/Aw6kyh6U5XqruIlw8LFTMT1rMserZs09KU2SykNCy+cjFBdE8KM14VrV4eIRTuUNNPlxpshVOVQMYmVDq49wiVtEiNIQn9c4Js8uzWmpwgKrrtrfJX9oqZ8MFchdUzpSf6+rylJ60/er4rKJy
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0307df9c-08bb-475f-e4a9-08d6609765c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 01:07:48.7464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4308
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_170803_914780_C6F0DCFA 
X-CRM114-Status: GOOD (  15.18  )
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
v10->v11:
 * break dependency on the arch Kconfig
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
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   2 +-
 drivers/clk/imx/Kconfig                            |  11 +
 drivers/clk/imx/Makefile                           |   8 +-
 drivers/clk/imx/clk-imx8qxp-lpcg.c                 | 216 +++++++++++++++
 drivers/clk/imx/clk-imx8qxp-lpcg.h                 | 102 ++++++++
 drivers/clk/imx/clk-imx8qxp.c                      | 153 +++++++++++
 drivers/clk/imx/clk-lpcg-scu.c                     | 114 ++++++++
 drivers/clk/imx/clk-scu.c                          | 270 +++++++++++++++++++
 drivers/clk/imx/clk-scu.h                          |  18 ++
 include/dt-bindings/clock/imx8qxp-clock.h          | 289 +++++++++++++++++++++
 12 files changed, 1233 insertions(+), 2 deletions(-)
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
