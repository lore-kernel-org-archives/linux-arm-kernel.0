From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 5 May 2015 16:55:38 +0200
Subject: [PATCH v6 10/25] iommu: exynos: remove useless device_add/remove
 callbacks
In-Reply-To: <1430727380-10912-11-git-send-email-m.szyprowski@samsung.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
 <1430727380-10912-11-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20150505145538.GL15736@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 04, 2015 at 10:16:05AM +0200, Marek Szyprowski wrote:
> The driver doesn't need to do anything important in device add/remove
> callbacks, because initialization will be done from device-tree specific
> callbacks added later. IOMMU groups created by current code were never
> used.

Hmm, will this remove support for iommu-groups in the exynos driver? I
am still working on the default-domain patch-set which makes iommu-group
support mandatory for iommu-drivers.


	Joerg
