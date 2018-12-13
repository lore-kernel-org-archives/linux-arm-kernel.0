Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C87AC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:49:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1088720870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bXVyEB1B";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RakNhJZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1088720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P6XbPhSWBLGrJZC1LFK3XKPQj7ApAS5kB2j5zPgGjzA=; b=bXVyEB1BVglaM7
	07P1YtV6MK8KMdgxlSfPPCAVGzu4trXd7byOReHE2bpJvMlq/Vx/AadQf3Kp2ukurHP4rY9m62Wuv
	cWgNWI7F2nZCqzEMtaaGRB8V796FjZaX9dmWMNTCrAVN+tujBIcDS5JjnygHf1axhMfLWhz1iFFeX
	VgapL0qqKBnlIDKgs5krxwxoHl/QLThsu9B+WNlR9KIhRrU7zt4kbzibkUeE6/qfOD36BNq2D5qsw
	lF/bf8HhilVIfTJgC6LX0YHTrgDS5DBfpdVKDy9MPHamrHMgjkmS6+jEBam18w3wvnl9ToQnBgNyH
	2FJPdBArEaYzoNlsQ9Sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQQh-0004jd-GZ; Thu, 13 Dec 2018 12:49:27 +0000
Received: from mail-am5eur03on0603.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::603]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQQd-000444-5O
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 12:49:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FchVhBPfn09L/hXLSIaxzw62o6IpEK8l7UPnFC3i8ig=;
 b=RakNhJZ3kFNzN/+1gCXKHoJoD5woeqxwHgd8Vjgr8aXypyO3FB3OBusxXdmzMbaae7TLf52NdOApiP76c7N23e0vB0bjX8yO3vmS+SHp4uHvYPrnFcwozuFZEydArOTp54QYDqpm1VXBvdINiCfkDBGkC6xvX417jdRoC8l87MU=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5745.eurprd04.prod.outlook.com (20.178.119.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 12:49:08 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Thu, 13 Dec 2018
 12:49:08 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V11 1/7] clk: imx: add configuration option for mmio clks
Thread-Topic: [PATCH V11 1/7] clk: imx: add configuration option for mmio clks
Thread-Index: AQHUkoBFxXjd98YyekOIqi1bO3Y7g6V8TgAAgAA5bEA=
Date: Thu, 13 Dec 2018 12:49:07 +0000
Message-ID: <AM0PR04MB4211128F59A987F3D94AAD8F80A00@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1544662938-5020-1-git-send-email-aisheng.dong@nxp.com>
 <1544662938-5020-2-git-send-email-aisheng.dong@nxp.com>
 <154468785263.19322.9529215687462426277@swboyd.mtv.corp.google.com>
In-Reply-To: <154468785263.19322.9529215687462426277@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5745;
 6:FwmsZotdsQto2KEMc5VxVhWR0LKwti45pye0tezu/f1LPwssd5bYZah8o0Yk3Xz6VhT5bysgfUNHEOC+cvYkAW2OCrngciOVDdzLsPc7kR/On1QImYy2KuNC40Dk2dpR1bzpPyadhz4VvjTnBdzYDzcacQ8CMfpGbgr4jH3l4pTZxxyaUgzWbgD/q8CJVOYMjAxmG/Pi19eSeWjxjlAarVfmgNj/a8K2lUdr+yZQLgsNnKHLZu2XQV2Yq2Ikr/6uzmXxlx9H1PLBVgdPdVyKEMhhx0lQ7Ueq5oEVgauOQDtK42dWH8lHIbOKfkBYjYykv4So7ps+X6szeq4rMFQ3SFp1ty9ynr4izfcD1R9B41+wo7RLr8JCYx4BIGKo3DsLr+4Y2hwcU2N1q8PI3xUd3xiN4kf8pzPG3M9CZXiFEjHWbKtXEdeDQWUXltmKlOnmx5NNHp25TSpGkn2oyfNHjQ==;
 5:dup7T87Fg5b147APrqMSRvoAKykpDH9R7ZMHDSnlD195cAPiS9LN5HAQVMJzwVANbB2VZ7Eg6v5FhKco6Ozm+Rssd1jEeA/jCHW5JaxLvwZguf+9s/drxqV/jNRhYtQzKquK2oMhzgp4HqR6U0n2UZBba1RAy/4JNpOmCzQdc7Y=;
 7:GgMhlcDbvQMzxILOglMTQwBqLHZShvV1KXNRcJBSc9RuNsOy47uVPayqk4LQHrvE3e/YtoV4N/POKShge6ejpwF9+s1aeC24La4rNMKhJKSpTee8+22Jp+qINHGkavUpswvz/XQYwjMlEkTLaAav5g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: be1182b6-6e9a-4263-9f72-08d660f95f4b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5745; 
