Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E36C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:16:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DCBA21726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kmlxQn9+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PgfCwwrb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DCBA21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=0gQTR1zpZHIaC4SrZ01hh5tr1G5ivPlwgYkNHYy/8KI=; b=kmlxQn9+dWb+wG
	Zgx71VN3a/uJGkGEmM8PqEwWzipEKsaobVz7tjjQberf20NIx6KB4/Edl2KO1Wsaqy4PbrXQ53Rlf
	nS3kuVmP15cpU56F2XcwT1d3nfjFv6v0JwKRJDmFPwCwW56nfizrpXmuH3zFOuP6C1PLw8BpiJszh
	S9S3KjRTvA4b2IcGhdw+pjVJQVWJQMXuFUMa8x4GYrZZd8bcC/ac4dLAOZ4KvZzv7S0Ciy8Qm/xAc
	akmdyGodU5yBoO5n0eHqvgv+VbPVsFC1ocEqX+WsvV9YyBUWmRRaoJ4SzGj/efuXVcwM8tMg5vtHB
	DubLc2PMqw1WCDD0GRfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmDiI-0004V4-Us; Wed, 23 Jan 2019 08:16:46 +0000
Received: from mail-ve1eur01on0606.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::606]
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmDiF-0004LZ-N0
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 08:16:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oImIePRYA+OVzVtwYy8bO3Snq+gX6RjYMqTU9JxMgMw=;
 b=PgfCwwrbWI52UbOAjgf5F6mDi13Vu9jM846b9pZHJR3WLbGjKUaK+1GbrbKu/12suXWtzXdgwo6oDqoxS4CkElyEz4dlmwFpr17Y3S3nG5BP1tB6Y302AuIa2S2eb3IqCwnstwNZbknC/DViVYzzR/BmKb5rBjfg2vI2vaDXS38=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4482.eurprd04.prod.outlook.com (52.135.148.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.30; Wed, 23 Jan 2019 08:16:39 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1558.016; Wed, 23 Jan 2019
 08:16:39 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH V2 0/5] dt-binding: clk: prepare for imx8qm clock support
Thread-Topic: [PATCH V2 0/5] dt-binding: clk: prepare for imx8qm clock support
Thread-Index: AQHUsvP3nb0OibsUXkSix73UA+4SKg==
Date: Wed, 23 Jan 2019 08:16:39 +0000
Message-ID: <1548231044-4344-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0020.apcprd03.prod.outlook.com
 (2603:1096:202::30) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4482;
 6:mca6OOdItVP3UD1MbQqWXGp3/CQ29qTKFCNAzHNV41CJ+BMhsGnlLA3c7JF5JuuzwZNdfyDQz+Qm3AqMLrCiRV0XCSgTf2GQAJ9qg7Gzb+nyzdV8RqnPirnHUobiUePRFmlkGtyNJIHEOcx+JXpMwDXbz2KNVyHYpjKJIdwidMj3ZSKmEymmKM48RSLOFZANT/L09DYRqoJzRNmEX/donTPoDMLZd8TzjiwjWqkDGC0Y1QeAVsRHSs+E3GI4YInRbXgvl0ghKqsp8M7Bvax8iUNEdks/d5g2hS49A6WDtehw8Hb5TigHJVydUSPu6QOZTq5nhe5szU8mn0hAWz1Ouv/WZ8peGZo2UbQhwa4N3N1rFDf/iNUv6usCUNT1Z83lXRBvCyWqNZzSwBfNqlO0OCO5NL2QIBOrtQObLDbOpZFI7/ZilNvQsohKgj39zaecpHhEqnE9VmOx+HlrLu19Ag==;
 5:m1XmnNLvWXldFVzYBR/VNrcdAt2jFinFKnGFOMRn08F4tWmF3sJ4vMFzTFSErW9Arx0QKXkm50CPEwZzHeDaD/jTXPPWjEQW+ZGDIGmHcN5/h8RMDPM5AtnIHruMJACRZWPWIEhSoUHbsGgjK9lKRA7R8HmEXFM/EHrWuq5r3iNh1WcqVUQqqmFu5h1LieiNaOrBQ+TOJCdW+/9NkRigHg==;
 7:Lq1Bs6z1I+1fckIHYP54X7MH/RXmhy6mpsaP7fyR1zz6Re0UbqPhF1zcEvcMo5Q8ByvaYMHOTUSRHbGpnbN9oCJrxvJdGNc706AWJOOVFKBzxRl92k487JFEfUzsTf4ck2smhajT3wHRVIrbJV40zQ==
x-ms-office365-filtering-correlation-id: aba6a3fc-4693-457c-bf12-08d6810b196a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4482; 
x-ms-traffictypediagnostic: AM0PR04MB4482:
x-microsoft-antispam-prvs: <AM0PR04MB44827CF7A9D769AD66B007AF80990@AM0PR04MB4482.eurprd04.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(39860400002)(346002)(376002)(396003)(366004)(189003)(199004)(8936002)(2501003)(50226002)(86362001)(81166006)(81156014)(8676002)(305945005)(7736002)(478600001)(14454004)(66066001)(25786009)(4326008)(97736004)(6916009)(6512007)(53936002)(106356001)(6116002)(3846002)(386003)(6506007)(105586002)(2351001)(26005)(102836004)(54906003)(68736007)(256004)(99286004)(14444005)(2616005)(6346003)(71200400001)(71190400001)(52116002)(6436002)(476003)(6486002)(316002)(4744005)(44832011)(2906002)(486006)(36756003)(5640700003)(186003)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4482;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k+jYEkX25ct37ErQlpMaevwOGLo/S0Y4AyBHm6h70iUmxPzIavFDjyd+KgZDlhwvF25zm9bqWOsp0SKucvTvWQEpFnLhzuromq+lysLgTiwqTV0q5oKI5UHymcNbDSCvtAufDBAEBbElVRYa0iZbWtYK8ES0x0eJFU1/Jgw2dO2sTHq4Kwgz7MTNfYvI6PSJKpkVHwNBj9GhqyxyTg+0HE4fFO/0TVW7vtppHIBg6iLOHAYyCk5msG22ScMhRxqQAxFpK9Pg+ecF/pIc3RhCch6CgIfZzAoxjxldR54bdK7ZqdghY7xCMavVsLokTBsmX2KxOSZQHeb/0hG8lA3h4aAv0anKKGmyPsgusQ5pGoXWxpctmrPf0Pq3yDUlLQFQoxgcihHPEe8zxmWTbqvakAc9cBxt39ruIQlYqjiHO78=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba6a3fc-4693-457c-bf12-08d6810b196a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 08:16:35.4878 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4482
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_001643_816174_71A8A564 
X-CRM114-Status: UNSURE (   8.90  )
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
 include/dt-bindings/clock/imx8-clock.h                      | 8 +++++---
 3 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
