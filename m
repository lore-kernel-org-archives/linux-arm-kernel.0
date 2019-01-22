Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7514AC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:27:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40B3F20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pvwky4i1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YQhyKidI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B3F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AnZyAnLDsjvHVFeoov+xws+SSgzXebuQj5MHm8bR7vA=; b=pvwky4i1dGfMBf
	ONBlhWI7iENV7zP66IrgsJHlsmspjyCd9DqXcZtPstMPgSloQqawZul0ERpcY0KEX5bSezzozVeY8
	SZVmAq18NUTWjCV2UKcqgvISzdt2t2caPoUmwMw7O8ZhrJkGecFkBVE7DwT8ymvMWqRr7lri6w3H0
	S/8obqzuW7/E4DO6Qnd1f5alw5LJsVLCIX9sE/b2Bh2/Z7gLh18WY1nyp2i8tn8POi+qFvCVrkLrd
	hmmW8J/B+hkcWrcum6QLaGGEhzTZ1h62T+I2nijR/4mZ+hRf3bCY3it+nbkFIsr/a2vNQo9RZfht/
	cmWFyaLQi0spYiMfexjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glv9G-0001pM-5L; Tue, 22 Jan 2019 12:27:22 +0000
Received: from mail-db5eur03on0627.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::627]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glv9C-0001dt-Gf
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 12:27:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zS5evjuSODvoc1pVgY2FjDOE0o+fUBX/EujMcsaGncA=;
 b=YQhyKidI+2q6iyKn0Rq3ZK4Yv1nu32QcmysiiND6hIvz0oA2iRWOIWj203u19nEmMFuyfcP8k20R6QyXYlXJWIWn9BZCAgJPphhD1ucfzaU6/vbtTKUTSa65jLN/J3j74ES369mX3Bk/I29bZdf/ALTdEmZpn178HOhmkk6H+JM=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4227.eurprd04.prod.outlook.com (52.134.126.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.25; Tue, 22 Jan 2019 12:27:12 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1558.016; Tue, 22 Jan 2019
 12:27:12 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: RE: [PATCH 1/1] irqchip: gpcv2: make config option visible
Thread-Topic: [PATCH 1/1] irqchip: gpcv2: make config option visible
Thread-Index: AQHUrwExKd8SdkCETUqu4TDod0IgjqW0vfmAgAAJiQCAAAZKgIAGVosggAAMJICAAAg90A==
Date: Tue, 22 Jan 2019 12:27:12 +0000
Message-ID: <AM0PR04MB421134C538A0235C0595AD2580980@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1547796918-29790-1-git-send-email-aisheng.dong@nxp.com>
 <25cd3e29-e365-f0d4-65a3-b3af69acd9cd@arm.com>
 <AM0PR04MB421158B2E042D623792A296E809C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <77ecfcfa-16fe-a3e2-3d6b-90cdf999b316@arm.com>
 <AM0PR04MB4211ACC01F82236A7A34944780980@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <867eewapjy.wl-marc.zyngier@arm.com>
In-Reply-To: <867eewapjy.wl-marc.zyngier@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4227;
 6:I5ApTKBFrtf9+IhHZdngRvcHjqzGCfqB3LBPvbc6YYFrbp6HwDBsmpK1FiLzcjaIWJJ8nT75UuG25wWuYet0ANkuWy2VQcCdzKeliofH1EK2o53bt/7LeCWF4TVlAwJADXhi9v061RPsEsCb7ejC4Yy/GLOn3f4JPlLdkFicpfEdJ2AFofMa3VCkNMDXcNSBwD0IlWAWBQgXIrg3Bmo4QoaR5URrFA+z0vCKuMj5cauReHO7UuBav1U8fwthILYDUfl0w8PmBn1rzUIzFYrG3xPz2gU8wCBj5EU5l/oBszvUks3UqgPMcs8tBGv/YqspSv0rNWL4rmVfUvm8Vxxpd/Ox5berojfmm3lRolpWERBvLvsCPqpGWXBGZSArU27DjkjOILol0mb5nCf4WwTD2jQr0oZJoRN8TbWH67shKZg97EQchXMxXYc+zj3HJBlrZnPOLM0S/WNKQNHOl2aLHA==;
 5:ExfLuZVVDdh9aAjxIe2IcQlkOQ052G8zKjRhc0v9BdJyXifl3suPvLLYtLDlxymT3KsdGOjU+V6FjYSiSKFQVUMZ7uT0kdeSx5JDNJcpxe/cgFQ1uZQFpUYD2tOydZTSvYOLzpnXOehdy8cyEtk6zj/kvv4KV1EoMjRWaNxuZkbW4FWmFEcBgh47UbQriMVRMlmcZ5JmZMVIwP00/vaAXQ==;
 7:PvmG8VXdL9LsLGFsK6/9Rqp+45mjzBszuzbuYs+3g3XeSj64EStMr9axICfCxBms8wawvTHq5iJz7CI2DcneyP3hHoE56AWBOCKAMTbji2ovVYsV3PuWojGZKAwpokqR9iWHo7dKmkMILI82chbzcQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fbabd3d2-895b-467e-b591-08d68064efdf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4227; 
x-ms-traffictypediagnostic: AM0PR04MB4227:
x-microsoft-antispam-prvs: <AM0PR04MB4227D33760C118F7B2C2475A80980@AM0PR04MB4227.eurprd04.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(346002)(136003)(366004)(39860400002)(376002)(189003)(199004)(51914003)(71190400001)(71200400001)(476003)(99286004)(8936002)(486006)(44832011)(106356001)(478600001)(6246003)(446003)(11346002)(105586002)(305945005)(97736004)(53936002)(2906002)(7736002)(9686003)(25786009)(186003)(93886005)(55016002)(102836004)(68736007)(6506007)(6116002)(3846002)(26005)(7696005)(14454004)(74316002)(66066001)(81156014)(81166006)(39060400002)(86362001)(6916009)(256004)(33656002)(6436002)(4326008)(54906003)(8676002)(316002)(76176011)(229853002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4227;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: z4RKL3SFjEZJ5L4g98NSu6LA0THns+HlKmFucul/uIdJT/ur1MH2A8dHsP2+o83h+LXeAQ7kVJ7gaPEVzQZCqcHHRy5HbkkgGeA3tPo369UJJa7+zks8C66ingpF+qYiVXLmxVWlhN38dNX4eTuFj/LD3r35dFVhWyZxj0PgJgnYT0izEgWAJLs34M9OUIEKd8CXW7OwEUN44+NRnMzjhXyQUbtg3UN/m8gwLbK+Oexwgbmyn51slnWyPwroNV9gxao0m7pHupTcXiVEJVbPZpL6UGngx27NKRf8w+3huEAA/ghWB6didQLhM2RVOaJdRy7Yo6blLUhK6kuomhOi2o8AVzTpf4Og4/eHyyVEZXxGoThE76U6/B1mMDXSKCT2ORGvsPeC9qiHDIdzjXK/JeP0UYxlaOnleNEtlI9mvVs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbabd3d2-895b-467e-b591-08d68064efdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 12:27:12.8163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4227
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_042718_567804_83A8E7E6 
X-CRM114-Status: GOOD (  25.23  )
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
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Thomas Gleixner <tglx@linutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> From: Marc Zyngier [mailto:marc.zyngier@arm.com]
> Sent: Tuesday, January 22, 2019 7:40 PM
> On Tue, 22 Jan 2019 11:04:48 +0000,
> Aisheng Dong <aisheng.dong@nxp.com> wrote:
> >
> >
> >
> > > From: Marc Zyngier [mailto:marc.zyngier@arm.com]
> > > Sent: Friday, January 18, 2019 6:10 PM
> > [...]
> > > >>>
> > > >>>  config IMX_GPCV2
> > > >>> -	bool
> > > >>> +	bool "i.MX GPCv2 IRQ chip"
> > > >>> +	depends on ARCH_MXC || (COMPILE_TEST && OF)
> > > >>>  	select IRQ_DOMAIN
> > > >>>  	help
> > > >>>  	  Enables the wakeup IRQs for IMX platforms with GPCv2 block
> > > >>>
> > > >>
> > > >> How does it help exactly? It is pretty difficult for a user to
> > > >> know exactly what they need. I'd rather see it selected by
> > > >> ARCH_MXC, which makes it
> > > >
> > > > ARM64 SoC maintainers suggest not add more driver specific options
> > > > except an Generic ARCH option.
> > > >
> > > > As GPCv2 is also used in MX8MQ. So we may select it in armv8 defconfig.
> > > > If this option is invisible, we can't select it.
> > >
> > > And conversely, users have no idea of what letter soup they have to
> > > select to make their HW work properly. Selecting the driver when the
> > > platform is supposed to be supported is the right way to solve this
> problem.
> > >
> >
> > I think the problem is that we have no platform specific CONFIGs for arm v8
> platforms.
> > We have only one CONFIG_ARCH_MXC for all MX8 SoCs, e.g. mx8qxp,
> mx8mq...
> > Only MX8MQ needs to use GPCv2. Selecting GPCv2 under ARCH_MXC means
> > users have no chance to disable it for mx8qxp which does not need it.
> 
> And where is the problem to select this on platforms that do not strictly
> require it? Code bloat?

I think it's not a big problem.

> 
> If you want fine grained selection for people dealing with a single SoC, make it
> depend on CONFIG_EXPERT. Don't force this on unsuspecting users who expect
> their HW to just work.
> 

Seems not too necessary

> Something like:
> 
> config IMX_GPCV2
>        	bool "i.MX GPCv2 IRQ chip" if EXPERT
> 	def_bool ARCH_MXC
> 	select IRQ_DOMAIN
> 	help
> 	  Enables the wakeup IRQs for IMX platforms with GPCv2 block
> 
> >
> > We probably could introduce SOC option under drivers/soc/ to do the
> > default configs selection. But we've already handled all other driver
> > selections in defconfig e.g. firmware, clk, pinctrl, power domain and etc.
> > Not sure whether GPCv2 should be an exception.
> 
> I think something like the above should be the rule. Configuration feature
> creep is not helping anyone.

Got it, thanks for the suggestion.

Regards
Dong Aisheng

> 
> 	M.
> 
> --
> Jazz is not dead, it just smell funny.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
