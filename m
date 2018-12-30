Return-Path: <SRS0=kGow=PH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA70C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 03:25:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6537220866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 03:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K43a0uGp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="umXp7d9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6537220866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rExRYOgSSAExOlga+fnVm8byGDh3knkJ8/uV2xB5a3A=; b=K43a0uGpzcyYLX
	A7XguDY938sHTy9Exov7BffIAKavNuZMG4jt4HM2orH1kPptOtMX8AR9R69oq+C445j8+4M5ZvZRI
	qthe0OH7kgDTIGy7T4d1pMY9roZ4AP8PXpoXN2nml77pWLLvqWCze58tc/3m/hOASTdc7wichTorm
	Q1Ly6zBaKPqXqJy9Il1TaPZOx9z79reGiX9TbAatX63VKQt2U/ZhbkrwzG6dj1w9FUBQ18kQFulm1
	E03JKE92sIruZnVVCQwDfzaiUypD0Mf84WhgJimNIIaPf5Gb0bu018C5nUrrwlQQK1Z88x3SmI83p
	WqwRSNoLzsCiApOvIGMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdRjG-0001kI-Sh; Sun, 30 Dec 2018 03:25:30 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdRjD-0001jX-OP
 for linux-arm-kernel@lists.infradead.org; Sun, 30 Dec 2018 03:25:29 +0000
X-IronPort-AV: E=Sophos;i="5.56,416,1539673200"; d="scan'208";a="22051571"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 29 Dec 2018 20:25:15 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Sat, 29 Dec 2018 20:25:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNkDUCoiFADjt6TMemM8bgXX4a7irtNXOarNNCaDiy0=;
 b=umXp7d9vj2hxLpWy+g2V5mHtqAzAznzQcRYzng6d/CMJxGgyqkN3zuaaMn8VEHiD3AvkwaLjH54Gw95KvyWMzE++62JYjmFwRWtinU4hVfEjEf0CQcrpaqCzr9V6nIT30i5Xe3dGYEHa+grqX6B/eQ5ReoOq8aRBJmVZ7ZE7yII=
