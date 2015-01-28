From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 14:48:04 +0100
Subject: [PATCH 0/5] drm: add missing dependencies
Message-ID: <1422452889-415782-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I did lots of randconfig tests over time, which resulted in many patches,
five of which are for drm. In each of these cases, the Kconfig dependencies
are incomplete, which can lead to broken builds, and specifying the
complete dependencies solves it.

The patches are all independent from one another and solve separate
issues. Please apply.

Arnd Bergmann (5):
  drm: panel/sharp: add backlight dependency
  drm: panel/simple: add backlight dependency
  drm: rockchip: add reset controller dependency
  drm: sti: add panel dependency
  drm: msm: add missing dependencies on OF and COMMON_CLK

 drivers/gpu/drm/msm/Kconfig      | 1 +
 drivers/gpu/drm/panel/Kconfig    | 2 ++
 drivers/gpu/drm/rockchip/Kconfig | 1 +
 drivers/gpu/drm/sti/Kconfig      | 1 +
 4 files changed, 5 insertions(+)

-- 
2.1.0.rc2
