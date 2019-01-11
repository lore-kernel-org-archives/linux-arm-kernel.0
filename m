Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D132C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:37:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3497217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O+vDyOJl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EGYknVer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3497217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=rSahdpenAIQ9OIGbGhW/LSSf7vpIlCk3vH9L3kSXqgA=; b=O+vDyOJlqv6+dk
	ngkiSJ3TLQUZJxKVdt7LhQAgOw4DjGH7DLQR/M7GEYQiSThpXZF/MEzGk0iHK97P9bM5Jaxm11jvX
	JPsoWtwo251pE+vLAMPPEHl5G3mLaw3PDw76oHMyQmWVA2UGJyTHPrUuUobdJCau65BK15tk40d0W
	YIBCsVaoc7CVVMiqJR9mbz6AAj85rwrrIZuaCqHAs/nJzNjijZcjoB265cVCtba2ILMTLe6sSmOqO
	El9Su9daKmbhNZ5fPO+MYtD7laDXo7ImBZIr0Ntb3I8zueMU09jpXZ83F69yZ2kuz3OCth+VT0q2H
	SdQVu1w5Umd0894T4XBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghv7v-00033z-AL; Fri, 11 Jan 2019 11:37:27 +0000
Received: from mail-eopbgr20086.outbound.protection.outlook.com ([40.107.2.86]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghv7q-00033C-V5
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 11:37:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iIjC191k26zvJBK1IjZ4swLVQUBKNN+n4kay1KA1lQ=;
 b=EGYknVerlykTLncWMRUongCVA3/7CPJVGu7GD8E+gyJBNAKJkZDpdnPZ3VTsb9nLAS7nFCThQ2JI9hAUYU2F6FUw9lyXeWmyiDwlq7LNjyS1DeyDpGdKB6rrsAfzmmY7j+L5hSl4sWYEfhbGqIqrGvy8mSMiEaZReMSgWFfnBWo=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5684.eurprd04.prod.outlook.com (20.178.118.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Fri, 11 Jan 2019 11:37:20 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 11:37:20 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V6 0/4] arm64: imx: add imx8qxp support
Thread-Topic: [PATCH V6 0/4] arm64: imx: add imx8qxp support
Thread-Index: AQHUqaICeVTSFs+N7kK+1k81Pk5DWA==
Date: Fri, 11 Jan 2019 11:37:19 +0000
Message-ID: <1547206279-26169-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0085.apcprd04.prod.outlook.com
 (2603:1096:202:15::29) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5684;
 6:Fl3eauw2bayxNjI8P0tgrt5eb+4ppX4dtdrSYXKI2nqxurYdk7r2qdbvT2b6jGSHbUHSFuJV9bsvYwx/wPZozCguhpWPnhA8Vr6lRaH+lULV2/ykibZQc+mtqjS3QHOK1bes9VVteZsH2vJL6CIzQVc8X27ZzffTibEdHXnGMppA85Vd7REs6X0Z42kroltZ1uxhzv35UZuWe8Z5NmyFW7iY6m7ahoMAZFGJaAAvu4C5GOeWJd9KiaYMDoNu7hgEO8QwEBSDAg1DqN4rmmMXVlIq96cP68eDW8VopTo/viP+wqiAJMy0ust7mT6rfw7gqkp8sHAB5rSraGVGCXUCrBJzTNTnJiaLpbGF5jH7LVvpEZLCS05nsTZM4LuIfG+cvP/8u3o4xzbtNgjkw46unFzECE+5Hn9TbYz4+Tga7YU4tYjG66PWECzhthUYM/xCdkwYv8wVYQkZoGtk6+7/eQ==;
 5:MG6/uwO/9Dm3XDTMT8ZW3/1hnAs4NVSPOTmWuSirQ+jVKcaAtzxES1XvoYKIr6K6P7g5vdYknUAGHT5sYVYIA/8TWI+UXTmZ9wc4Y5UTPUP7Ci54Yv+pnCX82kDRImj03XvMpIwbwcSWUkCWoUO1uw8eZMG9SHHm6OtIq9YVqFwFUx7+PnS75wuONNGrxgkN/nmuLuqzRXzw8MSEJYJQvw==;
 7:65t0XXN1rF8VSZhfoq2loCAIpDlWysr69iz5VQTHhiB5AavN408MDf57MvyNs1Qwj7/NELTjoyz6TfuQve2dW5g8T0zBco5VszFRcuFoCbMlNJ2G8ncMcljw2FD2WqblOZfL8+BRf3ODsBjlYEIH3w==
x-ms-office365-filtering-correlation-id: fddc4675-b262-4c14-a0a8-08d677b9252c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5684; 
x-ms-traffictypediagnostic: AM0PR04MB5684:
x-microsoft-antispam-prvs: <AM0PR04MB5684FFCCAC8CB5A13714DCE680850@AM0PR04MB5684.eurprd04.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(39860400002)(136003)(376002)(396003)(366004)(54534003)(189003)(199004)(50226002)(256004)(2616005)(2501003)(8936002)(316002)(26005)(52116002)(6436002)(14454004)(54906003)(6512007)(97736004)(3846002)(6486002)(6116002)(6306002)(99286004)(81156014)(81166006)(478600001)(39060400002)(186003)(8676002)(966005)(5660300001)(68736007)(53936002)(2906002)(2351001)(105586002)(106356001)(66066001)(6916009)(386003)(6506007)(4326008)(44832011)(86362001)(476003)(25786009)(486006)(102836004)(7736002)(5640700003)(71190400001)(71200400001)(305945005)(36756003)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5684;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 74tIarlbHPJ00VaLfhR2B7h0Nm+Jl5Q5fZ8DGMjxZnY5fTFYTslt9OD4UKiqGWisUbyCa10oH8k7H4fR/rmMiLl9yyY2OnclTpTnYb69GJqplhN9+Pqrhd/3oaWJPD5U2eLB/CxNsoXW0Wc8ui6+p2tvYRk0gJ8uc8u/H2DnN/iwTdhRKKVC6RbYnLc4XSNZJ5QmAHb9x6BS1TrGpb22X9apj9rCDN0MloLhsE7bpIQaAD2tsamoc85iyg7BA3OrBvMqrW+1uqFN9TFauPH42I0dMR32j2MAm3r0aS8Ew8bSGm5VWEWNPPrJbZTAmlzpL1LgTiML81De8COGN+DAfnVbhL1a5fH+sfzBbDQqr94+Jb2Z2tYLxV9hTpMD66Wf/IV5khKzyGZRmIpO+13VAGfwPej+EOYPTc9+nC7/ww8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fddc4675-b262-4c14-a0a8-08d677b9252c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 11:37:16.3668 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5684
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_033723_425925_CCF4D3AE 
X-CRM114-Status: GOOD (  11.92  )
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
v5->v6:
 * separate binding doc
 * merge imx8-ca35.dtsi into imx8qxp.dtsi
 * remove still unused nodes
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

Dong Aisheng (4):
  dt-bindings: arm: imx: add imx8qxp mek support
  arm64: dts: imx: add imx8qxp support
  arm64: dts: imx: add imx8qxp mek support
  defconfig: arm64: add imx8qxp support

 Documentation/devicetree/bindings/arm/fsl.yaml |   6 +
 arch/arm64/boot/dts/freescale/Makefile         |   1 +
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts  | 137 ++++++++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi     | 442 +++++++++++++++++++++++++
 arch/arm64/configs/defconfig                   |  10 +
 5 files changed, 596 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp.dtsi

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
