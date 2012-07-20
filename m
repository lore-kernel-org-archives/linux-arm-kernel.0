From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 20 Jul 2012 11:34:40 +0530
Subject: [RFC 0/4] OMAP Cpuidle/Suspend Cleanups
Message-ID: <1342764284-8143-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are some CPUidle/Suspend cleanup patches done by adding
some more functionality in the OMAP Powerdomain framework.
They mostly cleanup OMAP3 but the same ideas can be used/
applied for OMAP4 and beyond.

The series is based off Teros' series [1] to add usecounting
support within the OMAP Powerdomain framework.

The patches are tested with RET/OFF in CPUidle and Suspend
on 3630 beagle Xm and 3430 SDP.

regards,
Rajendra

[1] http://www.mail-archive.com/linux-omap at vger.kernel.org/msg72163.html

Rajendra Nayak (4):
  ARM: OMAP3: cpuidle: Remove unused MPU OSWR support code
  ARM: OMAP: PM: Get rid of Powerdomain book-keeping from cpuidle
  ARM: OMAP: powerdomain: Add .power_on/.power_down hooks for
    powerdomains
  ARM: OMAP3: PM: Use .power_on/.power_down to clean omap_sram_idle

 arch/arm/mach-omap2/omap-mpuss-lowpower.c |    4 +-
 arch/arm/mach-omap2/pm34xx.c              |  158 ++++++++++++++---------------
 arch/arm/mach-omap2/powerdomain.c         |   40 ++++----
 arch/arm/mach-omap2/powerdomain.h         |    8 +-
 arch/arm/mach-omap2/sleep34xx.S           |    4 +-
 5 files changed, 104 insertions(+), 110 deletions(-)
