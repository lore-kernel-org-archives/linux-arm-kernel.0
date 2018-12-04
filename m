Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBAEC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:39:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F27F20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I+Fknw+R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TaR+DTi9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F27F20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=WdqXZo/mtL7wcnzq9IjQNMY3uQ8ifmIJrAj149ckxxs=; b=I+Fknw+ReuoEKW
	ymsIeqVRxEOby9Fo0oJI47gqeNF3tfEscyB9b+whwGvC3FzwE5Ipnk0m+IvXucgStX1QrMUV+HMHP
	MSkUEUJAappZGbwDmsvWtjAtUAGEytA4g6dKZdqcnaJzE83MpfWnDmSeKvUJSq+o6Zyw5+PLBLmNU
	lRMt7eu5xP5e+ZT2LS+gdxHXUHsjB64O7RcEh5uFPBrDbSGGBt09aL+tgkb0Dhs+Cb20CH7rL8+x5
	Om5AlzMHj834133M7qjmYRIzL2N3tZxyhPjhB6oNJzUGW1kAEDPecqr/DJP9Quljw32LIhFPc1sMF
	z5FzI0tOUn3v1Pz7uRLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUBrM-0002ot-Ep; Tue, 04 Dec 2018 14:39:36 +0000
Received: from mail-eopbgr130043.outbound.protection.outlook.com
 ([40.107.13.43] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBrI-0002o6-RC
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:39:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iq5FychqW8bgLZrvnPKBu99zhg3gx9iIhFSq5yUESR8=;
 b=TaR+DTi9LCJRSQeXlprNmfIMGso4oy/WBKGOsV4xzVccWPzkwxnzR3moBIXjchm5UbgxhPdfkCP4kj83qP7TyNvax5tJnScwAyQ70MVaaTpH0+JgNAb22j3cugkMyR5N1IAIrSgAFlDmiJLN5nY5HByy6prWTUZOhwRwnU5qOZE=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4546.eurprd04.prod.outlook.com (52.135.148.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 14:39:18 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1382.023; Tue, 4 Dec 2018
 14:39:18 +0000
From: Aisheng DONG <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH V9 0/7] clk: imx: add imx8qxp clock support
Thread-Topic: [PATCH V9 0/7] clk: imx: add imx8qxp clock support
Thread-Index: AQHUi98jvykrnvKQL0Kg33biwal6jw==
Date: Tue, 4 Dec 2018 14:39:18 +0000
Message-ID: <1543934041-12572-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::27) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4546;
 6:zv4pyIuyWp0JhNqgsH91fnHaRAaTzbB3Z89XkGu7lPf8WdouqQxfb58QWS1sgr6fJsFohErCykprZU0WoQQG6l3Dnt5e+Lm/njLlHSBplsPFZHKbEkf1tc0aDIfQxt6E6limRrhcRn132MEa9iQhr3V8rp7+jv/gazz7MoDo/tuvrpi0HJBIE4bgFUXkOADzSggoM20lerKIvDSrtBBm/yxc5ryg+Hsp0kLcEy/V41z4hSV/aVJKSC9KnmubzBGDj28FxjqJ8VIAAa5ZlVBkr/f4ou56F4Fx0Gs+hDRiApv76c5YAwO+RGm7aiX807gclyZclr+89MuH4j/2xBanJbyidvSx75M+jKVvr5ercqpOG1JwsUhshjln96vTsn1wVtMc5IfC8Z0RPCi1bPBbkyeWf28Hr/XDNxPkTvCC1+PqKu7XDQxsDzHQnMMfymzZ6YpinHG9nQQ83elfFqRIvg==;
 5:A36tTXydj28I/Bf3X0gsLm5HBzxRU3J+GT4xbzTMPV5VYd3Q4THlz16nBUKJtTPiWeyzbuUrTt+fJMqstBscQOgBVvbhN0doEVfPfv8Yt0LbxtHofG2y76v+Bm3XLSOEjpUyiQmohq3dkBEAnDD2C3THaqVq/r7TV7//IaRlePM=;
 7:/N5KDfatJribyxqCpv0V3t3Sn5EhaUAGunzKgw6T+q3zxfZAOVJZY6k6v4dL6DuwKrUiStLDWx/IMj6117CHADQwVnm9vUsjJW+T0k2dLL3QYhDbAq/gSM/DPA9KlsXT1ET3ys2SR9hqQRkdeuxXdA==
x-ms-office365-filtering-correlation-id: 5cf5315d-6842-488d-12eb-08d659f64556
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4546; 
x-ms-traffictypediagnostic: AM0PR04MB4546:
x-microsoft-antispam-prvs: <AM0PR04MB4546A1CC99F0F940E466204C80AF0@AM0PR04MB4546.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4546; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4546; 
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(136003)(396003)(39860400002)(346002)(366004)(189003)(199004)(54534003)(68736007)(36756003)(66066001)(316002)(2501003)(6486002)(6916009)(97736004)(71200400001)(71190400001)(81156014)(50226002)(81166006)(5660300001)(8936002)(8676002)(4326008)(3846002)(6512007)(386003)(6116002)(26005)(186003)(102836004)(2351001)(2906002)(99286004)(52116002)(6506007)(106356001)(53936002)(305945005)(105586002)(5640700003)(256004)(14444005)(2616005)(86362001)(478600001)(486006)(476003)(25786009)(7736002)(6436002)(54906003)(14454004)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4546;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ry/y0aosuWclLauIBfDqjfATTRGYC5I0x36OTn+gnzodRh1QvsupPA0/qqAFHwRFs0ZkLt36z+qbJkP5B6BjeUuZ+Kb7ETLkvYHR7VDqOJy7PpL0F1fLBRLp7qSaIfS8OFZ05PP8xxGwT7dvziG22lLufDHAh6z/wu6+qS5D75jXR1bzswbzfrvRRz95RbRKALwnAO0DquakXkxJgPYOlI/erBcbfhWJ94DyvVyzDQzOoOQWLuFLTbp7+Jlti04e1LPJC48h8LM3PT9EIZoz/0htKVMXvFc7LMVZgLKC4wo5D1sxoL790gRUd21H0PPSUMoYVdot8ZRC7aJYHDJAg5zZnmAJiSlU6BvKGnby7a0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf5315d-6842-488d-12eb-08d659f64556
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 14:39:18.7275 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4546
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_063932_995966_E4B75003 
X-CRM114-Status: GOOD (  15.16  )
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
Cc: Aisheng DONG <aisheng.dong@nxp.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
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
 drivers/clk/imx/clk-scu.c                          | 265 +++++++++++++++++++
 drivers/clk/imx/clk-scu.h                          |  24 ++
 include/dt-bindings/clock/imx8qxp-clock.h          | 289 +++++++++++++++++++++
 12 files changed, 1242 insertions(+), 1 deletion(-)
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
