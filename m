Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A70C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:28:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5714320C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JxThyOS5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c2c5OrdP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5714320C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FbUTsrEfhAUzlUgpay4Tz9bs0YCDTg7CGZWb22Qb2nM=; b=JxThyOS52T4smo
	noHeo1ficqPdnmJZVpAdGzT6mPwKe+Ezfcy7rFsKv+M3CEWE4nI656FSLdNdFUaGzelH7RXX+vzSi
	YzP1fPIxIA0dcZecdlYH6/uzG4CrMRXsQLjuhFpbjf/vp/Id4v08yJvz1+QB2FOHsxEnYq9a8ALOK
	PvZzg+HnvqgWUB7xxokTu5NA+ajYYw1cdC4TzXGnUyzSh4mIE1c+WlPXON4QqJTXh4kdAcs7OedP7
	4QvJEy+EpOsXdGK3HHo17qyHnkS1CyMC/cbUBL3DAcODXXrj7dZopkOX7pDlP+6bHBP1pe4yTIRWf
	BnRk1mORGj6prlFWgjcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwLMg-00018T-Hp; Wed, 20 Feb 2019 06:28:18 +0000
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwLMc-000186-JR
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 06:28:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44LVgEAATIbKJnQufGlMIk2Ckhe2kKBucKVkgJiJZ7E=;
 b=c2c5OrdPN1iU6STptkSIjm/UmdCkLkL2bX5zZLqSxufCCXLpjEvRel7PuqnC5+HueA5cZhIaglXAtvyvXk3e3n9GoZMZYY2+xdvKZVHwUEg7ieNuSmakhfYYRQK0f0D8HsTXyzVen9TA05CqDJEhnTEtRYMqtONX/tomYQNvoB0=
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com (52.135.168.141) by
 AM6PR04MB4213.eurprd04.prod.outlook.com (52.135.168.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.17; Wed, 20 Feb 2019 06:28:09 +0000
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08]) by AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08%5]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 06:28:09 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Zhi
 Li <lznuaa@gmail.com>
Subject: RE: [PATCH V4 4/4] MAINTAINERS: Added imx DDR performonitor driver
 maintainer information
Thread-Topic: [PATCH V4 4/4] MAINTAINERS: Added imx DDR performonitor driver
 maintainer information
Thread-Index: AQHUxVi6LS0M2yKB3U6Nb2ODmQ9SJ6XhR9eAgAAT7QCAAAjeAIAG2qOA
Date: Wed, 20 Feb 2019 06:28:09 +0000
Message-ID: <AM6PR04MB421565AFBF1ED068E02E1EBE807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
References: <1550253761-26841-1-git-send-email-Frank.Li@nxp.com>
 <1550253761-26841-4-git-send-email-Frank.Li@nxp.com>
 <20190215200141.pncrzp3oaoja2mnd@pengutronix.de>
 <CAHrpEqTexakw-OXjUt3nTdroPxv2YVjT-8VmZTUpDeF6e_dZMw@mail.gmail.com>
 <20190215214444.n2watl6k5ij6ptfs@pengutronix.de>
