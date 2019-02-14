Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3FCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:45:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D5C1206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i+QVzzeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5C1206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WLYWslvh/8/VfmCThvAlkADOpndxp5BxZdUDQGDLkyE=; b=i+QVzzeAQbJGQi
	N12OSSEjoS82jndG/Mw+eHWj4sKe9FdpZisRSqenvUQgY3tjpvVT6Kk/m0sClpoZnqBALjl/H/ynG
	hB+xfuP8LNetn2gCygdlBP+mF8jfkERw6teNwtrQaNYIPDnoXl+jUgq1on7gF4/XfMVz8KvzFXHbC
	eixq7If4ydDMEynFuwPQ+rbiRLeMqq+O9e8uVEW/l9mTMVgQxmErRcP8qJfBKCMvET1V8CjppYy5c
	G/n17+tShcliSfEQuizYKqbZiy1S29hJcvXwqjsNCkJ3Rsuxv5MT6Wn39TAW9A9fg2NofIvEl+sIm
	g/e1K44Jsz73GiKN7Y9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu71T-0006uD-DK; Thu, 14 Feb 2019 02:45:11 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu71P-0005im-79; Thu, 14 Feb 2019 02:45:08 +0000
X-UUID: e4ef965db75845e7abadaa4275065604-20190213
X-UUID: e4ef965db75845e7abadaa4275065604-20190213
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <long.cheng@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1876248802; Wed, 13 Feb 2019 18:45:00 -0800
Received: from mtkmbs03n1.mediatek.inc (172.21.101.181) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 13 Feb 2019 18:44:59 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs03n1.mediatek.inc
 (172.21.101.181) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Thu, 14 Feb 2019 10:44:57 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 14 Feb 2019 10:44:56 +0800
Message-ID: <1550112296.7678.5.camel@mhfsdcap03>
Subject: Re: [PATCH v10 1/3] dmaengine: 8250_mtk_dma: add MediaTek uart DMA
 support
From: Long Cheng <long.cheng@mediatek.com>
To: Vinod Koul <vkoul@kernel.org>
Date: Thu, 14 Feb 2019 10:44:56 +0800
In-Reply-To: <20190204072154.GJ4296@vkoul-mobl>
References: <1547781016-890-1-git-send-email-long.cheng@mediatek.com>
 <1547781016-890-2-git-send-email-long.cheng@mediatek.com>
 <20190204072154.GJ4296@vkoul-mobl>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_184507_269209_BB4DC143 
X-CRM114-Status: GOOD (  14.22  )
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

On Mon, 2019-02-04 at 12:51 +0530, Vinod Koul wrote:

Hi Vinod sir,

> On 18-01-19, 11:10, Long Cheng wrote:
> > +static enum dma_status mtk_uart_apdma_tx_status(struct dma_chan *chan,
> > +					 dma_cookie_t cookie,
> > +					 struct dma_tx_state *txstate)
> > +{
> > +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> > +	enum dma_status ret;
> > +	unsigned long flags;
> > +
> > +	if (!txstate)
> > +		return DMA_ERROR;
> 
> Why, it is not a mandatory arg!

Next version, I will remove it.
> 
> > +	ret = dma_cookie_status(chan, cookie, txstate);
> > +	spin_lock_irqsave(&c->vc.lock, flags);
> > +	if (ret == DMA_IN_PROGRESS) {
> > +		c->rx_status = mtk_uart_apdma_read(c, VFF_RPT) & VFF_RING_SIZE;
> > +		dma_set_residue(txstate, c->rx_status);
> > +	} else if (ret == DMA_COMPLETE && c->dir == DMA_DEV_TO_MEM) {
> > +		dma_set_residue(txstate, c->rx_status);
> 
> what is the point is setting residue to comleted txn, it is zero!
> 
> > +	} else {
> > +		dma_set_residue(txstate, 0);
> 
> naah that doesnt sound correct!
> 
Next version, I will modify the function.

> > +static void mtk_uart_apdma_config_write(struct dma_chan *chan,
> > +			       struct dma_slave_config *cfg,
> > +			       enum dma_transfer_direction dir)
> > +{
> > +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> > +	struct mtk_uart_apdmadev *mtkd =
> > +				to_mtk_uart_apdma_dev(c->vc.chan.device);
> > +	unsigned int tmp;
> > +
> > +	if (mtk_uart_apdma_read(c, VFF_EN) == VFF_EN_B)
> > +		return;
> > +
> > +	c->dir = dir;
> > +
> > +	if (dir == DMA_DEV_TO_MEM) {
> > +		tmp = cfg->src_addr_width * 1024;
> 
> why multiply by 1024?
> 
Next version, I will modify the this, with 'src_port_window_size' &&
'dst_port_window_size'.

> > +static int mtk_uart_apdma_device_pause(struct dma_chan *chan)
> > +{
> > +	/* just for check caps pass */
> > +	return 0;
> > +}
> 
> please remove, this is not a mandatory fn

Can't remove it. Before the mail, i had explained it. in 8250 uart
framework, will check the function..

thanks.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
