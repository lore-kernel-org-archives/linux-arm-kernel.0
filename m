From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Tue, 26 Aug 2014 09:30:28 +0200
Subject: [PATCH 0/2 v2] Fix Exynos peach USB on kernels with USB Gadget support
Message-ID: <1409038230-7242-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building a kernel with support for both USB host and USB Gadget support on
the dwc3 controller on the Exynos5 soc will go into USB OTG mode unless
otherwise specified in the dtb, which is unhelpful for boards hooked up to run
as USB host.

First patch in this set explicitely set the dual-role mode for the dwc3
controller on Peach pi and Peach pit boards to host mode. Second patch enables
gadget mode in the default exynos config to more easily catch/trigger issues
like these.

I suspect other boards base using exynos5420/5800 might need the similar fixes
(Arndale Octa and Samsung SMDK5420) to their dts files, so would be great if
folks with those board could verify this.

Changes in v2: alphabetically sort the dts entries

Sjoerd Simons (2):
  ARM: dts: exynos: Explicitly set dr_mode on peach-pit and peach-pi
  ARM: exynos_defconfig: enable USB gadget support

 arch/arm/boot/dts/exynos5420-peach-pit.dts | 8 ++++++++
 arch/arm/boot/dts/exynos5420.dtsi          | 4 ++--
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 8 ++++++++
 arch/arm/configs/exynos_defconfig          | 1 +
 4 files changed, 19 insertions(+), 2 deletions(-)

-- 
2.1.0
