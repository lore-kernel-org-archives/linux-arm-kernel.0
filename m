Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D85EC282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:22:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEE85218A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="haW3VgdI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="eaF5QIll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE85218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zUhuRaBXW/dRqbMp2SVEQmVBPrckuXk+I/nNm8EFEkg=; b=haW3VgdI8H/Zch
	W/WXqfE2xsRh27Mv30OpI3vug1hpQ/LShAw36GFI1oRCi6d0w2QeDwLsPhkCG3YNVxMggIYZ7AL34
	FjqcNhsPJR247O2HuzWZk69dMlVyKUhpi1Z2kgVCupFUTpo3/c4zHh+xTjtObsdoDksHNVT630BUf
	mFCPX5dhtgaPK+z+Pj6JcKXepF+INU+Afc2Mg/nfJXaZJ3w1xYSWoEitk2evRE0DW4ruQhkYXYEzJ
	TH8cq/NxjQFp7C7vq66NK/8xqLuGbZD1QknxVBDJPsKvqW4qlukoiNOlshR8GqxqByA3r1TI1JfxR
	ooDpK6vfurSAWEx/MxwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtJxw-0007ra-Pm; Mon, 11 Feb 2019 22:22:16 +0000
Received: from mail-eopbgr700133.outbound.protection.outlook.com
 ([40.107.70.133] helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtJxt-0007qk-0E
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 22:22:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ncr1vqWIcCFfDQ+JoQdZCBEJBWvJ2tL5QxoNNaIT9M=;
 b=eaF5QIlll+QcTblTBe6dEFNFla6x2AoRZW0ySDIbapbWRNMtW/W8YyHOXhrAusWKVNR1/sgLayrRMyPoeOx91Vm7WaAHanojL3Ff4nB5lecPJAteXzYdiuwqCl7e8zjfFxnl7CYJdip122KGR5dih+mC2yHMVShrbIJ5Krezwkw=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3659.namprd06.prod.outlook.com (10.167.236.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Mon, 11 Feb 2019 22:22:08 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 22:22:08 +0000
From: Trent Piepho <tpiepho@impinj.com>
To: "festevam@gmail.com" <festevam@gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
Thread-Topic: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
Thread-Index: AQHUvyD/DkP33gVxsUSHwHJ5QzA1bqXU0h6AgAUATgCAATwLAIAAFl6AgAANW4A=
Date: Mon, 11 Feb 2019 22:22:07 +0000
Message-ID: <1549923727.3075.103.camel@impinj.com>
References: <20190107132226.16216-1-stefan@agner.ch>
 <20190107132226.16216-2-stefan@agner.ch>
 <1549573243.3075.72.camel@impinj.com> <20190211012305.GA21496@dragon>
 <1549916056.3075.102.camel@impinj.com>
 <CAOMZO5BrTLyg7Q51tPcHbN8S2VmA4HAENOVzNhw+Yx7Nniz3Gg@mail.gmail.com>
In-Reply-To: <CAOMZO5BrTLyg7Q51tPcHbN8S2VmA4HAENOVzNhw+Yx7Nniz3Gg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25321201-83ba-45a4-2078-08d6906f5c24
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR0601MB3659; 
x-ms-traffictypediagnostic: MWHPR0601MB3659:
x-microsoft-exchange-diagnostics: 1; MWHPR0601MB3659;
 20:LPzvUFD2xloKfKA4RV8f54A7mRX4jQpcJ0oBvxgv4R8isrzmnT324Un7lbPUkmd75wKLwu4TMPAU8l5Ab1BYZAiTyKS7IvOfcwA7bTm+5zmzMg6IciW5zfyyWB9uqCmHelUcgbpPdVFYm7AgMylVDjdNsG78+p+Kj+HNXvVoDQ0=
x-microsoft-antispam-prvs: <MWHPR0601MB365907C6B2CEAE4B9992A4E9D3640@MWHPR0601MB3659.namprd06.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(376002)(346002)(396003)(39840400004)(199004)(189003)(316002)(102836004)(6246003)(66066001)(6486002)(229853002)(25786009)(7416002)(86362001)(53936002)(6116002)(2351001)(26005)(6506007)(97736004)(7736002)(53546011)(5640700003)(3846002)(305945005)(103116003)(106356001)(1411001)(6436002)(6512007)(105586002)(4326008)(11346002)(446003)(14454004)(8676002)(2501003)(2906002)(2616005)(476003)(99286004)(6916009)(256004)(1730700003)(71200400001)(36756003)(54906003)(1361003)(68736007)(81156014)(8936002)(478600001)(76176011)(486006)(186003)(93886005)(81166006)(71190400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR0601MB3659;
 H:MWHPR0601MB3708.namprd06.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: J8VNIZmvl1zEzz2jsqKMZaZHatTXKO98JKlZzms6s4iM2z9SKg4Trq3jnJpYT/1i4umI2h5m7IWw3zHmSUE6jzSvC+oTnHz+EFsVFQZ7EgSctcX1qY2iZIjz4Ay0mRvWBKeHGGYyz8rNustUt2FnfpZWqRvRve9KEm22UEUwOBi6omKCw1J8LOKsCh2IFKh91LeI044aWDLIPH6ojPiQa9rwm3tLT5+7YHM4WHWRWpdCqYrymsnwuaNWfQMiuO04Org9bwIBPVZeaZEwK0GH9JlaG0Z4TqhTltOr1cLLhSjsS5O+QRLpMjLdqC1VspOtXR+IjbLXRzXEAc3/pSpKWZhzxvglfjqzMyocWL7lvuWvzIFRoTarTcHMZWdag5G24nf0rglOFLn2GfSGxsgMLqDYwW/qwVpXL4sJMb21Z5g=
Content-ID: <C92860F19D57624E88286F1F866A4B77@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25321201-83ba-45a4-2078-08d6906f5c24
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 22:22:07.9613 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3659
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_142213_094295_431D2477 
X-CRM114-Status: GOOD (  15.39  )
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

On Mon, 2019-02-11 at 19:34 -0200, Fabio Estevam wrote:
> Hi Trent,
> 
> On Mon, Feb 11, 2019 at 6:44 PM Trent Piepho <tpiepho@impinj.com> wrote:
> 
> > I've had more time to test.
> > 
> > Without DMA, I can reload my FPGA hundreds of times and get days of
> > uptime using linux-next.
> > 
> > With DMA, loading is unreliable.  The higher the SPI speed, the less
> > reliable it is.  Unfortunately, it's hard to duplicate the problem with
> > a small amount of data, and with a large amount of data I can't examine
> > it in depth enough to determine if the problem is related to SPI bus
> > timing or IMX sDMA sending the wrong bytes to the spi controller.
> > 
> > Using DMA with SPI causes kernel panics.  Not always immediately, but
> > after using DMA it's a smaller of minutes before something crashes.
> > The backtraces are all over the place and don't usually point back into
> > SPI.  It does seem like they usually hit something has allocated or is
> > allocating DMA memory.
> 
> Did you test with an external SDMA firmware or with the ROM SDMA firmware?
> 
> Just trying to understand if the SDMA firmware plays a role on this
> behavior or not.

The ROM firmware only.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
