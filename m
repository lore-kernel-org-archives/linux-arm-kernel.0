Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C31C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:05:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A15222D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C3hxKIvf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FI194rcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A15222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=AHF1GD5y8H6m7oed0fuVymGwiWkXqhtwxnqSkg9SR9M=; b=C3hxKIvfybG5z1
	AGCzNbmKB7xfejBEbIQnVXhHx1aZVTjGspPr88bCzjXEXhSstS8wwoOC2Ffiv06IbXJYWoibyWfp+
	0PfrCnBqodspJ5OffrtZ8v4JQ6eo04IkeUqwfPluM1L5lzgV1VryiahOnz7MPbBErznxHxwJKviEp
	rZZeqssi74NwJwBIbCaD65tGffSuzNRnPlou1/z0EEexE/ftO6escf5oe3wrgLq9k250vKbfPxX28
	lecXOE2MPVy5yuxHoV3fizfuEXqI+CCnAsZlaWcFjI3hPA3v3pWFip/P4t2RcF+xTfoc6H6GPCPQM
	Ima2BKJJl43fKQYDm0kg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtzqS-0005Q4-Hq; Wed, 13 Feb 2019 19:05:20 +0000
Received: from mail-eopbgr70040.outbound.protection.outlook.com ([40.107.7.40]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtzqP-0005P8-0M
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 19:05:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsSTv2/G99JpPDvMmznDyNQ8rRkMBCqqXMbJUHn6gkc=;
 b=FI194rcTFywa2/ajyElOtyKV3ivmDt/tZ8dN0CJv0cpakT2hiqLAgi5TdqIO//hMLF0hxuXgscZHExa7HoNABiQyitExbhVpTP3M+xamXO4DiweSVGjPIFmomgFv4TYCZwpunLBMjgkXJ0EYRJVxpLpRYak9iA1mm64ubqGv8g8=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4515.eurprd04.prod.outlook.com (52.135.148.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 19:05:11 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 19:05:11 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Mike Turquette <mturquette@baylibre.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Lucas
 Stach <l.stach@pengutronix.de>, Angus Ainslie <angus.ainslie@puri.sm>, Anson
 Huang <anson.huang@nxp.com>
Subject: [RFC 0/5] Add cpufreq-dt support i.MX8MQ
Thread-Topic: [RFC 0/5] Add cpufreq-dt support i.MX8MQ
Thread-Index: AQHUw88LTkjKdriTxE6guK0OS+WFfQ==
Date: Wed, 13 Feb 2019 19:05:11 +0000
Message-ID: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0058.eurprd07.prod.outlook.com
 (2603:10a6:203:2::20) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 542ed91e-8eba-4b85-cd32-08d691e62d54
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4515; 
x-ms-traffictypediagnostic: AM0PR04MB4515:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; AM0PR04MB4515;
 23:vczA4NvZ9nvPtXLKcj1pHS49d8V8l2Cb+LmTl/6?=
 =?iso-8859-1?Q?SjCYGAKAIzpr9TlXEEVR+M7ohqRM8u7BI0yDG03o3cwObMQ4IDgo6HWiXP?=
 =?iso-8859-1?Q?COyMF+kW8+cjl6cYRVerYFdMT5GrY5OtMUHEIaA1RUp9Fd9fIgc5NqmgNF?=
 =?iso-8859-1?Q?V989tCRVibG1fM0tXPvIQGkUWeW9eTzBhtm5N5pxyUIWcSmNCL9K8lBFGF?=
 =?iso-8859-1?Q?2f2LsV983GiB8FJNc4bS/hFzzVRz9YzC3gbAluchyU6SD/KY+iroK57oSP?=
 =?iso-8859-1?Q?yHgDmo84ZaMTI0euairhmSzRuHMNQliuG6f5PoDgdqkLqJlUUkYCMzpijl?=
 =?iso-8859-1?Q?SldyXorRYDxDQcbQOWFWGB2eDC4lQ9XO4cgb5n8rzc4ykWzdtE+bbn35gT?=
 =?iso-8859-1?Q?TL2l4SI++pW+XucsfscGKxXmjXuZBbecxD1nJSTACWed/H3NFPhy3EfaGi?=
 =?iso-8859-1?Q?EwS0ZKYh6jgn7q/QDazFlBaw+M6VUzGtiThI3BXu4oOrM0lt/97n/5UHdK?=
 =?iso-8859-1?Q?Ow3P/LmJgSIi4B1J4sIr86DA69CzwUq1sPffSbF3sxfMvew1cF4BewfwHL?=
 =?iso-8859-1?Q?Uq/590bC/dJ+9RmQbt8oqSrXhEco+x2QP1Zy1XSTdgq62v3okTHMAa+Iqy?=
 =?iso-8859-1?Q?334wyAvcs1AczzUsB9jSkrKQAwo7NKOyvyzKejBgBeSGqoJQxNAb434ehb?=
 =?iso-8859-1?Q?fz3He/QRh1OMYUCxWMZ5ByQmS8wMeCo35NvFsDXpdl9ZbqlhA30h13JEkv?=
 =?iso-8859-1?Q?2uyVQ7BnfNUg8qxkeREGmOgiVkdEiFcQmpEMehKyVteoaWmrf0c4o0bqjY?=
 =?iso-8859-1?Q?dQzzZWb6lNDueiO2tnpPZyPFePFqNI0P0YAeESDRI232r0znEOc14wA8Cu?=
 =?iso-8859-1?Q?9N8xlIhDfLtRUwzQUqp5feBGJLrUkzMEwXw+vmhKakkNGbri8H6IKMga3n?=
 =?iso-8859-1?Q?B//wGf8N2CkkkHlfCeOg0kF1WSYXd5ot2170dEReyn2fTvytjnTPnd43iP?=
 =?iso-8859-1?Q?tHVVzj5wqgY40cadWsUniUDinf3+pXnl1rw0cB6SliLO6qD1/1raPZEKll?=
 =?iso-8859-1?Q?h5BSAR8502jN4DXhwnIZ7yAj1315R7xQ0UHdtCIvAboEFJw62m3HrwrlRO?=
 =?iso-8859-1?Q?78u6hWqv4QwSM98Ddv+g8MtOvEwFGEZU89xtH46ZsBA//36Xx5z0F/4Lyu?=
 =?iso-8859-1?Q?eds+gnJaQSrVoUwYPAFeZCJ90q3Mf3jWaIi8IyVcyIfY5+dtaRhO+Da7ZP?=
 =?iso-8859-1?Q?v/7OtP8q8paDkiX0ei1tHD6UFLID8IqImcSpomw=3D=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB45158AFF3A4CFC74E9A4C01BF6660@AM0PR04MB4515.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(4326008)(52116002)(2906002)(6636002)(3846002)(6116002)(99286004)(106356001)(105586002)(7736002)(305945005)(25786009)(97736004)(14454004)(66066001)(966005)(53936002)(8676002)(81156014)(81166006)(68736007)(36756003)(8936002)(478600001)(6486002)(6436002)(6306002)(6512007)(50226002)(110136005)(54906003)(316002)(486006)(186003)(2616005)(476003)(14444005)(256004)(26005)(102836004)(71200400001)(71190400001)(7416002)(6506007)(86362001)(386003)(44832011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4515;
 H:AM0PR04MB5779.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EXooFvcXkI9/VjzauF4b9mPoZNypyq+MI90ek7mi1dfgka7hwd5PNFPy7Rx0ZlbZWZGIsCef5CuHHOXYReg9ypCVYpn9HmZ5IX66N/7VkR5/UVhV1umJkzlv2fmNOc/IzFdJaY2uUpPGMqSVvDsM/GFHsNGspaDM9O+MZuXKmSAqKMLDbrCuHbut5zCEL/PtGeBiBwSeUwim+VQxyKRKUJrncQOzqoX+N0VpNMteQ2lANHIYXNOQ2TxbD9YVAJb+M3wgKGhauESPBg+4JWar+6dG4zP9FsVSzdBZYkQ025jTBAdwXp9zpIOfn+DI3WENTYWQ+kDq4P6skG8S4ZgeQMqm7QKq8qcikRCGSqF4H55qml9FqIAD4csq3bsORsvoIKWB92R+vp3FpD1MUGaQYiF60vnzWEolQQY1mmBJqMA=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 542ed91e-8eba-4b85-cd32-08d691e62d54
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 19:05:10.1606 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4515
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_110517_052872_73226ED4 
X-CRM114-Status: GOOD (  12.74  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Abel Vesa <abel.vesa@nxp.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

I'm sending this as a patchseries (RFC) just to show all the changes
needed for this to work. I'll resend separately once I get some feedback
on the entire thing.

One thing that is missing compared to the earlier work
(here: https://patchwork.kernel.org/patch/10807821/ )
is the speed grading. That can be done as a separate change 
once I figure out how to do it with cpufreq-dt.

Unfortumately, there is a need to update the dt-bindings
once again in order to add missing ARM clock from patches 1 and 2.

Abel Vesa (5):
  clk: imx: imx8mq: Fix the rate propagation for arm pll
  dt-bindings: imx8mq-clock: Add the missing ARM clock
  clk: imx8mq: Add the missing ARM clock
  arm64: dts: imx8mq: Add the clocks and the latencies for the A53 cores
  arm64: dts: imx8mq: Add the opp table and the cpu-supply nodes

 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 17 +++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 31 ++++++++++++++++++++++++++++
 drivers/clk/imx/clk-imx8mq.c                 |  8 ++++++-
 include/dt-bindings/clock/imx8mq-clock.h     |  4 +++-
 4 files changed, 58 insertions(+), 2 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
