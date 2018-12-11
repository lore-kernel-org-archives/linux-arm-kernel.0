Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E5BC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 04:06:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE58720672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 04:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UyetoI/G";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eTicZj6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE58720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KAeIqW9ssM+u4NlkNVOliuN+gTbleRhx3dtZIi0NdUI=; b=UyetoI/GivCdpC
	WjRkwSflWtuJ+39MJH+BE4AjnDGI9rVYRz5pvnpMW2Lcf4XNwW6DaJm0+siJJdICyyHUqUdoZFfm2
	NXvDscWJ0J5Esu+rgmmJLNLZxMsoor3RPMzI95Phg7EAlZMeMwxrH7Am8eQ0+pLNh7v1zQn7iqicG
	F87RS5qA4ipNxOrGBOXRpyL4ZVPAv10dJEhS0Dx8JT6TjGU65MESd9XeKWItel+lHMgqcjL7ikHqZ
	O7f3Ezylc+fa4B3sOr2640/aQX2Ff/021SWqbBze/LwQyT70wAHXTUk5ZB/YLDWa0/YzJPBc6gBcS
	n76LkE4IOgk3Qg3M9WGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWZJE-0004bb-Ep; Tue, 11 Dec 2018 04:06:12 +0000
Received: from mail-eopbgr40068.outbound.protection.outlook.com ([40.107.4.68]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWZJB-0004bE-7C
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 04:06:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iRLmvYNgZEshPDfT5bQXdhVD3/xeaBxphY5yHqq/wY=;
 b=eTicZj6Ga5IYob/g0AohJEyKFIPyuRJ9tgRzPccc+BhR4W0WXtxjYNTGIek6aKH/3u0x3nfGKL8x7JhHLkjZ9vYtOt6OlPvK44lPqX3rn0Yo3TKH1sLbu1zkIf6IVVdUugrq4BRAobBztJohiiVabR2Kl/k7VR6PaOvOPJLGMF8=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4145.eurprd04.prod.outlook.com (52.134.125.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Tue, 11 Dec 2018 04:05:56 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 04:05:56 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V9 0/7] clk: imx: add imx8qxp clock support
Thread-Topic: [PATCH V9 0/7] clk: imx: add imx8qxp clock support
Thread-Index: AQHUi98jvykrnvKQL0Kg33biwal6j6V4eymAgAB4qnA=
Date: Tue, 11 Dec 2018 04:05:55 +0000
Message-ID: <AM0PR04MB4211BE52F403155BD09538C780A60@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1543934041-12572-1-git-send-email-aisheng.dong@nxp.com>
 <154447480107.17204.18337865638259063687@swboyd.mtv.corp.google.com>
In-Reply-To: <154447480107.17204.18337865638259063687@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [101.93.238.110]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4145;
 6:sjQhA3lWz9lC7HWM1pTCDSkJBDmC0MCXPkDB1tfqd2g+NZ7ryCYlYamDnMfnTMWj9dLDXCuabnmkgQlbT3dY6w0EgN2/WEvVZtRt3oXlGbF+sUXRANWBvmcxTgd9PAY8wnb8EMFYBRuKI7e4s/xzj3xbJpwx4m6wwsvFeMbEG46CIRspWZ/2Jxzj8qSRZbZh4oo+WMc6OIQnN7leuzVPkGnPqa28wR/fzNxSuwRFhA81jV4sNnu9vCicvU6+x7BZgdB2u7XiCc3LRn+J6nHowrvCnzdxxfotosM9LGRBmrEkCwhsTtkpBiKp/9qir25+rqxmy4p5YCvQXaG5atTC8MbPuvhTSUrr33hjoDnZMPc5ZSviaU4eYMemPbbafA65v6pAZR9DXr79ldpFkyAIqYCYYvjz43KPDdnI1y7rSe8fNKIZgEZIy9bwCOvj4AA8YN+gOAwEjz/R+Wmd0JcmSw==;
 5:aN70vqpSq1uZVKlxlW31N1T+O8OmMp4HYsLrZSACUFsJ76ImFT2W8DzMYRkJdedVmafF7uU8PlGxmGYeXNHSNMGU+T5bBiE4yIQYFCMlux/XHU9rIVNiekHEI2pvOCJq+NAafkjlF5X6cMUDSBH6Q73NBQEXge/H9Bnz4JwXwFY=;
 7:vsKoBTbrYC868R/2zPeGRx1NC1oLeQNx5JCr5Ns8PkzX2j5C6qIerLPxRJKXhPVNWQBVW7BArcmI5II43220gaPcW+yua1M0yRH9Zexw7I+oh8UB+CV4wD5GtHpmXj0PgCvJmGnqxUsniYjQ2PnTUw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6759afdf-35bc-4c7d-cd87-08d65f1df353
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4145; 
x-ms-traffictypediagnostic: AM0PR04MB4145:
x-microsoft-antispam-prvs: <AM0PR04MB41455977796C5BD3973FDC1380A60@AM0PR04MB4145.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4145; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4145; 
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(366004)(136003)(39860400002)(396003)(199004)(13464003)(189003)(9686003)(53936002)(2501003)(446003)(3846002)(81156014)(2906002)(11346002)(81166006)(110136005)(316002)(54906003)(486006)(476003)(55016002)(8676002)(6116002)(97736004)(14454004)(86362001)(44832011)(99286004)(8936002)(106356001)(6246003)(25786009)(74316002)(186003)(66066001)(68736007)(105586002)(71200400001)(33656002)(5660300001)(102836004)(256004)(76176011)(6506007)(229853002)(7696005)(14444005)(6436002)(305945005)(71190400001)(7736002)(26005)(478600001)(4326008)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4145;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wCO0wVJP/39W11tVO7bqL+jYSAJeEOddDyW5xn6gJiJ/+QrAa1kgRQIv0neMaLGAdQBgyNYTlIw/ibBlldOi7Xwufi5T/zdj7krUbc1KgxASLdDmkVpxmGqBcREbTPFuAhtkzgdutE76lGzRGOnYJIa2gDYknHHDQK1obZzbrwjpZiCNyxoXSJOBX06zp3KyDF1p2q7o3LtU6Hh+Z/GlQKRAgHKyXw9BtzGu+4W5/MrXKc7DJjs7/WBwfLI9O4+YKQwya1tU4CF/p4r+ObpystSsBlbSGXFw++0I4BQdoymdy7RExBL2FAw8ktWJMzKk
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6759afdf-35bc-4c7d-cd87-08d65f1df353
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 04:05:55.9669 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4145
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_200609_264952_DE991688 
X-CRM114-Status: GOOD (  15.35  )
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
> Quoting Aisheng DONG (2018-12-04 06:39:18)
> > This patch series adds i.MX8QXP clock support which is based on the
> > clock service provided by SCU firmware.
> >
> > Note: It depends on SCU driver which has already been merged by Shawn.
> > So this patch series could go through Shawn's tree as well.
> 
> Which patch series?
> 
> I'm having trouble applying the first patch, so I suspect something is wrong.

As I replied in last mail, patches were made against clk-next branch.
I also tried apply against clk-master branch and met the same failure.

$ git am *.patch
Patch is empty. Was it split wrong?
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
$ git am --skip
Applying: clk: imx: add configuration option for mmio clks
error: patch failed: drivers/clk/imx/Makefile:1
error: drivers/clk/imx/Makefile: patch does not apply
Patch failed at 0002 clk: imx: add configuration option for mmio clks
The copy of the patch that failed is found in: .git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

If manually apply, it can work.
$ patch -p1 < 0001-clk-imx-add-configuration-option-for-mmio-clks.patch
patching file arch/arm/mach-imx/Kconfig
Hunk #7 succeeded at 571 (offset -9 lines).
patching file drivers/clk/Kconfig
patching file drivers/clk/imx/Kconfig
patching file drivers/clk/imx/Makefile
Hunk #1 succeeded at 1 with fuzz 1.

I guess it might because clk-next merged clk-imx7ulp.c and clk-imx8mq.c which
Changed the drivers/clk/imx/Makefile a bit.

If you want me to generate the patch set against clk-master, please let me know.

Regards
Dong Aisheng
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
