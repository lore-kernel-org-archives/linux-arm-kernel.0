From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Wed, 24 Sep 2014 09:57:42 +0200
Subject: [PATCH 0/3 v4] Fix Exynos USB on kernels with USB Gadget support
In-Reply-To: <542199F4.3090601@samsung.com>
References: <542199F4.3090601@samsung.com>
Message-ID: <1411545465-12930-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Same patches as v3 but rebased on
https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/log/?h=for-next

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
Changes in v4: Rebased on todays linux-samsungs for-next branch

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
