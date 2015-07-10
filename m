From: s-anna@ti.com (Suman Anna)
Date: Fri, 10 Jul 2015 12:28:54 -0500
Subject: [PATCH 0/2] Add missing #iommu-cells on IOMMU nodes
Message-ID: <1436549336-33456-1-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

This series adds the #iommu-cells property to the existing
IOMMU nodes on OMAP4 & OMAP5. It was already fixed for OMAP3
in commit 2055088b5e17 ("ARM: dts: omap3: Add #iommu-cells to
isp and iva iommu").

OMAP4 and OMAP5 do not yet have users for these IOMMUs (remoteproc
nodes), so the warning as seen with the fix added for OMAP3 is not
seen yet, but will as soon as a user is added.

Patches based on 4.2-rc1.

regards
Suman

Suman Anna (2):
  ARM: dts: OMAP4: Add #iommu-cells property to IOMMUs
  ARM: dts: OMAP5: Add #iommu-cells property to IOMMUs

 arch/arm/boot/dts/omap4.dtsi | 2 ++
 arch/arm/boot/dts/omap5.dtsi | 2 ++
 2 files changed, 4 insertions(+)

-- 
2.4.4
