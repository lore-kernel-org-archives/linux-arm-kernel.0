Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5272FC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:11:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 168DE2184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gMKFil/0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ulPgiD8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168DE2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BczWlL/apnCDsqHwibukaA3/FEAZ65SdW7r0A6ExRbY=; b=gMKFil/0BnEqf2
	NYDhpECs14vovSeedXjY5jtrVmcd4moBlfN/TCZ0DO/7aAvRWw+oD2snGAJ+gO44HrOfxhqvfp2tI
	w0896rBKNJy5cCpEZv+0gHOWaXad7/wgdL3EJBKDhfipZ8E8qwSvqjA4ymIK2MbXfxQkldvVRklU+
	mAcZkux4pah/pmC9Z+CzurdE/Dwx1dA0wlhtbs5w8eAZV66jmbdYmDF17YNZOZxo435tLxpoaqJSV
	c33wmD1kOUpSyc2iZVjlhgJrogi6i9yMQW3NYytiX/lfJB/3OKbfR2da1TxNGNZu6yNW9kWq91we1
	KvUArVCBCje32iOhbNAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnTMR-0000Wo-W3; Sat, 26 Jan 2019 19:11:23 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnTMO-0000WG-Ez
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 19:11:21 +0000
Received: by mail-ed1-x543.google.com with SMTP id y56so9949844edd.11
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 26 Jan 2019 11:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=lJJMAtUkS11z2VxFANMb2emLxV7qrgoiIpjlBEdkCWA=;
 b=ulPgiD8Xoe9Z6hdbUCRnkjuxqS9Eb8Mh0qRhL8ecuHUD7ymMui/dpBU0P4byzCjDcu
 FgVee+gQoDHbTiLvlhM86Wl9Qrc5Sx4kfCAgP8KlqQ+Xll27zcXQtz6MPA6c/c4TcBjI
 KOLEacA/f0GWGdZ8MDth6hqNjaUBTEaIGMOFb77DNP3O9Dpuv09lhqtXx1fBbVl273ic
 5Tp4wVqSkCklmIn1Q7+2YXzhORr+cDHH3Oa69XQ7W/RjsMWNPrpFc2cPmAOYLIS7eMl9
 ofR1qkOK7i9ydKuRDpSh3coNlbohUwygDZPjpb/6Pca4t/PXIynisYZY+kNRIATqrVnC
 OuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=lJJMAtUkS11z2VxFANMb2emLxV7qrgoiIpjlBEdkCWA=;
 b=rvQ6HN5bF+rzH5HqOIcjmVwhyYmlfUyCf2mWf9NC2UV29bIT+Pgi/Mlc68bEFQw9we
 Zo8aYLAkN8hQSv4JO9ZAvBSoJBACGbdat/uN5iIfLspZWw/7rlMxyhChTteuouvHS5u+
 GCm1oRO5PmsylkQ46hkT9iZvbWvYAGldPLLr/KThZJ38R38hOxCiZe8A6UM6sl44b2ox
 xrf29lwY16/QSAUfYy7cXJ+r31V+Ji2cNP4HwvlEhkZNSHdE06yVuc72HNF6j4qN35CU
 Ykpt0TPIGyM6Sk2bocSSZag9+CgFM2o/SmaQHQ12nmoPv5iloOhgZTecu7PpoMPHcdBV
 ufhw==
X-Gm-Message-State: AJcUukdGzs8/IPLX48Sq7QknUJDCfGwodKPXJzP6rgLUJAdeUnFbF/oN
 +55PuyRHSgMsYmvem2i3BbU=
X-Google-Smtp-Source: ALg8bN7OGmwP1lUNIKTa8DaXP1+fkm4bbntUHW83mLqyc8495FoZ3xZc7HemBynZN6YMPKBajhjCsA==
X-Received: by 2002:a50:84a9:: with SMTP id 38mr15264799edq.185.1548529877322; 
 Sat, 26 Jan 2019 11:11:17 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
 by smtp.gmail.com with ESMTPSA id g40sm12430525edg.39.2019.01.26.11.11.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 26 Jan 2019 11:11:16 -0800 (PST)
Date: Sat, 26 Jan 2019 12:11:15 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Santosh Shilimkar <ssantosh@kernel.org>
Subject: Re: [PATCH] soc: ti: knav_dma: Use proper enum in pktdma_init_chan
Message-ID: <20190126191115.GA25003@archlinux-ryzen>
References: <20181211004114.28029-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211004114.28029-1-natechancellor@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_111120_560063_62137FC9 
X-CRM114-Status: GOOD (  16.24  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 05:41:14PM -0700, Nathan Chancellor wrote:
> Clang warns when one enumerated type is implicitly converted to another:
> 
> drivers/soc/ti/knav_dma.c:601:20: warning: implicit conversion from
> enumeration type 'enum dma_data_direction' to different enumeration type
> 'enum dma_transfer_direction' [-Wenum-conversion]
>         chan->direction = DMA_NONE;
>                         ~ ^~~~~~~~
> 1 warning generated.
> 
> While DMA_NONE and DMA_TRANS_NONE have different values, there is no
> functional change because direction is never checked against DMA_NONE,
> only against DMA_MEM_TO_DEV and DMA_DEV_TO_MEM.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/soc/ti/knav_dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
> index e05ab16d9a9e..6285cd8efb21 100644
> --- a/drivers/soc/ti/knav_dma.c
> +++ b/drivers/soc/ti/knav_dma.c
> @@ -598,7 +598,7 @@ static int pktdma_init_chan(struct knav_dma_device *dma,
>  
>  	INIT_LIST_HEAD(&chan->list);
>  	chan->dma	= dma;
> -	chan->direction	= DMA_NONE;
> +	chan->direction	= DMA_TRANS_NONE;
>  	atomic_set(&chan->ref_count, 0);
>  	spin_lock_init(&chan->lock);
>  
> -- 
> 2.20.0
> 

Ping?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
