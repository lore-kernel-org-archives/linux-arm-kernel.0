Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A243C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:40:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37F3221872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jBIvKP1d";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6/pRZTd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F3221872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wIIvq9IS3Sq9oc0gn8pPq+73oVboRxGJ7ZkJevxCKlI=; b=jBIvKP1d30LkL7
	GusdyesJvRboUI9LEdvRp+3Y4Gb77NS1J5kk0w397FZpvkx1ykVM0p76qgln4c5pgrRgnwtHVHnYW
	nrbtNXWrlwTF/SxuXCv8gO38M+zeicW0+PdGsaFz+crLPrnNzZd9YK8kvx5CtBrvSbg9RkK2AU5ja
	Emnw5Z/JBD47ytphr0kEwSFpdhSi16lErbrpWR41dPmlPxfqlolv7wmvhP8CpxhN+XdZEz9MBXBdI
	f4Y9CcXftuLikgYQZwgwhsmIIISZ0s8zMO9K6cITNM1J4uSSK3XjVW269xMM5Mu5Sjjp5DRhIlN67
	6pqzSt8Xr+hkfSt0m9hw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfRZt-0004Fd-M9; Fri, 04 Jan 2019 15:40:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfRZi-00044U-7O
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 15:39:58 +0000
Received: from localhost (unknown [171.76.109.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BA8D720874;
 Fri,  4 Jan 2019 15:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546616393;
 bh=F4sKUK4O07tb0szES5xEALFkkCdT1ICUyACGH9scCuM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V6/pRZTdqXUA79btEPz7fl8tY6di/tQYeVASebVpaycbBurZTItIqUxFZCaYGDzAL
 b+DHdA97jMiC55YA9lXkP7c9CBV/hqX+DuZQRZLwR79dyVBHRguBklYYr8uxV7YaX+
 foEKLMfGNYGWA/UYbnXfPcUTYr9AL9K+nM4BcsqU=
Date: Fri, 4 Jan 2019 21:08:15 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Mesih Kilinc <mesihkilinc@gmail.com>
Subject: Re: [RFC PATCH 01/10] dma-engine: sun4i: Add a quirk to support
 different chips
Message-ID: <20190104153815.GN13372@vkoul-mobl.Dlink>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
 <864e28404a31ba24094f74fd060d11c16562e965.1543782328.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <864e28404a31ba24094f74fd060d11c16562e965.1543782328.git.mesihkilinc@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_073954_756169_7347F1A3 
X-CRM114-Status: GOOD (  12.15  )
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
 alsa-devel@alsa-project.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
 dmaengine@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 03-12-18, 00:23, Mesih Kilinc wrote:
> Allwinner suniv F1C100s has similar DMA engine to sun4i. Several
> registers has different addresses. Total dma channels, endpoint counts
> and max burst counts are also different.

So if register layout is the only diff, have you thought about using
regmap_field so that you dont care about the layout

> +struct sun4i_dma_config {
> +	u32 ndma_nr_max_channels;
> +	u32 ndma_nr_max_vchans;
> +
> +	u32 ddma_nr_max_channels;
> +	u32 ddma_nr_max_vchans;
> +
> +	u32 dma_nr_max_channels;
> +
> +        void (*set_dst_data_width)(u32 *p_cfg, s8 data_width);
> +        void (*set_src_data_width)(u32 *p_cfg, s8 data_width);

aligned please, checkpatch should warn about this stuff

>  struct sun4i_dma_dev {
> -	DECLARE_BITMAP(pchans_used, SUN4I_DMA_NR_MAX_CHANNELS);
> +	unsigned long *pchans_used;

why not bitmap?

> +static struct sun4i_dma_config sun4i_a10_dma_cfg = {
> +	.ndma_nr_max_channels	= SUN4I_NDMA_NR_MAX_CHANNELS,
> +	.ndma_nr_max_vchans	= SUN4I_NDMA_NR_MAX_VCHANS,
> +
> +	.ddma_nr_max_channels	= SUN4I_DDMA_NR_MAX_CHANNELS,
> +	.ddma_nr_max_vchans	= SUN4I_DDMA_NR_MAX_VCHANS,
> +
> +	.dma_nr_max_channels	= SUN4I_NDMA_NR_MAX_CHANNELS + 
> +		SUN4I_DDMA_NR_MAX_CHANNELS,
> +
> +	.set_dst_data_width	= set_dst_data_width_a10,
> +	.set_src_data_width	= set_src_data_width_a10,
> +	.convert_burst		= convert_burst_a10,
> +
> +	.ndma_drq_sdram		= SUN4I_NDMA_DRQ_TYPE_SDRAM,
> +	.ddma_drq_sdram		= SUN4I_DDMA_DRQ_TYPE_SDRAM,
> +
> +	.max_burst		= SUN4I_MAX_BURST,
> +};
> +
>  static const struct of_device_id sun4i_dma_match[] = {
> -	{ .compatible = "allwinner,sun4i-a10-dma" },
> +	{ .compatible = "allwinner,sun4i-a10-dma", .data = &sun4i_a10_dma_cfg },

I would prefer this to be split into two patches, first one does the
refactoring of driver (better if we split things logically) and then
addition of new one..

-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
