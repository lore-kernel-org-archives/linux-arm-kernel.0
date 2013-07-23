From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 23 Jul 2013 11:54:36 +0530
Subject: [PATCH 0/3] OMAP2+: hwmod: Add support to parse clock info from DT
Message-ID: <1374560679-14666-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With all of OMAP clock data now moving to DT, its possible to pass the
main or functional clock and all optional clocks information for a
device from DT instead of having these as part of hwmod static data
in the kernel.

This patch series is based on 'v3' of omap4 clock movement to DT
patches [1] and is boot tested on a omap4 panda es.

The series does leave all the interface clocks as part of hwmod (and
main and optional clocks for devices which are missing DT drivers).

[1] http://comments.gmane.org/gmane.linux.ports.arm.omap/100117

Rajendra Nayak (3):
  ARM: OMAP2+: Add support to parse 'main_clk' info from DT
  ARM: OMAP2+: Add support to parse optional clk info from DT
  ARM: OMAP4: dts: Add main and optional clock data into DT

 arch/arm/boot/dts/omap4.dtsi               |  100 +++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod.c           |  100 +++++++++++++++++++++----
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  112 ----------------------------
 3 files changed, 185 insertions(+), 127 deletions(-)

-- 
1.7.9.5
