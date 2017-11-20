From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 20 Nov 2017 15:19:53 +0100
Subject: [PATCH v2 0/4] ARM64: dts: meson-gx: fix VPU init for non-vendor
 u-boot
Message-ID: <1511187597-18248-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the Amlogic Gx SoCs (GXBB, GXL & GXM), the VPU power domain is initialized
by the vendor U-Boot code, but running mainline U-boot has been possible
on these SoCs. But lacking such init made the system lock at kernel boot.

A PM Power Domain driver has been pushed at [1] to solve the main issue.

This patchset depends on the the following patchsets :
- [1] soc: amlogic: add support for Meson GX VPU Domains
- [2] reset: meson: add level reset support for GX SoC family
- [3] clk: meson: gxbb: Add VPU and VAPB clocks

Changes since v1 at [4] :
 - Dropped hdmi-supply in hdmi node until 4.16
 - set 5v regulator always-on for now

[1] https://lkml.kernel.org/r/1508228167-11753-1-git-send-email-narmstrong at baylibre.com
[2] https://lkml.kernel.org/r/1508167573-17396-1-git-send-email-narmstrong at baylibre.com
[3] https://lkml.kernel.org/r/1508168085-19032-1-git-send-email-narmstrong at baylibre.com
[4] https://lkml.kernel.org/r/1508228951-12384-1-git-send-email-narmstrong at baylibre.com

Neil Armstrong (4):
  ARM64: dts: meson-gx: add VPU power domain
  ARM64: dts: meson-gx: Add HDMI_5V regulator on selected boards
  ARM64: dts: meson-gx: grow reset controller memory zone
  ARM64: dts: odroid-c2: Add HDMI and CEC Nodes

 .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi | 12 ++++++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          | 13 ++++++-
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 30 +++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 43 ++++++++++++++++++++++
 .../dts/amlogic/meson-gxl-s905x-libretech-cc.dts   | 12 ++++++
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi     | 12 ++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         | 43 ++++++++++++++++++++++
 .../boot/dts/amlogic/meson-gxm-khadas-vim2.dts     | 12 ++++++
 8 files changed, 176 insertions(+), 1 deletion(-)

-- 
2.7.4
