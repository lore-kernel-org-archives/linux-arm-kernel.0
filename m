From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 21 Mar 2017 18:35:43 +0100
Subject: [GIT PULL] Reset controller fixes for v4.11
Message-ID: <1490117743.6403.8.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

please consider merging this tag, which completes an already merged
commit in case the RESET_CONTROLLER config option is disabled.

I have already sent a few patches that make use of the new behaviour
introduced by commit bb475230b8e5 ("reset: make optional functions
really optional"). It would be nice if those could be merged for v4.11,
as without this fix they could cause drivers to fail probing if
RESET_CONTROLLER is disabled.

regards
Philipp

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-fixes-for-4.11

for you to fetch changes up to 0ca10b60ceeb5372da01798ca68c116ae45a6eb6:

  reset: fix optional reset_control_get stubs to return NULL (2017-03-21 18:19:43 +0100)

----------------------------------------------------------------
Reset controller fixes for v4.11

Fix optional reset_control_get_stubs to return NULL and remove warnings
from reset_control_* stubs.
This fixes commit bb475230b8e5 ("reset: make optional  functions really
optional"), which was merged in reset-for-4.11, and would cause consumer
drivers depending on the new behaviour of optional resets to fail probing
if RESET_CONTROLLER Kconfig option is disabled.

----------------------------------------------------------------
Philipp Zabel (1):
      reset: fix optional reset_control_get stubs to return NULL

 include/linux/reset.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)
