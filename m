Return-Path: <SRS0=5OaU=PA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA071C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 15:35:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9810121971
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 15:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FF9FUiBe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EcuVCwJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9810121971
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DoTW1Zys5AIAlG8brEo4mjvTMg3o7LImjNIH/5dVfZw=; b=FF9FUiBe/TItai
	Zj3Rik3Tvu4o/ewoOQ/NE9SLP2tbNRv7BoTMePjyv7dc6wLpbFiwM/ddVqc5uVkhGC1m56E+e+Mpb
	vr4eICeSvcvsyb+5bahSaiwpD0oyfVQVlBj9LWkIB50IzemqQtDN0P5a/m1Re7oqwa4gc9IQaciqR
	izCmmWr53LERnoPmoVW9xAFrAU56F9p71wIbeqOhudnVCr7XL3zbPJK3Q5eomHu36pbgICJHCc29p
	Pv4SPku9D2GfVCKtgKDzCf6hkL/rZ6QpovKp1YbMOyOurT6jzBG/BYL7yKCpLdjlz56ydweZ8Jlj3
	U3utnYfd90AIQ3cJmXPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gb5mp-0007Ow-27; Sun, 23 Dec 2018 15:35:27 +0000
Received: from mail-eopbgr20078.outbound.protection.outlook.com ([40.107.2.78]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gb5mk-0007OD-LY
 for linux-arm-kernel@lists.infradead.org; Sun, 23 Dec 2018 15:35:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARSB9MP2O2T0GgNmwoC2i8GvEmiD0tz9pwxnUXO0yaY=;
 b=EcuVCwJfuGOvk5jdKmAQaMb6LtjW3ykhFDLWdMmIBmMOHINjMmMFFdYyL/OBhixYJVClnREN7m8roUMJ56ARNE4pMFxuVMy/1JfIpggcPnOrUkTaGXr3fXTyEIpyumyYSK2Z9hai5PGMHnB0NZ5kFWNRRDplxMaoG79YPyALLkw=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5409.eurprd04.prod.outlook.com (20.178.114.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Sun, 23 Dec 2018 15:35:08 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%7]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 15:35:08 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 Fabio Estevam <festevam@gmail.com>
Subject: RE: [PATCH 4/5] clk: imx8qxp: make the name of clock ID generic
Thread-Topic: [PATCH 4/5] clk: imx8qxp: make the name of clock ID generic
Thread-Index: AQHUl69S+HgseDOVoEaFEXoCLLe+SaWGS2qAgADXyCCAAOU2gIAAY27wgAEjygCAAugrYA==
Date: Sun, 23 Dec 2018 15:35:08 +0000
Message-ID: <AM0PR04MB4211494A964F6DBD437A7EAC80BA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1545232888-9302-1-git-send-email-aisheng.dong@nxp.com>
 <1545232888-9302-5-git-send-email-aisheng.dong@nxp.com>
 <CAOMZO5DzMpMp-Tf74iM3SuHoFpji8z-dxM-UsC13GeDx2bZYgA@mail.gmail.com>
 <VI1PR04MB4222ABD43B82BD3C0B73404780BF0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <154533484105.79149.16225192496445475758@swboyd.mtv.corp.google.com>
 <AM0PR04MB4211F8786714DD6CCBB55F0A80B80@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <154541885475.13075.16994932864140896829@swboyd.mtv.corp.google.com>
In-Reply-To: <154541885475.13075.16994932864140896829@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5409;
 6:kjQbWoWyNJupzvRxtHSpxQMyu8g49fnSJOEKw+j3YjZ1/gRm9eu7HGrzjGZq33kPpwpOTXecajdSpkbTjTfcPUoR5YWEWKUZoIEW+bRWgTCkauf27CiPBQ/ah5fOMPmK1TlB5CvXeE7ECD4rXX3mHXHw1shlWIog0qplhOK3yBhMhfz4XIx+CD7VgOXC9u+YQRfDaUzxM10vgk8a947ajTevC15XTRe6huYfwLvA+TzeUYIhcN2a/lsWoUjd9rNyEzvolIKjhZMuk3JVqrLFn+z/c0AZF6D3CAnB3ERgoquL/El7c3uWbjO0+8QxPeMk6NGtg6/WC55Oq/ybomsI0TrPrSnwljRNox20hzVtCFYp+6qxQyzfhToIjmckQG+nNnIibxaQyO55KilSwVak+YQXtJQwgSm82YbLa90MBs82JPiIfudlS560G+fyZtkvTvZ4HNjlTJCcETVgMcalOA==;
 5:3wFGuHYYh1aAkR+ohBP2oCcraGGFs8tzVsGwVe+nDpj7jAGCb3dMF0fud/yQz47cEblR0IAD5ovGgSVofWFsRCdzY4imUb9CEZg3lQzzu19IZeuQzhpemVvqwaAVe6iqWRWKGwxunVMNpqLMs78OCLmSBbRAAmlxlik5C9te0a0=;
 7:sUWi7ybotPoQk1z+C2SM3XQ3auolIpNGz8chw7quPxG/zEycM1yY4zYjzFLw8J9br+gOvBzxU9OH3pAW9Mh3dUCk2JeYKNwfuWywm2mCa7IBuAPBFTJDPzkwWj25NnTOvESRAk+PK6I7k3yX/hpTQQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3a62dc33-1336-4ea5-039a-08d668ec3814
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5409; 
x-ms-traffictypediagnostic: AM0PR04MB5409:
x-microsoft-antispam-prvs: <AM0PR04MB54094448BAA71F51EF99AB3E80BA0@AM0PR04MB5409.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5409; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5409; 
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(136003)(396003)(39860400002)(366004)(13464003)(51914003)(199004)(189003)(76176011)(55016002)(4326008)(9686003)(39060400002)(71200400001)(44832011)(71190400001)(26005)(486006)(2906002)(74316002)(476003)(6116002)(3846002)(256004)(446003)(11346002)(86362001)(25786009)(102836004)(93886005)(7696005)(186003)(14444005)(53546011)(6506007)(6246003)(14454004)(53936002)(316002)(8936002)(4001150100001)(81166006)(81156014)(478600001)(8676002)(97736004)(68736007)(99286004)(33656002)(2501003)(305945005)(6436002)(7736002)(66066001)(54906003)(110136005)(229853002)(105586002)(5660300001)(106356001)(41533002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5409;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SyXH4tH64M3oD4ySsgjIzuqzWwn18menTFSu1UZqkBZsFGuNdeNwlV87Lc8Qrj3s1ASq9V1dpjmt+nueNrrcr9lJc70+TdYy5yOEoHblhuvkkQOCls1TyUQx3kx6OavSnsXWGfW5ubRbHdhJ/iMVSLaWmGF9aWrXKYrOOss8kQRI22P0FD4kOJfNGgyf7PqNpdGRxhRLVwzvdro2YkXEvTJtimy1DUml4ATzcOPGF9vrW1rWVkzQoJz8k1+OXuo0Et2Jo+K0kIRfSPAgX4Fk9cQQknkEcja/EfCQpKOqRwC9qm+JDF2Rg9m50Tg6KblJ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a62dc33-1336-4ea5-039a-08d668ec3814
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 15:35:08.0479 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5409
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_073522_784350_1327B020 
X-CRM114-Status: GOOD (  33.96  )
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
Cc: "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd@kernel.org]
> Quoting Aisheng Dong (2018-12-20 17:44:28)
> > > -----Original Message-----
> > > From: Stephen Boyd [mailto:sboyd@kernel.org] Quoting Aisheng Dong
> > > (2018-12-19 22:26:50)
> > > > > -----Original Message-----
> > > > > From: Fabio Estevam [mailto:festevam@gmail.com] Hi Aisheng,
> > > > >
> > > > > On Wed, Dec 19, 2018 at 1:29 PM Aisheng Dong
> > > <aisheng.dong@nxp.com>
> > > > > wrote:
> > > > > >
> > > > > > SCU clock can be used in a similar way by IMX8QXP and IMX8QM
> SoCs.
> > > > > > Let's make the name of clock ID generic to allow other SoCs to
> > > > > > reuse the common part.
> > > > > >
> > > > > > This patch only changes the clock id name and file name, so no
> > > > > > functional change.
> > > > > >
> > > > > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > > > > Cc: Sascha Hauer <kernel@pengutronix.de>
> > > > > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > > > > Cc: Stephen Boyd <sboyd@kernel.org>
> > > > > > Cc: Michael Turquette <mturquette@baylibre.com>
> > > > > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > > > > > ---
> > > > > >  drivers/clk/imx/clk-imx8qxp-lpcg.c        | 146 +++++++--------
> > > > > >  drivers/clk/imx/clk-imx8qxp.c             | 152 ++++++++--------
> > > > > >  include/dt-bindings/clock/imx8-clock.h    | 289
> > > > > ++++++++++++++++++++++++++++++
> > > > > >  include/dt-bindings/clock/imx8qxp-clock.h | 289
> > > > > > ------------------------------
> > > > > >  4 files changed, 438 insertions(+), 438 deletions(-)
> > > > >
> > > > > This seems like unneeded churn. Just keep the existing naming
> > > > > and other SoCs can reuse it without problem.
> > > >
> > > > There's a reason.
> > > > We still need add some clock IDs which exist on MX8QM only
> > > > (probably more on future SoCs) Having them prefixed with 'IMX8QXP'
> > > > may look
> > > strange.
> > > >
> > > > Besides that, as those clock IDs will also be used in devicetree,
> > > > make the name generic for different SoCs seems still better and less
> confusing.
> > > >
> > >
> > > This looks like an integration problem. Is anyone using the defines
> > > that are merged through clk tree now? A grep of linux-next says no,
> > > but how can I be sure?
> >
> > I'm sure no one is using it now.
> > The only user DTS (imx8qxp mek) is waiting for merge after 4.21-rc1 is out.
> > So it's a chance to update it.
> >
> > >
> > > So can you leave around the header file with the deprecated define
> > > names and introduce another one that's a copy of the header file but
> > > with the non-SoC specific names?  Then you can wait for a release
> > > cycle and delete the old header file that nobody should be using in DT
> anymore.
> > > Unless you plan to make sure that nobody uses the deprecated defines
> > > somehow?
> > >
> >
> > Yes, the plan is to make sure nobody uses that.
> > Otherwise, it may be hard to send DTS patches using new CLK ID name
> > through different tree later.
> >
> 
> I've already tagged and prepared to send out clk tree for the next merge
> window. It's getting difficult to change this before -rc1 too because I'm
> traveling for the holidays in the US. I'm fine with changing the world if it
> doesn't break anything, but I'm not interested in making the pull request wait
> another few days for this particular topic, so I'd rather send this as part of a
> follow-on fixes PR during the merge window next week.
> 

It's fine to me.
Thanks for the detailed explanation.

> Can you resend with just the things that need to be changed for the next
> release (v4.21 or v5.0)? And Cc the relevant people/lists and try to collect acks
> and reviewed-by tags before next Wednesday? I can send a fixes PR on Friday
> next week then.

Okay, I will resend this one only.
Thanks

Regards
Dong Aisheng
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
