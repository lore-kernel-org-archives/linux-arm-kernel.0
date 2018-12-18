Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC579C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:17:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B7D9217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GEOltpkm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r2MkyULG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7D9217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YWU3hU0K+iHTKj7q7vO2gza/7PzDYAMV5yB0UxDO19I=; b=GEOltpkm+vuJET
	0XzLF+XKRr+eWUdZmGyEi9VMl18jXGVgtDMNkyvE50L9J79KogfZ851CT1mIAAEh8kaRg7KPsjG8y
	KElQbWbXzH4pkbXRSsR3o6BQ84C1TdcfYEldY0G2pUw7gS5Kyp646aDgXsEiAVRxxG4ZEPwi0rg4l
	6luCd/jS3XEKC3gq+2XxC2C3SIY2D6cHfu/bb/l/fGO779zZFpdigRCIqVn9ce4M9kL4c3SPMmkLZ
	FM6/KyFw5Yl/9nij4lPBU35eGqS+ntZfaCsFukiPl9IHY1ZouetSt7yFFNJ8s4ufOpXPNe9GsNt93
	gpMKdBC1O+uvAUt+VMeQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZGBA-0001Sx-C7; Tue, 18 Dec 2018 14:17:00 +0000
Received: from mail-eopbgr140070.outbound.protection.outlook.com
 ([40.107.14.70] helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZGB7-0001Ru-GV
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 14:16:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2Y7EvIcCHexouM3HBkeQw2IoQ5LVllDDVjuFzBX/Ug=;
 b=r2MkyULGCIQXCi5x9pOnOLJ9ubQ462vUGZDSKRwA0pwxKNQ4/F7B4AfCFNmbo5t2K2CMIjk2Z81kTjXvnUuELb0XvA/Mz3cMs4V4vvLlSt3K0bX9Up6eFWoApBQWXNLFO6MZZYIlgomrsibTEvWTG0WTVrhalMYpDOs3a2aAfP8=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5025.eurprd04.prod.outlook.com (20.177.40.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Tue, 18 Dec 2018 14:16:44 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%6]) with mapi id 15.20.1425.023; Tue, 18 Dec 2018
 14:16:43 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, Wei Yongjun <weiyongjun1@huawei.com>
Subject: RE: [PATCH -next] clk: imx: fix potential NULL dereference in
 imx8qxp_lpcg_clk_probe()
Thread-Topic: [PATCH -next] clk: imx: fix potential NULL dereference in
 imx8qxp_lpcg_clk_probe()
Thread-Index: AQHUlpvry2qgkPP2Wk6112vrMZV9TqWEQIGAgABJ0CA=
Date: Tue, 18 Dec 2018 14:16:43 +0000
Message-ID: <AM0PR04MB42111E537F8377C4DDAD56A880BD0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1545115389-173136-1-git-send-email-weiyongjun1@huawei.com>
 <CAOMZO5C1+bxWtapaBrdzf0o3Q30BkBNHLg9=4K5ZsxBk6s2DWw@mail.gmail.com>
