Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C30DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:29:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C497E206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S38stwd5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jdn17jXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C497E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Swv3NX1Zp2b2UG6WsujqZnqVEVTkeIRmqznA2rTJU3Y=; b=S38stwd5SIjB/Q
	l5tQOlVFkRzfwLR2SDdOnpAjPYV9Y4ta+oktfs/IPTGiLPBEdeRwMaWIcexXLNNQDUd9XApnQ13Be
	4ka22gQXJxb+o+yiQi989nec5x5yBi9U0dUOkZhwtvPOQSd0JwqX4+8vDkbEKHsiR1Zpx/xj1mgvO
	ybDueUXkwFYEjqPIM+9OGuVJyY5htRFOJb8i/1+TIm60GmJfzM47jmsxJEVuw1bvl7J3GR2toD//j
	Tyq1rYhrvvMwfuttvlz9ekxhi1dxOVjhhGb0fn0JhfAQV7jweBhB9Lkvg1Yhtj08dJhBZMuZb+It4
	85KVwMeYBQvry8vEwQmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj56y-0000T7-0b; Mon, 14 Jan 2019 16:29:16 +0000
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj56u-0000SU-9U
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 16:29:13 +0000
Received: by mail-qt1-x843.google.com with SMTP id k12so27166065qtf.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 08:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=A5cQcWgbQjYFw544uutW3MxtIejCvx84mGC5rsDJ3Uo=;
 b=Jdn17jXhi5/Cb6MK2/K85r7Tc0CfKsJZgI/IyqenXtjyT7I1liyDG5P0lYQLaXshSX
 8fM6j+jIg4LXs4aP6HvhyexqvoeLF1IwFwAmRBnrsgVLY+NoY70whcaTx18GJrHth3bi
 X2CdXlaX9eEmpLzviWdyuGf+3hyqiO9MQUMfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=A5cQcWgbQjYFw544uutW3MxtIejCvx84mGC5rsDJ3Uo=;
 b=QzV+mdXZtVmjMkYjyd5IH/1OSo8e9tGigZyFUik0uNXa+VSZlH9Vq7c6wDqGfAnjlm
 QwH73n/6/NC2Exn01cmkZ6dH8FFSRjGftOOHMtbW5LWwjmh5TpS8yHEOU3OBIi+Y0GJL
 NDp5SALhbgWXB+98yERZkuMucUgcP8UX5nFNHYxrBC3ARwQ3xom571AIA8he5ZAdGPq6
 0qnM337md4LMfo9tNQ8J0P2nsa2txxxiszbUvNxfVFuKm6B2y3Y+wyoUQDHsSOlQFWpj
 0bX1O1B7IubCJPullzV3DsG7K/iAi00M3vCmjHwLhxSGAnOFJno6ApECFsEPqi7a6+Zv
 3blQ==
X-Gm-Message-State: AJcUukciUFSvdZy4zmf+0f1NVZB6p8X1V4q7DKeO34asIwQ9R6uoCKh2
 79KecLKarZrNvrsZLMjsrKm2QQ==
X-Google-Smtp-Source: ALg8bN5azjlcexe1pAxWtCK01n9/B3FewGfDUYqJy+A14m052i2QnO5+vn3UPSWta1b4A+qKBKmuIg==
X-Received: by 2002:ac8:60cb:: with SMTP id i11mr24962694qtm.360.1547483350790; 
 Mon, 14 Jan 2019 08:29:10 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca.
 [70.82.104.228])
 by smtp.gmail.com with ESMTPSA id l95sm7311992qkh.37.2019.01.14.08.29.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 14 Jan 2019 08:29:09 -0800 (PST)
Date: Mon, 14 Jan 2019 11:29:07 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 07/11] mmc: mvsdio: handle highmem pages
In-Reply-To: <20190114095804.27978-8-hch@lst.de>
Message-ID: <nycvar.YSQ.7.76.1901141107030.4477@knanqh.ubzr>
References: <20190114095804.27978-1-hch@lst.de>
 <20190114095804.27978-8-hch@lst.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_082912_327447_191C01BA 
X-CRM114-Status: GOOD (  20.06  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 14 Jan 2019, Christoph Hellwig wrote:

> Instead of setting up a kernel pointer to track the current PIO address,
> track the offset in the current page, and do an atomic kmap for the page
> while doing the actual PIO operations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Just a small suggestion below


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
>  	unsigned int intr_en;
>  	unsigned int ctrl;
>  	unsigned int pio_size;
> -	void *pio_ptr;
> +	struct scatterlist *pio_sg;
> +	unsigned int pio_offset; /* offset in words into the segment */
>  	unsigned int sg_frags;
>  	unsigned int ns_per_clk;
>  	unsigned int clock;
> @@ -96,9 +98,9 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
>  	if (tmout_index > MVSD_HOST_CTRL_TMOUT_MAX)
>  		tmout_index = MVSD_HOST_CTRL_TMOUT_MAX;
>  
> -	dev_dbg(host->dev, "data %s at 0x%08x: blocks=%d blksz=%d tmout=%u (%d)\n",
> +	dev_dbg(host->dev, "data %s at 0x%08llx: blocks=%d blksz=%d tmout=%u (%d)\n",
>  		(data->flags & MMC_DATA_READ) ? "read" : "write",
> -		(u32)sg_virt(data->sg), data->blocks, data->blksz,
> +		(u64)sg_phys(data->sg), data->blocks, data->blksz,
>  		tmout, tmout_index);
>  
>  	host->ctrl &= ~MVSD_HOST_CTRL_TMOUT_MASK;
> @@ -118,10 +120,11 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
>  		 * boundary.
>  		 */
>  		host->pio_size = data->blocks * data->blksz;
> -		host->pio_ptr = sg_virt(data->sg);
> +		host->pio_sg = data->sg;
> +		host->pio_offset = data->sg->offset / 2;
>  		if (!nodma)
> -			dev_dbg(host->dev, "fallback to PIO for data at 0x%p size %d\n",
> -				host->pio_ptr, host->pio_size);
> +			dev_dbg(host->dev, "fallback to PIO for data at 0x%x size %d\n",
> +				host->pio_offset, host->pio_size);
>  		return 1;
>  	} else {
>  		dma_addr_t phys_addr;
> @@ -291,8 +294,9 @@ static u32 mvsd_finish_data(struct mvsd_host *host, struct mmc_data *data,
>  {
>  	void __iomem *iobase = host->base;
>  
> -	if (host->pio_ptr) {
> -		host->pio_ptr = NULL;
> +	if (host->pio_sg) {
> +		host->pio_sg = NULL;
> +		host->pio_offset = 0;
>  		host->pio_size = 0;
>  	} else {
>  		dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_frags,
> @@ -376,11 +380,12 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
>  	if (host->pio_size &&
>  	    (intr_status & host->intr_en &
>  	     (MVSD_NOR_RX_READY | MVSD_NOR_RX_FIFO_8W))) {
> -		u16 *p = host->pio_ptr;
> +		u16 *p = kmap_atomic(sg_page(host->pio_sg));
> +		unsigned int o = host->pio_offset;

To minimize code change, you could do:

		u16 *p0 = kmap_atomic(sg_page(host->pio_sg));
		u16 *p = p0 + host->pio_offset;

and at the end:

		host->pio_offset = p - p0;

leaving the middle code unchanged.

This might also produce slightly better assembly with the post increment 
instructions on ARM if the compiler doesn't figure it out on its own 
otherwise.


Nicolas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
