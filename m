Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D953FC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:08:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A56EB20645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U2Us3Bun";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="imKZ1Zqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56EB20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PkdKJpicm3uGAs3w1bFLwA5FcUfMd0VcfgUbA7QMPoU=; b=U2Us3Bun6Y7q1p
	Sr+6B9Oye9X6qHgN1Yi+CpdRbmmYi6gJjZR1PtruZgT3nT5jhP8C/pBevwsbaYLaA1RPaJ0kTgBch
	+fFXAZPdYsC2n4PwwqczR41tBcgGNqqV3MhA42YtVS6ZXVSFKwVZTWzJjv1CxATi44vbfQFqKJSio
	S+PAMOkhnIRm7C7DTWqBvhQ+maOO6qx2qm6pLTY9BaHs/zVNHu8I+PYk5RxkywM0zsEhla5zwmQ3H
	n19gmKzm0x1cxckRuUzsor0DJyHDs4qh/4yF04vg+1Y25dVfzdQyvjCG1CM+Jzp6oD/3b9BAQ5cfd
	rPYypyCCKjA+GCK9MVRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYnwk-00005l-Ma; Mon, 17 Dec 2018 08:08:14 +0000
Received: from mail-vk1-xa44.google.com ([2607:f8b0:4864:20::a44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYnwh-0008VX-Va
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 08:08:13 +0000
Received: by mail-vk1-xa44.google.com with SMTP id s184so990989vkd.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 00:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zRudsPkD624ydGN1AtgJCA7dack5snQUWwrQZeL/gLM=;
 b=imKZ1ZqdFXKPmSY0L6m2rr82pMf6RKNK2t3m1M4u2PpQsSWshH0Cxu/yss4s+w6WEB
 5m/iBDYVenjEiAx3ofNn+OsEfxKuCA0rhFddN4cBQMTHrtKFPsECzNqneWyyHjLRtHgt
 mJnB3JU+7xPojct3hklS7m5jgrr8oI170WqPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zRudsPkD624ydGN1AtgJCA7dack5snQUWwrQZeL/gLM=;
 b=VBW12PNtiFk/HNGqq7Y9ulf29BMuNioKRu9vtrNCYp6lfQ9DLt+5g9CInrjSL7YJfW
 PivdNB84MBoiV3U2ZFjZE49aERebV3I4ZuB3kXcGqIEAbHP1RuVS8IeJBjH321vG9d6+
 iDkoCUrt08vzPEBpKQ0pLAPYtdHeiteNa9hOqnOSasbatqF/NgSasc0cppZRzlkqlDoJ
 aP2vKxJUDfkTN9R7IR0rQHwyeXt6uDBDxPPMOOWpOpuKLg1wB9hNtxDI6+yK20UHsWGz
 50yEpBH8W47USG1CrqpXCnULXpGcvNce7j2NNwAxM3SIAOK3mXaMi22VDTeV061FcgH/
 TxVA==
X-Gm-Message-State: AA+aEWZNZGcljOMIB8AwF2U+DBqyMNO4lmN4zxiNZzGkJgOA2x5fAtGu
 ear2BWSBHfWPb8nQfrgHzJRUBqoMQDBZamZ7GPYRbQ==
X-Google-Smtp-Source: AFSGD/VHxei83MY2ghft0RsLDjRokq9N70gfYJBuDfqO8cmUfOhBDuZ9E9PzQjRu0VJm7/UzihtiWNPIYFwL6ToLark=
X-Received: by 2002:a1f:298e:: with SMTP id p136mr3210067vkp.40.1545034080450; 
 Mon, 17 Dec 2018 00:08:00 -0800 (PST)
MIME-Version: 1.0
References: <E1gWjE3-0006mG-2S@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1gWjE3-0006mG-2S@rmk-PC.armlinux.org.uk>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 17 Dec 2018 09:07:24 +0100
Message-ID: <CAPDyKFo3W4Bwe6oVXUQdZvZaMgvmXGK5+hAD8wVfLyEcU4JGvw@mail.gmail.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: fix DMA API warning
To: Russell King <rmk+kernel@armlinux.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_000812_016373_6A2E4DDD 
X-CRM114-Status: GOOD (  20.84  )
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>,
 linux-omap <linux-omap@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 11 Dec 2018 at 15:41, Russell King <rmk+kernel@armlinux.org.uk> wrote:
>
> While booting with rootfs on MMC, the following warning is encountered
> on OMAP4430:
>
> omap-dma-engine 4a056000.dma-controller: DMA-API: mapping sg segment longer than device claims to support [len=69632] [max=65536]
>
> This is because the DMA engine has a default maximum segment size of 64K
> but HSMMC sets:
>
>         mmc->max_blk_size = 512;       /* Block Length at max can be 1024 */
>         mmc->max_blk_count = 0xFFFF;    /* No. of Blocks is 16 bits */
>         mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
>         mmc->max_seg_size = mmc->max_req_size;
>
> which ends up telling the block layer that we support a maximum segment
> size of 65535*512, which exceeds the advertised DMA engine capabilities.
>
> Fix this by clamping the maximum segment size to the lower of the
> maximum request size and of the DMA engine device used for either DMA
> channel.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

I have applied this for fixes, amending the change by modifying the
min-min check to min3 according to the suggestion from Tony.
I assumed adding a stable tag makes sense so I did, however, please
tell if you want me to drop that.

Thanks and kind regards
Uffe


> ---
>  drivers/mmc/host/omap_hsmmc.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 467d889a1638..55100974fb95 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1909,7 +1909,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>         mmc->max_blk_size = 512;       /* Block Length at max can be 1024 */
>         mmc->max_blk_count = 0xFFFF;    /* No. of Blocks is 16 bits */
>         mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
> -       mmc->max_seg_size = mmc->max_req_size;
>
>         mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
>                      MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_ERASE | MMC_CAP_CMD23;
> @@ -1939,6 +1938,17 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>                 goto err_irq;
>         }
>
> +       /*
> +        * Limit the maximum segment size to the lower of the request size
> +        * and the DMA engine device segment size limits.  In reality, with
> +        * 32-bit transfers, the DMA engine can do longer segments than this
> +        * but there is no way to represent that in the DMA model - if we
> +        * increase this figure here, we get warnings from the DMA API debug.
> +        */
> +       mmc->max_seg_size = min(mmc->max_req_size,
> +                               min(dma_get_max_seg_size(host->rx_chan->device->dev),
> +                                   dma_get_max_seg_size(host->tx_chan->device->dev)));
> +
>         /* Request IRQ for MMC operations */
>         ret = devm_request_irq(&pdev->dev, host->irq, omap_hsmmc_irq, 0,
>                         mmc_hostname(mmc), host);
> --
> 2.7.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
