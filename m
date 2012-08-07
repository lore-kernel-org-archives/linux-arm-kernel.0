From: matt@genesi-usa.com (Matt Sealey)
Date: Tue,  7 Aug 2012 17:45:12 -0500
Subject: [PATCH 0/2] ARM: imx: change building of SSI FIQ support for i.MX
 processors
Message-ID: <1344379514-30076-1-git-send-email-matt@genesi-usa.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patches to fix Thumb2 kernel building and change the dependency for SSI FIQ
support to a more specific option to prevent it from being needlessly built
in the first place on more frugal kernel configurations.

A better solution might be to rewrite the function in Thumb-compatible assembly
but the target processors do not support Thumb2 kernels anyway, and the last
time it was suggested the updated code was nacked by Russell. Since its built
as a side-effect on ARMv6/v7 i.MX processors, these could be considered somewhat
Needful Things(tm) by people wanting Thumb2 kernels based on imx_v6_v7_defconfig
or wanting to remove certain boards from their configs.

Matt Sealey (2):
  ARM: build ssi-fiq.S in ARM mode to prevent CONFIG_THUMB2_KERNEL
    build breakage
  ARM: only build ssi-fiq.S et al if CONFIG_SND_IMX_SOC_PCM_FIQ is
    selected

 arch/arm/plat-mxc/Makefile  |    2 +-
 arch/arm/plat-mxc/ssi-fiq.S |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
1.7.9.5
