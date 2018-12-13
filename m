Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83328C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:04:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B6B12086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gYLYPJ/t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GdKlhjA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6B12086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Es1Ua1xr0SSONnHF4apYO0MPLS3jCjwkmiudZNzLeLI=; b=gYLYPJ/t9QO0S8
	ibsLv1lM5SaUvi7AjEq9Hikd+VW8JfMFIm2lkwg4Juc8TAoDTc3ajBGS4gSuG8olX/D/qc4dwCGm1
	sTae/S2IrgOQyTiX1ilBNgppKgO4iUP9vgbgYM4EttvaZko/J1ji0UC8HiUE9DASP5WGHvVRG1dLe
	EakuR1No0MqH5djRE9Wi12ITE4auxxvATUNsgNBrRQoUkNwS9iBK31PLHKxG84m0tzv/HySGJgpfB
	+18yAvFlj5dzavEQbpyFnsYOYh4GsZy++xbqwaW6Ir9GumPZwrmPebjNB7ty7t7xcRYyDY+6dudpp
	RhYDuXIAhTum0JvwHBVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXPjA-0004sx-8Z; Thu, 13 Dec 2018 12:04:28 +0000
Received: from mail-eopbgr20085.outbound.protection.outlook.com ([40.107.2.85]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXPj1-0004rx-Ol
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 12:04:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLv3uEzSGLxujoUAmx62Er/9D/aPQ9Q7/RDBVN09x64=;
 b=GdKlhjA45ipuEFgp+lApkXfOtC7vdjFn8oJ2L4wsQc7lirZ9scw4ZQ8XyfJ4H+VEAwEOBj21qSignbpnzOIp9VFq9DWbZrhRRtFamPY5F/cfi8FkHjhU8SPz2n2RdTzipMSa2iDxt9AJpaDemdUmdI27EnnhrnHQDYdAKBnFmdI=
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com (52.134.65.28) by
 DB3PR0402MB3900.eurprd04.prod.outlook.com (52.134.71.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 12:04:04 +0000
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb]) by DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb%5]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 12:04:04 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH V11 1/7] clk: imx: add configuration option for mmio clks
Thread-Topic: [PATCH V11 1/7] clk: imx: add configuration option for mmio clks
Thread-Index: AQHUkoBGWd9Zb2oin0+2+ywtXpulbKV8TgAAgAABaACAAALTgIAAQJ6A
Date: Thu, 13 Dec 2018 12:04:04 +0000
Message-ID: <20181213120357.uwwnxpb56zpb2mjd@fsr-ub1664-175>
References: <1544662938-5020-1-git-send-email-aisheng.dong@nxp.com>
 <1544662938-5020-2-git-send-email-aisheng.dong@nxp.com>
 <154468785263.19322.9529215687462426277@swboyd.mtv.corp.google.com>
 <CAOesGMhFtawJLpHmXbxvs=z+S1jVW8n2VQVv1gMcWicrOxDWdA@mail.gmail.com>
 <20181213081239.GB12458@dragon>
