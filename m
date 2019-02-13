Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A449BC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:07:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F575222CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E6JoA4gS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="aWxUPH7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F575222CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=holA2eBQ2Oli13qkOqjN2UP+fNqLpLOFkd+aCXzz8v4=; b=E6JoA4gSDSEyE2
	SKH5m+SUs5ZgqlMm88u1MPIqkiN4xgvWfmJutrqXvZyoaCiDbd5oM8XVdHjELRPgIs+W/ZueUpteh
	a6+NNMLomRzS4QYrSyYrJZda1WH8Q6Zf2yjUb4JkWFGsncAdtCmfPA/Js+f5F6sH3sr12EO0ZZsvi
	KKfD5Xv3z5ua++tCo76TbOLlCuijgFX+cM1Xatj99Y75ZM8PhpPHCWPeF+kvtcdwiWbd9NUjJ+wi6
	l9/PoAH2fMP734VFnjLW8FvL/zWhbJXBEzx12B76kHJZ8pGt/seyzeStE9wSyaCTTSiaPGtQyErTt
	dsIsfzfCF0IS6LbHMlFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gti5H-000296-OT; Wed, 13 Feb 2019 00:07:27 +0000
Received: from mail-eopbgr820130.outbound.protection.outlook.com
 ([40.107.82.130] helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gti5D-00028K-G6
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 00:07:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0c2CcpKNZQ3vOHmbydgcLwLYlHcKbwhT/ivOh8IvbhQ=;
 b=aWxUPH7RNsjyqt9QLoB38njCJ7idFH35xngN+aXqAA+gmN9iwo2eHETR9O1qOVgd/w/vROgtL1hC0hf23W0rqKacHXlKuU5u3g4McTc4S3mbIhffcdv7J4uWVfFbB7WDBAY+vbY7sSmmF1839V6JEM5vH9tYlONq2u15bCeaCx4=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3673.namprd06.prod.outlook.com (10.167.236.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Wed, 13 Feb 2019 00:07:17 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1622.016; Wed, 13 Feb 2019
 00:07:17 +0000
From: Trent Piepho <tpiepho@impinj.com>
To: "festevam@gmail.com" <festevam@gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
Thread-Topic: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
Thread-Index: AQHUvyD/DkP33gVxsUSHwHJ5QzA1bqXU0h6AgAUATgCAATwLAIAAFl6AgAANW4CAAWRIAIAAS20A
Date: Wed, 13 Feb 2019 00:07:17 +0000
Message-ID: <1550016436.3075.127.camel@impinj.com>
References: <20190107132226.16216-1-stefan@agner.ch>
 <20190107132226.16216-2-stefan@agner.ch>
 <1549573243.3075.72.camel@impinj.com> <20190211012305.GA21496@dragon>
 <1549916056.3075.102.camel@impinj.com>
 <CAOMZO5BrTLyg7Q51tPcHbN8S2VmA4HAENOVzNhw+Yx7Nniz3Gg@mail.gmail.com>
 <1549923727.3075.103.camel@impinj.com>
 <CAOMZO5Ccovx2hMU0SmPm9ToZDNXOdLWkoQ8QT7EOhLocL7GAEQ@mail.gmail.com>
In-Reply-To: <CAOMZO5Ccovx2hMU0SmPm9ToZDNXOdLWkoQ8QT7EOhLocL7GAEQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e893883-a83b-4d58-df13-08d691473760
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR0601MB3673; 
x-ms-traffictypediagnostic: MWHPR0601MB3673:
x-microsoft-exchange-diagnostics: 1; MWHPR0601MB3673;
 20:Lp95K+5c0Cwv7fDsK1Wi4d17xqUTjrMbLaH1rE7uIS+xkeqRsNiN+AVemboKpybkl1S99pTtMw1km3o+9MesW3v+AvP0HE3+t22COzUELIJLlTS7gnjtEhvMMs5OStA1t520MQxiHaAMctAyVtsNgdRLpFXuzukzdi3C+2qB10U=
x-microsoft-antispam-prvs: <MWHPR0601MB367388510C9BC189107BD08ED3660@MWHPR0601MB3673.namprd06.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(346002)(376002)(396003)(39850400004)(199004)(189003)(51444003)(4326008)(6506007)(71190400001)(36756003)(14454004)(26005)(71200400001)(106356001)(53546011)(6512007)(1411001)(478600001)(66066001)(53936002)(6486002)(3846002)(486006)(14444005)(186003)(8936002)(6916009)(256004)(68736007)(5640700003)(6436002)(6116002)(6246003)(476003)(8676002)(229853002)(86362001)(81156014)(54906003)(103116003)(93886005)(1361003)(81166006)(305945005)(7416002)(102836004)(1730700003)(97736004)(105586002)(2616005)(2351001)(2906002)(11346002)(446003)(76176011)(99286004)(7736002)(2501003)(316002)(25786009)(4744005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR0601MB3673;
 H:MWHPR0601MB3708.namprd06.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TVWIYD+a3xth9w9cTyqHWN87rRFrG8HnelxuzR2KDDxAZDyibdrP4cLgB0NicBhR4TRdJBeOTWGi/Qw+qa4Wo0QQre+hHXkc9WyiZeQtoj5bCb/y9Fk8XDS/Jv9iEBTfOsA2awS+CY7ZVWq1Jksv6wYeDKsbri+eQH62/FE9axQ5US3TZ3GZS0jlNNhLLMfWrgw/2/3q6nOMxcjEH3mNWO1SkN91Cz/XqwCt5+YWsX2mKs8t/2Z7i3nZHAC8Gg+9rj5/u17TwnnU80zXQOGjQuOdt0qg0Dz8Swcdj4AfMkxB2UzhZDmBzlaSN0KGAsjSwcSD1v78nhVqDWnUv6geL+2XQixd1kDeYsEOxZmUfy0HE712c79ZVk+p46mFfH+PagiJ9jb2Vz95BtHWwqOPBq3EZUBlYlBDPlVAqHU6+F0=
Content-ID: <047FC06350572F43B74894761A4D517A@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e893883-a83b-4d58-df13-08d691473760
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 00:07:17.5813 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3673
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_160723_686873_BB23FDFC 
X-CRM114-Status: GOOD (  13.85  )
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

On Tue, 2019-02-12 at 17:37 -0200, Fabio Estevam wrote:
> On Mon, Feb 11, 2019 at 8:22 PM Trent Piepho <tpiepho@impinj.com>
> wrote:
> 
> > > Just trying to understand if the SDMA firmware plays a role on
> > > this
> > > behavior or not.
> > 
> > The ROM firmware only.
> 
> Does the problem also happen if the external SDMA firmware is used?
> Just trying to narrow it down.

Tried SDMA firmware 4.2.  Still broken.  No apparent change.

Get 4 cycle pause after each byte.

And crash while/after using DMA.  Clearly some sort of memory
corruption going on.  Fortunately, it's very reliable that using DMA
almost immediately causes a problem and this is easy to reproduce.  I
think that indicates it's either clobbers a lot of RAM, or consistently
manages to hit a very important location for kernel memory allocators.

I've got an idea of where that might be happening that I'm looking
into.

I think it's reasonable to add the dma attributes, but put a check in
the spi-imx driver to disable DMA on imx7d at least.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
