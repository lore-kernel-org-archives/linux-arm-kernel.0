Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89FEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:25:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB4E3218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tES4P8kq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vuoMke9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4E3218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5piG6VPBlekklc1MQdV9jNmRa5FjNvf2BorY0Mh69eo=; b=tES4P8kqfCtePq
	FTdCQ+hlxE9RtczIEu/v+nrHy3jzr7E3iDBkeQdRQ7OubR5tKFQt09ueDPCATCZW4r2Z2Aqj/nkCz
	lNvMwsFwV84bnJPynLTkrGdC58hxoaxsZIXcgGIdL0slGCeHFNZ5/gXV88F8nhrm1Mp4yCIysUXPW
	GCXICgvE5tOz6iBiEu/dBMMgtisHf+dvoTIPEWZ4o1qh7XQaV8YynlMO3cYUba7+HV6G7IzkP7aAI
	VjOc/f7QIOyCwX/OYKvAXTYj84tuz1U2OntwS2t4Njw7RFneZhGolCkKeXIWflD77HHBhxXZ7S5ZF
	360sKImAQoUGD2cfMDCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfTEK-0003v8-6b; Fri, 04 Jan 2019 17:25:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfTEE-0003uL-8i
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 17:25:51 +0000
Received: from localhost (unknown [49.207.53.230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1AC4020656;
 Fri,  4 Jan 2019 17:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546622749;
 bh=2/zq3PaqLM7AzddyYYTaIENYeh7K6nFG/+3ZibIfp/c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vuoMke9HMHMhAnm/vSJOsSqo8fwvKZUmZLR1GbX8WWTtQEiOREr3LkDsE1QbzE2Le
 OS6vH8bBfxnDWTy10IX1cpQ9KUhV2w36PBrHAXIG4Zk2ZVTzQcgGVDGN0RQVatxMGx
 CuX9MvXu1skhiG2DACHZ3u4dRgsrX9KY/sTm7JJY=
Date: Fri, 4 Jan 2019 22:54:05 +0530
From: Vinod Koul <vkoul@kernel.org>
To: h00249924 <hutenghui@huawei.com>
Subject: Re: [PATCH 1/3] k3dma: Upgrade k3dma drever to support hisi_asp_dma
 hardware
Message-ID: <20190104172405.GR13372@vkoul-mobl.Dlink>
References: <1545978983-124360-1-git-send-email-hutenghui@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545978983-124360-1-git-send-email-hutenghui@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_092550_427987_A4BF7E09 
X-CRM114-Status: GOOD (  18.06  )
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
Cc: devicetree@vger.kernel.org, Youlin Wang <wwx575822@notesmail.huawei.com>,
 hanxiaolong3@hisilicon.com, suzhuangluan@hisilicon.com, hantanglei@huawei.com,
 linux-kernel@vger.kernel.org, kongfei@hisilicon.com, ninggaoyu@hisilicon.com,
 liyuequan@hisilicon.com, dmaengine@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, huangli295@hisilicon.com,
 wangyoulin1@hisilicon.com, linux-arm-kernel@lists.infradead.org,
 cash.qianli@hisilicon.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 28-12-18, 14:36, h00249924 wrote:
> From: Youlin Wang <wwx575822@notesmail.huawei.com>
> 
> There is an new "hisi-pcm-asp-dma-1.0" device added in
> "arch/arm64/boot/dts/hisilicon/hi3660.dtsi".
> So we have to add a matching id in the driver file:
> "{ .compatible = "hisilicon,hisi-pcm-asp-dma-1.0", }"
> 
> And also hisi-pcm-asp dma device needs no setting to the clock.
> So we skip this by "if" sentence on id string matching:
> "if (strcasecmp((of_id->compatible), (k3_pdma_dt_ids[0].compatible)) == 0)"
> 
> After above this driver will support both k3 and hisi_asp dma hardware.
> 
> Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
> Signed-off-by: Tanglei Han <hantanglei@huawei.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/dma/k3dma.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
> index fdec2b6..10eecc2 100644
> --- a/drivers/dma/k3dma.c
> +++ b/drivers/dma/k3dma.c
> @@ -792,6 +792,7 @@ static int k3_dma_transfer_resume(struct dma_chan *chan)
>  
>  static const struct of_device_id k3_pdma_dt_ids[] = {
>  	{ .compatible = "hisilicon,k3-dma-1.0", },
> +	{ .compatible = "hisilicon,hisi-pcm-asp-dma-1.0", },

The binding doc patch should precede this..

>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, k3_pdma_dt_ids);
> @@ -835,10 +836,12 @@ static int k3_dma_probe(struct platform_device *op)
>  				"dma-requests", &d->dma_requests);
>  	}
>  
> -	d->clk = devm_clk_get(&op->dev, NULL);
> -	if (IS_ERR(d->clk)) {
> -		dev_err(&op->dev, "no dma clk\n");
> -		return PTR_ERR(d->clk);
> +	if (strcasecmp((of_id->compatible), (k3_pdma_dt_ids[0].compatible)) == 0) {
> +		d->clk = devm_clk_get(&op->dev, NULL);

who provides clk in this case? how does this scale if you have another
compatible in future for newer version of controller?


> +		if (IS_ERR(d->clk)) {
> +			dev_err(&op->dev, "no dma clk\n");
> +			return PTR_ERR(d->clk);
> +		}
>  	}
>  
>  	irq = platform_get_irq(op, 0);
> -- 
> 1.9.1

-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
