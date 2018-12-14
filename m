Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD16AC6786C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:17:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DF1F20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FJKENsdt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="w8/1Vwgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF1F20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8hoCgWuX1CDUKgY1ncZ2WlX9cUbrWryKdBAKsdKTcPs=; b=FJKENsdtFKxChM
	p+K+You2adSvIjlfRe+4lwc+xr1q+ubOv+GDZyI/xQr9m5t49kTUCAn1oiVTzWYTB0M0Jk5OSCDXL
	dQvCMY1F1jPdqEfuv4TDqLssFciMQvoAqPtl8RtJE1IiUMLWZ0Zv0X81Kl6EAUd41SHD34J6+DXR0
	Vp8q2fmIlLxVo0SXVlQa5r9ZZ/3CuNdh4eQyX3VxHURZpO6Js1jhMSzhIPgT+XO0Q/gtbmN09Todt
	CnPSfpVfic8gwg/IYhxeYSB8BMoE2e1q70urdER46ObmjXteq1LnOq/6ygzIaysa+uYlODvv/mHSp
	Mx5BYpoBmZx/9WKqA6pw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXgma-0001C4-PG; Fri, 14 Dec 2018 06:17:08 +0000
Received: from mail-eopbgr140077.outbound.protection.outlook.com
 ([40.107.14.77] helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXgmX-0001AO-CD
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 06:17:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+FBpd83tk2ANQ9vywX9ZBzbdXe9hn5snnyeqOYqJVA=;
 b=w8/1Vwgz3d1zGwCaToi2OK4QIefRhQ56ihl/e+AXe4ZDv9M91DGjKqLmJK/0sizM3QNeLZg9q6j0Ag9BHqRptZ6SyB9KP8j4kazvzdY5g154nN2ht5Lo+IpJ0Om0GW2qkfdXadKOpzp9JhZZSdPv4n+wmSjMR1tBvelJNVgfhbw=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4865.eurprd04.prod.outlook.com (20.176.215.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Fri, 14 Dec 2018 06:16:52 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.028; Fri, 14 Dec 2018
 06:16:52 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Subject: RE: [PATCH V12 0/5] clk: imx: add imx8qxp clock support
Thread-Topic: [PATCH V12 0/5] clk: imx: add imx8qxp clock support
Thread-Index: AQHUkvp+2I/kA9Gq1kKYOSfh1d+quqV9fQkAgAABMXCAABN6AIAAA+qggAAGT4CAAA3/QIAADGWAgAAKNwCAAAJOgIAAACKA
Date: Fri, 14 Dec 2018 06:16:52 +0000
Message-ID: <AM0PR04MB4211E547638B39B2A44015A080A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1544715442-8902-1-git-send-email-aisheng.dong@nxp.com>
 <20181214020533.GC13243@dragon>
 <AM0PR04MB42114ACB1A55BB42D2C5523280A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181214031931.GD13243@dragon>
 <AM0PR04MB4211D692CBED348EF8C109A180A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181214035606.GE13243@dragon>
 <AM0PR04MB4211CEFB586B7878BBB58FEB80A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181214053033.GF13243@dragon>
 <154476762849.19322.6761040252503231833@swboyd.mtv.corp.google.com>
 <154476812306.19322.4832664425826114886@swboyd.mtv.corp.google.com>
In-Reply-To: <154476812306.19322.4832664425826114886@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4865;
 6:R44mCOPINz2//Kp7/mm6OxxBaQspChR2YOy/HO6jxNbmh4OwULRkFGxcKrufoKWAdKQ+PnyQns/k0YCMrZFb7jJ+QoAW5Lxf/p5W2wuEBxXIH1Q4+pD1aFKzy7XXPhIkXSytWTqNCDVEGtM7KWnFUXS5EHlCKxR/FRKyCjbv4w7uYhe75nfAbL3wuVEpQeng+8DHkCy8LITAKjdqbqOa2wvjlvlCkQj98Gb5Bwu5JjQL5EriyfUeM7pZbawazxX3moLXWrMl6HlQ6NO+52yOh5SdjC5AvwqnmHclobuSKXGWlX5ggob1vxLE9z1/RAmMyIh9aJxR3U89coe2hZ2TlFUaepnVtPbrchE4q8estm96NG3EFY2nqkRXvbPFMsriOLdw36SQ6UWERVUrKLx0eaaPzaYnzwrACaN1IoFHTxOIjlL1VhguvfSIRN9GOO7i3GidGlogueOvgE4hBOYYmA==;
 5:EqRiN/SwaPeuLNKrbCDsFw2GCA8X2gNKrCl2qJ2g+FGARsl4o+/axhsc+38iSw1xpIlTqw0rXSy+UIPYNcwQWl8DHQsAKGtRfBHlYRuBnrxJBv5we/tJhDo2Cl3L6xRZqvjfe2Rpg0aonk3fPewpqqJfEfdEjXggQ5O8PuB5zkM=;
 7:HVljdSp1eFCtw2JZ3VkW56cRqN4uaebZacHj6BPfsAADzK7Ygaw8AMCdaHx48qHcuuoDHRZa4bO4o2JOQjoGvul1qV1EYRi8EnA+1f7vq+XnX/nOqAd/VLU/e6/AI61hpZjMCx/PyYsGE1Wr3/3Q1A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b1f82e5a-b312-4626-65e1-08d6618bbd40
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4865; 
x-ms-traffictypediagnostic: AM0PR04MB4865:
x-microsoft-antispam-prvs: <AM0PR04MB486558B13EA4C1D649A0545E80A10@AM0PR04MB4865.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4865; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4865; 
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(396003)(39860400002)(136003)(376002)(13464003)(199004)(189003)(2906002)(33656002)(93886005)(66066001)(71200400001)(6436002)(71190400001)(55016002)(478600001)(7736002)(305945005)(14454004)(256004)(99286004)(106356001)(105586002)(4001150100001)(5660300001)(316002)(229853002)(81166006)(86362001)(102836004)(74316002)(26005)(76176011)(54906003)(9686003)(44832011)(8936002)(486006)(8676002)(81156014)(6246003)(476003)(6506007)(53936002)(6116002)(186003)(3846002)(68736007)(25786009)(11346002)(4326008)(446003)(110136005)(7696005)(97736004)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4865;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tr81m/iF9SWYG4RwvM+iGns+n5QcT7jaA4r2R7+7yjamRWi8RKU/c6LDRoaCv7XOph5BlnAqKMVngY06hchnyMC3JSEgtOAktNR0XuYsCMjuC3zczJxtabpnzp4jrRl+t3nm5I3AvnWfbyD5Gkg7vTYrZ4TAS1Fdrga1Zrtyu6bD2RPsyU+Y8txJkecvzBlnwqHLjcQNzZg8bqnpO5ANxW3WUNvJ9avK6mZAChZb0m015EnhDTlfYYezrSt5NUVHaEu3XlM4PFOz6+G1rOpoq/pHURK3wavPxqLzn2vf74Zc+7rxCuZ7LF+4JI69Sqjn
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f82e5a-b312-4626-65e1-08d6618bbd40
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 06:16:52.1755 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4865
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_221705_417196_94C22CF3 
X-CRM114-Status: GOOD (  12.60  )
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
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd@kernel.org]
> Quoting Stephen Boyd (2018-12-13 22:07:08)
> > Quoting Shawn Guo (2018-12-13 21:30:35)
> > >
> > > In case Stephen is fine by pulling dependency from my tree, it's all
> > > on branch below, which has been pulled/queued by arm-soc folks for
> > > 4.21 merge window.
> > >
> > >  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
> > > imx/drivers
> > >
> >
> > I can pull just the first patch from this branch and then everything
> > will compile? That should be OK.
> >
> 
> Hm.. turns out I need to pull up to
> 
> 0a914a4948d4 firmware: imx: add pm svc headfile
> 
> but then it all compiles fine. Ok I can do that.

Yes, it is.
Really appreciate for your kind help.

Regards
Dong Aisheng
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
