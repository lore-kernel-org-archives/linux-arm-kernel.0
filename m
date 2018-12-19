Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A05C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:28:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A6D20815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iYQvixU6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onelaird.onmicrosoft.com header.i=@onelaird.onmicrosoft.com header.b="8UfP5qn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A6D20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lairdtech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iPEN4v+wu0ttwrf+ndG5PP7HWTzIo5WwkPs8hkXrPH4=; b=iYQvixU66g9oOv
	ROhnhDEbspxanPDp7fIZZWkq6vockY8OSI6I1n8DbNSfGt6ERXJtNINM4frqs5qFVgglmhgA39O03
	E2+1+BIyJT50n8oJ95VIIm0Wmyqgx/048XoUdehJaazMUnbOc2skAZ5LsAygNoXLrNd2Ade+EE6IW
	gZWkHDeXGmNTMIfy/1fqcAUYjWIOAswcYZsV9k0iPFdgSAmnSZB+rqyBQEcTvvq/Er6KL2nHeXSmb
	xxc+v3K51INzaZkDslwsC17OxFiy3li3+o0r5aJ5cUZ0Xr63rNCOV44mDc1/aA4l60gT/6OVfI5dS
	Xtk1qRMdYc4H0dRn2X9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZa1R-0000kK-Jn; Wed, 19 Dec 2018 11:28:17 +0000
