Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAE0C31680
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:03:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B9C42089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jg4zeAPd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nxuTdgkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9C42089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mlQVuF2R8C+PNouVbeMO28QL4AJZXJ59e9t3XR3j5IE=; b=Jg4zeAPdnfZgoo
	8zKYBmMA0uGe3zZ2bFIp4dKbjgVUXFrmrZbzY6BVK8JW9BeTfo9OzWf9stwQozxIXx8mKvQ4hocpM
	8myrLVqdbLIX/HV+OgEWpEm+L5Udgb79k85AALeosInOGp3dsa324//MurNgB9BQx5g/Iw2ZgPOAQ
	m7kJnbrooWOO+NLeOC7faB7A6Nx53GNiJzp0xwroeHAzmOGg3aa3WxkxeJyFLtDn3zJuAIQQzEHvw
	b0RHN75pkA4NRzV9mgQDTLOaKQRvlWVVbe5MbiiokU7gYmx67On/m261rOnQtW1KEvE8ZMxa18CgL
	K73d6g1Px+5Edtl8QMkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gldv7-00014S-Fh; Mon, 21 Jan 2019 18:03:37 +0000
Received: from mail-eopbgr50052.outbound.protection.outlook.com ([40.107.5.52]
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gldv4-000141-NT
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 18:03:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJYV/D+xHKX6/YHFjO/r/Em81skVMJyqK9pkZ9rFNQI=;
 b=nxuTdgkt+IscFVS+kSSYewmNJpEUBrP1GeczxEu5FuFKiWa5C1ID87Jxn/+7T43bhHzJ4y/ooZdSe7A8yb8bfRmNdyPCG4CqysQtxm4FCqus0eCInPxiUdKxToDxyrrfIQJcpvBS3RsgWbZxwPppjLHPUt9XP4D1241MkfMqYac=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2799.eurprd04.prod.outlook.com (10.172.255.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Mon, 21 Jan 2019 18:03:29 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::2d83:eb90:f977:f649]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::2d83:eb90:f977:f649%3]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 18:03:29 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "festevam@gmail.com"
 <festevam@gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mq: properly describe IRQ hierarchy
Thread-Topic: [PATCH 1/2] arm64: dts: imx8mq: properly describe IRQ hierarchy
Thread-Index: AQHUrMIi2VbXtQ07rUO3i1BCpJShUKW56MJMgAADCoCAABdlgIAAASkAgAAAdICAAAfXgIAAARCA
Date: Mon, 21 Jan 2019 18:03:29 +0000
Message-ID: <1d1bb801a03aebc53f23346f0087e6ee30ee8b1e.camel@nxp.com>
References: <20190115110446.19077-1-l.stach@pengutronix.de>
 <VI1PR0402MB3357FAB48888D99A809F41AEF99F0@VI1PR0402MB3357.eurprd04.prod.outlook.com>
 <AM6PR04MB51581FBD4D21FEFDCAC2B27FE39F0@AM6PR04MB5158.eurprd04.prod.outlook.com>
 <7f92c150219832eb9fb54e72021116ad78ae71c3.camel@nxp.com>
 <CAOMZO5BFZVUT8x8o57TkYfwfT9OF1a=g5pNo48bW1qwfYXUrRg@mail.gmail.com>
 <1548091897.2465.10.camel@pengutronix.de>
 <601e00d6dd1300737551c2ad82cbec8ab79c67f0.camel@nxp.com>
In-Reply-To: <601e00d6dd1300737551c2ad82cbec8ab79c67f0.camel@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0402MB2799;
 6:8R6Lrcw1YsGbJkr2ZhSa8kylmyiKJG+KpRhJYtGrQp69iOCZn3MMVjU52CgnSxChwEkbQ2M/iC90KLCho43Ql/uRHpceruFdWBXs12m1i8782vMcrby5aQRHW53m7EkzU+hTTOBrwhgYMSl84NL+ripFR/9PJOB97CcLklvXLxs1jMi9M1R3VO2j1se66Vmmbr4UATHPw2FfZ5C2UlrHx+S/o7vY+hym8eF3lfLkiB01dbZncPrRl4YHcaXwF8Seijh94PCQmmUg/uHMb4waXTHo71+oWZM8HWp/UoFocENhlz+DWOHudTv2Tw4a649fJbrjyVk7/hJnl2RoXPXiP4K0MGGcG571DdVbTtjvHU/J4SWSjYFuzs4ZEcYbQOE+VIzQYXiPkeHFif9AGxWFCH9X6gIUlAg8nrzpIh+UNU0QRmhXULximP0O+74m/DHkFrtKEmDy2tQeD7Ba58UZ/g==;
 5:8NMGGBso5N8Il2tTgy7dc+4foB9ONHN3YQLRgHmM0ViUWExzdP0TjxVzb+cvXdK4B+L++KlqXTOhk97vE7IeWhdYlkvc4j5oVq6uI+rzLIVEtURVBHyn1pch9X3mnLv8/KVuczxTvIvUYsEQj1PODnhShmBpMgRGeNmk5/Jb0i7RHM6zShgb1t9T8rn6BbCPxWurwZwbMmVNItr8Vr8rDw==;
 7:JYqarJCybYLfMTscnYyPiRkdTH6SUjjMVFmG48dmRXl492S0lMniR3qIfrKWwbRVj596cmbfJPKpxdyD8q5kio1Lrh/XzxrdLZZpa6cUWLpD9NyhqDIDxsukl9Ig3kJGh+DhhZWh/gqrd+HrG+oLSw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cba66edb-c7e4-48fa-cb99-08d67fcabfd9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB2799; 
