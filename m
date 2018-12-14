Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEA3C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:42:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C46C20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EoGbFbPY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HejSI7do"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C46C20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2XBAQwlRVbaD+ELH1pc/wEmsCsmEM1LqApZ/bBvn+U0=; b=EoGbFbPYFAUPk7
	p/rLou5uSwUafaHCcsFsMzCJoc3Pzq2+CrVlWyBzp21di/OlzQw2lh9LoHg7VV+CemKwvFHk6LcGY
	mVAk1+3fnUgTVueXdNc7ZRprxjNrsT/kqXR/Kgj9QJoq6Qw04KVSnekVMmwdid2gPsWtlebvI7z/i
	7zCz1ykzvfVBZ+eyxuEYJtx+8rdmCCv4IHN+4eq4iTRtBGg1Kl+k9VU37bQOszD+O0lmQ6cmk/jks
	qaObAWLDeV9KSV1lL+IrU1NK5en+3JQYTWm1HCYsMmexCXKbhQmXEQSMahSaO1A/tcmabgjh5Kmgb
	Azb/d24kAGsCcB+Xyelg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXmn6-0005MG-Tz; Fri, 14 Dec 2018 12:42:04 +0000
Received: from mail-eopbgr50081.outbound.protection.outlook.com ([40.107.5.81]
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXmn3-0005Kq-IZ
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 12:42:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkArKe1eQy3qyb/AckD2OuD50GGT/EFYhtp6kRmLjOA=;
 b=HejSI7do7R4x6Nwa2glKeZNBivTp3STrb44CROrUrk7q5y/HvW3p4M8+RDrr2hSye7L+QpaHsLWcBj5679DGHDBlEQiPskRrhbH8zS68u6CZcgtWmcHWVgNOG4wUEEwubSyWLX/fc2OxT7kYt1+Kj4wyTbbiy6ehf033CB9sWIg=
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com (52.134.65.28) by
 DB3PR0402MB3849.eurprd04.prod.outlook.com (52.134.71.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Fri, 14 Dec 2018 12:41:46 +0000
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb]) by DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb%5]) with mapi id 15.20.1425.016; Fri, 14 Dec 2018
 12:41:46 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 1/3] arm64: Remove CONFIG_SOC_IMX8MQ and use ARCH_MXC
 instead
Thread-Topic: [PATCH 1/3] arm64: Remove CONFIG_SOC_IMX8MQ and use ARCH_MXC
 instead
Thread-Index: AQHUkuY6nb3Z7jYWIkKip6q0zf3chKV8vGGAgAAEk4CAAK1RgIAAiOqAgAA3woA=
Date: Fri, 14 Dec 2018 12:41:46 +0000
Message-ID: <20181214124145.dbtx6z3itwepsuwb@fsr-ub1664-175>
References: <1544707047-4417-1-git-send-email-abel.vesa@nxp.com>
 <1544707047-4417-2-git-send-email-abel.vesa@nxp.com>
 <1544711727.3137.32.camel@pengutronix.de>
 <20181213145149.6hyyhi6hxdzvikl4@fsr-ub1664-175>
 <20181214011207.GB13243@dragon> <1544779331.3137.36.camel@pengutronix.de>
In-Reply-To: <1544779331.3137.36.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB3PR0402MB3849;
 6:XTcnWpOJt2Tpdk4wQ9WjEgGLxDHg5lSxBSrPrXbL3/MOX7gEmG2RM0rLZZkCmTIuIviK51FxVrEx1Qmr8f1RvxBJOGcR6j2L5mqaCY02nOAJBIQnaijBM3488fYIXe5+GbawGUdFEvfdpLvPgqZqk7HwBMlHTtdaX3faaN4PKXitijjsy4PJlqlaXmwJsloPBSUDokCW/7g1eww3H50eZ4QEBC8LTfmvaPwS8TlCLHIcKOFr5PlJTQVK79MBzwCdisj9OCCtGSauXlHUxpi80yoQew7Va4BCnUHRfXCgE/p3HRiihnqThk02wY3A+ohB9MZyCknN7Z6zhjjwi4xG/Lbb2GAxXYh2yPmKhPR+IgvdhoLpGoKICC0TKs5OJbwSdLIrzgIwrcxWsGtPdJ85paU7pnvJRshQUg96j4einCcEAx6tDF30TIQgCBO9qgvXwdOA9J7BosngXqiskBII4g==;
 5:njv9MtwKc3mTWGwAdOWu0Zby4YDouJo8G6pRPZOrakwkhSlkUYHtHZHlTpSIGBeW7Bgr4M1gyG+a9SvAvKwIfOhsiYTgCwZvz4YPZ/+Ii3lS/i80sKXotOKnI1a/j9OmmNLFcP+tpXJd67vLYWe75ib3nHmhQt/JVv/U4l3pGlE=;
 7:BIgjVZJVvwu+F+RgiyqpMM4xXC7oMLjgkkkaJm6SJ4uNgk9UqmXulDX9RQsJevmYAtmy9ZNE/jOKMlMTPRzKZGZetOjxSjEGqMcSUyTTIAzn6bKFqMBP38lCaYXePEkfBDotjlwu2Q+Wvka5Aa3OAg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 328ba95b-93fb-4ad9-dba6-08d661c1827f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3849; 
