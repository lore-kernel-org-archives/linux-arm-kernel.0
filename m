From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 17 Oct 2017 09:38:00 +0200
Subject: [PATCH 0/2] soc: amlogic: add support for Meson GX VPU Domains
Message-ID: <1508225882-8795-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the Amlogic Gx SoCs (GXBB, GXL & GXM), the VPU power domain is initialized
by the vendor U-Boot code, but running mainline U-boot has been possible
on these SoCs. But lacking such init made the system lock at kernel boot.

This patchset adds the Video Processing Unit power domain driver to enable
the same power-on and power-down sequences and was designed to allow booting
with the power domain already initialized or not.

This driver has been tested on :
- Odroid-C2 (GXBB) with Vendor and Mainline U-Boot
- P212 (GXL) with Vendor and Mainline U-Boot
- Khadas Vim (GXL) with Vendor U-Boot
- Khadas Vim2 with (GXM) Vendor U-Boot

Neil Armstrong (2):
  soc: amlogic: add Meson GX VPU Domains driver
  dt-bindings: power: add amlogic meeson power domain bindings

 .../bindings/power/amlogic,meson-gx-pwrc.txt       |  65 ++++++
 drivers/soc/amlogic/Kconfig                        |  10 +
 drivers/soc/amlogic/Makefile                       |   1 +
 drivers/soc/amlogic/meson-gx-pwrc-vpu.c            | 234 +++++++++++++++++++++
 4 files changed, 310 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt
 create mode 100644 drivers/soc/amlogic/meson-gx-pwrc-vpu.c

-- 
2.7.4
