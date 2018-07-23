From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Mon, 23 Jul 2018 15:08:18 +0100
Subject: [PATCH] iommu/arm-smmu-v3: sync the OVACKFLG to PRIQ consumer
 register
In-Reply-To: <1532350618-16486-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1532350618-16486-1-git-send-email-zhangshaokun@hisilicon.com>
Message-ID: <07622bf1-161e-3cd2-eda5-334601d077d8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/07/18 13:56, Shaokun Zhang wrote:
> From: Miao Zhong <zhongmiao@hisilicon.com>
> 
> When PRI queue occurs overflow, driver should update the OVACKFLG to
> the PRIQ consumer register, otherwise subsequent PRI requests will not
> be processed.

Since the upstream driver doesn't enable PRI in endpoints, I'm not sure
this patch makes sense on its own, but it seems correct anyway. I had a
similar patch in my initial SVA RFC, but for some reason dropped it in
later versions (https://patchwork.kernel.org/patch/9594021/)

It's worth noting that the event queue doesn't have the same problem,
because the SMMU can record new events even if the overflow hasn't been
acknowledged.

Thanks,
Jean
