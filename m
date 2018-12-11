Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87DEC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:40:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E4692081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="akXose/K";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hBykHs9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4692081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Hgnk6gzmECQI1I3X0MG/dp1hZo3iSIOvC9GBlYxSPb8=; b=akXose/KKfZOOx
	krZex4eJob4WHZHial0hPX+KgsMN/wZAw0C1pgCXwwNex222aQWXQOXLwqWjqH6hYW20KFeu+GNz1
	9iFX4ghSI0sPtra2/661Dnj5D3zFrBvlEMwEbq6eHy1k3Ty2EZFU3InztcmK7+QV/9YP1kQ1z/aRN
	g9chLlbORBGfD98b3m1GTZ00Jl5EKmRg+PcRoxiOp/BCoS4gvT+w8kybnnoaDU5G1DXJ7u9TuT6iM
	gBO8LMRc9G1BZf+LQgEBvjmzI8p5ItRsDDB7JcXj9qmZ1c49bMCgNydLfcP/cTcLqAWyuJ+pxtjYg
	hgM8t6G6Vetw2PAY5eEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWiGZ-0005cI-RE; Tue, 11 Dec 2018 13:40:03 +0000
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWiGV-0005OV-FB
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 13:40:01 +0000
Received: by mail-vs1-xe43.google.com with SMTP id g68so8831656vsd.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 05:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SGVIEaOV83OnHhkQX+7xbAM8HIhKxcKdpdRGjEdgy1U=;
 b=hBykHs9HCIepSmwg3Eux19HKcF9EqbwqeKZtp2w5siG7ADBeIX8caKU+FNZ4+/VkYr
 AqqyR5QGQ7ByasSCBk7WQS/6gHdsbJkw2STvJT4/0dy4hii4t2FsKB9VL6nZV+ItZM5j
 poHCkMzV6TBMQuofiAQwvd7uiplM865ICTl9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SGVIEaOV83OnHhkQX+7xbAM8HIhKxcKdpdRGjEdgy1U=;
 b=C++77/nKWt+Z8ZyPD/tLxe04bAHLrFfbnkmvYUI8nsHBNDcLeIv7/ckCatfARAhcSh
 Ft0YtuXhdeMnuU8D1RwpKg9H2igzI7uvdKw8ZG2RIGc1VNqFdr4YfHW/NjS0Mzv1in6D
 aArKHBuD+ZVql2VJO5SHpm9J/8pO3qRJbvkatrpwrhbi0vsITwxVDkL+JpEt++sUkvFg
 aCbMjlu5DF4are4QwB7PO+3/Nsm+E3U5NUN+Uvop9bn9lUlbFWJDbnJIPHwOuV+SSIrR
 CsfuU5ZWxhOINUm04xK4rOAsalbfyC2LI9b1QFbsKS8qvk69ibuACy5jOym+2hUjjqTc
 A/gQ==
X-Gm-Message-State: AA+aEWZAwani9kbNurjVfpcZWEWfJ0KVv+DL4UsK7UOpRN28H0KVex6x
 f6x/ZyceXjPIh3IxK5Ery26FZQUMEg7i04V6/mEqDA==
X-Google-Smtp-Source: AFSGD/X12ndjcvVJ97iCdCl/L+iHxy3IDel7XnVA8Cdk5ZBFwOe0qAts72lzkPCRejjlw8b6birj2yOD2hy8Y+nWm8c=
X-Received: by 2002:a67:b245:: with SMTP id s5mr7339727vsh.200.1544535587603; 
 Tue, 11 Dec 2018 05:39:47 -0800 (PST)
MIME-Version: 1.0
References: <20181031155738.18367-1-tony@atomide.com>
 <CAPDyKFqtMHRjHsJXcKTTzGYSsyab=2SfWdYiETS4Bo2f7Zw2CQ@mail.gmail.com>
 <20181129191332.GY53235@atomide.com>
 <CAPDyKFpgOjr1Zp=31b-_+KVOnvRnXXdXt5e8b0X1pGNVAihtyA@mail.gmail.com>
 <20181211131336.GD9507@n2100.armlinux.org.uk>
In-Reply-To: <20181211131336.GD9507@n2100.armlinux.org.uk>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Dec 2018 14:39:11 +0100
Message-ID: <CAPDyKFr=vqNh+auGXjYJs+oq70+VksuOJNF7cFm-VifSKf6f9w@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Lower max_seg_size if too high for DMA
To: Russell King <linux@armlinux.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_053959_510813_562204D9 
X-CRM114-Status: GOOD (  32.10  )
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

