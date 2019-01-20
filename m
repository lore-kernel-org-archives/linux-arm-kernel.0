Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9CDC61CE4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 05:29:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9264A20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 05:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fdQnHXRN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1yZZAXwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9264A20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b9cVAbzaKHe7X88vkD9hgpSU9YoAEPxuyBa2FWiSq50=; b=fdQnHXRN9/qBX1
	7CvrCLuDakw+QO/aEzfXbFDNdnB/j8KGaOMol1etd7ehtjWwLz6ALNAOJf0SPWBPy+P2J3C9a0Rl7
	EpuUT/cxRenYL/y13bbs0y9oQ8R4O/T+UVkcuBpLKphWjtuBtYMosJ3I/ze8CQnAGbwOFvDfEHiC9
	PHce0+NS4Sez788aPWX6F03I8HMrpzXA1byNeDO4v02Z/Ui/RZit/5mIFj/fTNvGynjqNPyv25p4i
	bsfNa3Sv3U/brGn7VkniiFMEp0Hq28QV9AX1p80CN+i0lXvzRkt3MIByocuYqeuJoUJ8J24DjkZNz
	T9ZG2Z/TksymnwaQp1TA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gl5fp-0001sY-I1; Sun, 20 Jan 2019 05:29:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gl5fm-0001s9-13; Sun, 20 Jan 2019 05:29:31 +0000
