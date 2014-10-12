From: b.galvani@gmail.com (Beniamino Galvani)
Date: Sun, 12 Oct 2014 22:01:52 +0200
Subject: [PATCH 0/3] media: rc: add support for Amlogic Meson IR receiver
Message-ID: <1413144115-23188-1-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is a driver for the IR receiver available in Amlogic Meson6 and
Meson8 SoCs. The device can operate in two modes: in "NEC" mode the
hardware can decode frames using the NEC IR protocol, while in
"general" mode the receiver simply reports the duration of pulses and
spaces for software decoding.

In order to have the maximum compatibility with different protocols
the driver implements software decoding.

The third patch (dts files) depends on some other patchsets [1][2]
that are still under review, so at the moment is not meant to be
merged.

[1] https://lkml.org/lkml/2014/10/5/162
[2] https://lkml.org/lkml/2014/10/7/712

Beniamino Galvani (3):
  media: rc: add driver for Amlogic Meson IR remote receiver
  media: rc: meson: document device tree bindings
  ARM: dts: meson: add dts nodes for IR receiver

 .../devicetree/bindings/media/meson-ir.txt         |  14 ++
 arch/arm/boot/dts/meson.dtsi                       |   7 +
 arch/arm/boot/dts/meson8-vega-s89e.dts             |   6 +
 arch/arm/boot/dts/meson8.dtsi                      |   7 +
 drivers/media/rc/Kconfig                           |  11 ++
 drivers/media/rc/Makefile                          |   1 +
 drivers/media/rc/meson-ir.c                        | 214 +++++++++++++++++++++
 7 files changed, 260 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/meson-ir.txt
 create mode 100644 drivers/media/rc/meson-ir.c

-- 
1.9.1
