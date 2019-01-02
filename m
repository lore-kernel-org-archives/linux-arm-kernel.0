Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF37C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:42:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6B1521479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YOTbyYFs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="G3HbRDgl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B1521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aBBZyMvv+HFCwUZn8f3Gfl0VrPeuEYCOyNxqmmAwU3U=; b=YOTbyYFsaogg/Y
	1VxWGU8URco/tkYzWKpnCYQWED30o4GfVMMOK6iYXCUcMwyuHrpBzVMZ6EfuD41hHO0Sk/IjqGEpt
	gN92Qv5WqtxZlapLp4ExrkstnSfyZ2DwCo7yNBU/OCQHwW35FUGJDC3oUXp2ZX35zPstMpYtyGpvS
	0xXqO3ThBKJNj+cOSkKFCau1XXjO0kP10XaGZMak68sf2L87j5PRKNaUMI1cZFPpBD2MJ/epcSTsd
	8CarYyf+04HNt0cmzvJm6DjK4JdZ+7Pa3Vy6bpmIdpFEsfirgyznvnd9Lt9ZtjRzJmGE7OcoYvG0E
	Sjcn06x3HTtv3QYegZbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geoHf-00023r-Vm; Wed, 02 Jan 2019 21:42:39 +0000
Received: from esa5.microchip.iphmx.com ([216.71.150.166])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geoHb-00023P-GJ
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 21:42:38 +0000
X-IronPort-AV: E=Sophos;i="5.56,432,1539673200"; d="scan'208";a="22905596"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 02 Jan 2019 14:42:31 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Wed, 2 Jan 2019 14:43:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddyMyuNrv1uCwbRodVaCQaO6sm10DbFVC+ASQ4g5ASk=;
 b=G3HbRDglhLE9f+goSVWbDYmVP3CVBxPpnXdyL9fcUppGCYMPK1RxtmCrLc+/OkAFGYq6Pyn+/pV9VRL27uD4u/WAOIdZFG2WOVAislrIed44cArGXtO66LXxljOah95Fz2RkaB4tQfrdZDKkLPc9SI1awBWShYWP9rIaGmdnysY=
