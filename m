Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B959FC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:39:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8981F21019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KePTXiH7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JPUemUT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8981F21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nj0JCgF2ul4eCFAbkL2iUQUOsS1MgVZSXtB6lQtd2Ds=; b=KePTXiH7baWema
	ic0cFPzt+3uk5JIq56aailsnR7AskheVK/NOvYEIftwJLPwe8zEMsjdOKh6Y7q9+5U5duqKuNjP2j
	GaA2fMTiKOZE6xrLCpF3+umkS38N6ympYI0kiJU2FW8aBNFj8TEu07girFzFureuQ/cxgKQbCFl8G
	2Ko6N6NBHAC1vl/OklGhe8t11YrUVweyWDPEKkZ5iVAPStZyqhj2k50XcYfBxpTVksHeHDzQX5Wfw
	w0AAvQzas424RroNIIO2m/KYEOoeLLS6Hb+cBu3bGFZYGn78DgXV/G3JhKiH5Yfq8vcAiOpH73A2W
	EVm0w4ye8j6dn/Lf9VyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gltSl-00037n-Hv; Tue, 22 Jan 2019 10:39:23 +0000
Received: from mail-eopbgr150052.outbound.protection.outlook.com
 ([40.107.15.52] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gltSh-00037J-Mt
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 10:39:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/28HdpE6s64XYKW0pmD94s/0wpVPD69+bg6PEg83HiU=;
 b=JPUemUT9Hrb6gMSeUwit1sLw0VOjyLgzMDYz2z+MXcZxYbSOp/4uHNXSVpBVBF7+fiMaPztu/zE03qLSJhK5a6hOmF9HkZayy5vaw3eaBUfby3KH1s6Z+jsqKl+FjJ9+GhEtCZW+OmgAyBfK8txTjk8g1Gyp2DUtH2x+555zf04=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4834.eurprd04.prod.outlook.com (20.176.215.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Tue, 22 Jan 2019 10:39:11 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1558.016; Tue, 22 Jan 2019
 10:39:11 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/4] irq: imx: irqsteer: add multi output interrupts
 support
Thread-Topic: [PATCH 4/4] irq: imx: irqsteer: add multi output interrupts
 support
Thread-Index: AQHUrwL34aHTasx2wUetvBoWoE17FaW0uIqAgAAPyPCAAAkjAIAGQGdg
Date: Tue, 22 Jan 2019 10:39:11 +0000
Message-ID: <AM0PR04MB42111FE266342A2C2EAECC3580980@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
 <1547797668-30342-5-git-send-email-aisheng.dong@nxp.com>
 <1547801609.2626.5.camel@pengutronix.de>
 <AM0PR04MB42111D634F28492434AA9309809C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <1547806960.2626.9.camel@pengutronix.de>
In-Reply-To: <1547806960.2626.9.camel@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4834;
 6:ffgQ6ZaW9i2oFI0Q9f/HcL43pIBfbz4T1bY9WHIVW6AshTMtODmveVyQIyUXDqzPGBQjZrjrzegBN3ZBPp4GfhsJinviDPTwcJvJytj8DD6YaIZ5UzAWq2Hj4Zmf/ePaAgqRUsmNF1i1HZJmcLSw9QBdX7Roo9klptf49BB0f+PK7XF8FuFapA42eSmcmJjgguDtMOb/y6y6YAqdchx7RAOXUDhtMjtJX63JIDcFBKLyaa+6E/u1dBtS2qs7XuA13nJwk3eGEeidzxr8IZVwjek5EgcJhCCjqSLMyA9/H4ZPI0LBTuNZfzIZ9YHOXXdcxv+eor35ocpC2zVuWQ4qGDbK1S4bcRcKvlKjZ9Ja1ozvBjwvU0rhrscs7AbKXTSGkbJAmrFCHVMBcwFLL2XEHZ4oCz+LMqyop2j+wvqIfcUl9QDyJArBjUo1JZ0O5Jy89JnchUHGtrwH0ZPou/yHnw==;
 5:owNmumrxq2nTTEDhsTVN9PUWD0dc7O/LShgJZAy/G0o/TzLLR72+wRoeveU7cjKEKBK+psGg+EcSf+ayHbyvuzPckrlJUYF/YJqJvNeJUQ5ggi4I8IHoX7t7JpS3NBr7AM/jcVNL64uNIbNQ7jbHXLRZSuWk+c9HbQWErh4+otgtqJaL4XGAuKb2jqgqbt/TPQebo7ZJ/n6xP8KdKVxuwg==;
 7:4zASuMm5clwzd7ltlotboC6m/ixR7aDRup8wJjzriu+YBYjMUiMxBMSgeQIggL3eiEJdZh/DEHPOFRfrotRYKfaecG7dEYNJZtkbE/ywe2/0LVeI4Z/VxYfpKgrlV9aEkdi9GNozEh/Tx6aahhbW8A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a61ec872-7630-4288-15ca-08d68055d8bb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4834; 
x-ms-traffictypediagnostic: AM0PR04MB4834:
x-microsoft-antispam-prvs: <AM0PR04MB4834D906A742EB2D0CE161C880980@AM0PR04MB4834.eurprd04.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(366004)(39860400002)(396003)(136003)(346002)(189003)(199004)(53936002)(106356001)(256004)(86362001)(6506007)(229853002)(6436002)(102836004)(14454004)(2906002)(93886005)(81156014)(26005)(76176011)(105586002)(7736002)(97736004)(81166006)(305945005)(8676002)(8936002)(99286004)(9686003)(7696005)(71190400001)(71200400001)(68736007)(66066001)(6246003)(478600001)(44832011)(316002)(486006)(186003)(3846002)(55016002)(6116002)(2501003)(110136005)(54906003)(476003)(446003)(11346002)(25786009)(4326008)(33656002)(74316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4834;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QH2MRSnxAHBSiY8WFIp3mSXVJ4qvMjBJYaMAwdEUKonH+mCrjJRYOijY2sJrx0/zU0KpLoRLet7qbxrxcUDAUTAmd2Xz7HKci4oUHmodNPaw1xovT4Odu8kvXDQh3ag0W8c09aXakXVohlrMVZFll9P7NthqLJYMZjreoD7S0PidF7lRIucv69mGE4Ux5pNuscWWlNiS4Hl9pc2spd4r5/KXHXGXi8u5x2mSXflVW9rdZA8a+3rfKAwlUXuhyt0TUWOzl+Yj6jxjmKbZn9BHEgkREDa8m9UNsy5Pux2mZj4s37fnF3n0lyC0QeEoHdaE360lRwcV/ZmdLRRxKu9NLIGWV5xZNF2PQEKiqPDe14CVN7Adbd6gA/vfY8DztI56shC/JGspK/OOrKL5ZkMqbkclG2KsDxcHpi2CHQyvXxc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a61ec872-7630-4288-15ca-08d68055d8bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 10:39:11.4977 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4834
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_023919_753278_BA4CCE80 
X-CRM114-Status: GOOD (  25.69  )
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
 Marc Zyngier <marc.zyngier@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> From: Lucas Stach [mailto:l.stach@pengutronix.de]
> Sent: Friday, January 18, 2019 6:23 PM
[...]
> > > This has been discussed when upstreaming the driver. The controller
> > > may support multiple output IRQs, but only one them is actually used
> > > depending on the CHANCTRL config. There is no use in hooking up all
> > > the output IRQs in DT, if only one of them is actually used. Some of
> > > the outputs may not even be visible to the Linux system, but may
> > > belong to a Cortex M4 subsystem. All of those configurations can be
> > > described in DT by changing the upstream interrupt and "fsl,channel" in a
> coherent way.
> > >
> > > Please correct me if my understanding is totally wrong.
> >
> > I'm afraid your understanding of CHAN seems wrong.
> > (Binding doc of that property needs change as well).
> >
> > On QXP DC SS, the IRQSTEER supports 512 interrupts with 8 interrupt
> > output Conntected to GIC.
> > The current driver does not support it as it assumes only one interrupt
> output used.
> 
> Okay, so let's take a step back. The description in the QXP RM is actually better
> than what I've seen until now. Still it's totally confusing that the "channel"
> terminology used with different meanings in docs. Let's try to avoid this as
> much as possible.
> 
> So to get things straight: Each irqsteer controller has a number of IRQ groups.
> All the input IRQs of one group are ORed together to form on output IRQ.
> Depending on the SoC integration, a group can contain 32 or
> 64 IRQs, where DCSS irqsteer on MX8M and the big 512 input controllers on
> QXP and QM both use 64 IRQs per group. You are claiming that the smaller
> controllers on both QXP am QM have only 32 IRQs per group, right?
> 
> So the only change that is needed is that the driver needs to know the number
> of input IRQs per group, with a default of 64 to not break DT compatibility.
> 

Not exactly.
from HW point of view , there're two parameters during IRQSTEER integration.
For example,
DC in QXP:
parameter  IRQCHAN		=  1; 	//Number of IRQ Channels/Slots
parameter  NINT32		=  8;	//Number of interrupts in multiple of 32

MIPI CSI in MQ:
Parameter  IRQCHAN		= 1
Parameter  NINT32		= 1

You will see no group concept used here. Only channel number and interrupts number.
The group is an IP internal concept that ORed a group of 64 interrupts into an output
interrupt. But it may also only use 32 interrupts in the same group.

> Also if the connection between IRQ group and output IRQ is fixed, the driver
> should be more clever about handling the chained IRQ. If you know which of
> the upstream IRQs fired you only need to look at the 32 or 64 IRQ status
> registers of that specific group, not all of them.

Yes, that's right.
I planned to do that later with a separate patch before.

> 
> Can you please clarify what the CHANCTRL setting changes in this setup?
> 

IRQsteer supports up to 5 separate CAHNNELS which each of them supports up
to 512 interrupts. CHANCTL is used to enable those respective CHAN output interrupts.
e.g.
1~8 output interrupts of CHAN0.

One notable thing is the each channel has a separate address space.
That means the chan1 reg address is not the one we specified in default reg property.
So the correct dts may be like for multi channels cases.
interrupt-controller@32e2d000 {
        compatible = "fsl,imx8m-irqsteer", "fsl,imx-irqsteer";
        reg = <0x32e2d000 0x1000>,
              <0x32e2e000 0x1000>,
              <0x32e2f000 0x1000>;
              ...
        reg-names = "ch0", "ch1", "ch2", ...;
        interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
        fsl,irqs-per-chan= <64>;
        interrupt-controller;
        #interrupt-cells = <2>; //cell 0: chan index cell 2: interrupt number
};
This makes the things quite complicated.

In reality, we still don't have such using cases so far as as multi channels usually
are used to deliver the interrupts to different cores,
e.g. M4, SCU, or DSP, A core don't handle it.
So I did not change it currently as it's another story.
This patch series mainly aims to add support for 32 or 512 interrupts channel and multiple
Outputs for a single CHANNEL case.

Regards
Dong Aisheng

> Regards,
> Lucas
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
