From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat,  7 Jan 2017 10:51:59 +0200
Subject: [PATCH 0/4] ARM: exynos: Fix Odroid U3 USB/LAN when TFTP booting
 (power sequence)
Message-ID: <20170107085203.4431-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks to Markus Reichl, I got an Odroid U3 to work with. Thanks to Peter
Chen, we got a power sequence generic library which solves my long
standing Odroid U3 problem - no LAN9730 if it was enabled by bootloader.

My previous attempts for this can be found here [0].

This patchset is based on Peter's v11 of power sequence [1].
Patchset is available also on my Github [2].

More detailed analysis is described in patch 2/4 ("ARM: dts: exynos: Fix
LAN9730 on Odroid U3 after tftpboot").


Best regards,
Krzysztof


[0] http://www.spinics.net/lists/linux-mmc/msg37386.html
[1] https://lwn.net/Articles/710736/
[2] https://github.com/krzk/linux/commits/for-next/odroid-u3-usb3503-pwrseq

Krzysztof Kozlowski (4):
  ARM: dts: exynos: Fix indentation of EHCI and OHCI ports
  ARM: dts: exynos: Fix LAN9730 on Odroid U3 after tftpboot
  ARM: exynos_defconfig: Enable power sequence for Odroid U3
  ARM: multi_v7_defconfig: Enable power sequence for Odroid U3

 arch/arm/boot/dts/exynos4.dtsi            | 24 ++++++++++++------------
 arch/arm/boot/dts/exynos4412-odroidu3.dts | 21 +++++++++++++++++++++
 arch/arm/configs/exynos_defconfig         |  2 ++
 arch/arm/configs/multi_v7_defconfig       |  1 +
 4 files changed, 36 insertions(+), 12 deletions(-)

-- 
2.9.3
