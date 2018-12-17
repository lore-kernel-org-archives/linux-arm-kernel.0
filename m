Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D55C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:01:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E50E92133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="orlPBoFy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="f+HYCt0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50E92133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=diL+ll0I5KJ27mxGuaiGwjnw68YL59VcWJ0v17f3HBw=; b=orlPBoFyRtM8QY
	zr+3aWc/QuIkaN3FfbnQ7kyCEhJ+2DkP6zy5uPtYB4PhTgeAlRZFZQns0q7b7e6XoPjW0/TClchkU
	QOPVB8mOfD7KtkyVHZ5/7b1NQTpU05DVRDz+M0YvxI5zRsXIHWgUfSg82h6N3umizVa6aOGQW2iTK
	aRDW6kY+CIrCJ4PKZ13GSw/Srh0c+1AgtDxbRr673+ADpEUm9Kgn4G2rq8eKceQ5YfO+txeppuJBg
	5mrRLBb3W20rlLuFMjk5ctxvu4xYTcEG9/Y1d54d4zKYlCdouMYtXDkeGgvP+ipVc6Y/IfdtwuatH
	9NTWitex/JArwFS170ZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYtSR-0000CV-Li; Mon, 17 Dec 2018 14:01:19 +0000
Received: from mail-db5eur03olkn0802.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::802]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYtSI-0008Rf-Mx; Mon, 17 Dec 2018 14:01:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JD+JCxciU1fgXJ8qM4eMU/yNsWXOrdWSE2cOVFnCe40=;
 b=f+HYCt0cZCb8318owInNKIDfLRHaKvCrIldQ+98NKFchR2FI2s0hi++hJbsXv0UWyaEzKRMAnz9UlGVsUBpzANhh7kiWLvSa2932pGwVYTY8D1eifv4MOM/St9vZxUB/cngKTLDIc6c8ldVjERDKVo08zmMXChTDgFfPm8DdW6yg+pH7ulvujAVbAc0IzAS+GywhL4hivaZHiolPukHfN5UmKKUeVq6iIEhmfxUYCij4POdLleh3oyWgkiBo/BXQlbvsXwLg026/i8UdAW9MDufLx0rdxAtObtu+ctg1DrCoRBxpcGiAlbWKw4fhhlha8Qvzi2toVtpQWKScwIONWg==
Received: from VE1EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (10.152.18.57) by VE1EUR03HT145.eop-EUR03.prod.protection.outlook.com
 (10.152.19.168) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1382.18; Mon, 17 Dec
 2018 14:00:55 +0000
