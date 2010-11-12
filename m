From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 12 Nov 2010 17:20:59 +0900
Subject: [PATCH 00/07] ARM: Common GIC entry macro code V3
Message-ID: <20101112082059.27221.52879.sendpatchset@t400s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: Common GIC entry macro code V3

[PATCH 01/07] ARM: Introduce asm/hardware/entry-macro-gic.S
[PATCH 02/07] ARM: Use shared GIC entry macros on CNS3XXX
[PATCH 03/07] ARM: Use shared GIC entry macros on Realview
[PATCH 04/07] ARM: Use shared GIC entry macros on Tegra
[PATCH 05/07] ARM: Use shared GIC entry macros on UX500
[PATCH 06/07] ARM: Use shared GIC entry macros on Vexpress
[PATCH 07/07] ARM: Use shared GIC entry macros on OMAP

Put GIC demux code in a common place to avoid duplicated code.

These patches are almost identical to 6284/1 in the RMKs
patch tracker. The main difference is that these ones require
each platform to specify base address using the macro
get_irqnr_preable. Both Tegra and OMAP are supported in V3.

The s5pv310 subarch is excluded due to the special "addne"
instruction in the get_irqnr_and_base macro.

The msm subarch is excluded as well since it treats PPIs
differently than other platforms and needs a different
version of the get_irqnr_and_base macro.

I intend to submit these patches to the RMK patch tracker
unless I hear any objections.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/include/asm/hardware/entry-macro-gic.S   |   68 +++++++++++++++
 arch/arm/mach-cns3xxx/include/mach/entry-macro.S  |   61 -------------
 arch/arm/mach-omap2/include/mach/entry-macro.S    |   92 +++++++--------------
 arch/arm/mach-realview/include/mach/entry-macro.S |   60 -------------
 arch/arm/mach-tegra/include/mach/entry-macro.S    |   64 --------------
 arch/arm/mach-ux500/include/mach/entry-macro.S    |   67 ---------------
 arch/arm/mach-vexpress/include/mach/entry-macro.S |   57 -------------
 7 files changed, 104 insertions(+), 365 deletions(-)
