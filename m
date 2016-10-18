From: yong.wu@mediatek.com (Yong Wu)
Date: Tue, 18 Oct 2016 19:37:18 +0800
Subject: [PATCH 1/2] iommu/mediatek: Convert M4Uv2 to iommu_fwspec
In-Reply-To: <0205bf6404b16bdebe8039bfc65570a2a6f9f960.1476704508.git.robin.murphy@arm.com>
References: <0205bf6404b16bdebe8039bfc65570a2a6f9f960.1476704508.git.robin.murphy@arm.com>
Message-ID: <1476790638.3062.1.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-10-17 at 12:49 +0100, Robin Murphy wrote:
> Our per-device data consists of the M4U instance and firmware-provided
> list of LARB IDs, which is a perfect fit for the generic iommu_fwspec
> machinery. Use that directly as a simpler alternative to the custom
> archdata code.
> 
> CC: Yong Wu <yong.wu@mediatek.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> These are fairly mechanical cleanups, so I'm pretty confident, but it
> still bears mentioning that they're only compile-tested as I don't have
> the relevant hardware.

Thanks for the improvement.

Tested-by: Yong Wu <yong.wu@mediatek.com>

> 
> Robin.
> 
>  drivers/iommu/mtk_iommu.c | 75 ++++++++++++-----------------------------------
>  1 file changed, 18 insertions(+), 57 deletions(-)
> 
[...]
