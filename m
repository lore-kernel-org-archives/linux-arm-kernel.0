Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6728CC282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:00:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02810222C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KFOfnRY6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sy7G95FG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02810222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YPoWZD7OeA/fBi+O+x3xkxilI2VunupKFrzq2AXV3LM=; b=KFOfnRY6c5/61g
	18Q3ges+3EQceZDd7Gk9psD+OA1oDG2csyyhiiXVGVVFffmpzZqtoxh3PmiDtsHQj+JSo0V63QhVv
	EvkAkLi3vTwaBw0Gbwq33vbAgfqdQr3TIsuA64IfujN9VWd8nqj7WCDDhg00FlhhW/FQniLnkUlJR
	//qh4smvGwjzKc8Pk2XEGo6M12kY09vFZfZX6U39JolPvbgGeav5S23mKbhhjb1fotxABfBFN7sy1
	tPcLE95FF8JeRuvM8+mkUMx1iT428DLP/bU8tZxSZB/yEdAtsJG5EQ/mgu+hRBiXcgjGCguNF+n16
	PIUF4P3H+vlczVGJm1Kg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtf9q-0006fU-Df; Tue, 12 Feb 2019 20:59:59 +0000
Received: from mail-eopbgr10072.outbound.protection.outlook.com ([40.107.1.72]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtf93-0005rE-My
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 20:59:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCYVD9fSM1tBHZCNbbmXK7hmRXG63Dggw+BW46+nIls=;
 b=sy7G95FGZeX4Wp/qIsU8DibbzooqOMwnhp3qEMq7s0dUe3BFB6BPL8Ar8IFNgLSOeQNixHbD2BBkjmYGFa5u7ahpCd3ZEpMY7cj/iWo171BuqeIQrGaojI4y2fR4LPXyuwufvdvmuK8jroZbQQHUPJtzDWZt5VPr2fucVQ1/Z0o=
Received: from VI1PR04MB4910.eurprd04.prod.outlook.com (20.177.49.159) by
 VI1PR04MB1613.eurprd04.prod.outlook.com (10.164.84.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Tue, 12 Feb 2019 20:59:03 +0000
Received: from VI1PR04MB4910.eurprd04.prod.outlook.com
 ([fe80::6cc7:b375:76f7:b849]) by VI1PR04MB4910.eurprd04.prod.outlook.com
 ([fe80::6cc7:b375:76f7:b849%5]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 20:59:03 +0000
From: Frank Li <frank.li@nxp.com>
To: "mark.rutland@arm.com" <mark.rutland@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 dl-linux-imx <linux-imx@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "lznuaa@gmail.com" <lznuaa@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V2 4/4] MAINTAINERS: Added imx DDR performonitor driver
 maintainer information
Thread-Topic: [PATCH V2 4/4] MAINTAINERS: Added imx DDR performonitor driver
 maintainer information
Thread-Index: AQHUwxXJ3wQFS5yVI0iqfNuecqJt8A==
Date: Tue, 12 Feb 2019 20:59:03 +0000
Message-ID: <1550005119-25750-4-git-send-email-Frank.Li@nxp.com>
References: <1550005119-25750-1-git-send-email-Frank.Li@nxp.com>
In-Reply-To: <1550005119-25750-1-git-send-email-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0021.namprd04.prod.outlook.com
 (2603:10b6:803:21::31) To VI1PR04MB4910.eurprd04.prod.outlook.com
 (2603:10a6:803:56::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=frank.li@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.5.2
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB1613;
 6:ITF/Ou7kUcfePyX7buXDSMXoS0XFyWD45T6J5bqDfT0X3v8caAt0HfIcd6MoD4jAEqJQ9SbRJHGW3NYDnTrjz1WTKaT8W6Vuho3Ez0Ub3J3NGdNlwEqQZzcsAEjFsLOZaQy4zU1a6RO22K98tNccIxCVoZBuoTdI+0q76E0ZgryWjkxBld4Q5PZwIkuxb4Xaw1LEmeUJu/khtS6/Y+2e+8LQSOoRcrYiYAKG2JOBnO+CdXuLElx1uv9ElU6eYyM1doTMbcwjSmY4wBKr88y0qORKgV0XwDJqNIc2a3gjbbOX0NmFP76WSwQyWG3VRVyotGI/57u/BF0pBaixywHc+/P/SGWTq014IxWBzXYW1b1S1UG1w75Me0MIsz/auK67Lm50N3ZkUOSDz64g0WuYDXtupt/Q2MWsdgNRNYfjVDvvgyNV3qi7alNqHjcNfgUyJ3vZzOpe0HnzsEQsuOcMng==;
 5:7hwfcxG+uVyFCu3WmMTbJFNMSiVjZAB7/0rd5tuGMprOPA/vMq0KRwazvoFA9iF2Vf+3pqr4+3OcvVKEsFdRSU3p7+H+u7D946HfWYi3bToqsxgznzSt2Uwyj4sYsnUjcFQVS2kGPvBc2u0EFh6sTtGNA7aJ5fs3Lt7ahwRd2+oMH4qz81cVhPW5xww1pOqsEfLXneGBxgMibIDEPy4dDw==;
 7:kI+Mw4kAxfSEYnW2bG+7LwyOS6sHBICeU2WoPe0Kl0crvXp8XBD1vpEVw0yQCU7+G1o4p+VSPSBN11Tbgq/JU99Gc8K9jYMdnMdqKd4ow4xOQyiXUnxBvVCMiUZdD3Kze4jm3YiH5W1jR4oosEPjpQ==
x-ms-office365-filtering-correlation-id: 1df05d88-0dc5-48a1-52cb-08d6912ceb5c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB1613; 
x-ms-traffictypediagnostic: VI1PR04MB1613:
x-microsoft-antispam-prvs: <VI1PR04MB1613CBDD2B73403A5A076E6388650@VI1PR04MB1613.eurprd04.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(346002)(366004)(136003)(376002)(189003)(199004)(97736004)(71190400001)(81156014)(26005)(11346002)(81166006)(446003)(102836004)(50226002)(25786009)(386003)(6506007)(8936002)(8676002)(68736007)(99286004)(4744005)(6116002)(3846002)(71200400001)(7736002)(256004)(316002)(110136005)(305945005)(76176011)(7416002)(53936002)(2906002)(86362001)(14454004)(2501003)(2201001)(52116002)(186003)(105586002)(478600001)(6486002)(4326008)(6436002)(6512007)(486006)(36756003)(106356001)(476003)(2616005)(66066001)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB1613;
 H:VI1PR04MB4910.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NQuCREtYGJu+MCJhs1Eu/Q4vje+Thz6k9fWlyn89BmIsb9x3raCt+Oe300Xg7uftR591LjtF3ZyCx34vjsmWGypBJvwQULkhR/sx8HGrad6frbJ+HKyVlLMtwt+sIpPwsAxwRvPi2bFsIiJIeddyFV2K5GigavwRpgZuquGJHJpL5sSSK3FRCPKWX8/w5qCgwx4Pek5560qJaVOmD37Zmhlrd+5dbztIqRdrkYyi60xdpWNdkpY2taYXIcR73LT/z3ok2EdClnqeGzPvn+ruf9OXUX/AU3RB9XQw+/zwMs2fD3QqPGfK6Qj7vrCcd0SYmqkg2UuE0zIO8C9bIA2NoryWgbrOU7N4Knr9Z+ScLnaVp9yDwxWHEcTucvOfUGosz0BT5DQu0Vvw8BLfCCV36wM38HEMwF65P2twRzQXcLk=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df05d88-0dc5-48a1-52cb-08d6912ceb5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 20:59:01.1633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1613
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_125910_175723_06FB63E2 
X-CRM114-Status: UNSURE (   8.63  )
X-CRM114-Notice: Please train this message.
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
Cc: Frank Li <frank.li@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add DDR perf counter driver maintainer information

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
No change from v1 to v2

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ba068e..687be0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6163,6 +6163,13 @@ L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/busses/i2c-cpm.c
 
+FREESCALE IMX DDR Performance Monitor DRIVER
+M:	Frank Li <Frank.li@nxp.com>
+L:	linux-arm-kernel@lists.infradead.org
+S:	Maintained
+F:	drivers/perf/fsl_imx8_ddr_perf.c
+F:	Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
+
 FREESCALE IMX LPI2C DRIVER
 M:	Dong Aisheng <aisheng.dong@nxp.com>
 L:	linux-i2c@vger.kernel.org
-- 
2.5.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
