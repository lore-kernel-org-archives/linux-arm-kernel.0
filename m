Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B88AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:27:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3755E20815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t0kKyuhQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZAYYG4Da"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3755E20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Jt3KzI3yCKvobgWKx7O1ZhFMAYenXFD2TZYRzW5LEMc=; b=t0kKyuhQ8YWueO
	/2QFFWy6Jjtr6ZMAZ6dkfZCwpGO2pYndouyY09eE+Sk6lUB0RCBdYe9c+Vl82DcIv9h/a2uqJKpUh
	XxCCXSA6DjjNp3zoxrvUCEd+522Gd06Tj70IxGhjuJ/oEiyb7WMHgBC00XBiDZ10ivR9uiG0rW06A
	FMJ4JmX3vPG4iT3nuorJb4MXLndLB3uLGeeOoofk35jDep0BYPxUvXC+4Zm7oIF714maY9ogXKV1k
	UTnPMYHdoRQ8A/naqWiFrmUjhuLApzJizYTwHzwiYHtz3XjFCRm+1hoNn125W9S7jDFKjQ0d9UXDa
	AQHPTrJuJp3QLPV2KjSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZrnf-0006Fk-Sp; Thu, 20 Dec 2018 06:27:15 +0000
Received: from mail-ve1eur01on062b.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::62b]
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZrnc-0006Ef-JV
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 06:27:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/zl/8QnL8oFgZ1oPgFgwHcd7iefG4pfo155k2IGJ5I=;
 b=ZAYYG4DaVAFEGuL5vR9LRquzMPhqoh3RNBgcyd4MK9rafAZUtA6ITN04G9XAP6kB40S12SkAYkRziTezvnO8wTq9YaqIvnjsgCeF0AzR5078NgL8+PFl5wukejIqUr5y0J+vrxmwzTylIdre997AtzBOKruEDcKrNYlyTgyyH1M=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB1438.eurprd04.prod.outlook.com (10.163.166.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Thu, 20 Dec 2018 06:26:50 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::8003:6376:a0a2:9a30]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::8003:6376:a0a2:9a30%6]) with mapi id 15.20.1446.020; Thu, 20 Dec 2018
 06:26:50 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Subject: RE: [PATCH 4/5] clk: imx8qxp: make the name of clock ID generic
Thread-Topic: [PATCH 4/5] clk: imx8qxp: make the name of clock ID generic
Thread-Index: AQHUl69S+HgseDOVoEaFEXoCLLe+SaWGS2qAgADXyCA=
Date: Thu, 20 Dec 2018 06:26:50 +0000
Message-ID: <VI1PR04MB4222ABD43B82BD3C0B73404780BF0@VI1PR04MB4222.eurprd04.prod.outlook.com>
References: <1545232888-9302-1-git-send-email-aisheng.dong@nxp.com>
 <1545232888-9302-5-git-send-email-aisheng.dong@nxp.com>
 <CAOMZO5DzMpMp-Tf74iM3SuHoFpji8z-dxM-UsC13GeDx2bZYgA@mail.gmail.com>
