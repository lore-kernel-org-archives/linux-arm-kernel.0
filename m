Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B592C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:12:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3829B20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ubrUvM65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3829B20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BBx9Q4nhmASJS/ljX8lv5Rv/J7rDgyh4AFm+mXH2aZU=; b=ubrUvM651F35Ft
	pQuWfiuFKDzyyqrfxr290WFwCXLXne8qldaBWqjfF1D8I2QM0JyJbQ4IC6jCHtuVl372RRXLpyD4s
	MtaINM4o1ye9a9FLIJ9+4ovrm32ujNcf+GyIqiDdxTl0J25wRTV9g/eMz2qHyOJUStBRjwhFJ8GI6
	gevtm3mhPwR5ZEuHME2ZsG4gKyLiPFoi2I2dwMUKBh7325zlMvQkumCa1nhDe9clAo9zdtiJOexCa
	aZT0vrYFGF00MVTDyghkm9m8xc3TVJJyfFZdYJnsYexZ+kRGk6ztO+tEkH1+lB7S7y6jnokEPCIoJ
	v12/ISpN3C5LVvpLCo1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWgtP-0003B0-4d; Tue, 11 Dec 2018 12:12:03 +0000
Received: from [1.203.163.81] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWgtJ-000397-Nu; Tue, 11 Dec 2018 12:12:00 +0000
X-UUID: 0a659e8873b746a8a8d39f704cef2cb3-20181211
X-UUID: 0a659e8873b746a8a8d39f704cef2cb3-20181211
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
 (envelope-from <jjian.zhou@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 418914162; Tue, 11 Dec 2018 20:11:35 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Tue, 11 Dec 2018 20:11:34 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 11 Dec 2018 20:11:33 +0800
Message-ID: <1544530293.29734.30.camel@mhfsdcap03>
Subject: Re: [PATCH v3] mmc: mediatek: Add MMC_CAP_SDIO_IRQ support
From: Jjian Zhou <jjian.zhou@mediatek.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Dec 2018 20:11:33 +0800
In-Reply-To: <CAPDyKFq2xH2m4JTbOwbh38mqjbwLRNewuYEVyOKCsBAPrUm9Dg@mail.gmail.com>
References: <1544442233-20303-1-git-send-email-jjian.zhou@mediatek.com>
 <CAPDyKFq2xH2m4JTbOwbh38mqjbwLRNewuYEVyOKCsBAPrUm9Dg@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_041158_785953_D4889C2C 
X-CRM114-Status: GOOD (  24.44  )
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
Cc: Ryder Lee =?UTF-8?Q?=28=E6=9D=8E=E5=BA=9A=E8=AB=BA=29?=
 <Ryder.Lee@mediatek.com>, srv_heupstream <srv_heupstream@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Yong Mao =?UTF-8?Q?=28=E6=AF=9B=E5=8B=87=29?= <yong.mao@mediatek.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Chaotian Jing =?UTF-8?Q?=28=E4=BA=95=E6=9C=9D=E5=A4=A9=29?=
 <Chaotian.Jing@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2018-12-11 at 17:29 +0800, Ulf Hansson wrote:
> On Mon, 10 Dec 2018 at 12:44, Jjian Zhou <jjian.zhou@mediatek.com> wrote:
> >
> > From: jjian zhou <jjian.zhou@mediatek.com>
> >
> > This patch enables support SDIO IRQs. It enables
> > MMC_CAP_SDIO_IRQ & MMC_CAP2_SDIO_IRQ_NOTHREAD
> > and implement the ->ack_sdio_irq callback.
> >
> > Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
> > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> > Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> > ---
> >  drivers/mmc/host/mtk-sd.c | 49 ++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 46 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > index 6334cc7..40a1848 100644
> > --- a/drivers/mmc/host/mtk-sd.c
> > +++ b/drivers/mmc/host/mtk-sd.c
> > @@ -1114,6 +1114,7 @@ static void msdc_start_command(struct msdc_host *host,
> >                 struct mmc_request *mrq, struct mmc_command *cmd)
> >  {
> >         u32 rawcmd;
> > +       unsigned long flags;
> >
> >         WARN_ON(host->cmd);
> >         host->cmd = cmd;
> > @@ -1131,7 +1132,10 @@ static void msdc_start_command(struct msdc_host *host,
> >         cmd->error = 0;
> >         rawcmd = msdc_cmd_prepare_raw_cmd(host, mrq, cmd);
> >
> > +       spin_lock_irqsave(&host->lock, flags);
> >         sdr_set_bits(host->base + MSDC_INTEN, cmd_ints_mask);
> > +       spin_unlock_irqrestore(&host->lock, flags);
> > +
> 
> The above looks like a reasonable change, however does it really
> belong in $subject patch. If so, can you explain why?
> 
> Maybe you should move this into a standalone separate patch?
> 

Thanks for your suggestion.

The modification of MSDC_INTEN is non-atomic operation. If it enanbles
MMC_CAP_SDIO_IRQ, there is a race condition of access MSDC_INTEN in irq
and thread context. So need make modification of MSDC_INTEN by atomic.

> >         writel(cmd->arg, host->base + SDC_ARG);
> >         writel(rawcmd, host->base + SDC_CMD);
> >  }
> > @@ -1351,6 +1355,27 @@ static void msdc_request_timeout(struct work_struct *work)
> >         }
> >  }
> >
> > +static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
> > +{
> > +       unsigned long flags;
> > +       struct msdc_host *host = mmc_priv(mmc);
> > +
> > +       if (enb)
> > +               pm_runtime_get_sync(host->dev);
> 
> I would convert to pm_runtime_get_noresume() as the host is already
> been runtime resumed by the mmc core.

will do it in next version.

> > +
> > +       spin_lock_irqsave(&host->lock, flags);
> > +       if (enb)
> > +               sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> > +       else
> > +               sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> > +       spin_unlock_irqrestore(&host->lock, flags);
> 
> You should move the code above into a separate function. Along the lines of:
> 
> static void __msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
> 
> You need this, because you will otherwise mess up the runtime PM usage
> count when acking the SDIO irq. More comments about that below.

will do it in next version.

> > +
> > +       if (!enb) {
> > +               pm_runtime_mark_lastwill do it in next version._busy(host->dev);
> > +               pm_runtime_put_autosuspend(host->dev);
> 
> Convert to pm_runtime_put_noidle(), as the above is already managed by
> the mmc core.
> 

will do it in next version.

> > +       }
> > +}
> > +
> >  static irqreturn_t msdc_irq(int irq, void *dev_id)
> >  {
> >         struct msdc_host *host = (struct msdc_host *) dev_id;
> > @@ -1373,7 +1398,12 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
> >                 data = host->data;
> >                 spin_unlock_irqrestore(&host->lock, flags);
> >
> > -               if (!(events & event_mask))
> > +               if ((events & event_mask) & MSDC_INT_SDIOIRQ) {
> > +                       msdc_enable_sdio_irq(host->mmc, 0);
> 
> To not mess up the runtime PM reference count and to avoid invoking
> runtime PM callbacks from atomic context, I suggest you call
> __msdc_enable_sdio_irq(host->mmc, 0) (new proposed function according
> to earlier comment).

will do it in next version.

> 
> > +                       sdio_signal_irq(host->mmc);
> > +               }
> > +
> > +               if (!(events & (event_mask & ~MSDC_INT_SDIOIRQ)))
> >                         break;
> >
> >                 if (!mrq) {
> > @@ -1493,8 +1523,11 @@ static void msdc_init_hw(struct msdc_host *host)
> >          */
> >         sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIO);
> >
> > -       /* disable detect SDIO device interrupt function */
> > -       sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> > +       /* Config SDIO device detect interrupt function */
> > +       if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
> > +               sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> > +       else
> > +               sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> >
> >         /* Configure to default data timeout */
> >         sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
> > @@ -2013,6 +2046,11 @@ static void msdc_hw_reset(struct mmc_host *mmc)
> >         sdr_clr_bits(host->base + EMMC_IOCON, 1);
> >  }
> >
> > +static void msdc_ack_sdio_irq(struct mmc_host *mmc)
> > +{
> > +       msdc_enable_sdio_irq(mmc, 1);
> 
> To not mess up the runtime PM reference count, I suggest you call
> __msdc_enable_sdio_irq(host->mmc, 1) (new proposed function according
> to earlier comment).
> 

will do it in next version.

> > +}
> > +
> >  static const struct mmc_host_ops mt_msdc_ops = {
> >         .post_req = msdc_post_req,
> >         .pre_req = msdc_pre_req,
> > @@ -2020,6 +2058,8 @@ static void msdc_hw_reset(struct mmc_host *mmc)
> >         .set_ios = msdc_ops_set_ios,
> >         .get_ro = mmc_gpio_get_ro,
> >         .get_cd = mmc_gpio_get_cd,
> > +       .enable_sdio_irq = msdc_enable_sdio_irq,
> > +       .ack_sdio_irq = msdc_ack_sdio_irq,
> >         .start_signal_voltage_switch = msdc_ops_switch_volt,
> >         .card_busy = msdc_card_busy,
> >         .execute_tuning = msdc_execute_tuning,
> > @@ -2147,6 +2187,9 @@ static int msdc_drv_probe(struct platform_device *pdev)
> >         else
> >                 mmc->f_min = DIV_ROUND_UP(host->src_clk_freq, 4 * 4095);
> >
> > +       if (mmc->caps & MMC_CAP_SDIO_IRQ)
> > +               mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
> > +
> >         mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
> >         /* MMC core transfer sizes tunable parameters */
> >         mmc->max_segs = MAX_BD_NUM;
> > --
> > 1.9.1
> >
> 
> Kind regards
> Uffe



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