Received: from localhost (unknown [122.178.235.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5D6ED2084C;
 Sun, 20 Jan 2019 05:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547962169;
 bh=UHKWDlIfapoOd6CK6rgHfqbocnOPirpeKm1gH8X4Np0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1yZZAXwx9jVsGbNoNQAnrYijeDW3lT77XhfmBF3LCEGb2cfg6wG5ZXoFaXawVwtOq
 oST+VI/GRcmrYG+SBndFT1EGuYlXMmfiR+h1I6+H0GKaLa2MCIBwOY1jfd2nnRK+RB
 3X6g9OpilUg7VypfLkhmDgccTT8QbXlXI5RnKHKY=
Date: Sun, 20 Jan 2019 10:57:50 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Long Cheng <long.cheng@mediatek.com>
Subject: Re: [PATCH v9 1/2] dmaengine: 8250_mtk_dma: add MediaTek uart DMA
 support
Message-ID: <20190120052750.GN4635@vkoul-mobl>
References: <1546395178-8880-1-git-send-email-long.cheng@mediatek.com>
 <1546395178-8880-2-git-send-email-long.cheng@mediatek.com>
 <20190104171953.GQ13372@vkoul-mobl.Dlink>
 <1547116431.3831.43.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547116431.3831.43.camel@mhfsdcap03>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_212930_106873_36CD99A5 
X-CRM114-Status: GOOD (  26.37  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>,
 Zhenbao Liu <zhenbao.liu@mediatek.com>, linux-serial@vger.kernel.org,
 srv_heupstream@mediatek.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>,
 YT Shen <yt.shen@mediatek.com>, dmaengine@vger.kernel.org,
 Ryder Lee <ryder.lee@mediatek.com>, linux-mediatek@lists.infradead.org,
 Sean Wang <sean.wang@mediatek.com>, Jiri Slaby <jslaby@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Yingjoe Chen <yingjoe.chen@mediatek.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 10-01-19, 18:33, Long Cheng wrote:
> On Fri, 2019-01-04 at 22:49 +0530, Vinod Koul wrote:
> > On 02-01-19, 10:12, Long Cheng wrote:
> > > In DMA engine framework, add 8250 uart dma to support MediaTek uart.
> > > If MediaTek uart enabled(SERIAL_8250_MT6577), and want to improve
> > > the performance, can enable the function.
> > 
> > Is the DMA controller UART specific, can it work with other controllers
> > as well, if so you should get rid of uart name in patch
> 
> I don't know that it can work or not on other controller. but it's for
> MediaTek SOC

What I meant was that if can work with other controllers (users) apart
from UART, how about say audio, spi etc!!

> 
> > > +#define MTK_UART_APDMA_CHANNELS		(CONFIG_SERIAL_8250_NR_UARTS * 2)
> > 
> > Why are the channels not coming from DT?
> > 
> 
> i will using dma-requests install of it.
> 
> > > +
> > > +#define VFF_EN_B		BIT(0)
> > > +#define VFF_STOP_B		BIT(0)
> > > +#define VFF_FLUSH_B		BIT(0)
> > > +#define VFF_4G_SUPPORT_B	BIT(0)
> > > +#define VFF_RX_INT_EN0_B	BIT(0)	/*rx valid size >=  vff thre*/
> > > +#define VFF_RX_INT_EN1_B	BIT(1)
> > > +#define VFF_TX_INT_EN_B		BIT(0)	/*tx left size >= vff thre*/
> > 
> > space around /* space */ also run checkpatch to check for style errors
> > 
> 
> ok.
> 
> > > +static void mtk_uart_apdma_start_tx(struct mtk_chan *c)
> > > +{
> > > +	unsigned int len, send, left, wpt, d_wpt, tmp;
> > > +	int ret;
> > > +
> > > +	left = mtk_uart_apdma_read(c, VFF_LEFT_SIZE);
> > > +	if (!left) {
> > > +		mtk_uart_apdma_write(c, VFF_INT_EN, VFF_TX_INT_EN_B);
> > > +		return;
> > > +	}
> > > +
> > > +	/* Wait 1sec for flush,  can't sleep*/
> > > +	ret = readx_poll_timeout(readl, c->base + VFF_FLUSH, tmp,
> > > +			tmp != VFF_FLUSH_B, 0, 1000000);
> > > +	if (ret)
> > > +		dev_warn(c->vc.chan.device->dev, "tx: fail, debug=0x%x\n",
> > > +			mtk_uart_apdma_read(c, VFF_DEBUG_STATUS));
> > > +
> > > +	send = min_t(unsigned int, left, c->desc->avail_len);
> > > +	wpt = mtk_uart_apdma_read(c, VFF_WPT);
> > > +	len = mtk_uart_apdma_read(c, VFF_LEN);
> > > +
> > > +	d_wpt = wpt + send;
> > > +	if ((d_wpt & VFF_RING_SIZE) >= len) {
> > > +		d_wpt = d_wpt - len;
> > > +		d_wpt = d_wpt ^ VFF_RING_WRAP;
> > > +	}
> > > +	mtk_uart_apdma_write(c, VFF_WPT, d_wpt);
> > > +
> > > +	c->desc->avail_len -= send;
> > > +
> > > +	mtk_uart_apdma_write(c, VFF_INT_EN, VFF_TX_INT_EN_B);
> > > +	if (mtk_uart_apdma_read(c, VFF_FLUSH) == 0U)
> > > +		mtk_uart_apdma_write(c, VFF_FLUSH, VFF_FLUSH_B);
> > > +}
> > > +
> > > +static void mtk_uart_apdma_start_rx(struct mtk_chan *c)
> > > +{
> > > +	struct mtk_uart_apdma_desc *d = c->desc;
> > > +	unsigned int len, wg, rg, cnt;
> > > +
> > > +	if ((mtk_uart_apdma_read(c, VFF_VALID_SIZE) == 0U) ||
> > > +		!d || !vchan_next_desc(&c->vc))
> > > +		return;
> > > +
> > > +	len = mtk_uart_apdma_read(c, VFF_LEN);
> > > +	rg = mtk_uart_apdma_read(c, VFF_RPT);
> > > +	wg = mtk_uart_apdma_read(c, VFF_WPT);
> > > +	if ((rg ^ wg) & VFF_RING_WRAP)
> > > +		cnt = (wg & VFF_RING_SIZE) + len - (rg & VFF_RING_SIZE);
> > > +	else
> > > +		cnt = (wg & VFF_RING_SIZE) - (rg & VFF_RING_SIZE);
> > > +
> > > +	c->rx_status = cnt;
> > > +	mtk_uart_apdma_write(c, VFF_RPT, wg);
> > > +
> > > +	list_del(&d->vd.node);
> > > +	vchan_cookie_complete(&d->vd);
> > > +}
> > 
> > this looks odd, why do you have different rx and tx start routines?
> > 
> 
> Would you like explain it in more detail? thanks.
> In tx function, will wait the last data flush done. and the count the
> size that send.
> In Rx function, will count the size that receive.
> Any way, in rx / tx, need andle WPT or RPT.
> 
> > > +static int mtk_uart_apdma_alloc_chan_resources(struct dma_chan *chan)
> > > +{
> > > +	struct mtk_uart_apdmadev *mtkd = to_mtk_uart_apdma_dev(chan->device);
> > > +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> > > +	u32 tmp;
> > > +	int ret;
> > > +
> > > +	pm_runtime_get_sync(mtkd->ddev.dev);
> > > +
> > > +	mtk_uart_apdma_write(c, VFF_ADDR, 0);
> > > +	mtk_uart_apdma_write(c, VFF_THRE, 0);
> > > +	mtk_uart_apdma_write(c, VFF_LEN, 0);
> > > +	mtk_uart_apdma_write(c, VFF_RST, VFF_WARM_RST_B);
> > > +
> > > +	ret = readx_poll_timeout(readl, c->base + VFF_EN, tmp,
> > > +			tmp == 0, 10, 100);
> > > +	if (ret) {
> > > +		dev_err(chan->device->dev, "dma reset: fail, timeout\n");
> > > +		return ret;
> > > +	}
> > 
> > register read does reset?
> > 
> 
> 'mtk_uart_apdma_write(c, VFF_RST, VFF_WARM_RST_B);' is reset. resd just
> poll reset done.
> 
> > > +
> > > +	if (!c->requested) {
> > > +		c->requested = true;
> > > +		ret = request_irq(mtkd->dma_irq[chan->chan_id],
> > > +				  mtk_uart_apdma_irq_handler, IRQF_TRIGGER_NONE,
> > > +				  KBUILD_MODNAME, chan);
> > 
> > why is the irq not requested in driver probe?
> > 
> 
> I have explained in below,
> http://lists.infradead.org/pipermail/linux-mediatek/2018-December/016418.html
> 
> > > +static enum dma_status mtk_uart_apdma_tx_status(struct dma_chan *chan,
> > > +					 dma_cookie_t cookie,
> > > +					 struct dma_tx_state *txstate)
> > > +{
> > > +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> > > +	enum dma_status ret;
> > > +	unsigned long flags;
> > > +
> > > +	if (!txstate)
> > > +		return DMA_ERROR;
> > > +
> > > +	ret = dma_cookie_status(chan, cookie, txstate);
> > > +	spin_lock_irqsave(&c->vc.lock, flags);
> > > +	if (ret == DMA_IN_PROGRESS) {
> > > +		c->rx_status = mtk_uart_apdma_read(c, VFF_RPT) & VFF_RING_SIZE;
> > > +		dma_set_residue(txstate, c->rx_status);
> > > +	} else if (ret == DMA_COMPLETE && c->cfg.direction == DMA_DEV_TO_MEM) {
> > 
> > why set reside when it is complete? also reside can be null, that should
> > be checked as well
> > 
> In different status, set different reside.

Can you explain that..

> 
> > > +static struct dma_async_tx_descriptor *mtk_uart_apdma_prep_slave_sg
> > > +	(struct dma_chan *chan, struct scatterlist *sgl,
> > > +	unsigned int sglen, enum dma_transfer_direction dir,
> > > +	unsigned long tx_flags, void *context)
> > > +{
> > > +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> > > +	struct mtk_uart_apdma_desc *d;
> > > +
> > > +	if ((dir != DMA_DEV_TO_MEM) &&
> > > +		(dir != DMA_MEM_TO_DEV)) {
> > > +		dev_err(chan->device->dev, "bad direction\n");
> > > +		return NULL;
> > > +	}
> > 
> > we have a macro for this
> 
> Thanks for your suggestion. i will modify it.
> > 
> > > +
> > > +	/* Now allocate and setup the descriptor */
> > > +	d = kzalloc(sizeof(*d), GFP_ATOMIC);
> > > +	if (!d)
> > > +		return NULL;
> > > +
> > > +	/* sglen is 1 */
> > 
> > ?
> > 
> > > +static int mtk_uart_apdma_slave_config(struct dma_chan *chan,
> > > +				struct dma_slave_config *cfg)
> > > +{
> > > +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> > > +	struct mtk_uart_apdmadev *mtkd =
> > > +				to_mtk_uart_apdma_dev(c->vc.chan.device);
> > > +
> > > +	c->cfg = *cfg;
> > > +
> > > +	if (cfg->direction == DMA_DEV_TO_MEM) {
> > 
> > fg->direction is deprecated, in fact I have removed all users recently,
> > please do not use this
> 
> You will remove 'direction' in 'struct dma_slave_config'? if remove, how
> do confirm direction?

Yes please use the direction argument in prep_xx calls
-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
