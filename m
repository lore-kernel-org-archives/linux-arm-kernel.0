From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Wed, 30 Apr 2014 14:25:06 +0530
Subject: [PATCH 0/4] dts: Add usb2phy to Exynos 5250/5420
Message-ID: <1398848110-6152-1-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Next version for earlier patch-series:
[PATCH v7 0/2] dts: Add usb2phy to Exynos 5250

Based on 'for-next' branch of Kgene's linux-samsung tree.

Tested with driver side patches:
[PATCH v2 1/4] usb: ohci-exynos: Use struct device instead of platform_device
[PATCH v2 2/4] usb: ehci-exynos: Use struct device instead of platform_device
[PATCH v4 1/2] usb: ohci-exynos: Add facility to use phy provided by the generic phy framework
[PATCH v10 4/4] usb: ehci-exynos: Change to use phy provided by the generic phy framework


Changes from v7 series:
 - Added patches to enable usb 2.0 support on exynos5420;
   which include dt nodes for usb2phy as well as ehci and ohci
   controllers.

Changes from v6:
 - Splitted the patch into two:
    adding syscon nodes to Exynos5250 and Exynos5420 in first;
    and phy entry change in the second.
 - Changed the name of phandle for usb2phy from 'usb2_phy_new'
   to 'usb2_phy_gen' indicating generic phy.
 - Using clock macros in dt entries.

Kamil Debski (1):
  ARM: dts: Add usb2phy to Exynos 5250

Vivek Gautam (3):
  ARM: dts: Add sysreg sytem controller node to exynos5250 and
    exynos5420
  ARM: dts: Add usb2phy support on exynos5420
  ARM: dts: Add usb 2.0 support on exynos5420

 arch/arm/boot/dts/exynos5250.dtsi |   31 +++++++++++++++++++++++
 arch/arm/boot/dts/exynos5420.dtsi |   49 +++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

-- 
1.7.10.4
