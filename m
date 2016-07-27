From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Wed, 27 Jul 2016 16:39:39 -0700
Subject: [PATCH v4 4/6] arm64/dma-mapping: Implement DMA_ATTR_PRIVILEGED
In-Reply-To: <f6fa75a9-ce70-e6c5-fd51-2af502bc2f67@arm.com> (Robin Murphy's
 message of "Tue, 26 Jul 2016 16:05:17 +0100")
References: <20160725191649.13414-1-mitchelh@codeaurora.org>
 <20160725191649.13414-5-mitchelh@codeaurora.org>
 <f6fa75a9-ce70-e6c5-fd51-2af502bc2f67@arm.com>
Message-ID: <vnkweg6e6478.fsf@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26 2016 at 04:05:17 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> +	if (attrs & DMA_ATTR_PRIVILEGED)
> +		prot |= IOMMU_PRIV;
> +
>
> then drop the rest of the changes to the switch statement below. It's
> taken me an embarrassingly long time to work out why things were blowing
> up in __iommu_sync_single_for_device() all with a VA of phys_to_virt(0) ;)

Ah yes, that is much nicer!  Nice catch...

> With that change, for the whole series:
>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Tested-by: Robin Murphy <robin.murphy@arm.com>
>
> I guess at this point it may be worth waiting to repost based on -rc1.
> Be sure to CC patch 5 to Vinod as the current dmaengine maintainer, as
> it's his ack we'll need on that.

Thanks for the review and test.  I'll go ahead and send a v5 series
since I'm actually leaving QuIC this Friday and so I won't be around to
send it next week...


-Mitch

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
