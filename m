From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 23 Jun 2017 19:25:54 +0200
Subject: [GIT PULL] ARM: actions: drivers for v4.13
In-Reply-To: <20170623172556.12618-1-afaerber@suse.de>
References: <20170623172556.12618-1-afaerber@suse.de>
Message-ID: <20170623172556.12618-5-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

This is the initial drivers pull for Actions Semi.
The Kconfig symbol is introduced in the arm and arm64 pulls.

Regards,
Andreas

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git tags/actions-drivers-for-4.13

for you to fetch changes up to d97d0f1b4630d46976b7a275c1636229c3ebf4d0:

  Merge branch 'v4.13/sps' into v4.13/drivers (2017-06-23 18:03:40 +0200)

----------------------------------------------------------------
Actions Semi SoC drivers for 4.13

This adds clock source and power domain drivers for S500/S900.

----------------------------------------------------------------
Andreas F?rber (6):
      clocksource: Add Owl timer
      clocksource: owl: Add S900 support
      dt-bindings: power: Add Owl SPS power domains
      soc: actions: Add Owl SPS
      soc: actions: owl-sps: Factor out owl_sps_set_pg() for power-gating
      Merge branch 'v4.13/sps' into v4.13/drivers

 .../devicetree/bindings/power/actions,owl-sps.txt  |  17 ++
 drivers/clocksource/Kconfig                        |   7 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/owl-timer.c                    | 172 ++++++++++++++++
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/actions/Kconfig                        |  16 ++
 drivers/soc/actions/Makefile                       |   2 +
 drivers/soc/actions/owl-sps-helper.c               |  51 +++++
 drivers/soc/actions/owl-sps.c                      | 224 +++++++++++++++++++++
 include/dt-bindings/power/owl-s500-powergate.h     |  19 ++
 include/linux/soc/actions/owl-sps.h                |  11 +
 12 files changed, 522 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/actions,owl-sps.txt
 create mode 100644 drivers/clocksource/owl-timer.c
 create mode 100644 drivers/soc/actions/Kconfig
 create mode 100644 drivers/soc/actions/Makefile
 create mode 100644 drivers/soc/actions/owl-sps-helper.c
 create mode 100644 drivers/soc/actions/owl-sps.c
 create mode 100644 include/dt-bindings/power/owl-s500-powergate.h
 create mode 100644 include/linux/soc/actions/owl-sps.h
