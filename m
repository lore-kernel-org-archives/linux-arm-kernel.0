From: b.galvani@gmail.com (Beniamino Galvani)
Date: Sun,  9 Nov 2014 09:32:05 +0100
Subject: [PATCH v2 0/3] media: rc: add support for Amlogic Meson IR receiver
Message-ID: <1415521928-25251-1-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is a driver for the infrared receiver available in Amlogic Meson6
and Meson8 SoCs. The device can operate in two modes: "NEC" mode in
which the hardware decodes frames using the NEC IR protocol, and
"general" mode in which the receiver simply reports the duration of
pulses and spaces for software decoding.

In order to have the maximum compatibility with different protocols
the driver implements software decoding.

Changes since v1:
 - added COMPILE_TEST to allow compilation for other architectures
 - added missing header files
 - removed bogus vendor, product and version assignments
 - added file path to Meson entry in MAINTAINERS
 - reordered patches

Beniamino Galvani (3):
  media: rc: meson: document device tree bindings
  media: rc: add driver for Amlogic Meson IR remote receiver
  ARM: dts: meson: add IR receiver node

 .../devicetree/bindings/media/meson-ir.txt         |  14 ++
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/meson.dtsi                       |   7 +
 drivers/media/rc/Kconfig                           |  11 ++
 drivers/media/rc/Makefile                          |   1 +
 drivers/media/rc/meson-ir.c                        | 215 +++++++++++++++++++++
 6 files changed, 249 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/meson-ir.txt
 create mode 100644 drivers/media/rc/meson-ir.c

-- 
1.9.1
