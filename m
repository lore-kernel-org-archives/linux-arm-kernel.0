Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED64C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:35:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3DA2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tckyUjXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3DA2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sDpCkcjK91RXtFf4+wPDL7xv5a2deOqI31980BeLOCc=; b=tckyUjXU6KV6GI
	SQqrMaI3STFZmwHkP5nEFx3eGDAs8QPeVNt4dB3MEEiAXmT6l/8ZlhXQPsd60QvGdJMS75erBGJIq
	QLpgjyWQLAGagzd63VL2PfOZFoywLeCATeI/jugiEhnmg8tH0lnG58YKdJjP/7U7aIGNr2Job8Uls
	GtMEtXGsm/dLRN7WceIXhltQ5KmZu5zadCAR6ClbIqzjUXGTSlox6OON3YeK4aj68rU5ZjI1Ltx9B
	LUno50hMq4Lc4DbvIH2a38OXHiMf0E0gtErQCUc9zqltMxSPGkixFPiLBsZ9IUsVXJART2NFwkhhy
	HWF5DblKXjTbK+C6BqjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqzwm-0000Kj-JX; Tue, 05 Feb 2019 12:35:28 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqzwj-0000KM-Ld
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 12:35:27 +0000
X-IronPort-AV: E=Sophos;i="5.56,563,1539673200"; d="scan'208";a="26329076"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 05 Feb 2019 05:35:23 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch05.mchp-main.com
 (10.10.76.106) with Microsoft SMTP Server id 14.3.352.0; Tue, 5 Feb 2019
 05:35:23 -0700
Date: Tue, 5 Feb 2019 13:35:10 +0100
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH 3/3] dmaengine: at_xdmac: only monitor overflow errors
 for peripheral xfer
Message-ID: <20190205123509.tgvqbdik5lhrb5qb@M43218.corp.atmel.com>
Mail-Followup-To: Nicolas Ferre <nicolas.ferre@microchip.com>,
 linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-kernel@vger.kernel.org
References: <324b91c71a148a7694d28d9b8b4364095d9b0ebe.1549364323.git.nicolas.ferre@microchip.com>
 <4af293348e03a30746d8c0e5eead2f480b2f13f9.1549364323.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4af293348e03a30746d8c0e5eead2f480b2f13f9.1549364323.git.nicolas.ferre@microchip.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_043525_822060_5453F17E 
X-CRM114-Status: GOOD (  17.76  )
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

On Tue, Feb 05, 2019 at 12:03:43PM +0100, Nicolas Ferre wrote:
> The overflow error flag (ROI: Request Overflow Error) is only relevant
> for the case when the channel handles a peripheral synchronized transfer.
> Not in the case of memory to memory transfer where there is no hardware
> request signal.
> 
> Remove the use of this interrupt source in such a case. It's based on
> the first descriptor which holds the configuration for the whole
> linked list transfer.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

> ---
>  drivers/dma/at_xdmac.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index ec7a29d8e448..b558a23ffbc2 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -308,6 +308,11 @@ static inline int at_xdmac_csize(u32 maxburst)
>  	return csize;
>  };
>  
> +static inline bool at_xdmac_chan_is_peripheral_xfer(u32 cfg)
> +{
> +	return cfg & AT_XDMAC_CC_TYPE_PER_TRAN;
> +}
> +
>  static inline u8 at_xdmac_get_dwidth(u32 cfg)
>  {
>  	return (cfg & AT_XDMAC_CC_DWIDTH_MASK) >> AT_XDMAC_CC_DWIDTH_OFFSET;
> @@ -389,7 +394,13 @@ static void at_xdmac_start_xfer(struct at_xdmac_chan *atchan,
>  		 at_xdmac_chan_read(atchan, AT_XDMAC_CUBC));
>  
>  	at_xdmac_chan_write(atchan, AT_XDMAC_CID, 0xffffffff);
> -	reg = AT_XDMAC_CIE_RBEIE | AT_XDMAC_CIE_WBEIE | AT_XDMAC_CIE_ROIE;
> +	reg = AT_XDMAC_CIE_RBEIE | AT_XDMAC_CIE_WBEIE;
> +	/*
> +	 * Request Overflow Error is only for peripheral synchronized transfers
> +	 */
> +	if (at_xdmac_chan_is_peripheral_xfer(first->lld.mbr_cfg))
> +		reg |= AT_XDMAC_CIE_ROIE;
> +
>  	/*
>  	 * There is no end of list when doing cyclic dma, we need to get
>  	 * an interrupt after each periods.
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
