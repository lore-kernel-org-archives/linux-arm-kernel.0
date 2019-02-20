Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B593C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:09:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DA852146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aZCvS5E+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="in+sGAOi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA852146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VXmthXg1cBaYHzQQDmphWdP1ck994rH15CWimTxKC+0=; b=aZCvS5E+Sj02JH
	aHmAhO3ysR3JPPcKUHuHvJuJlzJqsCmrTl+tV+AvRSVVRvrAGYIMFFJgXZqc6Y1UeXRdfM7qNd30I
	fS0OciCBo4O0/Wj9UteOOXCU0mwTebt6KVTVarawrHrHyw31K1ba0yGihBaPRozdVtTRT//Gi1Z1C
	Z2Lc0EUAANN3epgAIM2hQx3u9siWPOpot3N+vq2mNyt/cApTz+f749UaouVzOFoVpZLG8owPg4t9R
	wKHu94+kgm5eA4MtpEC3NDbu+aPYQEpCTo65l2cNeNhrrMjhCI0WqbL2fkPUkMeHBHsRoazN44MeW
	BrBHyQENIeyuIvw4/sIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwSYh-0004xK-Ua; Wed, 20 Feb 2019 14:09:11 +0000
Received: from mail-eopbgr00069.outbound.protection.outlook.com ([40.107.0.69]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwSYe-0004wt-3n
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 14:09:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vQKIqhuIUrXfLKd2ylcOeuBp8j5l7I7Kn0UVZfXzq0=;
 b=in+sGAOi/3pRDgTogs2cLfruxx7f3ykr/5bKpNV4ikiVnlwaua3i4Grk4zwfRpEXdw02hLhLCsjk9JKhtPLhMPnhqFTZ/NBUl7CLmArazTe2/Vhye22adjqMrLrqPsR7PUBS4mdd0OsA8cQS8wVdZkAH1p7zMR++W41tC2Om41w=
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com (52.135.168.141) by
 AM6PR04MB5238.eurprd04.prod.outlook.com (20.177.35.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 14:09:03 +0000
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08]) by AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08%5]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 14:09:03 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>, Lucas Stach
 <l.stach@pengutronix.de>
Subject: RE: [PATCH] dt-bindings: imx: update scu resource id headfile
Thread-Topic: [PATCH] dt-bindings: imx: update scu resource id headfile
Thread-Index: AQHUyDGr6JcuNwk39kK74/kE/Vm176XnE3iAgAAGyxCAABmaAIAABhpAgADPbuCAAE95AIAAFTeQgAAWXoCAAAIvkIAAE7mAgAAcTgCAAADCIA==
Date: Wed, 20 Feb 2019 14:09:03 +0000
Message-ID: <AM6PR04MB4215AFEA3F139B48D7FE4E9D807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
References: <20190219125211.2pg2bqxner4klcb5@pengutronix.de>
 <DB3PR0402MB3916AF3AA0283DB22DF61E2FF57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190219144808.qqpaubjcsb4huoml@pengutronix.de>
 <DB3PR0402MB39160A56E168ED20410674D7F57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM6PR04MB42152D05E62753E760741160807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
 <20190220081650.cu3yzausx55jefb6@pengutronix.de>
 <AM6PR04MB4215014B734F71D409D617A5807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
 <20190220105249.u2hcvk6ut3cycvqs@pengutronix.de>
 <AM6PR04MB4215D9FE015E9251425B0FFC807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
 <a55e0643bb2acd522145c74ec0e8b74a16b718f8.camel@pengutronix.de>
 <20190220135232.4drv77tbkfwjeapl@pengutronix.de>
