Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3905DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:03:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 007E5217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M17fXgiS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lsj7qKqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007E5217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4noOCw3P4wUE8mxbW8yjkGCgHRJdFMC3y4gdDWXE1rs=; b=M17fXgiSgkHbDt
	LU81qPlaxlZzkmWdyGQ/Oo81IzcAm2wBzjBbB0bWODose7olMjQpAZsoLmMBMss/2hP3dem+mh+L/
	W7We74AlwS1Ff2ixDeAqqu06TQTZP8q4nFAVjaLubVeOe3TSULsx3l4R9PLD5M7nvLQnDvQlnn1J1
	9i0YqcqzlV6CByljhebJ9Z0Iu8yxXqQGrdEj39gbsDtWwYjVIolVgirkcLGm6uvxy/hpostOdR7o3
	ppbYDQOL81RlCHCBCLxO42Q9jWx6cpApx0AWHZZbJ1/3g2pmgiqfXhQsy8tbnbFU3uvbjJW9hpwCj
	TedE69AtDmw4ZAlC8vAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybSi-0006DC-G8; Tue, 26 Feb 2019 12:03:52 +0000
Received: from mail-eopbgr140074.outbound.protection.outlook.com
 ([40.107.14.74] helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybSf-0006CZ-4U
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:03:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjNJAvpY45/UF8rVbyDRsUQ30Q+c3pkeMgMVahrgWKg=;
 b=Lsj7qKqt1SJydiOjJAhGUEwV8gzITe5PdbtrjrNP5POSBIcR468kURGyVz0kK2mSVUb9tki3XQxkQP9FTgqlicw6dFyUPuNeDWITdeFMpOp3qnKmo/PL2J2DrHBvWu9LPr/XC0atcYqP3fw+gAOPGdwuXy4rxZWOXoiDNOVMB5c=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.91.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Tue, 26 Feb 2019 12:03:45 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 12:03:45 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH v2] clk: imx: Refactor entire sccg pll clk
Thread-Topic: [PATCH v2] clk: imx: Refactor entire sccg pll clk
Thread-Index: AQHUytEZ0gNCfcsGj0q44zlYEICsNKXsF2qAgAEgS4CAA5A8AIABK8BQgAACEoCAAAWUMIAABaoA
Date: Tue, 26 Feb 2019 12:03:45 +0000
Message-ID: <20190226120344.r5ymbrdfddaoslbn@fsr-ub1664-175>
References: <1550855235-31528-1-git-send-email-abel.vesa@nxp.com>
 <155085758346.77512.1117855723990616329@swboyd.mtv.corp.google.com>
 <20190223105813.aepvfxzbjcdjvkzy@fsr-ub1664-175>
 <155111539427.77512.17052467596124902632@swboyd.mtv.corp.google.com>
 <VI1PR04MB42229D26B9713EA6DFC484D2807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <20190226112329.slvskbyokeqe7vik@fsr-ub1664-175>
 <VI1PR04MB4222FB04467A3FF699FF43D8807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB4222FB04467A3FF699FF43D8807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 708b819f-97fa-49de-115d-08d69be275a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4290; 
x-ms-traffictypediagnostic: AM0PR04MB4290:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1; AM0PR04MB4290;
 23:ZU/Sk7JpFbv6acEoMlzhxITzz5KcQKxr6TBXMxCdh?=
 =?us-ascii?Q?4VntaZGk4vx10SKqfkSBqpyCdAqWwGCBySBFD9wxNqyH1Li0/NB5AsGDj5eD?=
 =?us-ascii?Q?SjMd0HosVMv0l2jAmXtB1u2Goi4hH3IpwGl8aFpafBzAAy74OWZVtfklDJ/h?=
 =?us-ascii?Q?bB/c9l1Fxymt+0svtE2y2mrwLK/6fVpCzMUeZt4c7Y5dSabnE1ZyeGDv2SHT?=
 =?us-ascii?Q?8oKvLP1olYcvYyFOWy2Cj670D9qJfuWm0j4QPEJ0iUZ9KeBojwOh5QSZ3ThA?=
 =?us-ascii?Q?wOAPQcM1+zvYd9wF9ATsN+CEjq9tVuj1jc4qlrO9eB/QEqmMJCMT1mUvHC5a?=
 =?us-ascii?Q?crey3c0s1u0EEy0pa/PTr6TE8HXInfdFGIk+4nYy+OhispJhSLztz79C+5qt?=
 =?us-ascii?Q?vtwbWrkNpHEzrfCvq/1NbfQwpx3mxvAQpI95VrTi0k/13l/3MhxO8Fde3vqu?=
 =?us-ascii?Q?7Wd2r7R1AhCL9WvLYIqR3TCK8dl34TzuH5PUpDAGtfjMI435+3hUGNTLZT5X?=
 =?us-ascii?Q?ys6piA5+ytPTz42DyW9FhIqBooDOcO5KuE1zdJmi9pxnvW3VrN+n+Epitox2?=
 =?us-ascii?Q?nR0fOWsnMx3loPz0WXHW9+i7A0vgUwnhDGPC5VTxOjjRT+rVj1LhHAoP3Acd?=
 =?us-ascii?Q?Br8jJQrguC60/UiG4rRemzQ/0fIfeqgFk7XecQXdO53Ob+G0Uw/X48MUS0LC?=
 =?us-ascii?Q?bwCC4s76kMtryFXyNcLpM654LQKZcU5C0KzOqAWvI0w+lysyLgeKd2bxnpLa?=
 =?us-ascii?Q?juS9RubgwT9ggr74TgEiVISzbK2lN+CB//Fpbinwek99nVES3ZXNytptbsZC?=
 =?us-ascii?Q?08pPPWzFxmarwJb0efYc7rauq2+MdkCXIn8WAP5l+kb8/86kOmSWxOp/Nhof?=
 =?us-ascii?Q?WujjlrAy3PVdlGioasJAnkFdX7lQpayox7x7g/oLAbtwlXTa0+PUXU6CvqEx?=
 =?us-ascii?Q?2AgKLvBdwyf8ewi23TefI35PZrVQqy2PZiEL3u078r3VyGwjVYg9FyoKyTOW?=
 =?us-ascii?Q?Q64l+sPnthO28wEIFomlNPRNhCb/OMJ44JSz13k4H51PIzs2rDgydJotnBDl?=
 =?us-ascii?Q?Ik5NKys61XS3OA/R6Oc7yvJux4gW4CXsA/LqfCuT+Q4kuMUC091SKwF593yp?=
 =?us-ascii?Q?+JCOiyY+fS5AyNjIBWQxUEE52xWvuZRSaQfF5Cy7oJcW+GE4tM/oGKE5oIv5?=
 =?us-ascii?Q?iJmUhmlnwRrwT7wiXT4vG+rd5Gp5gkcE73/yIXJxSthfaNnO6sDBYYVUKBED?=
 =?us-ascii?Q?VHAUTgWZcNdMg9T5DvurQDzvHhLJ4m+9nhAdjO846r08jANo/YtDpaz0RXJv?=
 =?us-ascii?B?UT09?=
