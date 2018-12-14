Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43244C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:45:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1207620811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gyi4qFzF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="APs96XGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1207620811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oAw1iHMuBNd/+hJBA9BIZgJwBO12fyv9Z/Y0BQgJqVI=; b=gyi4qFzF1Ibll+
	s2ghjFYNutSKis+/wRF9yALU2ooHhfW3qOMqjo6LiEKXvIPcqLKUKQYxYqi3K3SEXfvgjMGzMlI1J
	BcRrLcpOAhYkb0mTFNbX/Vs+3t6GHbgCljR4roATwfzyDNl6IEzXDMs5LHrn2sO/CH/GkyY7loADu
	cvNg4MszRh1ReObdBug+LyJJSr+da3EKSw163in0P7pk45kAqWy7fXJ5X7COiR2pY1iNfgGVQCgHI
	OqKqhzvhmaB67xkODrplgGMP++9UTmViZNU5QvUKm2sOQZCcWoha5bb25qDDrKyt5tnAA+0VE3nK6
	eqSsfdok3NEv3aWH5phg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXcXT-00042u-Sl; Fri, 14 Dec 2018 01:45:15 +0000
Received: from mail-eopbgr130084.outbound.protection.outlook.com
 ([40.107.13.84] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXcXP-0002kD-NO
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 01:45:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zibGWd5kwlCfkowVEFOkO2bjp3jwJS+6B7wyvyXibzI=;
 b=APs96XGUUcyiE5zcsBJTPH/68yso6TOObVbcYJR6LJJxQ+QHnbU/uJ6kcWCfTT/S4eqs4oYnUE+QdsrwW6W1UBfEJ/5VpnerS6Q0HuowSnJ44sFJ3y7RQTqvmU6Z2jPGif9wYYY+/N/Ln1QrxigJyayRnPlguXWH1SWxE655Avs=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4609.eurprd04.prod.outlook.com (52.135.149.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.24; Fri, 14 Dec 2018 01:44:55 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Fri, 14 Dec 2018
 01:44:55 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V11 2/7] clk: imx: add scu clock common part
Thread-Topic: [PATCH V11 2/7] clk: imx: add scu clock common part
Thread-Index: AQHUkoBHoRLNmKbTG0W2ArFlHoWixqV8S10AgAA08PCAAPPtgIAAAqXg
Date: Fri, 14 Dec 2018 01:44:55 +0000
Message-ID: <AM0PR04MB4211D584BCE4B6D06D57637280A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1544662938-5020-1-git-send-email-aisheng.dong@nxp.com>
 <1544662938-5020-3-git-send-email-aisheng.dong@nxp.com>
 <154468728640.19322.12955855783518519739@swboyd.mtv.corp.google.com>
 <AM0PR04MB42118C3E7F49A0437453BA5880A00@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <154475103791.19322.8783777114832958727@swboyd.mtv.corp.google.com>
In-Reply-To: <154475103791.19322.8783777114832958727@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [101.93.238.110]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4609;
 6:ieE8DQ4XKiwO/ACiDuMAqBa/62t8rdQPuPW7wBJ413SSAg6Wgnv2CWuPBtskCs0BfCx99Tyu8WuWZbeXj8XQ2pLpAZMwU2WRDNZSbLS/utyxq6L4EuyH750rkWw4xTngEMW2rfa0jKDfl4lQE1cmZdmXOCiyBOZFW7VZcS31yABThavqJDrDMt5ThGIEev4gMF5OVmLJcFuqNb9S781VdVp6NGHhhHKP8dRQ7nkFuUpnjbs0nhyxkGRSBTXHWFKLNaIr51BuAmkKDHNmUJzQz5LdkwDpZ1z/oKb7wNyTkE2y0Hlo2PWTyQZqZnbKjuzrTUhSsEcBo0dTUBSa1ka9tRbtiHU0Utyx1KR7/gJIwE3e3IPqpgAU4BsBecs2jkDE4Gggr1VLu7WnDVI7CO9572xlYZqtgRITot/MF0nnk7YZnLqOOhj2op/UlMOcwFm9QmYezSdq8NpHIpBXhT4NIQ==;
 5:AK2wNwrL3QGvm0S5eQG9oOL1s0uQ6yNKH24B2N2vxY+jKpHqUPbdzgjobjxYbtIrdAtq/yWP5yEh972PlYzFSk2EkbSTDsdy3A6syjhIeud0q78nszzod0SCWFpnH5THqRWj2+xfiHIsMgxkt8IBQVwBBkhn6HvnfeqtS6CNphY=;
 7:Z/TDGaW1NrYaLTuI33vyBa8l+CBt9xIm90N2pjCzP8dFMaeQ/tf+evsjUvIxj3xyonjmcLL3F2//j707bjQ4UXTyPfiRxyQ/bmuytRIFkxXBVz5YpXT7RK+WigdBuj9ozMogxyLfzi30pztG3AaQ7A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6bde759c-5902-4041-5645-08d66165bfda
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4609; 
x-ms-traffictypediagnostic: AM0PR04MB4609:
x-microsoft-antispam-prvs: <AM0PR04MB46098A887B999ABE181315F280A10@AM0PR04MB4609.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231475)(944501520)(52105112)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4609; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4609; 
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(39860400002)(366004)(396003)(136003)(13464003)(189003)(199004)(11346002)(71200400001)(25786009)(53936002)(256004)(45080400002)(3846002)(4326008)(6246003)(9686003)(99286004)(33656002)(68736007)(6116002)(478600001)(53546011)(966005)(486006)(446003)(8936002)(97736004)(106356001)(6506007)(105586002)(86362001)(26005)(102836004)(305945005)(476003)(6306002)(54906003)(2501003)(4001150100001)(186003)(5660300001)(8676002)(7696005)(76176011)(55016002)(93886005)(44832011)(81166006)(81156014)(74316002)(110136005)(229853002)(316002)(2906002)(66066001)(14454004)(6436002)(7736002)(71190400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4609;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8L4MOoB5lK5M7z5gprcZvV/JpcNT2Hh4qoUqNLuBlbn+ldzy8ylT38X3eib+xhi4JdEFfs49V3+mWqrezFKGZmYgKRHK33ZJc5pRF1RrLEfpiQHpi+skKnstePYImgIW/BYgRkCuV3d0eTsrHPsco0Qdc0yzGolL9vd/uzfJ0EYuct7tohCX43/qWC65vdqYQXaW1EZDBGAc8UMrjDtgu3t4bEGEdlj91rwjseIsThsbodW3EkEiJJBzR6ubljFzbT1qZt1pz0y63TflUT//PdCbJwqN1u2DUpqa5TTvldyeOGuj/1WvqmXN8VjOjpgc
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bde759c-5902-4041-5645-08d66165bfda
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 01:44:55.7341 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4609
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_174512_144961_B2F4E8D6 
X-CRM114-Status: GOOD (  23.39  )
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
> Sent: Friday, December 14, 2018 9:31 AM
> To: linux-clk@vger.kernel.org; Aisheng Dong <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; mturquette@baylibre.com;
> shawnguo@kernel.org; Fabio Estevam <fabio.estevam@nxp.com>; dl-linux-imx
> <linux-imx@nxp.com>; kernel@pengutronix.de
> Subject: RE: [PATCH V11 2/7] clk: imx: add scu clock common part
> 
> Quoting Aisheng Dong (2018-12-13 03:19:26)
> > > -----Original Message-----
> > > From: Stephen Boyd [mailto:sboyd@kernel.org] Quoting Aisheng Dong
> > > (2018-12-12 17:07:55)
> > > > diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
> > > > index 37478ba..5c26f4e 100644
> > > > --- a/drivers/clk/imx/Kconfig
> > > > +++ b/drivers/clk/imx/Kconfig
> > > > @@ -3,3 +3,9 @@
> > > >  config MXC_CLK
> > > >         bool
> > > >         def_bool (ARCH_MXC && !ARM64) || (ARCH_MXC && ARM64
> &&
> > > > SOC_IMX8MQ)
> > > > +
> > > > +config MXC_CLK_SCU
> > > > +       bool "IMX SCU Clock"
> > > > +       depends on ARCH_MXC && ARM64
> > >
> > > This should depend on the IMX_SCU config too, right? Otherwise
> > > compilation will fail.
> > >
> >
> > Yes, you're right. I will add it.
> >
> > > Plus, I can't seem to compile this driver regardless, because the
> > > defines for the CLK messages are in some header file that is just
> > > included in another header file, and that is all going through another tree.
> Why?
> > >
> > > Is there any reason why those defines can't just be written in the
> > > clk-scu.h file introduced in this patch?
> >
> > Sorry about that.
> > Yes, it depends on PM service headfile [1] which defines all the power
> > related service together by SCU protocol, including power domain/clk/reset
> and etc.
> > (we probably should divide them to get a better separation from the start).
> > But Patch 4 depends on the resource ID headfile shared by most SCU client
> users.
> >
> > [1]
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpat
> >
> chwork.kernel.org%2Fpatch%2F10664137%2F&amp;data=02%7C01%7Caishe
> ng.don
> >
> g%40nxp.com%7Cea09bbc7dfbf424844bb08d66163c240%7C686ea1d3bc2b4
> c6fa92cd
> >
> 99c5c301635%7C0%7C0%7C636803478422100123&amp;sdata=GwOYjZns%2
> BJxLePnT5
> > 6ZTzRuME3DQA5V8eukvRXCf1s0%3D&amp;reserved=0
> > [2]
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpat
> >
> chwork.kernel.org%2Fpatch%2F10664125%2F&amp;data=02%7C01%7Caishe
> ng.don
> >
> g%40nxp.com%7Cea09bbc7dfbf424844bb08d66163c240%7C686ea1d3bc2b4
> c6fa92cd
> >
> 99c5c301635%7C0%7C0%7C636803478422100123&amp;sdata=CJGAlaF4K3
> uK3bYlEbC
> > sSRQssa25%2F%2BiPaI5y4x7grRc%3D&amp;reserved=0
> >
> > How would you suggest for this situation?
> >
> 
> I suggest the defines just go into the clk driver. Is that a workable solution or
> does something not work?

Are you suggesting me to doing it now?
As the patch is already in Shawn's tree, but I think I can do it and clean up
the file in Shawn's tree later.

However, only moving the clk related defines into clk driver is not enough.
The driver compiling still depends on the resource ID file which is shared
by power domain driver and clk driver (and possible many others).
So we still have dependency issues.

Any suggestion?

Regards
Dong Aisheng

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
