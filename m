Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C32C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:21:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4A11218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="roY++j9G";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tFpt1ezV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A11218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p6mjjsKy4kTI4vBcwfT0IGKuVLg2kPUqCwauNZhiz+k=; b=roY++j9G3seUKh
	mjZofO8xYO0xuiL1UsFkwB2ePKmmMDGcQhPm5FZx28NvLenf12cKKaqpt+s7sfkJagH+bhR8mNDVF
	Vb+3rtxvenIW74uhMjAHgn3gf60HUkgEZQdsRDU0aw3jyAUVUch/D5y4RLUYpREZ7wBxG+Xi+N5Fm
	+WEBZtaN06w2O/Mz2fk4IMj8EQV8gGVPsDPDfvoIURq5FSmVUXVzzR/vzipzHpGrELXcZOVbtfQrp
	/mi+2otW6lRMM5MJLPzP4WJtfKxc9s5zzg0gjxZYNuF/pdkmH8/0Uwp1yyH0M01LWi3+0xZ54jsVY
	PNawxaBb1eZit9sgL9Ag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmxfc-000688-4k; Fri, 25 Jan 2019 09:21:04 +0000
Received: from mail-ve1eur03on0628.outbound.protection.outlook.com
 ([2a01:111:f400:fe09::628]
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmxfY-000672-E2
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 09:21:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSRUNT7Ivg3W90ba7zSOszblEVZqAMeLysv0A+U+S1o=;
 b=tFpt1ezVRH/+3tZzliQdrC8rlZKfIZP6NarGDRxtdwJzWKIj/YOV9bnGhnNwY2Kx5oD+Yv1JzaZIQlqWFyHvLbJ7rIOEw+3Byu/Ekr0CuUyQgDgomKlUxqy0VwDyH2lMggKANMeiksZyrMXT0absAo4LVOZ0wmHe1nEUIYFF2gE=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
 VI1PR04MB5917.eurprd04.prod.outlook.com (20.178.205.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Fri, 25 Jan 2019 09:20:51 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::9c6e:406c:e2bd:c293]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::9c6e:406c:e2bd:c293%5]) with mapi id 15.20.1558.021; Fri, 25 Jan 2019
 09:20:51 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Wolfram Sang <wsa@the-dreams.de>
Subject: RE: [PATCH v2 1/2] i2c: imx: fix dma_request_chan error handling
Thread-Topic: [PATCH v2 1/2] i2c: imx: fix dma_request_chan error handling
Thread-Index: AQHUrY6sN90gZ64G9kac2+8c4kfcXaW77weAgAPT5LA=
Date: Fri, 25 Jan 2019 09:20:51 +0000
Message-ID: <VI1PR04MB51345D0DD6A2138B3E452CEAEC9B0@VI1PR04MB5134.eurprd04.prod.outlook.com>
References: <20190116112855.13824-1-laurentiu.tudor@nxp.com>
 <20190122225155.vfy37bfuikzzymao@ninjato>
In-Reply-To: <20190122225155.vfy37bfuikzzymao@ninjato>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5917;
 6:AvYN1UFZu1uAR+MoFEUhOSBFMsUdeaRnQbaK+zKk85XvqjT43r27jvs6k4MoRkp0/J6OQHD5W0br728pXMb5UgrbRM6nQNrgy3lEBjefbzMeMb7/OZN9PelGIObi5jBPcEVqqrOhvdiP33uSuMCNacdI0j63JAv1gjbKiHsp+q1xMG8lk8RSFlb8HBdTTqy0wjoO51ERZP9l9AbaiV4JNghV43riH8IakxCXPK16hgztr7TrxQmd056dXTEn2OuuHFNLXlS7Vn7W4mKdcORwCFbHrcGalCk2InIfGXVgHjxqS45tSU9YhnQlNFE++Y0n3u87zQ0PkRXmbH6LS6KDz5WxvGbhp+mJDg21gQ9vxrh7CoHNDP+XEXrOJG3QxU3RaWLk2mCFR9Wj9+jYvjKBFTfhGNkWJWKZQQBT/p3r/juORdPAgNtTobKdV9OpIADXWh7jU8nds1FyT1vCP3i7dA==;
 5:q5rqq9zmyLCXF6G5FnWkdHqz4s0cBzA2Pc6rZTgQaDWe5Rroj/wtt02fyoFvL9HWTlruZ87Caju7Qexi5RVOo88IfzLQbxioVlmO/WD9SGxuQVupNRtcuezR7B6e7deqeFFU4l3UJlfReVbKTrQi/uOGxGSlDxVbzOd9sbrJb6WqYngvmjPXLAfQuLpixcEynGjlN1OawIN9yrsx9MGLxw==;
 7:+MRHXIj02EPdC0TgK9IdXUj69EWLxYn/6iB+cyIj9gTq6VpmICBTr9E2FFUYU5sC4rTLW8YlDRF5V2DlgMDbEz8YzwBHHk+0/g7uuSqnuKJW40dX1nvaAbP8+jc54FL915tYW+UKeXpjy9RGZculXg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fffdd335-3e11-480d-f68c-08d682a666a6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5917; 
