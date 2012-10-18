From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 18 Oct 2012 19:38:15 +0300
Subject: [RFC PATCH 0/2] ARM: OMAP4+: Clk registration update
Message-ID: <1350578297-22572-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we use CK_446X etc to differentiate which clk needs to be registered on which SoC.
The following patch series removes that requirement, instead SoC and SoC variants are
detected on the fly and only the required clocks are registered in the system.
This will help to remove the CK_XYZ macros from the system.

Please comment if this is an acceptable approach - at a first glance,
it seems to pave way to be capable of being replaced potentially by DT data as well.

Grygorii Strashko (2):
  ARM: OMAP2+: clock: Add omap2_clks_register API
  ARM: OMAP4: clock: use omap4_clks_register API

 arch/arm/mach-omap2/clock.c          |   36 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock.h          |    3 +++
 arch/arm/mach-omap2/clock44xx_data.c |   40 ++++++++++++++++++----------------
 3 files changed, 60 insertions(+), 19 deletions(-)

-- 
1.7.9.5
