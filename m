From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 12 Oct 2011 10:22:54 +0200
Subject: [PATCH v4 2/2] iommu/exynos: Add iommu driver for Exynos Platforms
In-Reply-To: <000501cc88b6$0dd17d00$29747700$%cho@samsung.com>
References: <000501cc88b6$0dd17d00$29747700$%cho@samsung.com>
Message-ID: <CAK=WgbZ4RjJXjCXeN-rg84OLv1KZiWAAXXTWXknn_Gt4eioqDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi KyongHo,

On Wed, Oct 12, 2011 at 10:07 AM, KyongHo Cho <pullip.cho@samsung.com> wrote:
> +static int exynos_iommu_unmap(struct iommu_domain *domain, unsigned long
> iova,
> + ? ? ? ? ? ? ? ? ? ? ? ? ?int gfp_order)
> +{
...
> + ? ? ? return 0;
> +}

->unmap() should return the size of the unmapped region (in page order
atm); this is already expected by mainline users of the IOMMU API
today, and will also be used by the iommu core itself soon.

Ohad.
