From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 31 Mar 2016 10:46:44 +0200
Subject: [GIT PULL] Reset controller changes for v4.7: shared resets
Message-ID: <1459414004.4005.10.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

this tag adds reference counted shared reset support for multiple
consumers that use the same reset line for low power states.
Also there is a cleanup patch for lpc18xx removing global variables.

This is a rebased version of the late reset-for-4.6-2 tag. The patches
are reordered so that Hans can base his USB changes on the reset/shared
branch (reset-for-4.7~1) once this is merged into arm-soc.

regards
Philipp

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.7

for you to fetch changes up to 773fe72630c8aca874ec8a07ebacace4ae305a02:

  reset: lpc18xx: get rid of global variables for restart notifier (2016-03-30 15:42:07 +0200)

----------------------------------------------------------------
Reset controller changes for v4.7

- add support for shared reset controls
- remove global variables from the lpc18xx driver

----------------------------------------------------------------
Hans de Goede (3):
      reset: Make [of_]reset_control_get[_foo] functions wrappers
      reset: Share struct reset_control between reset_control_get calls
      reset: Add support for shared reset controls

Joachim Eastwood (1):
      reset: lpc18xx: get rid of global variables for restart notifier

 drivers/reset/core.c             | 217 ++++++++++++++++++++++-----------------
 drivers/reset/reset-lpc18xx.c    |  22 ++--
 include/linux/reset-controller.h |   2 +
 include/linux/reset.h            | 188 +++++++++++++++++++++++++++------
 4 files changed, 289 insertions(+), 140 deletions(-)