In-Reply-To: <20181213081239.GB12458@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB3PR0402MB3900;
 6:rJDF12yIgKpsKt8e4UsKZmWO94MfMJoF5v0kmiKKDCulO5StldyQYQOfG/DXWJLc3F+UaxhchkywFKmzagodK2EYJw1enp1Gxn/ZtpRYIqi2US6syrmidgwLqYo1QKCiK3MpMrFYy6RkrBxjuVOM0imPGwHnIbZup4juTctJ21uF1Oj9A1WuRuMRPcy0Pvq0nQ2mu7Cm68n9UDDlysYAc73LN8QUj0fwnYOcBKu9SUhbiVmBsk93WmGIylpl5B9R3S3ZSA8dNNr4SYUBqKxrS8L8qXmStWivQlkudRVoUdi4dSPDfE7Pgy2WP50Gaa6njH8+tgUGq0Yd9knXNlo/xzx0ZezBwXIJD44yQuOYpFHdgIypbrD52N6zMeC5Ku1ny4fu/OY5xvlP3KpNGg+CowMcIZ22A9jU983aKKO7pl2XMpBckU8KZUhErAVvtLHicjGgQe6ectrgPWLpNNRFDA==;
 5:YpmDwZLM3lGZbwCZVZz2g4Vcjat+Dew0XOAR9poQQZC10Vel0KAqWqyRlp8jJhHq7jRHUXN7QyvtY/B+SxqhU89KhDtoELcIeFhYENUj8vSNiOyq5B9SG/Tn8rNLpWYkB2FbZ6ZoAqih4N4xt220eUFZD71HzgG+VIejWK/OEco=;
 7:1mFPkj4j/n9pVwewEWkIY6lvnfUtAAGUZTnCpzsSGocuGprdR3W0uO2pfIl3rBKwZjW8uQfuPF0NAZ0t5aDdLMs3nWBA+fs6ainbfB3yNRE4VaHMpBVuoRxjPziEwLkmXFd7CpuWRgED94THtMBxww==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 334e2a2b-ab18-4a2d-89fa-08d660f313d2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3900; 
