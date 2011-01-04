From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue,  4 Jan 2011 23:56:11 +0530
Subject: [PATCH 0/5] omap2plus: Trivial build break fixes
Message-ID: <1294165576-15628-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are trivial build fixes which I found while doing some 
testing 'omap-for-linus' branch.

The series is generated against the linux-omap 'omap-for-linus' branch
and boot tested on OMAP4430 SDP and OMAP3630 ZOOM.


The following changes since commit dc69d1af9e8d9cbbabff88bb35a6782187a22229:
  Ben Gamari (1):
        omap2: Make OMAP2PLUS select OMAP_DM_TIMER


Santosh Shilimkar (5):
      omap2plus: clockdomain: Trivial fix for build break because of clktrctrl_mask
      omap2plus: prm: Trvial build break fix for undefined reference to 'omap2_prm_read_mod_reg'
      omap2plus: voltage: Trivial warning fix 'no return statement'
      omap2plus: voltage: Trivial linking fix 'undefined reference'
      omap2plus: voltage: Trivial linking fix for 'EINVAL' undeclared

 arch/arm/mach-omap2/Makefile              |    2 +-
 arch/arm/mach-omap2/clockdomain.h         |    2 +-
 arch/arm/mach-omap2/prm2xxx_3xxx.h        |   45 ++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/voltage.h |   17 ++++++++--
 4 files changed, 59 insertions(+), 7 deletions(-)
