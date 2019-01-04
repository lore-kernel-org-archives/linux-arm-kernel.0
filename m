Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCA2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:21:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D958218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bS4TjYIR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLk2stXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D958218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wfo6oEMbzZnFohgHwuxetIkQ6q1cT8/wggxiCRod/uE=; b=bS4TjYIR+/Jf2p
	NwzC25uKz3CWik16sM68qk4MeKFLmFxL95Y2wHHBmGn3JWfoXMM77fAtpfqr4Gqvom8YNbo2duRld
	3kbtAETKvpWZkYATsOs/Tq+EQSdHUik259aRpnrnjpgWO2OuHLUHcwdmwQ0+vm0fcZ7bmqOGWAbDH
	ZcUckveXYSL0VQyRIG+Pl+Ii3A7XLXhBimbQ324yRPnNf4Hvcr69oI3vy3R9lnk0re5xemGliVM3K
	25qR6YOQQzx86oGAbzQ8x83sv9m9cf9VU6VOsL0WlVJHSkQroiqX95Ne4tD2tqW3wlEyIEkJRr7f5
	UXDYKzdMUMm7gu1ch2pQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfTAC-0001yc-Cz; Fri, 04 Jan 2019 17:21:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfTA9-0001yA-5b; Fri, 04 Jan 2019 17:21:38 +0000
