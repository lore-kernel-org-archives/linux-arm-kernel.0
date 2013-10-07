From: nm@ti.com (Nishanth Menon)
Date: Mon, 7 Oct 2013 11:49:41 -0500
Subject: [PATCH 0/2] ARM: dts: OMAP: standardize SoC specific bindings
In-Reply-To: <523C9D8B.2000701@ti.com>
References: <523C9D8B.2000701@ti.com>
Message-ID: <1381164584-4008-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a respin of [1] based on of Olof's comments to introduce a
generic SoC binding. This standardizes the binding definitions for
SoCs based on existing "implied" bindings and based on existing usage
in arch/arm/mach-omap2/soc.h. Eventually we should be able to get rid
of soc_is_xyz() functions and allow machine descriptors to seamlessly
handle the deltas.

The series is based on [2] and was triggered primarily due to the bug
seen with [3] - clock dts conversion.

Nishanth Menon (2):
  Documentation: dt: OMAP: standardize SoC naming definition
  ARM: dts: omap3-beagle: use 3630 definitions

 .../devicetree/bindings/arm/omap/omap.txt          |   45 ++++++++++++++++++++
 arch/arm/boot/dts/omap3-beagle-xm.dts              |    2 +-
 arch/arm/mach-omap2/board-generic.c                |   23 ++++++++++
 3 files changed, 69 insertions(+), 1 deletion(-)

[1] https://patchwork.kernel.org/patch/2919661/
[2] https://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git/log/?h=for_3.13/dts
[3] http://marc.info/?t=138009899400001&r=1&w=2
-- 
1.7.9.5
