From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 10 Sep 2014 13:31:28 +0200
Subject: [PATCH v4 0/3] Add Atmel maXTouch support for Peach boards
Message-ID: <1410348691-18317-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kukjin,

This is a fourth version of the series that adds support
for the Atmel trackpad found on the Exynos5420 Peach Pit
and Pi boards.

Support for Pi was included again even when the driver
does not support yet the T100 touchscreen objects used
by the Atmel mXT540S chip found on the Peach Pi, since
Nick Dyer said that he will push the T100 support for
3.18. So we can queue the Peach Pi DTS snippet for 3.18
since by then the driver should already support it.
It was tested on a Peach Pi with an out-of-tree patch
that adds support the needed T100 object support.

The first patch adds the needed changes for the Peach Pit
DTS, the second patch does the same but for the Peach Pi
DTS and the third patch enables the driver in the Exynos
specific kernel configuration.

The patch that enables the driver on the ARMv7 multi-platform
config file was dropped since that is not meant to be merged
through the linux-samsung tree. I'll post a separate series
to sync exynos_defconfig and multi_v7_defconfig so those can
be picked through the arm-soc tree.

This series must be merged after [0] to avoid merge conflicts.

Javier Martinez Canillas (2):
  ARM: dts: Add Peach Pi dts entry for Atmel touchpad
  ARM: exynos_defconfig: Enable Atmel maXTouch support

Sjoerd Simons (1):
  ARM: dts: Add Peach Pit dts entry for Atmel touchpad

 arch/arm/boot/dts/exynos5420-peach-pit.dts | 29 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 28 ++++++++++++++++++++++++++++
 arch/arm/configs/exynos_defconfig          |  1 +
 3 files changed, 58 insertions(+)

Best regards,
Javier

[0]: https://lkml.org/lkml/2014/9/10/226
