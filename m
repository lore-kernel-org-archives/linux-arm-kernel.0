From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Sat,  9 Nov 2013 13:33:47 +0100
Subject: [PATCH 0/2] ARM: Rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY
Message-ID: <1384000429-3590-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series enables compilation of SH-Mobile drivers on both the
non-multiplatform (ARCH_SHMOBILE) and the multiplatform (ARCH_SHMOBILE_MULTI)
SH-Mobile architectures. To do so it renames ARCH_SHMOBILE to
ARCH_SHMOBILE_LEGACY and creates a new ARCH_SHMOBILE symbol selected by both
ARCH_SHMOBILE_MULTI and ARCH_SHMOBILE_LEGACY.

The second patch adds a dependency on ARCH_SHMOBILE_LEGACY to the ASoC R-Car
driver. It can be squashed with the first patch or applied separately to
minimize the risk of conflicts if desired.

Laurent Pinchart (2):
  ARM: Rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY
  ASoC: sh: rcar: Depend on ARCH_SHMOBILE_LEGACY

 arch/arm/Kconfig                  | 14 ++++++++------
 arch/arm/Makefile                 |  1 -
 arch/arm/boot/compressed/Makefile |  2 +-
 arch/arm/boot/dts/Makefile        |  2 +-
 arch/arm/mach-shmobile/Kconfig    |  8 ++++++--
 drivers/Makefile                  |  2 +-
 sound/soc/sh/Kconfig              |  1 +
 7 files changed, 18 insertions(+), 12 deletions(-)

-- 
Regards,

Laurent Pinchart
