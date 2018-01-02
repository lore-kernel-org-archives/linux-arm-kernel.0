From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 02 Jan 2018 10:16:37 +0100
Subject: [GIT PULL] Reset controller changes for v4.16
Message-ID: <1514884597.5080.3.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

Happy New Year! Please consider merging this tag for v4.16. It adds
Meson-AXG?reset support and fixes a few issues with the reset include
header:?device_reset_optional is fixed to be really optional, unused
headers are pruned, and useless warnings and deprecated API calls are
removed.

regards
Philipp

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.16

for you to fetch changes up to 0e5721f76252d69d424ec87a391d5ea37414b641:

  reset: meson-axg: add compatible string for Meson-AXG SoC (2017-11-27 09:16:40 +0100)

----------------------------------------------------------------
Reset controller changes for v4.16

- Fix device_reset_optional to be really optional
- Header clean up: includes, warnings, and deprecated calls.
- Add driver and bindings for the Meson-AXG SoC reset controller

----------------------------------------------------------------
Masahiro Yamada (4):
      reset: make device_reset_optional() really optional
      reset: remove remaining WARN_ON() in <linux/reset.h>
      reset: minimize the number of headers included from <linux/reset.h>
      reset: remove reset_control_get(_optional)

Yixun Lan (2):
      dt-bindings: reset: Add bindings for the Meson-AXG SoC Reset Controller
      reset: meson-axg: add compatible string for Meson-AXG SoC

 .../bindings/reset/amlogic,meson-reset.txt         |   3 +-
 drivers/reset/core.c                               |   9 +-
 drivers/reset/reset-meson.c                        |   2 +
 .../dt-bindings/reset/amlogic,meson-axg-reset.h    | 124 +++++++++++++++++++++
 include/linux/reset.h                              |  50 +++------
 5 files changed, 149 insertions(+), 39 deletions(-)
 create mode 100644 include/dt-bindings/reset/amlogic,meson-axg-reset.h
