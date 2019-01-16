Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5E7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:00:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C94B20866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aam9RKnU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hMN1tH8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C94B20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7keW8zJyK/J48jpF0VWMAnVK3ijNs96vxKeZKS4h9/o=; b=aam9RKnUrNi2bU
	cqa2pIwYNznpUofT1P3rA+3Qnoy8h2xDqkcM+dZUN35zKxO7SqYorMH81+YW+GvGzihIWQlzp46z3
	byR4lthWIrTFH934f8Bnz8QhpTpFGW+K3+Xy1Yo7U+9vslmh5mpPF1vMps44zAXgj9ZG0TXkK6p0a
	LW0xDzTu1mubp1R9i/cWETxOWLD2j2memJyTK1ULjirq5dKR13fmW16ICzOWfuvBEMZM/gndLd3fz
	4NJ9bkAg2dd0raw0XCLgRTFPEXFNyU2d81vQBbmXEYTZUr2ifjlgiSd1LJAcrc5UcwPydeFStU3+V
	JrdVAoiiErf6He/nlnPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjfBU-000551-7l; Wed, 16 Jan 2019 07:00:20 +0000
Received: from mail-eopbgr70089.outbound.protection.outlook.com ([40.107.7.89]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjfBM-00054T-BT
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 07:00:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEZLYaHo/OuWKDJc7MPiHo5QjVYlglV6cgypZDuTSXE=;
 b=hMN1tH8EbTsNMwGQpzD6AedPrXBBk4xAQUCIimfEpx7cEc8PyetTJTNTY69MXYufze5s+i0GERPBYDnvpRJ7wkkQpC/AJHaN+B3TCK7xgSuHsdUvC+1Im+kCqxDyeU4HgEbkEf8Kdsu4DXCoLPUYnxzSsu3cFEgdEc5x0RDSKaY=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4641.eurprd04.prod.outlook.com (52.135.149.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.20; Wed, 16 Jan 2019 07:00:09 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 07:00:09 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Lucas Stach <l.stach@pengutronix.de>
Subject: RE: [PATCH v2 2/2] arm64: imx8mq: select PM support
Thread-Topic: [PATCH v2 2/2] arm64: imx8mq: select PM support
Thread-Index: AQHUrMG4y4B3Pys1ikq5u3IBwWYCCKWxOnoAgAA9D4A=
Date: Wed, 16 Jan 2019 07:00:08 +0000
Message-ID: <AM0PR04MB4211F62EB37A8D4A67026F9180820@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190115110145.11017-1-l.stach@pengutronix.de>
 <20190115110145.11017-2-l.stach@pengutronix.de>
 <20190116031720.GF15808@dragon>
In-Reply-To: <20190116031720.GF15808@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4641;
 6:ICQuxN841RIVMTQyEJHj+rEnPHMp/Ke9DxiI1n3K1Sep/0g6XeenPg/fDryXq6mSq/VYJGQJjc2Q8HGaaFRAcpbf2StsQNbbco0wHCxi/L6R/lFalwHSpxvREyt3DfasRzpMsTS0xmi0u/SbaWZ84zXYpGNMumlNUPKW3MoEVVNiln8cEnmCXZEGg5M8t71Ky5jFxiCOHfPC2c3C37J5tSe9UT0qeq5YdAElKBshbzLPT8cTTE6G+z2Cbo3xXYHlmBW/+FDGR7eDf5MhpkorhHr+NOCTXz9cIZfdW25tNLfQpGTHj6mwnI+PEDsCdrgXKOSXXDzZSNDTrgxk8qGv7RAKsvl2ipsKF6itofOrY4Yu3qLke/l5jS+YG/08YF6V9yleF03z1LpYkr/k9HqTMyJQvSLnRvhx8ZOwd2zdu9IeyuL0oA3d3xLBBrN805G6sUYdbEk2u3F5LnLFdMYn7Q==;
 5:xPtuqGrZFwx4KLrqqOQB14IBX/5FozZvkvYP949+Psrj59wmUzSLD7mr+1+fiufNFJ+Giz40BF++GYOvKOExXPmpQxtLP3z5VWvnyuJHZAuy51F2vKQE2D5/F+CQYcH5F+MtxuexotqLdiGydtMfGAsh6d/KtH7GjWQV89YCFmJRs3w+sqCep0v8JVyP4gwAPlwsWRHeR8hY8Nwy3o3JJQ==;
 7:AnYfkPWQM7TVIBBbLFpQDAP4KxckcIhO6tFyGABXwlZOM8Ot3+4sSxycfvHM0o40ocyQIGLN+zoGLygbMQQXnSvJ3vqi3+aae950hBHpIjopj/TDmjme/ivbxcCFay0tfnIx8E2cGk2CLentMTfsPw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 09935cec-3807-48aa-6178-08d67b8040b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4641; 
x-ms-traffictypediagnostic: AM0PR04MB4641:
x-microsoft-antispam-prvs: <AM0PR04MB464110B85190110E96A6F99D80820@AM0PR04MB4641.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(396003)(366004)(39860400002)(136003)(346002)(13464003)(199004)(189003)(8676002)(7736002)(2906002)(14454004)(81156014)(81166006)(26005)(256004)(186003)(229853002)(110136005)(54906003)(5660300001)(4326008)(97736004)(33656002)(3846002)(66066001)(6116002)(6346003)(99286004)(11346002)(106356001)(86362001)(102836004)(316002)(71190400001)(71200400001)(68736007)(74316002)(6246003)(9686003)(486006)(476003)(105586002)(6506007)(7696005)(25786009)(478600001)(8936002)(76176011)(305945005)(53936002)(55016002)(6436002)(446003)(44832011)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4641;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r6sgiGbtIzwjiNPtqrtEIcRMjQ2yofYuC05Bau7KtRjpz/K+QinSPV9HqqB6Kn5B/bmV9xG5TqWsPlJVFDygqlkaEsj4MpXV4T6u7tN4fBm9IOf+Nd0Grtosh3MNmHqPSgS1ePl+zaPBefDXRKAPHZ99Mi4mxQr0r4Ld8nGFQznv+6Ru3ulRv3e0Rgq80JSJrcsKKG7rh9lx/biIPmcCttC2ZHOmNRDjSlRP4Pj59iWnsVWNUXmzg5JEMiV7hbcXKDMVAbJ4oNkQHgQbarD7bUsIpeNMUZoJKgAFjuwyfQk+UbqnUF7KUSdLISYQ6YjG0iZM0d2AxN1J4/Fbm2mITsKLgrSM2/cNUEx03Lbi73BTS36E1svN3MNt2y3XID3N7VoWHBcNIUHZPmZMQzzgMl09fGCoypI2Zd6Jxscbm6o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09935cec-3807-48aa-6178-08d67b8040b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 07:00:09.0135 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4641
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_230012_394963_01126D12 
X-CRM114-Status: GOOD (  15.32  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
 "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
 dl-linux-imx <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo@kernel.org]
> Sent: Wednesday, January 16, 2019 11:17 AM
...
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  arch/arm64/Kconfig.platforms | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm64/Kconfig.platforms
> > b/arch/arm64/Kconfig.platforms index 251ecf34cb02..bb0d78d1ca4d
> 100644
> > --- a/arch/arm64/Kconfig.platforms
> > +++ b/arch/arm64/Kconfig.platforms
> > @@ -146,6 +146,9 @@ config ARCH_MXC
> >  	bool "ARMv8 based NXP i.MX SoC family"
> >  	select ARM64_ERRATUM_843419
> >  	select ARM64_ERRATUM_845719
> > +	select CONFIG_PM
> 
> select PM
> 
> > +	select PM_GENERIC_DOMAINS
> > +	select IMX_GPCV2_PM_DOMAINS
> 
> We would like to keep the list alphabetically sorted.

Should these two options to through defconfig according to the former suggestion
From arm soc maintainer?

Put them here also means there's no chance to disable it for other imx v8 socs.

Regards
Dong Aisheng
> 
> Shawn
> 
> >  	help
> >  	  This enables support for the ARMv8 based SoCs in the
> >  	  NXP i.MX family.
> > --
> > 2.20.1
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