x-microsoft-antispam-prvs: <AM0PR04MB4290B58AD2A465F7CFE12990F67B0@AM0PR04MB4290.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(7916004)(396003)(39860400002)(136003)(366004)(346002)(376002)(189003)(199004)(4326008)(229853002)(3846002)(14454004)(6246003)(6116002)(186003)(106356001)(26005)(6862004)(478600001)(6506007)(99286004)(1076003)(105586002)(102836004)(76176011)(25786009)(53546011)(66066001)(9686003)(5660300002)(316002)(44832011)(486006)(54906003)(476003)(6512007)(305945005)(7736002)(11346002)(446003)(2906002)(93886005)(81156014)(53936002)(8936002)(256004)(86362001)(6636002)(71190400001)(6486002)(97736004)(71200400001)(8676002)(81166006)(68736007)(6436002)(33716001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4290;
 H:AM0PR04MB5779.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: v8dQGVfNwkbPNqBfyQj9RWPUie/j1xl1wcD2bWiPqPAefg/MBpi5El7pVLn7HsoUcEH+eQSth52o7kYD+uUyIs+JVsMJBQUacusCb6rqD0sql3EZbF00+SWjS7wm3WQz75ZA+OV9zLA3M3k7eGRzKVsKCLQxigMQ0zNE5q/C5YNvaSLxSKT8HR/U0QNrd1kA0EcO2ect/wZzsyqwpn/U1Gkx5ITCKo9Y1ap8r4WgElASXCEzGqiCw/TQR/w4eoW1hRLHIiMKpuXdBzOivp76NQLRvUjZOm0Pyr1n56zUE4HBSlzA+wh+R1Zl603aoXsalOpOaEFQxmk9ScOTONmMFdX2uL4tr9kiL7Janb6QxaBIXsQSbWzw3To7pN5/qJAojG9BGniatNutb8VkGq6o5zDJOvYv0PzgEsYuamzJf3A=
Content-ID: <1361B4BE64762642BA864C327BB269F2@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708b819f-97fa-49de-115d-08d69be275a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 12:03:45.6152 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_040349_173946_51269F50 
X-CRM114-Status: GOOD (  15.64  )
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
Cc: Jacky Bai <ping.bai@nxp.com>, Anson Huang <anson.huang@nxp.com>,
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 19-02-26 11:45:17, Aisheng Dong wrote:
> [...]
> 
> > > > > > > Tested-by: Lucas Stach <l.stach@pengutronix.de>
> > > > > > > Acked-by: Lucas Stach <l.stach@pengutronix.de>
> > > > > >
> > > > > > I suspect these tested by and acked tags should have been
> > > > > > dropped, unless you discussed and tested off-list?
> > > > > >
> > > > >
> > > > > Oups, I forgot to drop them.
> > > >
> > > > Ok. Can Lucas re-test?
> > >
> > > Tested on clk-next by cherry-pick a few defconfig patches from imx tree.
> > > So:
> > > Tested-by: Dong Aisheng <aisheng.dong@nxp.com>
> > >
> > 
> > Thanks for helping with the testing.
> > 
> > I don't think there should be any defconfig changes required by this patch.
> > 
> > Can you please list here the CONFIGs added?
> > 
> > Just wanna make sure I'm not missing anything.
> > 
> 
> Clk-next does not have MX8 defconfig patches.
> So I manually cherry-picked them from imx-next.
> Below two needed:
> dee305e arm64: defconfig: Add i.MX8MQ boot necessary configs
> a1624ef arm64: defconfig: add imx8qxp support
> 

Ah, makes sense.

Thanks.

> Regards
> Dong Aisheng
> 
> > > Regards
> > > Dong Aisheng
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
