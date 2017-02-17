From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 17 Feb 2017 11:56:14 +0100
Subject: [GIT PULL] Reset controller fixes for 4.10
Message-ID: <1487328974.3107.24.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

any chance this small fix can still make it into v4.10?

regards
Philipp

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  https://git.pengutronix.de/git/pza/linux tags/reset-for-4.10-fixes

for you to fetch changes up to e5a1dadec3648019a838b85357b67f241fbb02e8:

  reset: fix shared reset triggered_count decrement on error (2017-02-17 08:11:47 +0100)

----------------------------------------------------------------
Reset controller fixes for v4.10

- Remove erroneous negation of the error check of the reset function
  to decrement trigger_count in the error case, not on success. This
  fixes shared resets to actually only trigger once, as intended.

----------------------------------------------------------------
Jerome Brunet (1):
      reset: fix shared reset triggered_count decrement on error

 drivers/reset/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