Received: from mail-bgr052100140106.outbound.protection.outlook.com
 ([52.100.140.106] helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZa1N-0000jB-4l; Wed, 19 Dec 2018 11:28:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onelaird.onmicrosoft.com; s=selector1-lairdtech-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpzJQh7ySLwKcZr502506yYn3QcLXpmTDP2/duoNYzM=;
 b=8UfP5qn/RWxxEtqvA6CuqAsAQmxaQTe5HlcNetg4cMB03FYvYGd1rk8VOafPEYAInBzPqdxktKlupK5+4hH1XYf7D9wz2Y2kNCE4dtuXkQaZfe7plNjOoK+j5gzVIrRsa87UKdj/+A1kURBhjx3dmZoIw0Nt8dRMMeM5HihsISg=
Received: from BY1PR02MB1114.namprd02.prod.outlook.com (10.162.108.140) by
 BY1PR02MB1211.namprd02.prod.outlook.com (10.162.108.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Wed, 19 Dec 2018 11:27:52 +0000
Received: from BY1PR02MB1114.namprd02.prod.outlook.com
 ([fe80::619e:d5fa:199e:c1b1]) by BY1PR02MB1114.namprd02.prod.outlook.com
 ([fe80::619e:d5fa:199e:c1b1%4]) with mapi id 15.20.1425.024; Wed, 19 Dec 2018
 11:27:52 +0000
From: Ben Whitten <Ben.Whitten@lairdtech.com>
To: =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>, Jian-Hong Pan
 <starnight@g.ncu.edu.tw>, Jiri Pirko <jiri@resnulli.us>
Subject: RE: [PATCH v5 5/6] net: maclorawan: Implement maclorawan class module
Thread-Topic: [PATCH v5 5/6] net: maclorawan: Implement maclorawan class module
Thread-Index: AQHUlSj0xlSlK7vGv0u4S31FjvDsaKWC9/6AgAGZNICAAEksgIABC9Dg
Date: Wed, 19 Dec 2018 11:27:52 +0000
Message-ID: <BY1PR02MB11148DBF420DCAC7CCDD8A79E7BE0@BY1PR02MB1114.namprd02.prod.outlook.com>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-6-starnight@g.ncu.edu.tw>
 <20181217140233.GG2096@nanopsycho>
 <CAC=mGziN5KrXPMAXoN_hhfQrtofCeyzTr4AjbbJLOoJ+p2+Nng@mail.gmail.com>
 <60ff6940-4bcc-750c-ad38-0a183375169f@suse.de>
In-Reply-To: <60ff6940-4bcc-750c-ad38-0a183375169f@suse.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Whitten@lairdtech.com; 
x-originating-ip: [109.174.151.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BY1PR02MB1211;
 7:vzGACmQUQDXgKsCIRZEQbvJvURMXnOub5bIOHmyQq1Zy80mfZSsxToe6OMisGFV+fEEL1u9keyCWZv2Ii728q2oEzAjV5Ii+z+Lce06VHJPM7bAd2HnosjtKPjZmozWGstcmVvUjl9tyN23qn6l0xg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e563e2a1-9862-48c7-e6f6-08d665a503a9
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BY1PR02MB1211; 
x-ms-traffictypediagnostic: BY1PR02MB1211:|BY1PR02MB1211:
x-microsoft-antispam-prvs: <BY1PR02MB121187E23CA79507D29E01DDE7BE0@BY1PR02MB1211.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231475)(944501520)(4982022)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:BY1PR02MB1211; BCL:0; PCL:0; RULEID:; SRVR:BY1PR02MB1211; 
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(396003)(366004)(136003)(39860400002)(376002)(346002)(189003)(199004)(99286004)(305945005)(14454004)(966005)(2171002)(6246003)(7736002)(6436002)(55016002)(81166006)(81156014)(8676002)(476003)(6306002)(33656002)(9686003)(5660300001)(478600001)(93886005)(229853002)(7416002)(486006)(8936002)(53936002)(2906002)(74316002)(4326008)(97736004)(102836004)(110136005)(54906003)(6506007)(68736007)(71190400001)(71200400001)(446003)(6116002)(316002)(3846002)(66066001)(11346002)(256004)(106356001)(26005)(7696005)(186003)(105586002)(72206003)(25786009)(14444005)(86362001)(76176011)(4432625001);
 DIR:OUT; SFP:1501; SCL:5; SRVR:BY1PR02MB1211;
 H:BY1PR02MB1114.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: lairdtech.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: G2f7jrYvr/lDH/lKp7WuCLtriz2Nuhji2rjqFYqvfiN3Ze999zBTbVbgutNGpbWmyTxVbyOenKBTW/y9anxn9HhdQ9iSucExaZyeFp8OtBE+NvEPeQj65wYN7grEUtI5fZLAJBBZrbqgLdL1beZDNas1dfUmpCWlhgHue2EYv6x8Sraewn6+DRvLZUSNSMriy93u7KZNdUCr9O1MNrKlCjFXcJ1VO7kp4OqAhlLQszbhwy3zWM7X+1UId3r8mAUlVYgG02HzTaZG5yftfGeo2RSfP63FuGdm9Eyc3Zpos9iIScTdOeWFkDN6t8NRNj9yiniMlaF+TEWgIkCbEc1nHf/JrJzTduOG6FaIQ/yWCpo+h7xXBkZTFJ22IPkHkafqG1pMiKXS1SWP9LhGwyqQx7aBm70mQmfyb1gHEFj7Z/fj7/wyhFRgLWnvegQjK1syBPChODL5D3/DkarTN37+7lv5RrBJ0jaXMUl0fKX/CNBkWS5pWxJUmRR118+wOdVp
spamdiagnosticoutput: 1:22
MIME-Version: 1.0
X-OriginatorOrg: lairdtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e563e2a1-9862-48c7-e6f6-08d665a503a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 11:27:52.3729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4d27a54-2db1-4088-a044-1a83c778ad1b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB1211
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_032813_271517_ECC14D93 
X-CRM114-Status: GOOD (  23.31  )
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
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-lpwan@lists.infradead.org" <linux-lpwan@lists.infradead.org>,
 Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>,
 linux-wpan - ML <linux-wpan@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> Am 18.12.18 um 15:27 schrieb Jian-Hong Pan:
> >> Sun, Dec 16, 2018 at 11:18:59AM CET, starnight@g.ncu.edu.tw wrote:
> >>> LoRaWAN defined by LoRa Alliance(TM) is the MAC layer over LoRa
> devices.
> >>>
> >>> This patch implements part of Class A end-devices SoftMAC defined in
> >>> LoRaWAN(TM) Specification Ver. 1.0.2:
> >>> 1. End-device receive slot timing
> >>> 2. Only single channel and single data rate for now
> >>> 3. Unconfirmed data up/down message types
> >>>
> >>> On the other side, it defines the basic interface and operation
> >>> functions for compatible LoRa device drivers.
> >>>
> >>> Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> [...]
> >>> net/maclorawan/Kconfig  |  14 +
> >>> net/maclorawan/Makefile |   2 +
> >>> net/maclorawan/mac.c    | 555
> ++++++++++++++++++++++++++++++++++++
> >>> net/maclorawan/main.c   | 606
> ++++++++++++++++++++++++++++++++++++++++
> >>> 4 files changed, 1177 insertions(+)
> >>> create mode 100644 net/maclorawan/Kconfig
> >>> create mode 100644 net/maclorawan/Makefile
> >>> create mode 100644 net/maclorawan/mac.c
> >>> create mode 100644 net/maclorawan/main.c
> >>
> >> I don't get it. In patch "Add LoRaWAN API declaration for LoRa devices"
> >> you add headers for "API" and here you implement functions. That is just
> >> weird. Does it mean you can have other implementations?
> >
> > LoRaWAN defined by LoRa Alliance(TM) is the MAC layer over LoRa PHY.
> > This part is soft-MAC as Andreas mentioned
> > http://lists.infradead.org/pipermail/linux-lpwan/2018-
> December/000010.html
> >
> >> Also, you don't really have any user of this API in the set. Please
> >> introduce at least 1 driver, preferably more (I see that Andreas has
> >> multiple ones in his patchset). You cannot push kernel infrastructure
> >> without kernel user.
> >
> > The soft-MAC is suitable for the LoRa chips' device drivers, like
> > sx1276/77/78/79, RFM95/96/97/98W ...
> > Still waiting for Andreas' sx1276 version 2 patch and more discussion.
> 
> sx1276 regmap conversion was pushed to my staging tree together with
> Ben's sx1301 final conversion last night, lightly tested.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-
> lora.git/log/?h=lora-next
> 
> TBD: rename to sx127x, implement regmap fields, only auto-detect reset
> when no OF node available (all low priority atm, patches welcome)
> 
> (and for sx1301 I still need to update my DT overlays with the new clk)
> 
> > For example, how to make PF_LORA and PF_LORAWAN like Ethernet,
> PF_INET
> > and PF_INET6 don't need separate devices either, both use eth0.
> > https://lkml.org/lkml/2018/8/3/266
> 
> Jiri, I am expecting the maclorawan driver to lower packets from
> ETH_P_LORAWAN to ETH_P_LORA in a generic way, so that any of the LoRa
> device drivers can benefit of it, with maclorawan using the LoRa netlink
> commands that the individual drivers implement.
> Not sure what if anything is missing for that in the current revision?
> Still dealing with the lower-level infrastructure and my test setup ...
> progressing slowly.
> 
> I'll probably need to queue the remaining generic LoRaWAN part 1/6 in my
> tree to resolve this circular dependency between Jian-Hong and me, so
> that only the soft-MAC implementation remains a separate patch series.
> The hard-MAC implementations will be on my plate mostly, as both SX1276
> and SX1301 need the soft-MAC.

On the SX1301 side of things, the ability to send messages as a LoRaWAN
node device is a niche use case, the majority if not all people will use the
concentrator card as the pass through gateway to the node.

In this mode of operation the parameters for transmission such as; frequency,
spreading factor / data rate, power, are given by a remote server and passed
in from the userspace application which received it.
Eventually in the kernel these need to be checked locally to ensure regulatory
compliance.
To that end I have experimented with framing, as CAN does, so that this
metadata can be provided on a write from userspace to the SX1301 driver.

Sounds like we need different protocols for framing within the protocol family.
Raw in the case of nodes and framed with metadata in the case of concentrator
cards, thoughts?
I will send my experiment RFC to the lpwan mailing list.

Regards,
Ben Whitten
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
