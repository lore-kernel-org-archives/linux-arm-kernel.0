Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF34C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:21:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4282F206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UsSOyBPD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dxZrOX3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4282F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=2XIK2Gvjo/QucqtSNbg1ODqwK8r60BlJP89giuAyEck=; b=UsSOyBPDDnu82J
	c17tLbgkdH+H87Wc5CzcdA//DQf8TKDnGAkd7t0H6RCJ7ZsOqt++mOJ4KRWFMhEGySTvkxjo7rtME
	18HlPNrLz3qUuaqYvJr9/L6YZ0awcWmneLtbEyxYgKAyymLw+oZrJKvdwYNqYAQGB+uJ8TkHr/Jj9
	mPRYuXI9RSj9DCYM//GM0KWspi5CVgIlydxMHQkQVsDyhPk15MpG5oKJdZ4yHa1OMtxtTnTCyCWzR
	AfL3SU+LBvAbc6bRh2cUlE5EQ9Wy2xOWIKMCRTEpMgskc3slPiSquYjOQM4PuB5cnuWYTimTSGATs
	nTP51fx46G439V5ZYtkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggR6W-0003HJ-KF; Mon, 07 Jan 2019 09:21:52 +0000
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggR6S-0003GX-5L
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 09:21:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CS/l+Z/GBPQylx7hHLd90gCpOtl7TQkEJCMkH0lEyKk=;
 b=dxZrOX3sOYiRLh+688D1kNunLbpcB2gxp/TElG6DcsrKzwNwoe4BHg9ovRUpgaPd3hg+Ax9ppGYBWGPzV9dcs6fbXIxif26vFKkBD+Z0n9z+6VrndstYXeReJ8Fi3WzuS5v1mIq9JJFDdlRMC3wc9QezPJCL1bKyi9d3pD/YtQA=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5697.eurprd04.prod.outlook.com (20.178.119.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Mon, 7 Jan 2019 09:21:42 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 09:21:42 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH RESEND V5 0/3] arm64: imx: add imx8qxp support
Thread-Topic: [PATCH RESEND V5 0/3] arm64: imx: add imx8qxp support
Thread-Index: AQHUpmpm/xZAhHz03UmISbWt9RXpgg==
Date: Mon, 7 Jan 2019 09:21:42 +0000
Message-ID: <1546852546-29228-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0043.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::31) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5697;
 6:7yPVEVz4uC0eTF12O2yovwLgv09uVCEHXIzLnpGLWZzBk0UYPWNqEhhNuR++SAc1gdil3VCql3gxksbtr+wVZNZGjWjLAwutO9Bulzt95fEaKEDz8wKZqG04HFKts7OeUBszNL8zf9L87Jss9CRvx9cfyKX8wxPEaSFy8xwPqml7FblQi2J3v4ZSit+wRrFKe+cDIXFcKM6L9PBvjCk2B+Apif2ujfKyqtjejxKSQCmQqT5M2pjUczjbgs/2aV8GM2XCVv/Rggg5wtoKGavMUZzeyOElMzk8HudfPoHMn4VwPnjU6MS6cy2C2dGkUmM8G1O+dhOhHZP4ZvHPMsXBn+ZyWdC/Bn2m3uexDrWxLA5IwgQnV+P6AvsFZXu0TMmE2FmjxaUVorrqo57ACxX1QOD5pE5z5AQYP6NxMSiZsCMvej4Kfw68vW9LsB93G0YqJWbesCJJyXDG+Sp0FTFZkQ==;
 5:bgAbxdQzCuqWX2djM1Vbiqf3W+PL2XoDe038YjxALvBZFJqICVbMkrf5YCrib0+mLnnFNHlfy3ENXelnxhs8CKfQG7JTeOH8RfSL7JqrOjGciUSYSoOr0ZSUeiDDFbbRYlPm6O+FAYm1lq877Wun8RggbhYf1VwAKotrUxguHfR4Fdttu5EkrwVSfuLn+5n2ghWli1348FBaNXfalSJxcA==;
 7:i5qOwiEw4i3YTleEQ6JL797uyE6ynEJ05gs4wYsApZ57hTY5SXyEDNerAn8fukx/VT5vkdokgP3h8iABRwqDm78LaGaWPn8KFS6STYANWpZu+PX69PZ2ZSUN3fC2L5joZh/wftPzXeY/KtQBdd3/mw==
