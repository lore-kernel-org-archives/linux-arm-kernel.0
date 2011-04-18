From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Mon, 18 Apr 2011 11:39:39 -0500
Subject: [PATCH v2 0/3] OMAP: l3: fixes and cleanup
Message-ID: <1303144782-5591-1-git-send-email-omar.ramirez@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on the comments received for the first patch:
OMAP3: l3: fix for "irq 10: nobody cared" message[1],
and quick skimming through the code.

Although there are still parenthesis that are not needed
because of operator precedence, they were left for clarity.

E.g.:
(error >> 32) & 0xffff;

clear = (L3_AGENT_STATUS_CLEAR_IA << int_type) |
       L3_AGENT_STATUS_CLEAR_TA;

v2:
- Joining omap3_l3_probe fixes into a single patch.
- Joining trivial cleanups into a single patch.
- Adding acked by Santosh line.

---
[1] https://patchwork.kernel.org/patch/665141/

Omar Ramirez Luna (3):
  OMAP3: l3: fix for "irq 10: nobody cared" message
  OMAP3/4: l3: fix omap3_l3_probe error path
  OMAP3/4: l3: minor cleanup for parenthesis and extra spaces

 arch/arm/mach-omap2/omap_l3_noc.c |   51 ++++++++++++++++--------------------
 arch/arm/mach-omap2/omap_l3_smx.c |   46 ++++++++++++---------------------
 2 files changed, 40 insertions(+), 57 deletions(-)
