Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D5FC282D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:55:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4053A21852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FP0sxn4J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Szk2rfrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4053A21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GjFCaSqZxSHuLB/RJDALC+HYwwAXWbiq42yWbuAl+hA=; b=FP0sxn4JBUQXas
	pnykyXmJKlze9lU1aPzGQ/eYr39YpMscvndVBqnehcuG3X0MEf3wpba96erUbnmAFinqMzFOvVUWw
	0xbIqOMO5QBcYgZDbrQISpUaDxI95hLnjUhGmD9SXpauaitGnj2YwY1FTtCK+Dlb9mN3siimr8z75
	75l7IW9l9GH1f2lBLU/p6JgLvv0WDxE9KiNy1QrbVKIp4qoUBoq4Pnnu9uVwCcTFJIfIwFIaRqMcF
	Lx+6p1koeouK2oQzRFx4GOEa2KfTohJSrsssJvnKi7C6QXchXMvMyuT36G0tshtbi/BNPLwondcTN
	jqovN2iM9otbpdaRhm/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gokir-0001ta-2E; Wed, 30 Jan 2019 07:55:49 +0000
Received: from mail-ua1-x941.google.com ([2607:f8b0:4864:20::941])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gokin-0001tE-Lp
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 07:55:47 +0000
Received: by mail-ua1-x941.google.com with SMTP id p9so7778316uaa.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 23:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nZIvWLr2bMHRAYkCkGLBjoPGhk0MGw5PKfGobTQT1ZQ=;
 b=Szk2rfrF2gujhUb+9JkuNLLUBR7BHzwf/XFuWtKivbr3nb7Z+1Gm8UvfjIpktekj23
 dkoLuGVZehQYf1oSAjlVMQTaJa3IGvvrP5PNk4OHeaEuV900QRq/2sc3i4V+22VXouQT
 zOfBgxWif96Ibh6QBI1nX3oQcrsA/NqaDTawI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nZIvWLr2bMHRAYkCkGLBjoPGhk0MGw5PKfGobTQT1ZQ=;
 b=jijEtQS/qIN94iTRf+Y35Egif5HAta0CTpEHUqR0REXw7z3VUjEtqePsr0eZUVC8gP
 zs4huL2MDbcEj++JE2BxRUKvSmO49HGXFo3XFmXxrAVWm93+qwO5b0zvxXQqdOhr0Ke6
 X8ks8qBi7BLEQHBTJ58xQRbMXU9sFTeiRINoGpu7/Tl72n4BrivXr8DdplGAP1GHVpna
 /ayRqkcsUxTYsf988edyuBhgY5uIjtAI68fTidzJ9UJsJnuKmXOHciJlRfXInkCT0u+V
 xSL9BajEVgnDqPXJYYTTf5JVdKfiIRzqvmb396oTdVZpihXIy50JNxPSIuLanVDyjH3A
 OF+A==
X-Gm-Message-State: AJcUukecYY/jUBaxfuFk+UUJLazvizuqtfYrXRD1I/VpsDafGCdYLuds
 Wd10hqyxZOjLfHIYUbOjIsV6DCfpZMBWK0Gx3kBPIw==
X-Google-Smtp-Source: ALg8bN4q+O5UBStmvc5vY8XFWUOvO2/8XYi/PZrtpkxbGUhBFnbCsFCpmQ4TCQWax7jPK3go3FhGDiH4O7OPytidBHs=
X-Received: by 2002:ab0:b83:: with SMTP id c3mr11514419uak.77.1548834943903;
 Tue, 29 Jan 2019 23:55:43 -0800 (PST)
MIME-Version: 1.0
References: <20190114095804.27978-1-hch@lst.de>
 <20190114095804.27978-8-hch@lst.de>
