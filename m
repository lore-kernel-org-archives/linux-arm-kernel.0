From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sun, 25 Nov 2012 01:45:20 +0100
Subject: [RFC 0/2] ARM: S3C24XX: Add devicetree support
Message-ID: <201211250145.21226.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series builts on my not-yet-accepted irq rework and provides the
last bits to use devicetree on s3c2416 boards. It also requires the
patch "serial: samsung: add devicetree properties for non-Exynos SoCs"
which adds the missing device names to the mapping table.

Thanks to the work of other developers all the drivers used already
support dt, so only the interrupt controllers and board support was
missing.

This of course easily expandable to the other s3c24xx SoCs in the
future.

So, while the underlying irq rework might still need changes, I'd really
like to get feedback, especially on the irq controller bindings.

The whole thing boots and runs sucessfully on my s3c2416 based board,
which shares most caracteristics and all the used gpio with the smdk2416.


Heiko Stuebner (2):
  ARM: S3C24XX: add devicetree support for interrupts
  ARM: S3C24XX: Add devicetree support and dt-board file for s3c2416 SoCs

 .../interrupt-controller/samsung,s3c24xx-irq.txt   |   57 ++++++
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/s3c2416-smdk2416.dts             |   79 ++++++++
 arch/arm/boot/dts/s3c2416.dtsi                     |  193 +++++++++++++++++++
 arch/arm/boot/dts/s3c24xx.dtsi                     |  158 ++++++++++++++++
 arch/arm/mach-s3c24xx/Kconfig                      |    9 +
 arch/arm/mach-s3c24xx/Makefile                     |    1 +
 arch/arm/mach-s3c24xx/common.h                     |    1 +
 arch/arm/mach-s3c24xx/mach-s3c2416-dt.c            |   91 +++++++++
 arch/arm/plat-s3c24xx/irq.c                        |  197 ++++++++++++++++++++
 10 files changed, 787 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24xx-irq.txt
 create mode 100644 arch/arm/boot/dts/s3c2416-smdk2416.dts
 create mode 100644 arch/arm/boot/dts/s3c2416.dtsi
 create mode 100644 arch/arm/boot/dts/s3c24xx.dtsi
 create mode 100644 arch/arm/mach-s3c24xx/mach-s3c2416-dt.c

-- 
1.7.2.3
