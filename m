Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD9EC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:23:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10A992083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Io/J2gg0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUKyNq6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A992083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8yMRbJUzWhMb5ojYimjMruXvneHpc9Y2jiRWyRmlayM=; b=Io/J2gg0HA3mQr
	6YWL9kbSkE3F4ysJyK1jmH4mZ+HLAVmBlX+B0S6381HcNE7GkoY29ZoYIxM7x0iJIU5YWOBAH91TH
	qHz0coWrORHKJSnhoNWbeGw/VJNKYKHCOgoA3yNM6M7E4KRAQt87yFmtqPKAU9zLx1eGg5HeutGAh
	a8kxYa/dWQ6DBDwTZ086sV8hKU8c4bL44zFnKbVTvzWI7WdJSuY0b7JMqpO+g1OTagOv5BWp2d4NR
	gW7VXQN3SmeCZ75OR26jQVuJdNae3ZXwWBS7OLEM9QEH2oZJJQgl8WUvg/MF3b344PHgH5uLXp9Uc
	e6H1pUuYs6qd6cLqIyMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqYbF-0000wp-Me; Mon, 04 Feb 2019 07:23:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqYbC-0000wO-VJ; Mon, 04 Feb 2019 07:23:24 +0000
Received: from localhost (unknown [171.76.74.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 92B4A2083B;
 Mon,  4 Feb 2019 07:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549265002;
 bh=HDgwpkhTpoTEVDPKrkmykrNSqq9yCCJYhstkDTGaZWE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nUKyNq6Hts9oKpqFVbZ/mpkxPAtFK43ibh8WLBgzpsTvo7+BLeLG5N0+7brbVEffc
 WQAhP+A6rr5jgbzfuyTzgN6G6JdhQPfOglnHO9KqhfXhN3TKwqUlBNTOueG8khTv9Z
 Lrpbh+ZuDSqochHp+jcQVvER3BRaDmXY7Yb8fB4Q=
Date: Mon, 4 Feb 2019 12:51:54 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Long Cheng <long.cheng@mediatek.com>
Subject: Re: [PATCH v10 1/3] dmaengine: 8250_mtk_dma: add MediaTek uart DMA
 support
Message-ID: <20190204072154.GJ4296@vkoul-mobl>
References: <1547781016-890-1-git-send-email-long.cheng@mediatek.com>
 <1547781016-890-2-git-send-email-long.cheng@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547781016-890-2-git-send-email-long.cheng@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_232323_028985_1C239D46 
X-CRM114-Status: GOOD (  12.57  )
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

On 18-01-19, 11:10, Long Cheng wrote:
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

Why, it is not a mandatory arg!

> +	ret = dma_cookie_status(chan, cookie, txstate);
> +	spin_lock_irqsave(&c->vc.lock, flags);
> +	if (ret == DMA_IN_PROGRESS) {
> +		c->rx_status = mtk_uart_apdma_read(c, VFF_RPT) & VFF_RING_SIZE;
> +		dma_set_residue(txstate, c->rx_status);
> +	} else if (ret == DMA_COMPLETE && c->dir == DMA_DEV_TO_MEM) {
> +		dma_set_residue(txstate, c->rx_status);

what is the point is setting residue to comleted txn, it is zero!

> +	} else {
> +		dma_set_residue(txstate, 0);

naah that doesnt sound correct!

> +static void mtk_uart_apdma_config_write(struct dma_chan *chan,
> +			       struct dma_slave_config *cfg,
> +			       enum dma_transfer_direction dir)
> +{
> +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> +	struct mtk_uart_apdmadev *mtkd =
> +				to_mtk_uart_apdma_dev(c->vc.chan.device);
> +	unsigned int tmp;
> +
> +	if (mtk_uart_apdma_read(c, VFF_EN) == VFF_EN_B)
> +		return;
> +
> +	c->dir = dir;
> +
> +	if (dir == DMA_DEV_TO_MEM) {
> +		tmp = cfg->src_addr_width * 1024;

why multiply by 1024?

> +static int mtk_uart_apdma_device_pause(struct dma_chan *chan)
> +{
> +	/* just for check caps pass */
> +	return 0;
> +}

please remove, this is not a mandatory fn
-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
