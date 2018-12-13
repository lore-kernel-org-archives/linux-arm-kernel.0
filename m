Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA43C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:17:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8610A20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NIfa2ujR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m3u5XPIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8610A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5gtILRhen20XomUkpp1vvtSN6elY6c3h2blHhP9BAUQ=; b=NIfa2ujRYCw2KE
	SKoV8QbqbkYMIZd/BRlsQ4yTxUwkqRD9aWedGL8W7BLUgJSCOxkSBe8A0IYlraeI+qfT9paJDlh40
	wgE1NKU6LQ+TdYBLzOyxpg4gY9Ckuk08ppF6CgYMucC/f/OKheMOup3jGlJ0b6WNBnkwfkKBtXSTo
	zk/jxueEHVWTolDRir7hvO6BB9cGJp0q8mhWldIYQ5yhNn9IOYcN5aFbKndb8x4pAipYBFAudhsWl
	gewDYg2gEfC7mY8u2sDYiWBOI/AFNRpgyb2vbyF64j7wi6g4/1qjRirM/J1+lJmIZ4oxoPYmuOrGd
	z9uKt19LaqNw1GwsuP+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQsH-0005bT-Ug; Thu, 13 Dec 2018 13:17:57 +0000
Received: from mail-eopbgr30070.outbound.protection.outlook.com ([40.107.3.70]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQsE-0005ZT-LS
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 13:17:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IttkqedxI7/eKcmWVjuNP4AGS1Eow4wq+J6L9CzuYm0=;
 b=m3u5XPIsDnHQVpOCr8aw/kkei+U2c1Eq7nojeLxBaP3ydeRbaxtOEOUYg9o/27r8ssxNAsk3x0+9MSGuzMqRTEmv9IhQKVxEvwtcafBBd1mTa7i3WAPsE214+nKIDtEpvHQl2niKcXVbtSyNC0ZMQTeoVz8GLuoMd65WuJUBH8Q=
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com (52.134.65.28) by
 DB3PR0402MB3692.eurprd04.prod.outlook.com (52.134.65.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 13:17:40 +0000
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb]) by DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb%5]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 13:17:40 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Aisheng
 Dong <aisheng.dong@nxp.com>
Subject: [PATCH 0/3] i.MX8MQ build dependency fixes
Thread-Topic: [PATCH 0/3] i.MX8MQ build dependency fixes
Thread-Index: AQHUkuY53d/oCm2ngUK7tf7BE0j/Pw==
Date: Thu, 13 Dec 2018 13:17:40 +0000
Message-ID: <1544707047-4417-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P192CA0103.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::44) To DB3PR0402MB3658.eurprd04.prod.outlook.com
 (2603:10a6:8:2::28)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB3PR0402MB3692;
 6:sSoL9sSDXE+NtyHzavtOcPL7ehVOBNobph6Gf4ZtdVshrebJHyp5cw8+NduZMf9AZp9BWXt8uMJpe0B3KFzsIZ882bSD2+EZlfQ/dI+DdipP7yULulNwlrzvKTvHcYNUSae2chKy4pSSPE9gaZUNbteLTmylpU+8/uDaFlWC3MJyWYgMU4uf8IV7zj51dQj59jPpJb6UI3Ui0E4UXKsWvCrxdr53tzxZlLxCGtqANaIkW/o5Ji+4X8to0bxqQF2vitHewUzdoMeVEymwtgQ9u89khSDW0O8HmBdHII2hJdh4/jxopsQ9ZKRfCGNHmSPg4qEHSyEW/O2zDUrJVP7YDuaFBN1Tcc47VCfe4imbLAWPUF12vHRJsecnWSiWJJAzgPJivJvR93L7OiXTezoSz7dMs2Mi2L7mwt4rqCdysB7LIxTsSKtDXEYmnI6xuV9RrOshT5HH7qyZxo41TtCFRw==;
 5:WHwAibX17l9xQwwOLKK8OCrnGT7AVJI+wPxvutak3Kpa6mA41y9br+7KlvUjDqLGiFiMf4bgV8xzgq46xj91sAoZ0gnM3wSG41ZK82aVS6wHNv7gKZ7RerHMomoeKoXgP73HMk6XO51NMo99yoFyZM3jPGCJl9zvrArOs2MY5wk=;
 7:NMGfMacHLhUmWf2cdiM6fgBFMZyRd1tOuyagzx5M2Zpse/oZf3AHTBexr2BZ0z8PdQqzmMW8dNnfWqbnMshrmrT0Y9Ew6O1OqcxygJUOFPywu6KHXbIs6ud1SrVEslWBbiyxe2nKNTLiQ7BQA4ACTg==