In-Reply-To: <20190114095804.27978-8-hch@lst.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 30 Jan 2019 08:55:07 +0100
Message-ID: <CAPDyKFrtJmaS33=yZz7ubUVVb5UB-Euq5pcaBMSFeQyubDYvGA@mail.gmail.com>
Subject: Re: [PATCH 07/11] mmc: mvsdio: handle highmem pages
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_235545_738506_B0A6A46B 
X-CRM114-Status: GOOD (  20.09  )
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
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Nicolas Pitre <nico@fluxnic.net>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Ben Dooks <ben-linux@fluff.org>, linux-omap <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 14 Jan 2019 at 10:58, Christoph Hellwig <hch@lst.de> wrote:
>
> Instead of setting up a kernel pointer to track the current PIO address,
> track the offset in the current page, and do an atomic kmap for the page
> while doing the actual PIO operations.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/mmc/host/mvsdio.c | 48 +++++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index e22bbff89c8d..545e370d6dae 100644
> --- a/drivers/mmc/host/mvsdio.c
> +++ b/drivers/mmc/host/mvsdio.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> +#include <linux/highmem.h>
>  #include <linux/platform_device.h>
>  #include <linux/mbus.h>
>  #include <linux/delay.h>
> @@ -42,7 +43,8 @@ struct mvsd_host {
>         unsigned int intr_en;
>         unsigned int ctrl;
>         unsigned int pio_size;
> -       void *pio_ptr;
> +       struct scatterlist *pio_sg;
> +       unsigned int pio_offset; /* offset in words into the segment */
>         unsigned int sg_frags;
>         unsigned int ns_per_clk;
>         unsigned int clock;
> @@ -96,9 +98,9 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
>         if (tmout_index > MVSD_HOST_CTRL_TMOUT_MAX)
>                 tmout_index = MVSD_HOST_CTRL_TMOUT_MAX;
>
> -       dev_dbg(host->dev, "data %s at 0x%08x: blocks=%d blksz=%d tmout=%u (%d)\n",
> +       dev_dbg(host->dev, "data %s at 0x%08llx: blocks=%d blksz=%d tmout=%u (%d)\n",
>                 (data->flags & MMC_DATA_READ) ? "read" : "write",
> -               (u32)sg_virt(data->sg), data->blocks, data->blksz,
> +               (u64)sg_phys(data->sg), data->blocks, data->blksz,
>                 tmout, tmout_index);
>
>         host->ctrl &= ~MVSD_HOST_CTRL_TMOUT_MASK;
> @@ -118,10 +120,11 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
>                  * boundary.
>                  */
>                 host->pio_size = data->blocks * data->blksz;
> -               host->pio_ptr = sg_virt(data->sg);
> +               host->pio_sg = data->sg;
> +               host->pio_offset = data->sg->offset / 2;
>                 if (!nodma)
> -                       dev_dbg(host->dev, "fallback to PIO for data at 0x%p size %d\n",
> -                               host->pio_ptr, host->pio_size);
> +                       dev_dbg(host->dev, "fallback to PIO for data at 0x%x size %d\n",
> +                               host->pio_offset, host->pio_size);
>                 return 1;
>         } else {
>                 dma_addr_t phys_addr;
> @@ -291,8 +294,9 @@ static u32 mvsd_finish_data(struct mvsd_host *host, struct mmc_data *data,
>  {
>         void __iomem *iobase = host->base;
>
> -       if (host->pio_ptr) {
> -               host->pio_ptr = NULL;
> +       if (host->pio_sg) {
> +               host->pio_sg = NULL;
> +               host->pio_offset = 0;
>                 host->pio_size = 0;
>         } else {
>                 dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_frags,
> @@ -376,11 +380,12 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
>         if (host->pio_size &&
>             (intr_status & host->intr_en &
>              (MVSD_NOR_RX_READY | MVSD_NOR_RX_FIFO_8W))) {
> -               u16 *p = host->pio_ptr;
> +               u16 *p = kmap_atomic(sg_page(host->pio_sg));

Seems like a corresponding kunmap_atomic() is missing somewhere.

> +               unsigned int o = host->pio_offset;
>                 int s = host->pio_size;
>                 while (s >= 32 && (intr_status & MVSD_NOR_RX_FIFO_8W)) {
> -                       readsw(iobase + MVSD_FIFO, p, 16);
> -                       p += 16;
> +                       readsw(iobase + MVSD_FIFO, p + o, 16);
> +                       o += 16;
>                         s -= 32;
>                         intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
>                 }
> @@ -391,8 +396,10 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
>                  */
>                 if (s <= 32) {
>                         while (s >= 4 && (intr_status & MVSD_NOR_RX_READY)) {
> -                               put_unaligned(mvsd_read(MVSD_FIFO), p++);
> -                               put_unaligned(mvsd_read(MVSD_FIFO), p++);
> +                               put_unaligned(mvsd_read(MVSD_FIFO), p + o);
> +                               o++;
> +                               put_unaligned(mvsd_read(MVSD_FIFO), p + o);
> +                               o++;
>                                 s -= 4;
>                                 intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
>                         }
> @@ -400,7 +407,7 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
>                                 u16 val[2] = {0, 0};
>                                 val[0] = mvsd_read(MVSD_FIFO);
>                                 val[1] = mvsd_read(MVSD_FIFO);
> -                               memcpy(p, ((void *)&val) + 4 - s, s);
> +                               memcpy(p + o, ((void *)&val) + 4 - s, s);
>                                 s = 0;
>                                 intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
>                         }
> @@ -416,13 +423,14 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
>                 }
>                 dev_dbg(host->dev, "pio %d intr 0x%04x hw_state 0x%04x\n",
>                         s, intr_status, mvsd_read(MVSD_HW_STATE));
> -               host->pio_ptr = p;
> +               host->pio_offset = o;
>                 host->pio_size = s;
>                 irq_handled = 1;
>         } else if (host->pio_size &&
>                    (intr_status & host->intr_en &
>                     (MVSD_NOR_TX_AVAIL | MVSD_NOR_TX_FIFO_8W))) {
> -               u16 *p = host->pio_ptr;
> +               u16 *p = kmap_atomic(sg_page(host->pio_sg));

Ditto.

> +               unsigned int o = host->pio_offset;
>                 int s = host->pio_size;
>                 /*
>                  * The TX_FIFO_8W bit is unreliable. When set, bursting
> @@ -431,8 +439,10 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
>                  * TX_FIFO_8W remains set.
>                  */
>                 while (s >= 4 && (intr_status & MVSD_NOR_TX_AVAIL)) {
> -                       mvsd_write(MVSD_FIFO, get_unaligned(p++));
> -                       mvsd_write(MVSD_FIFO, get_unaligned(p++));
> +                       mvsd_write(MVSD_FIFO, get_unaligned(p + o));
> +                       o++;
> +                       mvsd_write(MVSD_FIFO, get_unaligned(p + o));
> +                       o++;
>                         s -= 4;
>                         intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
>                 }
> @@ -453,7 +463,7 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
>                 }
>                 dev_dbg(host->dev, "pio %d intr 0x%04x hw_state 0x%04x\n",
>                         s, intr_status, mvsd_read(MVSD_HW_STATE));
> -               host->pio_ptr = p;
> +               host->pio_offset = o;
>                 host->pio_size = s;
>                 irq_handled = 1;
>         }
> --
> 2.20.1
>

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
