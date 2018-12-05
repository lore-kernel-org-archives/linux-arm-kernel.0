Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F0EC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:03:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 232282082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GLE6s6Ia";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="Iq8G112C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232282082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=viON/+GW6ChAgrcay3DTkw7bOw7xStxFpXVEhXpxz+w=; b=GLE6s6IauOAD1X
	LkRq1PQ23FAiwWfEmvfIBqsun8dQevg0SNvCNfPUemBiWZOloyA5wua8acS077/SOoguayGQfMpae
	zbN7kmxcobKhaGPEzD+O+w6BdjbuvZpM2TYYro0S0PhVbJL5QY+CzApdJU0El6nZJNHQg/B81IGPp
	nFlXvwE/+5UjUb9Qkp4KaRL5pRwmjfNIRIQKzzaoBzgYwmf7A+UQhYMVVxRb0BZg5B7/Nukq1E5ul
	JBffy6SWuYvOCobq0+gp0giflDSwx1dY4JNaGw0VIam2dANZMYlZJ7yYDWeTkufuUdijYLUhaoNZ5
	ifoy6CiiogGPZZ3JxW7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUQGx-0003YD-F0; Wed, 05 Dec 2018 06:02:59 +0000
Received: from mail-co1nam04on0614.outbound.protection.outlook.com
 ([2a01:111:f400:fe4d::614]
 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUQGt-0003U6-B6
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 06:02:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95sGubi0hBFod2GWioDZ8cn+xT6VKh2h1t7IZfUldvY=;
 b=Iq8G112Cqg7UdSU5AR1Li6TuNddD0NFNV3UzHf99itgCsK4/4sWcYvNdJc9I9Kf0dvFZBelgH0iCMj3G5o8ktXS0B2221/nSZiZidrtCGMdPC6qQMokjG24YxIMbjkz7bXfCwwUfdUwdik1RxYvox4odSMgR3P/ivKSbgGe14rQ=
Received: from SN6PR03MB4398.namprd03.prod.outlook.com (20.177.255.219) by
 SN6PR03MB3632.namprd03.prod.outlook.com (52.135.80.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Wed, 5 Dec 2018 06:02:39 +0000
Received: from SN6PR03MB4398.namprd03.prod.outlook.com
 ([fe80::7c2a:de77:a4ce:5ccc]) by SN6PR03MB4398.namprd03.prod.outlook.com
 ([fe80::7c2a:de77:a4ce:5ccc%3]) with mapi id 15.20.1404.019; Wed, 5 Dec 2018
 06:02:39 +0000
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: Moving ARM dts files
Thread-Topic: Moving ARM dts files
Thread-Index: AQHUjABim0nyCtiTgEG6mpQLHVSeW6VvpssA
Date: Wed, 5 Dec 2018 06:02:39 +0000
Message-ID: <20181205135726.70badac7@xhacker.debian>
References: <20181204183649.GA5716@bogus>
In-Reply-To: <20181204183649.GA5716@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0225.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::21) To SN6PR03MB4398.namprd03.prod.outlook.com
 (2603:10b6:805:fd::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; SN6PR03MB3632;
 6:VyJ1m/JvMvRy4eLGcObxyrY0Nn2LJFJVC/0U4TcixX603aNnBT2DeyibkBiN3Kk8+Vk/88FzRFMAAiwB4wU24nd4M4u/1thuh7LVolhJ3sk/ybGvUZF/hJVctICDN2SYV4dw3vZ2II8HfDs7KJckZKYwFQWrc+YYMoupGU+zujP94+ttsu7lZbAQG7Ae4/HEIwGwmc/dzTg0QuQwqzW6GVDlFMsJZCwTGRDU9CN55hg1fCbMCX6ukuSMPRVj5D9aEwSSW86+6foxmavlTFller2CF7jt1+Ece0bsnABCkFdTwzCt+gLQBlUaZgeN8liTUQud+slL8gugCdfsaCSGmVkJ3BNCTSHYAOmGhe5hlHADVsKZHaAPPyHa4Km3R/nAV0LcrUhLNnzWSnaf9BqWBwoSAWtzLioOfhkm1CBsBzS6FtD40uoVyFiI8fKLy6mD6aFjbTZ1n1NXfWKNnwe7PA==;
 5:t8sMuTqixLyw41Oe7lOzygA5jzSwEIdFvPV6VNHBK+rDf+OtqVEAc+r5wr47Uo8JOlPnS1qMdnn/DKhStq9Eiz2Z6CrWQ881MnlCPXsA64iE9Lair5byxl+a8SXoAG1X5auNXJk9s9b1DMI6ZxX05h9iNaNC85wx2PNwtUjG7eA=;
 7:02YtJwEmmbnri6FQpHzqwwfK/a2f5FFINdzqdTKJWiOfDHWgx/Tyyo4LKbiz09OYtl97XPxSPibA/wZeLaFHWhkOnS7YhhxzAIIXQqkwJG/K84GO1IO3t6VGr+a0l6QRfaf10Vpgo+YhIa/PW56IzQ==
x-ms-office365-filtering-correlation-id: d2fb4933-c01f-4ea9-0a01-08d65a77431a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:SN6PR03MB3632; 
x-ms-traffictypediagnostic: SN6PR03MB3632:
x-microsoft-antispam-prvs: <SN6PR03MB36322B1A9F290101A2D0B5E3EDA80@SN6PR03MB3632.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:SN6PR03MB3632; BCL:0; PCL:0; RULEID:; SRVR:SN6PR03MB3632; 
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(136003)(39860400002)(366004)(396003)(189003)(199004)(97736004)(72206003)(25786009)(99286004)(33896004)(76176011)(478600001)(71200400001)(71190400001)(26005)(52116002)(66066001)(186003)(14444005)(256004)(9686003)(6512007)(53936002)(68736007)(386003)(6506007)(39060400002)(6246003)(4326008)(106356001)(105586002)(102836004)(6916009)(5660300001)(316002)(1076002)(305945005)(86362001)(54906003)(6116002)(81156014)(81166006)(6486002)(8676002)(8936002)(7416002)(3846002)(229853002)(6436002)(2906002)(486006)(11346002)(446003)(476003)(7736002)(14454004)(3480700005)(39210200001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR03MB3632;
 H:SN6PR03MB4398.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Yltr+WHhMRyh9wvr1Xh+QQfh8VN2rdS6cEcHI6sBsExdMdsltyZN0xQBGwX9zWswptkf80PL5r0BbjA8lOMryRDRw4dx2KBABEHOvZV3BPDO5nvdYHYJ0txO2StztXP0/SFgn0Y2YKCxQQuJ//6CvsPt5ZzebBPYW+ba/aUZt1iWjlVzoshn4HI0nxTMVBKn+GzRjCkLF3RfeTC21ZwItPIypHJPgPAcRPraaAbcjQ14y1G/66OOgZ1tjkVi6hd1ep/5CagFa7dpKcJzykXvj/4Zgw86PZF8UUpq9uu2N4Kb1nNrVFyCysQ00wli5/AaxyEhE4ICXstSVFKeaM0cm+g4GkRglhaICP8fog1ZrY0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <0749FD24A27D70418492C967C58C578D@namprd03.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fb4933-c01f-4ea9-0a01-08d65a77431a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 06:02:39.6016 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3632
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_220255_748088_728FCEB9 
X-CRM114-Status: GOOD (  16.35  )
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
 Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Michal Simek <michal.simek@xilinx.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 "arm@kernel.org" <arm@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andy Gross <andy.gross@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Jason Cooper <jason@lakedaemon.net>, Simon Horman <horms@verge.net.au>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 =?iso-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Rob,

On Tue, 4 Dec 2018 12:36:49 -0600
Rob Herring <robh@kernel.org> wrote:

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
> 
> Rob
> 
> 8<-----------------------------------------------------------
> #!/usr/bin/env python3
> 
> import os
> import re
> from git import Git
> import glob
> 
> vendor_map = {
>     'imx': 'fsl',
>     'ls': 'fsl',
>     'vf': 'fsl',
>     'qcom': 'qcom',
>     'am3' : 'ti',
>     'am4' : 'ti',
>     'am5' : 'ti',
>     'da' : 'ti',
>     'dm' : 'ti',
>     'dra' : 'ti',
>     'keystone' : 'ti',
>     'omap' : 'ti',
>     'nspire' : 'ti',
>     'armada' : 'marvell',
>     'berlin' : 'marvell',

Now, berlin SoC is synaptics' SoC ;)

Thanks


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
