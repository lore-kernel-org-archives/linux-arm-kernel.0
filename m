Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED20C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:11:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A0B72087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BjEHWDzo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O436PpfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0B72087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bVeqeASgqZgl3R+YeTbimraHKEeY/ZI8/pJaxG5qQYs=; b=BjEHWDzo8l1IDF
	A0rGQHJV6BiodEDPJ4shMdjDUm+Ro4anbmTz1MlCkWJT74AUeprcpS7JBt+yFU11kHBPxoUSUrb1f
	c9Uk+6hE0aBNvb0HA9/u2gslNVYmp+3pX5W3MWsDRd8/rK0T5P2wsWI4f1VSDxhbJ3DsYU5oh/dlj
	FSkHiZIQO6k/BrPqWPci0cxkyFd+Y0ZLcpzbeOE36UplBys+kSJILypauhuqSryzA1ZhZYenHPtYX
	PTWNw/kn8EeddE6w4hKXP5CI5U+bPKMeTys7DvxXW7nfvbiNWfyhMtUg6DBPsRA+WnS92UNzy+uqy
	mahXi+Q2DozZXj8Ab8OQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyHup-0004G4-LM; Mon, 25 Feb 2019 15:11:35 +0000
Received: from mail-eopbgr30073.outbound.protection.outlook.com ([40.107.3.73]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyHum-0004Fi-HR
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 15:11:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwnekPbXOp/yMDSDTxeiu5/js9kE3si1ADKfYaqYi3k=;
 b=O436PpfPHWA6dVHZpM54OFwfiMrRkyUuWAnt4m0GO9YDbTMReAvV0gHIa8vBp5BHKYIGaoXanK+IamCn/9H+PTRfVvelOqjlAObGYZ8wrfWVT3biaF6+ZsjrF2mBi/tCi0p/TSL5QYhmtC3drLD5yVK3nMzvuWJH/6jizNrgMak=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5763.eurprd04.prod.outlook.com (20.178.117.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Mon, 25 Feb 2019 15:11:28 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 15:11:28 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Carlo Caione <ccaione@baylibre.com>
Subject: Re: [PATCH v2 0/2] Add and document the i.MX8MQ OTP controller
Thread-Topic: [PATCH v2 0/2] Add and document the i.MX8MQ OTP controller
Thread-Index: AQHUuwj2Cc/A///8P0qiGlZUchVYHKXwwq+A
Date: Mon, 25 Feb 2019 15:11:28 +0000
Message-ID: <20190225151127.elg2iuaxa4otdb46@fsr-ub1664-175>
References: <20190202150638.13672-1-ccaione@baylibre.com>
In-Reply-To: <20190202150638.13672-1-ccaione@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bdcfcce-9afa-47ab-6a48-08d69b33848f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5763; 
x-ms-traffictypediagnostic: AM0PR04MB5763:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1; AM0PR04MB5763;
 23:C0FCtWm1llzVQOtq31pEm3BT66hspt3TlScHO7U+X?=
 =?us-ascii?Q?xtPUnKhLIny+F5I5mGsUJt0xxY9xpcRsTCOYREdqMS1JKbD+AXwxZT7wWaRD?=
 =?us-ascii?Q?serxRWoWXXfwalzjSKlHhT8LDivCT/TFziQ7JASBrWtUco1y+E8maPzz3zid?=
 =?us-ascii?Q?Rh77mJkKxXYZE0TXf6GMD9waZkHXRXWrDUvPbdbVXp73eB1fV2VfycZ+ZZPC?=
 =?us-ascii?Q?5uUX0Y/QCc6r6KEhMYfHGRmED1pguecxBtN7pzSczuoIP+c9atAZBZ4peHMB?=
 =?us-ascii?Q?6i+R+Iz1WgBHIw+YKHJV2MvmFYOp8EKETQPCBFf8qMHouXvQfdJ3UU53Og8R?=
 =?us-ascii?Q?C2rlOGK6dao7WwUxSuiLrLyTqu/tqKfUcDm6rqBHphX/owIgBv9d6yfa/PY3?=
 =?us-ascii?Q?108dnQCGKXkkyVEOyPaeO/FfhRNLw0V+pn8HJLC4FFj8BpyKzezNDiW+jabg?=
 =?us-ascii?Q?tt0POx+D7/cYc8yj8rIkAnss8owjEJDEIT2/ijsWwXWpqNevpC+iviAgHUAq?=
 =?us-ascii?Q?VY/r4grl8F8RN4sK3nJtz7K+xHA5UJhxkglPZJktOAjRoNkYPp8x1es7Y+jf?=
 =?us-ascii?Q?zuF9BlSZvYEFFT6xWJ8mCzY2sdeYk3cscyEyA7ucSi6NHr2NaDot2Jva3g5v?=
 =?us-ascii?Q?oThjYgo53taPRqpgU9ieeL9A0pV7vjpdVWF92r3YCQickbWyqc7bvfnb2lbV?=
 =?us-ascii?Q?09CNB+MFxRp4RNgyDIg0Twi4vFRVv3kt2P3DVC6vxecEn+mQHG2Ph5DjWtTy?=
 =?us-ascii?Q?V9Ne1INMOJ8EWDeNesl54IAGtmWY2vrgv0HFE6v3A4YV82NL6Ti2mt7a0eqL?=
 =?us-ascii?Q?j5N1aSUH5WLMnXGi39plDTPDVgSSojkaW1TvYzvTrnw0C6q5eBKn3fjOLsAJ?=
 =?us-ascii?Q?7vdHeS9+APfge52xRtKGmbI5DL5aDkoLn4RKHbEdRkJqDg0JoXp3ByYx6lKd?=
 =?us-ascii?Q?neMyHx7+tYVD3A8ESqhezCOapjFQ4NasXsfK4nVw7vk8Z+5yvfzFexsKg4zO?=
 =?us-ascii?Q?KivT1mE4OsZvmTSiCEOea8RPWCnUAnG608PqOsDa7bYHggV/nEKus0+1uTdK?=
 =?us-ascii?Q?WkcjtccsHyksPsIFyuAgkcVW9EfI5iJj3P0hIINRPbeqGirAebeqZUz424+m?=
 =?us-ascii?Q?uZ1QZhZUTBXzxypb9AQXuorlJ/U36ytWUtx5b0Cav1RyXHIQe+ycHumLVKxb?=
 =?us-ascii?Q?/vnA/7mZGDNgHpdy1VgMXrpvQorfqAMptmmlMPbd4ZfzS2KzeWzRiQgKNVoU?=
 =?us-ascii?Q?YJMvb9vZDTMxNR9Ysx9dZ6eFZwctG8sS4/geOZoELHWbsbFN8P2nyy2dYnz2?=
 =?us-ascii?B?Zz09?=
x-microsoft-antispam-prvs: <AM0PR04MB5763B188BC2BA010FB1901CEF67A0@AM0PR04MB5763.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(7916004)(366004)(136003)(396003)(39860400002)(346002)(376002)(199004)(189003)(6512007)(305945005)(7736002)(9686003)(6436002)(68736007)(486006)(446003)(11346002)(476003)(44832011)(53936002)(4744005)(6246003)(6506007)(53546011)(7416002)(26005)(33716001)(102836004)(6486002)(478600001)(14454004)(186003)(229853002)(76176011)(86362001)(8676002)(99286004)(81166006)(81156014)(5660300002)(1076003)(8936002)(256004)(2906002)(25786009)(54906003)(71190400001)(71200400001)(4326008)(316002)(6916009)(105586002)(3846002)(6116002)(66066001)(106356001)(97736004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5763;
 H:AM0PR04MB5779.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Bnq+Ley7cSvuFB0tVNXoqOexGXd+ialzXN2cgPfAx2UCHGZFbEKg7P9i2ylTGq02MYXJD+JMwmLEgoCyfhk8R27NXmimVsll2362KQ0yPLsYKbEQJuhPBiZz9/Y8UJILd0rIoCdZZsfso7hc6W8OUpCUWjNiXPLSCD/tdDkhOIMuYdbahdMaVoSAqEutnk3UA80RFy76zNEoDg2t5CtH3Ji24R8oMKGgcgk9LJV3QrEYvnsnBodemLO1ZwGujGSlzFxcJwgoXxl5DVgdnX1egHhgrFgRw3W4v+N+HOowHYdQsEpxZApzyY4ytRZ+EWuzEm1dinJ5QpVdEgk6nB884H1KFtM+T0heOGCSpFS2Vx5u8hUNOzeH+XE39SIgisIeH0qhz7ARy7Bkrcmdle6jmcI2VJfMblACunazXXHIuZk=
Content-ID: <6A27DF8094355A43B49DEEDA7B2D886E@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdcfcce-9afa-47ab-6a48-08d69b33848f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 15:11:28.8582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5763
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_071132_579823_531F57C8 
X-CRM114-Status: GOOD (  12.23  )
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
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 19-02-02 15:06:36, Carlo Caione wrote:
> Add a new node to enable the On-Chip OTP controller and add the new 
> binding in the documentation.
> 
> Carlo Caione (2):
>   arm64: dts: imx8mq: Add on-chip OTP controller node
>   dt-bindings: imx-ocotp: Add i.MX8MQ compatible
> 
>  Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 1 +
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi             | 8 ++++++++
>  2 files changed, 9 insertions(+)
> 
> -- 
> 2.19.1
> 

What's the status of this patchseries ?

It would help a lot if we would manage to get this in.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
