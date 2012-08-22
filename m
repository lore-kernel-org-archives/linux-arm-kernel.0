From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Wed, 22 Aug 2012 00:42:28 -0500
Subject: [PATCH 0/2] OMAP: hwmod: fix hardreset handling
Message-ID: <1345614150-25723-1-git-send-email-omar.luna@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Omar Ramirez Luna <omar.ramirez@ti.com>

The patch to expose hwmod assert/deassert functions through omap_device
has been accepted and queued for 3.7[1], however these two patches are
needed to make the API functional. Hence a revised version is being sent
according to previous comments:

- ARM: OMAP: hwmod: revise deassert sequence
Now it uses enable|disable_module to handle the configuration of the
modulemode inside CLKCTRL. As part of the cleanup of leaf clocks, the
one associated with ipu_mmu will be removed along with the iommu hwmod
migration[2].

- ARM: OMAP: hwmod: partially un-reset hwmods might not be properly
  enabled
More infomation added in the patch description[3].

[1] http://patchwork.kernel.org/patch/1266731/
[2] http://patchwork.kernel.org/patch/1201791/
[3] http://patchwork.kernel.org/patch/1201801/

Omar Ramirez Luna (2):
  ARM: OMAP: hwmod: partially un-reset hwmods might not be properly
    enabled
  ARM: OMAP: hwmod: revise deassert sequence

 arch/arm/mach-omap2/omap_hwmod.c |   74 ++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 15 deletions(-)

-- 
1.7.9.5
