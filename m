Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB95C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:14:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8CE92084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KLwqXzs9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="sszVRgAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8CE92084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ENSEb962RAxswCiPKEKwoY+zyc+EjCenUEJ8z7UWNtE=; b=KLwqXzs93fkcyc
	4w/z45ovjelwqhQlSxjykPJZKXv4UW6vEcuPcCmBuT2L2STtSPr9F8KEMzLZ5r5NeWnQ0Ryq2u6Uh
	CqpSG1tT39SET34K6TdBF//YZbpET+5hCkOW2OycCEatR6PLeQ8g2ZC4IxVRCY5i9us9A3+a6jEDn
	DRCiO/2mo8VtOaYxRmT6r8SOympXo8IVbdtEGOxvTnqEascpHJL9VhTdB+Y5/9LFg1DQfa3w/efkx
	oKC7Y7RrEReQIHKRG0kxDwuMSZsQvM1vPIqJAtJJ1mpnrLu0d4emKNROqkP1aVKjInvIyrZJpGTCX
	mfau6BnhUwaOohHNroJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUSJj-0003nV-Sb; Wed, 05 Dec 2018 08:13:59 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUSJe-0003mb-JO
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 08:13:57 +0000
X-IronPort-AV: E=Sophos;i="5.56,317,1539673200"; d="scan'208";a="21137930"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 05 Dec 2018 01:13:41 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 5 Dec 2018 01:13:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pmz9VZ4IqK7FTuZL7CMHFAgozc0zx9I5PIJsJuGRJ7I=;
 b=sszVRgAlOfO//cxDAaKvdaKzdT8QEhIKrN0Sz1tUOMvTw8u4fffKFj9YbUtxusKYd8fAyOWM/sun3z2FJrR04cD4T5vjL4NaN+UxgcG+7BCtqm0cK5OsTSAh73E4LdV1og6lMMd872qqb+1vaqiNWdDsDD+ZLC7KTTBKtoXvVrg=
