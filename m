Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32B6C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:32:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B9A20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lI5oUNBW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Asjk9yI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B9A20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9bPm0Iv4DWSVkJE101UajoJK1e+AKpmiHvcV4APtTIE=; b=lI5oUNBWl1bEA3
	TiQ/7PInzeG9c+S7QZ8mKl1d+NvpnTbfpRQnAqfV23RZUBDlXGgYvvwsfNbdzN0SMiVj9Kk9E8q5C
	h9fDyUc/Ms1ga+3LB/Io1Ki8ctIJmjfpVWRz6h/jWuwGgJdgaM86RCHb/9/Ti/lf+KJKHGcQvImcu
	4ckbZW8gBTE5/Zs7aesvyQALmgP01ECMVWpCF+7kKvvX4qjGErJwzn5VqKf6yMNbp0Mud+wNHCx+P
	v4XUpgEq5q5EjJGjAL7WjDLy4Jcjw/nm5TJHrBo5lzZtQVB4+Fg2JS0RxzVU2my9gsVqqBrJPCAo0
	gHEjwgu2F+eqOKeX86fQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXEvd-0006gG-9X; Thu, 13 Dec 2018 00:32:37 +0000
Received: from mail-eopbgr150079.outbound.protection.outlook.com
 ([40.107.15.79] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXEvZ-0006UI-Tl
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 00:32:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpH8FK6nQUAwZ/C4fxmDcHkcPscTSzjdwxHn2nvcDf8=;
 b=Asjk9yI58n6irDFMzCKgpssgTq9LY6HjHmMoy4MLSdmB7V62u+Mq4jFsk+0XLo47gyP8Ndu3huA0N5i8NT5aqrkernwJy5kM3pOdx4jT/EmRlB207RVLDqhR3HXCaXvQBQVAKkcLnoxdTLWpgVThbon655ZIL4LOzFOEgJ5mw7s=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4769.eurprd04.prod.outlook.com (20.176.215.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.23; Thu, 13 Dec 2018 00:32:20 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Thu, 13 Dec 2018
 00:32:20 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V9 1/7] clk: imx: add configuration option for mmio clks
Thread-Topic: [PATCH V9 1/7] clk: imx: add configuration option for mmio clks
Thread-Index: AQHUi98lQ6o73Estskm1k5h96wz2oqV4fYEAgABeCkCAARxjAIAAXN6QgACazVCAAMtXAIAAIYdA
Date: Thu, 13 Dec 2018 00:32:20 +0000
Message-ID: <AM0PR04MB421101C45B460F6DC5032D1780A00@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1543934041-12572-1-git-send-email-aisheng.dong@nxp.com>
 <1543934041-12572-2-git-send-email-aisheng.dong@nxp.com>
 <154447530435.17204.3027810086542897433@swboyd.mtv.corp.google.com>
 <AM0PR04MB4211B87A842FB8AF14621E3380A60@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <154455657071.17204.2493209125185218529@swboyd.mtv.corp.google.com>
 <AM0PR04MB4211D9C32A4DDCCF266B60C380A70@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB4211C8B8DC2D5F2133D30B9F80A70@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <154465342417.17204.9306702088509412293@swboyd.mtv.corp.google.com>
In-Reply-To: <154465342417.17204.9306702088509412293@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [101.93.238.110]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4769;
 6:2IjzseVeakvuv/YIyvr88t2RQ1PKFKiG6lys4Li1Z8N04DmPUE6CGwMYtWkcbXZzyeU4XLAy6Rn7ek0wEZfa311kc+IWEHYyVTLj6YHzJZAgkAk8A8PEm9XXAtVAYhae9QNyhHs2ouUi6+s+DNE0mtygeTbISqhGrXN5ZH+396yDsQLfrv/ML/+jdEt9O2MSalWWc6FTSfSAafQGdoGahKhfUwgSvAnsPfRTeBpg5+xMcUaL9pVr37LiFn5mgaTjWaTEeImMtA6ZWWGaAEmGI/BBUSm9mxjH4AM+tdyXghZWqoaTjVj5D8oTn7gBivyM+uBju7rM5TOz84b9P8i6VpiYYHv0xaLbOzBU/Maa+4GcCmlQZ4aiLG/8oGggYi4Pepqe8KRV/9q52OentJ35ur1RuAz7csnn69heLQSXkmIxCOmrQvDq0SpeRTeLdqwFnl90l7LoZgcXdXZcqtokzw==;
 5:D5KVlwjTKOhMwxWhl7XJIWynjaTVjvWTrwKvMh5v44gC+gefEfkexUD2D3TaRQ/UM8zwlIX2KnxJtKNiK2SGWEljIMezQgrroYj0EuhPnPuxpTodVMMYw2zNsuq/ZeypG3WJ8QATjSucupQXC74KnruROJbM4ovv1Q85gIHdSKk=;
 7:11MTyEjecOs7x5MhGAYVN0TzOECl3YUWpYJXUJ1vVoK4XSoXmvLDLp/H4FbzriqWQZtzAhqq3tzi+AC386mB7hnlF7qYc5LqXpQUFj84GmDD04725Jl+cCZCzk//IrUEvALM7BEDPqNbkY+r4G7w1A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 058ccbab-3ec8-473d-f16d-08d660927197
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4769; 
x-ms-traffictypediagnostic: AM0PR04MB4769:
x-microsoft-antispam-prvs: <AM0PR04MB4769133D536436AC529F1ECA80A00@AM0PR04MB4769.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230020)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4769; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4769; 
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(39860400002)(366004)(136003)(346002)(396003)(13464003)(51914003)(199004)(189003)(2906002)(93886005)(14454004)(7696005)(256004)(99286004)(575784001)(86362001)(14444005)(76176011)(105586002)(53936002)(6116002)(4001150100001)(8936002)(106356001)(2501003)(3846002)(54906003)(4326008)(71190400001)(316002)(55016002)(110136005)(9686003)(25786009)(33656002)(446003)(68736007)(5660300001)(7736002)(476003)(305945005)(97736004)(44832011)(26005)(6246003)(66066001)(102836004)(8676002)(478600001)(53546011)(186003)(486006)(6506007)(6436002)(71200400001)(81156014)(229853002)(11346002)(81166006)(74316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4769;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MHWQMBoXQvgiVCsZdeeLjd37pOEaC5MJPPMT5oqqqvWooSGVbfIJ8JMKF8Pg58gIjE3+CKmdY0z5FAqeV7pXA9QugjwD+7EtasT80t18xU2Jdkk+L+FZXCDXLR2AsrYNPV7bEiwsa2A6AhJm0SH37DaiAsMhJAyJaGwuxzLvYJWXs7xmsQwxIAEbUoRqqiN0Wx1+C/zQYDKFpqTXVjXS4N5QtRJF00hnd8RwE2KQ93UPelv2jXjrUrC6cPk7HmDI4j2ZpPYdQzeb5aeA/TvYldz7jOY1N3rvpYpDNbAOWTXKxGi9gBCdMG0Z1NgG90Uw
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 058ccbab-3ec8-473d-f16d-08d660927197
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 00:32:20.5958 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4769
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_163234_404187_8621775C 
X-CRM114-Status: GOOD (  26.98  )
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
> Sent: Thursday, December 13, 2018 6:24 AM
> To: linux-clk@vger.kernel.org; Aisheng Dong <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; mturquette@baylibre.com;
> shawnguo@kernel.org; Fabio Estevam <fabio.estevam@nxp.com>; dl-linux-imx
> <linux-imx@nxp.com>; kernel@pengutronix.de
> Subject: RE: [PATCH V9 1/7] clk: imx: add configuration option for mmio clks
> 
> Quoting Aisheng Dong (2018-12-12 02:27:24)
> > Hi Stephen,
> >
> > > > > > > diff --git a/drivers/clk/imx/Makefile
> > > > > > > b/drivers/clk/imx/Makefile index
> > > > > > > 5c0b11e..f850424 100644
> > > > > > > --- a/drivers/clk/imx/Makefile
> > > > > > > +++ b/drivers/clk/imx/Makefile
> > > > > > > @@ -1,6 +1,6 @@
> > > > > > >  # SPDX-License-Identifier: GPL-2.0
> > > > > > >
> > > > > > > -obj-y += \
> > > > > > > +obj-$(CONFIG_MXC_CLK) += \
> > > > > >
> > > > > > Because this changes to obj-$(CONFIG) we should change the
> > > > > > drivers/clk/Makefile to have obj-y for this Makefile instead
> > > > > > of depending on ARCH_MXC.
> > > > >
> > > > > We also use ARCH_MXC for ARMv8 SoC clocks.
> > > >
> > > > Yes, and? I'm suggesting drivers/clk/Makefile have an obj-y +=
> > > > drivers/clk/imx/ and then decide to compile or not compile the
> > > > MXC_CLK "core" bits based on CONFIG_MXC_CLK config option.
> > >
> > > Sorry for the missunderstanding before.
> > > I guess you point is have an ojb-y += drivrs/clk/imx/ Then in
> > > drivers/clk/imx/Kconfig config MXC_CLK
> > >               def_bool ARCH_MXC && !ARM64
> > >               select MXC_clk bits
> > > config MXC_CLK_SCU
> > >               def_bool ARCH_MXC && ARM64
> > >               select SCU clock bits
> > >
> > > If wrong please let me know.
> > >
> > > Will update the patch series and re-send.
> > > Thanks for the suggestion.
> 
> Yes that looks like what I'm asking for.
> 
> > >
> >
> > I tried and met another problem that MX8MQ (ARM64) is also using
> > legacy MXC_CLK. (And 3 more MX8M series based chips.)
> >
> > That means I have to write something like:
> > config MXC_CLK
> >         bool
> >         def_bool (ARCH_MXC && !ARM64) || (ARCH_MXC && ARM64 &&
> > SOC_IMX8MQ)
> >
> > config MXC_CLK_SCU
> >         bool
> >         def_bool (ARCH_MXC && ARM64 && !SOC_IMX8MQ)
> >
> > But it can't work as ARM64 supports multiplatforms.
> > e.g. we have also SOC_IMX8QXP, SOC_IMX8QM, SOC_IMX8DM ...
> >
> > Do you have a suggestion about this?
> >
> 
> Can you put the enabling of MXC_CLK_SCU in the defconfig and exposed it as a
> user selectable option? And keep hiding the MXC_CLK option behind the
> def_bool? I hope that MXC_CLK could be user selectable eventually, but the
> def_bool is there to make it easier to bridge the transition and update
> everyone's defconfigs while it is moved into the defconfig.

Sounds like a good suggestion.
I will do it now.

In order to avoid breaking MX8MQ, I will keep MXC_CLK as
config MXC_CLK
         bool
         def_bool (ARCH_MXC && !ARM64) || (ARCH_MXC && ARM64 && SOC_IMX8MQ)

and make MXC_CLK_SCU a user selectable option.

And finally we will make MXC_CLK selectable as well after the transition.

If any issue please let me know.

Regards
Dong Aisheng
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
