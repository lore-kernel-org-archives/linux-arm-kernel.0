From: jacopo+renesas@jmondi.org (Jacopo Mondi)
Date: Fri, 11 May 2018 11:59:59 +0200
Subject: [PATCH 0/3] arm64: dts: Draak: Enable HDMI input and VIN4
Message-ID: <1526032802-14376-1-git-send-email-jacopo+renesas@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
   this series enables HDMI input and VIN4 on R-Car D3 Draak board.

The Draak board has an HDMI input connected to an HDMI decoder that feeds
the VIN capture interface through its parallel video interface.

The series requires the just sent:
[PATCH 0/5] rcar-vin: Add support for digital input on Gen3

and enables image capture operations on D3 Draak board.

The series has been developed on top of media-master tree but applies cleanly
on top of latest renesas-driver.

Geert: would you like a topic branch for this series to be included in
renesas-drivers?

Patches for testing are available at:
git://jmondi.org/linux d3/media-master/driver
git://jmondi.org/linux d3/media-master/dts
git://jmondi.org/linux d3/media-master/test
git://jmondi.org/vin-tests d3

Thanks
    j

Jacopo Mondi (3):
  dt-bindings: media: rcar-vin: Add R8A77995 support
  arm64: dts: renesas: r8a77995: Add VIN4
  arm64: dts: renesas: draak: Describe HDMI input

 .../devicetree/bindings/media/rcar_vin.txt         |  1 +
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts     | 68 ++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a77995.dtsi          | 11 ++++
 3 files changed, 80 insertions(+)

--
2.7.4
