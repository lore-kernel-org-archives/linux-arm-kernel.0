Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD4DC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:38:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86C45204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DFIuCnWq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="IT1cpyG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C45204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DOUiyF8qI+LYyiGqVA6rmeuLuHLfKM0/6x3M0TGOX54=; b=DFIuCnWqlKx7lS
	aXEBMTEebdBcH2IwfjBKwQSg8seR59SdmRgwCs9LtuajeLfNzVA7adTHKMEHJbvBWI5OJjJQPbzfO
	IIKYHoMOwp7WYHzn90MvxtwZ5O9WB+3h3cuRPakEXSROvVTIOMS1Tq9fjJiMgPEQWoq/pjZib9/bJ
	gKY0ibtnt0tiq2VfFnmfTHh5CaWhnc0ocFyZDilfdvC899jhDOYPlENFL0q4xrrK8F3VAMTFizzw7
	0eZ6FwYKVangr76A1v2jG6A562ObgKkcxxQs9ceNR9mjuH7jzsNdQPVM8XKxEZkyA6FOrc6FTrlTU
	4Ch6fEKhPybyA9gqd2Eg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOZz-0000aE-Ix; Mon, 10 Dec 2018 16:38:47 +0000
Received: from mail-db3eur04on0706.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::706]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOZv-0000MF-4y
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:38:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FfMH4BG9eqUheIzAOoAt42wMPDnVJxwDIs8d/T3Buo=;
 b=IT1cpyG510k/kXMWCU3M5/cbhQEzuM+PZab43qsQUiXKQgzKF9rsGecKfHHkDig5RIBEdMbKTPx9HZpaxJpGqayOJ+DttWUp9Ck78M22hzHnp2QsLZKEfKcF/lLsExnjcOrkVuFDmJoEUNmwfGaOBzCuOnEBaZQJjtn/Q2J3pGE=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2623.eurprd05.prod.outlook.com (10.172.13.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Mon, 10 Dec 2018 16:38:26 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::f0bb:aa66:e721:ecac]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::f0bb:aa66:e721:ecac%11]) with mapi id 15.20.1404.026; Mon, 10 Dec
 2018 16:38:26 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Subject: Re: TK1: DRM, Nouveau and VIC
Thread-Topic: TK1: DRM, Nouveau and VIC
Thread-Index: AQHUjwX1/WKFepsP1EqwZtC4knNc+qV3xkOAgAAK8QCAAEh3AIAAEZmAgAAEOwA=
Date: Mon, 10 Dec 2018 16:38:26 +0000
Message-ID: <1cc57f2d95988965bae649a68f020b4a566625aa.camel@toradex.com>
References: <0c2db0d1c102a4f5a441f8e5a90f6793f329ada7.camel@toradex.com>
 <20181210102147.GF15154@ulmo> <20181210110056.GL15154@ulmo>
 <49ea16ae9b500551a68b001ed7ce064b2591fd04.camel@toradex.com>
 <20181210162317.GA4789@ulmo>
