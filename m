From: rnayak@ti.com (Rajendra Nayak)
Date: Tue,  5 Apr 2011 18:14:53 +0530
Subject: [PATCH 0/4] OMAP2+: Fix clockdomain state programming
Message-ID: <1302007497-10525-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixes a few issues in the clockdomain
state programming done as part of the omap_set_pwrdm_state()
function.
More details on the issues can be found in the discussions
below
http://marc.info/?l=linux-arm-kernel&m=130189971726452&w=2

Doing this requires adding additional api's in the
clockdomain framework to identify what idle mode a
clockdomain is currently programmed in.
Hence a new api clkdm_is_idle() is also added as
part of this series.

The series is tested on OMAP3-beagle for all low
power states in idle and suspend and also boot
tested on a OMAP4430sdp. Applies on 2.6.39-rc1.

Rajendra Nayak (4):
  OMAP2+: clockdomain: Add an api to read idle mode
  OMAP2+: clockdomain: Add SoC support for clkdm_is_idle
  OMAP2+: PM: Initialise sleep_switch to a non-valid value
  OMAP2+: PM: idle clkdms only if already in idle

 arch/arm/mach-omap2/clockdomain.c          |   21 +++++++++++++++++++++
 arch/arm/mach-omap2/clockdomain.h          |    3 +++
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c |   12 ++++++++++++
 arch/arm/mach-omap2/clockdomain44xx.c      |    7 +++++++
 arch/arm/mach-omap2/pm.c                   |    6 ++++--
 5 files changed, 47 insertions(+), 2 deletions(-)
