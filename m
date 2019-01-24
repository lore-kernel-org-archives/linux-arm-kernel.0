Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB46C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:34:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B133F2184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uQkAEwsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B133F2184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rLo0XlcA4zxWvIIv1M09LK6AQlXxJm+m6Jqjx6ZCo7A=; b=uQkAEwsCEnxVK7
	P6AAvPl4cn/mM26W0dPXR1z4a3UDFsvyy6dlFFe3OPCNBNK8p+MPoEm5UnsADz+tLFlKX/uNkpNP5
	vngdDf6elReYP92oLr11A+jf+DacH2C3fNfINb1EJkIvRc2piw9l42PEG/Ytoo/i5tJoOh20bOlbM
	QG9RsR5K/3+Iq8pFhJPuK4BXpx02JPKmQWySPlIxVuqRR8phCkPk8QugtNY1+nVm3+lp/jS7CBX/V
	KOoe6TK7YxzaCPKbsxDC4iCjh/9qfPMgkGqYqLiJTAq11pQz7BT5sMz0X7VU6AelprnqBibjeAmVG
	wlskLWMYKCrAt7RPyhOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmg5f-0001kg-4d; Thu, 24 Jan 2019 14:34:47 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmg5a-0001jz-Fr
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 14:34:44 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gmg5R-0003D1-0A; Thu, 24 Jan 2019 15:34:33 +0100
Message-ID: <1548340471.28802.23.camel@pengutronix.de>
Subject: Re: [PATCH] soc: imx: gpc: set DMA mask for PD platform devices
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>
Date: Thu, 24 Jan 2019 15:34:31 +0100
In-Reply-To: <CAOMZO5CeOxzyEG0tTKHfrNjY8WRKs=s5nBvxqZuFuJjR62eXOA@mail.gmail.com>
References: <20180912152702.14640-1-l.stach@pengutronix.de>
 <20180926023937.GD22238@dragon>
 <CAOMZO5CeOxzyEG0tTKHfrNjY8WRKs=s5nBvxqZuFuJjR62eXOA@mail.gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_063442_683478_1029120A 
X-CRM114-Status: GOOD (  17.12  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
 patchwork-lst@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Fabio,

Am Donnerstag, den 24.01.2019, 09:46 -0200 schrieb Fabio Estevam:
> Hi Shawn,
> 
> On Tue, Sep 25, 2018 at 11:41 PM Shawn Guo <shawnguo@kernel.org>
> wrote:
> > 
> > On Wed, Sep 12, 2018 at 05:27:02PM +0200, Lucas Stach wrote:
> > > The PD platform devices aren't DMA capable (as is correctly
> > > reflected
> > > in with a zero mask coherent_dma_mask). As they have a of_node
> > > attached
> > > they will go through of_dma_configure, which will warn if it
> > > finds an
> > > uninitialized DMA mask. Let the driver core know that this isn't
> > > a
> > > missing configuration, but a non DMA capable device by pointing
> > > the
> > > dma_mask to the coherent_dma_mask.
> > > 
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > ---
> > > Since the warning that is triggered with the incomplete
> > > configuration
> > > has been introduced in the v4.19 cycle, it would nice to get this
> > > in
> > > as a fix.
> > 
> > Applied as a fix, thanks.
> 
> Did you forget to push this change? I still don't see it applied.

It was dropped due to discussion in the pull request:

https://patchwork.kernel.org/patch/10621589/

It seems we are stuck there and I don't have the bandwidth to follow up
with this currently.

Regards,
Lucas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
