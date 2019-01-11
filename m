Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88C5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:24:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 848F520675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lBnp5uY2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TDn4y5VV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848F520675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cFmf7nIk+6+njRiUpMVrKI8AmNcOdZa32jkUz3PgvuA=; b=lBnp5uY2wyBNmt
	8BAhZEIVCLmINvoaxaTEKHVTB8Vxz71s+LI/iXFdWNSpeswMA3pERzKrdGqgdkm02nIoqOS/1WZP2
	nYKconMM72suRhuk7oYtZYOpq9iA3bYzHXgdH9Wg0T4DP3nShZ12Vvxy11PCZAp2bu0xXfWmqzmYW
	mYn4itUekpgJnKjDcWN0wjZcmYBabt4w73sIdD8jijzMrDl9OxoZqbgMVK+68FcVQsgGkR/Nb3UTh
	ELn18VWCIRzgb6268UWeWTkucYxDb7cr8QwQGXSdCVjpzRKi17ytV8VazowMCPuLWZhy+eO0ol9iq
	vChp1IWui09z0RXWpbfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghyfU-0006fI-L7; Fri, 11 Jan 2019 15:24:20 +0000
Received: from mail-eopbgr00076.outbound.protection.outlook.com ([40.107.0.76]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghyfP-0006ef-OT
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 15:24:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxlPpRo6u2jMAIRpsje40NO4LAu/ZWdRFDCZl7YVawQ=;
 b=TDn4y5VVU8KYEOBoS6hJlpaK8Qk7wb3q5gr4xM3dz9bXLmVg0QXMiVm1vNh/XF8nHRn+oipPcN88yXGMKVCdqB97JVBtDIyAmz+0YIQw6qoeru1g3c2F6y2KYflfynEAOckBHNJ0xdgVre8v32Gf6fF9V9JewNlTBvdeCBWkrOw=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5554.eurprd04.prod.outlook.com (20.178.114.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Fri, 11 Jan 2019 15:24:11 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 15:24:11 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: RE: [PATCH 1/3] dt-bindings: fsl: scu: add fallback compatible string
 for power domain
Thread-Topic: [PATCH 1/3] dt-bindings: fsl: scu: add fallback compatible
 string for power domain
Thread-Index: AQHUlurqutx971slw0Wkld4RueG9XaWp6keAgAAB4oCAABhkoIAAKaMAgAAiE/A=
Date: Fri, 11 Jan 2019 15:24:11 +0000
Message-ID: <AM0PR04MB4211BFB2A3D02F67E4AE0B1F80850@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1545148524-658-1-git-send-email-aisheng.dong@nxp.com>
 <1545148524-658-2-git-send-email-aisheng.dong@nxp.com>
 <20190111090009.GG32649@dragon> <20190111090653.GH32649@dragon>
 <AM0PR04MB42119B411244F0B1BB829D9F80850@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20190111130311.GA3599@dragon>
In-Reply-To: <20190111130311.GA3599@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5554;
 6:l0ur50xfWF5bpZ6Z21KtxZZE8bcK7tuwyC3zynL9KOxbJrxyJReL6XbjnfdD/NDx5fn38scVTssCPWHhLRh+Ju64Y36q+hMI+1QgRdvoAwm1pxhNedu/NFYQCgOnfMPqN8Ps+DusfB4i8LCCTWMwA+A83Ve0K7L9OjpRbSdPtgXRglmINWmyY5G5Yetn6WOjBuluOf+GEVnJXP0soFNuLjwEPTrwasCAmNxt6hRpuzh5qlViYRsnEG1C1+bbsDiEn3mahmySIu/1B9rHZW/A8Pqk1EtkgY4i8pYU5ve7X9+K0pP8PVzDTPTleeUq4fp1IreWz0z0CwHZ/b1spJoU0p5yurpeE2eSWI9ZX93SXYu1sECDgPOmLiXTLc0Vprv6Sg4/mbP6GS89DPH7McaS1w7HfPwBvHrU3wov81zaBpMBCEIPBD9fLfEZ4SqYkeLS8zqpTfxrIT/Ylc0+bQjQDw==;
 5:DoDpkylF0HY6XPYcLMOyS8hy9ymjWD1/gCnQbk7HivKPIqp4gFFDpjLS6WBI2Ot2Kz8bGeXWOtdZblCANUY/8RE7TXyjt/7qghlLsGwOV0QxZiMwE7AmYK9ntPab6XYmo5NIMumBZHZDMLizUpG689AIWI1GM0vW5ZAClvio3qui2Z7lqcLsGl9yXkudL5yVQXqhP/CIsashPGCeBXIvkw==;
 7:Cm+eokIwHWZu9n6XJXGKUxsDUiVwlL+XgKZ9bLPFOHqjztUFQBD0XF81Rv3yJ6rg4nis/hDd7UA6nKLqwXfzCvO6ogfjs/w7MV/HvrJxuhFz42J+zSvLVN1tzoPIOFGW2gxK0WBsnlmEx0vDXpuflQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d859078d-fec3-4eff-25f2-08d677d8d66d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5554; 
x-ms-traffictypediagnostic: AM0PR04MB5554:
x-microsoft-antispam-prvs: <AM0PR04MB5554455487C3CE9E9277DAD480850@AM0PR04MB5554.eurprd04.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(346002)(376002)(366004)(39860400002)(189003)(199004)(13464003)(52314003)(7696005)(7736002)(305945005)(39060400002)(2906002)(26005)(186003)(102836004)(99286004)(55016002)(478600001)(74316002)(97736004)(446003)(33656002)(71200400001)(11346002)(66066001)(4326008)(8676002)(81156014)(9686003)(71190400001)(486006)(53936002)(6246003)(7416002)(14454004)(25786009)(93886005)(6116002)(54906003)(229853002)(44832011)(5660300001)(476003)(3846002)(86362001)(256004)(316002)(68736007)(6916009)(106356001)(8936002)(76176011)(81166006)(6436002)(105586002)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5554;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oOqUAE+1KZZ8NWihOvVDrRL6rq8bTPwRUy50QxXkOBYDZkL72Kp9HrN21MvA4h9TegvMMtPvXM1TRl7i18N7iV7PpXkg6oxby5aFveLg+gs16lQqkrKgEvRGEF+Z2LbLO7xe7Mk8fekRRKExg9DhvIcX4jBy+ht61/7j5pQMETbV6uy6Yr8/48VQ4Vps5847SSUNU2YQPqKX8vYpGgXxJ/gaSCa2luCZktw4NTkIhJC2YGdYQIeYPXA5LM/o8qp6lyyLe5dFfZTwZiMppKCGHKaPgFVJY3K9y5mExpHzl/0LWd3fBJpJC6fOLKY6v2KpR6WCFX2ZtnJPJag8Ae835HxnEF/i7hjXfTzJzu1k39xaf/eHnIXVZ8pu+EEp2JjKzj+balK28PGNGMCJ0E6ggG7pcW8J4JYx5eCjag+x8ng=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d859078d-fec3-4eff-25f2-08d677d8d66d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 15:24:11.3102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5554
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_072416_366368_4CB7EB99 
X-CRM114-Status: GOOD (  21.59  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "khilman@kernel.org" <khilman@kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> From: Shawn Guo [mailto:shawnguo@kernel.org]
> Sent: Friday, January 11, 2019 9:03 PM
> On Fri, Jan 11, 2019 at 10:48:21AM +0000, Aisheng Dong wrote:
> > Hi Shawn,
> >
> > > -----Original Message-----
> > > From: Shawn Guo [mailto:shawnguo@kernel.org]
> > > Sent: Friday, January 11, 2019 5:07 PM
> > >
> > > On Fri, Jan 11, 2019 at 05:00:11PM +0800, Shawn Guo wrote:
> > > > On Tue, Dec 18, 2018 at 04:01:20PM +0000, Aisheng Dong wrote:
> > > > > SCU power domain can be used in the same way by IMX8QXP and
> > > IMX8QM SoCs.
> > > > > Let's add a "fsl,scu-pd" fallback compatible string to allow
> > > > > other SoCs to reuse the common part.
> > > >
> > > > This is not the practice we used to match devices with
> > > > compatibilities, i.e. coding the compatible string with the SoC
> > > > name that firstly introduces the device, and use the compatible as
> > > > fallback for new
> > > SoCs.
> > >
> >
> > This is suggested by Rob that if the future SoCs are likely to be compatible.
> > Then we can use a general fallback compatible string like "fsl,scu-pd".
> >
> >
> > From SCU HW protocol point of view, they're indeed compatible.
> > Just varies a bit on the domains numbers.
> > That's why we introduce "fsl,scu-pd".
> > But still keep SoC specific compatible string in case any special
> > tricks to ensure the ABI stability.
> >
> > How do you think?
> 
> Unless Rob is against the practice we have been used for long time on i.MX, I
> would keep using it for i.MX8, i.e. instead of introducing a generic compatible
> for fallback, simply falling on the compatible SoC specified IP block.
> 

Hmm, i feel protocol based devices is slightly a bit different from our old practice.
See ARM and TI are all used generic compatible string.
Documentation/devicetree/bindings/arm/arm,scpi.txt
Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt

If from firmware protocol point of view, they're defined SoC independent.
SW(driver) implementation might be a different on platforms due to special tricks
or implemented as platform independent.

Anyway, if you strongly against this, i will change to what you requested.

Regards
Dong Aisheng

> Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
