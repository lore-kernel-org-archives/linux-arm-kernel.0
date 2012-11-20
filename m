From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Nov 2012 00:04:51 +0900
Subject: [GIT PULL 2/7] Samsung hdmi for v3.8
Message-ID: <50AB9C13.9090900@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

This is for adding support for DT based exynos5250 hdmi and it adds 
device node for hdmi, mixer, hdmiphy and hdmiddc.

Please pull Samsung hdmi for v3.8 from:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/hdmi-samsung

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 8f0d8163b50e01f398b14bcd4dc039ac5ab18d64:

   Linux 3.7-rc3 (2012-10-28 12:24:48 -0700)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/hdmi-samsung

Rahul Sharma (6):
       ARM: dts: add device tree support for exynos5 hdmi
       ARM: dts: add device tree support for exynos5 mixer
       ARM: dts: add device tree support for exynos5 hdmiphy
       ARM: dts: add device tree support for exynos5 hdmiddc
       ARM: EXYNOS: add clocks for exynos5 hdmi
       ARM: EXYNOS: removing exynos-drm device registration from non-dt 
platforms

  .../devicetree/bindings/drm/exynos/hdmi.txt        |   22 +++++++++++++++
  .../devicetree/bindings/drm/exynos/hdmiddc.txt     |   12 ++++++++
  .../devicetree/bindings/drm/exynos/hdmiphy.txt     |   12 ++++++++
  .../devicetree/bindings/drm/exynos/mixer.txt       |   15 ++++++++++
  arch/arm/boot/dts/exynos5250-smdk5250.dts          |   24 +++++++++++++++-
  arch/arm/boot/dts/exynos5250.dtsi                  |   20 +++++++++++++
  arch/arm/mach-exynos/Makefile                      |    1 -
  arch/arm/mach-exynos/clock-exynos5.c               |   14 ++++++++-
  arch/arm/mach-exynos/dev-drm.c                     |   29 
--------------------
  arch/arm/mach-exynos/mach-exynos5-dt.c             |    8 +++++
  arch/arm/mach-exynos/mach-nuri.c                   |    3 --
  arch/arm/mach-exynos/mach-origen.c                 |    3 --
  arch/arm/mach-exynos/mach-smdk4x12.c               |    3 --
  arch/arm/mach-exynos/mach-smdkv310.c               |    3 --
  arch/arm/mach-exynos/mach-universal_c210.c         |    3 --
  arch/arm/plat-samsung/include/plat/devs.h          |    2 -
  16 files changed, 124 insertions(+), 50 deletions(-)
  create mode 100644 Documentation/devicetree/bindings/drm/exynos/hdmi.txt
  create mode 100644 
Documentation/devicetree/bindings/drm/exynos/hdmiddc.txt
  create mode 100644 
Documentation/devicetree/bindings/drm/exynos/hdmiphy.txt
  create mode 100644 Documentation/devicetree/bindings/drm/exynos/mixer.txt
  delete mode 100644 arch/arm/mach-exynos/dev-drm.c
