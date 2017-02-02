From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 02 Feb 2017 18:37:42 +0100
Subject: [GIT PULL] Reset controller changes for v4.11, part 2
Message-ID: <1486057062.2289.89.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

Please consider merging this tag, which fixes an issue with the optional
reset control API change from the last pull request and removes any
remaining modular code from the new builtin zx2967 driver.

regards
Philipp

The following changes since commit bb475230b8e59a547ab66ac3b02572df21a580e9:

  reset: make optional functions really optional (2017-01-20 10:36:15 +0100)

are available in the git repository at:

  git://git.pengutronix.de/pza/linux tags/reset-for-4.11-2

for you to fetch changes up to 7a1ca76dba35d1a443278811fb67625f0e98a713:

  reset: make zx2967 explicitly non-modular (2017-02-02 16:32:09 +0100)

----------------------------------------------------------------
Reset controller changes for v4.11, part 2

- Fix missing NULL check in reset_control_put for optional reset control
  conversion
- Make zx2967 driver explicitly non-modular

----------------------------------------------------------------
Heiner Kallweit (1):
      reset: core: fix reset_control_put

Paul Gortmaker (1):
      reset: make zx2967 explicitly non-modular

 drivers/reset/core.c         | 2 +-
 drivers/reset/reset-zx2967.c | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)