x-ms-traffictypediagnostic: AM0PR04MB5745:
x-microsoft-antispam-prvs: <AM0PR04MB5745D362DCA58425E4D0B7E680A00@AM0PR04MB5745.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5745; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5745; 
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(366004)(396003)(39860400002)(136003)(13464003)(51914003)(199004)(189003)(11346002)(2501003)(74316002)(25786009)(5660300001)(2906002)(476003)(478600001)(446003)(68736007)(44832011)(486006)(4001150100001)(33656002)(106356001)(14454004)(66066001)(81156014)(97736004)(7736002)(8676002)(81166006)(229853002)(54906003)(256004)(110136005)(71200400001)(71190400001)(14444005)(575784001)(105586002)(4326008)(53546011)(9686003)(53936002)(86362001)(55016002)(7696005)(6246003)(3846002)(186003)(6116002)(6436002)(26005)(102836004)(316002)(305945005)(6506007)(8936002)(99286004)(76176011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5745;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RXrDCxCftsCZOIMbaNoWw3TinIzS09j2ndyt9o9P/LCElQmk4dKf5tGoaUFQcMhtN4bXCTe7nkwZnGVYnYdskdqI+Cw8MPe7T4MZx2NsVLQ9qJoQFkwDZs3K/Bv5ByrKvvEuLL3wtZLMLnqwRzxrwM2W7Il0hARoT509ui2CWkRs1scMyH9wNw0Pd+MxRU3XfHJulgiK3S5kukVdZ/Av9TV4kXgS/lUGioVeu+rKmhB9Lt0xSPVg9+N56Zv1KJldXRwscEftK42/o8JDigDdAzld/N2BZaU583nRSilEO6gFtuRNXWN7+ZS/G8staWOu
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1182b6-6e9a-4263-9f72-08d660f95f4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 12:49:08.0157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5745
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_044923_213525_E50D34F7 
X-CRM114-Status: GOOD (  25.91  )
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
Cc: Arnd Bergmann <arnd@arndb.de>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 Olof Johansson <olof@lixom.net>, dl-linux-imx <linux-imx@nxp.com>,
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
> Sent: Thursday, December 13, 2018 3:58 PM
> To: linux-clk@vger.kernel.org; Aisheng Dong <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; mturquette@baylibre.com;
> shawnguo@kernel.org; Fabio Estevam <fabio.estevam@nxp.com>; dl-linux-imx
> <linux-imx@nxp.com>; kernel@pengutronix.de; Aisheng Dong
> <aisheng.dong@nxp.com>; Arnd Bergmann <arnd@arndb.de>; Olof Johansson
> <olof@lixom.net>
> Subject: Re: [PATCH V11 1/7] clk: imx: add configuration option for mmio clks
> 
> Quoting Aisheng Dong (2018-12-12 17:07:52)
> > The patch introduces CONFIG_MXC_CLK option for legacy MMIO clocks,
> > this is required to compile legacy MMIO clock conditionally when
> > adding SCU based clocks for MX8 platforms later.
> >
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com> diff --git
> > a/drivers/clk/Makefile b/drivers/clk/Makefile index a47430b..8a9440a
> > 100644
> > --- a/drivers/clk/Makefile
> > +++ b/drivers/clk/Makefile
> > @@ -72,7 +72,7 @@ obj-$(CONFIG_ARCH_DAVINCI)            +=
> davinci/
> >  obj-$(CONFIG_H8300)                    += h8300/
> >  obj-$(CONFIG_ARCH_HISI)                        += hisilicon/
> >  obj-y                                  += imgtec/
> > -obj-$(CONFIG_ARCH_MXC)                 += imx/
> > +obj-y                                  += imx/
> >  obj-y                                  += ingenic/
> >  obj-$(CONFIG_ARCH_K3)                  += keystone/
> >  obj-$(CONFIG_ARCH_KEYSTONE)            += keystone/
> > diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig new
> > file mode 100644 index 0000000..37478ba
> > --- /dev/null
> > +++ b/drivers/clk/imx/Kconfig
> > @@ -0,0 +1,5 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +# common clock support for NXP i.MX SoC family.
> > +config MXC_CLK
> > +       bool
> > +       def_bool (ARCH_MXC && !ARM64) || (ARCH_MXC && ARM64 &&
> > +SOC_IMX8MQ)
> 
> Ok I looked closer, SOC_IMX8MQ is only being introduced now and has only
> been in linux-next for a few days. Having such a config symbol is highly unusual
> for arm64 code. Has that been accepted by arm-soc? I don't know why it
> would be because we don't add SoC specific config options anymore. I imagine
> it will be rejected and we'll need to have this new MXC_CLK config be enabled
> in the defconfig instead of selected from the arch layer.
> 
> Given all that, is there any damage if this is just a def_bool ARCH_MXC right
> now? If it's enabled on the platforms that don't use it because they have SCU,
> does it actually matter? Or we just get some code bloat?
> If it's just some extra code, then even more reason to make a user visible config
> option that can be selected in the configurations that care to save some space.
> 

It make sense to me. No actual damage as we support multiplatforms using both
MXC_CLK and MXC_CLK_SCU on ARMv8. And for users who want to save one of them,
they do can change via memuconfig later.
I will make it a def_bool ARCH_MXC.
Thanks for the suggestion.

BTW, as I also introduced SOC_IMX8QXP in Patch 4 and 7.
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
+obj-$(CONFIG_SOC_IMX8QXP) += clk-imx8qxp.o clk-imx8qxp-lpcg.o 

According to your former suggestion, I think we should remove it.
So I'm going to make imx8qxp clk an user selectable configuration option which
will select the common MXC_CLK_SCU. So a bit difference from former discussion,
MXC_CLK_SCU will still be kept a hide option.

This way is mostly like how QCOM does and should work for IMX as well.

Then it will look like:
config MXC_CLK_SCU
        bool 

config CLK_IMX8QXP
        bool "IMX8QXP SCU Clock"
        depends on ARCH_MXC && IMX_SCU && ARM64
        select MXC_CLK_SCU
        help
          Build the driver for IMX8QXP SCU based clocks.

If any issue, please let me know.

Regards
Dong Aisheng

> > diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile index
> > 5c0b11e..f850424 100644
> > --- a/drivers/clk/imx/Makefile
> > +++ b/drivers/clk/imx/Makefile
> > @@ -1,6 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >
> > -obj-y += \
> > +obj-$(CONFIG_MXC_CLK) += \
> >         clk.o \
> >         clk-busy.o \
> >         clk-composite-8m.o \
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
