From: tfiga@chromium.org (Tomasz Figa)
Date: Wed, 17 Jan 2018 14:37:32 +0900
Subject: [PATCH v2 10/13] iommu/rockchip: Use IOMMU device for dma mapping
 operations
In-Reply-To: <20180116132540.18939-11-jeffy.chen@rock-chips.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
 <20180116132540.18939-11-jeffy.chen@rock-chips.com>
Message-ID: <CAAFQd5CFZj4nPcJsdndw6B1uoaTRU4MDJ7tUAjg3LiO7a72qQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 16, 2018 at 10:25 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> Use the first registered IOMMU device for dma mapping operations, and
> drop the domain platform device.
>
> This is similar to exynos iommu driver.
>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
>
> Changes in v2: None
>
>  drivers/iommu/rockchip-iommu.c | 91 +++++++++++-------------------------------
>  1 file changed, 24 insertions(+), 67 deletions(-)

Looks good to me, but we need to remove platform driver .remove(), as
it was done for Exynos IOMMU as well. With that fixed (probably
squashed to the patch that prohibits unbind):

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
