From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 02 Sep 2015 17:52:37 +0200
Subject: [GIT PULL] Reset controller fixes for v4.3
Message-ID: <1441209157.3279.49.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc maintainers,

This tags fixes a build error in COMPILE_TEST configurations with
RESET_CONTROLLER disabled and fixes a missing spinlock initialization.
Because of the build issue, it would be great if this could make it into
v4.3-rc1.

regards
Philipp

The following changes since commit 5d44595c2627f7edcd8c24a76b13bd115f9fc2da:

  Merge branch 'reset/ath79' into reset/next (2015-08-16 17:11:20 +0200)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.3-fixes

for you to fetch changes up to f319cb8491e1b4cc44e7baeeb3ae7817dedf57fc:

  reset: ath79: Fix missing spin_lock_init (2015-09-01 14:48:40 +0200)

----------------------------------------------------------------
Reset controller fixes for v4.3

- added stubs to avoid build breakage in COMPILE_TEST
  configurations with RESET_CONTROLLER disabled
- fixed missing spinlock initialization in ath79 driver

----------------------------------------------------------------
Axel Lin (2):
      reset: Add (devm_)reset_control_get stub functions
      reset: ath79: Fix missing spin_lock_init

 drivers/reset/reset-ath79.c |  1 +
 include/linux/reset.h       | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
