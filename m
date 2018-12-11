Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235EFC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:15:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEDA72081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HDACsktw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEDA72081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O+zGDyv/oFLr0U4BlqmCL9SK8c+/1WJO7K3z8N86Sa8=; b=HDACsktw82D0xS
	cryj6/rs9ccJW6CwzsujMlLZwvWNSGrOf1SZ0SCEUyM8Br6GRssYapvx0NQTWUpFnv8EA38bNry7p
	hPNPKno4A1Nw+FZ5wOW4pl/Z0aVnwgj0iPLzeHHAtRT5dwF6Ut6iP/J+FJDZRcjYqMHpAcafEVRBs
	u+x3TdROcBSrzN9yqKMfB/S/YPuTKA3yMI7XO+vpB07yocxKH0jVhhWFj9FB2u0xgVF51drV2olUu
	6dRuNHCqeINxFhlzKWRJ0h9jf6eNWC9lNdamORo3mUbIl6uAVbjNA5ukMF5TNbZzQfJZK0SEUezIO
	lB0hzo3Du+2CeU1nzDMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWf4e-0000nL-0B; Tue, 11 Dec 2018 10:15:32 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWf4Z-0000mY-Dj
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 10:15:29 +0000
Received: by mail-ot1-f66.google.com with SMTP id 32so13437051ota.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 02:15:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S2/HjXQk90vqltSEB0PRcazYDDBkbE8C+8BmOZL5LpQ=;
 b=eTMVGLgwB/xSosGoD5wYc1qrgJ37vL/m2ZceAOHgq9mhOC7aou4IedIkILVOyWKgUt
 +0bp5RBCPdAU1HsMIZD3h0fO9hjULC8IdSIujNJyytbfz1T5WcSYl0HzIpFkDy48CBmH
 /sEO4/wqlcBQOLy5OSk23NwNrlXGevsSXKcKF8B2p0dxO/DGmAljM3VD7APCwQL/2gsw
 qsDfhD2WJaIUlAvY2c54gge6EZg789X5h7VDlMKg7gdy84B3qk2tlIW/mlg5W2RaXZni
 S+11rJ0vXZNXgC6sHSsNeQmJ0d1yTTHzQTbPe+SC0HtRWXQ2Hwsyg6BydsewmMG/q+7R
 eY+Q==
X-Gm-Message-State: AA+aEWbA/423tcy1bgzKDDBGAksNotQxpyABHSl4XYid6VBw4jx8lWjF
 YDnPAi1OSWYrjArxMm2aRIuPS2Nv9TR1IErqEa4=
X-Google-Smtp-Source: AFSGD/Wi5HCkN2HxAfgFPZSGZWG/PnhZqymO3DXYt4Xc+4Jc+bIM0VJtHKB3NQ2oEcaBwFndNnuglyNVvx4EOvGQyXI=
X-Received: by 2002:a9d:2062:: with SMTP id n89mr10332185ota.244.1544523315557; 
 Tue, 11 Dec 2018 02:15:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544199754.git.robin.murphy@arm.com>
 <fe956f04bfe7f8293f6205ee224b087046e40a91.1544199754.git.robin.murphy@arm.com>
In-Reply-To: <fe956f04bfe7f8293f6205ee224b087046e40a91.1544199754.git.robin.murphy@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 11 Dec 2018 11:15:04 +0100
Message-ID: <CAJZ5v0g=RSXxFWU-Yu0UA2AFV+qNoW7Q6t1S8ecydrTrHJZwXA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI / scan: Refactor _CCA enforcement
To: Robin Murphy <robin.murphy@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_021527_463286_B899E1AE 
X-CRM114-Status: GOOD (  19.14  )
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
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 7, 2018 at 5:31 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
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

The changes in this patch are fine by me:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

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
>         const struct iommu_ops *iommu;
>         u64 dma_addr = 0, size = 0;
>
> +       if (attr == DEV_DMA_NOT_SUPPORTED) {
> +               set_dma_ops(dev, &dma_dummy_ops);
> +               return 0;
> +       }
> +
>         iort_dma_setup(dev, &dma_addr, &size);
>
>         iommu = iort_iommu_configure(dev);
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 41b91af95afb..c6daca875c17 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1138,8 +1138,7 @@ int platform_dma_configure(struct device *dev)
>                 ret = of_dma_configure(dev, dev->of_node, true);
>         } else if (has_acpi_companion(dev)) {
>                 attr = acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
> -               if (attr != DEV_DMA_NOT_SUPPORTED)
> -                       ret = acpi_dma_configure(dev, attr);
> +               ret = acpi_dma_configure(dev, attr);
>         }
>
>         return ret;
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index bef17c3fca67..f899a28b90f8 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1602,8 +1602,7 @@ static int pci_dma_configure(struct device *dev)
>                 struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
>                 enum dev_dma_attr attr = acpi_get_dma_attr(adev);
>
> -               if (attr != DEV_DMA_NOT_SUPPORTED)
> -                       ret = acpi_dma_configure(dev, attr);
> +               ret = acpi_dma_configure(dev, attr);
>         }
>
>         pci_put_host_bridge_device(bridge);
> --
> 2.19.1.dirty
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