In-Reply-To: <20190215214444.n2watl6k5ij6ptfs@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80e7a2ee-a3ca-4e83-6eed-08d696fc952a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4213; 
x-ms-traffictypediagnostic: AM6PR04MB4213:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; AM6PR04MB4213;
 23:7v9zvu8KtOLFiWw9HD4h71sJUIw6Z8hoRwQf0yg?=
 =?iso-8859-1?Q?2NjyzzgS5/+QapT9KXbB8rFRit83g5Be6JO2jvfnJvwbw/POrkuhnFYg6h?=
 =?iso-8859-1?Q?KsNZ9OheKgagmbO00t9Cgs4NdVQC49wjTPv3v1BvTldn8Aft7iUHWtl5qo?=
 =?iso-8859-1?Q?msTLjekOaBgcvzqpkAXMBUxHeSw1Ah45B9LW4Qa1bVeJHyKcrqjuAtyIXT?=
 =?iso-8859-1?Q?uU1IGi4jxlz6OO6fK8/7w/oivWWJ5QUWKI2eaj3x1e57clWMFZIN6LJ7T5?=
 =?iso-8859-1?Q?t5WOyueYwTN+06xt9bMmaVfweEUQbOaIp/i5NDEp1YDQUe5VZ2OQ9mo9av?=
 =?iso-8859-1?Q?VvCHt4nK33tI2rFImmJtk1qkTl4XH3vkTFokF8rvNz7NbYxxhsFHmW8Bfi?=
 =?iso-8859-1?Q?nll2S2O30pSYFTYLnFLMKmu5KGaYjEAUdPx0L/lKPc7vB/jHhEN2eqBzI6?=
 =?iso-8859-1?Q?Y0DPoCpGnxAvB8bCFK+jAgSJqpwxbY+af1eNI4NybPK7HwyiG7UWcKCTZN?=
 =?iso-8859-1?Q?jYgCMfXQXuliZqG/5Hu5ufzvVzQQ/ePhokLv0sn7f1s4BbPFo1ui7nc5Hf?=
 =?iso-8859-1?Q?3PVVdkV4kydXWOMQkgg6M0mfwmHHna1TR9/UWknCAV4O48dISXLjuffQsc?=
 =?iso-8859-1?Q?Mavd67GZCnsh8+o4W3GLBSrEO+a51Pjb12rFep3S4gpxc+ganSmpSJAx+R?=
 =?iso-8859-1?Q?7D7MSrq7d60AaPBpbs6BCA6Z4cN9lXIVsqKET0iWSa5+udLkjpAF1SjYZV?=
 =?iso-8859-1?Q?PV7xCXjMhwNxeFPAS9TuZs9WZKdFn5nBIEwEBMlpiuiRZopLvfMDA1fL+H?=
 =?iso-8859-1?Q?RoL9hAVNl1Nu5ZuP+i2L+9YjSOQfukRTyKURIxsuyRpW7FbgkxzxELBKBW?=
 =?iso-8859-1?Q?j6ImV9ZYX70US8k7GyLu7aofTzaKQndtVwaFVfDcGygR5KfXB3skCkYuEo?=
 =?iso-8859-1?Q?yLdQY69Oo3949M+Cir+BKb+H34BZ1Ayns+XJPr/7EqWhCwF4tmR2lEQYff?=
 =?iso-8859-1?Q?gwMb8CtWqx9bD1QqjCCma1REIZVIjgAqNLqc78R/ZnKVVPXRnIKlEiqRWd?=
 =?iso-8859-1?Q?5Ck5sF2PvDaNZrmzb5lyAsfV167Xrcj/Z68SfLW4Ixp2APcTONhNeXZ7k+?=
 =?iso-8859-1?Q?g/DVQIklzVuxs102cRmg9uAOlUSsTwFuHocnU39qD26RMS/cyd8/R1IMvS?=
 =?iso-8859-1?Q?4F11Bmd5A2nh/Q3eycNkgYBbmmu3RSkJNA2+L4zF3K+8jsir8F0Z7LI+qH?=
 =?iso-8859-1?Q?r6LMV48KdlzdzDcJ2vpotxuRw8UvCGkYjLW80YdZgZWCb1MZoj5ZO0NnS4?=
 =?iso-8859-1?Q?BH/r+0DId2ojIPlMt23E2QSZcaKwlddhklJVrLyAVeRlfs0hTCq+o1JJI0?=
 =?iso-8859-1?Q?c1qo0abHfyqMx7D7lzqNXWim/17wT?=
