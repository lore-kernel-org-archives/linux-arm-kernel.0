Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6BFC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:13:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 056B320823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PmtQPtDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056B320823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W335lzVzl4uoOTKWNpqwPUFzCMOttCPhXsvynWOsn08=; b=PmtQPtDpMckas6
	RE0QPVTkfF2yu4bX03MYrRAHTjGMz+NbtRHekvshmSfu3mT5itkfBsfWR1rFJmPOKYOzPoR8c83bJ
	dC4H1bW+XKe30FAxtlDN6Fz76AxOvYcrOKJZaKAZx6uFprRDn2pTxoUkvsq7Filre6efx8NSXvOL5
	Te5Vgpwk8aaZPL16QVU7F5HNIGElLW7xgPe2o3XVpvssJ2pIoqu6ekhuq9bMeyj11iGCmOCnXbqK3
	UEKbvhj9PRmGmAsY4uMNL0vkEBVu5GZZiva7U+pBj4/EK6w8ghjmeXN27Al8mvknQEeVz3mXleOid
	BZDfJHQJ3Sh9OngG0lTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gls7i-0004js-9S; Tue, 22 Jan 2019 09:13:34 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gls7f-0004j7-Jh
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 09:13:33 +0000
X-IronPort-AV: E=Sophos;i="5.56,505,1539673200"; d="scan'208";a="25618244"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 22 Jan 2019 02:13:29 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch06.mchp-main.com
 (10.10.76.107) with Microsoft SMTP Server id 14.3.352.0; Tue, 22 Jan 2019
 02:13:28 -0700
Date: Tue, 22 Jan 2019 10:13:17 +0100
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: Codrin Ciubotariu - M19940 <Codrin.Ciubotariu@microchip.com>
Subject: Re: [PATCH] dmaengine: at_xdmac: Fix wrongfull report of a channel
 as in use
Message-ID: <20190122091317.47iwli4ru4iom7fg@M43218.corp.atmel.com>
Mail-Followup-To: Codrin Ciubotariu - M19940 <Codrin.Ciubotariu@microchip.com>, 
 "vkoul@kernel.org" <vkoul@kernel.org>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190117160957.13175-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190117160957.13175-1-codrin.ciubotariu@microchip.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_011331_682192_3B50D700 
X-CRM114-Status: GOOD (  19.62  )
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
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "vkoul@kernel.org" <vkoul@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 05:10:38PM +0100, Codrin Ciubotariu - M19940 wrote:
> From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> 
> atchan->status is used for two things:
>  - pass channel interrupts status from interrupt handler to tasklet;
>  - channel information like whether it is cyclic or paused;
> 
> Since these operations have nothing in common, this patch adds a
> different struct member to keep the interrupts status.
> 
> Fixes a bug in which a channel is wrongfully reported as in use when
> trying to obtain a new descriptior for a previously used cyclic channel.
> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

As Vinod suggested, you may change the commit message to emphasize
that the bug comes from the fact that a single variable is used to store
different information.

The Fixes: tag should be added too.

Regards

Ludovic

> ---
>  drivers/dma/at_xdmac.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index 4e557684f792..fe69dccfa0c0 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -203,6 +203,7 @@ struct at_xdmac_chan {
>  	u32				save_cim;
>  	u32				save_cnda;
>  	u32				save_cndc;
> +	u32				irq_status;
>  	unsigned long			status;
>  	struct tasklet_struct		tasklet;
>  	struct dma_slave_config		sconfig;
> @@ -1580,8 +1581,8 @@ static void at_xdmac_tasklet(unsigned long data)
>  	struct at_xdmac_desc	*desc;
>  	u32			error_mask;
>  
> -	dev_dbg(chan2dev(&atchan->chan), "%s: status=0x%08lx\n",
> -		 __func__, atchan->status);
> +	dev_dbg(chan2dev(&atchan->chan), "%s: status=0x%08x\n",
> +		__func__, atchan->irq_status);
>  
>  	error_mask = AT_XDMAC_CIS_RBEIS
>  		     | AT_XDMAC_CIS_WBEIS
> @@ -1589,15 +1590,15 @@ static void at_xdmac_tasklet(unsigned long data)
>  
>  	if (at_xdmac_chan_is_cyclic(atchan)) {
>  		at_xdmac_handle_cyclic(atchan);
> -	} else if ((atchan->status & AT_XDMAC_CIS_LIS)
> -		   || (atchan->status & error_mask)) {
> +	} else if ((atchan->irq_status & AT_XDMAC_CIS_LIS)
> +		   || (atchan->irq_status & error_mask)) {
>  		struct dma_async_tx_descriptor  *txd;
>  
> -		if (atchan->status & AT_XDMAC_CIS_RBEIS)
> +		if (atchan->irq_status & AT_XDMAC_CIS_RBEIS)
>  			dev_err(chan2dev(&atchan->chan), "read bus error!!!");
> -		if (atchan->status & AT_XDMAC_CIS_WBEIS)
> +		if (atchan->irq_status & AT_XDMAC_CIS_WBEIS)
>  			dev_err(chan2dev(&atchan->chan), "write bus error!!!");
> -		if (atchan->status & AT_XDMAC_CIS_ROIS)
> +		if (atchan->irq_status & AT_XDMAC_CIS_ROIS)
>  			dev_err(chan2dev(&atchan->chan), "request overflow error!!!");
>  
>  		spin_lock(&atchan->lock);
> @@ -1652,7 +1653,7 @@ static irqreturn_t at_xdmac_interrupt(int irq, void *dev_id)
>  			atchan = &atxdmac->chan[i];
>  			chan_imr = at_xdmac_chan_read(atchan, AT_XDMAC_CIM);
>  			chan_status = at_xdmac_chan_read(atchan, AT_XDMAC_CIS);
> -			atchan->status = chan_status & chan_imr;
> +			atchan->irq_status = chan_status & chan_imr;
>  			dev_vdbg(atxdmac->dma.dev,
>  				 "%s: chan%d: imr=0x%x, status=0x%x\n",
>  				 __func__, i, chan_imr, chan_status);
> @@ -1666,7 +1667,7 @@ static irqreturn_t at_xdmac_interrupt(int irq, void *dev_id)
>  				 at_xdmac_chan_read(atchan, AT_XDMAC_CDA),
>  				 at_xdmac_chan_read(atchan, AT_XDMAC_CUBC));
>  
> -			if (atchan->status & (AT_XDMAC_CIS_RBEIS | AT_XDMAC_CIS_WBEIS))
> +			if (atchan->irq_status & (AT_XDMAC_CIS_RBEIS | AT_XDMAC_CIS_WBEIS))
>  				at_xdmac_write(atxdmac, AT_XDMAC_GD, atchan->mask);
>  
>  			tasklet_schedule(&atchan->tasklet);
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
