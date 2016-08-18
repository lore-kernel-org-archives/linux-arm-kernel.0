From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 18 Aug 2016 12:10:53 +0200
Subject: [PATCH 00/13] scpi: Add support for legacy SCPI protocol
Message-ID: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset aims to support the legacy SCPI firmware implementation that was
delivered as early technology preview for the JUNO platform.

Finally a stable, maintained and public implementation for the SCPI protocol
has been upstreamed part of the JUNO support and it is the recommended way
of implementing SCP communication on ARMv8 platforms.

The Amlogic GXBB platform is using this legacy protocol, as the RK3368 & RK3399
platforms.

This patchset add support for the legacy protocol in the arm_scpi.c file,
avoiding code duplication.

Last RFC discution tread can be found at : https://lkml.org/lkml/2016/8/9/210

The first patch is here to provide vendor commands on the official SCPI protocol,
it can be delayed to another patchset.

Patches 8 & 9 are only here to demo how Rockchip support could be implemented, these
patches should be delayed to a rockchip specific patchset.

The last patch depends on the "Platform MHU" dtsi patch.

Neil Armstrong (13):
  scpi: Add vendor_send_message to enable access to vendor commands
  scpi: Add alternative legacy structures and macros
  scpi: Add legacy send, prepare and handle remote functions
  scpi: Add legacy SCP functions calling legacy_scpi_send_message
  scpi: move of_match table before probe functions
  scpi: add priv_scpi_ops and fill legacy structure
  scpi: ignore init_versions failure if reported not supported
  scpi: add a vendor_msg mechanism in case the mailbox message differs
  scpi: implement rockchip support via the vendor_msg mechanism
  scpi: grow MAX_DVFS_OPPS to 16 entries
  dt-bindings: Add support for Amlogic GXBB SCPI Interface
  ARM64: dts: meson-gxbb: Add SRAM node
  ARM64: dts: meson-gxbb: Add SCPI with cpufreq & sensors Nodes

 Documentation/devicetree/bindings/arm/arm,scpi.txt |   8 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |  45 ++
 drivers/firmware/arm_scpi.c                        | 455 ++++++++++++++++++++-
 include/linux/scpi_protocol.h                      |   4 +
 4 files changed, 490 insertions(+), 22 deletions(-)

-- 
1.9.1