In-Reply-To: <20190220135232.4drv77tbkfwjeapl@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31014456-a93d-47c7-ab4a-08d6973cf850
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB5238; 
x-ms-traffictypediagnostic: AM6PR04MB5238:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1; AM6PR04MB5238;
 23:duO7BWS0ak1z2xwMCTcMhLx6GS684q9Jo6FuQI9hS?=
 =?us-ascii?Q?fewJli5yB26lb4lSOVHC+ymKaR2P6pumuqKXa8dlf6oSQybNFCFS1AoVa8r6?=
 =?us-ascii?Q?fizgFQTKzCn6sP+qu+VJEW3ebpsBcv42rFrGor1/gSyyT9ym50CRWAvQtTHo?=
 =?us-ascii?Q?zdHm6GwLJI3n3r2weNeqa4BdvaXjukiSox3iIpcfdNCpBFRWlbI/yUzjteMV?=
 =?us-ascii?Q?2bJrOanggGFZLtyTdSUXfRZPqiTOUMMIU8D6utPmu1D5/3w3sgr2GpKf9LZL?=
 =?us-ascii?Q?MTD8n6ZhZFsTEeBQiRwRnyd0JDRJsbv2h0Ip9T+QPghS2h3hxljuWk2AkuH6?=
 =?us-ascii?Q?fiZrE1Y6s2V3BM+3OUppoYxkadEwZvOl7NJf9sVOXWYnooewgvvsCZxiQ33r?=
 =?us-ascii?Q?k4LFBddlj/xIg3kHGkKITggOmPd72mthMWNpWUZptbVfqYo15jVCYCXtw1tG?=
 =?us-ascii?Q?fqCRSYwfZBqlr5ZeYBXSm4OvX0cTkbNn3d8m9M1NWzde75mq0PlbHu+NgUzx?=
 =?us-ascii?Q?zAoAvrkePPbxm0ONmvx3GwqOXwl1l4/t3QuvtpTnXD9V6WP87mMeEHC1lPxM?=
 =?us-ascii?Q?xkoz5O8ze8wFNYpqBnZAbnR1k/hGx0K4FVJAKggJ1EGxYuwR2xqu+nfNOqTz?=
 =?us-ascii?Q?4T+ADcByXPozOZ+kEgSpau2xu73JmCr+UqsKYwEDHIu+ZROk2ewAX8TGDuJM?=
 =?us-ascii?Q?wyxNOC966ek+QX00A53z1P7YPEFLeFBpKGrTZxnuJ1IzvJbZJQopslebywd4?=
 =?us-ascii?Q?E05sGICIxReBWra+ZizFpX7ecUJmbBypdxzLLohP/+dQriPkSm6V2HlqxxND?=
 =?us-ascii?Q?f5ae5a5Jn/p8GyyjwCjxg2q/GNhlh1O+sHgDBHsT5mH7KVvu3c9k/DiJ9Ol4?=
 =?us-ascii?Q?yZH+sGrL80EjO5neb/i/jqfyp6QPm0iuBmRumCZnTDFIxAW7z1kUkdCuX0at?=
 =?us-ascii?Q?VF8JvnX2PSFlt5ZxL7aHsSxILz3JhvtrwC/em3HNbiUj9zCK/lCEAbHl9tl2?=
 =?us-ascii?Q?j5721x3Eao5VJ8PLcGahhiyt+DY07o8EZj0hg2j2bfb6QvgFgaGBDcC2xM4v?=
 =?us-ascii?Q?G2NGeTNyhJeMOqcLjboZ0pVhI0FTeA6Z5rFhgjw6KjgspNh0fcGsNHjNA3Zk?=
 =?us-ascii?Q?0TiFlfVKuZ48Z8MFbDh7HRY6kI94e06Zrnw7U+eiVw8R78MTQihMY1R9b1jV?=
 =?us-ascii?Q?TNmxqgZ6Bsfj0QLGJ/E+aS8IAWxmi620jOwo73RQBarb3ycUykNmkHbD/W89?=
 =?us-ascii?Q?EJnoz3cXOcDUmKBksTW1eGQgm0S5t0LstJ7jDfzbrG/Jga7x4ihJsboYWR96?=
 =?us-ascii?Q?z8LVTX7QwSKRZ2s54SwTbs1pVS9/4UmsyUTwBe4q60b?=
