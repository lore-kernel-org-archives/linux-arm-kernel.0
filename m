Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B365C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:50:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B76620849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EXFsv6OX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FyV8lj3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B76620849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kZsyZEyhLvAtY504q4MQlrtdv6m3ZOa67TSZnmgz7xU=; b=EXFsv6OX9jFzkX
	OKsmNNyRp31CUqCgeXRJ5/sI5rLTe0EP+3ZJwC9FtPpChC+DixhuIzQ5d6oZ4oZJcEoOBMarHnHH8
	YJyl9kHXJ7zvyT6Oho+Gk1EEtrp6wlQWM89+8XUH/WtRQKsdAOyzY//rL3kQ/328DAL2Irb/cT8mi
	K7R/eYRAQTZgezKNlsWAzP2nBiboxKnRfGRjCGgo3yfJw8u5Dyc28tx8HRr2GECfKo6Lri0jtUhIB
	Lo+2gOnIisIXmx/pD6r5u7FYEqLfA5X7NcDYnqIRM/h1vwPWXnK9ylVKgSbk5nSiCh7Z5rfFbrzsK
	5Zt68UFz+MVkxFT9iNkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWiQH-0002rW-Pu; Tue, 11 Dec 2018 13:50:05 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWiQC-0002Mc-Vl
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 13:50:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9NMzM5M9pPXUFLDj+J9a4yYEeEsKyctE0Ug8UO1rtnE=; b=FyV8lj3sX48/88CSmGO07l/in
 sJ+GtMpzkKMMOYV0KT7ZngW12bVHlWAyl0t7DCjBQVmMeLQ2uwryN704+0FYFL+bYLfr+4NOmszAt
 Y5RJw+uGEz+Ly9GEl3cMyAZDtWLB4A9pUis07wkGIFP7tRtCtnpn/l1w5BX43i3XYYOVM=;
Received: from n2100.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:57174)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gWiPu-0006qJ-HQ; Tue, 11 Dec 2018 13:49:42 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gWiPr-0008Ub-M3; Tue, 11 Dec 2018 13:49:39 +0000
Date: Tue, 11 Dec 2018 13:49:37 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Lower max_seg_size if too high for DMA
Message-ID: <20181211134937.GE9507@n2100.armlinux.org.uk>
References: <20181031155738.18367-1-tony@atomide.com>
 <CAPDyKFqtMHRjHsJXcKTTzGYSsyab=2SfWdYiETS4Bo2f7Zw2CQ@mail.gmail.com>
 <20181129191332.GY53235@atomide.com>
 <CAPDyKFpgOjr1Zp=31b-_+KVOnvRnXXdXt5e8b0X1pGNVAihtyA@mail.gmail.com>
 <20181211131336.GD9507@n2100.armlinux.org.uk>
 <CAPDyKFr=vqNh+auGXjYJs+oq70+VksuOJNF7cFm-VifSKf6f9w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPDyKFr=vqNh+auGXjYJs+oq70+VksuOJNF7cFm-VifSKf6f9w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_055001_386759_854268B6 
