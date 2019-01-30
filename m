Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5084C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:50:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A37B921473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m+Or6R7t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0Gi6IUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37B921473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fDauDNeEMvI7JXazZN4F0pOIyRQbQ4KetC3nMr3FLpQ=; b=m+Or6R7tq3v5YG
	Tk/AvpoA5JVx4ZGufLIFNaMXZXVvZSwLZuLDjY2ErcQVVlN0+DFeM2xs9VNCQhCMWRHfaFG3O9REx
	/VVGrxdJRR4DWOfMjZaix/PgcVsUR0QNPcTIuwwW0PMf9sPDQ52oTThCpLzDYoiQ1RiS4/wVytA23
	UcjEPhE+1F1vteg1yf8/EroASLJvt2sfsg420ItJvuiCHI3d8SdBf9mznREm8JqcOUOZhJDXq2YC/
	elEeeBW3meFwkavh9v2J4adsz7Mh77+545ldCUqWM/0cckc1gNUuZ5KdctJq6NgTXnobtoKCWomF3
	q3sl5ZBVnUwHkDRTy7/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gos7r-0004Py-Hy; Wed, 30 Jan 2019 15:50:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gos7f-0004Cs-OE; Wed, 30 Jan 2019 15:50:04 +0000
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4063121473;
 Wed, 30 Jan 2019 15:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548863395;
 bh=+INOyHZAeZt27HReDRQNgCdW/5pwXbyqrHJoIGYAwHA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f0Gi6IUeLtioxqatr7i0DNPhfTdOzXHsjtPn06LuC5R5Pu9LvHwaiF6cORC215d2O
 b+pzwQbSR2yn4fc54wZNHqpkt2JyDlmSNYCyv6lGcUF9YjrjthrDD7vcnkDqKIQZ3h
 SKqtLWr8NnftuEyaPR+kyDo/zw9U2bw9D17VvJJU=
Date: Wed, 30 Jan 2019 09:49:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: honghui.zhang@mediatek.com
Subject: Re: [PATCH] PCI: Mediatek: Use resource_size function on resource
 object
Message-ID: <20190130154950.GD229773@google.com>
References: <1546409033-20412-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546409033-20412-1-git-send-email-honghui.zhang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_074955_933241_03299362 
X-CRM114-Status: GOOD (  15.01  )
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
Cc: youlin.pei@mediatek.com, lorenzo.pieralisi@arm.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 jianjun.wang@mediatek.com, ryder.lee@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 02, 2019 at 02:03:53PM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> drivers/pci/pcie-mediatek.c:720:13-16: WARNING: Suspicious code. resource_size is maybe missing with mem
> 
> Generated by: scripts/coccinelle/api/resource_size.cocci
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index e307166..0168376 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -654,7 +654,6 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>  	struct resource *mem = &pcie->mem;
>  	const struct mtk_pcie_soc *soc = port->pcie->soc;
>  	u32 val;
> -	size_t size;
>  	int err;
>  
>  	/* MT7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
> @@ -706,8 +705,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>  		mtk_pcie_enable_msi(port);
>  
>  	/* Set AHB to PCIe translation windows */
> -	size = mem->end - mem->start;
> -	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(size));
> +	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(resource_size(mem)));

This is actually a fairly interesting change because it effectively
changes this:

  fls(mem->end - mem->start)

to this:

  fls(mem->end - mem->start + 1)

And mem->end is the last valid address, so it changes something like
this:

  fls(0xffff)         # == 15

to this:

  fls(0x10000)        # == 16

So while this *looks* like a trivial warning fix, it likely fixes an
important bug, and it's worth pointing out what that bug is in the
changelog.

>  	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
>  
>  	val = upper_32_bits(mem->start);
> -- 
> 2.6.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
