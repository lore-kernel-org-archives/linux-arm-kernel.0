Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBC9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:56:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D2642146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pENAfZ9Q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gbCpXFnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2642146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=P8FfjHB3tjPljgVteVJERdMNzkzz9Gr7wi0OXNI5hyI=; b=pENAfZ9QNqZmCC
	NsCz+9OklYz0HqvNgWxuTZyg6pa5dopvY/NwS5C8HOT+Az9UXYvrStn29upRX7Cu8aC6Y7LNvjTWX
	UdtzOzFV4C8dJw9Cs8kBiNZgF8IS9V2EVHZam968wBXbsh2pzNuFjd+koQJyaA4DSfuY+RMQQnMX0
	gtgWNX2uDDVKh/+kfMzLOhq/PDYUwLT2HPh9hwjbZrtoEzqskbCeheSCpuwJE1HQfRQhbDs33SykP
	RQBpS18Dum7C4X722md2TFQJgCO9kt5W75N0NC4Qc0xRQ5ssCKEL2wAcw8UxvaUwdioU/ecFnndzF
	mLcBwMKtozRUHZSVpW6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghvPs-00054L-13; Fri, 11 Jan 2019 11:56:00 +0000
Received: from mail-eopbgr20074.outbound.protection.outlook.com ([40.107.2.74]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghvPn-00053i-Oz
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 11:55:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/abhdxDsoRDZzzYz5/fS94OHFE3/omLYdPTeSc0zfo=;
 b=gbCpXFnkgfBISFOQszSjQegGU0TnFrHhL6FnAddcXS84++6ltobXP5GJpZvwl4lAmrBVLP3v/4b0zOwkKnY5JICwLFsVyydytlIQET6CIB5gKfB40KfsWxvMTiT5rNz95iYusoy5vwSoRa1FyZemp5KTI1CGxuzW4UVkDmmidG0=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4659.eurprd04.prod.outlook.com (52.135.149.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Fri, 11 Jan 2019 11:55:52 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 11:55:52 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH RESEND v1 0/4] dt-binding: clk: prepare for imx8qm clock
 support
Thread-Topic: [PATCH RESEND v1 0/4] dt-binding: clk: prepare for imx8qm clock
 support
Thread-Index: AQHUqaSa8HQ124jcu0KqZJxAJsOAcg==
Date: Fri, 11 Jan 2019 11:55:52 +0000
Message-ID: <1547207400-28307-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0063.apcprd03.prod.outlook.com
 (2603:1096:203:52::27) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4659;
 6:sXYNBVakw1oa3KAzN3S01Hnmml2Nf9F/uhjxfmYKAhqi0R4OObLoQGxOclcMBviz4i7eqjtv4qfDj5KdF4iCi5Z0n8fRi9eaj3S17NzG/Y3uALmjEhncwHmPhzjtVMFdyxpjUy5IX+JTYJpae665YG+Y9ChEFYHcYp28g/ML4Se7i55kM1ZMHMvAv84erwcARxF+Q9Z5f3gf5AH/zOFYrMELrxrK4+cBP/pmndHHQh9hwSZhZNXnQdhLiuQhcKz5MHG9+NxtTeX3y8GDPXup2Vobxfv2JVT0FefUf+ODc3F63GJheoYzJ1VGtVnouDZmbyHcE2qXGuSp60BWxFCDMCHxGRuFFfa0DhXwbgIo9Odm0ItHtGn1OOrqNZJESH79pBCcB3QzX38UIUR9v5jCUDW1HhXtMIbx/CazoP+ZahWzd+6KbjPWsAQnrhrjtru/7gyf1BeAPhcrkkcx+m1v2Q==;
 5:fs84m0oK+BuoWM67HNog4XFUdC0nQbd132Xx8NqawF/UDGv5WHBbw/i0xXyDvxs5GA2+CBwJX2vIP4zxLeNUNgrT26wRQ8FsHweKxu6Bnq5LLvmO+56bnbYgw8VdgPB5RfJ5cfmFnGJGTmRCOLUBrW9bxnkUfP3qJI6wee4z7jpprkHI88Cp3Lxm8h02FwGCDQ3NcH3dMSqEEVOdbpbJ9A==;
 7:SfFXiSsPlVwvAQwoASa+AQ0k23rr09KMy0ZQJgknSo0tM/zNkkRE4baQJthYlzOdps7sfhy9hCY00EJns/H7TgTpeJVMoN21rQIq7JHFK+T0/I4QwqR8oWU7xmj0LN7ZMqbDmrS365SJtAFOFDUOXg==
x-ms-office365-filtering-correlation-id: f01bd4c9-c8b4-4d0f-8d72-08d677bbbc48
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4659; 
x-ms-traffictypediagnostic: AM0PR04MB4659:
x-microsoft-antispam-prvs: <AM0PR04MB465972F5021DEF2E29C8CEA080850@AM0PR04MB4659.eurprd04.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(376002)(39860400002)(346002)(366004)(199004)(189003)(478600001)(316002)(2351001)(54906003)(14454004)(68736007)(186003)(105586002)(106356001)(86362001)(4326008)(71190400001)(71200400001)(6486002)(52116002)(53936002)(5640700003)(25786009)(6436002)(2501003)(6512007)(5660300001)(97736004)(44832011)(256004)(99286004)(14444005)(102836004)(6916009)(217873002)(26005)(6506007)(6346003)(386003)(305945005)(7736002)(36756003)(50226002)(2616005)(486006)(66066001)(2906002)(476003)(6116002)(3846002)(81166006)(81156014)(8676002)(8936002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4659;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bHTddeNVY+wiGY1MofvKWMXTN7G/qyVaeVYiaFHqHRkDj4UCYr83oS5da8RyYqZ4KdRvgtTHvXn/H5i1L/q+wuVs0yoCxEMDoWWVtKdkY0U1XjdLSvDZgZ8gkTMGabFKwlvHPHbOp5xxyBY6zOmMnn/aXn6bT9M3QWftCOX4UBKO+EeV/ShH9ULzHUutInR3PBi/nEdwQbHuw5hDPRRsZ7U7q/vP//FjkDSahxRNSRczQUlGbn9JSiGOI7Ewi4khQYtXQH59kY8Wt29wGeTP9QxXOAn+mNtXZmqH26wDbMxh0U411+bSqvXoR/FcSp/UO8gc0r4mknerf6+eWvEBTzFVX3LdZbZ1SKLfoqm+AOEDrKgtD/PEGcSG6PyucI64ehlhbMU+Crq9edAh9GpFMY8Z/z6TLN/OE/VPia0rjO4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f01bd4c9-c8b4-4d0f-8d72-08d677bbbc48
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 11:55:48.5679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4659
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_035555_812254_5E4F5A24 
X-CRM114-Status: GOOD (  10.38  )
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

Dong Aisheng (4):
  dt-bindings: fsl: scu: add fallback compatible string for clock
  dt-bindings: fsl: scu: add imx8qm scu clock support
  clk: imx: scu: add fallback compatible string support
  dt-bindings: imx8-clock: add a53 and a72 clock id

 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 7 +++++--
 drivers/clk/imx/clk-imx8qxp.c                               | 1 +
 include/dt-bindings/clock/imx8-clock.h                      | 6 ++++--
 3 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