In-Reply-To: <20181210162317.GA4789@ulmo>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0501MB2623;
 6:8dN3/R//yGKvUy02S8v9bshQOMuW+Pr0uwyJS0lzu9KYVrwgqCIetovdtX4VmV9vG6SIWceiXZEcH+BLxqAQGSIXkUth5H4CpKhl7GcDuN6m4lwbNy22pPPBdB0tHEwH+WnUC8f/bT8hf3MZt82REaAzQnMfBR+OpQg5bCiw1DFD5srRpBB15SvsWvChGFN9Pn+MdpkEMrrx7hPuhkYoNQ++dPhQSA60/2/fAPc2b6v8cjB/9a7A9J1SHo5pDlt9HDKNThfbyg6aMhulKWZZ1+w9J7RIkByTK59s2shLc/SNuEb5z0DEjbQgWt7woZRHErOh1DRITPgHnYDAxsL4CHgSjpywBrdrVZDPCo9BiuwxX6/XC0hvg3LKMx7+CVJ1C/pETAZmiFpmpctJC4Ei/qf0Ho554jvWl+YNYV7PDPYzLctET2WcN7HQBTGN5OWxYu60qIqVNk/7ajtHehbqvg==;
 5:Xle7WaYGI5gqtMeEO4/BEyE0pc5JFZL72Z7xbvsjO+IjKJqEmCd26V9LWjtV9g98HhkPPejrZWNBvPXPKULr7rh17f+FIg1VJCBYn2CDaiH1SSBGU6djGL406KvRqY0sNYqWOt+1d17Md0G448vs0FA8EK/x21hLnT7L7jLffwo=;
 7:KpoyE1kfJiGg1fsSjn4nqCQ1b2qudzuF2hoTwI8WnpyMtNQfk755++nlfk4D75ie9HM1jRm6jfCqVc25q3gGUj8hXKRjrQ9AeY2kw3bvS01wkFgI50JYSKKC89fhwAjIN6oUC3n7goIhKba2uwRb0w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e446f85c-99c1-46a7-43d5-08d65ebde8d6
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0501MB2623; 
x-ms-traffictypediagnostic: VI1PR0501MB2623:
x-microsoft-antispam-prvs: <VI1PR0501MB26233198F7FACD8EB0494400FBA50@VI1PR0501MB2623.eurprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR0501MB2623; BCL:0; PCL:0; RULEID:; SRVR:VI1PR0501MB2623; 
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(136003)(366004)(376002)(39840400004)(199004)(189003)(44832011)(93886005)(5640700003)(1361003)(6486002)(476003)(5660300001)(76176011)(446003)(305945005)(81156014)(8676002)(8936002)(53936002)(4326008)(54906003)(105586002)(7736002)(6436002)(86362001)(39060400002)(486006)(81166006)(316002)(6512007)(102836004)(71190400001)(14454004)(186003)(6506007)(99286004)(6246003)(4001150100001)(66066001)(97736004)(25786009)(26005)(71200400001)(68736007)(2906002)(2501003)(36756003)(118296001)(6916009)(256004)(229853002)(106356001)(2351001)(2616005)(508600001)(3846002)(6116002)(11346002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR0501MB2623;
 H:VI1PR0501MB2590.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9dAam7vQAduh8G8aDbCmXxrnO0V06uVWZ3YQu18AUncU8ImzxVBzTp/qoSiYpiOFLLzGbJUZzx9BXBuIeWFXiStcqEXSLrayA8DxRDMpoHN6KORRyeLxdiKso1a3hUEo7RBCEkzH1Drcf7oLj3TqZTAqaLGSQacyzPSEemK/1PE6XuacmDxKYkSWbSumdW10HOQD5MigrjdndnxfLIaOpv2LgPzNSEkadWsZNK36dTxLAQW6LXtkaVF7cjlu0wVcerz1vGn6Iew/dz3Lb3+vEf8yNiZwZ/Whzn/j6VWxiH+rwBqC1KJIW/JNzCofA8Z6
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <0C0A1212DDA4B34C812B0DF6136CDE68@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e446f85c-99c1-46a7-43d5-08d65ebde8d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 16:38:26.6548 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2623
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_083843_516831_2835125B 
X-CRM114-Status: GOOD (  14.89  )
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
Cc: "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "mperttunen@nvidia.com" <mperttunen@nvidia.com>,
 "bskeggs@redhat.com" <bskeggs@redhat.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Thierry

On Mon, 2018-12-10 at 17:23 +0100, Thierry Reding wrote:

Snip.

> > Looks like with pci_disable_device() it may take a rather strange
> > path...
> 
> Yikes... it has no business at all calling pci_disable_device() on
> Tegra. Unless if you happen to have a GPU plugged into the PCIe slot.
> I'm assuming that's not what you're doing?

Nope, I only have a Wi-Fi card behind a PCIe switch though (;-p).

> I'll see if I can reproduce (and fix) that crash on unload.
> Admittedly
> it's not something that I regularly test. Perhaps that's something
> that
> I should change...

Don't worry. After a couple of years working on this I happen to try
this the first time myself just now (;-p).

> Thierry

Cheers

Marcel
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
