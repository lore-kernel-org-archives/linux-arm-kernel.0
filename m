Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED0FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:09:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3B1021720
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tI3pAHdi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3lTejcI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B1021720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OeVT0ez4cxFhkrCgigwpqgzierlMU4+k8ATS7+L9ans=; b=tI3pAHdipzecfe
	wAF8D82lpLKi/ecKrJyjtUl7yHxICm8mB9mB1CO7MN0DcAjQCGida9EFE5RnHVesRlmGWEtTr6+mP
	i3pRs0wxv2ajTiNCzLPUbEOkzrLSJK2YK/DDNlX8X/ga0oCmutp67A+lO2naKCSvK/PW+cCOU9/wH
	rHUDPrfDa9btKPsZA7aOwCSYzoSRNRQJX9jH+GT2eRSfbouMFV5byOdCdHg1j/ZWHNnBnCC87DUWf
	oRuBLz1mrdvh3xg8LPrYtIKwPx/mtctwOhOCCFObRr+n2xM3B81ysvj7biMnedU7ium7aWB371PCT
	HKj8VZjO9OvCFTCM6xiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZzwj-00058b-FJ; Thu, 20 Dec 2018 15:09:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZzwb-00057O-1G
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 15:09:07 +0000
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 113FE21720;
 Thu, 20 Dec 2018 15:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545318530;
 bh=u7C8+QJIgZn2KTlrtx/D76/p3INt0xn1OcrxfyZdLh4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=t3lTejcIcSe52bezwm4dS/kKRDpfBUNXZY6ndRj4ppLrkT9ALXnNvD43FijXONCt3
 tTs+i8Pg0gpjtu5zXPli1Jaj1UTlI2SWdHQBtyOZ1CVTtp/S/d266a21gtj67vwQaS
 bcwSEJtnaJLctE1ybZDPd0uUJTIeu+zwNJ/tmerA=
Date: Thu, 20 Dec 2018 09:08:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/2] ACPI / scan: Refactor _CCA enforcement
Message-ID: <20181220150848.GA183878@google.com>
References: <cover.1544199754.git.robin.murphy@arm.com>
 <fe956f04bfe7f8293f6205ee224b087046e40a91.1544199754.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fe956f04bfe7f8293f6205ee224b087046e40a91.1544199754.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_070901_108742_EA6BF4D9 
X-CRM114-Status: GOOD (  18.24  )
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
Cc: rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, catalin.marinas@arm.com,
 m.szyprowski@samsung.com, hch@lst.de, linux-arm-kernel@lists.infradead.org,
 lenb@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 04:31:35PM +0000, Robin Murphy wrote:
> Rather than checking the DMA attribute at each callsite, just pass it
> through for acpi_dma_configure() to handle directly. That can then deal
> with the relatively exceptional DEV_DMA_NOT_SUPPORTED case by explicitly
> installing dummy DMA ops instead of just skipping setup entirely. This
> will then free up the dev->dma_ops == NULL case for some valuable
> fastpath optimisations.
> 
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Len Brown <lenb@kernel.org>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

FWIW, if this hasn't been applied already (I think you targeted a DMA
tree):

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/acpi/scan.c      | 5 +++++
>  drivers/base/platform.c  | 3 +--
>  drivers/pci/pci-driver.c | 3 +--
>  3 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index bd1c59fb0e17..b75ae34ed188 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1456,6 +1456,11 @@ int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
>  	const struct iommu_ops *iommu;
>  	u64 dma_addr = 0, size = 0;
>  
> +	if (attr == DEV_DMA_NOT_SUPPORTED) {
> +		set_dma_ops(dev, &dma_dummy_ops);
> +		return 0;
> +	}
> +
>  	iort_dma_setup(dev, &dma_addr, &size);
>  
>  	iommu = iort_iommu_configure(dev);
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 41b91af95afb..c6daca875c17 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1138,8 +1138,7 @@ int platform_dma_configure(struct device *dev)
>  		ret = of_dma_configure(dev, dev->of_node, true);
>  	} else if (has_acpi_companion(dev)) {
>  		attr = acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
> -		if (attr != DEV_DMA_NOT_SUPPORTED)
> -			ret = acpi_dma_configure(dev, attr);
> +		ret = acpi_dma_configure(dev, attr);
>  	}
>  
>  	return ret;
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index bef17c3fca67..f899a28b90f8 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1602,8 +1602,7 @@ static int pci_dma_configure(struct device *dev)
>  		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
>  		enum dev_dma_attr attr = acpi_get_dma_attr(adev);
>  
> -		if (attr != DEV_DMA_NOT_SUPPORTED)
> -			ret = acpi_dma_configure(dev, attr);
> +		ret = acpi_dma_configure(dev, attr);
>  	}
>  
>  	pci_put_host_bridge_device(bridge);
> -- 
> 2.19.1.dirty
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
