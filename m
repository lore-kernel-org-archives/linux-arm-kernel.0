Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8B0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:10:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F28D206DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TEgTxBZw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/G0VnGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F28D206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pAgbFa7BXFB7hsi+SGE4TpCEQNncDwI3nDULhFXJ0wc=; b=TEgTxBZwRgzT+Z
	GR4/PDRo1w0IXctZBUccJuTfGJ85/pmB8Yx7E+Ce1Y+n1ragSW0TzfZ+fzCMSmxQMFeRxC7AYug5s
	xJXaoGvHIy0mEO/0PuBMlKNSs0NepOqDgyPY4n9qldIbcOCZhDlnfUMkMLZlnPWqcx3P06YMmqsRa
	iSzZXYqzdVM98YGQUTh74I1OkuHe9DaHRVgLUTPF3zN/NWqz8GBjcBpJNkrH1K+H9sO4zQEneEBq3
	YhAwdju2BtW04Ij7m0m9tsRQqYNQTqKTqEltmC+eZ3iDN3rhH2wvLnS0tQNbbt8tb0zAEEIgkDIUt
	o7ToN3y0iP5IAecs7ZDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXtmj-0007pG-ST; Fri, 14 Dec 2018 20:10:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXtme-00076i-Kk; Fri, 14 Dec 2018 20:10:06 +0000
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0CBA1208C4;
 Fri, 14 Dec 2018 20:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544818194;
 bh=XJgQzR3ZuSSBmzMXoqeCemRPq20xFFciHq8cMSZxqvY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=k/G0VnGivNugGFTK46tLBqoFooAi0gaCPLaIg0BaMhGkRnFZNMTMOT5dhniImwQL/
 7we/VDx4XUMyulP7Pdj4XKNBTL0Kb+Be/FyDtTJh2ClYjr9VmXb/mN3+fXW8qc+2As
 PCeY3AkkIswJFB20ESdHQ9XbyJaciZdxJyRkttUc=
Received: by mail-wm1-f51.google.com with SMTP id n190so6840212wmd.0;
 Fri, 14 Dec 2018 12:09:53 -0800 (PST)
X-Gm-Message-State: AA+aEWaDVfhDnHqwLoTGk1ZSXY9PgKH9VItjUH8TgFPEnMJV5lkcwwKP
 CqZFNGejgKdvQ4qlnNKBcQk9T9C3K3YrndnV1d8=
X-Google-Smtp-Source: AFSGD/UvdxuQk4NnzosyRYSoJf3S4ozLshv2aa6WrQOGEmEHLSMmdcvSaaz2chAXWKtD5ym1VUvZKZZq9X2NwKmD0XE=
X-Received: by 2002:a1c:5dce:: with SMTP id r197mr4082332wmb.130.1544818191613; 
 Fri, 14 Dec 2018 12:09:51 -0800 (PST)
MIME-Version: 1.0
References: <1544506645-27979-1-git-send-email-long.cheng@mediatek.com>
 <1544506645-27979-2-git-send-email-long.cheng@mediatek.com>
 <CAGp9LzqB=hzkOHZqa-ZzRLcJujU--7gxYZczXiEj3DiH+FmhbQ@mail.gmail.com>
 <1544700985.28871.26.camel@mhfsdcap03>
In-Reply-To: <1544700985.28871.26.camel@mhfsdcap03>
From: Sean Wang <sean.wang@kernel.org>
Date: Fri, 14 Dec 2018 12:09:15 -0800
X-Gmail-Original-Message-ID: <CAGp9LzpGfVgjL9MMQyh2iZRD9bJiuH0B0GTg_bahaa5ju2wmzw@mail.gmail.com>
Message-ID: <CAGp9LzpGfVgjL9MMQyh2iZRD9bJiuH0B0GTg_bahaa5ju2wmzw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dmaengine: 8250_mtk_dma: add Mediatek uart DMA
 support
