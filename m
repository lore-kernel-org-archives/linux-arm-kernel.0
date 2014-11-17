From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 17 Nov 2014 18:43:01 +0100
Subject: [PATCH 0/3] ARM: dts: Add spidev nodes for Exynos Chromebooks
Message-ID: <1416246184-29071-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos Snow and Peach Pit/Pi Chromebooks have a serial dataflash that
is accessed through SPI. This series add spidev nodes in the Device
Tree source files so the flash can be accessed from user-space.

The series is composed of the following patches taken from the ChromeOS tree:

Doug Anderson (1):
  ARM: dts: Add spidev registration to exynos5250-snow

Javier Martinez Canillas (1):
  ARM: exynos_defconfig: Enable user mode SPI device support

Simon Glass (1):
  ARM: dts: Add SPI flash node for Peach boards

 arch/arm/boot/dts/exynos5250-snow.dts      | 20 ++++++++++++++++++++
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 26 ++++++++++++++++++++++++++
 arch/arm/configs/exynos_defconfig          |  1 +
 4 files changed, 73 insertions(+)

Patch #1 adds the spidev node for the Snow Chromebook, patch #2
adds the spidev node for Peach Chromebooks and peach #3 enables
support for the user mode SPI device driver.

The series were tested on Snow and Peach using:

$ flashrom -p linux_spi:dev=/dev/spidev1.0 --get-size
$ flashrom -p linux_spi:dev=/dev/spidev1.0 --flash-name

and verify that the flash can be accessed

$ set_gbb_flags 0x39

and verify that the GBB flags could be written.

Best regards,
Javier
