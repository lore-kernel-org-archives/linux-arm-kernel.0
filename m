Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30392C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:49:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F090E2087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vrf8bE+B";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vLVusaK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F090E2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4ZqQLmcF1blm6fQ1cTzy3gZAuA1GtJgsfLmYuuT9qDM=; b=Vrf8bE+BlAmeui
	Nw2Ft8IdLYKRClMlI0Hp72/d4cvaSdKftISmxWEiL1GRwdy3txMdY5rxt7E+JlAFuysrv7BdJog9k
	jCiaxwT8Iq/7bSTKB/aCfUDI308iY5LnFSjUrPiA57vt4NvLVhQt3N2QpA9b4T2aim35oAB1dg6hc
	gOg5bsfOqcF/pERVJ36ZgTEelze7np2GRdru6Aik0ZiQilYN8dDwuOoQhM4oJq80hYcysTF69Faci
	H+T4bzdB2/K5r/nrKaL6U9oNtK5EQfMKvvG00iMhjGwveGc3IJuP617hlSQCa7zNE10NlXka/4MdJ
	7M5xjwcnP8zHnyDBW+dQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkQmc-0006QD-Ro; Fri, 18 Jan 2019 09:49:50 +0000
Received: from mail-eopbgr30049.outbound.protection.outlook.com ([40.107.3.49]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkQma-0006Pp-47
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 09:49:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRl0xQTuu9dX76rJL1qKDryW3r2elznaX/T/8fKZkTk=;
 b=vLVusaK6dyhof0Jkj++JhylU80w2IdKj5fxyM3MgeG3BqTmAzTZ8j9yMAxvBezhCMAWfJhS/U+Fzz+mHEpJSiENZ9gRQSwGYiyRET2/EzUqTz0gsYZ8s+OZk4XeHnFORnapwiaL1uwRXW+N39bdp+jmSbIo3HcBnmT3faD+F5yM=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5923.eurprd04.prod.outlook.com (20.178.117.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.19; Fri, 18 Jan 2019 09:49:43 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 09:49:43 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Marc Zyngier <marc.zyngier@arm.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] irqchip: gpcv2: make config option visible
Thread-Topic: [PATCH 1/1] irqchip: gpcv2: make config option visible
Thread-Index: AQHUrwExKd8SdkCETUqu4TDod0IgjqW0vfmAgAAJiQA=
Date: Fri, 18 Jan 2019 09:49:43 +0000
Message-ID: <AM0PR04MB421158B2E042D623792A296E809C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1547796918-29790-1-git-send-email-aisheng.dong@nxp.com>
 <25cd3e29-e365-f0d4-65a3-b3af69acd9cd@arm.com>
In-Reply-To: <25cd3e29-e365-f0d4-65a3-b3af69acd9cd@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5923;
 6:LdH5pZ5pPO5Akf1ttrcKnyqQcMKkXPXGspmnJctmd9FWlHzRhedGnDeJX4i4M4QgpGeZGXak6y4TXOrgZAuRMSrWn02hlTv4uml0uHOUJFLMx57FXcKOJ8WN+BxTuolUnE1AXlCFSpcKsUEA44mlDLP3sObqwwcYLZ/VfORG1k3PIyvTDWmfxZLMgitlpm23CQCtQ0f6R6ZXTZT7WDQIfN9heMy0xTj6cXnOmYGYNRxD7304sRwOl/8/66qkE4NSXRtk2pF5XRdVVK3w8ERTP1/lwwLJ5yMPn3Jtli+XgsQRXvq3ON1Mh7HYOaP/9akvgSYtby5nOvkUjGO0HVVB4UO47MdjWNFvfgvE3/7wWleudFW/Y8e0Ghke/J0SpohFYScjMIvguUC3yP/Z7sk+LUfVUyQPOrlQv4G3U9smyaFxqBPcxzf6SLQRryax7OXYlltKKqqTASZtrK8Al5cF0w==;
 5:OuJliVmdQqZLU6ki4F8KVl2d2QKWGoJG71zSXnf5felUmQhKCchXu1J1PpGP9FXPJaaelLQArvEId+QTtwdVgnvpO9CcVp4G0y7im/Z4OF9Z0MFxHdTQJS+mMb7I6U+RsYRUXFWxxngSqLKxDkYiwW8zqEkIIoTarA6eolfv4V4ywy7L8t3UcmfCV9sgkgI0QhSdo8D8AYgKbAGmdOKnSw==;
 7:CgUStssGVkKeqH/1AcQGeQLVLd++noGx1fwS7Yskac1lbJgOauliIgnNipEr5rY8b5I9Qoppe7TMF39k4tbhaF9y6tfY2fAll3pJB0QuG06X0QKl3Cd4z+mgp0q8Dr96Umk9tYDbs0KjQC/easWJJw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 67d2b6b2-3018-41ff-7f1b-08d67d2a4614
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5923; 
x-ms-traffictypediagnostic: AM0PR04MB5923:
x-microsoft-antispam-prvs: <AM0PR04MB59236E684086B3A7323B3775809C0@AM0PR04MB5923.eurprd04.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(366004)(199004)(189003)(25786009)(97736004)(99286004)(6246003)(76176011)(256004)(71190400001)(53546011)(14444005)(102836004)(53936002)(9686003)(6506007)(39060400002)(7696005)(4326008)(81156014)(476003)(33656002)(446003)(8936002)(2906002)(8676002)(71200400001)(81166006)(11346002)(2501003)(6436002)(486006)(229853002)(3846002)(110136005)(106356001)(55016002)(44832011)(105586002)(316002)(68736007)(6116002)(54906003)(305945005)(74316002)(186003)(26005)(5660300001)(14454004)(478600001)(7736002)(86362001)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5923;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: shxC1lXlmhEGVLv54hod2mLRAv7/vQ1pg53daFiHUgOA5GgnInDAkHzieNs9k4DKGV3pb5GWvtKd0dsp6/1GV0FFn4UGV1F9N0tEuolC9HK2lxNbljs87CK5rfEC4NJblYRHv0pQaWElIfo+kNm7BInmnPnwxY8Ru0Zf1QJ85BgO2t0YdnOViP0nlSVshLwkWLP5q9y7t5sl3fjzRGZcaAFYwjN807UHvO1YT9eRg1ScaycUeQWsk7eQDmWXWkp6JID/nv6PyQSwNb8bAOs7OqRAHIIFrjQbS8iqf9C+3OP3UOwo5+SPLEuiyXGBE4FNdhRoqKiq9mTYiVgZOyZLcgwZnNiiaqecXajrGr24xl9wEtVINuSMkk5jC+xD5fNfs/l1lRAOcdkEUVAt/iv7dbtAi7YebpqCAk9Fw92jiyk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d2b6b2-3018-41ff-7f1b-08d67d2a4614
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 09:49:43.6450 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5923
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_014948_168702_CCA031CD 
X-CRM114-Status: GOOD (  19.24  )
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
> Sent: Friday, January 18, 2019 5:13 PM
> On 18/01/2019 07:41, Aisheng Dong wrote:
> > Make GPCv2 config option visible, then user can select it in defconfig
> > for ARMv8 platforms.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  drivers/irqchip/Kconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig index
> > 3d1e607..ed04d47 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -289,7 +289,8 @@ config RENESAS_H8S_INTC
> >  	select IRQ_DOMAIN
> >
> >  config IMX_GPCV2
> > -	bool
> > +	bool "i.MX GPCv2 IRQ chip"
> > +	depends on ARCH_MXC || (COMPILE_TEST && OF)
> >  	select IRQ_DOMAIN
> >  	help
> >  	  Enables the wakeup IRQs for IMX platforms with GPCv2 block
> >
> 
> How does it help exactly? It is pretty difficult for a user to know exactly what
> they need. I'd rather see it selected by ARCH_MXC, which makes it

ARM64 SoC maintainers suggest not add more driver specific options except an
Generic ARCH option.

As GPCv2 is also used in MX8MQ. So we may select it in armv8 defconfig.
If this option is invisible, we can't select it.

Regards
Dong Aisheng

> unambiguous.
> 
> Thanks,
> 
> 	M.
> --
> Jazz is not dead. It just smells funny...
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
