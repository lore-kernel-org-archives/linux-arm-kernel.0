From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 23 Oct 2017 18:09:21 +0100
Subject: [PATCH v2 0/9] r8a7745/iwg22d DT rework + serial + HS-USB + IIC
Message-ID: <1508778570-28795-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series brings under the same roof a few patches that needed a v2
and that are related to either r8a7745 or iwg22d, with the goal of making
the merge process as smooth as possible.

Patches [1-4] define a new DT architecture for the iW-RainboW-G22D SODIMM
Development Platform to include the configuration with the HDMI daughter
board and to define the serial interfaces.

Patches [5-8] add USB function support to the r8a7745 SoC and to the
iwg22d board. The patches providing the definition of compatible strings:
* "renesas,r8a7745-usb-dmac", and
* "renesas,usbhs-r8a7745"
(on which these USB patches depend on) have been accepted by the
respective maintainers already, but it will take a little bit for the
definitions to appear on a renesas-devel tag. For reference:
https://patchwork.kernel.org/patch/9990063/
https://patchwork.kernel.org/patch/9987411/
https://patchwork.kernel.org/patch/9990113/

Patch 9 adds IIC cores to the r8a7745 SoC.

The patches of this series apply smoothly on top of tag:
"renesas-devel-20171018-v4.14-rc5".

Best regards,
Fab

Biju Das (4):
  ARM: dts: r8a7745: Add HS-USB device node
  ARM: dts: r8a7745: Add USB-DMAC device nodes
  ARM: dts: r8a7745: Enable DMA for HSUSB
  ARM: dts: iwg22d-sodimm: Enable HS-USB

Fabrizio Castro (5):
  ARM: dts: iwg22d: Use /dev/ttySC3 as debug console
  ARM: dts: iwg22d: Add /dev/ttySC5 support
  ARM: dts: iwg22d-sodimm-dbhd-ca: Add device tree for HDMI DB
  ARM: dts: iwg22d-sodimm: sort dt nodes
  ARM: dts: r8a7745: Add IIC cores to dtsi

 arch/arm/boot/dts/Makefile                         |  1 +
 .../arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts | 61 +++++++++++++++
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts        | 87 ++++++++++++++--------
 arch/arm/boot/dts/r8a7745.dtsi                     | 81 ++++++++++++++++++++
 4 files changed, 199 insertions(+), 31 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts

-- 
2.7.4
