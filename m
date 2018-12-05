Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C489C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:35:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62B3D2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J5sDwPPe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="DgSOFV16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B3D2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rqRbLlhegmVT0CNW0Srlt+5urm8hySwedtUE4WWgI+g=; b=J5sDwPPeVNuYYH
	Y0LaOnsMsgqofnVFsjVAWyRwFdLXr8mHNDKripjTDDhx4/YecJhOVi7dk4uAprvHi7onM5dTON849
	uYQFb4BTiXXOZ+D82qgq8S25FOEynNx06rd5Lf52MIBUvfcvalOtnmtHibW7Rpwk7EB/HWOLfA1b2
	/tdPbH/Wt+N1RyOKwgKuLsw88K7u7e42tsmpsOusDmTOc4QrBZBHuN9C0SK3sOghRnsdTkq2tOWnW
	TzJ6tfsnR+ppHcKYVSVm/52/GM3rRpSrainA04919O/9r/eDJL3dX5600mh3eKDKbGSrw33dYQomo
	Dx3fHaweN9GYE97pDsjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUSeA-0003mk-DA; Wed, 05 Dec 2018 08:35:06 +0000
Received: from mail-dm3nam05on0600.outbound.protection.outlook.com
 ([2a01:111:f400:fe51::600]
 helo=NAM05-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUSe7-0003Au-MV
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 08:35:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2eQ2alvNAK5aaVvWtDYHhdQ2ao5jYMFez69konQaEk=;
 b=DgSOFV16ct9RJ7x8R66SBtSFY50biOzyOJaUm4WjmsYzjt8UI8y//oWU54rd91F0ChsbgMZhC8Bbi9yLUjcPeUpFwB/9GHrT/UGr7xPqHIo53Cb9LVchDoDQw7JSLL63yS6GqoiOdZTPXRiHL0QMk3fVfqcNYH9Lwe70CAmDu9U=
Received: from SN6PR03MB4398.namprd03.prod.outlook.com (20.177.255.219) by
 SN6PR03MB4576.namprd03.prod.outlook.com (20.178.7.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.21; Wed, 5 Dec 2018 08:34:47 +0000
Received: from SN6PR03MB4398.namprd03.prod.outlook.com
 ([fe80::7c2a:de77:a4ce:5ccc]) by SN6PR03MB4398.namprd03.prod.outlook.com
 ([fe80::7c2a:de77:a4ce:5ccc%3]) with mapi id 15.20.1404.019; Wed, 5 Dec 2018
 08:34:47 +0000
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: Moving ARM dts files
Thread-Topic: Moving ARM dts files
Thread-Index: AQHUjABim0nyCtiTgEG6mpQLHVSeW6VwLOcA//+hrICAAALBgA==
Date: Wed, 5 Dec 2018 08:34:47 +0000
Message-ID: <20181205162941.2d8bbfaf@xhacker.debian>
References: <20181204183649.GA5716@bogus>
 <20181205135726.70badac7@xhacker.debian>
 <CACRpkdYs_s9m=fUuOcfqcvP5BMXity5GH17RSMyvHzdZ9aFNzA@mail.gmail.com>
In-Reply-To: <CACRpkdYs_s9m=fUuOcfqcvP5BMXity5GH17RSMyvHzdZ9aFNzA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR03CA0018.apcprd03.prod.outlook.com
 (2603:1096:404:14::30) To SN6PR03MB4398.namprd03.prod.outlook.com
 (2603:10b6:805:fd::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; SN6PR03MB4576;
 6:GlYhJtqH+c7g8LxX74+yvCjbLU4agZhBC1b9RI21MBhzSeKI2+RV58dgxwMLadmVJCzOV0ExfOo6l33kDECFE+PerZcvBCqG2YXaASHtvxIfkynxbPaMeg3vL6e6/DNLuTlGgH0ftpQCtYsns03OI3l4Qp3Yc8aOQIE2y0IUdKkrzxRArF9/IlKRRJrtUi3vUMuCO33zkrHLXKnt++zyMAm6Kbw/3wC2xzZtUXPoW5evqub9in6SWv//KisG4HswHtBUjhDrvMkj0mhyy/uoYT1x4QUq6pUhVftEygepHjaWJ1Oa/42iwR6f8ghuitbe9hpcN98i8mFC/0Ed/MG93c8dBJC6WjuLsKFrenBQRsVVtisDCrjdURLDoY7YFvlhcb4noU2F+3ASt4hxo+Ujns9fK5xZn8zaTq/EA9/y7Pdpu4/HcBeO+wxwiQdY0JBGbLYx6wgnHVyINdaav9Vvjg==;
 5:0I9Q4Ni0TwdYuvEaAEM84lreyAvCpHQRD5ulFBx25Yq34N5uZ/tk0Dp/iCI7/PbOshhFArZyztbYrPUJaFNo/4ng3ItJhZOCAJ9bv0vJAZEdNyM0bugdod6viyBq/9+QNQab/flT322Bp7ex/lJXVJCrVvXImJhBUJL7NmNY99c=;
 7:HSNi0J/GoUTfmIyOcSVRCAI0lvF+dcGlVBn8uHa1XySfQL+1/47NdOIIZrCcgi1uymisyGC9hGDubMmyta9vDniGNfT1hEu+Q+rWcDkQ4w56qIWQNtr6C2qt2dC2Yw4dETFvIGJ4dAdVvMpcd/FJOA==
x-ms-office365-filtering-correlation-id: 7d145ecf-7681-4ef4-7e77-08d65a8c83ce
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:SN6PR03MB4576; 
x-ms-traffictypediagnostic: SN6PR03MB4576:
x-microsoft-antispam-prvs: <SN6PR03MB457695BFB369E92316003DC8EDA80@SN6PR03MB4576.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:SN6PR03MB4576; BCL:0; PCL:0; RULEID:; SRVR:SN6PR03MB4576; 
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(105586002)(4326008)(229853002)(106356001)(6916009)(97736004)(186003)(68736007)(66066001)(102836004)(26005)(54906003)(3480700005)(71200400001)(71190400001)(39060400002)(86362001)(8676002)(256004)(6246003)(7416002)(476003)(52116002)(25786009)(8936002)(5660300001)(14454004)(11346002)(6436002)(6486002)(316002)(9686003)(6512007)(76176011)(53546011)(386003)(6506007)(33896004)(1076002)(3846002)(6116002)(486006)(478600001)(2906002)(446003)(81166006)(305945005)(81156014)(7736002)(53936002)(99286004)(72206003)(39210200001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR03MB4576;
 H:SN6PR03MB4398.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CbDGtj36sP580Z6+e3ar7fmcdrUhrgxmccQZVnZa34r+eg/mqcRA/Yhi44pIsWgx3RpYlO6FeSOENSnusW3JPR+4r6GRwRlERLCJ3xWd8FIKB4mWBFuMWbAZX3o3+Dzr5pE2h/rrUzmHITdn1Po1O4nZdHNc/a5qQq2EGO4kWPlTrf4XHjZNfsTcDH6kV8bb6YytRuI0BRAmzrSdc5y0aak14hd+2+rOviB5iYJZEle1vFXAWXsa4yVG0aWa/H3z4j70RbwDjr4KV0Yyw2GU/37YkfWKVqB5srMuIdMCnovXD4+QF0nlYCcRN4C2fy8IxdeZ9vH5FqUvTXBPVqOQ9EXqGIMqtrOekmkaGrD6K2A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <7F9C8CF35699A94EB4DB7E493D7ADF58@namprd03.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d145ecf-7681-4ef4-7e77-08d65a8c83ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 08:34:47.7460 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4576
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_003503_800954_B8DE340B 
X-CRM114-Status: GOOD (  16.06  )
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
Cc: Andrew Lunn <andrew@lunn.ch>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 ext Tony Lindgren <tony@atomide.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Kevin Hilman <khilman@kernel.org>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Michal Simek <michal.simek@xilinx.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 arm-soc <arm@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andy Gross <andy.gross@linaro.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS" <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>,
 Simon Horman <horms@verge.net.au>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 =?iso-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 5 Dec 2018 09:19:49 +0100 Linus Walleij wrote:

> On Wed, Dec 5, 2018 at 7:02 AM Jisheng Zhang wrote:
> > Rob Herring wrote:  
> 
> > >     'armada' : 'marvell',
> > >     'berlin' : 'marvell',  
> >
> > Now, berlin SoC is synaptics' SoC ;)  
> 
> This illustrates perfectly the artificial nature of using vendor names
> as prefixes with DT properties, prefix names, directories etc.
> 
> Companies start out purporting to be some eternal entity and the
> next day they buy each other left and right and license their
> hardware IP to whoever wants it.
> 
> It actually makes much more sense to organize these files by
> the SoC family name, because that doesn't change when the
> SoC is sold to another company.

If the SoC is sold to another company, then

case1: The original SoC family is renamed to another family.

case2: Based on the original SoC, a newer SoC family comes out.

I'm not sure it's still fine to put the new or renamed SoCs' files into the
original SoC directory.

Another issue is: who will be the maintainer of new or renamed SoC family?

Thanks,
Jisheng



> 
> omap/* containing all OMAP platforms, msm/* for all Qualcomm
> SoCs etc. SoC names/codenames are at least eternal once they
> have been manufactured and we can keep them together
> no matter what vendor currently controls it.
> 
> However I think there was a fork in the road ages ago when
> someone or something decided to use vendor prefixes for
> DT properties leading to this situation that we can no longer
> back out of.
> 
> It has the side effect of splitting DTS files with the same SoC
> in two different folders marvell/* and synaptics/*
> it's a bit meh.
> 
> Yours,
> Linus Walleij


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