x-ms-office365-filtering-correlation-id: 2792d29a-38b3-4ace-60cf-08d6748188cb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5697; 
x-ms-traffictypediagnostic: AM0PR04MB5697:
x-microsoft-antispam-prvs: <AM0PR04MB5697591F896EDD98E52479BA80890@AM0PR04MB5697.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5697; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5697; 
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(376002)(346002)(39860400002)(366004)(396003)(199004)(189003)(54534003)(105586002)(2906002)(305945005)(68736007)(14454004)(5660300001)(6486002)(39060400002)(106356001)(5640700003)(478600001)(66066001)(2501003)(6436002)(25786009)(217873002)(2616005)(54906003)(86362001)(476003)(6306002)(6512007)(97736004)(966005)(81166006)(36756003)(52116002)(256004)(53936002)(50226002)(2351001)(316002)(486006)(6116002)(3846002)(81156014)(8676002)(26005)(8936002)(102836004)(7736002)(99286004)(4326008)(186003)(71200400001)(44832011)(6506007)(71190400001)(386003)(6916009)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5697;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lGHUCoOBUkIWVvkfzH1czATwZzMTSYTZXfzZlgkmbhNVQYpsTqlJQhxQg6Ioa05NUEUZNaIv5mS9jF+Nsi9jESdjy11dixovsOMYc/28ZMDV/v+KrUB0AKQcGX+//zSsGKuRxqa4xn3BDD5wuCaFuCmfsL+xciCT0ereXDOwn3LHV0WZOXZE+R5NPyu/YSQJ7eG1LvKOMqgATRyjiLnSEkMd5k+LP12OacJmdK0OrBXdhoV6gPiL6l0np5Z0a0tO1bILK052QGzqfSxM6Jj4mcpTcIqnIc53IqapTLl6VMnMtWzKVMsS7uuGCoKBD3jy
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2792d29a-38b3-4ace-60cf-08d6748188cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 09:21:37.8672 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5697
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_012148_565814_C3AD5BA4 
X-CRM114-Status: GOOD (  11.82  )
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
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add imx8qxp mek basic support with the function
Lpuart
uSDHC
FEC
GPIO

ChangeLog:
v5-resend
 * Rebase against v5.0-rc1
   Clock ID name updated accordingly
   [1] https://patchwork.kernel.org/patch/10741753/
v4->v5:
 * remove the dependency of SOC_IMX8QXP
 * the original Patch 2 adding SOC_IMX8QXP is dropped
v4:
 * change to new power domain binding suggested by Ulf
 * Note below patches were merged separetely by each SS maintainer,
   so dropped in this seris
   dt-bindings: mmc: fsl-imx-esdhc: add imx8qxp compatible string
   dt-bindings: i2c: i2c-imx-lpi2c: add imx8qxp compatible string
   dt-bindings: spi: lpspi: add imx8qxp compatible string

Dong Aisheng (3):
  arm64: dts: imx: add imx8qxp support
  arm64: dts: imx: add imx8qxp mek support
  defconfig: arm64: add imx8qxp support

 Documentation/devicetree/bindings/arm/fsl.txt |   8 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 arch/arm64/boot/dts/freescale/imx8-ca35.dtsi  |  61 ++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 137 +++++++++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 409 ++++++++++++++++++++++++++
 arch/arm64/configs/defconfig                  |  10 +
 6 files changed, 626 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ca35.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp.dtsi

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
