Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD10C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:06:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CEBE21850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eOI6ZB8g";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="e5gjKDYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CEBE21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5GtDigxx3K8Us+OVrjdBNpzuejOzgK8pKYvMIERqxuo=; b=eOI6ZB8gGU7B2f
	zTeV/mxSb6mum3ymFWoouhSc/sAEg1sip7j5PoaZKrqCmICrfAKx/R/vZ7G8J9xWjRxeznDXmj/Py
	Ei6yR1axzhdFMM2Z7s0NGOyTpBKY3mIeTy0HmbViAYU13Gtz384SgbXtZ4EIJSbNdsHKnsZGRh5dS
	6yFNPEZX8jqIvNfSpIOPlAL1i0YRbvmm+GtAF1rbKQrXzNHwIYdiXs+0hYNYpyriCmP6kLUVC4Xm6
	JJVTWnBFv+YAZ1BswH4E2km7AvXm8mXTCaeOPWtqIWNVH50Rwy8zY6V8vstdOykUmZmFpm4VIv999
	843UWXenDjW4bmQxBzTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmJAH-0001Um-8V; Wed, 23 Jan 2019 14:06:01 +0000
Received: from mail-he1eur01on0723.outbound.protection.outlook.com
 ([2a01:111:f400:fe1e::723]
 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmJAD-0001UQ-5N
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 14:05:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com; 
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5tUklzvona4jiD33zOgexIFIkVJc/ymT7e4mok/EvI=;
 b=e5gjKDYvP58yyiY1b743iaVkYOUewFWLh/WxlJmr8KvdImjQTOzDtn+mxroWTfS5Gn6ft0BFfKE+U6EzQRPj5jvOAy5IsbO2dHFKsIVc6ydN9i9b+HHijWioy46D0uD2aB0tpA9of7cX1gjuB6kOD1VhMgsD8Ws5Q1mAISqkC9I=
Received: from VI1PR0701MB2701.eurprd07.prod.outlook.com (10.173.80.137) by
 VI1PR0701MB2511.eurprd07.prod.outlook.com (10.168.139.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.15; Wed, 23 Jan 2019 14:05:52 +0000
Received: from VI1PR0701MB2701.eurprd07.prod.outlook.com
 ([fe80::4883:b19f:8afa:a20f]) by VI1PR0701MB2701.eurprd07.prod.outlook.com
 ([fe80::4883:b19f:8afa:a20f%6]) with mapi id 15.20.1558.016; Wed, 23 Jan 2019
 14:05:52 +0000
From: "Adamski, Krzysztof (Nokia - PL/Wroclaw)" <krzysztof.adamski@nokia.com>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ARM: defconfig: axm55xx: Drop PL11x graphics driver
Thread-Topic: [PATCH] ARM: defconfig: axm55xx: Drop PL11x graphics driver
Thread-Index: AQHUsyF53VGgWaxKPUy/ojO6vQ2/EKW84ykA
Date: Wed, 23 Jan 2019 14:05:52 +0000
Message-ID: <20190123140536.GA26807@localhost.localdomain>
References: <20190123134219.15336-1-linus.walleij@linaro.org>
In-Reply-To: <20190123134219.15336-1-linus.walleij@linaro.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0109.eurprd02.prod.outlook.com
 (2603:10a6:7:29::38) To VI1PR0701MB2701.eurprd07.prod.outlook.com
 (2603:10a6:801:8::9)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.228.32.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0701MB2511;
 6:hk8fqIxPcKTbbr1SvD2v/4kC5oiqUpO1pq4U8cn+5K4GL+bg79sgK+0WAD5MLiTrYzwPTfD8/R+SBIqC7rvZovm1pXZsRWhB/nd6FNRTuxM/voVpdNXka5YxBciZ+9K8mvbML7HfyVSwy+7zQuxBwFkkBhyu+9zqmOovs6C+BXJiLYPHeSkJwcQpBJrxhH8XkniHqrIJ7zbiZp6rJvXBhVck3VboUjyjDjVrYm3A7KVrBR6PU7rcAm5oR97jobtxmK0iWt4fUAb9DEr/96SMcNQyM9Sbfw/1WeE9aikxVNF8Z6WhNH+jdKdAN6djcmBBSkfYu25q0NsxXBp2nVZZbmGgODGzDmjwgnbAdm1KPzEEERYnomYw1wCAw3dG2NKcOtwuIw3CNC3XhAegHEQaCX6osvS2EZrrBDNuYJFOlNAh50n/ItYadOxcK9WvDMthHbL3VnblSWQ+ztcNYPGVsw==;
 5:ofAuMqGcNgQkbo+qKBvB/zH1kUmNLioGLFnWuIr9r84zeQvxUwLeTCyp2csbyYAtPHyBFL2DHNC5wyHJcFrJdWpfyU5/cUK4hb2lpbOknjg4cwqNMibGy9G0KIMObQLihIoUAnRev2LEiazd7IdUGU7in9bPtwcJNomKMfka57xMxr9hj6T8Vx/ViyHZmRGzBdg2Gp1czLFaheMBTl325A==;
 7:7BScg79rVYYNr7Wzcoj3Q+bGrlEY27NVNHwnaO9x8U8Jl+ZAax3E1KN6/wPN7NDOb7ltsITrCCNS91KIUBZg+5NH5QpnlqqxKUizqMF4joTxiZLOVk5gp5gP6th1VMRyIUCpuPfmz+aRKiVhBzPnfQ==
x-ms-office365-filtering-correlation-id: b9b41227-24b7-41e9-b99b-08d6813be29a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:VI1PR0701MB2511; 
x-ms-traffictypediagnostic: VI1PR0701MB2511:
x-microsoft-antispam-prvs: <VI1PR0701MB2511C9D2175F2075882FC3A3EF990@VI1PR0701MB2511.eurprd07.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(346002)(396003)(136003)(376002)(366004)(189003)(199004)(106356001)(25786009)(97736004)(76176011)(305945005)(33656002)(7736002)(33896004)(52116002)(14454004)(105586002)(6916009)(478600001)(99286004)(8936002)(53936002)(9686003)(6512007)(4326008)(486006)(6246003)(3846002)(6116002)(6436002)(68736007)(6486002)(71190400001)(229853002)(8676002)(26005)(256004)(476003)(61506002)(446003)(316002)(1076003)(86362001)(102836004)(54906003)(6346003)(6506007)(386003)(11346002)(66066001)(2906002)(81156014)(186003)(81166006)(71200400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR0701MB2511;
 H:VI1PR0701MB2701.eurprd07.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=krzysztof.adamski@nokia.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BecZsWpxwv7TQ2ZSjblHa6ReWCCBBJvGxzLuQvAP5biJN+ECZP7sK8sBfZtAAQlI9SAXc1nE2G6GhvZed6S0WovreGVn4Q4B+A5SpB7vvBE/po8PZvEXUydCItzOkjJFlVcRxowrRLe+OfO9l0DC4UbOA+rbuOtrZnaUDYjGn4+BLKuKWvRlFaU2rzicGi7U+TMVX/8jYI/nct6W20zgHnQ0zSyPfGgp4fCbAV5n91oox8uAgfqrIm9tQ5mdqw+L5aTa6WsM+fQIRLm1nXhWSVc+KUO+YrImgAHwsVr0X2bFvGVyjbGkcNWiPibZZrihEZopS0nStXT0ydwsROvPfTXO8r+tXn3z0seQAcZ6AU3yJFH16ygIn8Ka8BgGjSju6qYywBJl089arYro6fSwi+HvVySo9HmyV3wOPcGOV0k=
Content-ID: <FE8A4AD8B7ED954FA34A78EE51DB984A@eurprd07.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b41227-24b7-41e9-b99b-08d6813be29a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 14:05:51.8703 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB2511
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_060557_207077_0C1E685D 
X-CRM114-Status: UNSURE (   9.59  )
X-CRM114-Notice: Please train this message.
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
Cc: Anders Roxell <anders.roxell@linaro.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, John Logan <john.logan@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 23, 2019 at 02:42:19PM +0100, Linus Walleij wrote:
>The defconfig for the AXM55xx includes the ARM CLCD
>(PL11x) PrimeCell framebuffer driver, but the device tree
>for this platform does not include this hardware, nor do I
>find it likely that this chip has graphics.
>
>Drop these config items.
>
>Cc: John Logan <john.logan@intel.com>
>Cc: Krzysztof Adamski <krzysztof.adamski@nokia.com>
>Cc: Anders Roxell <anders.roxell@linaro.org>
>Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>---
>I don't know who's collecting patches for Axxia these days,
>shall I send this to ARM SoC myself?
>---
> arch/arm/configs/axm55xx_defconfig | 4 ----
> 1 file changed, 4 deletions(-)
>
>diff --git a/arch/arm/configs/axm55xx_defconfig b/arch/arm/configs/axm55xx_defconfig
>index 8e17e7ed1f02..53864316bee1 100644
>--- a/arch/arm/configs/axm55xx_defconfig
>+++ b/arch/arm/configs/axm55xx_defconfig
>@@ -155,10 +155,6 @@ CONFIG_PMBUS=y
> CONFIG_SENSORS_LTC2978=y
> CONFIG_WATCHDOG=y
> CONFIG_ARM_SP805_WATCHDOG=y
>-CONFIG_FB=y
>-CONFIG_FB_ARMCLCD=y
>-CONFIG_FRAMEBUFFER_CONSOLE=y
>-CONFIG_LOGO=y
> # CONFIG_LOGO_LINUX_MONO is not set
> # CONFIG_LOGO_LINUX_VGA16 is not set
> CONFIG_HID_A4TECH=y
>-- 
>2.20.1
>

As far as I can tell based on my resources, you are right about the lack of
framebuffer on this SoC.

Acked-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>

Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
