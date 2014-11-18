From: b.galvani@gmail.com (Beniamino Galvani)
Date: Tue, 18 Nov 2014 21:22:32 +0100
Subject: [PATCH v3 0/3]  media: rc: add support for Amlogic Meson IR receiver
Message-ID: <1416342155-26820-1-git-send-email-b.galvani@gmail.com>
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

Changes since v2 [ https://lkml.org/lkml/2014/10/12/149 ]:
 - avoid calling rc_free_device() twice in probe error path

Changes since v1 [ https://lkml.org/lkml/2014/11/9/20 ]:
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
 drivers/media/rc/meson-ir.c                        | 216 +++++++++++++++++++++
 6 files changed, 250 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/meson-ir.txt
 create mode 100644 drivers/media/rc/meson-ir.c

-- 
1.9.1
