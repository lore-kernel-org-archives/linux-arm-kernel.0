Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546CFC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:56:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246A420870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TdSdOWph";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UTO6oC9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246A420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gGP3N4GRlRRx604QfqbyAJZBu5EXoiptNkVGTHOKuKA=; b=TdSdOWphU/5k+n
	t9caellSFS/IszdI38ctJyJWN057ZeTuXvWq8DadksH19E8kF7zx+18V1ZV5rQ+Y9kirRq/+w9mtV
	La6X/BHU0bhpXE+cMq+jKeu3GucYLQcUlXExndAfutNhKLfTdwM53h6yJvjAHV6E4JhHEedJpz+XA
	xtM3t7SHl/y09cl0hpMHof+Z1HkZxkm5KLxRvTnBbtt5QM/5zvBAreFCj8c7PtZdRM1715WOrijmh
	jr8u0MTL+WgcI53K6C9y20QKRVxtvTfZuGzndx7xJM1KgiAfBXLoxZ2VmxPfetB2pIUXSPbIiex8/
	r/tVVxw6n9D2I78e0OkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gltjd-0005JL-Oz; Tue, 22 Jan 2019 10:56:49 +0000
Received: from mail-eopbgr10073.outbound.protection.outlook.com ([40.107.1.73]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gltja-0005Iy-EH
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 10:56:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJdj1CZnxVI6V6ybj/ebBb0hDieEi/X6R1ZG0CjgzWs=;
 b=UTO6oC9IpTEtjaSasoVhBhwtWCNdNyG1Uel8kgRhkvM24YdEf2zH+6OWOEr/GOj6H0FYl1SD5cnW2h8QwO6QGtwMgMS8nSoxQ4yC9YgWremmLAgXQ0/iVlzs9Exzi8LqVvfOAhisTYYmxjJ4BKnicVCOjmbcFYkjFPUp8jQxGcg=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5170.eurprd04.prod.outlook.com (20.177.42.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Tue, 22 Jan 2019 10:56:42 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1558.016; Tue, 22 Jan 2019
 10:56:42 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Marc Zyngier <marc.zyngier@arm.com>, Lucas Stach <l.stach@pengutronix.de>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/4] dt-binding: irq: imx-irqsteer: use irq number per
 channel instead of group number
Thread-Topic: [PATCH 1/4] dt-binding: irq: imx-irqsteer: use irq number per
 channel instead of group number
Thread-Index: AQHUrwLwJbVcVt8a/UCLFkmrL3vOD6W0tw+AgAAOR4CAAAGp8IAAB5UAgAZQ5oA=
Date: Tue, 22 Jan 2019 10:56:42 +0000
Message-ID: <AM0PR04MB421189505D3F196A82DEF19A80980@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
 <1547797668-30342-2-git-send-email-aisheng.dong@nxp.com>
 <1547801291.2626.3.camel@pengutronix.de>
 <45c7e5b6-26bb-81b1-093b-96312a1788ec@arm.com>
 <AM0PR04MB42114D5B25B23C0D7FFF95BA809C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <ef6eb38d-8e74-a55d-6d78-516d81fa957f@arm.com>
In-Reply-To: <ef6eb38d-8e74-a55d-6d78-516d81fa957f@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5170;
 6:70FUtE9SvAKrGQPtsouBxKKofx4j/BCSvSUikxJXaRbMrWGKabG6Bm/G3tWwWSvKbVOAvT9kbYyF5oe1jwgMI5lObY8F05iN6+ZF/cs6N5L9KaSOijJyLoIksM4YsgPIc6r0YZl+i/xRBQQrxfueSO/70qnQXOh5mvZxy88TTZ7ayrC9T7y8QUaFRvoseVnYZpjEqvrMoZS6059WlOsGi4Y/+7ixPOYBFqkGCvWAEh+lGKMwBs+SqIHWg12kBD0gAJGh86AjXXendix8XG4RmPJfiFc7cAPRe77gAQbzt5K6mhic98totoFBQUEHBX1qTZMmRcabzA9QPiRKtbehR/n0nGSeigRaHEC4/CVOCJFLX0C8vUOUtnTdax4Fvx72iZzBAEdy2Hc/MqwzJDiI4nieamhUtifVA5FKvE6Wwl6ns905H9txrjbx8cQAa+HD6hW58x4zSQfGBuEpX69WMA==;
 5:/z3Cbk+N5gz7RkwYyvncdkbEOn435zurl8r1DpC8uyX0T1VDfoaBfUvTMPiWtBVcapXAsuCLcUrnLIcdf0lx0lHCrYCFHn9lnab1pbGm4CGi4gTdLPckro4qRGGRsIx/awIKgjMuMMYVvPlZUGY25xG971/eJgmTgu0DiOKn3yC3JIKPViPtp6+sCxVat1rmgAc8vX3RKGsnMOeHsWpi0g==;
 7:Cm4gHFHjTlpSLNNAHO2eoBE5LIMWOaGZJoFNXTlCktqvSF1qJTjG5zvDqbd2hdvMRBR1qy6B5lpS4h2AzOVQBPcyV56cwrqhH02xGyCMntDJdRnwPS1LGZO0uBpx0PlnDJDNIik52cn1UETCgOx1tA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cb16006d-1c06-4141-52e0-08d680584b0c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5170; 
x-ms-traffictypediagnostic: AM0PR04MB5170:
x-microsoft-antispam-prvs: <AM0PR04MB517005581E6B319A02A033ED80980@AM0PR04MB5170.eurprd04.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(74316002)(93886005)(14454004)(97736004)(76176011)(66066001)(305945005)(53936002)(102836004)(6506007)(9686003)(44832011)(2906002)(7696005)(86362001)(53546011)(256004)(14444005)(6246003)(7736002)(2501003)(186003)(25786009)(99286004)(106356001)(71190400001)(26005)(6116002)(105586002)(71200400001)(3846002)(6346003)(33656002)(4326008)(110136005)(486006)(55016002)(8936002)(11346002)(446003)(476003)(54906003)(6436002)(8676002)(478600001)(81156014)(316002)(81166006)(229853002)(68736007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5170;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GaBpy4hoB1VDEpwn1p43XhDYLDy8JeGW6teXCfgRhBNP3q2ktTjwxDAxg9mEuBZ/GtRezt1mt6e3lP/2Ce9WGDuQGqVo84jX9FhT1wu0g3FucNchRAUa1UpWT1wTu4P5yN9M1/KobUUPbi9nVPwARuXFqnyot3HUpqTK4Z7OrpLGJFDHIvE565sCpUSijySKj6ytScawmJFewGjXdnFO9xMz8uNtuVXW9WTjPU2Jg8T/ihZ1jXu9JfT0Zd/6h5Y1bmec5hMPUeXNif4xMnDF16kW/epGsOFJhKjXMv2RAYbmqmo+bfQ4LwGTwrOkecxISGB2xCU1Omd5Y1MuPUKdtpLVn0k7rjtnpZ2zN/XOMCTOxDv+IxPvrTbEVBbHeLfP99GWkyAmbDy3ed4F8SJo7Wh6sW7hUwAdeRQagdqHxKo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb16006d-1c06-4141-52e0-08d680584b0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 10:56:42.2959 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5170
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_025646_479100_665187BC 
X-CRM114-Status: GOOD (  22.00  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> From: Marc Zyngier [mailto:marc.zyngier@arm.com]
> Sent: Friday, January 18, 2019 6:12 PM
[...]
> >> From: Marc Zyngier [mailto:marc.zyngier@arm.com]
> >> Sent: Friday, January 18, 2019 5:39 PM On 18/01/2019 08:48, Lucas
> >> Stach wrote:
> >>> Am Freitag, den 18.01.2019, 07:53 +0000 schrieb Aisheng Dong:
> >>>> Not all 64 interrupts may be used in one group. e.g. most irqsteer
> >>>> in imx8qxp and imx8qm subsystems supports only 32 interrupts.
> >>>>
> >>>> As the IP integration parameters are Channel number and interrupts
> >>>> number, let's use fsl,irqs-per-chan to represents how many
> >>>> interrupts supported by this irqsteer channel.
> >>>
> >>> Sorry, but total NACK. I've got to great lengths with dumping the
> >>> actually implemented register layout on i.MX8M and AFAICS the IRQs
> >>> are always managed in groups of 64 IRQs, even if less than that are
> >>> connected as input IRQs. This is what the actually present register
> >>> set on i.MX8M tells us.
> >>
> >> Also, I'd really like the DT bindings not to change at every release.
> >> So whatever change (if any) has to be done for this driver to support
> >> existing HW, please make sure that the DT bindings are kept as stable as
> possible.
> >>
> >
> > Sorry I should clarify it a bit.
> > There's still no users in Devicetree.
> > So I guess we can update it, right? Or not?
> 
> What do you mean by no users? This driver is in 5.0, and I assume people are
> using it one way or another. Not having a platform in the kernel tree is pretty
> much irrelevant, as the kernel tree is not a canonical repository of existing
> platforms.
> 

I understand the concern.
Theoretically yes, but it's very unlikely that there's already an out of tree users
wants to use it for a long term as we're still at the very initial stage.

And the most important reason is that current using actually is wrong.
We can also choose to mark it as 'depreciated' and keep the backward compatibility in driver,
but I'm not sure whether it's worthy to do it as we may add a lot ugly code in driver
benefits no users.

Ideas?

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
