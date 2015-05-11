From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 11 May 2015 18:50:09 +0200
Subject: [PATCH] iommu: exynos: tell kmemleak to ignore 2nd level page
 tables
In-Reply-To: <20150509000544.GA29904@dtor-ws>
References: <20150509000544.GA29904@dtor-ws>
Message-ID: <20150511165008.GB10216@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 05:05:44PM -0700, Dmitry Torokhov wrote:
> From: Colin Cross <ccross@android.com>
> 
> The pointers to the 2nd level page tables are converted to 1st level
> page table entries, which means kmemleak can't find them and assumes
> they have been leaked.  Call kmemleak_ignore on the 2nd level page
> tables to prevent them from showing up in kmemleak reports.
> 
> Signed-off-by: Colin Cross <ccross@android.com>
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> ---
>  drivers/iommu/exynos-iommu.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to arm/exynos, thanks.
