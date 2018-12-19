Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D60C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:19:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B11321850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FWUODdmc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eVjCaFqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B11321850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZsiwGxu70CNpQwjMgBSd4+l34cX6+7qOOoFa9awtMLY=; b=FWUODdmce0wqlF
	2BlsCARGqarO3Ptp87pOHfRRvQrFJWpTP2zfo3wdKsQu1jNjkfw1MO4Oae7dBgqaQKJsNU6t0F8rm
	mWEQpvJDc4uG7gSm9T06X7T3myE+Yzyxe7RkwTkZJi9b7He9UyJKg3DmlrhON9LUP8Fff4pyLIGQT
	7K9kznLVugi698Y3JO+mUKqwd0nnF3WjSliXADscWXaDh/cikoWTco+zV1MD8kVUrqvqyDrWBnxRF
	+hiDw1vcR5/7nqKrZc5TawHKxb3nIJ61nkRXqTFKekmrtxTwRFtmkSG1sRPfAO6SmqegE/aNuDnaM
	0euWqLDd2dx4+O515bLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZY0M-00024l-9a; Wed, 19 Dec 2018 09:19:02 +0000
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZY0H-00022l-BN
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 09:18:58 +0000
Received: by mail-vs1-xe42.google.com with SMTP id n10so11760530vso.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 01:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FSVOxWjXIUXef9Dklx0hH0r/WZbFPxfM5408rI07BrY=;
 b=eVjCaFqTJ8w/XBYhLHUmw1J5FvUpAY5NNZM6dsZqEAUgVZLVOJ0e1yFD7VM+xplMkW
 nf38yoWaXK+S/OXHdOGlTP8YntFkMcymw69yi2t74Y4R+NNCO4+3VKOrXsc/tyC2p/ex
 /bWSn2fo9gy/Ge07YKyvf+tqhjNbqsW/SlRK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FSVOxWjXIUXef9Dklx0hH0r/WZbFPxfM5408rI07BrY=;
 b=gwW6X6m3Fs8jPq+v3Z1rVDHAqe2pcUIVEgOt5Jpk+qY3btABzQO+F5kVz3s4BQIC2M
 0jP1UUvsx65YN/q3QnNm/1P3dfIuU60YGQiGeq/e4Jfz54NbU/wvC5bIzeJKuf8l9Ade
 PTwC7kDZuX3drzfCWdl1aqvkavN5XYH+MVVwv+TPyEV76vhiXHYrz8LiclRyI/I2dgpn
 ILhmuf0xpu7kjXtaMVC6920ImX5LnMOngkrx6EwaAUvcYR0YSGuZmanYRA1HQKWWsGzG
 0Xx7D/Dw2AuBdvuzkqFtWAopTKca/sJEGLuvNht8J2o+C0kw3kdTG4XWOD/tbX/+lV7N
 52CQ==
X-Gm-Message-State: AA+aEWbK9UnzWALKqMKttCMlPsmg0WNqQZGZdIK0O+Et0mwHVeXfAf/b
 GY2LTjbt47nxKYX9lU7foM18TDJPBgIQvOrbRVfdHA==
X-Google-Smtp-Source: AFSGD/Vq3ftIQg45Dq5PZEKSkdqk6S5f/h59JZEaOR1FSiADKNeQs8GmU3yKlCrl9bR6ogxM5IBeRNOp08mNloWfsKw=
X-Received: by 2002:a67:7685:: with SMTP id r127mr9725315vsc.35.1545211122817; 
 Wed, 19 Dec 2018 01:18:42 -0800 (PST)
MIME-Version: 1.0
References: <1545136398-5066-1-git-send-email-jjian.zhou@mediatek.com>
In-Reply-To: <1545136398-5066-1-git-send-email-jjian.zhou@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 19 Dec 2018 10:18:06 +0100
Message-ID: <CAPDyKFr+TYXCEDtsdXQ5tLNqDv1yx2zPh+yiURmq_wji9q4cAg@mail.gmail.com>
Subject: Re: [v4] mmc: mediatek: Add MMC_CAP_SDIO_IRQ support
To: Jjian Zhou <jjian.zhou@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_011857_391695_DCE27FEF 
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
Cc: Ryder Lee <ryder.lee@mediatek.com>,
 srv_heupstream <srv_heupstream@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Yong Mao <yong.mao@mediatek.com>, linux-mediatek@lists.infradead.org,
 Chaotian Jing <chaotian.jing@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 18 Dec 2018 at 13:33, Jjian Zhou <jjian.zhou@mediatek.com> wrote:
