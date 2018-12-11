Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD20C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:36:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F20E62081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S7C4RWKx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gGsDoutE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20E62081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kXxxuJ3ThK+1Cjwx593O6B5GUyjaIS4d2OgC4dBtOt4=; b=S7C4RWKxE+iu0T
	gP0C1ZW2SQLIaQeGfr9EC0C6Nz2uT/j3oK/f2qe1eW2umemcdq9SH453rGcM40dNkcVD00gI2JVxx
	gfxCskvjuFGrUKJGMa9RrqXdm1ztyg84RFR2FyzEWBRYOYcs0flZpDRktx3OZ5m8hqAkgx9I3bD/F
	+kTl3vsXVM0/Q+Sh6gyhixDX5JQ6XRZj7MPgq/nnVnGk6533UwMFyRB3+Ug6XQuHukZol3zMZXo7a
	e9A3+uEQJTlvdg3r6D6lUk7a3J2ReOdWuyppKc81ydaTvYzX3/emGXTeze+vYmrwGduEYNsVlmCSb
	QLx/hFOwWSgvU6eaBUFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWYq5-0003le-Bp; Tue, 11 Dec 2018 03:36:05 +0000
Received: from mail-eopbgr60063.outbound.protection.outlook.com ([40.107.6.63]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWYq2-0003lI-1M
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 03:36:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJF8VRCwWshVEPE0JNFxFbiz+LgUMoGkN4aMtFixvHg=;
 b=gGsDoutE+JtCDdBBAU/lbAHQ+qIa7DJY0pmeGI/MFEOU9SbMi2et30X3hHbu7Kod1LXOIA6bme/V7t7SvNBKgmnOVz+N7qryQxbMt+GP7PcXRHl/3dkKRgHsALXBWg7hzJPQQqlLFXtxy86YoSsRTnyRA2stEfc4/TxLqNkW4/8=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5378.eurprd04.prod.outlook.com (20.178.115.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Tue, 11 Dec 2018 03:35:48 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 03:35:48 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V9 2/7] clk: imx: add scu clock common part
Thread-Topic: [PATCH V9 2/7] clk: imx: add scu clock common part
Thread-Index: AQHUi98nS3QbsFuE9k65NTuug/+jZaV4jpEAgABYpPA=
Date: Tue, 11 Dec 2018 03:35:48 +0000
Message-ID: <AM0PR04MB4211E44C3B64033C3795BDB380A60@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1543934041-12572-1-git-send-email-aisheng.dong@nxp.com>
 <1543934041-12572-3-git-send-email-aisheng.dong@nxp.com>
 <154447896872.17204.13777399275077720705@swboyd.mtv.corp.google.com>
In-Reply-To: <154447896872.17204.13777399275077720705@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [101.93.238.110]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5378;
 6:zKcCjT6eFqJpzKcuMwZGDgzmECMrbnW8IDhI9UFDtbvCBJ/STeFOmPqyLn56ZBmLeCRP4tcQLOg4P2Q0PdYOhZSOWPH11hQnViare4ss3vZAneXEEaMsz9jrcb4It9ckltWyuDqLv9HXenIqh2rm8ut76VJNeFuWulzNkDuvNEBs78s78VgF/x3HbRlPY9vkLKJVluJqPYKX7d8Wx/xtf2I5MVPMYu9Bj0iq+hmcZv3Suhh6BKFoNzQgM1EUhjt0tfNP0f5xkf9gQxGkoCgIwRx8d/IJuCeCwzolFMRhDX4/Fu0DT26dZscPzDr2YTXo4Jagc8gJf72Zb4m/XgQPHX4s1sPsA6RlNyj8Mt97AsQqlBoHifbKbqphDfJ2l2b26zOffoBq7KGI+aqKlaKB1saKzkwjO/0oPTuIuuuYgUhU/AtF4NDMD5uMYDUSD2606UPxTKgt/lbUyP6KJ98/4A==;
 5:EogZUbeltWQybtam6sxsFTSKpPWABZopLf74DwBm1KYw/qpyHxB8xuRV86VJMUgMr1gg0s6MH/+16MdtscUgbWd0n53Ghwu+7JyXaRHArREUY4twn51EXsmX0XJQdZSL25iEUP7sjlzIlU7AqiWQHrx6FMgMUDoPd9P7e4OaAOA=;
 7:aipFpzhwZ2VQlRcGNszqihb1fwneHf4O709oXM0gWjARDu1Ia0SC4YhTG1LsVEFnz0PTONsfBO/jd7fbUHb/a759FNzLjcR6oglI8ENyuu+9DId6JVFTeo57nJuNQvRwsV0jtxziVAqIkHdMxGkiTg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0185b341-5aeb-47f3-dd99-08d65f19bdd6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5378; 
x-ms-traffictypediagnostic: AM0PR04MB5378:
x-microsoft-antispam-prvs: <AM0PR04MB537873834F779F5BC7FB021680A60@AM0PR04MB5378.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231472)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5378; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5378; 
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(13464003)(81166006)(81156014)(446003)(486006)(11346002)(4326008)(8676002)(8936002)(44832011)(476003)(478600001)(966005)(14454004)(7696005)(86362001)(76176011)(2906002)(99286004)(3846002)(6116002)(2501003)(66066001)(25786009)(97736004)(6506007)(102836004)(110136005)(26005)(6436002)(68736007)(186003)(305945005)(106356001)(256004)(74316002)(33656002)(5660300001)(229853002)(316002)(53936002)(6246003)(6306002)(9686003)(71200400001)(71190400001)(55016002)(105586002)(7736002)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5378;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eDI3guq/Y6FWX5sWncRl4QAkDdsKXYUvRLQpw4lFKre3ElCs1pWdSe3OAzBbNFzRdt2RYhdpGIVfcAAHjG8uuhh2xnYOPQ4kpU2clyNEWue6Df7O2dX/rUEGqrW+wO2A3bsYKoBBVMFH5vK1GLqVFJlf3LQ2I8OOniArnhp6Zk+6tgyz9+NI2DeaXniUwn1fDrYRS13gF4BwUFlkU9swiCel3Ps8KpVZLYXKFdRuiy3Jg4Y6H9GHLopBx+IcvB1cHX0R9d9Dr6gLMzuP4VdEkKtur/5AOtrcjhZ8Vp0Oa28nQrMKr+9nOuM+3ZOVNamW
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0185b341-5aeb-47f3-dd99-08d65f19bdd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 03:35:48.2209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5378
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_193602_082421_71A612FF 
X-CRM114-Status: GOOD (  21.69  )
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
> Quoting Aisheng DONG (2018-12-04 06:39:25)
> > diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig index
> > 43a3ecc..63e7b01 100644
> > --- a/drivers/clk/imx/Kconfig
> > +++ b/drivers/clk/imx/Kconfig
> > @@ -3,3 +3,7 @@
> >  config MXC_CLK
> >         bool
> >         depends on ARCH_MXC
> > +
> > +config MXC_CLK_SCU
> 
> Is there any reason to make this a hidden option instead of making it a
> selectable option? It can still depend on ARCH_MXC and ARM64, but otherwise
> it should be compilable as long as CONFIG_IMX_SCU is defined (this should
> also be a config we depend on here).
> 

