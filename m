From: elder@linaro.org (Alex Elder)
Date: Tue,  1 Apr 2014 21:04:48 -0500
Subject: [PATCH v3 0/7] clk: bcm281xx: updates for 3.15
Message-ID: <1396404296-9390-1-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series includes updates for the bcm281xx clock code for 3.15.
It is dependent on the following code, already queued for 3.15:
    https://github.com/broadcom/mach-bcm/
    Branch armsoc/for-3.15/drivers
	clk: bcm281xx: don't disable unused peripheral clocks
	clk: bcm281xx: add initial clock framework support
followed by (same repository):
    Branch armsoc/for-3.15/dt
	ARM: dts: bcm281xx: define real clocks

Previously Mike Turquette had some questions about the way
prerequisite clock support was implemented.  I have removed that
functionality as well as the bus clock that depended on it from
this series.

The patches in this series (including the three commits they depend
on) are available here:
    http://git.linaro.org/landing-teams/working/broadcom/kernel.git
    Branch review/bcm-clk-next-v3

History:
  - v3: Dropped prerequisite clock support so resolving how
	best to handle that can be resolved separately.  As
	a result, bus clock support is no longer included.
  - v2: Removed one unrelated patch from the series.

Alex Elder (7):
  clk: bcm281xx: warn if ccu_wait_bit() fails
  clk: bcm281xx: use init_data.name for clock name
  clk: bcm281xx: change some symbol names
       	Three small code improvements.

  clk: bcm281xx: initialize CCU structures statically
  clk: bcm281xx: define CCU clock data statically
	Rearrange the way CCUs and the clocks they provide are
	defined, so that they're defined statically to the extent
	possible rather than allocating and initializing things at
	runtime.

  clk: bcm281xx: add clock policy support
  clk: bcm281xx: add clock hysteresis support
	Add two new features, ultimately for the eventual purpose of
	adding support for another type of Kona clock.

 drivers/clk/bcm/clk-bcm281xx.c   |  243 +++++++++++++++++---------------------
 drivers/clk/bcm/clk-kona-setup.c |  229 +++++++++++++++++++++++++----------
 drivers/clk/bcm/clk-kona.c       |  212 +++++++++++++++++++++++++++++++--
 drivers/clk/bcm/clk-kona.h       |  160 ++++++++++++++++++++-----
 4 files changed, 611 insertions(+), 233 deletions(-)

-- 
1.7.9.5
