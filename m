Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8FAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:23:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AE26206B8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pgQMK1xR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A0dU9yhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE26206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ouKcTinRcvcapXFhB8nXCYgqHWLAk5+wopPHiAiB6aM=; b=pgQMK1xR9+3Hg/
	jnVpdaDQdQ6/4a98/P7Y+0HZomqoipHSChdM5TS2OJA0PcNODBQeRPjv9ErULY0esaOxxQHts1ji9
	g6ZSBdJyRPhYWphemH0HYMXsknMwqqJpTyeEQihZZmhpgEZqD2We2EKLOZFv/yz5+mj2bxaen6FLv
	2UWaBiYOF1lkGuMyOqk2bgrZQMJw8DJnPCKdQIevzwEyLCJ8D1UKBfqV7AhKMFJnLodcVmq/nWXvm
	OrKkDFFYbG09X7tIRHEiAfFpeSXWOwy0OsYNXcJXQ4WU12JXCZGTmLh7FEWoh2ZPWSeiV0r+/nMO8
	m6yQVW/5nAxla8iU/Nyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyapn-0004Nb-7m; Tue, 26 Feb 2019 11:23:39 +0000
Received: from mail-eopbgr140044.outbound.protection.outlook.com
 ([40.107.14.44] helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyapj-0004NF-Rb
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 11:23:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfy70dhsi4Db1wRk7j6PrHO7qo/aYpjZj293bTvnyiw=;
 b=A0dU9yhCMtf91TBOh0fMMWthl9izZ5E3p8SukIpU5/v58+yS0wFQET3mDlOgZWRe7ddmNiCWXEiBqbwVPtrJETqvtX9Ds9VRdU8/VmjV3jfhaYFfh7urL3LAmUzRrqYbJPbbAQXv7xajnrh8pHe0M0YceGJwZfMVLwd+T2RK2JU=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5921.eurprd04.prod.outlook.com (20.178.117.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 26 Feb 2019 11:23:30 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 11:23:30 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH v2] clk: imx: Refactor entire sccg pll clk
Thread-Topic: [PATCH v2] clk: imx: Refactor entire sccg pll clk
Thread-Index: AQHUytEZ0gNCfcsGj0q44zlYEICsNKXsF2qAgAEgS4CAA5A8AIABK8BQgAACEoA=
Date: Tue, 26 Feb 2019 11:23:30 +0000
Message-ID: <20190226112329.slvskbyokeqe7vik@fsr-ub1664-175>
References: <1550855235-31528-1-git-send-email-abel.vesa@nxp.com>
 <155085758346.77512.1117855723990616329@swboyd.mtv.corp.google.com>
 <20190223105813.aepvfxzbjcdjvkzy@fsr-ub1664-175>
 <155111539427.77512.17052467596124902632@swboyd.mtv.corp.google.com>
 <VI1PR04MB42229D26B9713EA6DFC484D2807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB42229D26B9713EA6DFC484D2807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9841a13e-b265-4461-d87e-08d69bdcd5ca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5921; 
x-ms-traffictypediagnostic: AM0PR04MB5921:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1; AM0PR04MB5921;
 23:1DcPAtII/6h3FgIpIG8D3DhmLNgWX/p8FTg9F8l1d?=
 =?us-ascii?Q?ABQXitC6F6TauJfRslv0ArqLYuaQ1juCParGDGcy9bpTLkilpcnw3UezPF5h?=
 =?us-ascii?Q?Sgr5dqu3uCl3JRptZK5/2Mn7Xa7Ztw5K1UT29B8tMjCDDZx4bzK3KO6zy50W?=
 =?us-ascii?Q?i7CoqiulIATs3SfoP94zj7miPEgyS75DNMqiu+JL23WOoHW241oU9MA5zA3t?=
 =?us-ascii?Q?7KZYIUwnuOJy7dPncXmIMGFeK6s+aWVuvKFAnPMHPP7GISVlbFNbiaC+UUUv?=
 =?us-ascii?Q?ULcKWLEO6CkBNUznOAJH8Yr/Bm2TQug0QhV/p5Oap+ZheE23IPX0D9RH/RtD?=
 =?us-ascii?Q?ZgiZ4vZByEQLs7wGM4r8ie9u4dWvyV+wuQ+/BQsGkxomMBlIQ9D1MAgxgoc4?=
 =?us-ascii?Q?Mq2dI5mf0A6ZQMM9wvVgqR+xjcIZ1UoAx9gVpoM34aYFyVM2CdkT+iXzaooM?=
 =?us-ascii?Q?EjBy70C1+k3icsAV4SRUtLhpHEZtKnb+Kv9puMa6bDIGlGKeWkMF6s3wEcsf?=
 =?us-ascii?Q?6MGL14TdXFP9WrAdRxTZZH3ugoFLnAdEndZT4SVHesoVmJT+4y6QvnQFzN9D?=
 =?us-ascii?Q?4SVm1DdPvkYrnm2Q9A3uoKqZqqV2NgAjMyvs0fyCP16zZTHJhonm7mSfvF4q?=
 =?us-ascii?Q?HtkcuICorEtHTVP4Z6pqLsUqcrBlJQ2aN0mxOUxK2v6bxfquELo/XHDY519x?=
 =?us-ascii?Q?+xXeC6+SP8h2kziv6HLQKw2SSdX8kX1yiHH3yIB3wC9sDbctWI8Iy/62mXZ6?=
 =?us-ascii?Q?/ZPyALV5E5NY8kPvbor/A0v5MfLtcxIIZGrkjmqXoMylWQhJI4k4IAcDr6dX?=
 =?us-ascii?Q?lH4yI6+0ucuznuzpg5mSohF8brytyvop4auo7AixQH4rwqU3pEAoqrLrNROK?=
 =?us-ascii?Q?o8I8dNciLIreW0cElPgpf/c6vzTCfo5olj3xn6ZBTQoE4HQST8xWrLcOiFx3?=
 =?us-ascii?Q?RD4+Lqut9+jF2mp8X+zTKkc4OfCxryKeUO140wozo8ix6ENVQk5rBALFfe86?=
 =?us-ascii?Q?w8ItVd5zLu0s8qsfNUA8FzFz5vXWQaGvk+G/rNf7bDDyl6nnfzhWVBXVCJlG?=
 =?us-ascii?Q?CimxHOQ6zuzzkl2AEXYsjGPWyO89ys7xBQrQh9UySvMxTJDcYIgZf1ceXJiZ?=
 =?us-ascii?Q?IeVlYDIrZpvyX9jxi/pj2xpxbRcy8uPQbIto4KNgBzDNdgJ5uPGQoeJOzGI0?=
 =?us-ascii?Q?QTKBrQ7YIJ7nfC+RebkOC5nKWk7I7JwaciXVKb1IGzjRnoxzyCEbVcJS+itQ?=
 =?us-ascii?Q?7uX0Bqc1AzjWxXASEOcXryDW8y+X7ZQCsvmvfRQSB+TY5bK0hZuxwSqjOhPY?=
 =?us-ascii?Q?6HNdplBV/ya7fkSeXGuEbs=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB5921EF6289AB2D8E2FB5E285F67B0@AM0PR04MB5921.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(7916004)(366004)(136003)(39860400002)(346002)(376002)(396003)(51914003)(189003)(199004)(478600001)(6246003)(105586002)(102836004)(106356001)(14454004)(6862004)(25786009)(6636002)(4326008)(1076003)(6486002)(5660300002)(486006)(229853002)(6116002)(86362001)(476003)(8936002)(3846002)(68736007)(8676002)(186003)(256004)(81166006)(81156014)(316002)(26005)(9686003)(6512007)(44832011)(2906002)(54906003)(93886005)(53936002)(446003)(11346002)(76176011)(99286004)(7736002)(66066001)(33716001)(53546011)(6506007)(71200400001)(97736004)(71190400001)(305945005)(6436002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5921;
 H:AM0PR04MB5779.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /3QhjIdbV7geGGlwk5l8gLsCCLc7m0CMgOZK4+wkZbDgMN8xuNoYk8V8FWRh6u4ZumgVNhQPMyfbe4nHT+DEdJaBash5cCsgMWC/5+Wb46CikPls5OUrmRXqMLQkpLEsmdPU7lJWpUtv7E5cDesYQOo2NaGsW6R7njfeJgg+p9M8p+pGh31K+d0U8mzLmdqw910IkQ5BelZ1930p4qC5vm3xUeCzBjdnAotJ/2BVe12xVhBu+i3vqgdaHbbvJdLs/3+ZlsGo/Hc2so70DH5VJD1YThV4Jh+WV9IS3TKdOOTivCKTrEmovNCFOCXjASyum1llRPQqZS/pKdYTtMjv2AxsCgyxvn7K0Lacr6BfldkTYnW3/OjLVtxD17k0p/FgJZJvPsea8U01hE045F9s8vKMhxzBvgtrk7lu+w9jfZs=
Content-ID: <3596634E283FE947B25116BA0740607E@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9841a13e-b265-4461-d87e-08d69bdcd5ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 11:23:30.0534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5921
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_032335_897376_7D8DB07F 
X-CRM114-Status: GOOD (  17.37  )
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
Cc: Jacky Bai <ping.bai@nxp.com>, Anson Huang <anson.huang@nxp.com>,
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 19-02-26 11:18:08, Aisheng Dong wrote:
> > From: Stephen Boyd [mailto:sboyd@kernel.org]
> > Sent: Tuesday, February 26, 2019 1:23 AM> 
> > Quoting Abel Vesa (2019-02-23 02:58:14)
> > > On 19-02-22 09:46:23, Stephen Boyd wrote:
> > > > Quoting Abel Vesa (2019-02-22 09:07:32)
> > > > > Make the entire combination of plls to be one single clock. The
> > > > > parents used for bypasses are specified each as an index in the parents
> > list.
> > > > > The determine_rate does a lookup throughout all the possible
> > > > > combinations for all the divs and returns the best possible
> > > > > 'setup' which in turn is used by set_rate later to set up all the divs and
> > bypasses.
> > > > >
> > > > > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> 
> This significantly simply the clock tree output.
> Thanks for the work.
> 
> > > > > Tested-by: Lucas Stach <l.stach@pengutronix.de>
> > > > > Acked-by: Lucas Stach <l.stach@pengutronix.de>
> > > >
> > > > I suspect these tested by and acked tags should have been dropped,
> > > > unless you discussed and tested off-list?
> > > >
> > >
> > > Oups, I forgot to drop them.
> > 
> > Ok. Can Lucas re-test?
> 
> Tested on clk-next by cherry-pick a few defconfig patches from imx tree.
> So:
> Tested-by: Dong Aisheng <aisheng.dong@nxp.com>
> 

Thanks for helping with the testing.

I don't think there should be any defconfig changes required by this patch.

Can you please list here the CONFIGs added?

Just wanna make sure I'm not missing anything.

> Regards
> Dong Aisheng
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
