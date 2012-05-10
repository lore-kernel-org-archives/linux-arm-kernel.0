From: l.majewski@samsung.com (Lukasz Majewski)
Date: Thu, 10 May 2012 18:29:26 +0200
Subject: [PATCH RESEND 0/4] ARM: EXYNOS: Add s3c-hsotg support for Exynos4210
 and S5PV210 boards
Message-ID: <1336667370-2039-1-git-send-email-l.majewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds S3C-HSOTG UDC support for Exynos4210 and S5PV210 based targets; namely
 Universal_C210, Nuri and GONI.

Tested HW:
- Exynos4210 NURI target rev.1
- Exynos4210 Universal_C210 target rev.0
- S5PV210 GONI target

Dependencies:
- usb:hsotg:samsung USB S3C-HSOTG driver fixes and code cleanup
  patches, which have been already pulled to usb for-next branch.

http://permalink.gmane.org/gmane.linux.usb.general/62101

Those patches are enabling this UDC driver on GONI, NURI and Universal_C210 targets

Joonyoung Shim (1):
  ARM: EXYNOS: Add s3c-hsotg device support for NURI board

Lukasz Majewski (3):
  ARM: EXYNOS: Add usb otg phy control for EXYNOS4210
  ARM: EXYNOS: Add s3c-hsotg device support for GONI board
  ARM: EXYNOS: Add s3c-hsotg device support for Universal C210 board

 arch/arm/mach-exynos/Kconfig                 |    3 +
 arch/arm/mach-exynos/include/mach/irqs.h     |    1 +
 arch/arm/mach-exynos/include/mach/map.h      |    4 +
 arch/arm/mach-exynos/include/mach/regs-pmu.h |    3 +
 arch/arm/mach-exynos/mach-nuri.c             |    9 ++-
 arch/arm/mach-exynos/mach-universal_c210.c   |   10 +++
 arch/arm/mach-exynos/setup-usb-phy.c         |   95 +++++++++++++++++++-------
 arch/arm/mach-s5pv210/Kconfig                |    1 +
 arch/arm/mach-s5pv210/mach-goni.c            |    5 ++
 9 files changed, 105 insertions(+), 26 deletions(-)

-- 
1.7.2.3