x-ms-traffictypediagnostic: DB3PR0402MB3849:
x-microsoft-antispam-prvs: <DB3PR0402MB3849CF4978A6140752EF3F27F6A10@DB3PR0402MB3849.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:DB3PR0402MB3849; BCL:0; PCL:0; RULEID:; SRVR:DB3PR0402MB3849; 
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(7916004)(396003)(136003)(346002)(39860400002)(366004)(376002)(189003)(199004)(8676002)(53546011)(81156014)(6506007)(316002)(81166006)(6116002)(476003)(4326008)(3846002)(54906003)(97736004)(68736007)(86362001)(6916009)(33716001)(102836004)(66066001)(478600001)(25786009)(229853002)(2906002)(105586002)(6436002)(305945005)(6486002)(6246003)(53936002)(71190400001)(7416002)(11346002)(446003)(1076002)(7736002)(71200400001)(33896004)(26005)(76176011)(256004)(14444005)(99286004)(44832011)(486006)(93886005)(186003)(6512007)(9686003)(106356001)(14454004)(8936002)(5660300001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3849;
 H:DB3PR0402MB3658.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: spEpKzbQNr9nrruo8T+dXlQZl46GJN3d3O01nnz/V/6BcQtKbd0p3Jr4T5um2/QZB6/sKjO3Hjwr687bfPqoVql9whpd7HhrvwBvtN7ehUO8E9rX4s1wHVxZ0RF/CgZCatgpf+dbMmdmchaQLkdTrHTDLHXIdbKfovTWDSl/DzyhlbpTzji9qWsxLJOOtrXxcY0LjI5ojIdTGTiDfL35+3x2DWSsZfJeEomuuNRB7Zjqbg4PbqakBw+XtN58ci/IRy607im+A1nHom5ZMPsZDg8w7W4TgiMl1BWlIEgPTZKwizvJ93BrQcfLXuHUNi7n
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <7004F42C0BF510469BA2C36CD6C42A7D@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 328ba95b-93fb-4ad9-dba6-08d661c1827f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 12:41:46.4442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3849
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_044201_607614_F898F626 
X-CRM114-Status: GOOD (  29.88  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Olof Johansson <olof@lixom.net>, Shawn Guo <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 18-12-14 10:22:11, Lucas Stach wrote:
> Hi Shawn,
> =

> Am Freitag, den 14.12.2018, 09:12 +0800 schrieb Shawn Guo:
> > On Thu, Dec 13, 2018 at 02:51:50PM +0000, Abel Vesa wrote:
> > ...
> > > > > diff --git a/arch/arm64/Kconfig.platforms
> > > > > b/arch/arm64/Kconfig.platforms
> > > > > index 7e1545a..318dbb9 100644
> > > > > --- a/arch/arm64/Kconfig.platforms
> > > > > +++ b/arch/arm64/Kconfig.platforms
> > > > > @@ -148,14 +148,6 @@ config ARCH_MXC
> > > > > > > > > =A0	=A0=A0This enables support for the ARMv8 based SoCs i=
n the
> > > > > > > > > =A0	=A0=A0NXP i.MX family.
> > > > > =A0
> > > > > -config SOC_IMX8MQ
> > > > > > > > > -	bool "i.MX8MQ support"
> > > > > > > > > -	depends on ARCH_MXC
> > > > > > > > > -	select ARM64_ERRATUM_843419
> > > > > > > > > -	select ARM64_ERRATUM_845719
> > > > > > > > > -	help
> > > > > > > > > -	=A0=A0This enables support for the i.MX8MQ SoC.
> > > > > -
> > > > =

> > > > NACK on this one. Having a single place where stuff that is absolut=
ely
> > > > critical for proper SoC operation can be selected is very useful and
> > > > avoids hard to debug issues due to slightly wrong configs in the lo=
ng
> > > > run.
> > > =

> > > As mentioned in the cover letter, please ignore this patch set entire=
ly.
> > > The ARCH_MXC is actually used on arm32 too, so it won't work.
> > > =

> > > I'm working on a patchset that will add the Kconfig into=A0
> > > drivers/clk/imx/ and in it will add CLK_IMX8MQ. That will
> > > fix the clock dependency since the CLK_IMX8MQ will depend on
> > > ARCH_MXC and ARM64. I believe the CLK_IMX8QXP will follow
> > > the same pattern.
> > > =

> > > As for the SOC_IMX8MQ, all the other vendors have one single
> > > config for all the arm64 platforms. TBH, to control every SoC
> > > independently it's a little bit of an overkill.
> > =

> > Lucas,
> > =

> > We are still waiting for further comments from Olof [1].=A0=A0But it so=
unds
> > like SoC specific option is not welcomed on ARM64.
> =

> While I personally would prefer to keep the SoC options, I see that we
> need to align with the judgment of the arm-soc maintainers.
> =

> But at the very least we should keep the select for vital system
> workarounds. They need to move to the arch Kconfig symbol in that case
> and might select stuff that isn't needed on each of the i.MX8 SoCs. But
> better enabling more workaround and drivers than necessary than having
> hard to debug system failures in the future.
> =


I get your point. But that seems to be an issue with the whole arm64 approa=
ch.
TBH, I believe now would be the perfect time to "get it right" on IMX since=
 the 8MQ
is the first one to get boot-up support upstream. It will be way much harder
to change this later when more arm64 IMX SoCs get upstreamed.

I would really love more opinions on this.

I have patches on stand-by that remove the SOC_IMX8MQ in all the subsystems=
 and
a patch for the defconfig update which I'll keep on holding on to until the=
re
is a agreement on this.

> Regards,
> Lucas
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
