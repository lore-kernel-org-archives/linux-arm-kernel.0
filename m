Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC989C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:19:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C9821741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aXQ0KCSw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onelaird.onmicrosoft.com header.i=@onelaird.onmicrosoft.com header.b="smkaDWkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C9821741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lairdtech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4CyEWk9lK2lUV3qqbkSmzSXPQFG9xXU+9t2M3sRGP7c=; b=aXQ0KCSwJHU47p
	rCgWRuytH2QebjCPnJ7HOaFxOnjlC5UC0CxrjvYCaD+PiT7Rm1NUIJ64Ij5B50LQ+j8PuGzq0z5C0
	v0PpetGF2DVmQPdnLXqcT6UovlZ5kC20TcmKMDpWp57VE8RHwpbVYfhygi+1VkwHxG+H7ptHtejk6
	dsWG01RTY0Hoi7GtD0idm80k/WLeC9t8qrhrqIcJRvt+WghTAvsCgHDMow9lqsuX99kj2lTikGvQx
	RK9MruBvrnpkPicx3Wnw1sytC26T2dNJfsvysMM1v+mHjdDagFAMY5bc52w0Lkmv0JUarCvbfJgjH
	8y2qVYK3BbKD6bHDfxlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZvQY-00075E-9K; Thu, 20 Dec 2018 10:19:38 +0000
