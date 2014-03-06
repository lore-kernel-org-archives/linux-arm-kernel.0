From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 06 Mar 2014 17:20:09 +0100
Subject: [PATCH v6 00/10] Add device tree support for Exynos4 camera interface
Message-ID: <1394122819-9582-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds devicetree support for the front and rear camera of
the Exynos4412 SoC Trats2 board. It converts related drivers to use
the v4l2-async API. The SoC output clocks are provided to external image
image sensors through the common clock API.

This iteration includes three small fixes, detailed description can
be found in patches 7/10, 8/10.

I'd like to ask for a DT binding maintainer review/Ack of patch 3/10.
I'm  going to push this series to the media tree on beginning of next
week.

Thanks,
Sylwester

Sylwester Nawrocki (10):
  Documentation: dt: Add binding documentation for S5K6A3 image sensor
  Documentation: dt: Add binding documentation for S5C73M3 camera
  Documentation: devicetree: Update Samsung FIMC DT binding
  V4L: Add driver for s5k6a3 image sensor
  V4L: s5c73m3: Add device tree support
  exynos4-is: Use external s5k6a3 sensor driver
  exynos4-is: Add clock provider for the SCLK_CAM clock outputs
  exynos4-is: Add support for asynchronous subdevices registration
  ARM: dts: Add rear camera nodes for Exynos4412 TRATS2 board
  ARM: dts: exynos4: Update camera clk provider and s5k6a3 sensor node

 .../devicetree/bindings/media/samsung-fimc.txt     |   34 +-
 .../devicetree/bindings/media/samsung-s5c73m3.txt  |   97 +++++
 .../devicetree/bindings/media/samsung-s5k6a3.txt   |   33 ++
 arch/arm/boot/dts/exynos4.dtsi                     |    6 +-
 arch/arm/boot/dts/exynos4412-trats2.dts            |   86 ++++-
 drivers/media/i2c/Kconfig                          |    8 +
 drivers/media/i2c/Makefile                         |    1 +
 drivers/media/i2c/s5c73m3/s5c73m3-core.c           |  207 ++++++++---
 drivers/media/i2c/s5c73m3/s5c73m3-spi.c            |    6 +
 drivers/media/i2c/s5c73m3/s5c73m3.h                |    4 +
 drivers/media/i2c/s5k6a3.c                         |  389 ++++++++++++++++++++
 drivers/media/platform/exynos4-is/fimc-is-regs.c   |    2 +-
 drivers/media/platform/exynos4-is/fimc-is-sensor.c |  285 +-------------
 drivers/media/platform/exynos4-is/fimc-is-sensor.h |   49 +--
 drivers/media/platform/exynos4-is/fimc-is.c        |   97 ++---
 drivers/media/platform/exynos4-is/fimc-is.h        |    4 +-
 drivers/media/platform/exynos4-is/media-dev.c      |  340 ++++++++++++-----
 drivers/media/platform/exynos4-is/media-dev.h      |   32 +-
 18 files changed, 1136 insertions(+), 544 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/samsung-s5c73m3.txt
 create mode 100644 Documentation/devicetree/bindings/media/samsung-s5k6a3.txt
 create mode 100644 drivers/media/i2c/s5k6a3.c

--
1.7.9.5
