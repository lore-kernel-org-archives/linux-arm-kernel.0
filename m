From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 28 Aug 2017 11:26:42 +0200
Subject: [PATCH v2 1/2] iommu/mediatek: Fix a build fail of m4u_type
In-Reply-To: <1503560532-24416-1-git-send-email-yong.wu@mediatek.com>
References: <1503560532-24416-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <20170828092641.mrr2qynqwxhrwhjb@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 03:42:11PM +0800, Yong Wu wrote:
> The commit ("iommu/mediatek: Enlarge the validate PA range
> for 4GB mode") introduce the following build error:
> 
>    drivers/iommu/mtk_iommu.c: In function 'mtk_iommu_hw_init':
> >> drivers/iommu/mtk_iommu.c:536:30: error: 'const struct mtk_iommu_data'
>  has no member named 'm4u_type'; did you mean 'm4u_dom'?
>      if (data->enable_4GB && data->m4u_type != M4U_MT8173) {
> 
> This patch fix it, use "m4u_plat" instead of "m4u_type".
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Applied both, thanks.
