Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA243C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 10:19:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C6321741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 10:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aYh1XDm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C6321741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zT5xecJr7ytVFNo7y3920p8YMe87DbKEVGWPU1famLk=; b=aYh1XDm9dp1sSN
	Jv30DxobO2mBXL8aTj2KDxAtG7UGcMgON6F9hIQ/WHUpS4yPRJ4npzwN1y2yyuH0mNeuQCRDDQvo2
	QB0hLUqMQ/qgghdUZEJ/YC0kLy8+ElPZC3sBjbxIzQrkwTCWvq4RHV455e/fPJqZm6gE/WWBpBSzl
	EmrFInf0JJvNZyb8CgotR0M6v+U6vH+wVFRIiZQySS8EE3CSvUjdrkJFj0g7sNTBoOu93qLUyzbtE
	clwSfJ5lKgTJxpc1P0/S0vaN+YIZDk9lGKM086OPlccxzvsUVDX6KBlp53KyLKok9DG3oX3Ah+ktY
	YIdq4GlSVFb6P0xGiy1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gc6HY-0004TL-9V; Wed, 26 Dec 2018 10:19:20 +0000
Received: from [210.61.82.184] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gc6HU-0004RS-5H; Wed, 26 Dec 2018 10:19:17 +0000
X-UUID: 15faf0724f9f490aae9a4cd03de26b4b-20181226
X-UUID: 15faf0724f9f490aae9a4cd03de26b4b-20181226
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by
 mailgw02.mediatek.com (envelope-from <long.cheng@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 454183028; Wed, 26 Dec 2018 18:18:57 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs03n1.mediatek.inc
 (172.21.101.181) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Wed, 26 Dec 2018 18:18:56 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Dec 2018 18:18:54 +0800
Message-ID: <1545819534.28871.93.camel@mhfsdcap03>
Subject: Re: [PATCH v7 1/2] dmaengine: 8250_mtk_dma: add MediaTek uart DMA
 support
From: Long Cheng <long.cheng@mediatek.com>
To: Nicolas Boichat <drinkcat@chromium.org>
Date: Wed, 26 Dec 2018 18:18:54 +0800
In-Reply-To: <CANMq1KDKqtKwSw1mJyR0TgBwY1YRfvY52vWyogqWweF3xAgiKA@mail.gmail.com>
References: <1545701209-6884-1-git-send-email-long.cheng@mediatek.com>
 <1545701209-6884-2-git-send-email-long.cheng@mediatek.com>
 <CANMq1KA1ywLnQDzXRbLcuu-afXuj_yrprRBC4kejF4-20ztXyA@mail.gmail.com>
 <1545739611.28871.77.camel@mhfsdcap03>
 <CANMq1KDtUgOUFRy-TyQK0EmbpXGtLEVo9Mqg1Hvs0JoL9NrFyQ@mail.gmail.com>
 <1545806121.28871.88.camel@mhfsdcap03>
 <CANMq1KDKqtKwSw1mJyR0TgBwY1YRfvY52vWyogqWweF3xAgiKA@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_021916_324956_6D4B1487 
X-CRM114-Status: GOOD (  19.36  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ryder
 Lee <ryder.lee@mediatek.com>, Zhenbao Liu <zhenbao.liu@mediatek.com>,
 linux-serial@vger.kernel.org, srv_heupstream@mediatek.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 Sean Wang <sean.wang@kernel.org>, YT Shen <yt.shen@mediatek.com>,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Sean Wang <sean.wang@mediatek.com>, Jiri Slaby <jslaby@suse.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-arm Mailing
 List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2018-12-26 at 17:28 +0800, Nicolas Boichat wrote:

......

> > > > > > +static int mtk_uart_apdma_device_pause(struct dma_chan *chan)
> > > > > > +{
> > > > > > +       /* just for check caps pass */
> > > > > > +       return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int mtk_uart_apdma_device_resume(struct dma_chan *chan)
> > > > > > +{
> > > > > > +       /* just for check caps pass */
> > > > > > +       return 0;
> > > > > > +}
> > >
> > > Why do you need these? Seems wrong to advertise device_pause/resume
> > > (and the caps) if we don't actually support that?
> > >
> >
> > in serial 8250_dma.c file, when request DMA, will calll
> > 'dma_get_slave_caps' to get the caps. and the will check caps.cmd_pause.
> > the pause is device_pause.  our device can't support the functions. but
> > to check pass, need add the fake function. or you can give better
> > comments. thanks.
> 
> Well, then I guess this is a hack... I'm not too familiar with
> 8250_dma.c, but I guess that if it requires pause/resume to be
> implemented, then we should implement them, not just stub them out...
> 
> Is this something that can be implemented with 8250_mtk DMA?
> 

the HW can't support it.

> Also, I don't see where you need resume, so maybe implementing pause is enough?
> 

yes. pause is enough. for symmetry, add resume function.
anyway, the pause function need to keep.

> > > > > > +
> > > > > > +static void mtk_uart_apdma_free(struct mtk_uart_apdmadev *mtkd)
> > > > > > +{
> > > > > > +       while (list_empty(&mtkd->ddev.channels) == 0) {
> > > > > > +               struct mtk_chan *c = list_first_entry(&mtkd->ddev.channels,
> > > > > > +                       struct mtk_chan, vc.chan.device_node);
> > > > > > +
> > > > > > +               list_del(&c->vc.chan.device_node);
> > > > > > +               tasklet_kill(&c->vc.task);
> > > > > > +       }
> > > > > > +}
> > > > > > +
> > > > > > +static const struct of_device_id mtk_uart_apdma_match[] = {
> > > > > > +       { .compatible = "mediatek,mt6577-uart-dma", },
> > > > > > +       { /* sentinel */ },
> > > > > > +};
> > > > > > +MODULE_DEVICE_TABLE(of, mtk_uart_apdma_match);
> > > > > > +
> > > > > > +static int mtk_uart_apdma_probe(struct platform_device *pdev)
> > > > > > +{
> > > > > > +       struct mtk_uart_apdmadev *mtkd;
> > > > > > +       struct resource *res;
> > > > > > +       struct mtk_chan *c;
> > > > > > +       unsigned int i;
> > > > > > +       int rc;
> > > > > > +

......



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