Received: from DM5PR11MB1658.namprd11.prod.outlook.com (10.172.38.17) by
 DM5PR11MB1818.namprd11.prod.outlook.com (10.175.92.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Wed, 5 Dec 2018 08:13:37 +0000
Received: from DM5PR11MB1658.namprd11.prod.outlook.com
 ([fe80::9e3:1208:627a:cb5f]) by DM5PR11MB1658.namprd11.prod.outlook.com
 ([fe80::9e3:1208:627a:cb5f%2]) with mapi id 15.20.1404.019; Wed, 5 Dec 2018
 08:13:37 +0000
From: <Nicolas.Ferre@microchip.com>
To: <robh@kernel.org>, <arm@kernel.org>
Subject: Re: Moving ARM dts files
Thread-Topic: Moving ARM dts files
Thread-Index: AQHUjHJmsmbKYHR04EunHZxWzmv9nQ==
Date: Wed, 5 Dec 2018 08:13:37 +0000
Message-ID: <392c9399-83c8-a74a-a849-748225802851@microchip.com>
References: <20181204183649.GA5716@bogus>
In-Reply-To: <20181204183649.GA5716@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWXP265CA0091.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:39::31) To DM5PR11MB1658.namprd11.prod.outlook.com
 (2603:10b6:4:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR11MB1818;
 6:8oZGgueQL5mza4XV0Sqk97cc8F3ZKuBH09nUzxt0yppsrCjH69uM07gJbACP1RIAodNcXXCYI7Xkhw0EgIgqVEk9y0hvWyjFb6YLqvc4Y3oWjaMU8Od4zMuwl20xhOIFmpnY3TfoNl+F6yIIJaBbd7SSTOBdZBPfjkgZkHbqoHrMbav4odVX+6op9FuZPcv7naGDOLYQQoxfnj0OcXBNRlQeiAunkOgWLvokuhPOI/wBhS87R4Dxhv6uaywWKfsafhBVT53KqvFSQ9UuhVmCeKwnefMVzP6Ok1sXIpGsKyRR2UdArxeaTz+PVCObtupeq7rNeVFnn2xI7VQBPvlzd7juEqSQ3g1jpcN+4owq1w+EgDgdePQN3EQ7X3lqlAB1zcmtZNzkOVvsbDmtkGtVZdpQxcJsJwdZZYWEvadWiFeJavvFHdRJ3Usr7+5YkhQsl/vnqohvPe7/RSrW3epp8Q==;
 5:CmVUrHJUfkKl+ix5mGXFWAkpzLH5819OZdzwJwgJ1BakfBYoFNr+ujdoXQbk/mGpne/edlZeAkKVlZgQst9hMmkAuYU7mPJVCIXiQeV9sJmJRMPz50lTc59TbArSQMGeqqeIbO3oKYkfY9Job6FF6nOE2hBKWVt6SsRLiOIlZss=;
 7:o+QT5UqxAI+l8wQSNQr6jpcoZ0g6f4XfSHPE+E2b2AAtAYsZdEC94d/fVSm8ffwLS9XV2KQRxYGqvtgcBIZ7kEAQ55YlE4kAObE+t5HWNF/wiJr2KvhHS4sik8/OPNBIzwOC2VkCpkJLangMm1p/Eg==
x-ms-office365-filtering-correlation-id: f65f0c3a-b448-474f-874b-08d65a898efa
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DM5PR11MB1818; 
x-ms-traffictypediagnostic: DM5PR11MB1818:
x-microsoft-antispam-prvs: <DM5PR11MB1818E0959F8B78EB39FF50C0E0A80@DM5PR11MB1818.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:DM5PR11MB1818; BCL:0; PCL:0; RULEID:; SRVR:DM5PR11MB1818; 
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(39860400002)(346002)(366004)(136003)(396003)(189003)(199004)(229853002)(316002)(6486002)(6436002)(2501003)(186003)(305945005)(7736002)(68736007)(110136005)(54906003)(31696002)(14454004)(256004)(14444005)(86362001)(71200400001)(71190400001)(26005)(25786009)(39060400002)(4326008)(97736004)(5660300001)(3480700005)(81166006)(81156014)(8676002)(8936002)(6512007)(53936002)(107886003)(6246003)(36756003)(52116002)(72206003)(478600001)(386003)(6506007)(53546011)(102836004)(76176011)(66066001)(7416002)(99286004)(31686004)(2906002)(106356001)(105586002)(446003)(2616005)(11346002)(476003)(486006)(3846002)(6116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR11MB1818;
 H:DM5PR11MB1658.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JI4Y5DlhX74hc2dC7ht5ctocg/U2mw4w/rpNby2aAx3TRBZ+rxsttJQZMw3TQ6Jx199cFfZBIhGV9E1AcHQ7qUt7Jz4rArgB3XgZ+k7wn8fKM3IeV18r2zTJhwP8plwRvpLKaOwwrEgX5zg09aXjf19nIipJeFVJ4lG55Ml8RySK3k9fLjEqy6mH//wZsvz2PyeY3to5gMJgUi2VlJoYP5ffw+roPsi90ftW7h1bwqfW1Vs1PrGQlbvAKv1EWyHF85Wqq/y9yDcKHQFgBR6m31H9w+XCP+wGVVEMn2JwJGuWtKEPnLGMRUmGdSXx3ekHeU+cTlOzDXx/hngvnf2gBuJnLHATEMhDD49wrypkLCc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <860E0E98F3268844A88BC71619279FEA@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f65f0c3a-b448-474f-874b-08d65a898efa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 08:13:37.8609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1818
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_001354_743763_7252F09D 
X-CRM114-Status: GOOD (  17.36  )
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
Cc: andrew@lunn.ch, alexandre.belloni@bootlin.com, tony@atomide.com,
 linus.walleij@linaro.org, liviu.dudau@arm.com, yamada.masahiro@socionext.com,
 thierry.reding@gmail.com, f.fainelli@gmail.com, khilman@kernel.org,
 gregory.clement@bootlin.com, michal.simek@xilinx.com, krzk@kernel.org,
 Ludovic.Desroches@microchip.com, joel@jms.id.au, andy.gross@linaro.org,
 devicetree@vger.kernel.org, jason@lakedaemon.net, horms@verge.net.au,
 linux-arm-kernel@lists.infradead.org, mcoquelin.stm32@gmail.com,
 shawnguo@kernel.org, afaerber@suse.de, daniel@zonque.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 04/12/2018 at 19:36, Rob Herring wrote:
> Olof, Arnd,
> 
> I've put together a script to move the dts files and update the
> makefiles. It doesn't handle files not following a common prefix which
> isn't many and some includes within the dts files will need some fixups
> by hand.
> 
> MAINTAINERS will also need updating.
> 
> A few questions:
> 
> Do we want to move absolutely everything to subdirs? There's quite a
> few platforms with only 1-2 platforms. I haven't added these to the
> list yet, but can.
> 
> Do any vendors need another level of directories? davinci, omap, nspire,
> etc. for TI for example.
> 
> What to do with armv7m.dtsi? I guess it should remain and we just fixup
> the include. There may be a few other cross vendor things.
> 
> 
> Sub-arch maintainers,
> 'vendor_map' below is the mapping of file prefix to new subdirectory
> (the SoC vendor prefix). Please comment if there are any issues.

It'll certainly break some of our scripts (CI, building scripts, overlay 
makefiles, etc.). We already experienced it when adding the "dts" 
directory. But if it's needed...

> 8<-----------------------------------------------------------
> #!/usr/bin/env python3
> 
> import os
> import re
> from git import Git
> import glob
> 
> vendor_map = {

[..]

>      'integ' : 'arm',
>      've' : 'arm',
>      'aspeed' : 'aspeed',
>      'at91' : 'atmel',

As it's a new directory, what about creating a "microchip" one as it's 
our vendor's name now.

>      'sama' : 'atmel',

If desired, you can extend to sama5d for the current files.

Adding the entry 'sam9' : "microchip", can be future proof...


Best regards,
-- 
Nicolas Ferre
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
