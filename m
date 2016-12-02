From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat,  3 Dec 2016 00:08:47 +0100
Subject: [PATCH v2 0/2] GXL and GXM SCPI improvements
In-Reply-To: <20161123162040.24843-1-martin.blumenstingl@googlemail.com>
References: <20161123162040.24843-1-martin.blumenstingl@googlemail.com>
Message-ID: <20161202230849.11422-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds SCPI support to GXL and GXM SoCs by moving the nodes
to meson-gx.dtsi.
Now that we have SCPI support for GXM we can also use it to configure
the CPU cores using the SCPI DVFS clocks.

Changes since v1:
- added Tested-By and Acked-By tags from Neil Armstrong (thanks!)
- rebased to khilman/linux-amlogic.git/amlogic-dt64-2-v2
- updated description of patch 1 because the "arm,scpi-pre-1.0" change
  is already part of the amlogic-dt64-2-v2 tag


Martin Blumenstingl (2):
  ARM64: dts: meson-gx: move the SCPI and SRAM nodes to meson-gx
  ARM64: dts: meson-gxm: add SCPI configuration for GXM

 arch/arm64/boot/dts/amlogic/meson-gx.dtsi   | 45 +++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 57 -----------------------------
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi  |  9 +++++
 3 files changed, 54 insertions(+), 57 deletions(-)

-- 
2.10.2
