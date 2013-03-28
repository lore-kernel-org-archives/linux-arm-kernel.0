From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 28 Mar 2013 16:29:33 +0000
Subject: [GIT PULL] Versatile Express poweroff/restart code to drivers/
Message-ID: <20130328162933.GI24039@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Anton,

Please pull these patches which move the vexpress poweroff/restart code
from arch/arm to driver/power/reset so that the code can be reused in
arm64. Thanks.


The following changes since commit a937536b868b8369b98967929045f1df54234323:

  Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-aarch64.git vexpress

for you to fetch changes up to 65deb782858128cde598ac4a9150ab7cdd29dafa:

  arm: vexpress: Decouple vexpress-poweroff implementation from machine_desc (2013-03-21 15:17:40 +0000)

----------------------------------------------------------------
Catalin Marinas (2):
      arm: vexpress: Move the poweroff/restart code to drivers/power/reset
      arm: vexpress: Decouple vexpress-poweroff implementation from machine_desc

 arch/arm/mach-vexpress/Kconfig                                   | 3 +++
 arch/arm/mach-vexpress/Makefile                                  | 2 +-
 arch/arm/mach-vexpress/v2m.c                                     | 5 -----
 drivers/power/reset/Kconfig                                      | 7 +++++++
 drivers/power/reset/Makefile                                     | 3 ++-
 .../reset.c => drivers/power/reset/vexpress-poweroff.c           | 9 +++++++--
 include/linux/vexpress.h                                         | 3 ---
 7 files changed, 20 insertions(+), 12 deletions(-)
 rename arch/arm/mach-vexpress/reset.c => drivers/power/reset/vexpress-poweroff.c (93%)
