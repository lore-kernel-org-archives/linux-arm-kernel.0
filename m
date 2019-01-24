Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246E5C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:22:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E807D21855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="icSYhGqe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aSDjtYF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E807D21855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Zgw4z/lVYOcqTU4h9gag7u/EfkvqJNeLqVRj4iiSkzU=; b=icSYhGqe8yj7i6
	sqHMEXKEOePy7b+KTu6NU2n6naNIxiuclIImnLWDfvHZZwNJc3IhJbPZiEn+GS7Ho+H2Z34jwue43
	69yu7x18uCd6M8C38Eb0IPkm3lti0Y6yzTnD8wy1ubKAgdMCMPyPY2jCs4Jao5MBLbvjEV/d/GFkK
	2hlDL9EQlWxOmsd8IGyQ6WeH/T/2dz6VSO2bVLeczLW30PIHslq/I875LAhVFh+nYbegDSksWyYbb
	hEguzywkU4tqlYMcN/UvqLrF8pHloF1b9kwMwYq7+tmptq0lSVeh7CtlcDvyridRwyfoED2VR2aWj
	qP5y/OzBJWpFSwYRt8+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmexr-0004s1-3v; Thu, 24 Jan 2019 13:22:39 +0000
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmexn-0004r1-Ia
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 13:22:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkTrU/Z/IrMhEYbdefyVVws/5/Ejs4Dzo4IZMeSxb0c=;
 b=aSDjtYF8dMygxS3ANP4eNIsxWaRBMMJfX167maPyJNNiguh0Q2EKjt15qcpgdVUm9hkUHO/Ep8BaYPQbvH27oQHF9+Dj9BQgYp1oRhFtfqq3cqZaX02M/1Deraun8Gh2kJgpYTnoPDc2rDeFeXLuVblxA5yKdx8JjCTTkMZ6dps=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5443.eurprd04.prod.outlook.com (20.178.112.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Thu, 24 Jan 2019 13:22:28 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1558.016; Thu, 24 Jan 2019
 13:22:28 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH V3 0/5] dt-binding: clk: prepare for imx8qm clock support
Thread-Topic: [PATCH V3 0/5] dt-binding: clk: prepare for imx8qm clock support
Thread-Index: AQHUs+fa4FLqgxNzK0m2acNYnGEA7w==
Date: Thu, 24 Jan 2019 13:22:28 +0000
Message-ID: <1548335800-6438-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0041.apcprd03.prod.outlook.com
 (2603:1096:203:2f::29) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5443;
 6:nGaKd6xAVX9JVAMXtFqEqoq5uzHbY6w4XfXUE0zEONrcxUoE6+7tae2ftPZ60Z9lUMuyt/T0Uy3l+d+Hv4Rxp+gP3qJmLi8wx9ZZJQhuGT8HHlBKL0a1LkWWj1LGw+1oW4T7sVPJJI+0BpKoo8aFJX+GXfr/ZptCnzhL4Pa0dbaWmYYG0WU65hxLpgJ+6fuWkNKaWjKqzqXodXqR+qj9EprwukP1zRSLh1YJAz/JM+ag0Wby51mRmaUVDMBTVFVrWooCj9r6hlxYNb8Fu+FwwZqb2mdrm/4ggjcrQhs6wjIP2KSqn3Z81NSC1GXCJ3UGjtJ5BOzx2PBUdXJMv99lPxu+7LqaruNL4CiILwiPWrL0BVDSaT94pLeqzbyQExCBwwAewYBwbuIik2emHxDM2vPeeP83kjyet4J4iT9addsKKgNJkWvf3+7OBhl2q0vtdu/jSjv//+9a9xqumQFu5w==;
 5:JiPgrhjDOdy4LFFnl/tgiTZW0VZV0Ye4WpsfYgCSeUtT17TPkeeb/vaJf6sACFS90f+gqhkeWEjo0jChg7dYpUPrKa/3zvN+v44gAuAxSP1Y5ug3GSFBn8FxnPtjdlpX72IPOfp2ed/chiDPEisIq01YsuQ+6bFQ0lRoto0K+rdCZwgLq1ra2XlgQrUjJb0GkLhJhgTgTpAnUVNyb3207g==;
 7:4Lc6kr7WoQdlkUBG4aWLuQN+/tNzh90LsqIB2cXh24zxpPBhTK5U2MSt8UKfxK73vHVSXL9jjoIKK2X+jZC1B1mNnYoIFd0m2n4gI2SPjN0sWYTjqcjkVsZORtNKisY1F3QjOPeabMWjQB6XcDRUAQ==
x-ms-office365-filtering-correlation-id: 8dec270b-ee3b-4c32-4e45-08d681fefc8a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5443; 
x-ms-traffictypediagnostic: AM0PR04MB5443:
x-microsoft-antispam-prvs: <AM0PR04MB54433CC869414E3F35D3966A809A0@AM0PR04MB5443.eurprd04.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(376002)(346002)(39860400002)(136003)(396003)(199004)(189003)(50226002)(6916009)(5640700003)(6512007)(6116002)(66066001)(305945005)(7736002)(486006)(44832011)(97736004)(86362001)(99286004)(316002)(6486002)(68736007)(81156014)(106356001)(81166006)(6436002)(8676002)(8936002)(54906003)(476003)(2351001)(2616005)(71200400001)(14454004)(102836004)(2501003)(2906002)(105586002)(36756003)(71190400001)(478600001)(4326008)(186003)(52116002)(256004)(3846002)(14444005)(53936002)(26005)(25786009)(6506007)(386003)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5443;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Puw9tgypilWjMx7H5oGQljJlYEll/969ekaw5cJc24L5DBs60q0oYVNH2uQ23Hfzib08QjTzwPIOCnTu0DwuCXnMkaDt6P1XgUzvD163Y/48RjZ5m/n7mAD4d+Y6yXSNWfwvq0K7NUwW8hZmqDNsPQlmgAkQMlSuqWRot39erl+ARZJrXXrVmEkXT/v+FUu4gkG3SYLZTjp4oiIgFztds/8XdlYZbP2zHQnUfER4KYX3v8fkd/M+USmiHmKd8Sr0YCQbGmmWr/U1f3OdCNMbdcnS38iSyqsWCmw4+AMMAIe1Jh6x7j9IkFaGsvzAVFZQYuWAZXudq+F1dS4UEXhVCQcx7pFP0HS9mFrgF3dMYebWae+Uhjykd59yuDQhUDN/abstdn2rvjrMZlMQNNYzOc5avrwI8/Rf5nkgqWkWN4Y=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dec270b-ee3b-4c32-4e45-08d681fefc8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 13:22:24.3267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5443
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_052235_615459_D0B99FD7 
X-CRM114-Status: UNSURE (   8.46  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
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
  dt-bindings: clock: update CPU clock ID name
  dt-bindings: imx8-clock: add a53 and a72 clock id
  clk: imx: scu: add fallback compatible string support

 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 7 +++++--
 drivers/clk/imx/clk-imx8qxp.c                               | 1 +
 include/dt-bindings/clock/imx8-clock.h                      | 7 +++++--
 3 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