X-CRM114-Status: GOOD (  36.95  )
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
Cc: Tony Lindgren <tony@atomide.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Kishon <kishon@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 linux-omap <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 02:39:11PM +0100, Ulf Hansson wrote:
> On Tue, 11 Dec 2018 at 14:13, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> >
> > On Thu, Nov 29, 2018 at 09:11:17PM +0100, Ulf Hansson wrote:
> > > On Thu, 29 Nov 2018 at 20:13, Tony Lindgren <tony@atomide.com> wrote:
> > > >
> > > > * Ulf Hansson <ulf.hansson@linaro.org> [181119 12:09]:
> > > > > On 31 October 2018 at 16:57, Tony Lindgren <tony@atomide.com> wrote:
> > > > > > With CONFIG_DMA_API_DEBUG_SG a device may produce the following warning:
> > > > > >
> > > > > > "DMA-API: mapping sg segment longer than device claims to support"
> > > > > >
> > > > > > We default to 64KiB if a DMA engine driver does not initialize dma_parms
> > > > > > and call dma_set_max_seg_size(). This may be lower that what many MMC
> > > > > > drivers do with mmc->max_seg_size = mmc->max_blk_size * mmc->max_blk_count.
> > > > > >
> > > > > > Let's do a sanity check for max_seg_size being higher than what DMA
> > > > > > supports in mmc_add_host() and lower it as needed.
> > > > > >
> > > > > > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > > > > > Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > > > > > Cc: Russell King <rmk+kernel@armlinux.org.uk>
> > > > > > Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
> > > > > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > > > > ---
> > > > > >  drivers/mmc/core/host.c | 16 ++++++++++++++++
> > > > > >  1 file changed, 16 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > > > > > --- a/drivers/mmc/core/host.c
> > > > > > +++ b/drivers/mmc/core/host.c
> > > > > > @@ -13,6 +13,7 @@
> > > > > >   */
> > > > > >
> > > > > >  #include <linux/device.h>
> > > > > > +#include <linux/dma-mapping.h>
> > > > > >  #include <linux/err.h>
> > > > > >  #include <linux/idr.h>
> > > > > >  #include <linux/of.h>
> > > > > > @@ -415,6 +416,19 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
> > > > > >
> > > > > >  EXPORT_SYMBOL(mmc_alloc_host);
> > > > > >
> > > > > > +static void mmc_check_max_seg_size(struct mmc_host *host)
> > > > > > +{
> > > > > > +       unsigned int max_seg_size = dma_get_max_seg_size(mmc_dev(host));
> > > > >
> > > > > Is dma_get_max_seg_size() really intended to be called for any struct
> > > > > device (representing the mmc controller) like this?
> > > > >
> > > > > My understanding is that the dma_get_max_seg_size() is supposed to be
> > > > > called by using the DMA engine device, no?
> > > >
> > > > Oh good catch sounds like I'm calling it for the wrong device,
> > > > need to check. In that case sounds like this can't be generic?
> > >
> > > No, I don't think so as it's only the mmc host driver that knows about
> > > the DMA engine device.
> >
> > We're nearing the merge window, and this is a regression that is yet
> > to be solved.  It causes a kernel warning with backtrace, so it's
> > very annoying.
> >
> > The error is:
> >
> > omap-dma-engine 4a056000.dma-controller: DMA-API: mapping sg segment longer than device claims to support [len=69632] [max=65536]
> >
> > which indicates that we have a SG segment length that exceeds thte
> > published maximum segment size for a device - in this case the
> > DMA engine device.  The maximum segment size for the DMA engine comes
> > from the default per-device setting, in linux/dma-mapping.h, which is
> > 64K.
> >
> > However, omap_hsmmc sets:
> >
> >         mmc->max_blk_size = 512;       /* Block Length at max can be 1024 */
> >         mmc->max_blk_count = 0xFFFF;    /* No. of Blocks is 16 bits */
> >         mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
> >         mmc->max_seg_size = mmc->max_req_size;
> >
> > which ends up telling the block layer that we support a maximum segment
> > size of 65535*512, so of course it _will_ pass SG lists where a segment
> > is longer than 64K.
> >
> > The problem here is that the HSMMC driver doesn't take account of the
> > DMA engine device's capabilities.
> >
> > We have something of an odd situation in that the omap-dma device's
> > maximum SG size depends on the "address width" - it's 64K transfers
> > of whatever unit "address width" is, so the current implementation of
> > per-device parameters doesn't exactly work.  That means the default
> > 64K limit at the device-level is reasonable.
> >
> > The only thing I can think of doing is adding into omap_hsmmc:
> >
> >         mmc->max_seg_size = min(mmc->max_req_size,
> >                                 min(dma_get_max_seg_size(host->rx_chan->device->dev),
> >                                     dma_get_max_seg_size(host->tx_chan->device->dev)));
> >
> > to limit the maximum segment size to that of the device _and_ dma
> > engine's capabilities.
> >
> > Doing this solves the problem for me.
> 
> Thanks for the suggestion - it sounds like a reasonable way to fix the
> problem, at least for now.

I don't think there's any "at least for now" about this approach - it's
not something that the MMC core can know about, because whether a driver
uses DMA engine or not, and how many channels it uses is completely
driver specific.

The only questionable thing is around the dma_get_max_seg_size()
interface, but the only way that's going to get solved is to eliminate
it entirely as it isn't a per-device property with some DMA engines
such as omap-dma - it's a per-request property.  That also means
killing the check in the DMA debug code, which isn't going to go down
very well.

> Do you want to send to patch or do you expect someone else to do it?

I'll send a patch once I've checked the corner cases, and whether
we should go further and include other DMA parameters from the
dma engine.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