x-ms-traffictypediagnostic: DB3PR0402MB3900:
x-microsoft-antispam-prvs: <DB3PR0402MB390038C4A2921E6DAE180502F6A00@DB3PR0402MB3900.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:DB3PR0402MB3900; BCL:0; PCL:0; RULEID:; SRVR:DB3PR0402MB3900; 
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(7916004)(396003)(346002)(366004)(376002)(39860400002)(136003)(199004)(189003)(81166006)(93886005)(5660300001)(1076002)(8676002)(3846002)(305945005)(33896004)(9686003)(6916009)(6512007)(256004)(97736004)(81156014)(6116002)(8936002)(7736002)(54906003)(14444005)(316002)(33716001)(106356001)(446003)(11346002)(68736007)(476003)(105586002)(99286004)(486006)(86362001)(71200400001)(71190400001)(2906002)(53936002)(44832011)(575784001)(229853002)(6506007)(186003)(25786009)(76176011)(66066001)(53546011)(4326008)(14454004)(6486002)(26005)(6246003)(102836004)(6436002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3900;
 H:DB3PR0402MB3658.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Vhxwhl1nKOngUKcMgEOTlXc8Uz6Eo9cOPPGvUKJnj2vufj5sAbjQyryFvHlken63081mgUxaCpE1UQSB4fyrS6XRz/gHPHg3DjK2QPamMuB45diMTndlAV6aUBDRkSCWONEsBYc1hZb6feH2kKScCu/ptJLMxkZBaaeFrsLV4yDG3Fy2GfPdX3a7hVXb6y1Xezuxl/IflxtR6vmsuegZkt8yHLbH9RKFZm3pE9hXWVeypytppZ0RNBc0B5HsbtMbJmAk2Rf0+bpZMbK1S+pOQH4DgKkYrvpGBTzZKWKQH+jIjFAIGFXwWqK9ne9qIMUI
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <BB88826C423F25489F8A0934DEC2C3DB@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 334e2a2b-ab18-4a2d-89fa-08d660f313d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 12:04:04.3877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3900
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_040419_900088_E00B7927 
X-CRM114-Status: GOOD (  28.27  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Olof Johansson <olof@lixom.net>,
 linux-clk <linux-clk@vger.kernel.org>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 18-12-13 16:12:41, Shawn Guo wrote:
> On Thu, Dec 13, 2018 at 04:02:34PM +0800, Olof Johansson wrote:
> ...
> > > > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> > > > index a47430b..8a9440a 100644
> > > > --- a/drivers/clk/Makefile
> > > > +++ b/drivers/clk/Makefile
> > > > @@ -72,7 +72,7 @@ obj-$(CONFIG_ARCH_DAVINCI)            += davinci/
> > > >  obj-$(CONFIG_H8300)                    += h8300/
> > > >  obj-$(CONFIG_ARCH_HISI)                        += hisilicon/
> > > >  obj-y                                  += imgtec/
> > > > -obj-$(CONFIG_ARCH_MXC)                 += imx/
> > > > +obj-y                                  += imx/
> > > >  obj-y                                  += ingenic/
> > > >  obj-$(CONFIG_ARCH_K3)                  += keystone/
> > > >  obj-$(CONFIG_ARCH_KEYSTONE)            += keystone/
> > > > diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
> > > > new file mode 100644
> > > > index 0000000..37478ba
> > > > --- /dev/null
> > > > +++ b/drivers/clk/imx/Kconfig
> > > > @@ -0,0 +1,5 @@
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +# common clock support for NXP i.MX SoC family.
> > > > +config MXC_CLK
> > > > +       bool
> > > > +       def_bool (ARCH_MXC && !ARM64) || (ARCH_MXC && ARM64 && SOC_IMX8MQ)
> > >
> > > Ok I looked closer, SOC_IMX8MQ is only being introduced now and has only
> > > been in linux-next for a few days. Having such a config symbol is highly
> > > unusual for arm64 code. Has that been accepted by arm-soc? I don't know
> > > why it would be because we don't add SoC specific config options
> > > anymore. I imagine it will be rejected and we'll need to have this new
> > > MXC_CLK config be enabled in the defconfig instead of selected from the
> > > arch layer.
> > >
> > > Given all that, is there any damage if this is just a def_bool ARCH_MXC
> > > right now? If it's enabled on the platforms that don't use it because
> > > they have SCU, does it actually matter? Or we just get some code bloat?
> > > If it's just some extra code, then even more reason to make a user
> > > visible config option that can be selected in the configurations that
> > > care to save some space.
> > 
> > On arm64 we generally add an ARCH_<family> and leave it at that. So,
> > ARCH_MXC would be suitable, but we shouldn't add more finegrained than
> > that.
> 
> Olof,
> 
> I'm just about to send pull request for i.MX8MQ support, which
> introduced SOC_IMX8MQ option.  It sounds like we should rework the
> patches to get SOC_IMX8MQ killed?
> 

That was introduced because of the way the clock were introduced by prior IMXs.
What I suggest is to change the way the clocks are built a little bit.
Something like this:

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 5c0b11e..fdea7d4 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -3,13 +3,11 @@
 obj-y += \
        clk.o \
        clk-busy.o \
-       clk-composite-8m.o \
        clk-cpu.o \
        clk-composite-7ulp.o \
        clk-divider-gate.o \
        clk-fixup-div.o \
        clk-fixup-mux.o \
-       clk-frac-pll.o \
        clk-gate-exclusive.o \
        clk-gate2.o \
        clk-pfd.o \
@@ -18,7 +16,6 @@ obj-y += \
        clk-pllv2.o \
        clk-pllv3.o \
        clk-pllv4.o \
-       clk-sccg-pll.o

 obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
 obj-$(CONFIG_SOC_IMX21)  += clk-imx21.o
@@ -34,5 +31,9 @@ obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) += clk-imx6ul.o
 obj-$(CONFIG_SOC_IMX7D)  += clk-imx7d.o
 obj-$(CONFIG_SOC_IMX7ULP) += clk-imx7ulp.o
-obj-$(CONFIG_SOC_IMX8MQ) += clk-imx8mq.o
 obj-$(CONFIG_SOC_VF610)  += clk-vf610.o
+
+obj-$(CONFIG_ARCH_MXC) += clk-imx8mq.o \
+       clk-sccg-pll.o \
+       clk-composite-8m.o \
+       clk-frac-pll.o

This way the frac, composite-8m and the sccg will only be built for arm64,
and we also get rid of the SOC_IMX8MQ. But then, arm64 IMX clocks will not follow
the same pattern as the arm32 ones. If that's ok with everyone, I already have
a patch that solves this issue.

> Shawn
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