x-ms-traffictypediagnostic: VI1PR04MB5917:
x-microsoft-antispam-prvs: <VI1PR04MB5917B999867E82325981C426EC9B0@VI1PR04MB5917.eurprd04.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(13464003)(52314003)(186003)(97736004)(25786009)(76176011)(71190400001)(71200400001)(53936002)(2906002)(99286004)(305945005)(7696005)(6436002)(86362001)(229853002)(54906003)(316002)(7736002)(6916009)(4326008)(8676002)(6506007)(66066001)(44832011)(81156014)(81166006)(14454004)(478600001)(55016002)(26005)(74316002)(256004)(6246003)(102836004)(9686003)(476003)(6116002)(33656002)(14444005)(446003)(105586002)(106356001)(8936002)(68736007)(3846002)(486006)(11346002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5917;
 H:VI1PR04MB5134.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oO9bSSh0CPf+e4yMc67cyPBISISeDFrOsvR29HflovL4cki637deI0rLPTI5zH6XN/iKOH8cLv1SDTbu9kuzuo8TWJBh2haQeJVz3cqTnXBINOQ2kNv4ujXbPVwlxGlmc0Rlomkpk5IC+J9dX5fvhPBpWjEN8Fhv07vXkTEccwX60PH4BFNAuZ1wMc6JqdMyBrQQsiT1lbPJfcNNgTwTtsNRfKnUGAGXCdeJhHmC+f0dpH0FKzPg2stXNrUDiSFOr2OoG7SBBLBwlPp1Fb1tY/moaE+WPxxOL+GH/Y5gDtZN0nyiRuVt9Om9FJeNaDP6PSq9NtEte8H7fGXdOw9ct0XYlbyFpHh8Eu74m6VaOEpYs4l20dc8cdS92Nkk/zAoguhddjUYWzTsiyZyUTubzoCmyoDI4RnR2BmNw+wDIHo=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffdd335-3e11-480d-f68c-08d682a666a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 09:20:51.6322 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5917
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_012100_475756_71F79BC2 
X-CRM114-Status: GOOD (  17.23  )
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
Cc: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Wolfram,

> -----Original Message-----
> From: Wolfram Sang [mailto:wsa@the-dreams.de]
> Sent: Wednesday, January 23, 2019 12:52 AM
> 
> On Wed, Jan 16, 2019 at 01:28:54PM +0200, Laurentiu Tudor wrote:
> > Use the correct error pointer when extracting the error code.
> >
> > Fixes: ea1e5f176e97 ("i2c: imx: notify about real errors on dma
> i2c_imx_dma_request")
> 
> This is not the sha1 in my tree. Maybe you rebased? I applied another
> patch meanwhile fixing the same issue. Still thanks!

I don't know, perhaps I was on some transient snapshot. Anyway, good that in the end it's fixed.

---
Best Regards, Laurentiu

> > Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > ---
> >  drivers/i2c/busses/i2c-imx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> > index 09b124547669..42fed40198a0 100644
> > --- a/drivers/i2c/busses/i2c-imx.c
> > +++ b/drivers/i2c/busses/i2c-imx.c
> > @@ -287,7 +287,7 @@ static int i2c_imx_dma_request(struct imx_i2c_struct
> *i2c_imx,
> >
> >  	dma->chan_tx = dma_request_chan(dev, "tx");
> >  	if (IS_ERR(dma->chan_tx)) {
> > -		ret = PTR_ERR(dma->chan_rx);
> > +		ret = PTR_ERR(dma->chan_tx);
> >  		if (ret != -ENODEV && ret != -EPROBE_DEFER)
> >  			dev_err(dev, "can't request DMA tx channel (%d)\n",
> ret);
> >  		goto fail_al;
> > --
> > 2.17.1
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
