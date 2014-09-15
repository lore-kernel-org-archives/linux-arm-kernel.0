From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Mon, 15 Sep 2014 12:52:31 +0200
Subject: [PATCH 0/3 v3] Fix Exynos USB on kernels with USB Gadget support
Message-ID: <1410778354-31210-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building a kernel with support for both USB host and USB Gadget support on
the dwc3 controller on the Exynos5 soc will go into USB OTG mode unless
otherwise specified in the dtb, which is unhelpful for boards hooked up to run
as USB host.

First patch in this set explicitely set the dual-role mode for the dwc3
controller on Peach pi and Peach pit boards to host mode. Second patch adds
similar updates for Arndale Octa as reported by Andreas F?rber. Last patch
enables gadget mode in the default exynos config to more easily catch/trigger
issues like these.

I suspect the Samsung SMDK5420 DTS might need similar changes, so it would be
great if users of those board could verify this.

Changes in v2: alphabetically sort the dts entries
Changes in v3: Add DTS updates for arndale octa

Sjoerd Simons (3):
  ARM: dts: exynos: Explicitly set dr_mode on peach-pit and peach-pi
  ARM: dts: exynos: Explicitly set dr_mode on arndale-octa
  ARM: exynos_defconfig: enable USB gadget support

 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 4 ++++
 arch/arm/boot/dts/exynos5420-peach-pit.dts    | 8 ++++++++
 arch/arm/boot/dts/exynos5420.dtsi             | 4 ++--
 arch/arm/boot/dts/exynos5800-peach-pi.dts     | 8 ++++++++
 arch/arm/configs/exynos_defconfig             | 1 +
 5 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.1.0
