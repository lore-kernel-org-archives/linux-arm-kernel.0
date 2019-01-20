Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D989C636A0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 11:06:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CB082084F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 11:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pzCeubob";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTowMNus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB082084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sHXIdxLjplzOSekGjRDSG+pAIHokwjpjepBZP2nYxg0=; b=pzCeubobWX2Myz
	IhfMfII6Hriehu21F1p60PErhHgrwZD2N8Po9bJP6PbkyubBPJpw2hoiWW/jspDHcVn35/3H83Yhk
	/wOSabHOKookZ6MTK+pjmSt7lJrONEGGN96YYR6P8pQT/DrAGwKzNiiT8F+x2eKfh0C6MahCne2QE
	GdqHdfAn+D1+cnOC3SnWKQzozX/YI3uFBNOsWXYWmeN4mt3ow1Y4Ofz02AUMFPgKqGIQq/J8y5ddo
	+0ba8nTYBNc96S8Cm/Iv1zqIfVQWmUM3knOQ3aVm8uhprRph9UUDlTH9vjS0khQwcxFqkj9fMfDAk
	SX2RDLCv1vy5OuF+WP3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glAvM-0004B3-Fx; Sun, 20 Jan 2019 11:05:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glAvI-0004Af-Tb
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 11:05:54 +0000
Received: from localhost (unknown [122.178.235.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9FC4A2084F;
 Sun, 20 Jan 2019 11:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547982351;
 bh=wG3z5ITXAES2jgkOil2PTVNtsT+82+7nAmey+q+++8k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WTowMNusXZzUjqNrxBzGneaywZIP4Pe62784EJmMx2AImSMv2NMipxCscEBgy/N4X
 2pr16/6Ly8cwIYFHQVJxFLJzPWd2yhV0Q+cgqFIM1sZmZdheJvjvJIQbxL5x17jvV2
 1Z+jz19GSPV5mhhlI4Y62qa7OrfF0nE3LmVBZvR4=
Date: Sun, 20 Jan 2019 16:34:17 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Codrin.Ciubotariu@microchip.com
Subject: Re: [PATCH] dmaengine: at_xdmac: Fix wrongfull report of a channel
 as in use
Message-ID: <20190120110417.GS4635@vkoul-mobl>
References: <20190117160957.13175-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190117160957.13175-1-codrin.ciubotariu@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_030552_999954_3D3FB462 
X-CRM114-Status: GOOD (  22.23  )
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
Cc: dmaengine@vger.kernel.org, Ludovic.Desroches@microchip.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Codrin,

On 17-01-19, 16:10, Codrin.Ciubotariu@microchip.com wrote:
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

This looks reasonable but am unable to see how the bug is fixed. Perhaps
would be great to split the bug part (which can go to fixes) and remove
the reuse of variable as a subsequent patch..

> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
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

-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