Received: from BN6PR1101MB2130.namprd11.prod.outlook.com (10.174.112.135) by
 BN6PR1101MB2068.namprd11.prod.outlook.com (10.174.112.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Wed, 2 Jan 2019 21:42:25 +0000
Received: from BN6PR1101MB2130.namprd11.prod.outlook.com
 ([fe80::7505:e994:c781:910]) by BN6PR1101MB2130.namprd11.prod.outlook.com
 ([fe80::7505:e994:c781:910%2]) with mapi id 15.20.1495.005; Wed, 2 Jan 2019
 21:42:25 +0000
From: <Woojung.Huh@microchip.com>
To: <stefan.wahren@i2se.com>
Subject: RE: lan78xx: WARNING: irq 79 handler enabled interrupts
Thread-Topic: lan78xx: WARNING: irq 79 handler enabled interrupts
Thread-Index: AQHUnwoprNs5FgB5F0GdFnVzz/mpVaWVd08AgAElhECABFfkgIABlH8A
Date: Wed, 2 Jan 2019 21:42:25 +0000
Message-ID: <BN6PR1101MB21304C3686D65E78E59110FDE78C0@BN6PR1101MB2130.namprd11.prod.outlook.com>
References: <1082628525.187562.1546041777025@email.ionos.de>
 <86efa0brfx.wl-marc.zyngier@arm.com>
 <BN6PR1101MB21305BBBB3F617C9C49141E4E7B10@BN6PR1101MB2130.namprd11.prod.outlook.com>
 <958035754.310420.1546378307673@email.ionos.de>
In-Reply-To: <958035754.310420.1546378307673@email.ionos.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Woojung.Huh@microchip.com; 
x-originating-ip: [47.19.18.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR1101MB2068;
 6:yXw1pEP/NTg6jthP6ztLJYE8ht5IkLsMVCmOAoRxvoXOLOnLSE1i3Yaahj2PcHys88uqq0AWEXaUoG52xBbhWPnvRFRC9vw2PjLGEpp2BiV78D4PAS6XvQB0U3rm+60wwYJ1Knbmm6T9U1kebaM78zDEnsXE0gl70JTMK/P0/BxhvdVhS+UKdtM145mZQ2Tpp+Tea3RzVJKaMw1vfQjxcav6mOgtpFEUW2iif7WkRzdhrLKzz3Is81UYzwTqHeVVJ+5A3QvuAS3bbcGA6nil+td9AsyPrPsLNeAJueXul3UkeDvixxVwrzqvOg7IhNgHu5ZJwfvlCjHY19rIFLzB81grsTPA2lIeuYKfXf0ZEsS4VmFYb3OF3govBefN6F+laJBQW5QlsXZoaEW1sH+jl5c3rsOEHu+l2NUMS4rvSaVVhhtJ8NMdnTyx9DtTNizQY1fxAOqF/nsZDT6w3PDYXg==;
 5:mbVAkyprD3Ec6ZOFyGsHI7RYS1eHVkMNvLweJpDZYtR+zwVzYkSaH0NemXfpdLGEoHC5salq4C1E3N77s2nPxPauOn/vLD/IIE+px6t04IlWXDZjpxfM895oa1z3NKa2i7hIxUPtAavT5M1yi/w+Gu3iuYAbfv814hTxsCh3ySl02Kcc6zF2VkX2ZXEO39oaMHZ/ccppGC6on5bT3ks9bw==;
 7:SOTrSKLTsUxsoKEXsACxixEYGJa59ttWAGo8Rp2C+33QOX9oTu80UPqFEAA/z5AM7eqOOqy1gMY1vprTyUYNVNy9bC3Iq+VNQQI9N2WV97GySWqfmM0uBRDXBtyS8hD9GJCMvXR35PoaS+w12hkKRg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3acc185d-8860-4ee2-4c1f-08d670fb2fbc
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR1101MB2068; 
x-ms-traffictypediagnostic: BN6PR1101MB2068:
x-microsoft-antispam-prvs: <BN6PR1101MB20681B81A8F6EF663767BACAE78C0@BN6PR1101MB2068.namprd11.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(823302103)(3002001)(3231475)(944501520)(52105112)(10201501046)(93006095)(93001095)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:BN6PR1101MB2068; BCL:0; PCL:0; RULEID:; SRVR:BN6PR1101MB2068; 
x-forefront-prvs: 0905A6B2C7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(376002)(346002)(39860400002)(396003)(136003)(13464003)(189003)(199004)(16799955002)(99286004)(106356001)(316002)(26005)(53546011)(6506007)(102836004)(476003)(186003)(93886005)(11346002)(486006)(446003)(256004)(33656002)(76176011)(105586002)(81156014)(8676002)(8936002)(81166006)(54906003)(7736002)(305945005)(14444005)(7696005)(74316002)(53936002)(68736007)(25786009)(6916009)(66066001)(5660300001)(229853002)(3846002)(6116002)(6436002)(97736004)(71190400001)(71200400001)(4326008)(86362001)(2906002)(478600001)(6246003)(966005)(55016002)(14454004)(72206003)(6306002)(9686003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1101MB2068;
 H:BN6PR1101MB2130.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OXkzij8hWBEe1z01O4/q5xE7tAE3kNh/tbMJQboqB9Ub7pSLLTVM/YQDQsnIZ7e9eMZ9mNk9xuCP5f6Sn+eOaPNLwm3TvprRMONQXOP0ixf/St+3wo9/YHC7IJXcuzhWzqHB2rBFbPZ/23fCX+j/eSHzUHZcqL9pAl0dxMhkhN8LKP2WSv2W44LiUdFZp/THSF4UWwCrLxzL0s5ADvfuP2r6iUM31RG0EBeSc8thX2LGvZKaJ/pjcWsHUDvvvbvjLtQkbNTHO1055qaAW0QgOlyWqmi1387oSRd2iLbpAcT6/wP2ONbAlO3+a7Nm7vHf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acc185d-8860-4ee2-4c1f-08d670fb2fbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2019 21:42:25.8537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2068
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_134235_713123_0B99EEA1 
X-CRM114-Status: GOOD (  18.25  )
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
Cc: marc.zyngier@arm.com, eric@anholt.net, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, UNGLinuxDriver@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Stefan,

Thanks for information and creating a ticket.

Did quick check on a PC machine with 4.20 rc. However, not seeing same warning.
Look need time to repro and get details on same build & target you are using.

Regards,
Woojung

> -----Original Message-----
> From: Stefan Wahren <stefan.wahren@i2se.com>
> Sent: Tuesday, January 1, 2019 4:32 PM
> To: Woojung Huh - C21699 <Woojung.Huh@microchip.com>
> Cc: eric@anholt.net; UNGLinuxDriver <UNGLinuxDriver@microchip.com>; marc.zyngier@arm.com;
> netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: RE: lan78xx: WARNING: irq 79 handler enabled interrupts
> 
> Hi Woojung,
> 
> > Woojung.Huh@microchip.com hat am 30. Dezember 2018 um 04:25 geschrieben:
> >
> >
> > HI Marc & Stephen,
> >
> > Most of engineers are out until New Year's Day.
> 
> thanks. I didn't expect a reply that fast.
> 
> >
> > LAN78xx driver uses irq_domain for phy interrupt, but smsc95xx uses polling.
> > Need to check flow again, you can try that comment out "lan78xx_setup_irq_domain" to
> > make dev->domain_data.phyirq = 0 which forces PHY polling.
> 
> I tested your suggestion with multi_v7_defconfig (32 bit) and arm64/defconfig.
> The warning disappeared and Ethernet is still working.
> 
> Only the old issue that we can't receive until a first packet has been send out reappear. But this should
> be manageable.
> 
> >
> > Can you share if this is filed on RPI forum?
> 
> I didn't submit this to the raspberrypi.org forum / github. They mostly care about the next LTS release
> 4.19 and not really about arm64.
> 
> But an Arch Linux user (aarch64 using Mainline kernel) already discovered this issue:
> https://archlinuxarm.org/forum/viewtopic.php?f=65&t=13302
> 
> > Also, it would be appreciated if you can create a ticket on Microchip site at
> > https://www.microchip.com/technical-support/hot-topics
> 
> Done
> 
> Best regards
> Stefan
> 
> >
> > Best Regards,
> > Woojung
> >
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
