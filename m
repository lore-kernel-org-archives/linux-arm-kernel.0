From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 03 May 2016 10:52:28 +0200
Subject: [GIT PULL] Reset controller changes for v4.7: build fix and OXNAS
 driver
Message-ID: <1462265548.3617.6.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

this tag contains a stub for the device_reset() function as a build fix
for drivers that use this function when compiling without
CONFIG_RESET_CONTROLLER enabled, and a reset driver for OXNAS SoCs.

regards
Philipp

The following changes since commit 773fe72630c8aca874ec8a07ebacace4ae305a02:

  reset: lpc18xx: get rid of global variables for restart notifier (2016-03-30 15:42:07 +0200)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.7-2

for you to fetch changes up to 4113652252fad972e0c191b1e536dc74a6faebdc:

  reset: Add missing function stub for device_reset (2016-04-04 18:15:23 +0200)

----------------------------------------------------------------
Reset controller changes for v4.7

- add missing stub for device_reset
- add support for OXNAS SoCs

----------------------------------------------------------------
Daniel Lezcano (1):
      reset: Add missing function stub for device_reset

Neil Armstrong (2):
      reset: Add Oxford Semiconductor Reset Controller driver
      dt-bindings: Add Oxford Semiconductor Reset Controller bindings

 .../devicetree/bindings/reset/oxnas,reset.txt      |  58 +++++++++
 drivers/reset/Kconfig                              |   3 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-oxnas.c                        | 136 +++++++++++++++++++++
 include/linux/reset.h                              |   6 +
 5 files changed, 204 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/oxnas,reset.txt
 create mode 100644 drivers/reset/reset-oxnas.c
