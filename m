Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A025CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:46:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7019F2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BRr7gMpw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kaWPi8VW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7019F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yv0q+hGpL2soZyPtEjsrKLbqwUuvc/XnHpvMYDAB6sY=; b=BRr7gMpwXY+Nej
	YfuVGlO+/llitSQXiQT81pWeD08H3KZKe+Hc71e43laoOrV2SI/ker6P30uPedEe95nNlHBOrVbcm
	BcQpnn0niYTVr7WeW7kll1VUWLZ6bVfEV7DkGGBRtYm3aaNbAY6aOaoK/8isfoM2BhucMaF3wnpO5
	qY0Axf8Cn25D6A5FO33ocSFA943xZx8H5mGJJbVRc3mCWF8kq32Yj1uT8a3h1b43VzjYJe02+fHm9
	61iIVaLy7MJGdNNH5gKYdbd/Q5psriQBX0KBNr2eCIjVcHVC82MFj0C0seOWQunBS+X1kSeRWkJQD
	rj/QXhBFRpF/hLq0AgTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkQjc-0005pC-1L; Fri, 18 Jan 2019 09:46:44 +0000
Received: from mail-eopbgr30083.outbound.protection.outlook.com ([40.107.3.83]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkQjY-0005oi-Sq
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 09:46:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsEUAB7JwjIavoXB2iwni60rmnTFbLZbZMCqRi8mjpQ=;
 b=kaWPi8VWW4M8GDzK77Bc069Lja9F63q/lhz/9XF/f6o+VqcB3zLFa578aIWxsjqypwsCs5GfjDUykLi38F9aHEKbiV+GskeirHMerwsws5a5628vjhKa53JnFCdjfNcmSbMO0TFVIeiWl7acVSqNnvyZsgSc3QTN+v0Bv/S9oKk=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5971.eurprd04.prod.outlook.com (20.178.113.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.19; Fri, 18 Jan 2019 09:46:38 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 09:46:38 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Marc Zyngier <marc.zyngier@arm.com>, Lucas Stach <l.stach@pengutronix.de>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/4] dt-binding: irq: imx-irqsteer: use irq number per
 channel instead of group number
Thread-Topic: [PATCH 1/4] dt-binding: irq: imx-irqsteer: use irq number per
 channel instead of group number
Thread-Index: AQHUrwLwJbVcVt8a/UCLFkmrL3vOD6W0tw+AgAAOR4CAAAGp8A==
Date: Fri, 18 Jan 2019 09:46:37 +0000
Message-ID: <AM0PR04MB42114D5B25B23C0D7FFF95BA809C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
 <1547797668-30342-2-git-send-email-aisheng.dong@nxp.com>
 <1547801291.2626.3.camel@pengutronix.de>
 <45c7e5b6-26bb-81b1-093b-96312a1788ec@arm.com>
In-Reply-To: <45c7e5b6-26bb-81b1-093b-96312a1788ec@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5971;
 6:yOXMgw8oaBRhWb7g9CRd6mSvFjsofTp7oVp2U9s9bk1hxxjSt9G/leDAdn7wRy4bFxvVfu+64/COIDy9hxELcuCtXXZU63n/PqsG0iBnDatqEgdrECz/eRJICB0tTKgBth4T+bonQsisQ8zDlzKHI+o8tZRnwvDyy7EuZV8AO2Ymv6BkRxJtxxI+kbN39S68iPRE/pK1pF2pE2waSm3aQV49vwLLCu22+DudcRdPIXBQin9Xyp0AakojA4ZAfKazxyw1JeQICiELZf3POzPo3QTyAnNNMuenrskPPnnabg81S+9BuIPM8G5+Of7OcUnNMFwj5wQP7DZAfy1rAN71+8/MH4H13m1jhnCPObax9oKXD4LCIvoMXTs3tjl52h2+aNNkGxAI+B409qe4+k1TvRUYoYySwlZDvKi1Q50xPBpNjJ3Bp4nVFmZjHAR6dQCthMPjUPeuCQY116KgVB9vLQ==;
 5:6OP+oY8E8oVQ5VZ4SFvU6JZxlLRIMJ2fIrX7aBuDT3vsKIClvAAM5DYBLHTVRbk1r36zkWQNDyIldHXAc3h0tCUDtzsr57/fasAdKF0qZ+KVGgPgIlEF/t/7e2sythZeacUEm1FSDw8BYbE/bZN6hSDcb+gGtGxg1y0T1eaklfy5vj2jBYbVqaWcB2dSNKLZnQq/kcApVtDuxvNXRFkP3w==;
 7:coU+URfxdQau70RQQL1kQcqRBxvcVylkwnA7V43DStU/vc0cFAiluvZYLYGkU0DZoka9rGJgipyXMFzDtXIKLmRFWO5w6FKA+Hxr3rbY52i9beak4HIPuw6yXo5ONQD7S/xcvFx6fC6pkCUw+WmkIg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 542cf225-935b-431c-88ce-08d67d29d762
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5971; 
x-ms-traffictypediagnostic: AM0PR04MB5971:
x-microsoft-antispam-prvs: <AM0PR04MB59710DD7ABD06A06FA616C63809C0@AM0PR04MB5971.eurprd04.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(366004)(189003)(199004)(3846002)(102836004)(6506007)(8676002)(2906002)(81166006)(81156014)(76176011)(7736002)(305945005)(6116002)(7696005)(54906003)(33656002)(93886005)(110136005)(68736007)(4326008)(6246003)(316002)(14454004)(8936002)(71190400001)(6436002)(25786009)(71200400001)(74316002)(9686003)(256004)(105586002)(229853002)(55016002)(106356001)(6346003)(53936002)(2501003)(14444005)(99286004)(66066001)(53546011)(26005)(446003)(478600001)(11346002)(86362001)(97736004)(44832011)(186003)(486006)(476003)(5660300001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5971;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: chYdcPe/Uq/aAAnx7OeFoFpRlkXzzRIFQPouJi5oEYRmGRjCvUzD6D2eo3fTBPurtADkcrEGI4xmU2fRInHm53dJyj+NnicGOg9s+TimAcG+hU7fCRM6mb847YKV6xwZSQRHXRh/ueHR0oxRBVMB8epu09HqArsJ/APXaadRui6rvSn9M4WV1c6LVrKVFQi0sfoGuiHQaKzq2fJRPbOzEt9Lc5AF1J0/eakI8Wm2taz7tIXeROgZLDAXC2GqaJZopMq7NRnFUeEDm8rjHJvf2a0hPbMqq1w5wS4icrUzSBhXuMjGLi8Frc+jtPuz9SMsV0RQtePKk7tnG+/aYEQyV00kuPiHgIH86451rsfxbw8cv8h55MYKA4t3oWC2Gqa2Go7EzqgbL2WkTwE+FGu17gmx7fxOPbporgcix8CKl8A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 542cf225-935b-431c-88ce-08d67d29d762
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 09:46:37.8963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5971
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_014640_929852_3CA5B0A6 
X-CRM114-Status: GOOD (  15.98  )
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
> Sent: Friday, January 18, 2019 5:39 PM
> On 18/01/2019 08:48, Lucas Stach wrote:
> > Am Freitag, den 18.01.2019, 07:53 +0000 schrieb Aisheng Dong:
> >> Not all 64 interrupts may be used in one group. e.g. most irqsteer in
> >> imx8qxp and imx8qm subsystems supports only 32 interrupts.
> >>
> >> As the IP integration parameters are Channel number and interrupts
> >> number, let's use fsl,irqs-per-chan to represents how many interrupts
> >> supported by this irqsteer channel.
> >
> > Sorry, but total NACK. I've got to great lengths with dumping the
> > actually implemented register layout on i.MX8M and AFAICS the IRQs are
> > always managed in groups of 64 IRQs, even if less than that are
> > connected as input IRQs. This is what the actually present register
> > set on i.MX8M tells us.
> 
> Also, I'd really like the DT bindings not to change at every release. So whatever
> change (if any) has to be done for this driver to support existing HW, please
> make sure that the DT bindings are kept as stable as possible.
> 

Sorry I should clarify it a bit.
There's still no users in Devicetree.
So I guess we can update it, right? Or not?

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
