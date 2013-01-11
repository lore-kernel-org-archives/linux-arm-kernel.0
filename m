From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 11 Jan 2013 17:08:03 +0530
Subject: [PATCH] ARM: OMAP: Fix the use of uninitialized dma_lch_count
In-Reply-To: <50EFA586.5010508@asianux.com>
References: <50EE9815.2080402@asianux.com> <50EE9C87.6060407@ti.com>
 <50EFA586.5010508@asianux.com>
Message-ID: <50EFF99B.7040602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 January 2013 11:09 AM, Chen Gang wrote:
>
>    'omap_dma_reserve_channels' when used is suppose to be from command.
>      so, it alreay has value before 1st call of omap_system_dma_probe.
>      and it will never be changed again during running (not from ioctl).
>
>    but 'dma_lch_count' is zero before 1st call of omap_system_dma_probe.
>      so it will be failed for omap_dma_reserve_channels, when 1st call.
>
>    so, need use 'd->lch_count' instead of 'dma_lch_count' for judging.
>
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
Looks fine to me.

Tony,
If you are ok with the patch, can you pick this fix in your
non-critical fixes branch ?