x-ms-traffictypediagnostic: VI1PR0402MB2799:
x-microsoft-antispam-prvs: <VI1PR0402MB2799878DDCC60343C95E3E37F99F0@VI1PR0402MB2799.eurprd04.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(366004)(346002)(396003)(136003)(376002)(199004)(189003)(40764003)(305945005)(6506007)(102836004)(7736002)(53546011)(68736007)(76176011)(3846002)(6116002)(97736004)(71190400001)(71200400001)(36756003)(45080400002)(54906003)(110136005)(316002)(99286004)(256004)(26005)(14454004)(966005)(478600001)(8676002)(6246003)(81156014)(81166006)(186003)(8936002)(106356001)(93886005)(66066001)(105586002)(53936002)(39060400002)(86362001)(6512007)(2501003)(118296001)(4326008)(25786009)(476003)(44832011)(6306002)(2616005)(11346002)(2906002)(6486002)(6436002)(446003)(486006)(229853002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB2799;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kXiTae9WzdJgSSep8rdrRALPHwRouBCjRNaWJ1l9X+Pb788+Y51eC6MhhtkK0ACCPxHC/d0A8cKJcBu3d8Fa/IdCu4pK/zsdBZEyMmKTttICzrBAjLi0TEBFOjX8BylKEHxpHq09oFtOcnE7CAA7qFYJ9ZjEw8SLIRQVYdzwffbl2+4s3iyWmSkIgrjosQJ23kY0JOsCP9nDG0zvRKbOVfLppw7aOu6j3DKwV54YrnIDVkvug/EAX8GAC/g0ZAHGzYEvqOO2FkwfO/CCvwBci7UGWLU+602anLVeHXO2bWTZBR/ggGrrjEOdX2RDXtfiTiQvlYQzMHpL2/UyEVilRCn76ztZP+MN37mi1XzB6m6FULs/R9+0qbp14RXkWAeMhK5fNpUDBss/RaL1QVQK/oO4LOlBlyoRU0n1+mgdqm0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <6F9AAA74703AFD42B0414FB6F81FB22D@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba66edb-c7e4-48fa-cb99-08d67fcabfd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 18:03:29.7565 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2799
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_100334_767314_C2CC3C1A 
X-CRM114-Status: GOOD (  22.01  )
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
Cc: "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 2019-01-21 at 19:59 +0200, Daniel Baluta wrote:
> On Mon, 2019-01-21 at 18:31 +0100, Lucas Stach wrote:
> > Am Montag, den 21.01.2019, 15:30 -0200 schrieb Fabio Estevam:
> > > Hi Daniel,
> > > 
> > > > On Mon, Jan 21, 2019 at 3:25 PM Daniel Baluta <
> > > > daniel.baluta@nxp.com> wrote:
> > > > Hi Fabio,
> > > > 
> > > > Your patch helps.
> > > 
> > > Thanks for testing. I will send it as a formal patch.
> > 
> > If you look closely that's exactly the patch 2/2 from this series.
> > 
> > Regards,
> > Lucas
> > 
> > > 
> > > > Now the console works. Anyhow, it seems that now there
> > > > is a problem with the network card.
> > > > 
> > > > [    0.831454] mdio_bus 30be0000.ethernet-1:00: error -2
> > > > loading
> > > > PHY driver module for ID 0x004dd074
> > > > [    0.840796] fec 30be0000.ethernet: Dropping the link to
> > > > regulator.0
> > > > [    0.847212] fec: probe of 30be0000.ethernet failed with
> > > > error
> > > > -2
> > > > 
> > > > Booting fails now because kernel isn't able to mount to nfs
> > > > rootfs.
> > > > 
> > > > [  111.652134] VFS: Unable to mount root fs via NFS, trying
> > > > floppy.
> > > > [  111.658510] VFS: Cannot open root device "nfs" or unknown-
> > > > block(2,0): error -6
> > > > 
> > > > This problem is similar with the one met on i.MX 8QXP.
> > > 
> > > Does this patch help?
> > > 
> 
> 
https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Fnetdev%2Fmsg545573.html&amp;data=02%7C01%7Cdaniel.baluta%40nxp.com%7Cb3055410508f4333003b08d67fc64cc8%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636836887005112836&amp;sdata=7qSMs76%2B%2Fjdgeu0VWvrj36gTx%2B1tXPLwN8ZoYYmAeLE%3D&amp;reserved=0
> 
> Yes, with this patch and 2/2 i.mx8m boots fine.
> 
> So, Mani I think this should also fix the problem on i.MX8 QXP.
> 
> Can you give it a try?
> 
> To sum up you need these two patches:
> 
> 1) https://www.spinics.net/lists/netdev/msg545573.html
> 
> 2) https://patchwork.codeaurora.org/patch/700169/
> 

Also, Fabio super thanks for your help! You saved us some 
long debugging hours! :)




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
