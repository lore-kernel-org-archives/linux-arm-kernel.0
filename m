From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu,  8 Mar 2012 11:22:14 +0200
Subject: [PATCH v2 0/3] ARM/ASoC: OMAP McBSP: Correct CLKR/FSR source selection
Message-ID: <1331198537-13469-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Changes since v1:
- Adapted to the moved mcbsp code which helped to reduce the number of patches
  from 5 to 3.
- Clock selection related defines moved from arch to ASoC header.

No change in functionality otherwise.

This series fixes the CLKR/FSR mux selection (on McBSP ports with 6 pin setup).
OMAP2/3 has 6 pin setup on McBSP1 port while OMAP4 has the 6 pin setup on McBSP4
port.
Add support for OMAP4 CLKR/FSR source selection, and simplify the ASoC part of
CLK mux configuration.

This series should go via ASoC with the rest of McBSP changes.

Regards,
Peter
---
Peter Ujfalusi (3):
  ARM: OMAP2+: McBSP: Correct CLKR/FSR clock source mux configuration
  ARM/ASoC: OMAP McBSP: Move remainig defines from arch to ASoC header
  ASoC: omap-mcbsp: Single function CLKR/FSR source mux configuration

 arch/arm/mach-omap2/mcbsp.c             |   46 ++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/mcbsp.h |   12 --------
 sound/soc/omap/mcbsp.c                  |   48 ++++++++++++++----------------
 sound/soc/omap/mcbsp.h                  |   13 +++++++-
 sound/soc/omap/omap-mcbsp.c             |    8 ++--
 5 files changed, 81 insertions(+), 46 deletions(-)

-- 
1.7.8.5