>
> From: jjian zhou <jjian.zhou@mediatek.com>
>
> This patch enables support SDIO IRQs. It enables
> MMC_CAP_SDIO_IRQ & MMC_CAP2_SDIO_IRQ_NOTHREAD
> and implement the ->ack_sdio_irq callback.
>
> Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 53 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 50 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 6334cc7..8afeaf8 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1114,6 +1114,7 @@ static void msdc_start_command(struct msdc_host *host,
>                 struct mmc_request *mrq, struct mmc_command *cmd)
>  {
>         u32 rawcmd;
> +       unsigned long flags;
>
>         WARN_ON(host->cmd);
>         host->cmd = cmd;
> @@ -1131,7 +1132,10 @@ static void msdc_start_command(struct msdc_host *host,
>         cmd->error = 0;
>         rawcmd = msdc_cmd_prepare_raw_cmd(host, mrq, cmd);
>
> +       spin_lock_irqsave(&host->lock, flags);
>         sdr_set_bits(host->base + MSDC_INTEN, cmd_ints_mask);
> +       spin_unlock_irqrestore(&host->lock, flags);
> +
>         writel(cmd->arg, host->base + SDC_ARG);
>         writel(rawcmd, host->base + SDC_CMD);
>  }
> @@ -1351,6 +1355,31 @@ static void msdc_request_timeout(struct work_struct *work)
>         }
>  }
>
> +static void __msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
> +{
> +       unsigned long flags;
> +       struct msdc_host *host = mmc_priv(mmc);
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +       if (enb)
> +               sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> +       else
> +               sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> +       spin_unlock_irqrestore(&host->lock, flags);
> +}
> +
> +static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
> +{
> +       struct msdc_host *host = mmc_priv(mmc);
> +
> +       __msdc_enable_sdio_irq(mmc, enb);
> +
> +       if (enb)
> +               pm_runtime_get_noresume(host->dev);
> +       else
> +               pm_runtime_put_noidle(host->dev);
> +}
> +
>  static irqreturn_t msdc_irq(int irq, void *dev_id)
>  {
>         struct msdc_host *host = (struct msdc_host *) dev_id;
> @@ -1373,7 +1402,12 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
>                 data = host->data;
>                 spin_unlock_irqrestore(&host->lock, flags);
>
> -               if (!(events & event_mask))
> +               if ((events & event_mask) & MSDC_INT_SDIOIRQ) {
> +                       __msdc_enable_sdio_irq(host->mmc, 0);
> +                       sdio_signal_irq(host->mmc);
> +               }
> +
> +               if (!(events & (event_mask & ~MSDC_INT_SDIOIRQ)))
>                         break;
>
>                 if (!mrq) {
> @@ -1493,8 +1527,11 @@ static void msdc_init_hw(struct msdc_host *host)
>          */
>         sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIO);
>
> -       /* disable detect SDIO device interrupt function */
> -       sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> +       /* Config SDIO device detect interrupt function */
> +       if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
> +               sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> +       else
> +               sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
>
>         /* Configure to default data timeout */
>         sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
> @@ -2013,6 +2050,11 @@ static void msdc_hw_reset(struct mmc_host *mmc)
>         sdr_clr_bits(host->base + EMMC_IOCON, 1);
>  }
>
> +static void msdc_ack_sdio_irq(struct mmc_host *mmc)
> +{
> +       __msdc_enable_sdio_irq(mmc, 1);
> +}
> +
>  static const struct mmc_host_ops mt_msdc_ops = {
>         .post_req = msdc_post_req,
>         .pre_req = msdc_pre_req,
> @@ -2020,6 +2062,8 @@ static void msdc_hw_reset(struct mmc_host *mmc)
>         .set_ios = msdc_ops_set_ios,
>         .get_ro = mmc_gpio_get_ro,
>         .get_cd = mmc_gpio_get_cd,
> +       .enable_sdio_irq = msdc_enable_sdio_irq,
> +       .ack_sdio_irq = msdc_ack_sdio_irq,
>         .start_signal_voltage_switch = msdc_ops_switch_volt,
>         .card_busy = msdc_card_busy,
>         .execute_tuning = msdc_execute_tuning,
> @@ -2147,6 +2191,9 @@ static int msdc_drv_probe(struct platform_device *pdev)
>         else
>                 mmc->f_min = DIV_ROUND_UP(host->src_clk_freq, 4 * 4095);
>
> +       if (mmc->caps & MMC_CAP_SDIO_IRQ)
> +               mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
> +
>         mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
>         /* MMC core transfer sizes tunable parameters */
>         mmc->max_segs = MAX_BD_NUM;
> --
> 1.9.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
