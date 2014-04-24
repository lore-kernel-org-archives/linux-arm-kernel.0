From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 24 Apr 2014 17:40:14 +0100
Subject: [PATCH 0/4] Versatile Express fixes for 3.15
Message-ID: <1398357618-11050-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd, Kevin, Olof,

This is a short set of Versatile Express fixes for 3.15. I've re-posted
them, because the last one wasn't reviewed publicly yet.

It is pretty straight forward, so if you feel comfortable about it,
please pull from the tag below. If not, I'll rebase the series on rc3
next week and send a normal pull request.

Thanks!

Pawel


The following changes since commit a798c10faf62a505d24e5f6213fbaf904a39623f:

  Linux 3.15-rc2 (2014-04-20 11:08:50 -0700)

are available in the git repository at:

  git://git.linaro.org/people/pawel.moll/linux.git tags/vexpress/fixes-for-3.15

for you to fetch changes up to cf2e0a73ca9ad376825c013ebaa145608abc27d7:

  ARM: vexpress/TC2: Convert OPP voltage to uV before storing (2014-04-24 17:20:50 +0100)

----------------------------------------------------------------
ARM Versatile Express fixes for 3.15

This series contains straight-forward fixes for different
Versatile Express infrastructure drivers:

- NULL pointer dereference on the error path in the clk driver
- out of boundary array access in the dcscb driver
- broken restart/power off implementation
- mis-interpreted voltage unit in the spc driver

----------------------------------------------------------------
Dan Carpenter (1):
      clk: vexpress: NULL dereference on error path

Heinrich Schuchardt (1):
      arm/mach-vexpress: array accessed out of bounds

Pawel Moll (1):
      power/reset: vexpress: Fix restart/power off operation

Punit Agrawal (1):
      ARM: vexpress/TC2: Convert OPP voltage to uV before storing

 arch/arm/mach-vexpress/dcscb.c           |  7 +++++--
 arch/arm/mach-vexpress/spc.c             |  4 ++--
 drivers/clk/versatile/clk-vexpress-osc.c |  2 +-
 drivers/power/reset/vexpress-poweroff.c  | 19 ++++++++++---------
 4 files changed, 18 insertions(+), 14 deletions(-)

-- 
1.8.3.2
