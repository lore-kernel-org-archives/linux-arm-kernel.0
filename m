Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C21C67872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:43:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7498520879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E7jfsQTK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JACBgCVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7498520879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=7dk0sI9Nk9IXlF0vJgtQabMbVL4reBPXPRm6Z57x+PQ=; b=E7jfsQTKcJW/xv
	dtsUwIujHEBbxcAz3fdPVssMMy9Y10fpnfWdB7/YHtmrF0XAJdMUD0sp+zax+89p69zSugmrx0AiS
	Oaq56kVHiNKazBUV0bI1vybqX2WsAfWcZSi0JMBR17vHrp5gcxasLWmntPFKihSW5hY3Bjy6dfrF0
	R5f31bNsa/Cn2YrHJL9mzbIwQdnmpVVvAi8H+Of/quQWOsOmMtC7hKcoU80spzN0dtlSCay00VKdf
	k3iyJcoZvORvF4oo9gozyFGmeAu4gBaEh3YdEG9q+8ymJxCZysALR0VQAlCPXc7C/qvlGUKJweuFH
	i8z0IGGlED9Lol3+d+dg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXT8h-0007yY-1e; Thu, 13 Dec 2018 15:43:03 +0000
Received: from mail-eopbgr00047.outbound.protection.outlook.com ([40.107.0.47]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXT8d-0007wY-Pa
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 15:43:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDhiPGrVfZBtZFQaTgndvY3wyQE6yRTyxKXpdCcPbqo=;
 b=JACBgCVklZXfTAbF+nB+XV/YrMQkMhUFwv486wkxDVgWjahydvs9L4yOZa9lwZIUCxloO+IpadbVELUXM5doi1cgM7SMaA5/l/VwYcXf0k/C3w4qip6xMJXRiN6oJ2z2rk5BgCgahbh9TiZwzUEfAsSAO8pY3xQnT/Q1Fwql60s=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5873.eurprd04.prod.outlook.com (20.178.117.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Thu, 13 Dec 2018 15:42:46 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Thu, 13 Dec 2018
 15:42:46 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH V12 0/5] clk: imx: add imx8qxp clock support
Thread-Topic: [PATCH V12 0/5] clk: imx: add imx8qxp clock support
Thread-Index: AQHUkvp+2I/kA9Gq1kKYOSfh1d+qug==
Date: Thu, 13 Dec 2018 15:42:46 +0000
Message-ID: <1544715442-8902-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0086.apcprd04.prod.outlook.com
 (2603:1096:202:15::30) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5873;
 6:J7tdNhcH/EBvleBhIMZIURLxOHgZnOzwYXT299Cqu4jvufCm+cmTGRZU7Ae3AERIiyTjZxZUeMuzQhrEoLuXB2bjyE7kVV21tGHdYAz+StVGe4xDwc/rYriRB7aQ5gA/B9VGF2wJRu2xivvfciL97rgTyjK7fVpFwNrBPUFjd43D8tmo3UsiTv8VqxDHG5PK+figsk64n7H7ixh2vi/weWDNYMIG53baz3rUWGNNiKfRE4V+/CW6ZRsP132t5sMG3M7ObAbBJUthDzaqPWpDXlK4Qgpn5Yo6ND59Kg6xVeh+IqbsMRTWqnbo7WPNUP4QA0kU5t2aDOFF5QuFrqQE/J0rYpQdYFdLET1qmJVFoLMnS2nmkAdIlnpiM2BAZCgcvx7dL4gtm9YJiHEAG2SL7X39mdFBb1euouYtprKvSRX938ita77q5blsK+feGHlKVLzaHVAmyYx/5RLB/rhQgg==;
 5:VnxNYCrDUuUcmudqrJcXWgR0Agv7nmEGJYvKneh3b+gi7nhI5weUrBT1FY9PtyW0NxhTpAGo5e2jbJS4BZTEUcWiubs5eVuSVQxEjWeE6brM38Wua51ZO3GuQYVyjAmZAAXEz0Py4ywVqR1aRLCjbNgmqDRHceoKUaQ1uCw3i2I=;
 7:YGXhEguG2MVhts7665V/D9x3pGxj+z9XwpMd7ejKgy4kHYrC+Sc+xM7++TE7AmVryu9PWWaulG0Na7VVSBLMw+yh6JUU1PUxSR0O1VUM3myQNjdKZFvChknXzJwBTQ5UZKoadkKI0rmQEhAw397BEA==
x-ms-office365-filtering-correlation-id: 720a0f49-d1de-4539-f50f-08d66111a0f4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5873; 
x-ms-traffictypediagnostic: AM0PR04MB5873:
x-microsoft-antispam-prvs: <AM0PR04MB5873482A395AD18AE7E8448A80A00@AM0PR04MB5873.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5873; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5873; 
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(376002)(346002)(136003)(366004)(54534003)(189003)(199004)(50226002)(8676002)(478600001)(2906002)(52116002)(6436002)(106356001)(53936002)(36756003)(14444005)(256004)(4326008)(68736007)(2501003)(14454004)(71190400001)(71200400001)(6512007)(3846002)(7736002)(316002)(6116002)(486006)(6486002)(6916009)(5640700003)(44832011)(86362001)(99286004)(25786009)(102836004)(5660300001)(54906003)(2351001)(66066001)(105586002)(386003)(8936002)(2616005)(476003)(305945005)(97736004)(81166006)(81156014)(6506007)(26005)(186003)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5873;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VsN9S7LWz8g0eP/CkZcy+4qj8b/WsLYcglhwqWmEE0phyEH+NUkI1ebwdYTcdTCmJ9hSIzY7GZg+Vya/s1watdnDN28XpOhz/oS3P90ZdhzRBGWPHyoAiUp178cAJ2UAZmdxFRWI8V6lXjf0s4QHr0m8iqumZiiWAKQOS6xZxfZjeG86exZE3RUmtagE0WiYYqBGb7heFEdFwLfaTK0yFYbptf52tf/9Me8KYaN6AacmdqoZUiZvrqMuWDkZJ5osNyF7Fbpz/xHXYBIOcfq/6j9THOgpXdJc62KvqPhvp5HO3bd3auaEu8wg6m0JLGYm
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 720a0f49-d1de-4539-f50f-08d66111a0f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 15:42:46.7613 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5873
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_074259_831818_4A79BB71 
X-CRM114-Status: GOOD (  16.04  )
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
v11->v12:
 * remove the dependency of SOC_IMX8QXP which will be deleted later
 * MXC_CLK_SCU depends on IMX_SCU
 * dropped dt-binding patches which has already been merged by Stephen
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



Dong Aisheng (5):
  clk: imx: add configuration option for mmio clks
  clk: imx: add scu clock common part
  clk: imx: add imx8qxp clk driver
  clk: imx: add lpcg clock support
  clk: imx: add imx8qxp lpcg driver

 drivers/clk/Kconfig                |   1 +
 drivers/clk/Makefile               |   2 +-
 drivers/clk/imx/Kconfig            |  16 +++
 drivers/clk/imx/Makefile           |   8 +-
 drivers/clk/imx/clk-imx8qxp-lpcg.c | 216 +++++++++++++++++++++++++++++
 drivers/clk/imx/clk-imx8qxp-lpcg.h | 102 ++++++++++++++
 drivers/clk/imx/clk-imx8qxp.c      | 153 +++++++++++++++++++++
 drivers/clk/imx/clk-lpcg-scu.c     | 114 ++++++++++++++++
 drivers/clk/imx/clk-scu.c          | 270 +++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk-scu.h          |  18 +++
 10 files changed, 898 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/imx/Kconfig
 create mode 100644 drivers/clk/imx/clk-imx8qxp-lpcg.c
 create mode 100644 drivers/clk/imx/clk-imx8qxp-lpcg.h
 create mode 100644 drivers/clk/imx/clk-imx8qxp.c
 create mode 100644 drivers/clk/imx/clk-lpcg-scu.c
 create mode 100644 drivers/clk/imx/clk-scu.c
 create mode 100644 drivers/clk/imx/clk-scu.h

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