Received: from AM6PR04MB4504.eurprd04.prod.outlook.com (10.152.18.56) by
 VE1EUR03FT061.mail.protection.outlook.com (10.152.19.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18 via Frontend Transport; Mon, 17 Dec 2018 14:00:55 +0000
Received: from AM6PR04MB4504.eurprd04.prod.outlook.com
 ([fe80::8c20:7e76:67d5:d5f5]) by AM6PR04MB4504.eurprd04.prod.outlook.com
 ([fe80::8c20:7e76:67d5:d5f5%6]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 14:00:55 +0000
From: Johan Jonker <jbx9999@hotmail.com>
To: Tomasz Figa <tfiga@chromium.org>, =?utf-8?B?SGVpa28gU3TDvGJuZXI=?=
 <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>
Subject: Re: [PATCH] dts: rockchip: rk3066: add qos_hdmi and HCLK_HDMI to pmu
 node
Thread-Topic: [PATCH] dts: rockchip: rk3066: add qos_hdmi and HCLK_HDMI to pmu
 node
Thread-Index: AQHUlIdQSVwnzF/AokSq9d3+I2Ug4qWCbr2AgACKBYA=
Date: Mon, 17 Dec 2018 14:00:55 +0000
Message-ID: <AM6PR04MB4504E587B100C217B4860380BFBC0@AM6PR04MB4504.eurprd04.prod.outlook.com>
References: <AM6PR04MB45048F404CB1166F7CEB0101BFA20@AM6PR04MB4504.eurprd04.prod.outlook.com>
 <CAAFQd5DrRRQku4jDn5sC+TornQjGi0U7W8UUiv29aQtCyxf=yQ@mail.gmail.com>
In-Reply-To: <CAAFQd5DrRRQku4jDn5sC+TornQjGi0U7W8UUiv29aQtCyxf=yQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR07CA0034.eurprd07.prod.outlook.com
 (2603:10a6:209:2a::47) To AM6PR04MB4504.eurprd04.prod.outlook.com
 (2603:10a6:20b:23::31)
x-incomingtopheadermarker: OriginalChecksum:3F66EEE95B01D0ABF91219BF7EA5EB4A23E79A71FC1A62C2DEBD454F2135B62E;
 UpperCasedChecksum:2404E6A1FC87BBAACD4106E7AA8FF23DB1898ECDD150ABBA4C968F75AA8876A1;
 SizeAsReceived:8070; Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [fqfFD1cvBuqQuduNZKua+eBGY6LLHlGz]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VE1EUR03HT145;
 6:Hz39t2hP0KtyKlY34g6cUBWXiAxVACTkTSiowJg5S+Em+G30EO8Q18IP0SkHXc7N1kcOVJM6ujotuD7t6VA2Gxte/nemk91WykJ0Q5ZynQc1o/x73DlZnZ5Lq5qoNdZHXKALWM6Mm2ka81pYNKrdG3BCMIysN99N/k84nLJ4zhopATUYQxI94fwR9TUtnrWqCT/Dp+yvbLJjqGfR+5/VRxwglSOOwtvNCS2bgIFzzwasktQCHdOT80HJTx9ThIdOi8jtsh6dVE8D+jEgwlloOT8H6B4y0pboidzBCMjXwh1png2Ih4Ct2EqwkTJdJurJNk9mbHkFQ9ba4q+5JS8CqpofGUq2vDZqn1ziWindEe4GpheLK/Kdg2q9+4kBTzIPEsWWxn6Tf0KLGhjV3gjuWMQHQrHY3Rg8Xm9hcQ8f/GctFF4otG9S4P702RvhiIiJtBkY2aW24jFXCfYbU/d5eQ==;
 5:+XTwnFQ+TUID1F+PbKBwumoia8tse+lfeJAJZ/qjClCNy+rjyWXakFfOQ+0oQeOCugowlubABt3BwOlbmyDThxjcnNHz6ccqklw6VXX/z6zGb/GkajT8hl8TwDRLJ+Ct9as8gMniG03v/HXyIvwO4zwaGWWkzHvym7Qgx2V9/4U=;
 7:XmR+BWCoPLa1EWZUWk662psWefO5W5iLx8AQrKrCckrNOiAl73ecF6YLud7P8c5A7IyH4DnGeH6dcmv5KNXSnfSevkUwSAY50vJRT3S529YPoozwxpJwsc0e8Ekcd3d7Mj7O0sYzhT7iLl6qqaNAoQ==
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1603101475)(1601125500)(1701031045);
 SRVR:VE1EUR03HT145; 
x-ms-traffictypediagnostic: VE1EUR03HT145:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:VE1EUR03HT145; BCL:0; PCL:0; RULEID:; SRVR:VE1EUR03HT145; 
x-microsoft-antispam-message-info: sB2QoewQGd6WsEFBB2cmDf2WT7X/bP8qX0IKsWOwM3YlDmwtb/SFO2ZcH5mQXwjr
Content-ID: <FE710BE20F39074EBFE497592C09CA8F@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: dd759f05-a917-4aa0-a2f5-4cc35c50e0c8
X-MS-Exchange-CrossTenant-Network-Message-Id: 7274d15a-609b-4f38-422f-08d664281018
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: dd759f05-a917-4aa0-a2f5-4cc35c50e0c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 14:00:55.7152 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT145
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_060110_839273_FA6A7499 
X-CRM114-Status: GOOD (  15.12  )
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
Cc: Joerg Roedel <joro@8bytes.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Sean Paul <seanpaul@chromium.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi all,

Thanks Tomasz for adding all the mailing lists.
I prefer to ask first if a qos_hdmi exists before sending it in for
public review.

All the clocks in the pmu node seem to have a "quality-of-service" (QoS)
block.
So I added one for hdmi too with the question if it exists and which
address it might have.
SoC documentation still isn't fully public, not that I'm aware off.

From Heiko's response I learned that the rk3066 manual does
not list any hdmi-related QoS blocks.
We now only add the HCLK_HDMI clock to pmu node in our patch.

After a small step forward people immediately ask to do a real patch serie.
The rk3066_hdmi.c file also handles audio, but this is not tested yet.
The rk3066a-rayeager.dts file gives a idea how it's done,
but I haven't had the time to get it working with .config and dts.
Let me know if you can.

That's it for now.


On 12/17/18 6:46 AM, Tomasz Figa wrote:

> Thanks for the patch. Unfortunately, it looks like you didn't add the
> necessary mailing lists to the recipient list. For reference, the
> ./scripts/get_maintainer.pl script in the kernel source tree should be
> able to give you a reasonable recipient list. For now, I added the
> mailing lists on CC and replied without snipping, so people should be
> still able to review the patch.
> 
> Other than that, It looks reasonable to me, but we need someone with
> access to SoC documentation to check it. Heiko, Sandy, is that
> something you would be able to help with?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
