From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Thu, 13 Dec 2012 22:06:00 +0530
Subject: [PATCH v3 0/2] Enable ehci and ohci devices for exynos5250
Message-ID: <1355416562-25539-1-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes from v2:
 - Changed the compatible string to chip specific(samsung,exynos4210),
   since ehci-s5p and ohci-exynos are being used from exynso4210 onwards.
 - Based on changes for drivers available at:
   http://www.mail-archive.com/devicetree-discuss at lists.ozlabs.org/msg23218.html

Changes from v1:
 - Changed the device node names from 'ehci' and 'ohci' to
   'usb at 12110000' and 'usb at 12120000' as per discussion for the
   change 'http://www.spinics.net/lists/linux-usb/msg73993.html'
 - Rebased on for-next branch of linux-samsung.

Vivek Gautam (2):
  ARM: Exynos5250: Enabling ehci-s5p driver
  ARM: Exynos5250: Enabling ohci-exynos driver

 .../devicetree/bindings/usb/exynos-usb.txt         |   40 ++++++++++++++++++++
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |    4 ++
 arch/arm/boot/dts/exynos5250.dtsi                  |   12 ++++++
 arch/arm/mach-exynos/include/mach/map.h            |    2 +
 arch/arm/mach-exynos/mach-exynos5-dt.c             |    4 ++
 5 files changed, 62 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/exynos-usb.txt

-- 
1.7.6.5
