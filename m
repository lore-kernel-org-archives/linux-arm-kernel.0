Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C76C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:27:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A28220643
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ONQvBxU9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lsSFWuN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A28220643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=FGzh5/4DV265CDXfJdXlY0i1l6f7Sl8Rt93/MTk9s3o=; b=ONQvBxU9j7rcmf
	pPhH8FZSbzq4tSVb1LnDrUQlTgEID6UBVnGGLO577gDG3IrW0pyD7vQ+BvIQTM8hvUXIMeeZ0REla
	bkP9ERzKQXQv3WBBrtVACoxCU4FbXrAL0GgJZNe/M+q/xGqcOliapdYJFErgjGMGqcUs7CWOVslbz
	G2uHfz9F17brMhZ4EVS9bfKcOAHxuujUfhOllCI0cq/HEvfgchLsh4DRMYR3oBTe9gN2Djkx6iyzE
	rKlPrxK/Tdw1WO+X97pb/qmqEuwXmPDuySLMUQC6zna0UXnhsXZgUOeLo9kEdgqnykRnVZtMNEzFK
	LI9Dm0QnbVg0uMRZzS+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZdkr-0007dw-T2; Wed, 19 Dec 2018 15:27:25 +0000
Received: from mail-eopbgr30085.outbound.protection.outlook.com ([40.107.3.85]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZdkj-0007KE-NW
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 15:27:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCzHH0YIqgJWs7KWt7r1CVOqpv0XG5IQDudk0MvBr8M=;
 b=lsSFWuN+ZVw5KwUhdwbgcWXh/EDBxrdx9lny/iAHOBxIlQhHAgJtfTQEW20TFkgRivgeWrXRS+ra4BvZ8sgeGNDCjliCHKYuesxSDwbPZu2EPV3Niq7u9MzRyjnuScXhzBDcewiWYbOL+A4Bo6LbSwtjcEVnSkB1TP71VPeR+60=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5633.eurprd04.prod.outlook.com (20.178.118.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 19 Dec 2018 15:27:02 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%6]) with mapi id 15.20.1425.024; Wed, 19 Dec 2018
 15:27:02 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH 0/5] clk: imx8qm: prepare for imx8qm clock support
Thread-Topic: [PATCH 0/5] clk: imx8qm: prepare for imx8qm clock support
Thread-Index: AQHUl69KP5rFoD0FDkqjgax/qBib7g==
Date: Wed, 19 Dec 2018 15:27:02 +0000
Message-ID: <1545232888-9302-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0070.apcprd03.prod.outlook.com
 (2603:1096:203:52::34) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5633;
 6:XdAqAy/q0S95zc4FbYgS4C2DQNQpTT59Ko+dSxCnuQKzsA1mmP5sj0EIfk6aoOMWsawoLJQHwr6QvDpfCaXQFKJIelEpmThGhD5h78vRZdxO/PsCXQOW+uRusHc/w42+zgKbERLtN73c1UAdWv/lsxJ7DuynMz4YOoEKqogXZuarf1DI4eZ9I7F/kFcTZIWshIpX6Pj836nhykWOjeixnznu2lIIcmXRDxb6meD7vxZTGI2l5P27xzxt/OGPEScfagmmYsqxKOze8QxpTxLdqltX9vzKguLYP0smzO1JUgfpBQsJlK+BYZP4pMeYJbRJ9TWdEdz2F969zo6u203RuZGkieuhPIKpk1hVrrbirkAQSDF++hHxJdWSxdlIJ8tCTcoctce13eLBbfmcoSnjxPs/Kfqv1BihQ9mcVxLOMFHIT+tMW60ZTo9FSDct3URkhFAPNT0cJEplROd08YLG8w==;
 5:+ZSpufpsSzjeJzd6IcnaQPFSIiTHGKNANCLXULMDKmrxSxAQSOiRptlZHKp2elTZNNC/smP2NLDX4/q7T7i22YzDO3RSZlkP2yQEq9YClLHIZ53ZQVmJe51yRn+4J11yPVyzbMhqxlemPb5LTjEUVR5QE/AO9ogTiBBWcC4/KAY=;
 7:QeIrwTN67ZlrSfLEJ4hRqP64Nkg9zIfi6lHgxu2bKseUigGSaAGi/CEBIb7hefOix0qEbfaFaKbX28CDVr3v67cScbodY9Nuy3TIqsQ2O/2y1DGu5u7xQHFpgYDruaf0zA2pwUoYRNExglZHQuCxaA==
x-ms-office365-filtering-correlation-id: df5374c6-3aab-4cd5-a47b-08d665c66c74
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5633; 
x-ms-traffictypediagnostic: AM0PR04MB5633:
x-microsoft-antispam-prvs: <AM0PR04MB563312FCD5ECB4EC8E618A3180BE0@AM0PR04MB5633.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5633; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5633; 
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(366004)(136003)(39860400002)(396003)(189003)(199004)(2906002)(305945005)(7736002)(6486002)(256004)(14444005)(66066001)(4326008)(6116002)(86362001)(6512007)(44832011)(3846002)(54906003)(97736004)(102836004)(186003)(5640700003)(2501003)(53936002)(50226002)(68736007)(5660300001)(476003)(81156014)(2616005)(386003)(8676002)(26005)(81166006)(105586002)(8936002)(6436002)(486006)(36756003)(52116002)(106356001)(25786009)(71190400001)(478600001)(6916009)(99286004)(71200400001)(6506007)(2351001)(316002)(14454004)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5633;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 32blxFa5Q1o2/WB7E20/IaWECFesBaPB1sDkaPVh0bUTyASM2IUPqNawRh+X19b0AVgMY1pWiQiEmR0Vj87MgTLV9XaxAOJycQxaA3WrjPgClEbnZgI5efXKTS/9xjTXM3sXr6ZCmS3sw0cR2gr7i9RC9aT87TvIlGsWz/RnVbdiPPzpS8jNXAMiEMOHKXx7iliYdUjPNgo8XM2klJslks32sK3mF+CJg8xQKMC11E9dhO3zweGoZ6NBGfDtMDMjM1QkrVlO8rsz6PfInI3yqx0xWiLqbCOX0QBiwh6w9k+66V0xX3KE8+x3AxGzw0ym
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df5374c6-3aab-4cd5-a47b-08d665c66c74
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 15:27:02.2642 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5633
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_072717_894267_BD4DB0C8 
X-CRM114-Status: GOOD (  11.28  )
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

After a bit more investigation on IMX8QM, it seemed SCU clock can be used
in a similar way as IMX8QXP. So update the binding and driver to be a bit
generic for easily extension of IMX8QM support later.

Dong Aisheng (5):
  dt-bindings: fsl: scu: add fallback compatible string for clock
  dt-bindings: fsl: scu: add imx8qm scu clock support
  clk: imx: scu: add fallback compatible string support
  clk: imx8qxp: make the name of clock ID generic
  dt-bindings: imx8-clock: add a53 and a72 clock id

 .../devicetree/bindings/arm/freescale/fsl,scu.txt  |   7 +-
 drivers/clk/imx/clk-imx8qxp-lpcg.c                 | 146 +++++------
 drivers/clk/imx/clk-imx8qxp.c                      | 153 +++++------
 include/dt-bindings/clock/imx8-clock.h             | 291 +++++++++++++++++++++
 include/dt-bindings/clock/imx8qxp-clock.h          | 289 --------------------
 5 files changed, 446 insertions(+), 440 deletions(-)
 create mode 100644 include/dt-bindings/clock/imx8-clock.h
 delete mode 100644 include/dt-bindings/clock/imx8qxp-clock.h

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
