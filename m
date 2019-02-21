Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE437C00319
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:03:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E76D2083E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P3NfRDfX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="X7K21ml+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E76D2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=blHLh//UvreN9s7gOwK8TVbZk4bUo2tv5yZhNbBIkTE=; b=P3NfRDfXj8T8jg
	v8xea/3AfUyAwUeY2XYKr50+Fp/0yc2/HstwixNHHdt0yMlcMsFQrCaKhD1h+IFvDCGASp/SSrx1c
	hns4UA3JrdiKY/YO7SL1B9i0qxL6ALAoM4UHfFoB4PNNezcEwwlZ3NLSrb3dSEax0tjv5GwVEO+ug
	xDv15PCBzRUgWzwqI2Ap0lCHRVKUKtt+uys0htAO6FpoIgksIO0Jv6D+wtEYrduowGBIsdBj369Hs
	1j6IQto4zxPVGWZdanhwdpXfE88XS2zpi+63oWz8AI5LzIIlKDnXUo9kAksN979BBOpSkEFGRuhfD
	qc0dUqIiaEjONrOMPtcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwshL-0006Nt-9w; Thu, 21 Feb 2019 18:03:51 +0000
Received: from mail-db5eur03on062e.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::62e]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwshI-0006Mm-6Y
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 18:03:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2T/GFvl4acGTeYYPDz7GFWh563lXxB8gW9gzleWxzs=;
 b=X7K21ml++Top6B9eDPKhDlUzDBl3Qh6RhEhIJh8VLm8U/upPYbJqEEAW+PFTxvQs4FdckHL9s1qfYt8rMtuxDgRtYh6XfLvKy0HlL6ncL4L8frGXxuszuTlsApxbP25YXeayBVuQL3dv+OMLz0LXjeoLCb/4QJmrvRCCOAZ4Bik=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB1663.eurprd04.prod.outlook.com (10.164.85.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Thu, 21 Feb 2019 18:03:40 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 18:03:40 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH 0/4] clk: imx: scu: add parsing clocks from device tree support
Thread-Topic: [PATCH 0/4] clk: imx: scu: add parsing clocks from device tree
 support
