Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1095CC282E9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:13:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C83A220855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UOU8+Fae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83A220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JmSx4hE+7yyUpu5sxce9fgB47CM/46xdqBnDFywaThM=; b=UOU8+FaecSyN2L
	RGralGTZljho6cYTbA8m4o5qTVbMe7CqcORVLlsPgdTkzt3O1Y0NaNkhaxjQSIw7w+WZ24eVUmDGG
	j5XLK8aqV16JxJr+5CktUO09jmd5O7qzvFDj9b2MJe682LL7fXrFRWeiiLiRFg+Cl/yE1avApg6tT
	4ltjlMwV5Wmdir0coHMuG7Ytw9apklFxjt4N0YVWtuVDtGUnLWypgQVTHmRYfDMwZ9Hx9qCx7cNk7
	KW+QsUfQUBiZsuFLIkxbOfNvsBN0lXW2FXFIOjEb51ZSldiXpF/hXXtoud6xdzwsJL6Kzl2+Jtzp4
	8U5uWwLDxzH46KYXGvoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glUhW-0003V1-8k; Mon, 21 Jan 2019 08:12:58 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glUhS-0003Tw-4p; Mon, 21 Jan 2019 08:12:56 +0000
X-UUID: 7a8b5582f8714b6abab29494fa305824-20190121
X-UUID: 7a8b5582f8714b6abab29494fa305824-20190121
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <long.cheng@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1444038887; Mon, 21 Jan 2019 00:12:46 -0800
Received: from mtkmbs08n1.mediatek.inc (172.21.101.55) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 21 Jan 2019 00:12:44 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs08n1.mediatek.inc
 (172.21.101.55) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Mon, 21 Jan 2019 16:12:30 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 21 Jan 2019 16:12:29 +0800
Message-ID: <1548058349.3831.71.camel@mhfsdcap03>
Subject: Re: [PATCH v9 1/2] dmaengine: 8250_mtk_dma: add MediaTek uart DMA
 support
From: Long Cheng <long.cheng@mediatek.com>
To: Vinod Koul <vkoul@kernel.org>
Date: Mon, 21 Jan 2019 16:12:29 +0800
In-Reply-To: <20190120052750.GN4635@vkoul-mobl>
References: <1546395178-8880-1-git-send-email-long.cheng@mediatek.com>
 <1546395178-8880-2-git-send-email-long.cheng@mediatek.com>
 <20190104171953.GQ13372@vkoul-mobl.Dlink>
 <1547116431.3831.43.camel@mhfsdcap03> <20190120052750.GN4635@vkoul-mobl>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_001254_202644_7CB7E5E1 
