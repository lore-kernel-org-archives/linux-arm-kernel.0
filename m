Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36A4C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:05:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8094120879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q1diCCqd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LMqXiGZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8094120879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bYKzAYfIBtKb7sdRNBMHm+ck5u+mxkPGFELQ1puZYko=; b=q1diCCqdEljsL5
	A0SlJ+opB9lvbvc1xU4i0OvuU1lCUJYHwRau45sXKcrYwiQGfwu2M+jpc0Yh9QvJu2aHE0edkPWnD
	SEzn+A9ZPGuVNRxhdY/qozSVEXyVur+n6sq48OSKp1rpCsKsmO7sZ3XCD45Neb4CplI9PzNr7OEaH
	jSXc2ZMfzjRo5wC46NkLyF0WgyAwQIn+ydnrnzV1VoEqqzV5ze7NDIThzd3BJjXUYNfu+70OvWlQ/
	Rp9F+06uJj1FYY/9slK6I/ceMHKzUoavR+4nFohBs2zPAFPgDnlWSz4rMnGJrCoxZV+Vfnj5pvpDU
	TVAg0NMkg6yvR3YF4bRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gltrX-0000rh-AL; Tue, 22 Jan 2019 11:04:59 +0000
Received: from mail-he1eur01on062e.outbound.protection.outlook.com
 ([2a01:111:f400:fe1e::62e]
 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gltrT-0000qq-Ql
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 11:04:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzePpS4eVYoxpHQQZs61xQxHykqVKZyXHqSG3794VO8=;
 b=LMqXiGZ7EKf4aopL7wZ8NXciVXP9Znuw9MWi+zGBqWpFVmelMQImhnlYhDhdv7665RiSCLx/T01FllMR6lD6lha0sZoFUOfQTW1iBfXRdfHvO5i2qrTi5yNTGe2GyvGmqHqtxlSan7SWeHppZwZbb8MN/r+iZx9ZqdLzbxvH2IY=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5875.eurprd04.prod.outlook.com (20.178.202.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.31; Tue, 22 Jan 2019 11:04:48 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1558.016; Tue, 22 Jan 2019
 11:04:48 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Marc Zyngier <marc.zyngier@arm.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] irqchip: gpcv2: make config option visible
Thread-Topic: [PATCH 1/1] irqchip: gpcv2: make config option visible
Thread-Index: AQHUrwExKd8SdkCETUqu4TDod0IgjqW0vfmAgAAJiQCAAAZKgIAGVosg
Date: Tue, 22 Jan 2019 11:04:48 +0000
Message-ID: <AM0PR04MB4211ACC01F82236A7A34944780980@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1547796918-29790-1-git-send-email-aisheng.dong@nxp.com>
 <25cd3e29-e365-f0d4-65a3-b3af69acd9cd@arm.com>
 <AM0PR04MB421158B2E042D623792A296E809C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <77ecfcfa-16fe-a3e2-3d6b-90cdf999b316@arm.com>
In-Reply-To: <77ecfcfa-16fe-a3e2-3d6b-90cdf999b316@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5875;
 6:vMVxbCNE0IueUwEMCempuSEXNuhQUPV+vn1iiv96D9lgfwCNBkT4SK5TS4rOTg8NAVIi9z9DPu20R9BljExFc3oNhphLB57K4rKxjKU16yOYJ7AU+r7NVUQGGbFXpO7srlAO/CCizmbD4eQHDCSnlOZLe0HbErIRnOXp/2SEUe8ldfaDyqIAAMZohAT3mk/hU2rDxwy6baIKlZSin+5A0kCwgjXuHaYAwoWK9Igi1eVQnTVdLOxGLU44NNhxJFFuGfytJ9lJ6jMf8pU6dZ2zY1IK+QFEQB3d7WLuweKDn8i86SbzjRVDRYhN5g55+BmMGV1ANiYaSD6SVfrtud333htNol2W0RclbEJVkOToxY7673S9Z0Rj7Xi36XM8fs1IfakmESkKxPgrVTydqOpnoJdiWaLGSalpE62bmVsWcxKhc3+g19rpw+iDFic5xSTPYlqgU9jQrpNV6VYcO7lNow==;
 5:y3hUBDGWRLbZ/Rk6Bk2ePcZ9557e/1aAtNcDsHm5FlYsRw6Gje0HZsxWPB/agfWTY4vMiks+CrXayiledFGOH5ISV0+ciBO+o6RXDxvvNf5+Dnr/6vDkO5TVsJrFDtB9IO1BDLfMbKcqu5a4jhPpxutLjBouyjrmgea5KpMbLMGHB4Q96kYZLbZEW2X5of+UOXpu6YaL8FqE2nvV65UjZg==;
 7:5jkO7FpetjVJPsJiR2KQrDrG1lllzrY+CSNzfYhVyOxSgrLPrp4HRFf/0LQHhG4H3hKV08EyNCdG16hRc2AcFCdx6MPCJMUQdCmZsx/uVeVPk9T1BRjMTQXgQ1MUFybeENzRcud+QihoWqS9sCrsyQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 69ad3122-c40a-4e0a-7882-08d680596cd0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5875; 
x-ms-traffictypediagnostic: AM0PR04MB5875:
x-microsoft-antispam-prvs: <AM0PR04MB587518A99BDCD7870AD108DE80980@AM0PR04MB5875.eurprd04.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(39860400002)(366004)(136003)(346002)(396003)(189003)(199004)(7696005)(6506007)(76176011)(74316002)(93886005)(478600001)(71190400001)(71200400001)(68736007)(3846002)(106356001)(8936002)(2906002)(66066001)(86362001)(6116002)(81166006)(105586002)(81156014)(8676002)(55016002)(6436002)(4326008)(25786009)(2501003)(256004)(14454004)(9686003)(97736004)(305945005)(53936002)(44832011)(229853002)(6246003)(33656002)(26005)(11346002)(476003)(486006)(99286004)(7736002)(54906003)(186003)(39060400002)(316002)(102836004)(110136005)(446003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5875;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H5WJ/0rIcbLVWxJwlro7usyTxJF1qU2AuGsTz3jH621vfLgzdUwzrsBspPwQ+RiC5t+k1dXQdixDRZ70Xhk+NLaXGiEILfPjdJnFuXdIa9qiELt7yv/vsxlEfrTwNYwIwI8yAlz/xodTUWtgUtjoX4aLqgX0+Snb0Gwf85MbmBhBp6aAkMqZB2UkemNEG/jzrenheyoBUGJ5oF0DNKS9WnbcxRozgWtr3iegL1YYbxNbbjCH51wbIzng+UlizF8TOTP5F4ZKYAZIt3YxVXx/TZ6oq4KgBYpEeyTquDT0YCTi03gezMIBWa9fs3mBXImTxi59SF7opYGlifn3YOGqZzRtuDJwJI0hAJigaAU9VO6tco1cW/vR4Z/MrSN1p08cF7xmhYVgDsFvDud55TESuaZEAJpqm2gb4KRzIVCfYw0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ad3122-c40a-4e0a-7882-08d680596cd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 11:04:48.5260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5875
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_030455_868214_35268B1F 
X-CRM114-Status: GOOD (  19.19  )
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
Cc: Jason Cooper <jason@lakedaemon.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



> From: Marc Zyngier [mailto:marc.zyngier@arm.com]
> Sent: Friday, January 18, 2019 6:10 PM
[...]
> >>>
> >>>  config IMX_GPCV2
> >>> -	bool
> >>> +	bool "i.MX GPCv2 IRQ chip"
> >>> +	depends on ARCH_MXC || (COMPILE_TEST && OF)
> >>>  	select IRQ_DOMAIN
> >>>  	help
> >>>  	  Enables the wakeup IRQs for IMX platforms with GPCv2 block
> >>>
> >>
> >> How does it help exactly? It is pretty difficult for a user to know
> >> exactly what they need. I'd rather see it selected by ARCH_MXC, which
> >> makes it
> >
> > ARM64 SoC maintainers suggest not add more driver specific options
> > except an Generic ARCH option.
> >
> > As GPCv2 is also used in MX8MQ. So we may select it in armv8 defconfig.
> > If this option is invisible, we can't select it.
> 
> And conversely, users have no idea of what letter soup they have to select to
> make their HW work properly. Selecting the driver when the platform is
> supposed to be supported is the right way to solve this problem.
> 

I think the problem is that we have no platform specific CONFIGs for arm v8 platforms.
We have only one CONFIG_ARCH_MXC for all MX8 SoCs, e.g. mx8qxp, mx8mq...
Only MX8MQ needs to use GPCv2. Selecting GPCv2 under ARCH_MXC means users
have no chance to disable it for mx8qxp which does not need it.

We probably could introduce SOC option under drivers/soc/ to do the default configs
selection. But we've already handled all other driver selections in defconfig
e.g. firmware, clk, pinctrl, power domain and etc.
Not sure whether GPCv2 should be an exception.

Regards
Dong Aisheng

> Thanks,
> 
> 	M.
> --
> Jazz is not dead. It just smells funny...
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