Thread-Index: AQHUyg/G0dfxbehLdEaU+79qEWIdDg==
Date: Thu, 21 Feb 2019 18:03:39 +0000
Message-ID: <1550771836-10014-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0044.apcprd04.prod.outlook.com
 (2603:1096:202:14::12) To VI1PR04MB4222.eurprd04.prod.outlook.com
 (2603:10a6:803:3e::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 146b7d4c-6ef6-420d-391b-08d69826e862
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB1663; 
x-ms-traffictypediagnostic: VI1PR04MB1663:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB1663;
 23:tLP27KcK8oZUVEmFG/TKaA2YJBVbd4L64VoKhaz?=
 =?iso-8859-1?Q?vPlc9G1XwG43ELNglCTWn4qdj5eRuRgEa7wAkzxtjUBUzb3tzYKIGo4vDm?=
 =?iso-8859-1?Q?lwYdQokYDPD795B78/qhI6m42eUPKFT2Z7sOXshs2mQecrbWmDOxpaAjjc?=
 =?iso-8859-1?Q?LJE0dLAmCHMhcgS6LbxoZFZug7WAJm/JL72n4TFNT41y33zmsK724zgbXr?=
 =?iso-8859-1?Q?z48xrxfDqP6/d21GU0nEggnyLmO/uxuu7bziE75e1nVMMk4CRT4yjxuoKe?=
 =?iso-8859-1?Q?Ls04cftrrbgUxWp8nwsGwrpgDETanWn+OKafNleSxhlnxrneXcg5x/OO0k?=
 =?iso-8859-1?Q?YWYhkX3maXiAHHQg1YmSPzCV5mNtuMEyuLm3va/8hKA0ewzTfDul2QDbn9?=
 =?iso-8859-1?Q?yS+6cYehiaufvTsbqwQf9zFgmohYGf3W8SAAog3HLdYv49qnz3vB7+3oLd?=
 =?iso-8859-1?Q?HmqjCOvXb2wTH0daQ9GRXAJDChAayLouNdx3kGxs66ghFHQUQZvtA9drRJ?=
 =?iso-8859-1?Q?fza98dY1GDXn59Arhjw45SQzF6gIHCZIu9E0+20ggF6TQZ2/wdR6abQIS1?=
 =?iso-8859-1?Q?U3+DO3/MkMVXLxRdsZI5eVTOppGoe0tgiunefvw3U3pYEIjSYRkUE0uzaw?=
 =?iso-8859-1?Q?BZYmCUK0EaIN/8DPXcWUEYuWkg06XyHKDw0wqjkVNOYt4jndwdVdsLtMfa?=
 =?iso-8859-1?Q?aC4PJbRjDRRLUkOJKLpR/LaZyuncTyM59ydROARUFSWUiD3w8evzLNCigr?=
 =?iso-8859-1?Q?qjfvJ5QKMl2juYc86GNWBbQLflFip0OLJ7B7zsah9Jv5FipCTKCMbzl5dp?=
 =?iso-8859-1?Q?7+CTjEPU5B3fxMuPI/4spsDhj44Jil6uQ6IFLKURBqwODbTQ4teouINllj?=
 =?iso-8859-1?Q?O9qkxHm+Tpg2vb8tGPXD4BwRqAzSk6BYNzJlgXv8rRzqMEFEVP/bP8GNsI?=
 =?iso-8859-1?Q?e2I1hwzfr/eOr9H1/buIlCm0iiLQW2qpZ+L7cykx0PnXXclB4nExLjZw68?=
 =?iso-8859-1?Q?2MthsnPpHJ1ZAcw15uz01u4jsb4mFCRCr2QJeSB5+ldOaO1qdNWdZlh9lq?=
 =?iso-8859-1?Q?3w/cTdfQ1BaLu5GHVMsq49oK6SZ0mKVAn62KTGcXWvGYzdFNV27EE+hYMa?=
 =?iso-8859-1?Q?TKruy8ELjIvqRGfAfdzVLf+bYPyE9EoorVfU8tzprGRhYJ8QveNdm3Od+s?=
 =?iso-8859-1?Q?pExQwQD+uxOywW/mB0Z2NVqXijU4+f8fCLUrG3PD3gZ1dcRBJqoqomko2l?=
 =?iso-8859-1?Q?uOf62KrYZuTo2HfE6?=
x-microsoft-antispam-prvs: <VI1PR04MB1663A6EB292DC256CED708CA807E0@VI1PR04MB1663.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(376002)(366004)(39860400002)(346002)(189003)(199004)(2906002)(8936002)(186003)(81156014)(4326008)(71200400001)(71190400001)(6506007)(97736004)(99286004)(102836004)(26005)(50226002)(2351001)(6512007)(68736007)(81166006)(386003)(3846002)(14454004)(6116002)(476003)(316002)(8676002)(5660300002)(478600001)(54906003)(2616005)(25786009)(44832011)(36756003)(305945005)(105586002)(106356001)(6486002)(486006)(7736002)(53936002)(66066001)(52116002)(256004)(2501003)(6436002)(5640700003)(6916009)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB1663;
 H:VI1PR04MB4222.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nd6H3LMaibYQ519ilXxwDKZZLJWuVVeWhjb3XUcsIlmbQ5CESZT0YZG7TYznbQ84cGauzCbBzVL3/n5G/Jlhldt/AGhVZA+iOd+KP6LK/QQ6FyOgqeQ4Pk7PguBRpQChdYyMVFqqZDvc9dB7xgJ3oKeoWWpUGAaQm266SHhY4770dofiUJXzGwY32e5nLK5TeE/MwwGj2LHQuTlGWDCuyfxorzWAHiLvN+Oe6JirXuD6HYvuNEEExWT3qE2OFiOdNcZH1YfIAu92RI15zE9Qn7hIcKLaWRtSkjSmKGJuMOl6XQ2nOoYl65BygNJyOa9Gx6B4erlO1jZd3QIlXOFMAcrMs8m8m1LOva+a660d/dC0yHh4NtJWoP6quIDKLhf7Jag9z6MuBK5/l6TVKQKQ2+CtulBFcz2VoVAMwpXmOvo=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146b7d4c-6ef6-420d-391b-08d69826e862
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 18:03:36.5814 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1663
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_100348_328801_4A424DED 
X-CRM114-Status: GOOD (  10.79  )
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

This patch series is a preparation for the MX8 Architecture improvement.
As for IMX SCU based platforms like MX8QM and MX8QXP, they are comprised
of a couple of SS(Subsystems) while most of them within the same SS
can be shared. e.g. Clocks, Devices and etc.

However, current device tree is heavily depends on Clocks IDs defined which
cause some troubles in writing the common <soc>-ss-xx.dtsi file.

This patch series adds a new binding to support parsing clocks from device tree
which can fully decouple the dependency of Clock IDs in device tree.
This can make the clock driver much easily to be maintained in the future and
avoid writing a lot of duplicated codes.

Dong Aisheng (4):
  dt-bindings: firmware: imx-scu: new binding to parse clocks from
    device tree
  dt-bindings: clock: imx-lpcg: add support to parse clocks from device
    tree
  clk: imx: imx8qxp: add parsing clocks from device tree
  clk: imx: imx8qxp-lpcg: add parsing clocks from device tree

 .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 29 +++++--
 .../devicetree/bindings/clock/imx8qxp-lpcg.txt     | 14 ++++
 drivers/clk/imx/clk-imx8qxp-lpcg.c                 | 90 ++++++++++++++++++++++
 drivers/clk/imx/clk-imx8qxp.c                      | 43 +++++++++++
 include/dt-bindings/firmware/imx/rsrc.h            | 17 ++++
 5 files changed, 185 insertions(+), 8 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
