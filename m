Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64186C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:36:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F47F21726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="okyFA2rb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F47F21726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/plvm+3lPn2u7u8WXC1VJ15zKeOtf5TdGdjFTKCkK/c=; b=okyFA2rb7DSaQw
	ArzEKlhvgBmEorzv51vFLQHLZ1DYRNKCnXkCK+XoAWE4ouZiUv4nrNfrw5F3oK7Bfpm9UQvBGYuU4
	RWpKAlTsFD9ngIAfpOsqAVY1HsltGjhtd/5OChUHBhfG9divPDNG7j/kqSq47tXVXfj6/7H6og35w
	p0/ojHrwzAPTnO1ctKLDICeUHd/iHrk/6hVaALrYjIY8+xQZMyXb3Tx7tGs7gbCllqag6XKpcpe5S
	I1xGPcmaPMHej1fv+pCygfVk9QteVWCTfgzgX1hMZJ2WPDBlDYljWQ+gb3M4kLB6bT1LvoQMuF7r8
	P0xYhg4Mj00z2268twLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbMem-00087K-A4; Mon, 24 Dec 2018 09:36:16 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbMei-00086I-PE
 for linux-arm-kernel@lists.infradead.org; Mon, 24 Dec 2018 09:36:14 +0000
X-IronPort-AV: E=Sophos;i="5.56,391,1539673200"; d="scan'208";a="21870182"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA;
 24 Dec 2018 02:36:00 -0700
Received: from localhost (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.352.0; Mon, 24 Dec 2018
 02:36:20 -0700
Date: Mon, 24 Dec 2018 10:36:00 +0100
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: Re: [PATCH 07/20] dmaengine: at_hdmac: drop useless LIST_HEAD
Message-ID: <20181224093600.elloyxqa6lx7rw33@M43218.corp.atmel.com>
Mail-Followup-To: Julia Lawall <Julia.Lawall@lip6.fr>,
 kernel-janitors@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
 <1545555435-24576-8-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545555435-24576-8-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_013612_853979_0CB13683 
X-CRM114-Status: GOOD (  15.06  )
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Dan
 Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 23, 2018 at 09:57:02AM +0100, Julia Lawall wrote:
> Drop LIST_HEAD where the variable it declares is never used.
> 
> tmp_list has been declared since the introduction of the driver
> and has never been used.  The two declarations of list were
> introduced with the containing functions but were also not used.
> 
> The semantic patch that fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> identifier x;
> @@
> - LIST_HEAD(x);
>   ... when != x
> // </smpl>
> 
> Fixes: dc78baa2b90b ("dmaengine: at_hdmac: new driver for the Atmel AHB DMA Controller")
> Fixes: 4facfe7f09f2b ("dmaengine: hdmac: Split device_control")
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com> 

Thanks
> 
> ---
> Successfully 0-day tested on 151 configurations.
> 
>  drivers/dma/at_hdmac.c |    5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 01d936c9fe89..a0a9cd76c1d4 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -134,7 +134,6 @@ static struct at_desc *atc_desc_get(struct at_dma_chan *atchan)
>  	struct at_desc *ret = NULL;
>  	unsigned long flags;
>  	unsigned int i = 0;
> -	LIST_HEAD(tmp_list);
>  
>  	spin_lock_irqsave(&atchan->lock, flags);
>  	list_for_each_entry_safe(desc, _desc, &atchan->free_list, desc_node) {
> @@ -1387,8 +1386,6 @@ static int atc_pause(struct dma_chan *chan)
>  	int			chan_id = atchan->chan_common.chan_id;
>  	unsigned long		flags;
>  
> -	LIST_HEAD(list);
> -
>  	dev_vdbg(chan2dev(chan), "%s\n", __func__);
>  
>  	spin_lock_irqsave(&atchan->lock, flags);
> @@ -1408,8 +1405,6 @@ static int atc_resume(struct dma_chan *chan)
>  	int			chan_id = atchan->chan_common.chan_id;
>  	unsigned long		flags;
>  
> -	LIST_HEAD(list);
> -
>  	dev_vdbg(chan2dev(chan), "%s\n", __func__);
>  
>  	if (!atc_chan_is_paused(atchan))
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
