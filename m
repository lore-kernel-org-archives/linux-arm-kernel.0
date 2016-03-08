From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 08 Mar 2016 09:12:35 +0100
Subject: Reset controller changes for v4.6: shared resets
Message-ID: <1457424755.4174.12.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

this tag adds reference counted shared reset support for multiple
consumers that use the same reset line for low power states.
Also there is a cleanup patch for lpc18xx removing global variables.

regards
Philipp

The following changes since commit f673ed4d5fdc123b1552525de30741cd8dfde53f:

  reset: sti: Make reset_control_ops const (2016-02-10 10:53:38 +0100)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.6-2

for you to fetch changes up to bc2a505c3f325c1b4ce0610fbeee3000910fda61:

  reset: Add support for shared reset controls (2016-02-24 11:37:32 +0100)

----------------------------------------------------------------
Reset controller changes for v4.6

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