This is mostly following the exist using that CLK is selected by SoC config option.
https://patchwork.kernel.org/patch/10677309/

As CLK usually is required for platform to run well, so we did not make it selectable.

> > +       bool
> > +       depends on ARCH_MXC && ARM64
> > diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile index
> > f850424..4abed37 100644
> > --- a/drivers/clk/imx/Makefile
> > +++ b/drivers/clk/imx/Makefile
> > @@ -20,6 +20,9 @@ obj-$(CONFIG_MXC_CLK) += \
> >         clk-pllv4.o \
> >         clk-sccg-pll.o
> >
> > +obj-$(CONFIG_MXC_CLK_SCU) += \
> > +       clk-scu.o
> > +
> >  obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
> >  obj-$(CONFIG_SOC_IMX21)  += clk-imx21.o
> >  obj-$(CONFIG_SOC_IMX25)  += clk-imx25.o diff --git
> > a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c new file mode
> > 100644 index 0000000..ec8a471
> > --- /dev/null
> > +++ b/drivers/clk/imx/clk-scu.c
> > @@ -0,0 +1,265 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2018 NXP
> > + *   Dong Aisheng <aisheng.dong@nxp.com>
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/err.h>
> > +#include <linux/slab.h>
> > +
> > +#include "clk-scu.h"
> > +
> > +struct imx_sc_ipc *ccm_ipc_handle;
> 
> Why does this need to be a global? Can it be in each clk_scu instance instead?
> 

No, no need to be in each clk_scu instance.
There's only one handler.

> > +
> > diff --git a/drivers/clk/imx/clk-scu.h b/drivers/clk/imx/clk-scu.h new
> > file mode 100644 index 0000000..09f381b
> > --- /dev/null
> > +++ b/drivers/clk/imx/clk-scu.h
> > @@ -0,0 +1,21 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright 2018 NXP
> > + *   Dong Aisheng <aisheng.dong@nxp.com>
> > + */
> > +
> > +#ifndef __IMX_CLK_SCU_H
> > +#define __IMX_CLK_SCU_H
> > +
> > +#include <linux/firmware/imx/sci.h>
> > +
> > +extern struct imx_sc_ipc *ccm_ipc_handle;
> > +
> > +static inline int imx_clk_scu_init(void) {
> > +       return imx_scu_get_handle(&ccm_ipc_handle);
> 
> And then this can be implemented in the C driver so that ccm_ipc_handle
> doesn't need to be exported into the header file?

Looks like a good suggestion.
I will take this as there's no other users of ccm_ipc_handle now, so no need in headfile.

Thanks

Regards
Dong Aisheng
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
