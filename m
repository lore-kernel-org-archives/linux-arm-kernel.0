Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A0FC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:10:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A52222BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yq/w7HN3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="qEaR6Ok6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A52222BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aaSpZozZ0yoHUFJdsMiEDAmS2DfS1IVehWMd/pCP+A0=; b=Yq/w7HN3mE6Zvo
	nYDlbM4OAZjPTFITtvDPyJueA42PnKPK1/xON7k3kGzqlNeL5tP6fdU26RzRESMpwymm+jl+LJNlc
	cqpYP9MEaEQ8VcTyh7jRrjGMBcsuvTgrHb2lcBujGKNYo34M7andQYGLOJAx3TkQauANpiIgfPKPW
	48pvOEY8LMM9goDBLHb4FsAI3gami5DICI1zkQl8/1ESJkyvjQf9KPX+C2e/EBR/UhI79DAEbbElv
	TgXgk0RMML3u1MaO0R+KjjMYsu5M7SCe4f3R24BmhD/dSWtpbRBALSUOVB1BZxpb0CYNJJ97zz5J/
	GE8gK0yXKtIpVI4nKWCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtj40-0007Of-8l; Wed, 13 Feb 2019 01:10:12 +0000
Received: from mail-co1nam03on072f.outbound.protection.outlook.com
 ([2a01:111:f400:fe48::72f]
 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtj3x-0006fP-8a
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 01:10:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i32Yy8wwpjGbFb49EpXLjNaiJN1jwLdA1/CHRtDedrU=;
 b=qEaR6Ok66f8tIleRL5AZ5C40Q1f/unqhPto3hCuN6+kd7LVdQ47goS7kRM/cUM9GSrh22lZE+0OiUwyTvD3VQH9UZIggcvjzEdPJH9sKCE+qvnkgcEcHRnEmFyim+sKaoqfR3eNlQPAKWBeEU4A0sBEoLKjrg9suAp0BvgZEF/w=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3642.namprd06.prod.outlook.com (10.167.236.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 01:10:03 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1622.016; Wed, 13 Feb 2019
 01:10:03 +0000
From: Trent Piepho <tpiepho@impinj.com>
To: "festevam@gmail.com" <festevam@gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
Thread-Topic: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
Thread-Index: AQHUvyD/DkP33gVxsUSHwHJ5QzA1bqXU0h6AgAUATgCAATwLAIAAFl6AgAANW4CAAWRIAIAAS20AgAAOAYCAAAOJAA==
Date: Wed, 13 Feb 2019 01:10:03 +0000
Message-ID: <1550020202.3075.135.camel@impinj.com>
References: <20190107132226.16216-1-stefan@agner.ch>
 <20190107132226.16216-2-stefan@agner.ch>
 <1549573243.3075.72.camel@impinj.com> <20190211012305.GA21496@dragon>
 <1549916056.3075.102.camel@impinj.com>
 <CAOMZO5BrTLyg7Q51tPcHbN8S2VmA4HAENOVzNhw+Yx7Nniz3Gg@mail.gmail.com>
 <1549923727.3075.103.camel@impinj.com>
 <CAOMZO5Ccovx2hMU0SmPm9ToZDNXOdLWkoQ8QT7EOhLocL7GAEQ@mail.gmail.com>
 <1550016436.3075.127.camel@impinj.com>
 <CAOMZO5Ctp_p=j1G1DCaPxsyjWTK8dtKR9Ov59XGxYdiqE+1c2g@mail.gmail.com>
In-Reply-To: <CAOMZO5Ctp_p=j1G1DCaPxsyjWTK8dtKR9Ov59XGxYdiqE+1c2g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9c90075-90fd-42b0-fcfd-08d6914ffbce
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR0601MB3642; 
x-ms-traffictypediagnostic: MWHPR0601MB3642:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1; MWHPR0601MB3642;
 20:EIAsZwRgNrR2imKiSdc48optt7LjQXiuCFpjUHbBaS6npMQ4EPciWuKYp54fYhPvHmpPxgU1LCjkM/t6BVmzj0Yajr0nx3Q0XXVJf+Ut0Yg6DbdYhfhBcUB91bnzhRI556Y1zhPG1WwhcPC3Cpf6cQ2Ukn1VvVRbNZFZyR1VlzA=
x-microsoft-antispam-prvs: <MWHPR0601MB3642B1DA53B751B7323671FAD3660@MWHPR0601MB3642.namprd06.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(366004)(136003)(376002)(346002)(199004)(189003)(54094003)(105586002)(1411001)(81166006)(478600001)(6436002)(966005)(5640700003)(106356001)(1730700003)(2351001)(476003)(14454004)(8676002)(53936002)(81156014)(7416002)(229853002)(6486002)(1361003)(2616005)(68736007)(256004)(14444005)(93886005)(2501003)(8936002)(71200400001)(71190400001)(6512007)(6306002)(103116003)(99286004)(2906002)(26005)(36756003)(102836004)(486006)(97736004)(25786009)(446003)(4326008)(316002)(66066001)(186003)(305945005)(7736002)(11346002)(86362001)(3846002)(53546011)(6506007)(6916009)(6116002)(76176011)(6246003)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR0601MB3642;
 H:MWHPR0601MB3708.namprd06.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vpR2qVWUUQiZ6QPDczMXtxLV6kJnc9jNvhK9QHgkmMNoT0pU2TOdoCMiyFEAf8Z80JA/ozR9F9TtAANyXsCvWtqyTPyUDRTgzevPmaPmg/K7JItSQxGgXIgWwQ3QnSx0yRjKdKlqgDWwrGGup04TMqPkl+lg1Yc49ru1K0YqsA8rS0qTUVdNqhcsRi7SG2/ai/Dk9/kLTOk3I/2/aRKsrBsT0rEVWzYlaXiYc6VUBkRPl1hP4tKM/gzbu3+3LworcdmQQ6/9n2rL+YR5+93ajs4ngBIDP4AonTZuh6cFrpEYOX1Nw/b2Pq1EsQ2p/KdY92lvmIj2SA0cHbohWwnETJ/4uB8U/leGd/jXlnmCqFJf/dKK98btJGVeQk7F9GjinGM7m5GR9ZAY/IWk3NtYeNDVNNELS4conKf3RXAh2y4=
Content-ID: <621C6364E9CB144487460B453BFA5A37@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c90075-90fd-42b0-fcfd-08d6914ffbce
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 01:10:03.1803 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3642
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_171009_355585_85DF2E5A 
X-CRM114-Status: GOOD (  19.26  )
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
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stefan@agner.ch" <stefan@agner.ch>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-imx@nxp.com" <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-02-12 at 22:57 -0200, Fabio Estevam wrote:
> On Tue, Feb 12, 2019 at 10:07 PM Trent Piepho <tpiepho@impinj.com>
> wrote:
> 
> > Tried SDMA firmware 4.2.  Still broken.  No apparent change.
> > 
> > Get 4 cycle pause after each byte.
> > 
> > And crash while/after using DMA.  Clearly some sort of memory
> > corruption going on.  Fortunately, it's very reliable that using
> > DMA
> > almost immediately causes a problem and this is easy to
> > reproduce.  I
> > think that indicates it's either clobbers a lot of RAM, or
> > consistently
> > manages to hit a very important location for kernel memory
> > allocators.
> > 
> > I've got an idea of where that might be happening that I'm looking
> > into.
> 
> Ok, thanks for investigating this issue.
> 
> > 
> > I think it's reasonable to add the dma attributes, but put a check
> > in
> > the spi-imx driver to disable DMA on imx7d at least.
> 
> Something like this?
http://dark-code.bulix.org/urfoh8-580174

Something like that.  I thought a printk on probe, that DMA was
disabled, would be nice so no one beats their head against the wall
trying to figure out why DMA isn't being used.

But I think I've found the issue and tracked it to bug in the spi core.
  I'll send a patch shortly.  It should affect anything that uses DMA,
with a spi master that requires RX and/or TX buffers, and a spi
transfer that does not provide the require buffer(s).  In my case, spi-
imx requires an RX buffer but I am doing TX only DMA.  The spi core
takes care of this, but I think there is a race in the cleanup of the
dummy RX DMA buffer.

This appears to clobber something relating to DMA buffer allocation and
the kernel starts to allocate bogus DMA buffer addresses, and the SPI
controller happily DMAs all over memory.  I wonder if that could be
somehow exploited to read/write arbitrary memory via SPI DMA?
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