In-Reply-To: <CAOMZO5C1+bxWtapaBrdzf0o3Q30BkBNHLg9=4K5ZsxBk6s2DWw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5025;
 6:mcPocRJc3jJGKc2SFkNXh7jTPBvOwWI9+vLISdXD2754i/reMDR+jbBep69i1ugzoBWPmWneJdeTEyf81HtXpqiz2WopQxA1WJzVAHEBsrexK/m4SuH0JwumxGyATLLWkB2gSoRff0Wwu9T6lGcRZ8ryzm/OabJVA1Jzre/Tt3LijOvlqJpaf8ZOA4kD8wsgpRd/5H+xSG5cRVfq361sCbHyNzzQ84m7+XP1L8UoUB8xt1pUd7qELWCkrQMXzXoZX2phvUTg4WMA663xiwYRCcwRpez34Fhpl/kKwi9ShfplORt1G2xcsCZCBmdH12svvy6E54HNO5/VXG3gnim2ZA7P81LNJSY/fMzm7IIn/HYrP2SzouC8uquoa2cZad50e/tKNVIRCtvEk9AJmTGAyUUA1hGkuF4HBJO9JcU088+9BH6qCb2I/+KsYDRELgGYbdWLyyyBuYW3xent3TS/NQ==;
 5:RNFL9W+ONRpJaAe0RvAkS6LVd9/HVv5cFeb9xt4BeLOrlA27RDlJakFWM5vFu4vvvzawx4cPLEWRhS0LvWBTMQGMCCI96K65SG+XNSzFWZnYrl9jvSqEv970iiJ4+0M3Ckzll7+Z8N5r0Ujw2AgBfAK52R7DoDSH5OmSSag7rdE=;
 7:ANpfH5iiV+WeaCqmYKKL2cIQ1PaDmRpmNxTy6YVo6m9elrh3saT47lrmazYe6TBrbbLg7bxDCOHY6Lk5U4KsKnxelAex7LAfqy12l1ibbAuM4unhR1MItQpyIf6Ufijui0X+QwSyM18ZS+X21cwT1g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 03876311-c95d-4d18-d92a-08d664f37013
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5025; 
x-ms-traffictypediagnostic: AM0PR04MB5025:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-microsoft-antispam-prvs: <AM0PR04MB5025105367C9FB7B52C6878E80BD0@AM0PR04MB5025.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5025; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5025; 
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(136003)(39860400002)(346002)(366004)(376002)(199004)(189003)(13464003)(4326008)(5660300001)(53936002)(9686003)(14454004)(86362001)(33656002)(97736004)(6246003)(39060400002)(74316002)(7736002)(7416002)(55016002)(305945005)(476003)(11346002)(105586002)(44832011)(106356001)(446003)(6506007)(53546011)(102836004)(486006)(76176011)(26005)(66066001)(71190400001)(71200400001)(14444005)(186003)(256004)(110136005)(25786009)(54906003)(316002)(229853002)(2906002)(478600001)(68736007)(8936002)(81166006)(81156014)(99286004)(8676002)(7696005)(6116002)(3846002)(6436002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5025;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: i9SHsOiq71jV7q4gWhfnLmlUV8dBx1R0B3rJcflnZZE6USIQoAk+QXsVOlWaSCOgMOuKeaXmUquM2/MsJLTXoLA3P6kzGX85Km2b/OQgHksoLunCfBLEe72BivgrewwIRQxgmNH9URDywaEm5mcVexLqEgFrZByH5At9xCXisWgNNK27KaOP6/GPDH13b32MeYICOky38c2CuTby89LuL1n1qpGLEAp1lnldv73mAsc8/ouKNOf1WHFj8ZgPZfyMZGIhPnvJ8vxt3gX+STGKNQmRabWYTzUEO+gpecWWbjaPitwzkqKdZv/hlxcsxN0H
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03876311-c95d-4d18-d92a-08d664f37013
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 14:16:43.8902 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5025
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_061657_603486_1EBE5363 
X-CRM114-Status: GOOD (  13.76  )
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 linux-clk <linux-clk@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, "moderated list:ARM/FREESCALE IMX /
 MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> -----Original Message-----
> From: Fabio Estevam [mailto:festevam@gmail.com]
> Hi Wei,
> 
> On Tue, Dec 18, 2018 at 4:36 AM Wei Yongjun <weiyongjun1@huawei.com>
> wrote:
> 
> >         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       if (!res)
> > +               return -EINVAL;
> >         base = devm_ioremap(dev, res->start, resource_size(res));
> 
> Wouldn't it be better to use devm_ioremap_resource(), which does the NULL
> check?

No, devm_ioremap_resource will call request_mem_region which we don't want
as LPCG memory space may overlap with other modules within the same SS.

This is something like the syscon device does:
drivers/mfd/syscon.c.

Regards
Dong Aisheng
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