x-microsoft-antispam-prvs: <AM6PR04MB52385520DA0541B83E588C6A807D0@AM6PR04MB5238.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(39860400002)(346002)(376002)(136003)(199004)(52314003)(189003)(26005)(229853002)(33656002)(81166006)(53936002)(6506007)(53546011)(8936002)(186003)(446003)(5660300002)(8676002)(81156014)(256004)(7416002)(3846002)(6116002)(71200400001)(106356001)(11346002)(478600001)(71190400001)(105586002)(15650500001)(110136005)(2906002)(76176011)(55016002)(66066001)(54906003)(97736004)(86362001)(25786009)(93886005)(476003)(7736002)(7696005)(4326008)(14454004)(6436002)(6246003)(44832011)(102836004)(316002)(68736007)(99286004)(486006)(74316002)(305945005)(9686003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB5238;
 H:AM6PR04MB4215.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ARaIhG1I6H/B0JVr/iNvoBLNFOyl/HmAp29dRbP+FVktrZ/y8HvtoJ93LFVsxJ4anOgM1J1RdWCt+pJNE4wA4CMVkQ7TF67ZFdWrPwVz2UYrk3sl/p2cmQ4CBF4lQSteQLwvtHUEQ/PQWjaxIhZcoUA2lAXgpMVRWtyNrlVXH+H2ZfQRY/qctLORY3SYwgXy7C9UII3Df47kGbWDNEk6Xq4vwMWPJKT61aa1CJaXEGdR3dNrYtIpI7s6zUZ6lKCqcZtTySnNny7oZzj/sXJmu6l5tZGUWocaCHdO8+UsFVtczUeeEkoyGiVr5pnMM5y0mrRjx9tpe1PFJBBhPaotnwaQotlFVgNl+sdDxYID/dlF0yhW5mcT/AmRoMaW58m8t9/+0rpmNWi2XNCsWbhTEO89vmzUL/2UyTzugKJmdsY=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31014456-a93d-47c7-ab4a-08d6973cf850
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 14:09:03.8461 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5238
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_060908_167953_771D5D13 
X-CRM114-Status: GOOD (  36.22  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 Anson Huang <anson.huang@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> From: Marco Felsch [mailto:m.felsch@pengutronix.de]
> Sent: Wednesday, February 20, 2019 9:53 PM
> 
> On 19-02-20 13:11, Lucas Stach wrote:
> > Am Mittwoch, den 20.02.2019, 11:21 +0000 schrieb Aisheng Dong:
> > > Hi Marco,
> > >
> > > > From: Marco Felsch [mailto:m.felsch@pengutronix.de]
> > > > Sent: Wednesday, February 20, 2019 6:53 PM
> > > >
> > > > Hi Aisheng,
> > > >
> > > > On 19-02-20 09:49, Aisheng Dong wrote:
> > > > > > From: Marco Felsch [mailto:m.felsch@pengutronix.de]
> > > > > > Sent: Wednesday, February 20, 2019 4:17 PM On 19-02-20 03:38,
> > > > > > Aisheng Dong wrote:
> > > > > > > [...]
> > > > > > >
> > > > > > > > > I don't like droping some ID's (e.g.
> > > > > > > > > IMX_SC_R_DC_0_CAPTURE0) by mark them as unused or even
> > > > > > > > > worse give them a other meaning. IMHO the scu-api should
> > > > > > > > > be stable since day 1 and the ID's should only be
> > > > > > extended.
> > > > > > > > > Marking ID's as deprecated is much better than moving them
> around.
> > > > > > > >
> > > > > > > > I agree the SCU APIs should be stable since day 1 and the
> > > > > > > > ID should ONLY be extended, but that is the best cases,
> > > > > > > > the reality is, there are different SoCs/Revision, some
> > > > > > > > revisions may remove the resources ID defined in pre-coded
> > > > > > > > SCU firmware, like the
> > > > > > > > IMX_SC_R_DC_0_CAPTURE0 etc., so SCU APIs removes them
> > > > > > > > after real silicon arrived, now latest SCU firmware marks
> > > > > > > > them as UNUSED, they could be replaced by some other new
> > > > > > > > resources in later new SoC, I am NOT sure, but if it
> > > > > > > > happens, this resource ID table should be updated anyway,
> > > > > > > > leaving the out-of-date resource ID table there will have
> > > > > > issues, since it is NOT sync with SCU firmware.
> > > > > > > > So how to resolve such issue? We hope the SCU firmware
> > > > > > > > should be stable since day 1, but the truth is NOT, could
> > > > > > > > be still some updates but NOT very often. And I believe
> > > > > > > > the updates will NOT break old
> > > > > > kernel version.
> > > > > >
> > > > > > Hi Anson,
> > > > > >
> > > > > > Please don't mix the dt-bindings and the kernel related stuff.
> > > > > > Unfortunately the bindings are within the kernel repo which in
> > > > > > fact is great for us kernel developer but the bindings are
> > > > > > also used in other projects such as barebox or other kernels
> > > > > > (don't know the BSD guys). So you can't ensure that your
> > > > > > change will break something. Please
> > > > keep that in mind.
> > > > > > IMHO solving that issue should be done by the scu firmware. I
> > > > > > tought the scu is a cortex-m4 with a bunch of embedded flash
> > > > > > and ram (I don't know that much about the scu since it is
> closed/black-boxed).
> > > > > > Why do you don't use a translation table within the scu? As I
> > > > > > said earlier I don't like the redefinition of ID's since they
> > > > > > are now part of the
> > > > dt-bindings.
> > > > > > The bindings can store up to 32bit values which is a large
> > > > > > number ;) IMHO wasting some ID's in favour of stability is a better
> solution.
> > > > > >
> > > > >
> > > > > As far as I know, those remove resource IDs are pre-defined and
> > > > > has never been used and won't be used anymore by SC firmware.
> > > > > (Anson can double check it) So I think it's safe to remove them
> > > > > or mark them as
> > > > deprecated.
> > > >
> > > > I think marking them as deprecated by a commentar is better than
> > > > redefining bits to be unused. As I said the bindings not only
> > > > linux related they are used in other projects too.
> > > >
> > >
> > > For other projects, the result is same because SC firmware does not
> > > support those Resource IDs.
> > >
> > > > > Personally I may prefer to remove them as they never worked to
> > > > > avoid confusing, especially at this early stage for mx8.
> > > >
> > > > So why they are there if they never worked? Wouldn't it a better
> > > > approach to start with a basic and working ID file and extend this
> > > > rather than adding id's because maybe the will work..
> > >
> > > Ideally yes, but may be hard in reality.
> > >
> > > SC firmware code usually is developed quite early before silicon comes.
> > > But the real chip may changes, e.g. removed or added something.
> > >
> > > AFAIK those resource IDs removed have never worked in SC firmware,
> > > and they're likely to come out of pre-silicon definition. But chip
> > > changes later.
> > >
> > > > Sorry but this seems wrong to me too.
> > > > I know the approach from driver development, adding a driver
> > > > specific *_reg.h file and later figuring out that those bits won't
> > > > work as aspected. As I said this will be driver and only linux
> > > > related so we can change them as many times as we want. But in
> > > > your case we are talking about dt-bindings and this approach won't work.
> > >
> > > I would agree with you if those resource IDs have worked before.
> > > But they never worked.
> > > Should we keep a thing never worked in device tree just because It
> > > makes us look like keeping compatibility?
> > >
> > > If that, I'd rather removing them to avoid confusing in the future. Life is
> long, right?
> > > I don't want people to bother with those unmeaning things anymore
> > > when they look at it.
> >
> > Removing things is totally fine if they have never worked. Re-using
> > the now "free" IDs is what is problematic. Only ever use previously
> > unused IDs when introducing new stuff into the SCU firmware. This is
> > something you need to communicate quite clearly with the SCU firmware
> developers.
> 
> I'm fine with removing too then there would be a gap. Don't know if it is better
> to have a gap or a comment that those ID isn't supported since fw-revision XYZ
> / silicon version ZYX.
> 
> Just some toughts:
> The gap will then suggest that this ID is free and was never assigned to some
> functionality. In real it was assigned previously and now gets redefined. Also as
> far as I can see there are no gaps currently. Let's wait for Rob's feedback.
> 
> As Lucas mentioned using IMX_SC_R_UNUSED* ID's for new functionality is
> totaly fine but redefine ID's seems wrong to me.
> 

Probably we still keep those removed IDs as IMX_SC_R_UNUSED*?

BTW, I guess Lucas's suggestion is:
" Re-using the now "free" IDs is what is problematic, Only ever use previously
unused IDs when introducing new stuff into the SCU firmware".
Because it's true that reused IDs are new stuff into SCU firmware.
So it's okay to change IMX_SC_R_UNUSED into a new ID, right?

Regards
Dong Aisheng

> Regards,
> Marco
> 
> >
> > Regards,
> > Lucas
> >
> >


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
