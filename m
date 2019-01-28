Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8A8C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:33:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5029C20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V3NQzw/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5029C20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jygBk0yoAyN84me38/+gaJxegd5EndOlJ00xBbz9wk0=; b=V3NQzw/jGBAt5j
	V3hsxXLVHCdf2JLYSlZQaE+5IEST4lyH6ooK+JiLnuk5Js/1T21omMCvyl4q+qqRkMBqeRjjxp9va
	qVraYQ+yHQZRqUzH/9yr23OLERFWsAem/fg5IlEBmEqOphZNfH632C2mQ4++ZnM3tUus92Hvp+oOk
	CBnR5r3Ty4HbdrKDabphPc8s/afO5qrD+F9IQwL6IVDeST70okwNOIZyk7oiDWNk3aolL+cYtzEKt
	vs6j4Xr5wHatAM391P5HczgAiAZhaoY7780dPOn31w28ErMx+1MNUdMHGRM6FAJRd/aRtAVaE6jhQ
	ZC+T0/eLUMlkc0wYIDAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go3IS-00066Y-2T; Mon, 28 Jan 2019 09:33:40 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go3IP-00065i-Au
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 09:33:38 +0000
Received: from gallifrey.ext.pengutronix.de
 ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1go3IK-00083N-2i; Mon, 28 Jan 2019 10:33:32 +0100
Message-ID: <7a3c2f812b7529e23a0007c70949a02e86a4f4f2.camel@pengutronix.de>
Subject: Re: [PATCH v5 4/5] dmaengine: imx-sdma: add a test for imx8mq multi
 sdma devices
From: Lucas Stach <l.stach@pengutronix.de>
To: "Angus Ainslie (Purism)" <angus@akkea.ca>
Date: Mon, 28 Jan 2019 10:33:31 +0100
In-Reply-To: <20190128060840.31695-5-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190128060840.31695-1-angus@akkea.ca>
 <20190128060840.31695-5-angus@akkea.ca>
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_013337_527444_37FAA6B9 
X-CRM114-Status: GOOD (  17.20  )
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, angus.ainslie@puri.sm,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Sonntag, den 27.01.2019, 23:08 -0700 schrieb Angus Ainslie (Purism):
> On i.mx8mq, there are two sdma instances, and the common dma framework
> will get a channel dynamically from any available sdma instance whether
> it's the first sdma device or the second sdma device. Some IPs like
> SAI only work with sdma2 not sdma1. To make sure the sdma channel is from
> the correct sdma device, use the node pointer to match.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/dma/imx-sdma.c                | 6 ++++++
>  include/linux/platform_data/dma-imx.h | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index c4db4fe6bcc9..d5f86becf59e 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1918,11 +1918,16 @@ static int sdma_init(struct sdma_engine *sdma)
>  static bool sdma_filter_fn(struct dma_chan *chan, void *fn_param)
>  {
>  	struct sdma_channel *sdmac = to_sdma_chan(chan);
> +	struct sdma_engine *sdma = sdmac->sdma;
>  	struct imx_dma_data *data = fn_param;
>  
>  	if (!imx_dma_is_general_purpose(chan))
>  		return false;
>  
> +	/* return false if it's not the right device */
> +	if (sdma->dev->of_node != data->of_node)
> +		return false;
> +
>  	sdmac->data = *data;
>  	chan->private = &sdmac->data;
>  
> @@ -1950,6 +1955,7 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
>  	 * be set to sdmac->event_id1.
>  	 */
>  	data.dma_request2 = 0;
> +	data.of_node = ofdma->of_node;
>  
>  	return dma_request_channel(mask, sdma_filter_fn, &data);
>  }
> diff --git a/include/linux/platform_data/dma-imx.h b/include/linux/platform_data/dma-imx.h
> index 7d964e787299..9daea8d42a10 100644
> --- a/include/linux/platform_data/dma-imx.h
> +++ b/include/linux/platform_data/dma-imx.h
> @@ -55,6 +55,7 @@ struct imx_dma_data {
>  	int dma_request2; /* secondary DMA request line */
>  	enum sdma_peripheral_type peripheral_type;
>  	int priority;
> +	struct device_node *of_node;
>  };
>  
>  static inline int imx_dma_is_ipu(struct dma_chan *chan)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
