Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EEBC31680
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:00:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF532089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G7UcjnJm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kf8W/414"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF532089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3GWdt/9lXw1OC+hSbrSfiOfDkrvvmKi7kS0Vfj5rC/M=; b=G7UcjnJm+qYvso
	g3/a0W9KpLHSm2uY06HyVq2v0VZISEfwjx+C1JZDt2bzoLLMBV1hdizhafUpjpKQW6cC1vN/QloAH
	zVi8c65bToRipksSvp5cn+Q1HdF7xJF1N5RZQOaJ3anuj1nxgXR2FXZvfFASA6JqUM8Abp055p6H0
	FSj+OG/EvKAbB+nI433ZmzNkRRqR7RM3vFjbKhT9sbU2T/QHJ19eKZdN3YkvSofC3o4snvn3IWqEv
	ux1V3jaYC8pJjc3TvHRqYwJ3/8PoreI9hRPStyVAVILW80ghTzSoGaSg5iqjG+4P3WPDJ9zt1RCVK
	444HB08PGTcOW6Gf6oIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gldro-00009q-IB; Mon, 21 Jan 2019 18:00:12 +0000
Received: from mail-eopbgr40081.outbound.protection.outlook.com ([40.107.4.81]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gldrQ-0007Xp-3C
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 17:59:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1au4FddCsDO5YbgpIERjOPLLEvhKUK9XUVYFHG3Lgo=;
 b=Kf8W/414OT3RUz559zJXe6bgqpqAS8EYkUi6KwinN7yl8Cj4jZMRu0IbBLUahniNAoG+GMBE4SASZUSm3TyEOCGGuw6D+figLmZT8KTRCxH0cuXX9G76DCa6xARXW39GVHldfLWPQQDljMd69HPfl6RnHH9sBYPLBiQCLRfu5g8=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3631.eurprd04.prod.outlook.com (52.134.7.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Mon, 21 Jan 2019 17:59:44 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::2d83:eb90:f977:f649]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::2d83:eb90:f977:f649%3]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 17:59:44 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "festevam@gmail.com"
 <festevam@gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mq: properly describe IRQ hierarchy
Thread-Topic: [PATCH 1/2] arm64: dts: imx8mq: properly describe IRQ hierarchy
Thread-Index: AQHUrMIi2VbXtQ07rUO3i1BCpJShUKW56MJMgAADCoCAABdlgIAAASkAgAAAdICAAAfXgA==
Date: Mon, 21 Jan 2019 17:59:42 +0000
Message-ID: <601e00d6dd1300737551c2ad82cbec8ab79c67f0.camel@nxp.com>
References: <20190115110446.19077-1-l.stach@pengutronix.de>
 <VI1PR0402MB3357FAB48888D99A809F41AEF99F0@VI1PR0402MB3357.eurprd04.prod.outlook.com>
 <AM6PR04MB51581FBD4D21FEFDCAC2B27FE39F0@AM6PR04MB5158.eurprd04.prod.outlook.com>
 <7f92c150219832eb9fb54e72021116ad78ae71c3.camel@nxp.com>
 <CAOMZO5BFZVUT8x8o57TkYfwfT9OF1a=g5pNo48bW1qwfYXUrRg@mail.gmail.com>
 <1548091897.2465.10.camel@pengutronix.de>
In-Reply-To: <1548091897.2465.10.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0402MB3631;
 6:4CCUHIH6Yu6pQSEChP4gdsRdO/paangGDeN+4npclhgW+CWvNKXu9UyWs7JpuJJ5XjWK/5bt4GD3enLa4N0x4jaq6hnBqjra+Rb17ykF3qX+WYFEsRTVKd/o9CH07ayHf4sVxwC1ADF4nXU/NnttYAdSkc2XFk4NlGDQKS049Qvk5AfiJZQmqj9BAHefuZnwJGfY/2OX5IdfdifjffWLzUZj+zdpT00Hq2XiIM1AAMj0waXuWkDG/VHFuMl90fT5xPdbNqw4pxDoFRBB6zgdb32KZz8P/VbJkMctWRmfz6C8YYWQrnyiartAnhaoEtxk3WFWcA6pmq+HIDAMJt8d+mBmP12TtavpvVahUHzXXijCXEAx032ymiB3aGQHvT8/s6DrZ+FFy4JsSuGqpeWelxoNdONDo5pM/9PF3r2fgSvaXr5gtAiFb5N2ImjC14XcT8fjxk6UyW5T2tXQ8mGgsQ==;
 5:bcGXPMX5cx47FZVJz7msbZlQz9qLkJepAz+twWdf0xNqILrHxT/2RU9vIYkvl4QIKzPMX17lP7Pj1ovAMZtkteo4sgNG0uA42OVh1dTO1Gqe73rf+RgwWnzUklOMp+Wt9DGO30Z3l7q67f3yHEw3MbVHwkDjZbPnqJZln4AwKKqVzezOAm0MCo3wyMRhwQ+Lb9yGcLLbxjX4NPWZ1mvVGg==;
 7:+ew0j6oi9XoGjxu3M55GqcgLQqIxqT+phn/IvHuw1Y+eznRYKy6A5Ih7oojDzGhe0T6MnS+Mb+9funXDXenUSluAjU+v+pR+zKRGAf6Ri6bpFShqJrEkanf1t4Hfosy/e8DdByqWthvlv2Kos5To9g==
