From: yong.wu@mediatek.com (Yong Wu)
Date: Tue, 1 Mar 2016 05:04:19 +0800
Subject: [PATCH 2/2] iommu/mediatek: mark PM functions as __maybe_unused
In-Reply-To: <1456737553-496245-2-git-send-email-arnd@arndb.de>
References: <1456737553-496245-1-git-send-email-arnd@arndb.de>
 <1456737553-496245-2-git-send-email-arnd@arndb.de>
Message-ID: <1456779859.26149.2.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-02-29 at 10:19 +0100, Arnd Bergmann wrote:
> When CONFIG_PM is unset, we get a harmless warning for this driver:
> 
> drivers/iommu/mtk_iommu.c:665:12: error: 'mtk_iommu_suspend' defined but not used [-Werror=unused-function]
> drivers/iommu/mtk_iommu.c:680:12: error: 'mtk_iommu_resume' defined but not used [-Werror=unused-function]
> 
> Marking the functions as __maybe_unused gits rid of the two functions
> and lets the compiler silently drop the object code, while still
> doing syntax checking on them for build-time verification.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 0df4fabe208d ("iommu/mediatek: Add mt8173 IOMMU driver")

Hi Arnd,
  Thanks very much for both fixes.
