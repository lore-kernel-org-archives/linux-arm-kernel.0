Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B626C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:14:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A91220811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LvVQxB9C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hjMoDthA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A91220811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ob/U7S3TpDLp2lJvQ80mJhJPz9mwbkuJ45/1VwVCzqo=; b=LvVQxB9CDCohZA
	Q0m5m0FF5Jau4GUOGOoOJ9tSFoeIP+A+dbMuLCar8RAB0SPshor/y26jGUobs9PtNDUjjSJr22/jp
	ubUJpSkW4HMT6gvlauy7E8U5SO1VBIj3QJmkyUgxUK1FH7I0tAqBqlPMtxFK3WHdZGIUmCaqsbbX9
	q9s2v5KhJksfyk4G5jlV+S71D3AJZVdyLVMajT2fvRDvLJdjfqXeg9PYnPIFxad4xTXeMPYCrnxOP
	vWNBcmbJV3iFM6+BWObMNx2ojFb4tZ6+N1pAlY2ujqbrgrIxd3JhXrxyV5jrX0qtMjochaiZKPy9z
	3psCdr5Ta3zN63Piyf6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWhrQ-0002tA-6v; Tue, 11 Dec 2018 13:14:04 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWhrM-0002sL-I7
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 13:14:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z+/ySEwowjsqDM4iwhpcgIWZWwL/FTTi14r56dkyW6Y=; b=hjMoDthAFKCCNczWz8QQ7ZkbP
 1qbE4TvPDhYQ6v35XHF61v47a5FufEgTPKZCo9AcE1EhfCV6/8ola8DYqDCDu9vNwQUSMmejGC0/0
 JJZc09hrBEOCs24nm9uX82CuYVfTYuUgT5tre6O7NlQVFs1hxTZ0Sn0JhVhem0fUg5A54=;
Received: from n2100.armlinux.org.uk
 ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:38726)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gWhr2-0006ex-Nt; Tue, 11 Dec 2018 13:13:40 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gWhqz-00085s-Je; Tue, 11 Dec 2018 13:13:37 +0000
Date: Tue, 11 Dec 2018 13:13:36 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Lower max_seg_size if too high for DMA
Message-ID: <20181211131336.GD9507@n2100.armlinux.org.uk>
References: <20181031155738.18367-1-tony@atomide.com>
 <CAPDyKFqtMHRjHsJXcKTTzGYSsyab=2SfWdYiETS4Bo2f7Zw2CQ@mail.gmail.com>
 <20181129191332.GY53235@atomide.com>
 <CAPDyKFpgOjr1Zp=31b-_+KVOnvRnXXdXt5e8b0X1pGNVAihtyA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPDyKFpgOjr1Zp=31b-_+KVOnvRnXXdXt5e8b0X1pGNVAihtyA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_051400_758109_46C688AE 
X-CRM114-Status: GOOD (  27.94  )
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

On Thu, Nov 29, 2018 at 09:11:17PM +0100, Ulf Hansson wrote:
> On Thu, 29 Nov 2018 at 20:13, Tony Lindgren <tony@atomide.com> wrote:
> >
> > * Ulf Hansson <ulf.hansson@linaro.org> [181119 12:09]:
> > > On 31 October 2018 at 16:57, Tony Lindgren <tony@atomide.com> wrote:
> > > > With CONFIG_DMA_API_DEBUG_SG a device may produce the following warning:
> > > >
> > > > "DMA-API: mapping sg segment longer than device claims to support"
> > > >
> > > > We default to 64KiB if a DMA engine driver does not initialize dma_parms
> > > > and call dma_set_max_seg_size(). This may be lower that what many MMC
> > > > drivers do with mmc->max_seg_size = mmc->max_blk_size * mmc->max_blk_count.
> > > >
> > > > Let's do a sanity check for max_seg_size being higher than what DMA
> > > > supports in mmc_add_host() and lower it as needed.
> > > >
> > > > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > > > Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > > > Cc: Russell King <rmk+kernel@armlinux.org.uk>
> > > > Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
> > > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > > ---
> > > >  drivers/mmc/core/host.c | 16 ++++++++++++++++
> > > >  1 file changed, 16 insertions(+)
> > > >
> > > > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > > > --- a/drivers/mmc/core/host.c
> > > > +++ b/drivers/mmc/core/host.c
> > > > @@ -13,6 +13,7 @@
> > > >   */
> > > >
> > > >  #include <linux/device.h>
> > > > +#include <linux/dma-mapping.h>
> > > >  #include <linux/err.h>
> > > >  #include <linux/idr.h>
> > > >  #include <linux/of.h>
> > > > @@ -415,6 +416,19 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
> > > >
> > > >  EXPORT_SYMBOL(mmc_alloc_host);
> > > >
> > > > +static void mmc_check_max_seg_size(struct mmc_host *host)
> > > > +{
> > > > +       unsigned int max_seg_size = dma_get_max_seg_size(mmc_dev(host));
> > >
> > > Is dma_get_max_seg_size() really intended to be called for any struct
> > > device (representing the mmc controller) like this?
> > >
> > > My understanding is that the dma_get_max_seg_size() is supposed to be
> > > called by using the DMA engine device, no?
> >
> > Oh good catch sounds like I'm calling it for the wrong device,
> > need to check. In that case sounds like this can't be generic?
> 
> No, I don't think so as it's only the mmc host driver that knows about
> the DMA engine device.

We're nearing the merge window, and this is a regression that is yet
to be solved.  It causes a kernel warning with backtrace, so it's
very annoying.

The error is:

omap-dma-engine 4a056000.dma-controller: DMA-API: mapping sg segment longer than device claims to support [len=69632] [max=65536]

which indicates that we have a SG segment length that exceeds thte
published maximum segment size for a device - in this case the
DMA engine device.  The maximum segment size for the DMA engine comes
from the default per-device setting, in linux/dma-mapping.h, which is
64K.

However, omap_hsmmc sets:

        mmc->max_blk_size = 512;       /* Block Length at max can be 1024 */
        mmc->max_blk_count = 0xFFFF;    /* No. of Blocks is 16 bits */
        mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
        mmc->max_seg_size = mmc->max_req_size;

which ends up telling the block layer that we support a maximum segment
size of 65535*512, so of course it _will_ pass SG lists where a segment
is longer than 64K.

The problem here is that the HSMMC driver doesn't take account of the
DMA engine device's capabilities.

We have something of an odd situation in that the omap-dma device's
maximum SG size depends on the "address width" - it's 64K transfers
of whatever unit "address width" is, so the current implementation of
per-device parameters doesn't exactly work.  That means the default
64K limit at the device-level is reasonable.

The only thing I can think of doing is adding into omap_hsmmc:

	mmc->max_seg_size = min(mmc->max_req_size,
				min(dma_get_max_seg_size(host->rx_chan->device->dev),
				    dma_get_max_seg_size(host->tx_chan->device->dev)));

to limit the maximum segment size to that of the device _and_ dma
engine's capabilities.

Doing this solves the problem for me.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
