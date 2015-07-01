From: acourbot@nvidia.com (Alexandre Courbot)
Date: Wed, 1 Jul 2015 18:13:44 +0900
Subject: [PATCH 0/4] ARM: tegra: enable Nouveau for Jetson TK1 and Venice 2
Message-ID: <1435742028-8237-1-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With all essential kernel driver and user-space patches merged, GK20A can now
be enabled safely on Tegra124 devices. This series makes small device tree
and configuration adjustments to allow this.

It leaves the GK20A nodes ready to be used, but still disabled. Enabling the
nodes is the work of the bootloader, after it has configured VPR properly.

U-boot patches that do this are in the work. In the meantime, it is safe to
merge this kernel support.

Alexandre Courbot (3):
  ARM: tegra: Add IOMMU node to GK20A
  ARM: tegra: jetson-tk1: Add GK20A GPU DT node
  ARM: tegra: Enable Nouveau in defconfig

Thierry Reding (1):
  ARM: tegra: venice2: Add GK20A GPU DT node

 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 10 +++++++++-
 arch/arm/boot/dts/tegra124-venice2.dts    | 10 +++++++++-
 arch/arm/boot/dts/tegra124.dtsi           |  3 +++
 arch/arm/configs/tegra_defconfig          |  3 +++
 4 files changed, 24 insertions(+), 2 deletions(-)

-- 
2.4.4
