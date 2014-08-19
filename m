From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 19 Aug 2014 17:08:27 +0200
Subject: [PATCH 0/6] Add max77802 support for Peach boards
Message-ID: <1408460913-13863-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kukjin,

Mark Brown has already queued for 3.18 the max77802 PMIC regulators
driver so now we can add support for these in the Peach Pit and Pi
DTS and also merge all the posted patches that depend on this. I've
picked all the patches I found and rebased them to be sure that they
apply cleanly on top of linux-next. Also I've taken some DT snippets
from the downstream Chrome OS 3.8 kernel DTS for devices that use
one of the regulators of these regulators has their input supply.

The series is composed of the following patches:

Javier Martinez Canillas (3):
  ARM: dts: Add Peach Pit and Pi dts entry for max77802 PMIC
  ARM: dts: Add vmmc and vqmmc supplies for Peach Pit and Pi boards
  ARM: dts: Add Peach Pit and Pi dts entry for ISL29018 sensor

Naveen Krishna Chatradhi (1):
  ARM: dts: Add thermistor dts fragment used by exynos based Peach
    boards

Rahul Sharma (2):
  ARM: dts: add hdmi regulators for exynos5800 based peach-pi board
  ARM: dts: add hdmi regulators for exynos5420 based peach-pit board

 arch/arm/boot/dts/cros-adc-thermistors.dtsi |  44 ++++
 arch/arm/boot/dts/exynos5420-peach-pit.dts  | 390 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts   | 390 ++++++++++++++++++++++++++++
 3 files changed, 824 insertions(+)
 create mode 100644 arch/arm/boot/dts/cros-adc-thermistors.dtsi

Best regards,
Javier
