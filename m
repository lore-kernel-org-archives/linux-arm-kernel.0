From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 18 Aug 2014 18:57:50 +0200
Subject: [PATCH 2/2] iommu: Implement a dummy bus_set_iommu()
In-Reply-To: <1406897113-20099-2-git-send-email-thierry.reding@gmail.com>
References: <1406897113-20099-1-git-send-email-thierry.reding@gmail.com>
 <1406897113-20099-2-git-send-email-thierry.reding@gmail.com>
Message-ID: <20140818165750.GE9809@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 01, 2014 at 02:45:13PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> This allows IOMMU drivers to compile even if IOMMU_API is not selected
> and helps improve compile coverage.

IOMMU drivers usually implement the IOMMU-API, so they have a strong
dependency to it. Why do you want to compile-test an iommu driver
without testing the iommu core-code as well?


	Joerg
