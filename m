Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F35C6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:10:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 012592084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uHOuGL4O";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aLmrH0xj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012592084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S2DPHkMfWBiXmimXMehGGexflr6EjQcf3zdmr7fwA78=; b=uHOuGL4OstMEzg
	7A0BC8uRAahMoAL9Pk+UVoOJiR5Xz/aDdmQl3K6DlhGrNQi+9RMDgXkVH4XdX76+16I1tPZd6fZSM
	zBqZnCPr2KJOgIZtcIAnWCR2p1IabSQR1MNoY4rdWi/BL+cjy/lG4INoajuyn33sVm6K4RhqnHeSS
	vbjFHnzYhk/alruim/SDgRPHoBc7L7XaUwMME/Dq9KFNR/OkzXsV+qWuiUS5imyz63w6KN46+h6wO
	R1PfxyEzUNNwfOFrlOYjWh8c0z3OhjL7Vaf8SN5arpNwZH5cCXLqX8E7Jxnv90fyeGs6L6jfa8mId
	2h6SaK+mj5XLtaONa5aQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWt21-0001Yr-Nb; Wed, 12 Dec 2018 01:09:45 +0000
Received: from mail-he1eur01on060b.outbound.protection.outlook.com
 ([2a01:111:f400:fe1e::60b]
 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWt1y-0001YK-RS
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 01:09:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ka3PsR2rjbNKxoDoy7R4u6MDmTcGI6lWNx3MoQ6LbaY=;
 b=aLmrH0xjYjk0rp6LxntzTXE6SurrbFXQHOEcyHS0ilv0XvMLP6OFZV9xPXAuII/2moYwxiBhUUmVqAp8gZ9vN43cwSAGJi2g2KS5kcJLL952NqIUCm38CNp36hCIICinZb+2D6OnTDBPsuz85Njl2aQlzS4YmyA4Q6H1KfOkpYI=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0SPR01MB17.eurprd04.prod.outlook.com (52.134.125.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Wed, 12 Dec 2018 01:09:26 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Wed, 12 Dec 2018
 01:09:26 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V9 1/7] clk: imx: add configuration option for mmio clks
Thread-Topic: [PATCH V9 1/7] clk: imx: add configuration option for mmio clks
Thread-Index: AQHUi98lQ6o73Estskm1k5h96wz2oqV4fYEAgABeCkCAARxjAIAAXN6Q
Date: Wed, 12 Dec 2018 01:09:26 +0000
Message-ID: <AM0PR04MB4211D9C32A4DDCCF266B60C380A70@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1543934041-12572-1-git-send-email-aisheng.dong@nxp.com>
 <1543934041-12572-2-git-send-email-aisheng.dong@nxp.com>
 <154447530435.17204.3027810086542897433@swboyd.mtv.corp.google.com>
 <AM0PR04MB4211B87A842FB8AF14621E3380A60@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <154455657071.17204.2493209125185218529@swboyd.mtv.corp.google.com>
In-Reply-To: <154455657071.17204.2493209125185218529@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [101.93.238.110]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0SPR01MB17;
 6:XBXBnbADfPXtuBZ4VtEir8aw/LbZOghsXxKw1vKYFPsAfSNzxGgp5su2FDRqBZdNZV61ZAsAMnA/M1a+vva1/YQUPbK6zGfTiOh6uZR4v93SGLoT9y7aA8Jvu69s4dh0+JDZqkndFNuwqhX2EtF2R9cwAfrCgZrNW979JCsCoqcgJFRrulnUEJM7ofVV1SOBcAT7Jgfs+qbnt2dcTN1Oi5zDcCmQSPuR7FCQgrnYvxpXloc29efsfPHnIFZt4YM5ZMqSCPpLMgPtlIx7N8SQj1e0F0uTrGxP4UM7zIq5G0S3kMNc8kM4b7h96her11cXljTZNREaI3mWDieVG51wJJVKSjJMpK7/AdpqcAhrOBy/SpMbREj2XFqEHa9xRapA/CX9E6+28bM+/5fLILTtrcPN46hGqiEFU3dhZ5moU0SdsiCW/cwm+RCfKNWazkGrDuLuGXsohRHElS2T+opkOQ==;
 5:6YonEZIAAutO49XkUP8kjg4YaiOTg+FTRyeDoD4QrX9nbc24q1jz/lIu9CzxHYeQXJnBWXorWb83jSwwPp5SR2ZbPr7engC0OnsOpZTwo2VwCp10sey0xSCkERWP7k8IxdaC1Q3DYNTUcIsv2PYA4EqgOJV4fo01gwH59GWdwFU=;
 7:uPC/qhO1GVoNcDjJvxWWfuqE4918yUi2rKL5HFsyTLVYp6/dXwrR2f6Vo/OjyZfvPshYdpL5jzRGGfbWP2/PIYkjJYw/9UDh4ILEpVBg3tWGoioh2eZBdyYNFXV1P8OXWkNm0X697uTM1JKCDMg7/w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f074a389-100f-4567-c088-08d65fce75c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0SPR01MB17; 
x-ms-traffictypediagnostic: AM0SPR01MB17:
x-microsoft-antispam-prvs: <AM0SPR01MB173AAC408FFBB2CC4FAFC580A70@AM0SPR01MB17.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:AM0SPR01MB17; BCL:0; PCL:0; RULEID:; SRVR:AM0SPR01MB17; 
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(51914003)(13464003)(199004)(189003)(105586002)(476003)(44832011)(8936002)(106356001)(486006)(25786009)(4001150100001)(66066001)(81156014)(256004)(14444005)(8676002)(14454004)(81166006)(6436002)(55016002)(74316002)(33656002)(68736007)(9686003)(229853002)(6246003)(4326008)(53936002)(5660300001)(99286004)(76176011)(7736002)(305945005)(6506007)(71190400001)(71200400001)(446003)(6116002)(2501003)(3846002)(2906002)(11346002)(93886005)(86362001)(575784001)(110136005)(316002)(7696005)(97736004)(54906003)(478600001)(26005)(102836004)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0SPR01MB17;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lpQ1ew7Le25+r0UY3jISAkkAiFrD2a/8382SQs8EuMEB+STYhyP02nPWBLK0hVLCt52FU8nUmwrLbf4pR/z6eMn/qw862nj/U80Sl6Mn8HDHqehymeFCJdW2097jAyiG7jPa8unXCX7MHpHD0bPpu5DFZzkCMxoFpCFm+c1du9V4adgJvXff4DG8bQ87fPq5ylMQxxlXeUvawDQi9Jq8RSQkfuI2hxONTOt2HbAyaSdF4Jao+iV9bifEct4bMmtCOk/FNUaehixeQ0Re2sfSN7cLtOaijrWmN3mCdeICOzhMnRkcPSMaSCmHEHYV88Kg
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f074a389-100f-4567-c088-08d65fce75c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 01:09:26.2501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0SPR01MB17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_170942_958279_BED60D3D 
X-CRM114-Status: GOOD (  23.35  )
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
Cc: "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd@kernel.org]
> Quoting Aisheng Dong (2018-12-10 18:36:29)
> > > -----Original Message-----
> > > From: Stephen Boyd [mailto:sboyd@kernel.org]
> > > Sent: Tuesday, December 11, 2018 4:55 AM
> > [...]
> > > Subject: Re: [PATCH V9 1/7] clk: imx: add configuration option for
> > > mmio clks
> > >
> > > Quoting Aisheng DONG (2018-12-04 06:39:22)
> > > > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > > > index c12a05c..303082c 100644
> > > > --- a/arch/arm/mach-imx/Kconfig
> > > > +++ b/arch/arm/mach-imx/Kconfig
> > > > @@ -570,6 +580,7 @@ config SOC_IMX7ULP  config SOC_VF610
> > > >         bool "Vybrid Family VF610 support"
> > > >         select ARM_GIC if ARCH_MULTI_V7
> > > > +       select MXC_CLK
> > > >         select PINCTRL_VF610
> > > >
> > >
> > > Instead of select can we break this dependency on the arch Kconfig
> > > and
> > > have:
> > >
> > >       config MXC_CLK
> > >               def_bool ARCH_MXC && !ARM64
> > >
> >
> > Thanks for the suggestion.
> > One little problem is that we also have LS1021 supported under
> > ARCH_MXC which does not use MXC_CLK.
> 
> Ok. So then your change is also limiting the compilation of drivers/clk/imx/ to
> only the platforms that select it now, instead of all ARCH_MXC like it was done
> before.
> 
> We can also have def_bool <big list of SoC platforms> if that helps for the
> optimization that this patch is making.
> 
> arm-soc has generally pushed against having so many different arch level
> Kconfig options because they make for unwieldy Kconfig fragments that may
> become conflicting. Instead, the options for the different SoCs are removed
> and we just have one for the platform and rely on defconfigs to pick the right
> drivers.
> 

Thanks for telling the detailed background. Very clear now.

> Why can't we do that here?
> 
> >
> > > > diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> > > > index
> > > > 5c0b11e..f850424 100644
> > > > --- a/drivers/clk/imx/Makefile
> > > > +++ b/drivers/clk/imx/Makefile
> > > > @@ -1,6 +1,6 @@
> > > >  # SPDX-License-Identifier: GPL-2.0
> > > >
> > > > -obj-y += \
> > > > +obj-$(CONFIG_MXC_CLK) += \
> > >
> > > Because this changes to obj-$(CONFIG) we should change the
> > > drivers/clk/Makefile to have obj-y for this Makefile instead of
> > > depending on ARCH_MXC.
> >
> > We also use ARCH_MXC for ARMv8 SoC clocks.
> 
> Yes, and? I'm suggesting drivers/clk/Makefile have an obj-y += drivers/clk/imx/
> and then decide to compile or not compile the MXC_CLK "core" bits based on
> CONFIG_MXC_CLK config option.

Sorry for the missunderstanding before.
I guess you point is have an ojb-y += drivrs/clk/imx/
Then in drivers/clk/imx/Kconfig
config MXC_CLK
		def_bool ARCH_MXC && !ARM64
		select MXC_clk bits
config MXC_CLK_SCU
		def_bool ARCH_MXC && ARM64
		select SCU clock bits

If wrong please let me know.

Will update the patch series and re-send.
Thanks for the suggestion.

Regards
Dong Aisheng
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
