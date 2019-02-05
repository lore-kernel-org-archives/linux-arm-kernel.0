Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88166C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:34:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5673F2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Epwuovcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5673F2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n+YFpM5FN3yZCpaHf9VPpk+DFS86vAaFDRQMUxFel54=; b=EpwuovcjK/X5Sz
	hnTCorSpGBrXhd2CG4I2axiuinE0IzHDhi25r8eXs1c8ss+JpI6moiTukaOMah73IBRtsSyzX3b5U
	nSWnmHAYLaaqDqmZ1fVrEveaHdavlZRxoEmDbIIrXAbagMFuiiGupIJJb8VQT4jn9SJ1fj2tcwc5f
	Zx+Tl2K6ipoYKngUkM6vKNt01yRg7Jxg9wmRyBBaSLbsHHDJzLLLyBxwHRLjb1YXMTcPjz7hVQSqt
	kLUWG3Za/T/4wDKQZ3M0Zr+ioPhr2bdTT373oZQc4W1aZC513IYvVs4F1eePlYMh/JOCCpHLg4vLa
	i558z1hTgawR1MIxQApA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqzvM-00079x-Tv; Tue, 05 Feb 2019 12:34:00 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqzvJ-00078R-0Z
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 12:33:59 +0000
X-IronPort-AV: E=Sophos;i="5.56,563,1539673200"; d="scan'208";a="23454194"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 05 Feb 2019 05:33:55 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch05.mchp-main.com
 (10.10.76.106) with Microsoft SMTP Server id 14.3.352.0; Tue, 5 Feb 2019
 05:33:55 -0700
Date: Tue, 5 Feb 2019 13:33:41 +0100
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH 2/3] dmaengine: at_xdmac: enhance channel errors handling
 in tasklet
Message-ID: <20190205123341.blmbxuuqjswrekfm@M43218.corp.atmel.com>
Mail-Followup-To: Nicolas Ferre <nicolas.ferre@microchip.com>,
 linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-kernel@vger.kernel.org
References: <324b91c71a148a7694d28d9b8b4364095d9b0ebe.1549364323.git.nicolas.ferre@microchip.com>
 <ad6c3c705fbef7ba4a1b762b39b0b8e04c10b632.1549364323.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ad6c3c705fbef7ba4a1b762b39b0b8e04c10b632.1549364323.git.nicolas.ferre@microchip.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_043357_096512_5C09E564 
X-CRM114-Status: GOOD (  16.67  )
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
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 05, 2019 at 12:03:42PM +0100, Nicolas Ferre wrote:
> Complement the identification of errors with stoping the channel and
> dumping the descriptor that led to the error case.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

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
> +	 * just have to scream loudly and try to carry on.
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
> +	dev_dbg(chan2dev(&atchan->chan),
> +		 "%s: lld: mbr_sa=%pad, mbr_da=%pad, mbr_ubc=0x%08x\n",
> +		 __func__, &bad_desc->lld.mbr_sa, &bad_desc->lld.mbr_da,
> +		 bad_desc->lld.mbr_ubc);
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
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
