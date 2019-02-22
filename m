Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890C4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 04:43:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51D89207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 04:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iGeFUnGb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BXbr8ZD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D89207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FdhgmZmXSyvq/CKmKqMlWq402qZe7zfHiJChp+Ru5R4=; b=iGeFUnGbZsWDxp
	C20RNWZrma5F0rpFfULaxExAXGXn7LM/0xL8LoLwPDtlWG1DoBKaUE5ebIuF2cgNb0MnrlDT1WHhs
	Gwcybtd8zwDuJGsuCn4kxlKLlp8ROSNAzb8k7Z4f0mGIk7eFSGfOKxrjMIwPtAK9jdw1J+jlR/0+g
	khlpLcsXei5iOFVG928LesCXcxAAc4cqTXx6o+YVtrs6jYr5hXqzJvaP8LvBsCt/tvBezpbDXKhLu
	KXAS5Qv2vcivYRuElPjou0/lG3rBvm133Cz8Kr8jxvy7fYGWoGUCmFFOmyj5wwnShQZtmoRidyBDo
	rnHiOlXU6DgxfWsf8k0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx2g8-0003PY-8J; Fri, 22 Feb 2019 04:43:16 +0000
Received: from mail-eopbgr10076.outbound.protection.outlook.com ([40.107.1.76]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx2g4-0003PC-D4
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 04:43:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDF/DvSdTKCtNrBqiIhqKfI+HMfYLBdsbqUtlAjIcN4=;
 b=BXbr8ZD1ygeXxucUwC3AHGAjPK6txnoaDI4CN02azkP5pyLmwQViwiYxic6mscR6yqCRV/PFKoAU3Vkx/INB6/PJqQb+B/DrgVR4o8JlYU7HQuvLSfH3vsOAvw4adIcpxy8TALpj3HPfvlxcf9o7wqk9RYHd6fb/3TXlGLQDfUk=
Received: from DB7PR04MB4218.eurprd04.prod.outlook.com (52.135.131.15) by
 DB7PR04MB5355.eurprd04.prod.outlook.com (20.178.85.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 22 Feb 2019 04:43:05 +0000
Received: from DB7PR04MB4218.eurprd04.prod.outlook.com
 ([fe80::4dbf:e531:d53e:9b51]) by DB7PR04MB4218.eurprd04.prod.outlook.com
 ([fe80::4dbf:e531:d53e:9b51%3]) with mapi id 15.20.1643.014; Fri, 22 Feb 2019
 04:43:05 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, Fabio Estevam <festevam@gmail.com>
Subject: RE: [PATCH] clk: imx8mq: Add support for the CLKO1 clock
Thread-Topic: [PATCH] clk: imx8mq: Add support for the CLKO1 clock
Thread-Index: AQHUuPregGiZIr9DTU6Nn4rL+VOFK6Xq2FoAgACC9uA=
Date: Fri, 22 Feb 2019 04:43:05 +0000
Message-ID: <DB7PR04MB4218C623E27118064F9A46F6807F0@DB7PR04MB4218.eurprd04.prod.outlook.com>
References: <20190131002056.12024-1-festevam@gmail.com>
 <155078140414.77512.3157214123340597508@swboyd.mtv.corp.google.com>
In-Reply-To: <155078140414.77512.3157214123340597508@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e708df68-530a-4081-4710-08d698803c96
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB7PR04MB5355; 
x-ms-traffictypediagnostic: DB7PR04MB5355:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjdQUjA0TUI1MzU1OzIzOm5NVDZLRnNSOWhhL1ZhYi82Z2pEUnZ4VDRG?=
 =?utf-8?B?QmRreXNKRUs4NlJOTktOZDZFbENCUHRleE5TSldXNmdYdVBic2ZpRnlIakNz?=
 =?utf-8?B?WTJ6ODRCR2pudjA3Z09uMFAyM1d0VFo1dnkwcU9GNGVYd1JUWUtma2h0SFlD?=
 =?utf-8?B?SDJtMmdQOVNZcEJ3WmpnSk5TM0VwZXFhWmNBV2tpNGlpVFZkbnNqQzNFQk1a?=
 =?utf-8?B?c1FSSUMwendmYXpoVDNIT2dtek5QdFd6MUhnK2hYUXZmY1ZxY3NubFdpM0FW?=
 =?utf-8?B?dTR3SnFnYk90VFZ3elZaOC9ody82ODZPeGY5TXBlZUVpTDczZ1RyLyt2cktv?=
 =?utf-8?B?RmI5NlRnaTJHOEp3UEJLUTRDcm1qeEtMZ0dqYWJhTzZqWVpHQWM3VmZETHFF?=
 =?utf-8?B?enJHWlBaZnhkbkVxSXQ1eEJ0WHhKbTZrbnVTci9aR3ZOTnNnU0ZPS2liV2Fs?=
 =?utf-8?B?Z0I4bmJRNTN6NnRyU0pqb2tpTkdib0pVNWp3cktRNW9SZGg1TWNUQU1WYmNx?=
 =?utf-8?B?K24xemNEajVwNFNaOW96SzFBUDJadG1XVmQxWjZtdzNHUXp1RW1XY2lrZ1NH?=
 =?utf-8?B?L2ZyWFcwUThnNzJWRHpKdzlhVGIzMXFST0VmUFl1Z0pXdXF1eE5hdjFMS2xy?=
 =?utf-8?B?K29hRG5lZ1BvV2xtQnI2dnpGVXA1Yk5pSkdtY1NmTXVzelVaNEhFcXVsZ0JZ?=
 =?utf-8?B?TzBLSzFHRGFZeWU0RGxXdmFqUHEzRVEvOWZ6enVXN0d5WHF2S01sN0tOUUR2?=
 =?utf-8?B?MlhBd1BoUGJRYnVjenUyejhEakZZUHVvcFIwcWtHQTFuTGUxU3FFZW03dUI0?=
 =?utf-8?B?N3B2Q1p2cXdDR2RWNzJ2UlRSRnZBWnZQZ2VVZXFrSXR0aXFmR0J4eUxDaEdQ?=
 =?utf-8?B?aEYrSU5hZk0wUFZwQ0s0cG5DdThnRHo3Ynp1dHZyS0JFaE1selpRdURZOWJy?=
 =?utf-8?B?aXVISTNDaVV3TDM3UDg5NDJIeVhzZnpFQzlmKzEvYUdtUG9oWnA4VkxydUhS?=
 =?utf-8?B?VzMyKzM0V1R4aWNwQU1WWFB4UDdTbE1CaEF3cUhKeVZOM3F3aWJzbTh4bFhQ?=
 =?utf-8?B?bk9Ody84WW1oSm1HVjIyUWNnNkFWOW4veDhoQ1ZwWWMxdXFvVWhXZUUwRGRj?=
 =?utf-8?B?YTZaR0p6REFuYTdXajhVTHBnWjdpSVkvL3M1L3VOSGVUS0Y2MkdJa2kyUlBw?=
 =?utf-8?B?bys1bTV6UjdaRUJVRU1MNVJPVmJJVFM5KzVjamNxenVrVE5MeEhGR3FlRlIr?=
 =?utf-8?B?MUVYbkhtS0lpZDlvOHpHaVZiSjVYbkhqajhybFp5M1dBREp6Z3cybmU0R1pH?=
 =?utf-8?B?WW9FOFBXWXczT2xZMkFiQWJEdVFPSTdDZlBsV0Z3c2Z2Yi9oWVl2a2lvVXMy?=
 =?utf-8?B?MVkreVMxTWtEcXhpQ3llM2doZlgySWVueWRIT05BcmN2MmhDeXJEaUs5ZStF?=
 =?utf-8?B?YW9IaU5kazdOTXNjajZobnFnMUxMaHZsWXdvb3BUNHJFMG93WHA3UERDSDZG?=
 =?utf-8?B?VlJVTnljMEF2WVBBRDFKU0lEcTlPUU0vWEF5alNhUGVmeHREbVJvZ0t1YTJx?=
 =?utf-8?B?SUhFWHk2aWVoNkhqSmw4ak1YY1pKS21zbytmNWtodk1kTHdTRSs4UVc2cE9S?=
 =?utf-8?B?MzgrSzcydUJESDZJL05LQUtuYmUyem9UVzRlelNGSkZKcjU1cHRhU1JLOWMx?=
 =?utf-8?Q?HVQyFKhRQDn5nNvP1w=3D?=
x-microsoft-antispam-prvs: <DB7PR04MB5355229F6FEAAC290F4FF9A0807F0@DB7PR04MB5355.eurprd04.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(366004)(189003)(199004)(7696005)(25786009)(97736004)(76176011)(14454004)(486006)(44832011)(478600001)(316002)(110136005)(186003)(55016002)(105586002)(3846002)(53936002)(9686003)(4326008)(74316002)(6116002)(68736007)(7736002)(66066001)(305945005)(54906003)(99286004)(26005)(33656002)(81166006)(86362001)(71200400001)(71190400001)(81156014)(229853002)(446003)(11346002)(6246003)(8676002)(2906002)(8936002)(6436002)(106356001)(476003)(102836004)(256004)(14444005)(6506007)(5660300002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR04MB5355;
 H:DB7PR04MB4218.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6NjnuOtVgPZJjmbEHV7oyUtSFq52MD3+uQmAEG+Kr7cRvrsX2/KMMBl33HyaJTRlobyj1SvfBDDQld5T/9nLLP+NEJ5qul0qFxl63ZuFZXqm3bDrAMgn8rAiCK0QM574KYLMnmq2UihFwp3TSPq6h2WOmFWbFZZ2tacoFkBUqRCjA3YeRsgtBGGBmCgrZSLWMMM3YkyD2/8BphD1nLRFAdAoOQo+LgVn98+jgj2Q+icXWl28CkN7w9bMHG731H5eDTzZe/JNGAfvEvFuLvDsl5Iu3gUJz/L31AwaMww41q9Fl6c9dKlznDBS60/GBqdDFkcVpTv7nczGagNAKaTZtamy1BujMsMQNwHxNqqA5Ren9lSbejEaT98RojhL/8KYu0++slEvPlxc5LUR7mBa4VcisE8CiWMbMcZyiZvy48I=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e708df68-530a-4081-4710-08d698803c96
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 04:43:05.8130 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5355
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_204312_509802_5C79AA98 
X-CRM114-Status: GOOD (  17.42  )
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
Cc: Abel Vesa <abel.vesa@nxp.com>, Carlo Caione <ccaione@baylibre.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Lucas Stach <l.stach@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Jacky Bai <ping.bai@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> From: Stephen Boyd [mailto:sboyd@kernel.org]
> Sent: Friday, February 22, 2019 4:37 AM
> Quoting Fabio Estevam (2019-01-30 16:20:56)
> > Add the entry for the CLKO1 clock.
> >
> > Signed-off-by: Fabio Estevam <festevam@gmail.com>
> > ---
> 
> Applied to clk-next but I had to fix the whole DT binding number because I
> don't know what this patch is based on. In fact, please get everyone involved at
> NXP and whoever else is working on i.MX clk drivers to coordinate somehow. I
> just spent 20 minutes working through the set of imx patches in my inbox and
> I see approximately 6 different authors all sending out a few clks at a time for
> the same drivers with zero information about what the patches are based on
> or what order they're supposed to be applied in.
> 
> If someone wants to collect all the patches and indicate on the list they've
> picked them up and will be sending them as a pull request that's fine.

We know that there were a lot of IMX clocks patches sent in the list recently
and it was a bit overloading as you still need to maintain all other platforms.
So we do appreciate for your big effort!

We're speeding up the IMX upstreaming, there might be more patches sent out
in the following months for new SoCs support.

I'm NXP internal upstreaming leader, currently I'm busy with upstreaming MX8
Arch and assume I will be a bit free later. If you and Shawn are okay,
I would like to spend more time to help review and collect i.MX Clock patches.
Hope this would help relief you a bit.

Regards
Dong Aisheng
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