Received: from localhost (unknown [49.207.53.230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DE77A20656;
 Fri,  4 Jan 2019 17:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546622496;
 bh=IWRxjqRZMfqkpFR+UMeB7j3ELM39V1FdMr8iK6tZ528=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NLk2stXIkhjFIstnEo966bJqc2knqjTaG8nIJ7zw7Uy7mL8GHS4AfxNlCpK3MvUBK
 5Hp4Ux6m1qUtqVZcCOunNNR/la5A94OBz/nQg7vhLcxNgc88ql9vkfkLF4fA8lwGJa
 UkI4zzs5NKZ5DdaCjsEVhRX9t4KaGsKT7T5VSbLo=
Date: Fri, 4 Jan 2019 22:49:53 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Long Cheng <long.cheng@mediatek.com>
Subject: Re: [PATCH v9 1/2] dmaengine: 8250_mtk_dma: add MediaTek uart DMA
 support
Message-ID: <20190104171953.GQ13372@vkoul-mobl.Dlink>
References: <1546395178-8880-1-git-send-email-long.cheng@mediatek.com>
 <1546395178-8880-2-git-send-email-long.cheng@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546395178-8880-2-git-send-email-long.cheng@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_092137_251200_C5029772 
X-CRM114-Status: GOOD (  19.59  )
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

On 02-01-19, 10:12, Long Cheng wrote:
> In DMA engine framework, add 8250 uart dma to support MediaTek uart.
> If MediaTek uart enabled(SERIAL_8250_MT6577), and want to improve
> the performance, can enable the function.

Is the DMA controller UART specific, can it work with other controllers
as well, if so you should get rid of uart name in patch

> +#define MTK_UART_APDMA_CHANNELS		(CONFIG_SERIAL_8250_NR_UARTS * 2)

Why are the channels not coming from DT?

> +
> +#define VFF_EN_B		BIT(0)
> +#define VFF_STOP_B		BIT(0)
> +#define VFF_FLUSH_B		BIT(0)
> +#define VFF_4G_SUPPORT_B	BIT(0)
> +#define VFF_RX_INT_EN0_B	BIT(0)	/*rx valid size >=  vff thre*/
> +#define VFF_RX_INT_EN1_B	BIT(1)
> +#define VFF_TX_INT_EN_B		BIT(0)	/*tx left size >= vff thre*/

space around /* space */ also run checkpatch to check for style errors

> +static void mtk_uart_apdma_start_tx(struct mtk_chan *c)
> +{
> +	unsigned int len, send, left, wpt, d_wpt, tmp;
> +	int ret;
> +
> +	left = mtk_uart_apdma_read(c, VFF_LEFT_SIZE);
> +	if (!left) {
> +		mtk_uart_apdma_write(c, VFF_INT_EN, VFF_TX_INT_EN_B);
> +		return;
> +	}
> +
> +	/* Wait 1sec for flush,  can't sleep*/
> +	ret = readx_poll_timeout(readl, c->base + VFF_FLUSH, tmp,
> +			tmp != VFF_FLUSH_B, 0, 1000000);
> +	if (ret)
> +		dev_warn(c->vc.chan.device->dev, "tx: fail, debug=0x%x\n",
> +			mtk_uart_apdma_read(c, VFF_DEBUG_STATUS));
> +
> +	send = min_t(unsigned int, left, c->desc->avail_len);
> +	wpt = mtk_uart_apdma_read(c, VFF_WPT);
> +	len = mtk_uart_apdma_read(c, VFF_LEN);
> +
> +	d_wpt = wpt + send;
> +	if ((d_wpt & VFF_RING_SIZE) >= len) {
> +		d_wpt = d_wpt - len;
> +		d_wpt = d_wpt ^ VFF_RING_WRAP;
> +	}
> +	mtk_uart_apdma_write(c, VFF_WPT, d_wpt);
> +
> +	c->desc->avail_len -= send;
> +
> +	mtk_uart_apdma_write(c, VFF_INT_EN, VFF_TX_INT_EN_B);
> +	if (mtk_uart_apdma_read(c, VFF_FLUSH) == 0U)
> +		mtk_uart_apdma_write(c, VFF_FLUSH, VFF_FLUSH_B);
> +}
> +
> +static void mtk_uart_apdma_start_rx(struct mtk_chan *c)
> +{
> +	struct mtk_uart_apdma_desc *d = c->desc;
> +	unsigned int len, wg, rg, cnt;
> +
> +	if ((mtk_uart_apdma_read(c, VFF_VALID_SIZE) == 0U) ||
> +		!d || !vchan_next_desc(&c->vc))
> +		return;
> +
> +	len = mtk_uart_apdma_read(c, VFF_LEN);
> +	rg = mtk_uart_apdma_read(c, VFF_RPT);
> +	wg = mtk_uart_apdma_read(c, VFF_WPT);
> +	if ((rg ^ wg) & VFF_RING_WRAP)
> +		cnt = (wg & VFF_RING_SIZE) + len - (rg & VFF_RING_SIZE);
> +	else
> +		cnt = (wg & VFF_RING_SIZE) - (rg & VFF_RING_SIZE);
> +
> +	c->rx_status = cnt;
> +	mtk_uart_apdma_write(c, VFF_RPT, wg);
> +
> +	list_del(&d->vd.node);
> +	vchan_cookie_complete(&d->vd);
> +}

this looks odd, why do you have different rx and tx start routines?

> +static int mtk_uart_apdma_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	struct mtk_uart_apdmadev *mtkd = to_mtk_uart_apdma_dev(chan->device);
> +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> +	u32 tmp;
> +	int ret;
> +
> +	pm_runtime_get_sync(mtkd->ddev.dev);
> +
> +	mtk_uart_apdma_write(c, VFF_ADDR, 0);
> +	mtk_uart_apdma_write(c, VFF_THRE, 0);
> +	mtk_uart_apdma_write(c, VFF_LEN, 0);
> +	mtk_uart_apdma_write(c, VFF_RST, VFF_WARM_RST_B);
> +
> +	ret = readx_poll_timeout(readl, c->base + VFF_EN, tmp,
> +			tmp == 0, 10, 100);
> +	if (ret) {
> +		dev_err(chan->device->dev, "dma reset: fail, timeout\n");
> +		return ret;
> +	}

register read does reset?

> +
> +	if (!c->requested) {
> +		c->requested = true;
> +		ret = request_irq(mtkd->dma_irq[chan->chan_id],
> +				  mtk_uart_apdma_irq_handler, IRQF_TRIGGER_NONE,
> +				  KBUILD_MODNAME, chan);

why is the irq not requested in driver probe?

> +static enum dma_status mtk_uart_apdma_tx_status(struct dma_chan *chan,
> +					 dma_cookie_t cookie,
> +					 struct dma_tx_state *txstate)
> +{
> +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> +	enum dma_status ret;
> +	unsigned long flags;
> +
> +	if (!txstate)
> +		return DMA_ERROR;
> +
> +	ret = dma_cookie_status(chan, cookie, txstate);
> +	spin_lock_irqsave(&c->vc.lock, flags);
> +	if (ret == DMA_IN_PROGRESS) {
> +		c->rx_status = mtk_uart_apdma_read(c, VFF_RPT) & VFF_RING_SIZE;
> +		dma_set_residue(txstate, c->rx_status);
> +	} else if (ret == DMA_COMPLETE && c->cfg.direction == DMA_DEV_TO_MEM) {

why set reside when it is complete? also reside can be null, that should
be checked as well

> +static struct dma_async_tx_descriptor *mtk_uart_apdma_prep_slave_sg
> +	(struct dma_chan *chan, struct scatterlist *sgl,
> +	unsigned int sglen, enum dma_transfer_direction dir,
> +	unsigned long tx_flags, void *context)
> +{
> +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> +	struct mtk_uart_apdma_desc *d;
> +
> +	if ((dir != DMA_DEV_TO_MEM) &&
> +		(dir != DMA_MEM_TO_DEV)) {
> +		dev_err(chan->device->dev, "bad direction\n");
> +		return NULL;
> +	}

we have a macro for this

> +
> +	/* Now allocate and setup the descriptor */
> +	d = kzalloc(sizeof(*d), GFP_ATOMIC);
> +	if (!d)
> +		return NULL;
> +
> +	/* sglen is 1 */

?

> +static int mtk_uart_apdma_slave_config(struct dma_chan *chan,
> +				struct dma_slave_config *cfg)
> +{
> +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> +	struct mtk_uart_apdmadev *mtkd =
> +				to_mtk_uart_apdma_dev(c->vc.chan.device);
> +
> +	c->cfg = *cfg;
> +
> +	if (cfg->direction == DMA_DEV_TO_MEM) {

fg->direction is deprecated, in fact I have removed all users recently,
please do not use this

> +		unsigned int rx_len = cfg->src_addr_width * 1024;
> +
> +		mtk_uart_apdma_write(c, VFF_ADDR, cfg->src_addr);
> +		mtk_uart_apdma_write(c, VFF_LEN, rx_len);
> +		mtk_uart_apdma_write(c, VFF_THRE, VFF_RX_THRE(rx_len));
> +		mtk_uart_apdma_write(c, VFF_INT_EN,
> +				VFF_RX_INT_EN0_B | VFF_RX_INT_EN1_B);
> +		mtk_uart_apdma_write(c, VFF_RPT, 0);
> +		mtk_uart_apdma_write(c, VFF_INT_FLAG, VFF_RX_INT_FLAG_CLR_B);
> +		mtk_uart_apdma_write(c, VFF_EN, VFF_EN_B);

why are we writing this here, we are supposed to do that when txn
starts!

> +static int mtk_uart_apdma_device_resume(struct dma_chan *chan)
> +{
> +	/* just for check caps pass */
> +	return 0;
> +}

if you do not support this please remove this!

> +static void mtk_uart_apdma_free(struct mtk_uart_apdmadev *mtkd)
> +{
> +	while (list_empty(&mtkd->ddev.channels) == 0) {
> +		struct mtk_chan *c = list_first_entry(&mtkd->ddev.channels,
> +			struct mtk_chan, vc.chan.device_node);
> +
> +		list_del(&c->vc.chan.device_node);
> +		tasklet_kill(&c->vc.task);
> +	}
> +}
> +
> +static const struct of_device_id mtk_uart_apdma_match[] = {
> +	{ .compatible = "mediatek,mt6577-uart-dma", },

where is the binding document for ediatek,mt6577-uart-dma ??

-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