To: long.cheng@mediatek.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_121004_739511_DE8AF23D 
X-CRM114-Status: GOOD (  36.06  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 =?UTF-8?B?UnlkZXIgTGVlICjmnY7luproq7op?= <ryder.lee@mediatek.com>,
 srv_heupstream@mediatek.com, gregkh@linuxfoundation.org,
 =?UTF-8?B?U2VhbiBXYW5nICjnjovlv5fkupgp?= <sean.wang@mediatek.com>,
 linux-kernel@vger.kernel.org, YT Shen <yt.shen@mediatek.com>,
 dmaengine@vger.kernel.org, vkoul@kernel.org, robh+dt@kernel.org,
 linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
 jslaby@suse.com, Matthias Brugger <matthias.bgg@gmail.com>,
 yingjoe.chen@mediatek.com, dan.j.williams@intel.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 3:36 AM Long Cheng <long.cheng@mediatek.com> wrote:

Hope those comments did not get a response that means they're fine with you.

< ... >

> > > +struct mtk_dmadev {
> > > +       struct dma_device ddev;
> > > +       void __iomem *mem_base[MTK_APDMA_CHANNELS];
> > > +       spinlock_t lock; /* dma dev lock */
> > > +       struct tasklet_struct task;
> >
> > we can drop tasklet and instead allows descriptors to be handled as
> > fast as possible.
> > similar suggestions have been made in the other dmaengine [1] and mtk-hsdma.c
> >
>
> OK, i will remove these, and improve it.
>

Thanks, that would be great.

> > [1] https://lkml.org/lkml/2018/11/11/146
> >
> > > +       struct list_head pending;
> > > +       struct clk *clk;
> > > +       unsigned int dma_requests;
> > > +       bool support_33bits;
> > > +       unsigned int dma_irq[MTK_APDMA_CHANNELS];
> > > +       struct mtk_chan *ch[MTK_APDMA_CHANNELS];
> > > +};
> > > +

< ... >

> > > +static struct dma_async_tx_descriptor *mtk_dma_prep_slave_sg
> > > +       (struct dma_chan *chan, struct scatterlist *sgl,
> > > +       unsigned int sglen,     enum dma_transfer_direction dir,
> > > +       unsigned long tx_flags, void *context)
> > > +{
> > > +       struct mtk_chan *c = to_mtk_dma_chan(chan);
> > > +       struct scatterlist *sgent;
> > > +       struct mtk_dma_desc *d;
> > > +       struct mtk_dma_sg *sg;
> > > +       unsigned int size, i, j, en;
> > > +
> > > +       en = 1;
> > > +
> > > +       if ((dir != DMA_DEV_TO_MEM) &&
> > > +               (dir != DMA_MEM_TO_DEV)) {
> > > +               dev_err(chan->device->dev, "bad direction\n");
> > > +               return NULL;
> > > +       }
> > > +
> > > +       /* Now allocate and setup the descriptor. */
> > > +       d = kzalloc(sizeof(*d) + sglen * sizeof(d->sg[0]), GFP_ATOMIC);
> > > +       if (!d)
> > > +               return NULL;
> > > +
> > > +       d->dir = dir;
> > > +
> > > +       j = 0;
> > > +       for_each_sg(sgl, sgent, sglen, i) {
> > > +               d->sg[j].addr = sg_dma_address(sgent);
> > > +               d->sg[j].en = en;
> > > +               d->sg[j].fn = sg_dma_len(sgent) / en;
> > > +               j++;
> > > +       }
> > > +
> > > +       d->sglen = j;
> > > +
> > > +       if (dir == DMA_MEM_TO_DEV) {
> > > +               for (size = i = 0; i < d->sglen; i++) {
> > > +                       sg = &d->sg[i];
> > > +                       size += sg->en * sg->fn;
> > > +               }
> > > +               d->len = size;
> > > +       }
> > > +
> >
> > The driver always only handles data move for the single contiguous
> > area, but it seems the callback must provide the scatter-gather
> > function to the dmaegine. otherwise, why is the callback be called
> > device_prep_slave_sg?
> >
>
> because in 8250 UART native code, call the device_prep_slave_sg. we just
> use one ring buffer.
>

If it really did specifically for UART, you should show the function
only can handle only one entry in sg for the DMA in a few comments and
a sanity check for these invalid requests (more one entries in sg).
Otherwise, the hardware will get a failure and even function doesn't
complain or warn anything if more one entries in sg requested in.
Additionally, the code can be simplified much if it's just for the
specific use case.

> > > +       return vchan_tx_prep(&c->vc, &d->vd, tx_flags);
> > > +}
> > > +
> > > +static void mtk_dma_issue_pending(struct dma_chan *chan)
> > > +{
> > > +       struct mtk_chan *c = to_mtk_dma_chan(chan);
> > > +       struct virt_dma_desc *vd;
> > > +       struct mtk_dmadev *mtkd;
> > > +       unsigned long flags;
> > > +
> > > +       spin_lock_irqsave(&c->vc.lock, flags);
> > > +       if (c->cfg.direction == DMA_DEV_TO_MEM) {
> > > +               mtkd = to_mtk_dma_dev(chan->device);
> >
> > mtkd can be dropped as it seems no users
> >

< ... >

> > > +static int mtk_dma_slave_config(struct dma_chan *chan,
> > > +                               struct dma_slave_config *cfg)
> > > +{
> > > +       struct mtk_chan *c = to_mtk_dma_chan(chan);
> > > +       struct mtk_dmadev *mtkd = to_mtk_dma_dev(c->vc.chan.device);
> > > +       int ret;
> > > +
> > > +       c->cfg = *cfg;
> > > +
> > > +       if (cfg->direction == DMA_DEV_TO_MEM) {
> > > +               unsigned int rx_len = cfg->src_addr_width * 1024;
> >
> > it seems you should use cfg->src_port_window_size as the comments explains
> >
> > * @src_port_window_size: The length of the register area in words the data need
> >  * to be accessed on the device side. It is only used for devices which is using
> >  * an area instead of a single register to receive the data. Typically the DMA
> >  * loops in this area in order to transfer the data.
> >  * @dst_port_window_size: same as src_port_window_size but for the destination
> >  * port.
> >
>
> in 8250 UART native code, will set the parameter. if want to modify
> this, i think that maybe at next kernel release, we can modify it. i
> suggest that not modify it at this patch. because it relate of 8250 uart
> code. thanks.
>

You can fix it in the next version and a separate follow-up patch for
the client driver.

> > > +
> > > +               mtk_dma_chan_write(c, VFF_ADDR, cfg->src_addr);
> > > +               mtk_dma_chan_write(c, VFF_LEN, rx_len);
> > > +               mtk_dma_chan_write(c, VFF_THRE, VFF_RX_THRE(rx_len));
> > > +               mtk_dma_chan_write(c,
> > > +                                  VFF_INT_EN, VFF_RX_INT_EN0_B
> > > +                                  | VFF_RX_INT_EN1_B);
> > > +               mtk_dma_chan_write(c, VFF_INT_FLAG, VFF_RX_INT_FLAG_CLR_B);
> > > +               mtk_dma_chan_write(c, VFF_EN, VFF_EN_B);
> >
> > I'd prefer to move those channel interrupt enablement to
> > .device_alloc_chan_resources
> > and related disablement to .device_free_chan_resources
> >
>
> i think that, first need set the config to HW, and the enable the DMA.
>

I've read through the client driver and the dmaengine, I probably know
how interaction they work and find out there is something you seem
completely make a wrong.

You can't do enable DMA with enabling VFF here. That causes a big
problem, DMA would self decide to move data and not managed and issued
by the dmaengine framework. For instance in DMA Tx path, because you
enable the DMA and DMA  buffer (VFF) and UART Tx ring uses the same
memory area,  DMA would self start to move data once data from
userland go in Tx ring even without being issued by dmaengine.

Instead, you should ensure all descriptors are being batched by
.device_prep_slave_sg and DMA does not start moving data until
.device_issue_pending done and once descriptors are issued, DMA
hardware or software have to do it as fast as possible.

> > > +
> > > +               if (!c->requested) {
> > > +                       c->requested = true;
> > > +                       ret = request_irq(mtkd->dma_irq[chan->chan_id],
> > > +                                         mtk_dma_rx_interrupt,
> > > +                                         IRQF_TRIGGER_NONE,
> > > +                                         KBUILD_MODNAME, chan);
> >
> > ISR registration usually happens as the driver got probe, it can give
> > the system more flexibility to manage such IRQ affinity on the fly.
> >
>
> i will move the request irq to alloc channel.
>

why don't let it done in driver probe?

> > > +                       if (ret < 0) {
> > > +                               dev_err(chan->device->dev, "Can't request rx dma IRQ\n");
> > > +                               return -EINVAL;
> > > +                       }
> > > +               }
> > > +       } else if (cfg->direction == DMA_MEM_TO_DEV)    {
> > > +               unsigned int tx_len = cfg->dst_addr_width * 1024;
> >
> > Ditto as above, it seems you should use cfg->dst_port_window_size
> >
> > > +
> > > +               mtk_dma_chan_write(c, VFF_ADDR, cfg->dst_addr);
> > > +               mtk_dma_chan_write(c, VFF_LEN, tx_len);
> > > +               mtk_dma_chan_write(c, VFF_THRE, VFF_TX_THRE(tx_len));
> > > +               mtk_dma_chan_write(c, VFF_INT_FLAG, VFF_TX_INT_FLAG_CLR_B);
> > > +               mtk_dma_chan_write(c, VFF_EN, VFF_EN_B);
> >
> > ditto, I'd prefer to move those channel interrupt enablement to
> > .device_alloc_chan_resources and related disablement to
> > .device_free_chan_resources
> >
> > > +
> > > +               if (!c->requested) {
> > > +                       c->requested = true;
> > > +                       ret = request_irq(mtkd->dma_irq[chan->chan_id],
> > > +                                         mtk_dma_tx_interrupt,
> > > +                                         IRQF_TRIGGER_NONE,
> > > +                                         KBUILD_MODNAME, chan);
> >
> > ditto, we can request ISR with devm_request_irq in the driver got
> > probe and trim the c->request member
> >
> > > +                       if (ret < 0) {
> > > +                               dev_err(chan->device->dev, "Can't request tx dma IRQ\n");
> > > +                               return -EINVAL;
> > > +                       }
> > > +               }
> > > +       }
> > > +
> > > +       if (mtkd->support_33bits)
> > > +               mtk_dma_chan_write(c, VFF_4G_SUPPORT, VFF_4G_SUPPORT_B);
> > > +
> > > +       if (mtk_dma_chan_read(c, VFF_EN) != VFF_EN_B) {
> > > +               dev_err(chan->device->dev,
> > > +                       "config dma dir[%d] fail\n", cfg->direction);
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int mtk_dma_terminate_all(struct dma_chan *chan)
> > > +{
> > > +       struct mtk_chan *c = to_mtk_dma_chan(chan);
> > > +       unsigned long flags;
> > > +
> > > +       spin_lock_irqsave(&c->vc.lock, flags);
> > > +       list_del_init(&c->node);
> > > +       mtk_dma_stop(c);
> > > +       spin_unlock_irqrestore(&c->vc.lock, flags);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int mtk_dma_device_pause(struct dma_chan *chan)
> > > +{
> > > +       /* just for check caps pass */
> > > +       return -EINVAL;
> >
> > always return error code seems not the client driver wants us to do.
> >
> > maybe if the hardware doesn't support pause, we can make a software
> > pause, that waits until all active descriptors in hardware done, then
> > disable interrupt and then stop handling the following vd in the
> > vchan.
> >
> > > +}
>
> the code can't run. just for 8250 native code to check the function
> pointer. in the future, if the function useful, we can realize. thanks.
>

Always return an error code looks like it's a faked function just to
pass the criteria check. It seems not a good idea.

> > > +
> > > +static int mtk_dma_device_resume(struct dma_chan *chan)
> > > +{
> > > +       /* just for check caps pass */
> > > +       return -EINVAL;

< ... >

> > > +static struct platform_driver mtk_dma_driver = {
> >
> > mtk_dma is much general and all functions and structures in the driver
> > should be all consistent.  I'd prefer to have all naming starts with
> > mtk_uart_apdma.
> >
>
> the function name and parameters' name, i will modify it. but before the
> 8250_mtk.c and the Doc. are recorded. if modify file name and Kconfig,
> will bring about the disorder. i suggest that after the patch is
> recorded, modify this. thanks.
>

We can do it in separate patches and in a logical order for the
changes required across different subsystems.

> > > +       .probe  = mtk_apdma_probe,
> >
> > such  as
> > mtk_uart_apdma_probe
> >
> > > +       .remove = mtk_apdma_remove,
> >
> > mtk_uart_apdma_remove
> >
> > > +       .driver = {
> > > +               .name           = KBUILD_MODNAME,
> > > +               .pm             = &mtk_dma_pm_ops,
> >
> > mtk_uart_apdma_pm_ops
> >
> > > +               .of_match_table = of_match_ptr(mtk_uart_dma_match),
> >
> > mtk_uart_apdma_match
> >
> > > +       },
> > > +};
> > > +
> > > +module_platform_driver(mtk_dma_driver);
> >
> > mtk_uart_apdma_driver
> >
> > > +
> > > +MODULE_DESCRIPTION("MediaTek UART APDMA Controller Driver");
> > > +MODULE_AUTHOR("Long Cheng <long.cheng@mediatek.com>");
> > > +MODULE_LICENSE("GPL v2");
> > > +
> > > diff --git a/drivers/dma/mediatek/Kconfig b/drivers/dma/mediatek/Kconfig
> > > index 27bac0b..d399624 100644
> > > --- a/drivers/dma/mediatek/Kconfig
> > > +++ b/drivers/dma/mediatek/Kconfig
> > > @@ -1,4 +1,15 @@
> > >
> > > +config DMA_MTK_UART
> >
> > MTK_UART_APDMA to align the other drivers
> >
> > > +       tristate "MediaTek SoCs APDMA support for UART"
> > > +       depends on OF && SERIAL_8250_MT6577
> > > +       select DMA_ENGINE
> > > +       select DMA_VIRTUAL_CHANNELS
> > > +       help
> > > +         Support for the UART DMA engine found on MediaTek MTK SoCs.
> > > +         when 8250 mtk uart is enabled, and if you want to using DMA,
> >
> > 8250 mtk uart should be changed to SERIAL_8250_MT6577 to be more intuitive
> >
> > > +         you can enable the config. the DMA engine just only be used
> > > +         with MediaTek Socs.
> >
> > SoCs
> >
> > > +
> > >  config MTK_HSDMA
> > >         tristate "MediaTek High-Speed DMA controller support"
> > >         depends on ARCH_MEDIATEK || COMPILE_TEST
> > > diff --git a/drivers/dma/mediatek/Makefile b/drivers/dma/mediatek/Makefile
> > > index 6e778f8..2f2efd9 100644
> > > --- a/drivers/dma/mediatek/Makefile
> > > +++ b/drivers/dma/mediatek/Makefile
> > > @@ -1 +1,2 @@
> > > +obj-$(CONFIG_DMA_MTK_UART) += 8250_mtk_dma.o
> >
> > obj-$(CONFIG_MTK_UART_APDMA) += mtk-uart-apdma.o
> > to align the other dirvers
> >
> > >  obj-$(CONFIG_MTK_HSDMA) += mtk-hsdma.o
> > > --
> > > 1.7.9.5
> > >
>
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