x-ms-office365-filtering-correlation-id: 7040b950-ce5a-4cc0-a60d-08d67fca394c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3631; 
x-ms-traffictypediagnostic: VI1PR0402MB3631:
x-microsoft-antispam-prvs: <VI1PR0402MB36316B1E2D002A9FC47133E4F99F0@VI1PR0402MB3631.eurprd04.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(346002)(376002)(396003)(366004)(39860400002)(189003)(199004)(71200400001)(66066001)(7736002)(68736007)(71190400001)(45080400002)(305945005)(102836004)(8676002)(446003)(53546011)(6506007)(76176011)(26005)(186003)(2501003)(6306002)(3846002)(6116002)(478600001)(966005)(14454004)(93886005)(6512007)(256004)(53936002)(6246003)(229853002)(36756003)(118296001)(4326008)(106356001)(486006)(97736004)(99286004)(54906003)(105586002)(8936002)(316002)(476003)(2616005)(11346002)(81156014)(81166006)(2906002)(86362001)(6486002)(110136005)(6436002)(25786009)(44832011)(39060400002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3631;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XiYepQ/k4DJkGE8xMROdSnwG+qr5bV3fEVlFtNx7lwBDbJ3vjnQ0fa05Iprf+L7mCyyb9PaRRxH7g8/tzb4EZAq+gKM2Nyv5QPuKqu5v4xrtcbLEdiHmEgLoG1x3fTTXzwI32eNkekj/FkstWyg/YmDc5u001o6IoO7RqDa55yMK7jUJzTo/dClOAK+LUTU1BelbolTWl+amvPtq1oH1xxmTyb6BEAGDMcu90PguFqr9jpP8rtBXsyDkP8KIwroRB5zDNjeSEOTsyGoRKBt9Z8+beMzhc/l5p8AdznUQc5+8+kozqrPUDpoaBLlWfYgBBdrG1+9wxKCVyDxY+Da0YEiE2oRuXhxO2Qc4wR8z/8a+KcWoJ180HZ75DZwTBgljtoZJj7FufsnY+oXCWbpyMIHmwwqL/rLWfD9s2ENMK7Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <7AD7F17D5C06A94DAA54F8A77869B018@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7040b950-ce5a-4cc0-a60d-08d67fca394c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 17:59:42.0480 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3631
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_095948_137124_A54BA10D 
X-CRM114-Status: GOOD (  19.22  )
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

On Mon, 2019-01-21 at 18:31 +0100, Lucas Stach wrote:
> Am Montag, den 21.01.2019, 15:30 -0200 schrieb Fabio Estevam:
> > Hi Daniel,
> > 
> > > On Mon, Jan 21, 2019 at 3:25 PM Daniel Baluta <
> > > daniel.baluta@nxp.com> wrote:
> > > Hi Fabio,
> > > 
> > > Your patch helps.
> > 
> > Thanks for testing. I will send it as a formal patch.
> 
> If you look closely that's exactly the patch 2/2 from this series.
> 
> Regards,
> Lucas
> 
> > 
> > > Now the console works. Anyhow, it seems that now there
> > > is a problem with the network card.
> > > 
> > > [    0.831454] mdio_bus 30be0000.ethernet-1:00: error -2 loading
> > > PHY driver module for ID 0x004dd074
> > > [    0.840796] fec 30be0000.ethernet: Dropping the link to
> > > regulator.0
> > > [    0.847212] fec: probe of 30be0000.ethernet failed with error
> > > -2
> > > 
> > > Booting fails now because kernel isn't able to mount to nfs
> > > rootfs.
> > > 
> > > [  111.652134] VFS: Unable to mount root fs via NFS, trying
> > > floppy.
> > > [  111.658510] VFS: Cannot open root device "nfs" or unknown-
> > > block(2,0): error -6
> > > 
> > > This problem is similar with the one met on i.MX 8QXP.
> > 
> > Does this patch help?
> > 
https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Fnetdev%2Fmsg545573.html&amp;data=02%7C01%7Cdaniel.baluta%40nxp.com%7Cb3055410508f4333003b08d67fc64cc8%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636836887005112836&amp;sdata=7qSMs76%2B%2Fjdgeu0VWvrj36gTx%2B1tXPLwN8ZoYYmAeLE%3D&amp;reserved=0

Yes, with this patch and 2/2 i.mx8m boots fine.

So, Mani I think this should also fix the problem on i.MX8 QXP.

Can you give it a try?

To sum up you need these two patches:

1) https://www.spinics.net/lists/netdev/msg545573.html

2) https://patchwork.codeaurora.org/patch/700169/

thanks,
Daniel.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