Received: from mail-bgr052100128085.outbound.protection.outlook.com
 ([52.100.128.85] helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZvQR-0006yp-FY; Thu, 20 Dec 2018 10:19:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onelaird.onmicrosoft.com; s=selector1-lairdtech-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggFpBvM/n6fep8TC52/+g4MvxuwnAXhtAcfL6FsgAtE=;
 b=smkaDWkMwGjDiYRoL+xbv4R5Uc3jZFhIDhjeqCeGoz8sMd5Lpg35aOIkO7m3R/eb/SHs0aTfl7yoLlk1Kkqm4EaaXZ3iETY0/KHm6ufs7+lYyjX8iVMiEqCoQuKZ2dHYZFsA7bxBiehwjHmKgJD+nbD9QfqUOYeKZnPN4dw+jQg=
Received: from BY1PR02MB1114.namprd02.prod.outlook.com (10.162.108.140) by
 BY1PR02MB1193.namprd02.prod.outlook.com (10.162.108.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 20 Dec 2018 10:19:08 +0000
Received: from BY1PR02MB1114.namprd02.prod.outlook.com
 ([fe80::619e:d5fa:199e:c1b1]) by BY1PR02MB1114.namprd02.prod.outlook.com
 ([fe80::619e:d5fa:199e:c1b1%4]) with mapi id 15.20.1425.024; Thu, 20 Dec 2018
 10:19:07 +0000
From: Ben Whitten <Ben.Whitten@lairdtech.com>
To: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: RE: [PATCH v5 5/6] net: maclorawan: Implement maclorawan class module
Thread-Topic: [PATCH v5 5/6] net: maclorawan: Implement maclorawan class module
Thread-Index: AQHUlSj0xlSlK7vGv0u4S31FjvDsaKWC9/6AgAGZNICAAEksgIABC9DggABe0oCAASWggA==
Date: Thu, 20 Dec 2018 10:19:07 +0000
Message-ID: <BY1PR02MB1114B352A3A73F8478AE667DE7BF0@BY1PR02MB1114.namprd02.prod.outlook.com>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-6-starnight@g.ncu.edu.tw>
 <20181217140233.GG2096@nanopsycho>
 <CAC=mGziN5KrXPMAXoN_hhfQrtofCeyzTr4AjbbJLOoJ+p2+Nng@mail.gmail.com>
 <60ff6940-4bcc-750c-ad38-0a183375169f@suse.de>
 <BY1PR02MB11148DBF420DCAC7CCDD8A79E7BE0@BY1PR02MB1114.namprd02.prod.outlook.com>
 <CAC=mGzg4TGCaNUbq=_kFqmF5VNFR6rWHVBwO_5Fprt0u3m1O9g@mail.gmail.com>
In-Reply-To: <CAC=mGzg4TGCaNUbq=_kFqmF5VNFR6rWHVBwO_5Fprt0u3m1O9g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Whitten@lairdtech.com; 
x-originating-ip: [109.174.151.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BY1PR02MB1193;
 7:1qBqGKUFITVn/a9f6TdGrqgbYh6mnO7/C/WRv/EVUlnt/8mqGhX7lNbW43gzEvXWy+c5nHFTaIGzvaEu8k3ShBUgaVflTPe1BPVGnhjWOPkX2mT/2yUwRcn3vP4nsaQnYfD/Ub0jjJcmjepISvzR4g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f48e35db-27a1-493e-f10b-08d66664939b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BY1PR02MB1193; 
x-ms-traffictypediagnostic: BY1PR02MB1193:|BY1PR02MB1193:
x-microsoft-antispam-prvs: <BY1PR02MB1193BC035EDE5CDDA69DCF0BE7BF0@BY1PR02MB1193.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(4982022)(52105112)(10201501046)(3002001)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:BY1PR02MB1193; BCL:0; PCL:0; RULEID:; SRVR:BY1PR02MB1193; 
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(39860400002)(366004)(136003)(376002)(396003)(346002)(199004)(189003)(7416002)(305945005)(2906002)(9686003)(74316002)(6436002)(5660300001)(66066001)(68736007)(93886005)(8676002)(106356001)(71200400001)(446003)(71190400001)(478600001)(476003)(6506007)(229853002)(14454004)(6306002)(11346002)(486006)(72206003)(105586002)(186003)(86362001)(54906003)(26005)(53936002)(2171002)(4326008)(81156014)(316002)(55016002)(81166006)(256004)(76176011)(102836004)(33656002)(6116002)(97736004)(6246003)(3846002)(6916009)(966005)(8936002)(25786009)(14444005)(7736002)(7696005)(99286004)(4432625001);
 DIR:OUT; SFP:1501; SCL:5; SRVR:BY1PR02MB1193;
 H:BY1PR02MB1114.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: lairdtech.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1Jf6OXgVYPrb2gaZ9uR2y+9X84bYCf4qMydIvPCDmo/G8PbgUTq1TiuAuIWzONkq9+XQGghnYf5qet8MGR3yV6g9hE9xqlXU2Znq5XCYZuqx50x/hgbR//+oXpDgW77PUj80+nRwdkwPDA7NTQKZBYoVNqKMbi8rvdL5K/NoXbR42fpXVmwFSw3oL/hIMfluMT5hFnSQY5u/cdL4s1RpXdKoq5EjH8nggik5EuAZPdTggRz3m83o3Gh1+7KpTf2XOeehQbEbRJuPlR1xkxoY7CUTIm1tg8HsJGtWXJirFohQfpdeVyHCfZWrmmajE6Uhssf5cfL8vMjPMDUsIo7NRQQUjFo61nnCON+fQes1GMGDTbF9aecQuABVvfhZRfNJ0QLtj/RQkfbbceL2JukF6tEuJyGlaSJNz67rrt3OXkn4MqMEP53RCUOmHbiBKzsMDBhcNrO+TZIPbMNp6tUe6gSANqkDzGoRC9t5yTTXKygbDhQgYICdLUamuUgTTCSw
spamdiagnosticoutput: 1:22
MIME-Version: 1.0
X-OriginatorOrg: lairdtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f48e35db-27a1-493e-f10b-08d66664939b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 10:19:07.6862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4d27a54-2db1-4088-a044-1a83c778ad1b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB1193
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_021931_520322_A1EDC140 
X-CRM114-Status: GOOD (  32.78  )
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
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Pirko <jiri@resnulli.us>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-lpwan@lists.infradead.org" <linux-lpwan@lists.infradead.org>,
 "David S. Miller" <davem@davemloft.net>, Dollar Chen <dollar.chen@wtmec.com>,
 Ken Yu <ken.yu@rakwireless.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>,
 =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> > > Am 18.12.18 um 15:27 schrieb Jian-Hong Pan:
> > > >> Sun, Dec 16, 2018 at 11:18:59AM CET, starnight@g.ncu.edu.tw wrote:
> > > >>> LoRaWAN defined by LoRa Alliance(TM) is the MAC layer over LoRa
> > > devices.
> > > >>>
> > > >>> This patch implements part of Class A end-devices SoftMAC defined in
> > > >>> LoRaWAN(TM) Specification Ver. 1.0.2:
> > > >>> 1. End-device receive slot timing
> > > >>> 2. Only single channel and single data rate for now
> > > >>> 3. Unconfirmed data up/down message types
> > > >>>
> > > >>> On the other side, it defines the basic interface and operation
> > > >>> functions for compatible LoRa device drivers.
> > > >>>
> > > >>> Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> > > [...]
> > > >>> net/maclorawan/Kconfig  |  14 +
> > > >>> net/maclorawan/Makefile |   2 +
> > > >>> net/maclorawan/mac.c    | 555
> > > ++++++++++++++++++++++++++++++++++++
> > > >>> net/maclorawan/main.c   | 606
> > > ++++++++++++++++++++++++++++++++++++++++
> > > >>> 4 files changed, 1177 insertions(+)
> > > >>> create mode 100644 net/maclorawan/Kconfig
> > > >>> create mode 100644 net/maclorawan/Makefile
> > > >>> create mode 100644 net/maclorawan/mac.c
> > > >>> create mode 100644 net/maclorawan/main.c
> > > >>
> > > >> I don't get it. In patch "Add LoRaWAN API declaration for LoRa devices"
> > > >> you add headers for "API" and here you implement functions. That is
> just
> > > >> weird. Does it mean you can have other implementations?
> > > >
> > > > LoRaWAN defined by LoRa Alliance(TM) is the MAC layer over LoRa PHY.
> > > > This part is soft-MAC as Andreas mentioned
> > > > http://lists.infradead.org/pipermail/linux-lpwan/2018-
> > > December/000010.html
> > > >
> > > >> Also, you don't really have any user of this API in the set. Please
> > > >> introduce at least 1 driver, preferably more (I see that Andreas has
> > > >> multiple ones in his patchset). You cannot push kernel infrastructure
> > > >> without kernel user.
> > > >
> > > > The soft-MAC is suitable for the LoRa chips' device drivers, like
> > > > sx1276/77/78/79, RFM95/96/97/98W ...
> > > > Still waiting for Andreas' sx1276 version 2 patch and more discussion.
> > >
> > > sx1276 regmap conversion was pushed to my staging tree together with
> > > Ben's sx1301 final conversion last night, lightly tested.
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-
> > > lora.git/log/?h=lora-next
> > >
> > > TBD: rename to sx127x, implement regmap fields, only auto-detect reset
> > > when no OF node available (all low priority atm, patches welcome)
> > >
> > > (and for sx1301 I still need to update my DT overlays with the new clk)
> > >
> > > > For example, how to make PF_LORA and PF_LORAWAN like Ethernet,
> > > PF_INET
> > > > and PF_INET6 don't need separate devices either, both use eth0.
> > > > https://lkml.org/lkml/2018/8/3/266
> > >
> > > Jiri, I am expecting the maclorawan driver to lower packets from
> > > ETH_P_LORAWAN to ETH_P_LORA in a generic way, so that any of the LoRa
> > > device drivers can benefit of it, with maclorawan using the LoRa netlink
> > > commands that the individual drivers implement.
> > > Not sure what if anything is missing for that in the current revision?
> > > Still dealing with the lower-level infrastructure and my test setup ...
> > > progressing slowly.
> > >
> > > I'll probably need to queue the remaining generic LoRaWAN part 1/6 in my
> > > tree to resolve this circular dependency between Jian-Hong and me, so
> > > that only the soft-MAC implementation remains a separate patch series.
> > > The hard-MAC implementations will be on my plate mostly, as both SX1276
> > > and SX1301 need the soft-MAC.
> >
> > On the SX1301 side of things, the ability to send messages as a LoRaWAN
> > node device is a niche use case, the majority if not all people will use the
> > concentrator card as the pass through gateway to the node.
> >
> > In this mode of operation the parameters for transmission such as;
> frequency,
> > spreading factor / data rate, power, are given by a remote server and passed
> > in from the userspace application which received it.
> > Eventually in the kernel these need to be checked locally to ensure
> regulatory
> > compliance.
> > To that end I have experimented with framing, as CAN does, so that this
> > metadata can be provided on a write from userspace to the SX1301 driver.
> >
> > Sounds like we need different protocols for framing within the protocol
> family.
> > Raw in the case of nodes and framed with metadata in the case of
> concentrator
> > cards, thoughts?
> 
> Yes, I have thought the roles of node and gateway.  They may have
> different skb passing paths.
> As you mentioned, many things of the gateway is controlled by the
> remote server.  So, I only implement the path for nodes right now.
> Maybe, we can have a role flag: node, gateway which can be assigned by
> some way.  Then, the skb can be decode, checked and passed according
> to the role flag.  And module also checks the integrity (MIC, length
> ...) and filter out the bad skb before sends to next stop.

As IP have IPPROTO_TCP, IPPROTO_UDP, etc maybe we can have
LORA_PROTO_MODULE, LORA_PROTO_GATEWAY which dictates the
pathway and skb format.

> > I will send my experiment RFC to the lpwan mailing list.
> 
> Or you can send the RFC first.  Then we can have the skb passing path
> for gateway and figure out how to put them together.
> 
> Does this sound reasonable?

Sent, it's being held at mailing list for moderator approval but should be in
your inboxes currently.

Regards,
Ben
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
