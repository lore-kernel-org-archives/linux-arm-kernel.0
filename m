From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 20 Oct 2012 13:09:59 +0200
Subject: [PATCH v2 0/2] DT EHCI support for Kirkwood.
Message-ID: <1350731401-21442-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two patches add DT support to ehci-orion and convert all
existing Kirkwood DT boards to using DT to instantiate the USB host.

v1->v2: Remove the phy property from DT. The previous implementation
was not compatible with the new ideas of a USB phy node. Only orion5x
needs it anyway, and currently converting orion5x to DT is low
priority. Adding a phy node later will also not affect backwards
compatibility.

Andrew Lunn (2):
  ARM: Kirkwood: ehci-orion: Add device tree binding
  ARM: Kirkwood: Convert all DT boards to EHCI via DT.

 .../devicetree/bindings/usb/ehci-orion.txt         |   15 ++++++++
 arch/arm/boot/dts/kirkwood.dtsi                    |    7 ++++
 arch/arm/mach-kirkwood/board-dnskw.c               |    1 -
 arch/arm/mach-kirkwood/board-dockstar.c            |    1 -
 arch/arm/mach-kirkwood/board-dreamplug.c           |    1 -
 arch/arm/mach-kirkwood/board-dt.c                  |    1 +
 arch/arm/mach-kirkwood/board-goflexnet.c           |    1 -
 arch/arm/mach-kirkwood/board-ib62x0.c              |    1 -
 arch/arm/mach-kirkwood/board-iconnect.c            |    1 -
 arch/arm/mach-kirkwood/board-iomega_ix2_200.c      |    2 --
 arch/arm/mach-kirkwood/board-km_kirkwood.c         |    1 -
 arch/arm/mach-kirkwood/board-lsxl.c                |    1 -
 arch/arm/mach-kirkwood/board-ts219.c               |    1 -
 drivers/usb/host/ehci-orion.c                      |   38 ++++++++++++++++++--
 14 files changed, 58 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ehci-orion.txt

-- 
1.7.10.4