x-ms-office365-filtering-correlation-id: 42726cc9-5244-4b25-e65c-08d660fd5bf0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3692; 
x-ms-traffictypediagnostic: DB3PR0402MB3692:
x-microsoft-antispam-prvs: <DB3PR0402MB3692DB5F2303EE85121DFF8FF6A00@DB3PR0402MB3692.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231475)(944501520)(52105112)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:DB3PR0402MB3692; BCL:0; PCL:0; RULEID:; SRVR:DB3PR0402MB3692; 
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(376002)(136003)(39860400002)(396003)(199004)(189003)(81166006)(36756003)(8936002)(486006)(186003)(25786009)(305945005)(2616005)(476003)(26005)(2906002)(68736007)(8676002)(81156014)(6486002)(14454004)(386003)(7416002)(478600001)(6436002)(6636002)(5660300001)(6506007)(256004)(6512007)(86362001)(66066001)(106356001)(105586002)(7736002)(54906003)(110136005)(14444005)(102836004)(316002)(71190400001)(71200400001)(44832011)(52116002)(3846002)(6116002)(53936002)(97736004)(99286004)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3692;
 H:DB3PR0402MB3658.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: W1lkyMcUT0SLpUzqd0io/oHF2GjKV5UqfkaGLvnyr7i0CaSK/r6zj6fOSq0xzQVFp5x9WTzruemRWNr2yciejdvEvrt7/gMBOFqId6a9guCJt80FyM2g+xVkdUH9846nJ5CUCChzo/YQh2pc0+OkJm8/RU4sdBWvWuOqmPSPK31cOoSH8mXtiR9j5YU3Sf4h2/1gHot+HymKnuDqG18LlNyIKV08nQc8WfJjUneW1JwMdFuKTi1YB3w471omvhBRAR9hAdGbHruLbSG1HemFPo+tRXrjmEkY9Q98c8Sexn7QpM82gucInK94Jww9qHqk
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42726cc9-5244-4b25-e65c-08d660fd5bf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 13:17:40.8362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3692
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_051754_704746_564185E9 
X-CRM114-Status: GOOD (  11.58  )
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
Cc: Rob Herring <robh@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Olof Johansson <olof@lixom.net>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

These patches will probably have to be take through different
trees, but the order has to be kept otherwise this won't work.

I can resend as separate patches (if necessary) as long as we can
get them in together.

Abel Vesa (3):
  arm64: Remove CONFIG_SOC_IMX8MQ and use ARCH_MXC instead
  clk: imx: Build imx8mq clocks on arm64 only
  arm64: Add i.MX8 boot necesarry configs to defconfig

 arch/arm64/Kconfig.platforms           |  8 --------
 arch/arm64/boot/dts/freescale/Makefile |  2 +-
 arch/arm64/configs/defconfig           |  5 +++++
 drivers/clk/imx/Makefile               | 11 ++++++-----
 drivers/phy/freescale/Kconfig          |  2 +-
 drivers/pinctrl/freescale/Kconfig      |  2 +-
 drivers/soc/imx/Kconfig                |  2 +-
 7 files changed, 15 insertions(+), 17 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
