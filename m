From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Mon, 12 Jun 2017 11:23:53 -0700
Subject: [PATCH 00/11] ARM: dts: imx6qdl: video capture support
Message-ID: <1497291844-14632-1-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series defines the i.MX6 internal video multiplexers and MIPI CSI-2
receiver device nodes, and their connections to eachother and the i.MX6
IPU CSI ports.

It also implements video capture support on the SabreLite, SabreSD, and
SabreAuto reference platforms, by defining the video sensor nodes on those
platforms, and their connections to the video muxes and MIPI CSI-2 receiver.

There should not be much of anything controversial in this series. The
imx-media driver is set to be merged in time for 4.13, so please accept
this series soon.


Philipp Zabel (2):
  ARM: dts: imx6qdl: add multiplexer controls
  ARM: dts: imx6qdl: Add video multiplexers, mipi_csi, and their
    connections

Steve Longerbeam (9):
  ARM: dts: imx6qdl: Add compatible, clocks, irqs to MIPI CSI-2 node
  ARM: dts: imx6qdl: add capture-subsystem device
  ARM: dts: imx6qdl-sabrelite: remove erratum ERR006687 workaround
  ARM: dts: imx6-sabrelite: add OV5642 and OV5640 camera sensors
  ARM: dts: imx6-sabresd: add OV5642 and OV5640 camera sensors
  ARM: dts: imx6-sabreauto: create i2cmux for i2c3
  ARM: dts: imx6-sabreauto: add reset-gpios property for max7310_b
  ARM: dts: imx6-sabreauto: add pinctrl for gpt input capture
  ARM: dts: imx6-sabreauto: add the ADV7180 video decoder

 arch/arm/boot/dts/imx6dl-sabrelite.dts   |   5 +
 arch/arm/boot/dts/imx6dl-sabresd.dts     |   5 +
 arch/arm/boot/dts/imx6dl.dtsi            | 189 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6q-sabrelite.dts    |   5 +
 arch/arm/boot/dts/imx6q-sabresd.dts      |   5 +
 arch/arm/boot/dts/imx6q.dtsi             | 125 ++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 131 +++++++++++++++++----
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 152 ++++++++++++++++++++++++-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi   | 114 ++++++++++++++++++-
 arch/arm/boot/dts/imx6qdl.dtsi           |  20 +++-
 10 files changed, 724 insertions(+), 27 deletions(-)

-- 
2.7.4
