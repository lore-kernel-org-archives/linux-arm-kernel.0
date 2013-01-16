From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Jan 2013 10:53:27 +0000
Subject: [PATCH v6 00/12] iommu/exynos: Fixes and Enhancements of System
 MMU driver with DT
In-Reply-To: <003301cde30b$c584c2d0$508e4870$%cho@samsung.com>
References: <003301cde30b$c584c2d0$508e4870$%cho@samsung.com>
Message-ID: <20130116105327.GA16543@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 26, 2012 at 01:53:15AM +0000, Cho KyongHo wrote:
> notice: v6 patch-set is rebased on next/iommu-exynos branch of
> linux-samsung.git.  This patch-set does not include 2 patches (05 and 06
> patches in v5 patch-se) because they alread exist already in the branch.

Given that devicetree-discuss has been notably absent from discussion
surrounding the proposed binding, I think that including that patch in
linux-samsung.git and dropping it from this series is rather premature.

I have comments on the binding, so I'll dig up the version you posted in v5
and add devicetree-discuss to CC.

> The current exynos-iommu(System MMU) driver does not work autonomously
> since it is lack of support for power management of peripheral blocks.
> For example, MFC device driver must ensure that its System MMU is disabled
> before MFC block is power-down not to invalidate IOTLB in the System MMU
> when I/O memory mapping is changed. Because A System MMU is resides in the
> same H/W block, access to control registers of System MMU while the H/W
> block is turned off must be prohibited.
> 
> This set of changes solves the above problem with setting each System MMUs
> as the parent of the device which owns the System MMU to recieve the
> information when the device is turned off or turned on.
> 
> Another big change to the driver is the support for devicetree.
> The bindings for System MMU is described in
> Documentation/devicetree/bindings/arm/samsung/system-mmu.txt

This should probably be Documentation/devicetree/bindings/iommu/ no?

Will
