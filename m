Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00247C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:12:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF82A20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uTR2f2ot";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b35z66+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF82A20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tmtTWHXUmB5leMvBGRr/U+cvpYOH/1EjMMswe3fdjrQ=; b=uTR2f2otP+jc99
	Gt44CE9gZvIx83d84cmDAjVx5bkT5G84oPTH+BUcKC88b3W0drGDJoBbVYl0GCKIE1XlSrjtKJHji
	jlNQzIAJLxfVIUH+omTPS3Wv8SYVhplaGd5lnFK8/3Y2qnnOOfhQfRZl6KaHJWhU72zA/dDGNIDbn
	6Y3/QUHOXDOdijLMvLnnB8/K8T8c6EkAVNNKvHM/ZJnTEvRkwm09ka4AbAyr9OW7D6VZLikfsI6Vj
	qM42AFhtzgUSSp6WOUiiwj9BWFbPdlnThS3B9FuF5bmuMqHp2pEAU0a65VpTQ6sdp4xtIDWoO2z+8
	fXkjxKn5jOpZUMoHPXQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSSfQ-0003lW-T3; Thu, 29 Nov 2018 20:12:08 +0000
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSSfN-0003ku-6J
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 20:12:06 +0000
Received: by mail-ua1-x944.google.com with SMTP id n7so1088612uao.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 12:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rH5/DUsUQow7m/WEF9v5+p7HexTsAjrOIbw6gwlVDiM=;
 b=b35z66+ihQtrVodxkGZV5yPx5DAteIB39ufN9J8mCZzTMDJOTCXvtMasv8eMK8fWuM
 3T5jkNg/msyFX7Z6GBCi85Z1GEGjPBT3MyOIzqlKkjXwu2CHnxJtcr7Rm27d/ZVmlRPJ
 jKJV6K9A3Hc3A6OkmbZZLmDxu2Xgldh8oO1I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rH5/DUsUQow7m/WEF9v5+p7HexTsAjrOIbw6gwlVDiM=;
 b=V7CZOYkqye4brqMWgDGYy0qxbupo8kTe53GcZsuabvWkJrpOcq1v6UNFwXD8CAT/ut
 0ae/gwnugYyzRA59FBARDfbid7TBfhXDUigbi5ooIMjINCQ0zjWVNTk1LwGMGmeYx9CW
 yN/fG4BjGU9UUBAZxHcQqwBcRRudOLxNn99A8HQ9EYsUU+2FPsNzBvwi/5H53u57ItIE
 +p7wK7EzZeb/kU26qrd38kErWliQ128U6jZNYYefTiTuemYGu1su9ao85Iw6E45wuET5
 obpaFfp5Le+XNPL62rDHSHWzd8safObgf/wzV94h9lYqXiKmIkhkZFOwQ2BXxE1NOEOu
 DDaQ==
X-Gm-Message-State: AA+aEWYT4MMZLc2HsRXtLPb8/6HAWBBZggPoiEJxxdf1vjqCurBxrDOV
 0pIgjLn3nMT9r8owgA5hM+D7OO3gSqpDPn4xmkaFeA==
X-Google-Smtp-Source: AFSGD/VIKsGqhkt6hvn/mb+lNFMJwO3YRMpo1QzCUurhnkUIWO6Zz+0FRlizBNWhQqY41qfiCHrtwFQ6jWCdA/qEnhs=
X-Received: by 2002:a9f:2244:: with SMTP id 62mr1185895uad.119.1543522313753; 
 Thu, 29 Nov 2018 12:11:53 -0800 (PST)
MIME-Version: 1.0
References: <20181031155738.18367-1-tony@atomide.com>
 <CAPDyKFqtMHRjHsJXcKTTzGYSsyab=2SfWdYiETS4Bo2f7Zw2CQ@mail.gmail.com>
 <20181129191332.GY53235@atomide.com>
In-Reply-To: <20181129191332.GY53235@atomide.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 29 Nov 2018 21:11:17 +0100
Message-ID: <CAPDyKFpgOjr1Zp=31b-_+KVOnvRnXXdXt5e8b0X1pGNVAihtyA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Lower max_seg_size if too high for DMA
To: Tony Lindgren <tony@atomide.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_121205_232371_B0435BEE 
X-CRM114-Status: GOOD (  21.51  )
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
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Kishon <kishon@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 linux-omap <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 29 Nov 2018 at 20:13, Tony Lindgren <tony@atomide.com> wrote:
>
> * Ulf Hansson <ulf.hansson@linaro.org> [181119 12:09]:
> > On 31 October 2018 at 16:57, Tony Lindgren <tony@atomide.com> wrote:
> > > With CONFIG_DMA_API_DEBUG_SG a device may produce the following warning:
> > >
> > > "DMA-API: mapping sg segment longer than device claims to support"
> > >
> > > We default to 64KiB if a DMA engine driver does not initialize dma_parms
> > > and call dma_set_max_seg_size(). This may be lower that what many MMC
> > > drivers do with mmc->max_seg_size = mmc->max_blk_size * mmc->max_blk_count.
> > >
> > > Let's do a sanity check for max_seg_size being higher than what DMA
> > > supports in mmc_add_host() and lower it as needed.
> > >
> > > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > > Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > > Cc: Russell King <rmk+kernel@armlinux.org.uk>
> > > Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > ---
> > >  drivers/mmc/core/host.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > > --- a/drivers/mmc/core/host.c
> > > +++ b/drivers/mmc/core/host.c
> > > @@ -13,6 +13,7 @@
> > >   */
> > >
> > >  #include <linux/device.h>
> > > +#include <linux/dma-mapping.h>
> > >  #include <linux/err.h>
> > >  #include <linux/idr.h>
> > >  #include <linux/of.h>
> > > @@ -415,6 +416,19 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
> > >
> > >  EXPORT_SYMBOL(mmc_alloc_host);
> > >
> > > +static void mmc_check_max_seg_size(struct mmc_host *host)
> > > +{
> > > +       unsigned int max_seg_size = dma_get_max_seg_size(mmc_dev(host));
> >
> > Is dma_get_max_seg_size() really intended to be called for any struct
> > device (representing the mmc controller) like this?
> >
> > My understanding is that the dma_get_max_seg_size() is supposed to be
> > called by using the DMA engine device, no?
>
> Oh good catch sounds like I'm calling it for the wrong device,
> need to check. In that case sounds like this can't be generic?

No, I don't think so as it's only the mmc host driver that knows about
the DMA engine device.

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
