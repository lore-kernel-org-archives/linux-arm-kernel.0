From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 27 Aug 2014 16:24:44 +0200
Subject: [PATCH v3 0/3] Add Atmel maXTouch support for Peach Pit
Message-ID: <1409149487-23582-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a third version of the series that adds support
for the atmel trackpad found on the Exynos5420 Peach Pit.
The first version was [0] but I missunderstood the DT
bindings since I don't have documentation about this hw.
After the feedback provided by Nick Dyer and Yufeng Shen
I think I now understand how it works and why my earlier
(wrong) attempt used to work as well.

I've dropped support for Peach Pi since the Atmel chip
in that machine uses a different T100 touchscreen object
instead of the T9 used by the touchpad in Peach Pit. And
that object is not supported by the Atmel mXT driver yet.

The first patch adds the needed DTS changes to the Peach
Pit device tree file, the second patch enables the driver
in the Exynos-specific kernel config and the third patch
enables the driver on the ARMv7 multi-platform config file.

I chose to build as a module in the later because only some
multi-platform supported machines have this touchpad device.

Javier Martinez Canillas (2):
  ARM: exynos_defconfig: Enable Atmel maXTouch support
  ARM: multi_v7_defconfig: Enable Atmel maXTouch support

Sjoerd Simons (1):
  ARM: dts: Add Peach Pit dts entry for Atmel touchpad

 arch/arm/boot/dts/exynos5420-peach-pit.dts | 31 ++++++++++++++++++++++++++++++
 arch/arm/configs/exynos_defconfig          |  1 +
 arch/arm/configs/multi_v7_defconfig        |  1 +
 3 files changed, 33 insertions(+)

Best regards,
Javier

[0]: https://lkml.org/lkml/2014/8/6/589
