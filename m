Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE5FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:59:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E080C2080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jNaxIIAi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zXwfmnIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E080C2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oZxEKbXx+Yv3rcGCb8hNYT5/tOP5reyL+owAaWyTKIA=; b=jNaxIIAiQwM9Hi
	nqggd84sxXaGMYUPZjPfF45ntE1QeAO68ckBwmHsgIpZVStXYte+kWbZWh7+kVf6o/d4gLxg8vf6f
	qlMjURsyi+1ni5XVuzTeZ3zoAlsc+SogpNseCxJMVH3IsWtRySFUSDMLukNsutqY4JOijT+krohjT
	MxzxKe/nMIxUgUE0W2SomPeikUTgDQ++NxfJByd966b7yQO6/8FThYjmegp7DKdw9KH6qIzLX4jvd
	Ega9ghD011xUpkec3xYFZ91R/8ORMEayqdZ5Ie6y/1UDgz7BsmzbNwCyExKheoCtf+drdiAa1lakn
	+giNAQt4rH90JvBhLTRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtAEm-0001Vb-5M; Mon, 11 Feb 2019 11:59:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAEW-0001EZ-64
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 11:58:47 +0000
Received: from localhost (unknown [117.99.91.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 53A31218D8;
 Mon, 11 Feb 2019 11:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549886323;
 bh=PtH0D97co2BL2WIoU0hRA56ddhkOq3OFNQ/QbbH3Wbo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zXwfmnIOmhm92dPSK72hJpPxK8wH7yHvCf1pI5cV9soPjDaKbIrol1YlxK4o7j83J
 NDPIfKf3iol/3WGwA+uQMZ9WQV9nG6MLIvpyXQNp7NVt5cQW2x2rYFtuhdd4wqfySX
 6S/0yaqf66NLPqBgbj/OMPbdZ4ROkxJiFEevEOrU=
Date: Mon, 11 Feb 2019 17:28:34 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH 2/3] dmaengine: at_xdmac: enhance channel errors handling
 in tasklet
Message-ID: <20190211115834.GS4296@vkoul-mobl>
References: <324b91c71a148a7694d28d9b8b4364095d9b0ebe.1549364323.git.nicolas.ferre@microchip.com>
 <ad6c3c705fbef7ba4a1b762b39b0b8e04c10b632.1549364323.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ad6c3c705fbef7ba4a1b762b39b0b8e04c10b632.1549364323.git.nicolas.ferre@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_035844_906776_E612DE41 
X-CRM114-Status: GOOD (  19.07  )
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
Cc: dmaengine@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 05-02-19, 12:03, Nicolas Ferre wrote:
> Complement the identification of errors with stoping the channel and
> dumping the descriptor that led to the error case.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>  drivers/dma/at_xdmac.c | 43 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index 37a269420435..ec7a29d8e448 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -1575,6 +1575,41 @@ static void at_xdmac_handle_cyclic(struct at_xdmac_chan *atchan)
>  		dmaengine_desc_get_callback_invoke(txd, NULL);
>  }
>  
> +static void at_xdmac_handle_error(struct at_xdmac_chan *atchan)
> +{
> +	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
> +	struct at_xdmac_desc	*bad_desc;
> +
> +	/*
> +	 * The descriptor currently at the head of the active list is
> +	 * broked. Since we don't have any way to report errors, we'll

You meant borked or broken... 

> +	 * just have to scream loudly and try to carry on.

should we carry on or abort..?

> +	 */
> +	if (atchan->irq_status & AT_XDMAC_CIS_RBEIS)
> +		dev_err(chan2dev(&atchan->chan), "read bus error!!!");
> +	if (atchan->irq_status & AT_XDMAC_CIS_WBEIS)
> +		dev_err(chan2dev(&atchan->chan), "write bus error!!!");
> +	if (atchan->irq_status & AT_XDMAC_CIS_ROIS)
> +		dev_err(chan2dev(&atchan->chan), "request overflow error!!!");
> +
> +	spin_lock_bh(&atchan->lock);
> +	/* Channel must be disabled first as it's not done automatically */
> +	at_xdmac_write(atxdmac, AT_XDMAC_GD, atchan->mask);
> +	while (at_xdmac_read(atxdmac, AT_XDMAC_GS) & atchan->mask)
> +		cpu_relax();
> +	bad_desc = list_first_entry(&atchan->xfers_list,
> +				    struct at_xdmac_desc,
> +				    xfer_node);
> +	spin_unlock_bh(&atchan->lock);
> +	/* Print bad descriptor's details if needed */

Well this is not great to look and read at, please do consider adding
empty line before comments or logical blocks..

> +	dev_dbg(chan2dev(&atchan->chan),
> +		 "%s: lld: mbr_sa=%pad, mbr_da=%pad, mbr_ubc=0x%08x\n",
> +		 __func__, &bad_desc->lld.mbr_sa, &bad_desc->lld.mbr_da,
> +		 bad_desc->lld.mbr_ubc);

not dev_err?

> +
> +	/* Then continue with usual descriptor management */
> +}
> +
>  static void at_xdmac_tasklet(unsigned long data)
>  {
>  	struct at_xdmac_chan	*atchan = (struct at_xdmac_chan *)data;
> @@ -1594,12 +1629,8 @@ static void at_xdmac_tasklet(unsigned long data)
>  		   || (atchan->irq_status & error_mask)) {
>  		struct dma_async_tx_descriptor  *txd;
>  
> -		if (atchan->irq_status & AT_XDMAC_CIS_RBEIS)
> -			dev_err(chan2dev(&atchan->chan), "read bus error!!!");
> -		if (atchan->irq_status & AT_XDMAC_CIS_WBEIS)
> -			dev_err(chan2dev(&atchan->chan), "write bus error!!!");
> -		if (atchan->irq_status & AT_XDMAC_CIS_ROIS)
> -			dev_err(chan2dev(&atchan->chan), "request overflow error!!!");
> +		if (atchan->irq_status & error_mask)
> +			at_xdmac_handle_error(atchan);
>  
>  		spin_lock(&atchan->lock);
>  		desc = list_first_entry(&atchan->xfers_list,
> -- 
> 2.17.1

-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
