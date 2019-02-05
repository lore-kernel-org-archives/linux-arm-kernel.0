Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C810C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:31:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDF312083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qxtnyKcc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF312083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ci9bKcX8BJrvpRZeZTk8TZnGqY8VumMGcES6ZBmkQGo=; b=qxtnyKcc5m/HIA
	za9P4DFl3D2xST0pp6ru3ZtSellm6cmBPo10vcNKkY4TTNpGALYzX2a1hkI76P6CU2B7ZZWL7oK9h
	47/NG/wLaPjrUcHFQZGHhDoBXA0cVBZmSUyOUSi/3xxhqzCQSNSY4k5sFlzcXrYmjkTEt2Lc3N5HB
	zz7pKGBj2e3P73wsLGsXjF8bYn9sxucow4S/4+AKTT9lv0XyxxGmMkHJxTUC1Lz81CSrKIQVJzPnC
	8SSCFyXcmkLUE09vnWm2EAFynYR3fgqbENph8Ce8nGIYZajMSLtQ7niw4+PiTIqrBNSJNMiyNg1cg
	4JfuNwqRlqBxxgM6if9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqzse-0006WD-HT; Tue, 05 Feb 2019 12:31:12 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqzsb-0006VP-4D
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 12:31:10 +0000
X-IronPort-AV: E=Sophos;i="5.56,563,1539673200"; d="scan'208";a="26160965"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 05 Feb 2019 05:31:04 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch04.mchp-main.com
 (10.10.76.105) with Microsoft SMTP Server id 14.3.352.0; Tue, 5 Feb 2019
 05:31:04 -0700
Date: Tue, 5 Feb 2019 13:30:51 +0100
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH 1/3] dmaengine: at_xdmac: remove BUG_ON macro in tasklet
Message-ID: <20190205123051.twnr45lawslr5ccr@M43218.corp.atmel.com>
Mail-Followup-To: Nicolas Ferre <nicolas.ferre@microchip.com>,
 linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-kernel@vger.kernel.org
References: <324b91c71a148a7694d28d9b8b4364095d9b0ebe.1549364323.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <324b91c71a148a7694d28d9b8b4364095d9b0ebe.1549364323.git.nicolas.ferre@microchip.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_043109_207905_0DEC48E1 
X-CRM114-Status: GOOD (  14.56  )
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

On Tue, Feb 05, 2019 at 12:03:41PM +0100, Nicolas Ferre wrote:
> Even if this case shouldn't happen when controller is properly programmed,
> it's still better to avoid dumping a kernel Oops for this.
> As the sequence may happen only for debugging purposes, log the error and
> just finish the tasklet call.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks

> ---
>  drivers/dma/at_xdmac.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index fe69dccfa0c0..37a269420435 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -1606,7 +1606,11 @@ static void at_xdmac_tasklet(unsigned long data)
>  					struct at_xdmac_desc,
>  					xfer_node);
>  		dev_vdbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, desc);
> -		BUG_ON(!desc->active_xfer);
> +		if (!desc->active_xfer) {
> +			dev_err(chan2dev(&atchan->chan), "Xfer not active: exiting");
> +			spin_unlock_bh(&atchan->lock);
> +			return;
> +		}
>  
>  		txd = &desc->tx_dma_desc;
>  
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