x-microsoft-antispam-prvs: <AM6PR04MB4213EB36BFBA3502E3769084807D0@AM6PR04MB4213.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(346002)(396003)(136003)(366004)(376002)(199004)(189003)(55016002)(53936002)(4326008)(305945005)(25786009)(44832011)(186003)(316002)(110136005)(6246003)(26005)(68736007)(74316002)(6436002)(7416002)(71200400001)(8936002)(256004)(9686003)(6306002)(81166006)(3846002)(81156014)(6506007)(6116002)(229853002)(102836004)(7736002)(93886005)(53546011)(8676002)(2906002)(5660300002)(71190400001)(86362001)(66066001)(14454004)(446003)(486006)(76176011)(966005)(97736004)(33656002)(11346002)(105586002)(106356001)(7696005)(54906003)(476003)(99286004)(45080400002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4213;
 H:AM6PR04MB4215.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: heJIhBNgJFy7CsRFg6FJNBzWk3MiefRLKcrIOAlX/zH1nbIp+HIOainSFJes/r1AsBAlFtskchDYpunzm33MVeu1S8wwRZFEqeqFxuBD1px5ZswseP8j6gXL99up1sTUqPqPoXHIE/63+UuxNvulDUhZ/Dtkf/CTrCJ7+IRKvOLhFu5mucQYmvYwd+GiZ766rBF30q8mgolQHNNY+hQQsRa9S0Mb9N/IerVBKapwkeqfaiyBsJBW6i4fFoXnUOilwrj0HD5jq6iOGI3knqhEF8hpEzScSChhlmZAsbGZPo9GFmg4+DHYY8fIHB/16MED/aHx1LCCZJTeawRbIu1Yusy3ByrCoQ5muwv+B0tebDOrLBhXR1J5GRiVyDoTZL7ULgqKoSGZXxKo0zP0arZCQltUiAbhtYrklFlk7zNSAcA=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e7a2ee-a3ca-4e83-6eed-08d696fc952a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 06:28:09.6674 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4213
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_222814_643970_D2AD449C 
X-CRM114-Status: GOOD (  18.11  )
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
 "festevam@gmail.com" <festevam@gmail.com>, Frank Li <frank.li@nxp.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> From: Uwe Kleine-K=F6nig [mailto:u.kleine-koenig@pengutronix.de]
> Sent: Saturday, February 16, 2019 5:45 AM
> =

> On Fri, Feb 15, 2019 at 03:13:00PM -0600, Zhi Li wrote:
> > On Fri, Feb 15, 2019 at 2:01 PM Uwe Kleine-K=F6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > On Fri, Feb 15, 2019 at 06:03:16PM +0000, Frank Li wrote:
> > > > Add DDR perf counter driver maintainer information
> > > >
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > > No change from v1 to v4
> > > >
> > > >  MAINTAINERS | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS index 6ba068e..687be0f
> > > > 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -6163,6 +6163,13 @@ L:     linux-i2c@vger.kernel.org
> > > >  S:   Maintained
> > > >  F:   drivers/i2c/busses/i2c-cpm.c
> > > >
> > > > +FREESCALE IMX DDR Performance Monitor DRIVER
> > > > +M:   Frank Li <Frank.li@nxp.com>
> > > > +L:   linux-arm-kernel@lists.infradead.org
> > > > +S:   Maintained
> > > > +F:   drivers/perf/fsl_imx8_ddr_perf.c
> > > > +F:   Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
> > > > +
> > >
> > > With da8b7f0fb02b ("MAINTAINERS: add all files matching "imx" and "mx=
s"
> > > to the IMX entry") that sits currently in next the "ARM/FREESCALE
> > > IMX / MXC ARM ARCHITECTURE" also matches for these two files.
> > >
> > > Is this good here or not?
> >
> > Yes! what's do you means?
> > Needn't these entry because da8b7f0fb02b?
> =

> It's just that we then will have two entries that will match. In a tree w=
here I
> have both, this series and da8b7f0fb02b I see:
> =

> 	$ scripts/get_maintainer.pl -f drivers/perf/fsl_imx8_ddr_perf.c
> 	Frank Li <Frank.li@nxp.com> (maintainer:FREESCALE IMX DDR
> Performance Monitor DRIVER)
> 	Will Deacon <will.deacon@arm.com> (maintainer:ARM PMU PROFILING
> AND DEBUGGING)
> 	Mark Rutland <mark.rutland@arm.com> (maintainer:ARM PMU
> PROFILING AND DEBUGGING)
> 	Shawn Guo <shawnguo@kernel.org> (maintainer:ARM/FREESCALE IMX /
> MXC ARM ARCHITECTURE)
> 	Sascha Hauer <s.hauer@pengutronix.de> (maintainer:ARM/FREESCALE
> IMX / MXC ARM ARCHITECTURE)
> 	Pengutronix Kernel Team <kernel@pengutronix.de>
> (reviewer:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
> 	Fabio Estevam <fabio.estevam@nxp.com> (reviewer:ARM/FREESCALE IMX
> / MXC ARM ARCHITECTURE)
> 	NXP Linux Team <linux-imx@nxp.com> (reviewer:ARM/FREESCALE IMX /
> MXC ARM ARCHITECTURE)
> 	linux-arm-kernel@lists.infradead.org (open list:FREESCALE IMX DDR
> Performance Monitor DRIVER)
> 	linux-kernel@vger.kernel.org (open list)
> =

> That's not necessarily a bad thing, but something I want people to make a=
ware
> of.
> =


IMHO it's better to have a more specific maintainer in the MAINTAINER file
for a specific module.

Don't reply on the general pattern to filter all IMX patches to send ARCH
Maintainers to help review.

Regards
Dong Aisheng

> Best regards
> Uwe
> =

> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=3D02%7C01%7Caisheng.dong%40nxp.com%7C88
> f88bc0bd7e4812d00008d6938ed1af%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C636858638948593375&amp;sdata=3DKwEG5SXUsLCgUU9pg8
> hnZ9JQq4%2FPGHA6EFhmF%2Bcmlo8%3D&amp;reserved=3D0  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
