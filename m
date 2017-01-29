From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 29 Jan 2017 11:36:16 -0500
Subject: [PATCH V7 07/11] iommu: of: Handle IOMMU lookup failure with
 deferred probing or error
In-Reply-To: <1485188293-20263-8-git-send-email-sricharan@codeaurora.org>
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
 <1485188293-20263-8-git-send-email-sricharan@codeaurora.org>
Message-ID: <34a703f0-3b37-88f0-46fa-b56ab6717a42@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/23/2017 11:18 AM, Sricharan R wrote:
> @@ -107,7 +107,7 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>  	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
>  	if (ret < 0) {
>  		dma_addr = offset = 0;
> -		size = dev->coherent_dma_mask + 1;
> +		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
>  	} else {

what's happening here?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