Received: from BN6PR1101MB2130.namprd11.prod.outlook.com (10.174.112.135) by
 BN6PR1101MB2098.namprd11.prod.outlook.com (10.174.112.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Sun, 30 Dec 2018 03:25:11 +0000
Received: from BN6PR1101MB2130.namprd11.prod.outlook.com
 ([fe80::a087:d8fb:ed76:d9e7]) by BN6PR1101MB2130.namprd11.prod.outlook.com
 ([fe80::a087:d8fb:ed76:d9e7%9]) with mapi id 15.20.1471.019; Sun, 30 Dec 2018
 03:25:11 +0000
From: <Woojung.Huh@microchip.com>
To: <marc.zyngier@arm.com>, <stefan.wahren@i2se.com>
Subject: RE: lan78xx: WARNING: irq 79 handler enabled interrupts
Thread-Topic: lan78xx: WARNING: irq 79 handler enabled interrupts
Thread-Index: AQHUnwoprNs5FgB5F0GdFnVzz/mpVaWVd08AgAElhEA=
Date: Sun, 30 Dec 2018 03:25:10 +0000
Message-ID: <BN6PR1101MB21305BBBB3F617C9C49141E4E7B10@BN6PR1101MB2130.namprd11.prod.outlook.com>
References: <1082628525.187562.1546041777025@email.ionos.de>
 <86efa0brfx.wl-marc.zyngier@arm.com>
In-Reply-To: <86efa0brfx.wl-marc.zyngier@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Woojung.Huh@microchip.com; 
x-originating-ip: [67.81.18.121]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR1101MB2098;
 6:wEYhhyb39NuZl0BHxbhSvge0vVMF5OamkatDXapW5GtsHnDTyQmXjMyDFAddqxlaV2yXov4AHmiwc515Q9nTaMs/+nNouaJNnegzrPJS4rzEyUYgAkxzfAUaOUVVjbu5PBQsejqUMqYj7DP+q8UqsvQf2EiqOcjc2/zk7Z/1px3wf7cLL7/p7+NHgrtdgSyyvFO/Q7iDZQASQWS51ByKlIkY4h0ciKCTo26CnUrQM+UJmedSvfrRO32TIPHla39kEg0G3Q3VhCdvxVqgaJFixOJpsr91GYby5ShosJP+RTbnnAy7Gkhc6GhUw0RY5g+FZGIuV7iqxzCDUtJnCSuBy/7Utbi/o4v/8DYlLoGA1yFOVi/xt3iPIRjNOhiKQ4B1Jb7FugSe0yGzunJHmKz7dwY2f5xuWX6ZVKh+JSRnr95OXeeIkAVMB3payFH/bjN0vOEndCB6x2bAOwU3n90rWA==;
 5:pupebxJq6LHLXkquyQVZA6o+QDHxpSrxwDZ9jUJ5k2l65hUdRofGgJ8M/l882SlfoERi5QI2OcEz9y1SVOue84tGNLeoh/zVaZssFSESf8epbyA/Th/P9PRQu4R9RbRCKO7evzZY5vUoLV8clUEaJFBfQ1GEss198PXkKOkPr/k=;
 7:qHJw2gqNpUGbOTqsz1OEzFX4zWzS7ta+pNMTBB+iw+vjiqyk7YFwf9Ty3YSAKcphsFeEogx/YMBDpURn2yK/tZjBx8ofixJD/RXs6ToDcBHHGTeeWgn80QqsCfZ8qMLPSGgOVb8FS4U+54s/3iJj9g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 086895ad-397f-42bf-7032-08d66e0667de
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR1101MB2098; 
x-ms-traffictypediagnostic: BN6PR1101MB2098:
x-microsoft-antispam-prvs: <BN6PR1101MB209897B2CF9306C656524452E7B10@BN6PR1101MB2098.namprd11.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220055)(2401047)(8121501046)(823302103)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:BN6PR1101MB2098; BCL:0; PCL:0; RULEID:; SRVR:BN6PR1101MB2098; 
x-forefront-prvs: 0902222726
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(396003)(39850400004)(366004)(136003)(13464003)(199004)(189003)(9686003)(71190400001)(4326008)(106356001)(54906003)(105586002)(53936002)(2906002)(3846002)(7696005)(33656002)(68736007)(97736004)(81156014)(81166006)(53546011)(25786009)(71200400001)(76176011)(486006)(6506007)(102836004)(316002)(6306002)(6246003)(110136005)(6116002)(55016002)(8676002)(99286004)(86362001)(14454004)(5660300001)(8936002)(6436002)(74316002)(229853002)(66066001)(14444005)(305945005)(186003)(11346002)(72206003)(446003)(478600001)(7736002)(256004)(476003)(26005)(966005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1101MB2098;
 H:BN6PR1101MB2130.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RnYu4cYVY/lC/W9kjg2SjuUo5+Ao6trQ9ieKAFQ7aIaOpaQxNTbOJUQX5nvyTER8LldiTDvLAhSXDVlMERu4YrOjiu7JpS0hsA01Ip1xwR8RcDoI/Wr1BMr904mvFrA1sndmAWmkjsSKCCbNc9gpYT18TiMJdobnUcJoJQRCAUZlVpch2VQLf6i+vxBKBNr+oGzLlMwS7uPB6kIAR1ElmO9VW8ZfO3ucfHZYh6h1FU790A76C5Y2oJMXvf/V3U108fcCcIyeG4yG2YSmbzZpvjU7LA4GKkRIJzXB+Zzpby3fBWAKFiqwqGK3IoaI/7sE
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 086895ad-397f-42bf-7032-08d66e0667de
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2018 03:25:11.0213 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2098
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181229_192527_830040_F0E7CC0D 
X-CRM114-Status: GOOD (  19.06  )
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
Cc: eric@anholt.net, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, UNGLinuxDriver@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

HI Marc & Stephen,

Most of engineers are out until New Year's Day.
 
LAN78xx driver uses irq_domain for phy interrupt, but smsc95xx uses polling.
Need to check flow again, you can try that comment out "lan78xx_setup_irq_domain" to
make dev->domain_data.phyirq = 0 which forces PHY polling.
 
Can you share if this is filed on RPI forum?
Also, it would be appreciated if you can create a ticket on Microchip site at
https://www.microchip.com/technical-support/hot-topics

Best Regards,
Woojung

> -----Original Message-----
> From: Marc Zyngier <marc.zyngier@arm.com>
> Sent: Saturday, December 29, 2018 4:42 AM
> To: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: Woojung Huh - C21699 <Woojung.Huh@microchip.com>; Eric Anholt
> <eric@anholt.net>; UNGLinuxDriver <UNGLinuxDriver@microchip.com>;
> netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: lan78xx: WARNING: irq 79 handler enabled interrupts
> 
> On Sat, 29 Dec 2018 00:02:57 +0000,
> Stefan Wahren <stefan.wahren@i2se.com> wrote:
> 
> Hi Stephan,
> 
> >
> > Hi,
> > while booting my Raspberry Pi 3 B+ with Linux 4.20 (arm64/defconfig)
> > i'm getting the following warning:
> >
> > [   11.005738] irq 79 handler irq_default_primary_handler+0x0/0x8 enabled
> interrupts
> 
> [...]
> 
> > This seems to come from the lan78xx driver, because i don't get this
> > warning on the RPI 3B (smsc95xx).
> >
> > What's the approach to fix this issue?  Is it just simply replace
> > spin_lock_irq() with spin_lock_irqsave() at the right places?
> 
> No, this is more pathological than that. The USB framework seems to be
> using threaded interrupts, which implies that interrupts are
> re-enabled as soon as it has run.
> 
> In turn, this driver is using handle_simple_irq() as its flow, which
> definitely expect interrupts to be disabled.
> 
> I have no insight in how this driver works, but I'm happy to help if
> someone explains the interrupt flow of this thing.
> 
> 	M.
> 
> --
> Jazz is not dead, it just smell funny.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
