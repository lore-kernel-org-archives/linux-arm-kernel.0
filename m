From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 29 Aug 2016 09:56:08 +0200
Subject: [RFC PATCH 0/3] ARm64: amlogic: Introduce common GX family dtsi
Message-ID: <1472457371-1305-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new Amlogic GLX SoCs (S905X and S905D) are part of the Meson GX family so
they share some basic characteritics that can be described in a common GX
dtsi file used by the Meson GXBB and Meson GXL dtsi.

This patchset introduces the common dtsi and switches the GLX and GXBB to use
the common dtsi, the GXBB dtsi is reformated to handle this situation.

This patchset depends on Carlo Caione "ARM64: dts: amlogic: Add basic support for Amlogic S905X" [1]

[1] http://lkml.kernel.org/r/1472382113-10754-1-git-send-email-carlo at caione.org

Neil Armstrong (3):
  ARM64: dts: amlogic: Add Meson GX Family common dtsi
  ARM64: dts: amlogic: Switch Meson GXL dtsi to use common GX dtsi
  ARM64: dts: amlogic: Switch Meson GXBB dtsi to use common GX dtsi

 arch/arm64/boot/dts/amlogic/meson-gx-common.dtsi | 181 +++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi      | 320 +++++++----------------
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi       | 133 +---------
 3 files changed, 281 insertions(+), 353 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gx-common.dtsi

-- 
1.9.1
