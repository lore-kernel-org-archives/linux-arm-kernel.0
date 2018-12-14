Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8468C6786C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:38:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A052080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hvoHBS4m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wRg/MZ+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A052080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a9IjVQsWzJJ1mPfOx3QwrRzitrvklg+2jgcZ1ScGSI0=; b=hvoHBS4mxiNQTy
	pYFPuhw1B7Jwe4/dik4LZUbhuWhOxWnzWeqeReek+UyvK7pTRtkG/YltV7ZtLtI8n5vpGQv/JnT24
	hi6bDskuoq0cmv6tGY6COUyIZcZ2xcogKezuSGGbjeb/SHqfaKkx77zCjEIJMj08pyjJvOrN8uy+z
	gvjv7+IwW7qa8/IdcQC8ZuV/QXZud/mkflh48mphMhaR9jMROsGFQr9TIE2xK8FKTQ/qiTJzUaC9k
	zlgnZFUene0XOOuJNrYyHKxase4h+mZ1TA57+xEo788r9eZFwukiFR/6zL9XxH9TiTL4lB6OehJnt
	RkpC3hBcSseBs0cJ4JHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXeIf-0006eu-Cc; Fri, 14 Dec 2018 03:38:05 +0000
Received: from mail-eopbgr20069.outbound.protection.outlook.com ([40.107.2.69]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXeIb-0006eI-QY
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 03:38:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fyi6Tk0jwR9J24jAL1aDNRqOMUxgVZ+LbwnehRd0te4=;
 b=wRg/MZ+ZzFo3eBA2ozg1JllbBXslQl1X2R/3N0/Z6UUl1JKiH4asnooR1qAPHo5wwM8hjs5+Bgv5w2Yl+AsiFHlZFTFgXXj2lI5E54A7a7b+joU3Rg7tz9LCPsIAhXJsZQwKh+tP8ncwGfnWE7UbVgOzkQGJFyIhfXiKq9IVv7o=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5297.eurprd04.prod.outlook.com (20.177.42.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Fri, 14 Dec 2018 03:37:47 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Fri, 14 Dec 2018
 03:37:47 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: RE: [PATCH V12 0/5] clk: imx: add imx8qxp clock support
Thread-Topic: [PATCH V12 0/5] clk: imx: add imx8qxp clock support
Thread-Index: AQHUkvp+2I/kA9Gq1kKYOSfh1d+quqV9fQkAgAABMXCAABN6AIAAA+qg
Date: Fri, 14 Dec 2018 03:37:47 +0000
Message-ID: <AM0PR04MB4211D692CBED348EF8C109A180A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1544715442-8902-1-git-send-email-aisheng.dong@nxp.com>
 <20181214020533.GC13243@dragon>
 <AM0PR04MB42114ACB1A55BB42D2C5523280A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181214031931.GD13243@dragon>
In-Reply-To: <20181214031931.GD13243@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5297;
 6:8bnsekNrE48U3RRyqVkvb3da/a+hebxmNWXti0i0QnjZdFF7xjLSg96WQPDdTQKIBqn/bbXYskswUseiHYhbyP8ySNFm6r8xquGpxKGIfiTMIZUfurMw720XSsXO4MbW/Cw06mf+FiaFSqcUFPRkrkLv3fNv6cO1zYFvTstpTYcTSyX0no4HMRrHNq/MJzzFpjAZqUZ3d0NIRTArJDLUece/V3c40CZTsuXIu8TTFcu3A7bbsVLVzo2KsHJQqFAZqfFxeL0Ou4deJgz6f34UDnjToXq3upK0nORlRYlte6ND9rq/JoJ5CVsH1MVwT0AkSunzyC8rw/UsZ4G01oNUpHzct6c+oOHp9VXBjygqf14dcABRUvSeBkF3ZAn8t2c2Y0cCpbRm/bmduHe4EeENAvn9yYmbI4H4e3GyKmpwjAgmI6AzAPV1Nwi9DL5GWPae3gO7H3+9lnwdHvpptnQQ2Q==;
 5:Jh5SmlhW0avKH07/qEIq17DvTIvh82CwFprnc1u9qU1aTtwJhcATL/938Kgu1AF3EPxw2cTzRORGvhM1Qcna6S8SZI5iYU0dkigUXqGJTdlyzER2ZneaNKs3fkgixOwLxT06y9shwl9+Pz9IB65oif/TonoWNiGqP9d9tpS3LsI=;
 7:YhkIqln30AhNojvu4uqFxlmjgqC1zOQGrt9yEkcVHIMTg6FpUHy19Z5DVd5Z6LJYAEDHzuINXYngV99FfWobaPp8aGQPw6NEMp9C+B3S75KD9jdzHXYb4B9gHeA7PWG0GxsPn4qtcDq8n70ybvAx5g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 073c8d42-6d95-419d-ca84-08d66175842e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5297; 
x-ms-traffictypediagnostic: AM0PR04MB5297:
x-microsoft-antispam-prvs: <AM0PR04MB52973D1E89FF608C5D917AF280A10@AM0PR04MB5297.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5297; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5297; 
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(366004)(346002)(396003)(39860400002)(376002)(13464003)(199004)(189003)(478600001)(71200400001)(14454004)(9686003)(71190400001)(99286004)(76176011)(7696005)(316002)(446003)(66066001)(6916009)(11346002)(55016002)(229853002)(106356001)(33656002)(54906003)(105586002)(25786009)(81166006)(8676002)(81156014)(5660300001)(6116002)(26005)(305945005)(93886005)(53936002)(8936002)(3846002)(6436002)(476003)(7736002)(4326008)(44832011)(102836004)(6506007)(6246003)(68736007)(2906002)(186003)(86362001)(97736004)(74316002)(486006)(256004)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5297;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 29rXhOojWIRl7xlOH/tFDn2q12VNhrRkpVOOyXYPSZOzd7v4i33GGNJDcvJiwrnf+RwNDKhgA8R6T8hplAERJegmhB8fIAL2xPuTx6B0D+yeKFAqLCmFIKbulJQYjANLfKs2ZavXxyMik7cd5aMLvl7iz2rpLzXn3o6u18gKpdUERiGkI18wT2nZne70R1divev4GfGaqoIV4lV1PkVNZKbid1WwjTdN8LrFX8jt9BLkIGlfgg+02NEHkZ0VWmWxfjnvsDBPNU0HTv40y7iJf+pVkkx/GDlq0U3OsLGGKkLFvLzwQg6mSndxPoKOSW9B
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 073c8d42-6d95-419d-ca84-08d66175842e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 03:37:47.5700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5297
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_193801_860982_D30336DF 
X-CRM114-Status: GOOD (  18.72  )
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
Cc: "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
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
> From: Shawn Guo [mailto:shawnguo@kernel.org]
> On Fri, Dec 14, 2018 at 02:17:04AM +0000, Aisheng Dong wrote:
> > [...]
> > > > Note: It depends on SCU driver which has already been merged by
> Shawn.
> > > > So this patch series could go through Shawn's tree as well.
> > >
> > > To be clear, I'm not going to take this via my tree, and it
> > > definitely needs to go through clk tree.  If there is a dependency
> > > on my tree, you will likely need to wait for the dependency to land on
> mainline and then retry.
> > >
> >
> > Sorry, I should have corrected that comment.
> > It's not depend on SCU driver which is already in the Stephen's tree.
> > It actually depends on the resource ID definitions[1] and the
> > centralized PM related service definitions headifle in in power domain
> > series which is already in your tree.
> >
> > [2] can be fixed by defining them in clock driver.
> > But [1] seems can't be fixed as resource ID is shared by power domain
> > and possible many other SCU client drivers.
> >
> > Any suggestion?
> 
> After [1] and [2] land on v4.21-rc1, you rebase the series on that.  The
> dependency will be gone, right?  This is what I suggested above.
> 

Okay, that may need a few more weeks.
BTW, after v4.21-rc1 is out, can the mx8qxp CLK and DTS hit the final v4.21 release?
As I understand, usually we don't receive new feature patch after the first RC,
right?

Regards
Dong Aisheng

> Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
