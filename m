Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523C6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:28:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ED0C2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DMc/12wA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="X84kgaH2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED0C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b1PsHdtW+RvFhgNdB/Kx8DDLa2p1o2mBFOMzFQtxwTI=; b=DMc/12wANSlquM
	MFeRgMumSg3VuPdpURL786PKTJRrhI6eDU6e5YWfJYaZoHahPWr4iYRTMZ/T0jkPwc7BrU1FEualn
	644QsaAH8wWb7FmW7v/z+awwUT6ZLY0YWT1Ve4vCJr6NXQr2HnYu+6ku2Th0iM+Bkxmz2HEucVYOc
	2WqZl7QfNj7Acyh5tfJ1Ve9YVeS5VFV+Xs+YKX4hlBA32BPrO0f8gR0GEmC+kEBPjkBbX9I9kpTq+
	MpzS7MGHwLorAJ9wzT15lXV6jyhwrmJhlEP7b7zZ0XY7Myq9bZnQnFCtEf2atvUK0hYAOCkNme0mo
	1c7dPdnS+g0h0EfO04Tg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX1kD-0004uE-4C; Wed, 12 Dec 2018 10:27:57 +0000
Received: from mail-db5eur01on0605.outbound.protection.outlook.com
 ([2a01:111:f400:fe02::605]
 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX1jw-0004tq-RU
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 10:27:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwpuEu5fzBl5ztmr3P2kpFVI1L1td3Z5+RJmOOW1ljE=;
 b=X84kgaH24S4Vjr5GUABvQE5nOcfi/OhlxLiJRGgQX1I8Ir5DCPD3BHB/SXEED8THEjkKGtlgGMAvuWnev6xgF8YRCX+LnrDvFX6cRpR7KA3C6paJyZEweghI5vSm4Iq1gMjTYTAgV+2SmyuUhMpdNdOg3eqU1KVrPzRxQlY3C1w=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB3955.eurprd04.prod.outlook.com (52.134.90.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Wed, 12 Dec 2018 10:27:24 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Wed, 12 Dec 2018
 10:27:24 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V9 1/7] clk: imx: add configuration option for mmio clks
Thread-Topic: [PATCH V9 1/7] clk: imx: add configuration option for mmio clks
Thread-Index: AQHUi98lQ6o73Estskm1k5h96wz2oqV4fYEAgABeCkCAARxjAIAAXN6QgACazVA=
Date: Wed, 12 Dec 2018 10:27:24 +0000
Message-ID: <AM0PR04MB4211C8B8DC2D5F2133D30B9F80A70@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1543934041-12572-1-git-send-email-aisheng.dong@nxp.com>
 <1543934041-12572-2-git-send-email-aisheng.dong@nxp.com>
 <154447530435.17204.3027810086542897433@swboyd.mtv.corp.google.com>
 <AM0PR04MB4211B87A842FB8AF14621E3380A60@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <154455657071.17204.2493209125185218529@swboyd.mtv.corp.google.com>
 <AM0PR04MB4211D9C32A4DDCCF266B60C380A70@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211D9C32A4DDCCF266B60C380A70@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB3955;
 6:b8ibR8TLb12iW31MMWLH8gvoxrOK0rYGk9F4ORL6lYgTn0kusXUDaEqBdlON4fyfXpGWtGxXW5Yf0dHklMOt1gWSXqS3q2oV5qA3mq4gvg+N6huqftT2bTgB6bofkqtrrkFjBxpvZp/HGUPdQVbO7FFu4XCqZdXOUMqNLcrp7UdelHKT2mciARLFSwrCsDZXkMzCA9muHMIKZyLiXEQCyKdzQ9Gc98MhWjXF1WcrwgsGdcegjV80+VY1f2qnCXge5xNjMCOtAbKnjF1tkOTsMhdsUkn35c5Ol3EvuGPnFt6Lm1ccepiSnfrFoZjEAKdnMNaFASCn9aJwSZW2Ib/vuOJAoewjIgr8ohLTB1rWNRiX8t7GNgPiQ/OsW7ZVP2rzamD85wioRLC4Hk/0HbMRmMk3KF15AOq3kQNfG0Y0l4GwOHYfHHE7ikSbqXWceufRQtGi7euAFfL14Y84NZvMjw==;
 5:rJ49of83wgCnAbnnuQH5on9ztyyrIMYjBrAD/9KPRCC9xr19EKYNCxCQl0LVr1A4+1Y/q6j8mS+PunkhGxgrpJinbPrUJPUd2ipD36XQ/G79TKOwIq1+pLONnEtfih/+qKxtijCWfN9YwY1lnh0ipaCzaq/s9++nbRXe+bZveUI=;
 7:GOpv6T9ggKt7iCiMrvbzZkxj/FPk3cj68eaGJryvzXWGQwaLVYi3h+PNXf4okROjvm+J8E7S1ysP5XIgW2fdO8oK4AK0dBUb+im0paScnSsVZnFoZ6q0Cjm3nAm7uY33oaRHPXCDTk0u8leGexQVBQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cc196a77-c774-42a2-13a9-08d6601c6888
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB3955; 
x-ms-traffictypediagnostic: AM0PR04MB3955:
x-microsoft-antispam-prvs: <AM0PR04MB39554D19A01DB4D6AB02919A80A70@AM0PR04MB3955.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231455)(999002)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB3955; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB3955; 
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(39860400002)(366004)(376002)(396003)(136003)(199004)(51914003)(189003)(26005)(53936002)(4326008)(3846002)(6506007)(76176011)(14454004)(7736002)(33656002)(71200400001)(9686003)(68736007)(7696005)(71190400001)(66066001)(6436002)(305945005)(486006)(55016002)(186003)(102836004)(6246003)(446003)(93156006)(6116002)(476003)(99286004)(2906002)(2940100002)(229853002)(478600001)(575784001)(54906003)(86362001)(256004)(110136005)(93886005)(44832011)(105586002)(81156014)(97736004)(106356001)(81166006)(11346002)(74316002)(14444005)(25786009)(5660300001)(8936002)(8676002)(316002)(2501003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB3955;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Bqfhn4wz01p0lP8mwvrLdU/eFnv41s4poupHjORq7Z52dlTOjrOlsu77kgFmUKk+cEv/DlSAku+Iqbr/0noUaYfV2q9GGmaK3pQRHYCJjYadxnCF+t2kXQx4GVYp7KOPbBxSiyI+BGp00wein/Ze2eP43IgIaQrWjsX2xZ46y9OwbpsOklz0x2ZQjrdgfILkLoYa7YYNzJsY+8wT3zREDSC+PNsIxBOkJGFMLDdjvWRqdhJYDQuxbra/XbygKW960h6g+zB6gtdwg/Xka1rgbt3+ZoXnmpvHp910ESeE+cY354HiMy2CoQ+heUpUArbM
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc196a77-c774-42a2-13a9-08d6601c6888
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 10:27:24.7792 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3955
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_022740_960318_F5B67F7C 
X-CRM114-Status: GOOD (  18.40  )
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

Hi Stephen,

> > > > > diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> > > > > index
> > > > > 5c0b11e..f850424 100644
> > > > > --- a/drivers/clk/imx/Makefile
> > > > > +++ b/drivers/clk/imx/Makefile
> > > > > @@ -1,6 +1,6 @@
> > > > >  # SPDX-License-Identifier: GPL-2.0
> > > > >
> > > > > -obj-y += \
> > > > > +obj-$(CONFIG_MXC_CLK) += \
> > > >
> > > > Because this changes to obj-$(CONFIG) we should change the
> > > > drivers/clk/Makefile to have obj-y for this Makefile instead of
> > > > depending on ARCH_MXC.
> > >
> > > We also use ARCH_MXC for ARMv8 SoC clocks.
> >
> > Yes, and? I'm suggesting drivers/clk/Makefile have an obj-y +=
> > drivers/clk/imx/ and then decide to compile or not compile the MXC_CLK
> > "core" bits based on CONFIG_MXC_CLK config option.
> 
> Sorry for the missunderstanding before.
> I guess you point is have an ojb-y += drivrs/clk/imx/ Then in
> drivers/clk/imx/Kconfig config MXC_CLK
> 		def_bool ARCH_MXC && !ARM64
> 		select MXC_clk bits
> config MXC_CLK_SCU
> 		def_bool ARCH_MXC && ARM64
> 		select SCU clock bits
> 
> If wrong please let me know.
> 
> Will update the patch series and re-send.
> Thanks for the suggestion.
> 

I tried and met another problem that MX8MQ (ARM64) is also
using legacy MXC_CLK. (And 3 more MX8M series based chips.)

That means I have to write something like:
config MXC_CLK
        bool
        def_bool (ARCH_MXC && !ARM64) || (ARCH_MXC && ARM64 && SOC_IMX8MQ)

config MXC_CLK_SCU
        bool
        def_bool (ARCH_MXC && ARM64 && !SOC_IMX8MQ)

But it can't work as ARM64 supports multiplatforms.
e.g. we have also SOC_IMX8QXP, SOC_IMX8QM, SOC_IMX8DM ...

Do you have a suggestion about this?

Regards
Dong Aisheng

> Regards
> Dong Aisheng
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
