Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC03BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:57:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC2892133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rJ/H/ZjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2892133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tgFBtHw1P8D3aN7asopEm4OaQ949VzQYLsfnvDH6iLs=; b=rJ/H/ZjEw4wbpV
	MGT6Trb81e157fjrv0lEZCn4fl+cv3isMxDojnv3HInY40yDzzKJES1jggQliU6Vr0NkvgZSFTuKv
	HiX5fZ0P72Wjn9REN/+6UNwoqBwj2S/J39aLPVqHpEmww6m970l1Kxy8s3oNgdwCrLBgkMPC0Qlia
	XTKAE4GkpQ3007PZikwUW9iua7DgakC+5sw7aJ1DZPdr1/RLpEwjGz9MLGYWNqtwXOD19xczKUB1E
	icnmNtDvHRivPqzunCtgOt1i6PEHuZvna5sn+jGMemnLfH39lztKA4Mxr2QVjbkdXw0GZbvI+mMtP
	SFc1/OzHbO5F88A/dK5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYrWe-0001jH-Ij; Mon, 17 Dec 2018 11:57:32 +0000
Received: from [1.203.163.81] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYrWZ-0001gG-N7; Mon, 17 Dec 2018 11:57:30 +0000
X-UUID: 2420496297034a8c81cef50108929910-20181217
X-UUID: 2420496297034a8c81cef50108929910-20181217
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
 (envelope-from <long.cheng@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 1336393856; Mon, 17 Dec 2018 19:57:08 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Mon, 17 Dec 2018 19:57:07 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Dec 2018 19:57:06 +0800
Message-ID: <1545047826.28871.69.camel@mhfsdcap03>
Subject: Re: [PATCH v5 1/2] dmaengine: 8250_mtk_dma: add Mediatek uart DMA
 support
From: Long Cheng <long.cheng@mediatek.com>
To: Sean Wang <sean.wang@kernel.org>
Date: Mon, 17 Dec 2018 19:57:06 +0800
In-Reply-To: <CAGp9LzqFS5ku8-WE0Xc2xwztw9DumeU0DE4ZXbpH8w8u12LnOA@mail.gmail.com>
References: <1544506645-27979-1-git-send-email-long.cheng@mediatek.com>
 <1544506645-27979-2-git-send-email-long.cheng@mediatek.com>
 <CAGp9LzqB=hzkOHZqa-ZzRLcJujU--7gxYZczXiEj3DiH+FmhbQ@mail.gmail.com>
 <1544700985.28871.26.camel@mhfsdcap03>
 <CAGp9LzpGfVgjL9MMQyh2iZRD9bJiuH0B0GTg_bahaa5ju2wmzw@mail.gmail.com>
 <1545035989.28871.41.camel@mhfsdcap03>
 <CAGp9LzqFS5ku8-WE0Xc2xwztw9DumeU0DE4ZXbpH8w8u12LnOA@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_035728_233709_7DBFD5CD 
X-CRM114-Status: GOOD (  27.82  )
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
 Ryder Lee =?UTF-8?Q?=28=E6=9D=8E=E5=BA=9A=E8=AB=BA=29?=
 <ryder.lee@mediatek.com>, srv_heupstream@mediatek.com,
 gregkh@linuxfoundation.org,
 Sean Wang =?UTF-8?Q?=28=E7=8E=8B=E5=BF=97=E4=BA=98=29?=
 <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
 YT Shen <yt.shen@mediatek.com>, dmaengine@vger.kernel.org, vkoul@kernel.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 linux-serial@vger.kernel.org, jslaby@suse.com,
 Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com,
 dan.j.williams@intel.com, Long Cheng <long.cheng@mediatek.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 2018-12-17 at 02:07 -0800, Sean Wang wrote:
> On Mon, Dec 17, 2018 at 12:40 AM Long Cheng <long.cheng@mediatek.com> wrote:
> >
> > On Fri, 2018-12-14 at 12:09 -0800, Sean Wang wrote:
> 
> < ... >
> 
> > > > > > +
> > > > > > +               mtk_dma_chan_write(c, VFF_ADDR, cfg->src_addr);
> > > > > > +               mtk_dma_chan_write(c, VFF_LEN, rx_len);
> > > > > > +               mtk_dma_chan_write(c, VFF_THRE, VFF_RX_THRE(rx_len));
> > > > > > +               mtk_dma_chan_write(c,
> > > > > > +                                  VFF_INT_EN, VFF_RX_INT_EN0_B
> > > > > > +                                  | VFF_RX_INT_EN1_B);
> > > > > > +               mtk_dma_chan_write(c, VFF_INT_FLAG, VFF_RX_INT_FLAG_CLR_B);
> > > > > > +               mtk_dma_chan_write(c, VFF_EN, VFF_EN_B);
> > > > >
> > > > > I'd prefer to move those channel interrupt enablement to
> > > > > .device_alloc_chan_resources
> > > > > and related disablement to .device_free_chan_resources
> > > > >
> > > >
> > > > i think that, first need set the config to HW, and the enable the DMA.
> > > >
> > >
> > > I've read through the client driver and the dmaengine, I probably know
> > > how interaction they work and find out there is something you seem
> > > completely make a wrong.
> > >
> > > You can't do enable DMA with enabling VFF here. That causes a big
> > > problem, DMA would self decide to move data and not managed and issued
> > > by the dmaengine framework. For instance in DMA Tx path, because you
> > > enable the DMA and DMA  buffer (VFF) and UART Tx ring uses the same
> > > memory area,  DMA would self start to move data once data from
> > > userland go in Tx ring even without being issued by dmaengine.
> > >
> > > Instead, you should ensure all descriptors are being batched by
> > > .device_prep_slave_sg and DMA does not start moving data until
> > > .device_issue_pending done and once descriptors are issued, DMA
> > > hardware or software have to do it as fast as possible.
> > >
> >
> > the VFF enable just enable the DMA function. DMA can't move data here.
> > Now, the code get length of the data in '.device_prep_slave_sg'.
> > And let DMA move data in '.device_issue_pending function'. in here, just
> > enable the function.
> >
> 
> My all curiosity are all from the descriptor programmed in
> .device_issue_pending in the other drivers at least includes
> information such data length, target address, and hardware control
> code, but in the driver only includes data length and even the target
> address is set up at device_config, that seems unusual.
> 
> And, It does too for DMA_DEV_TO_MEM?  What I see is there is almost no
> any code be programmed for kick off the hardware for the direction but
> DMA still can move. That is another point I got confused.
> 

8250_dma in tty, mapping xmit buffer to DMA buffer. and the tx just use
the only one buffer. it's ring buffer. 8250_dma set the begin address
and length of the buffer by means of '.deivce_config' function. 
when TX happen, tty_write will write data to xmit buffer. in 8250_dma,
will set the address and length of the data by means of
'.device_prep_slave_sg'. but the address is in the xmit buffer rang. the
WPT(write pointer), RPT(read pointer) registers are recored the DMA data
transfer status, include the current location of transmission. and the
apdma is only for UART. So don't need recored the the address of data ,
target address in '.device_prep_slave_sg'.
in '.device_issue_pending', just using the data length from descriptor,
WPT ,  we can figure out what's data need to move. then update the WPT
and flush TX.

RX too. RX use other buffer in instead of XMIT buffer. when RX interrupt
coming, will update the RPT, and 8250_dma will get the length from vchan
complete. then 8250_dma can get the data.

> > > > > > +
> > > > > > +               if (!c->requested) {
> > > > > > +                       c->requested = true;
> > > > > > +                       ret = request_irq(mtkd->dma_irq[chan->chan_id],
> > > > > > +                                         mtk_dma_rx_interrupt,
> > > > > > +                                         IRQF_TRIGGER_NONE,
> > > > > > +                                         KBUILD_MODNAME, chan);
> > > > >
> > > > > ISR registration usually happens as the driver got probe, it can give
> > > > > the system more flexibility to manage such IRQ affinity on the fly.
> > > > >
> > > >
> > > > i will move the request irq to alloc channel.
> > > >
> > >
> > > why don't let it done in driver probe?
> > >
> > there are many uart ports, like UART[0-5]. in probe, just get the all
> > irq of ports. which port is using, who request irq. example, UART1 is
> > using. we just request irq of uart1. uart0, uart[2-5] don't need request
> > irq.
> >
> > > > > > +                       if (ret < 0) {
> > > > > > +                               dev_err(chan->device->dev, "Can't request rx dma IRQ\n");
> > > > > > +                               return -EINVAL;
> > > > > > +                       }
> > > > > > +               }
> > > > > > +       } else if (cfg->direction == DMA_MEM_TO_DEV)    {
> > > > > > +               unsigned int tx_len = cfg->dst_addr_width * 1024;
> > > > >
> > > > > Ditto as above, it seems you should use cfg->dst_port_window_size
> > > > >
> > > > > > +
> > > > > > +               mtk_dma_chan_write(c, VFF_ADDR, cfg->dst_addr);
> > > > > > +               mtk_dma_chan_write(c, VFF_LEN, tx_len);
> > > > > > +               mtk_dma_chan_write(c, VFF_THRE, VFF_TX_THRE(tx_len));
> > > > > > +               mtk_dma_chan_write(c, VFF_INT_FLAG, VFF_TX_INT_FLAG_CLR_B);
> > > > > > +               mtk_dma_chan_write(c, VFF_EN, VFF_EN_B);
> > > > >
> > > > > ditto, I'd prefer to move those channel interrupt enablement to
> > > > > .device_alloc_chan_resources and related disablement to
> > > > > .device_free_chan_resources
> > > > >
> > > > > > +
> > > > > > +               if (!c->requested) {
> > > > > > +                       c->requested = true;
> > > > > > +                       ret = request_irq(mtkd->dma_irq[chan->chan_id],
> > > > > > +                                         mtk_dma_tx_interrupt,
> > > > > > +                                         IRQF_TRIGGER_NONE,
> > > > > > +                                         KBUILD_MODNAME, chan);
> > > > >
> > > > > ditto, we can request ISR with devm_request_irq in the driver got
> > > > > probe and trim the c->request member
> > > > >
> > > > > > +                       if (ret < 0) {
> > > > > > +                               dev_err(chan->device->dev, "Can't request tx dma IRQ\n");
> > > > > > +                               return -EINVAL;
> > > > > > +                       }
> > > > > > +               }
> > > > > > +       }
> > > > > > +
> > > > > > +       if (mtkd->support_33bits)
> > > > > > +               mtk_dma_chan_write(c, VFF_4G_SUPPORT, VFF_4G_SUPPORT_B);
> > > > > > +
> > > > > > +       if (mtk_dma_chan_read(c, VFF_EN) != VFF_EN_B) {
> > > > > > +               dev_err(chan->device->dev,
> > > > > > +                       "config dma dir[%d] fail\n", cfg->direction);
> > > > > > +               return -EINVAL;
> > > > > > +       }
> > > > > > +
> > > > > > +       return 0;
> > > > > > +}
> > > > > > +
< ... >


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
