Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D99BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:36:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EEFD20645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CLN7Ywxt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="puYzedac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EEFD20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uIvDfUBjoII9Z/pKDT7fdZF/eqWYoqeF9Zp5ucig9SU=; b=CLN7YwxtIelPfE
	YicqWTjEcjswaLutTsC69uknYFoj5efaDHGtt0rbNJ0ZRbyBbFWF1P1SPY7XcVXfJgR/p4xhYsQWF
	YAS7yS5dwjOE6pIYszEcvP+y/K4HhtQ5ipY7A0Zifxj+AIH81l55PkYQJO9MuEUyOoqyQctFvFEhc
	Ur1gKKeo47Hd2LHCbwdR7+89iY+2zGjCI2Iim91JFZQTBqPMJF4Lc5ZuCYg1AzO+fS6SVEXwC1E0N
	vJ/b6+CYOoRnJljT2ocRCr+gmzDJVrKKIUGcmjFC+pHXtp0AHS+DUBbARDmrDvf5MBinTwhww/P20
	zh3z8+1s6YWbJgGUaaDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWXuf-00014P-OP; Tue, 11 Dec 2018 02:36:45 +0000
Received: from mail-eopbgr50059.outbound.protection.outlook.com ([40.107.5.59]
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWXuc-000133-Kp
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 02:36:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoendakPlsuJwqwnlaSWI2qM67V8cpuUEsP5twFSmYg=;
 b=puYzedacrW+NX0HQ3c9IHkdYIhRJ7uEnEfo7puHvz08tI0Lb3ABGcMMfwmhoy9+8Gyhm1UQFKiw3KjtfuGY0m6bQXMRtJLWFufujbHxRdPaswBvWSK6HwKcfXDhqjwpIs2qcV9U3AOtDslI/ZtO3DoN/XqyheCO0CavtjTZIkZ4=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB3970.eurprd04.prod.outlook.com (52.134.90.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Tue, 11 Dec 2018 02:36:29 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 02:36:29 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V9 1/7] clk: imx: add configuration option for mmio clks
Thread-Topic: [PATCH V9 1/7] clk: imx: add configuration option for mmio clks
Thread-Index: AQHUi98lQ6o73Estskm1k5h96wz2oqV4fYEAgABeCkA=
Date: Tue, 11 Dec 2018 02:36:29 +0000
Message-ID: <AM0PR04MB4211B87A842FB8AF14621E3380A60@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1543934041-12572-1-git-send-email-aisheng.dong@nxp.com>
 <1543934041-12572-2-git-send-email-aisheng.dong@nxp.com>
 <154447530435.17204.3027810086542897433@swboyd.mtv.corp.google.com>
In-Reply-To: <154447530435.17204.3027810086542897433@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [101.93.238.110]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB3970;
 6:GNVHnNqmCfpXI0zS3F+l5sasj9UzvFlQ2QUDwHFlAebq1KPpAGYT/m/a7cqCHUBjAZ4j7NYgzSK2XqHvrfDGgdRkS1JeVVsBm515AJMiRoWYWBrJYTbhWbQz/2+F2245NEbjZ7qD4dB6mLLOfPmB7pcWtZ80KnxGfV+CNHPkQu5KekTUYqXd9cyKhwswDvCF1ikHjCNyCMDiPna6OsVPOGhM27+3rQs379ktXznrLVBlHFK41pbT1PzLH09DMVPWmd/Uo9UMi8S9MP4xYYqtpr3OkN/4LxjuHe4WNRSKMO4MrLXfXgKgMzXDk9K6VeqNtj5M4GmjQ/mSNDOg9Rq5k3WhxuXfq4ACMmW0wn7EhTFAbq5q9k1qeJDZW3Pds132aM1kP7k+HJ/wpirvn5zN5WcyAiXhN8Q9X+svBbc5t653YqOIJ2j7Z9lfNh8jgEMJxKp+M3csCUXMrfspScw11g==;
 5:K6DAfx3jKx8WI2PGZGH53J19hm4K8B59PSvdJc2WftcmjbIV8H2VC2FxthFW1U4yGZJvl8bog8KomFwQMPyEB5x05wk5A5FwmNMdbwDcWPN+K2tzjCdhkUm6HWtCt74WucnqYlagjVUp1bNqg0igNKycIYOpmmVGUFHbl0T5zSI=;
 7:ySILl0IELZqJ+tCiMCQElj4ePT7HFY+2AP75HoLIBxAMqtEffwlk1CSQg1eN7+Gm00IpF2f9SXLYzNh8EmR7wEa+STBhw36xdRQfHQal7yzXZwQ8DpI8VB2cCmiTlKJIysZ8Uyh6780IXcGC9DuK8g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: daca6f0e-2da7-4662-14c0-08d65f1174a3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB3970; 
x-ms-traffictypediagnostic: AM0PR04MB3970:
x-microsoft-antispam-prvs: <AM0PR04MB3970B7B8B6DBFF4A84F01C3980A60@AM0PR04MB3970.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231472)(944501520)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB3970; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB3970; 
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(366004)(376002)(346002)(396003)(199004)(189003)(13464003)(51914003)(6506007)(105586002)(8676002)(71200400001)(53546011)(6246003)(53936002)(6436002)(575784001)(86362001)(26005)(186003)(81156014)(106356001)(102836004)(316002)(110136005)(54906003)(2501003)(8936002)(9686003)(81166006)(229853002)(66066001)(55016002)(99286004)(76176011)(5660300001)(14454004)(305945005)(3846002)(486006)(7736002)(71190400001)(7696005)(74316002)(478600001)(2906002)(44832011)(6116002)(476003)(11346002)(256004)(4326008)(33656002)(68736007)(97736004)(25786009)(446003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB3970;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eoTxGyVcVltsUAP9E4KKjK+wibjM7CnvXnKvBvBrMzO2UeDnGaFUMcTuVhrDC0nw+IablsojcOOW+xNmLiDV1DhRixRaJmpsP8w6JoWJuCUb07FuZ2PvKO5Qu09wt7wEvlXreuKUneONguuMd0HOL9GMjSWWqd+StC6tUyxEgJOP2hypQPHIOEmfLova4GeELGRlrfdFek5/TtcmCsMgl/Xfi3oVNqiEAOf7lG8KYlJyIhhXvEp8Xr5CCvZe6KyHIreJGwmB59hGenPdJoUrLPSvDUlhtHNDWtAe6fY4sIxGny5ix+Aph5C/dciRWP0n
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daca6f0e-2da7-4662-14c0-08d65f1174a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 02:36:29.4300 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3970
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_183642_748043_309DF834 
X-CRM114-Status: GOOD (  17.02  )
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
> Sent: Tuesday, December 11, 2018 4:55 AM
[...]
> Subject: Re: [PATCH V9 1/7] clk: imx: add configuration option for mmio clks
> 
> Quoting Aisheng DONG (2018-12-04 06:39:22)
> > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > index c12a05c..303082c 100644
> > --- a/arch/arm/mach-imx/Kconfig
> > +++ b/arch/arm/mach-imx/Kconfig
> > @@ -570,6 +580,7 @@ config SOC_IMX7ULP  config SOC_VF610
> >         bool "Vybrid Family VF610 support"
> >         select ARM_GIC if ARCH_MULTI_V7
> > +       select MXC_CLK
> >         select PINCTRL_VF610
> >
> 
> Instead of select can we break this dependency on the arch Kconfig and
> have:
> 
> 	config MXC_CLK
> 		def_bool ARCH_MXC && !ARM64
> 

Thanks for the suggestion.
One little problem is that we also have LS1021 supported under ARCH_MXC which
does not use MXC_CLK.
 
> > diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile index
> > 5c0b11e..f850424 100644
> > --- a/drivers/clk/imx/Makefile
> > +++ b/drivers/clk/imx/Makefile
> > @@ -1,6 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >
> > -obj-y += \
> > +obj-$(CONFIG_MXC_CLK) += \
> 
> Because this changes to obj-$(CONFIG) we should change the
> drivers/clk/Makefile to have obj-y for this Makefile instead of depending on
> ARCH_MXC.

We also use ARCH_MXC for ARMv8 SoC clocks.

Regards
Dong Aisheng
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
