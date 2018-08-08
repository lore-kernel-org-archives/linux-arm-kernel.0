From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 08 Aug 2018 08:33:54 +0200
Subject: [PATCH 1/2] iommu/rockchip: Handle errors returned from PM
 framework
In-Reply-To: <20180807085406.3863-2-marc.zyngier@arm.com>
References: <20180807085406.3863-1-marc.zyngier@arm.com>
 <20180807085406.3863-2-marc.zyngier@arm.com>
Message-ID: <1943708.zxIcSzHDJ6@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 7. August 2018, 10:54:05 CEST schrieb Marc Zyngier:
> pm_runtime_get_if_in_use can fail: either PM has been disabled
> altogether (-EINVAL), or the device hasn't been enabled yet (0).
> Sadly, the Rockchip IOMMU driver tends to conflate the two things
> by considering a non-zero return value as successful.
> 
> This has the consequence of hiding other bugs, so let's handle this
> case throughout the driver, with a WARN_ON_ONCE so that we can try
> and work out what happened.
> 
> Fixes: 0f181d3cf7d98 ("iommu/rockchip: Add runtime PM support")
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

With Rockchip platforms always selecting PM
[see other longer thread in reply to the patch]

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
