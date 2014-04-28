From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Apr 2014 10:34:41 +0200
Subject: [PATCH v12 00/31] iommu/exynos: Fixes and Enhancements of System
 MMU driver with DT
In-Reply-To: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <26065037.GxQQuIURPg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 27 April 2014 13:07:32 Shaik Ameer Basha wrote:
> The current exynos-iommu(System MMU) driver does not work autonomously
> since it is lack of support for power management of peripheral blocks.
> For example, MFC device driver must ensure that its System MMU is disabled
> before MFC block is power-down not to invalidate IOTLB in the System MMU
> when I/O memory mapping is changed. Because a System MMU resides in the
> same H/W block, access to control registers of System MMU while the H/W
> block is turned off must be prohibited.
> 
> This set of changes solves the above problem with setting each System MMUs
> as the parent of the device which owns the System MMU to receive the
> information when the device is turned off or turned on.
> 
> Another big change to the driver is the support for devicetree.
> The bindings for System MMU is described in
> Documentation/devicetree/bindings/arm/samsung/system-mmu.txt

Sorry I've been absent from the review so far. Most of the patches
seem entirely reasonable to me, but I'm worried about the DT binding
aspect. We are going to see more systems shipping with IOMMUs now,
and we are seeing an increasing number of submissions for 64-bit
systems. We really have to work out what the DT representation for
IOMMUs should look like in general before adding another ad-hod
implementation that is private to one driver.

	Arnd
