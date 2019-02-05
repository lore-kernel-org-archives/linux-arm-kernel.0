Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C138C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:24:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD092083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NR1Eh09g";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MWHK39PH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD092083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WWj31cTFxFq0A0oIAiLcfVe4k6+d+iziDxIXl33n0lQ=; b=NR1Eh09gR3ZQs/
	k+QyCorVv/dNoMEI0UbM5rKP+W4+1Rv2XzeeF2tY6RlGDZEbs4VdU4+MjJJilF31aIz0QBk4jqhv+
	B9Ss7gz/dbkf38xLYCz3u5aZppwtetdGS9K/YRznZXy28pZVMulPkbdsYiVV3dzGLNyd+uY6pe9C+
	I2G2NcT9TrkxVH0O52uOkiJ/GT4hSfmBpc9EPbCA2fC4JZxtgUyF1SNGR5ueFrkjhGe/84jThKDZd
	WE2IL9P5RvT9iwS3byl087y+4hOY8PO5WxOngPWR4uD/6brcqthavKVz/wZCY0H3TuiZj2N+qxN83
	3kAz9qaNxnZglP9ARy3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqzls-0002ik-Vk; Tue, 05 Feb 2019 12:24:12 +0000
Received: from mail-am5eur03on0600.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::600]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqzlo-0002iD-Rp
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 12:24:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHpkBvb0gMYcz0luFhXdOo9NDMZoEoc+RlXuDEAVHXc=;
 b=MWHK39PH+zqSzE6JCq3ceqTFZyA1pe3xe8aIRS0rjzB+u9Fm2KONhoJxRl8ik/1kIEayKlIOEBjVQyvdj8LRm2BIa5+40Y3pW28sGa+3hZz7Ks/EiOZGy9ATMsMcCPpYwhtSTl1NKyzZyK7e7n+RDckRt6y+b4o7YaCE9/289Pc=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2509.eurprd04.prod.outlook.com (10.168.65.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Tue, 5 Feb 2019 12:24:02 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 12:24:02 +0000
From: Pankaj Bansal <pankaj.bansal@nxp.com>
To: Leo Li <leoyang.li@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [PATCH v2] arm64: dts: lx2160aqds: Add mdio mux nodes
Thread-Topic: [PATCH v2] arm64: dts: lx2160aqds: Add mdio mux nodes
Thread-Index: AQHUvGbiC8iYo4SL4Um4n0hI+dty16XP2soAgAFHECA=
Date: Tue, 5 Feb 2019 12:23:44 +0000
Message-ID: <VI1PR0401MB2496085A7A23DF5CE86A4657F16E0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
References: <20190204141641.18272-1-pankaj.bansal@nxp.com>
 <20190204.085056.439064547458115258.davem@davemloft.net>
In-Reply-To: <20190204.085056.439064547458115258.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0401MB2509;
 6:rbNttYzCaFK+8Lnlk1Ly4eU4sPEznBUcPb9L5xx07Iegg5uVjLEfOR8zUO0F5afWflStr5JU17/ffdbx2Sq146vSb91MIuc2M0lPxRMFm+ZEn69UpXHakR/zpQ90NcfBbuwEpL5kF0e1JhbkTg9ZsBOiGGVEUatNLtll4BFwl5WV14p0pmjMFjIWe/2oWXJHhVLhFF9FIqmdZ09pCThgAlSCsCuWcD4hLK5c3i1VjpXjsX/lutIO6GprMvntnbynMz1mhdadeW/aD6lT8dE4wr19LpQrz8T02zuFl6n384fmBYM7FgbMWPrAQDChr3iVRYgqJrnoaNqWzpIMeuRqgF3zG/Gy1Lb6fZOeBwUH5iDd+BwaClXmT5CWae6J7mrdS6Qs9ehq8LyQMjHeK+32X1vPtaIAUaNG/WUxoxnRKUwdF/vzKqgjcAHdMXT+i3uIQoZZGR3CCfLK3wMTCwvLMA==;
 5:Guha9t6Yt20a5CjkA02ZlUjVamuHnr6+7xYPZxy13WRLURRVyQLV2NQ/OwBn1G6UR0cdT8Pt4WYDdmDnfNdJg63+f1pd2Jg4JqzC/kN1IZ7D8s/bIdUeY/jYUoc/6WwD9fweosAYW++Wy1Rbw+qL9K2Aa0NQZSCAqn+b3RZZS/O81ESfyIskQnBQlBXPweLE+MIaC+uJF3I65i+4sE1g9w==;
 7:CocpkEGVgH5yDg9mrrijm6iWX4yZqAUgO9bQ+/pq8l2retbc+wkSceGqXZf9B9EO9kMw6TnazXXyk9EJKJnZGIWNNGxYxDsyZm7GhCBWQNUJy12yEm90b2io8zjziFHzMvEwRjXSgKQo5BhbF/HThw==
x-ms-office365-filtering-correlation-id: a6c423fc-3f8e-4522-43b6-08d68b64d074
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0401MB2509; 
x-ms-traffictypediagnostic: VI1PR0401MB2509:
x-microsoft-antispam-prvs: <VI1PR0401MB25091736543177D14761D29FF16E0@VI1PR0401MB2509.eurprd04.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(136003)(376002)(346002)(366004)(39860400002)(13464003)(189003)(199004)(76176011)(7696005)(53936002)(6246003)(4326008)(99286004)(305945005)(7736002)(478600001)(74316002)(8676002)(25786009)(110136005)(54906003)(102836004)(26005)(476003)(186003)(55016002)(9686003)(6506007)(256004)(81156014)(8936002)(53546011)(2501003)(446003)(6436002)(11346002)(86362001)(97736004)(14454004)(33656002)(6666004)(81166006)(68736007)(229853002)(71190400001)(71200400001)(486006)(2906002)(6116002)(66066001)(316002)(44832011)(106356001)(3846002)(105586002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB2509;
 H:VI1PR0401MB2496.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EOjzGSIMQK3WlVV3XfIaN6y5nRKRJlCPthPQ+zN2SIHgIphHcG0hPGRhftKX7qD4Z7KKEwOD+KJydSJ04NhwDl3ZqM2BdVLcT9Ugjx1/tUMYl384nhnT/PjJxNvGYDJDK1X3nE83+seb/70sTPVi6JV3GZqhTWxFOpea7dTQ0dYDC6gMWDknocAkDRpvbtIXBoPQPH6qjqlKEvOwkXp8nzWoYbhzZ2KRO50jlMyaeqdxoDFxdDr+XLYr4gcH4OA34kmQvXZhwLdowqRPeiltSezCwHkPH2zdiZeri/EQ6rWW+WrHJ6am8hk94BJzETHmMQfxE+/l8mk88MqB/hJTnom2kAKNlgyjStXV3THb6ASJ2KsmvpOzhUi2375gCVb4zTT0Xn+Ya81Tre+vKJ3z/m5Lr5I+XV834TE7WQnBDSI=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c423fc-3f8e-4522-43b6-08d68b64d074
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 12:23:44.3909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2509
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_042408_965624_6A3C3959 
X-CRM114-Status: GOOD (  13.50  )
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
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
 "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
 David Miller <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Shawn/Leo,

If you have no more comments, can you please merge this path in your branch?
in same branch in which you have accepted LX2160AQDS board patches.

Regards,
Pankaj Bansal

> -----Original Message-----
> From: David Miller [mailto:davem@davemloft.net]
> Sent: Monday, 4 February, 2019 10:21 PM
> To: Pankaj Bansal <pankaj.bansal@nxp.com>
> Cc: shawnguo@kernel.org; Leo Li <leoyang.li@nxp.com>; andrew@lunn.ch;
> f.fainelli@gmail.com; netdev@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v2] arm64: dts: lx2160aqds: Add mdio mux nodes
> 
> From: Pankaj Bansal <pankaj.bansal@nxp.com>
> Date: Mon, 4 Feb 2019 08:51:57 +0000
> 
> > The two external MDIO buses used to communicate with phy devices that
> > are external to SOC are muxed in LX2160AQDS board.
> >
> > These buses can be routed to any one of the eight IO slots on
> > LX2160AQDS board depending on value in fpga register 0x54.
> >
> > Additionally the external MDIO1 is used to communicate to the onboard
> > RGMII phy devices.
> >
> > The mdio1 is controlled by bits 4-7 of fpga register and mdio2 is
> > controlled by bits 0-3 of fpga register.
> >
> > Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> 
> Am I applying this to my networking tree or are the ARM folks taking this?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
