Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C529C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:29:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A64520880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vAWo2XEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A64520880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3uPPiSzCQNcUiYb2yIGLyOu/uRDiozxOBnMB1p9wWEM=; b=vAWo2XEMyf4qeQ
	kKWSKk4Q+T/rhek/ilqpx1bu+EpVbmq3f29Vbq01DoYx8Q/KTRlCjGZsm9W0UoAbHmbdVQbQBTW9k
	i7CqOIm7UuFfB06WbVVpfMdnwnMMnGzCZBE067quyRqi68i9cH9ncXZXH514tgNpvWA0mIElH6Mjl
	SZKN/2eVzkDtLKhpFheFAOdye6eXaE/PXP+DYiAFwsjVmrYhJQvObPrYErYh6KpCYh3m1MMmGFNzb
	DQBFInDzS7iu4J5p8zvWqh3+VtS/r0zupWsRfjRbpT2R0sseCD8xmJzXrbXEBwwFnEtxEZnuyXEiW
	50QWxeRAXZb3YEOSGE0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go3EJ-0003qI-Ff; Mon, 28 Jan 2019 09:29:23 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go3EF-0003pc-68
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 09:29:20 +0000
Received: from gallifrey.ext.pengutronix.de
 ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1go3E6-0007PO-Ds; Mon, 28 Jan 2019 10:29:10 +0100
Message-ID: <3e5e2026e98a3e4ae74541c0e09e1ca4120209de.camel@pengutronix.de>
Subject: Re: [PATCH v5 1/5] dmaengine: imx-sdma: add clock ratio 1:1 check
From: Lucas Stach <l.stach@pengutronix.de>
To: "Angus Ainslie (Purism)" <angus@akkea.ca>
Date: Mon, 28 Jan 2019 10:29:07 +0100
In-Reply-To: <20190128060840.31695-2-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190128060840.31695-1-angus@akkea.ca>
 <20190128060840.31695-2-angus@akkea.ca>
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_012919_386101_2C5D0D05 
X-CRM114-Status: GOOD (  15.92  )
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
> On i.mx8 mscale B0 chip, AHB/SDMA clock ratio 2:1 can't be supportted,
> since SDMA clock ratio has to be increased to 250Mhz, AHB can't reach
> to 500Mhz, so use 1:1 instead.
> 
> Based on NXP commit MLK-16841-1 by Robin Gong <yibin.gong@nxp.com>
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/dma/imx-sdma.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 0b3a67ff8e82..757fad2fbfae 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -440,6 +440,8 @@ struct sdma_engine {
>  	unsigned int			irq;
>  	dma_addr_t			bd0_phys;
>  	struct sdma_buffer_descriptor	*bd0;
> +	/* clock ratio for AHB:SDMA core. 1:1 is 1, 2:1 is 0*/
> +	bool				clk_ratio;
>  };
>  
>  static int sdma_config_write(struct dma_chan *chan,
> @@ -662,8 +664,11 @@ static int sdma_run_channel0(struct sdma_engine *sdma)
>  		dev_err(sdma->dev, "Timeout waiting for CH0 ready\n");
>  
>  	/* Set bits of CONFIG register with dynamic context switching */
> -	if (readl(sdma->regs + SDMA_H_CONFIG) == 0)
> -		writel_relaxed(SDMA_H_CONFIG_CSM, sdma->regs + SDMA_H_CONFIG);
> +	reg = readl(sdma->regs + SDMA_H_CONFIG);
> +	if ((reg & SDMA_H_CONFIG_CSM) == 0) {
> +		reg |= SDMA_H_CONFIG_CSM;
> +		writel_relaxed(reg, sdma->regs + SDMA_H_CONFIG);
> +	}
>  
>  	return ret;
>  }
> @@ -1840,6 +1845,9 @@ static int sdma_init(struct sdma_engine *sdma)
>  	if (ret)
>  		goto disable_clk_ipg;
>  
> +	if (clk_get_rate(sdma->clk_ahb) == clk_get_rate(sdma->clk_ipg))
> +		sdma->clk_ratio = 1;
> +
>  	/* Be sure SDMA has not started yet */
>  	writel_relaxed(0, sdma->regs + SDMA_H_C0PTR);
>  
> @@ -1880,8 +1888,10 @@ static int sdma_init(struct sdma_engine *sdma)
>  	writel_relaxed(0x4050, sdma->regs + SDMA_CHN0ADDR);
>  
>  	/* Set bits of CONFIG register but with static context switching */
> -	/* FIXME: Check whether to set ACR bit depending on clock ratios */
> -	writel_relaxed(0, sdma->regs + SDMA_H_CONFIG);
> +	if (sdma->clk_ratio)
> +		writel_relaxed(SDMA_H_CONFIG_ACR, sdma->regs + SDMA_H_CONFIG);
> +	else
> +		writel_relaxed(0, sdma->regs + SDMA_H_CONFIG);
>  
>  	writel_relaxed(ccb_phys, sdma->regs + SDMA_H_C0PTR);
>  


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