In-Reply-To: <CAOMZO5DzMpMp-Tf74iM3SuHoFpji8z-dxM-UsC13GeDx2bZYgA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB1438;
 6:OYaq3JqYULnjRiYVVXaSTKQXFWublWoWFXgQQ9xIcowy7zBiYHfO/SqGzp0I+FR/7CoduyMDvJ6ZCRGynhYrOXdhkGcnDWEddhh2z2sqSeoty4vbatXvqvi+42Q1BJ0Wz+8WUKLv/JyrWGRVuPJCtLjhHKBsKQhUlqNsbcuYqlgPNbYwVg99YhGGQ/XdLqthZdrVAZky8UNjUPUKbtUzZ12FVXYSL/OXxhCWmz257qMpiJLimMGYSuLwgSVVnwOYAdRUOxOkYbFPA7+Wy4nZ00mazqNeeqDNp2Zjp8xlTpAS4BwowtLLsOq0tSEpG4ne368qPfVy3KTDLOFS+FLFVR4L6jMS8siLdXUxHW0IZhEcRajMbzjqRIhbiQ3n+QHfKLYolzAP/WeITS1YHCpkhBiRHelqUAjgnmB0lVxVw3dyNZbUNL4oVyKV8cPiIITnoQF4Or1M5IqcbXCVor30xQ==;
 5:fnwEG4/uMH+I4e2iZRbroENfu1XynbyA6H4kS65qYQfIa47z3NAso7w5XT4Tljrb6lUufxiw3PQIlWpzrGVtjPhhKxGsbtjrJz9kXZskrio6fqKlMwt9llIZ7W8XQOLChRurIqj6iRldWdWknx5bcWoPcP4JC3kg1sxvyZvd2Ps=;
 7:YcozfWNtyRGOGLE14sjbXHU6jV+a/xjMCdTCM+BpZ/JTze3ooh2YfzfSx2Ih7UBH2QmY98tXNbknZJsZ9CzgKEVNVne0+uW/EGLnj6x93NlzOiHJtbo+dTnLJgUFL1sWLjmG4vkuA0n1+nGfKdd4gg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6904f9f9-be6e-4996-22d9-08d666442066
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB1438; 
x-ms-traffictypediagnostic: VI1PR04MB1438:
x-microsoft-antispam-prvs: <VI1PR04MB1438D15E6FEFBFE774E0079D80BF0@VI1PR04MB1438.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231475)(944501520)(52105112)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB1438; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB1438; 
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(396003)(376002)(366004)(136003)(39860400002)(199004)(13464003)(189003)(99286004)(68736007)(316002)(8676002)(446003)(11346002)(105586002)(8936002)(2906002)(53936002)(55016002)(4326008)(6116002)(305945005)(39060400002)(81166006)(81156014)(3846002)(5660300001)(6246003)(256004)(9686003)(74316002)(476003)(486006)(71190400001)(71200400001)(186003)(86362001)(7736002)(1411001)(106356001)(6436002)(478600001)(102836004)(14454004)(7696005)(76176011)(53546011)(25786009)(54906003)(97736004)(6916009)(6506007)(66066001)(44832011)(229853002)(26005)(33656002)(41533002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB1438;
 H:VI1PR04MB4222.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CZbCkHByvGStec8HoUzTUg7AiBFastMGOuS6zHuCZbzrtSybe/AOtkSGfDFu/prAjOrNdBHYWRrp+6cUYN7EvZcd5AunCV9T+LKJF5Q4qal4nmCyes2d/6s20Wjxfw//dUA2QZnHmb6Z53RSVmMfMf8o+7JfEJwmR26fBRg0Dl/Z5WQ02mcrW57Jrl77AUDJ+xB1JcDumPvHAKDYIgk+YW31Tgc94npkyyjWQutmtAeXm5Wrjd5ueuqTRCDph8aMZOac/w58qcnTHurykJDzJ/U4LVbalXMKE5nEjEmSW64DGI2kpsK6E3hF3uzguUO6
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6904f9f9-be6e-4996-22d9-08d666442066
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 06:26:50.5706 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1438
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_222712_695614_3ABEB8F7 
X-CRM114-Status: GOOD (  19.13  )
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
Cc: "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
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
> From: Fabio Estevam [mailto:festevam@gmail.com]
> Hi Aisheng,
> 
> On Wed, Dec 19, 2018 at 1:29 PM Aisheng Dong <aisheng.dong@nxp.com>
> wrote:
> >
> > SCU clock can be used in a similar way by IMX8QXP and IMX8QM SoCs.
> > Let's make the name of clock ID generic to allow other SoCs to reuse
> > the common part.
> >
> > This patch only changes the clock id name and file name, so no
> > functional change.
> >
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  drivers/clk/imx/clk-imx8qxp-lpcg.c        | 146 +++++++--------
> >  drivers/clk/imx/clk-imx8qxp.c             | 152 ++++++++--------
> >  include/dt-bindings/clock/imx8-clock.h    | 289
> ++++++++++++++++++++++++++++++
> >  include/dt-bindings/clock/imx8qxp-clock.h | 289
> > ------------------------------
> >  4 files changed, 438 insertions(+), 438 deletions(-)
> 
> This seems like unneeded churn. Just keep the existing naming and other SoCs
> can reuse it without problem.

There's a reason.
We still need add some clock IDs which exist on MX8QM only (probably more on future SoCs)
Having them prefixed with 'IMX8QXP' may look strange.

Besides that, as those clock IDs will also be used in devicetree, make the name generic for
different SoCs seems still better and less confusing.

Regards
Dong Aisheng
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