On Tue, 11 Dec 2018 at 14:13, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Thu, Nov 29, 2018 at 09:11:17PM +0100, Ulf Hansson wrote:
> > On Thu, 29 Nov 2018 at 20:13, Tony Lindgren <tony@atomide.com> wrote:
> > >
> > > * Ulf Hansson <ulf.hansson@linaro.org> [181119 12:09]:
> > > > On 31 October 2018 at 16:57, Tony Lindgren <tony@atomide.com> wrote:
> > > > > With CONFIG_DMA_API_DEBUG_SG a device may produce the following warning:
> > > > >
> > > > > "DMA-API: mapping sg segment longer than device claims to support"
> > > > >
> > > > > We default to 64KiB if a DMA engine driver does not initialize dma_parms
> > > > > and call dma_set_max_seg_size(). This may be lower that what many MMC
> > > > > drivers do with mmc->max_seg_size = mmc->max_blk_size * mmc->max_blk_count.
> > > > >
> > > > > Let's do a sanity check for max_seg_size being higher than what DMA
> > > > > supports in mmc_add_host() and lower it as needed.
> > > > >
> > > > > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > > > > Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > > > > Cc: Russell King <rmk+kernel@armlinux.org.uk>
> > > > > Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
> > > > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > > > ---
> > > > >  drivers/mmc/core/host.c | 16 ++++++++++++++++
> > > > >  1 file changed, 16 insertions(+)
> > > > >
> > > > > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > > > > --- a/drivers/mmc/core/host.c
> > > > > +++ b/drivers/mmc/core/host.c
> > > > > @@ -13,6 +13,7 @@
> > > > >   */
> > > > >
> > > > >  #include <linux/device.h>
> > > > > +#include <linux/dma-mapping.h>
> > > > >  #include <linux/err.h>
> > > > >  #include <linux/idr.h>
> > > > >  #include <linux/of.h>
> > > > > @@ -415,6 +416,19 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
> > > > >
> > > > >  EXPORT_SYMBOL(mmc_alloc_host);
> > > > >
> > > > > +static void mmc_check_max_seg_size(struct mmc_host *host)
> > > > > +{
> > > > > +       unsigned int max_seg_size = dma_get_max_seg_size(mmc_dev(host));
> > > >
> > > > Is dma_get_max_seg_size() really intended to be called for any struct
> > > > device (representing the mmc controller) like this?
> > > >
> > > > My understanding is that the dma_get_max_seg_size() is supposed to be
> > > > called by using the DMA engine device, no?
> > >
> > > Oh good catch sounds like I'm calling it for the wrong device,
> > > need to check. In that case sounds like this can't be generic?
> >
> > No, I don't think so as it's only the mmc host driver that knows about
> > the DMA engine device.
>
> We're nearing the merge window, and this is a regression that is yet
> to be solved.  It causes a kernel warning with backtrace, so it's
> very annoying.
>
> The error is:
>
> omap-dma-engine 4a056000.dma-controller: DMA-API: mapping sg segment longer than device claims to support [len=69632] [max=65536]
>
> which indicates that we have a SG segment length that exceeds thte
> published maximum segment size for a device - in this case the
> DMA engine device.  The maximum segment size for the DMA engine comes
> from the default per-device setting, in linux/dma-mapping.h, which is
> 64K.
>
> However, omap_hsmmc sets:
>
>         mmc->max_blk_size = 512;       /* Block Length at max can be 1024 */
>         mmc->max_blk_count = 0xFFFF;    /* No. of Blocks is 16 bits */
>         mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
>         mmc->max_seg_size = mmc->max_req_size;
>
> which ends up telling the block layer that we support a maximum segment
> size of 65535*512, so of course it _will_ pass SG lists where a segment
> is longer than 64K.
>
> The problem here is that the HSMMC driver doesn't take account of the
> DMA engine device's capabilities.
>
> We have something of an odd situation in that the omap-dma device's
> maximum SG size depends on the "address width" - it's 64K transfers
> of whatever unit "address width" is, so the current implementation of
> per-device parameters doesn't exactly work.  That means the default
> 64K limit at the device-level is reasonable.
>
> The only thing I can think of doing is adding into omap_hsmmc:
>
>         mmc->max_seg_size = min(mmc->max_req_size,
>                                 min(dma_get_max_seg_size(host->rx_chan->device->dev),
>                                     dma_get_max_seg_size(host->tx_chan->device->dev)));
>
> to limit the maximum segment size to that of the device _and_ dma
> engine's capabilities.
>
> Doing this solves the problem for me.

Thanks for the suggestion - it sounds like a reasonable way to fix the
problem, at least for now.

Do you want to send to patch or do you expect someone else to do it?

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