X-CRM114-Status: GOOD (  28.48  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Sean Wang <sean.wang@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Zhenbao Liu <zhenbao.liu@mediatek.com>,
 Nicolas Boichat <drinkcat@chromium.org>, Long
 Cheng <long.cheng@mediatek.com>, linux-serial@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>, YT
 Shen <yt.shen@mediatek.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>,
 devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org,
 srv_heupstream@mediatek.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, 2019-01-20 at 10:57 +0530, Vinod Koul wrote:
> On 10-01-19, 18:33, Long Cheng wrote:
> > On Fri, 2019-01-04 at 22:49 +0530, Vinod Koul wrote:
> > > On 02-01-19, 10:12, Long Cheng wrote:
> > > > In DMA engine framework, add 8250 uart dma to support MediaTek uart.
> > > > If MediaTek uart enabled(SERIAL_8250_MT6577), and want to improve
> > > > the performance, can enable the function.
> > > 
> > > Is the DMA controller UART specific, can it work with other controllers
> > > as well, if so you should get rid of uart name in patch
> > 
> > I don't know that it can work or not on other controller. but it's for
> > MediaTek SOC
> 
> What I meant was that if can work with other controllers (users) apart
> from UART, how about say audio, spi etc!!
> 

it's just for UART APDMA. can't work on spi ...

> > 
> > > > +#define MTK_UART_APDMA_CHANNELS		(CONFIG_SERIAL_8250_NR_UARTS * 2)
> > > 
> > > Why are the channels not coming from DT?
> > > 
> > 
> > i will using dma-requests install of it.
> > 
> > > > +
> > > > +#define VFF_EN_B		BIT(0)
> > > > +#define VFF_STOP_B		BIT(0)
> > > > +#define VFF_FLUSH_B		BIT(0)
> > > > +#define VFF_4G_SUPPORT_B	BIT(0)
> > > > +#define VFF_RX_INT_EN0_B	BIT(0)	/*rx valid size >=  vff thre*/
> > > > +#define VFF_RX_INT_EN1_B	BIT(1)
> > > > +#define VFF_TX_INT_EN_B		BIT(0)	/*tx left size >= vff thre*/
> > > 
> > > space around /* space */ also run checkpatch to check for style errors
> > > 
> > 
> > ok.
> > 
> > > > +static void mtk_uart_apdma_start_tx(struct mtk_chan *c)
> > > > +{
> > > > +	unsigned int len, send, left, wpt, d_wpt, tmp;
> > > > +	int ret;
> > > > +
> > > > +	left = mtk_uart_apdma_read(c, VFF_LEFT_SIZE);
> > > > +	if (!left) {
> > > > +		mtk_uart_apdma_write(c, VFF_INT_EN, VFF_TX_INT_EN_B);
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	/* Wait 1sec for flush,  can't sleep*/
> > > > +	ret = readx_poll_timeout(readl, c->base + VFF_FLUSH, tmp,
> > > > +			tmp != VFF_FLUSH_B, 0, 1000000);
> > > > +	if (ret)
> > > > +		dev_warn(c->vc.chan.device->dev, "tx: fail, debug=0x%x\n",
> > > > +			mtk_uart_apdma_read(c, VFF_DEBUG_STATUS));
> > > > +
> > > > +	send = min_t(unsigned int, left, c->desc->avail_len);
> > > > +	wpt = mtk_uart_apdma_read(c, VFF_WPT);
> > > > +	len = mtk_uart_apdma_read(c, VFF_LEN);
> > > > +
> > > > +	d_wpt = wpt + send;
> > > > +	if ((d_wpt & VFF_RING_SIZE) >= len) {
> > > > +		d_wpt = d_wpt - len;
> > > > +		d_wpt = d_wpt ^ VFF_RING_WRAP;
> > > > +	}
> > > > +	mtk_uart_apdma_write(c, VFF_WPT, d_wpt);
> > > > +
> > > > +	c->desc->avail_len -= send;
> > > > +
> > > > +	mtk_uart_apdma_write(c, VFF_INT_EN, VFF_TX_INT_EN_B);
> > > > +	if (mtk_uart_apdma_read(c, VFF_FLUSH) == 0U)
> > > > +		mtk_uart_apdma_write(c, VFF_FLUSH, VFF_FLUSH_B);
> > > > +}
> > > > +
> > > > +static void mtk_uart_apdma_start_rx(struct mtk_chan *c)
> > > > +{
> > > > +	struct mtk_uart_apdma_desc *d = c->desc;
> > > > +	unsigned int len, wg, rg, cnt;
> > > > +
> > > > +	if ((mtk_uart_apdma_read(c, VFF_VALID_SIZE) == 0U) ||
> > > > +		!d || !vchan_next_desc(&c->vc))
> > > > +		return;
> > > > +
> > > > +	len = mtk_uart_apdma_read(c, VFF_LEN);
> > > > +	rg = mtk_uart_apdma_read(c, VFF_RPT);
> > > > +	wg = mtk_uart_apdma_read(c, VFF_WPT);
> > > > +	if ((rg ^ wg) & VFF_RING_WRAP)
> > > > +		cnt = (wg & VFF_RING_SIZE) + len - (rg & VFF_RING_SIZE);
> > > > +	else
> > > > +		cnt = (wg & VFF_RING_SIZE) - (rg & VFF_RING_SIZE);
> > > > +
> > > > +	c->rx_status = cnt;
> > > > +	mtk_uart_apdma_write(c, VFF_RPT, wg);
> > > > +
> > > > +	list_del(&d->vd.node);
> > > > +	vchan_cookie_complete(&d->vd);
> > > > +}
> > > 
> > > this looks odd, why do you have different rx and tx start routines?
> > > 
> > 
> > Would you like explain it in more detail? thanks.
> > In tx function, will wait the last data flush done. and the count the
> > size that send.
> > In Rx function, will count the size that receive.
> > Any way, in rx / tx, need andle WPT or RPT.
> > 
> > > > +static int mtk_uart_apdma_alloc_chan_resources(struct dma_chan *chan)
> > > > +{
> > > > +	struct mtk_uart_apdmadev *mtkd = to_mtk_uart_apdma_dev(chan->device);
> > > > +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> > > > +	u32 tmp;
> > > > +	int ret;
> > > > +
> > > > +	pm_runtime_get_sync(mtkd->ddev.dev);
> > > > +
> > > > +	mtk_uart_apdma_write(c, VFF_ADDR, 0);
> > > > +	mtk_uart_apdma_write(c, VFF_THRE, 0);
> > > > +	mtk_uart_apdma_write(c, VFF_LEN, 0);
> > > > +	mtk_uart_apdma_write(c, VFF_RST, VFF_WARM_RST_B);
> > > > +
> > > > +	ret = readx_poll_timeout(readl, c->base + VFF_EN, tmp,
> > > > +			tmp == 0, 10, 100);
> > > > +	if (ret) {
> > > > +		dev_err(chan->device->dev, "dma reset: fail, timeout\n");
> > > > +		return ret;
> > > > +	}
> > > 
> > > register read does reset?
> > > 
> > 
> > 'mtk_uart_apdma_write(c, VFF_RST, VFF_WARM_RST_B);' is reset. resd just
> > poll reset done.
> > 
> > > > +
> > > > +	if (!c->requested) {
> > > > +		c->requested = true;
> > > > +		ret = request_irq(mtkd->dma_irq[chan->chan_id],
> > > > +				  mtk_uart_apdma_irq_handler, IRQF_TRIGGER_NONE,
> > > > +				  KBUILD_MODNAME, chan);
> > > 
> > > why is the irq not requested in driver probe?
> > > 
> > 
> > I have explained in below,
> > http://lists.infradead.org/pipermail/linux-mediatek/2018-December/016418.html
> > 
> > > > +static enum dma_status mtk_uart_apdma_tx_status(struct dma_chan *chan,
> > > > +					 dma_cookie_t cookie,
> > > > +					 struct dma_tx_state *txstate)
> > > > +{
> > > > +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> > > > +	enum dma_status ret;
> > > > +	unsigned long flags;
> > > > +
> > > > +	if (!txstate)
> > > > +		return DMA_ERROR;
> > > > +
> > > > +	ret = dma_cookie_status(chan, cookie, txstate);
> > > > +	spin_lock_irqsave(&c->vc.lock, flags);
> > > > +	if (ret == DMA_IN_PROGRESS) {
> > > > +		c->rx_status = mtk_uart_apdma_read(c, VFF_RPT) & VFF_RING_SIZE;
> > > > +		dma_set_residue(txstate, c->rx_status);
> > > > +	} else if (ret == DMA_COMPLETE && c->cfg.direction == DMA_DEV_TO_MEM) {
> > > 
> > > why set reside when it is complete? also reside can be null, that should
> > > be checked as well
> > > 
> > In different status, set different reside.
> 
> Can you explain that..
> 

RPT is different every time. When RX interrupt coming, update the
rx_status and notify uart that there have data. One transfer is
complete. Uart will call tx_status to get the length at the time of
interruption. Other case, if want to get the tx_status, directly read
register.

> > 
> > > > +static struct dma_async_tx_descriptor *mtk_uart_apdma_prep_slave_sg
> > > > +	(struct dma_chan *chan, struct scatterlist *sgl,
> > > > +	unsigned int sglen, enum dma_transfer_direction dir,
> > > > +	unsigned long tx_flags, void *context)
> > > > +{
> > > > +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> > > > +	struct mtk_uart_apdma_desc *d;
> > > > +
> > > > +	if ((dir != DMA_DEV_TO_MEM) &&
> > > > +		(dir != DMA_MEM_TO_DEV)) {
> > > > +		dev_err(chan->device->dev, "bad direction\n");
> > > > +		return NULL;
> > > > +	}
> > > 
> > > we have a macro for this
> > 
> > Thanks for your suggestion. i will modify it.
> > > 
> > > > +
> > > > +	/* Now allocate and setup the descriptor */
> > > > +	d = kzalloc(sizeof(*d), GFP_ATOMIC);
> > > > +	if (!d)
> > > > +		return NULL;
> > > > +
> > > > +	/* sglen is 1 */
> > > 
> > > ?

dmaengine_prep_slave_single is called. the parameter 'sglen' is 1.
Add annotation to indicate that the total length is sg_dma_len(sgl), no
more.

> > > 
> > > > +static int mtk_uart_apdma_slave_config(struct dma_chan *chan,
> > > > +				struct dma_slave_config *cfg)
> > > > +{
> > > > +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> > > > +	struct mtk_uart_apdmadev *mtkd =
> > > > +				to_mtk_uart_apdma_dev(c->vc.chan.device);
> > > > +
> > > > +	c->cfg = *cfg;
> > > > +
> > > > +	if (cfg->direction == DMA_DEV_TO_MEM) {
> > > 
> > > fg->direction is deprecated, in fact I have removed all users recently,
> > > please do not use this
> > 
> > You will remove 'direction' in 'struct dma_slave_config'? if remove, how
> > do confirm direction?
> 
> Yes please use the direction argument in prep_xx calls

I had modified on v10. thanks.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
