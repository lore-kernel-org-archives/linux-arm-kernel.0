From: michel.pollet@bp.renesas.com (Michel Pollet)
Date: Mon, 25 Jun 2018 09:25:03 +0100
Subject: [PATCH v6 0/3] Renesas R9A06G032 SMP enabler
Message-ID: <1529915110-5867-1-git-send-email-michel.pollet@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

*WARNING -- this requires the base R9A06G032 support patches
already posted.

This patch series is for enabling the second CA7 of the R9A06G032.
It's based on a spin_table method, and it reuses the same binding
property as that driver.

v6:
  + Passed scriptcheck --strict on the driver.
  + Rebased on base patchset v10
v5:
  + Fixed a couple of typos
  + Added the Reviewed-by tags where appropriate
  + Rebased on base patch v9
  + Replaced the dts property with a 64 bits one.
  + Changed the driver to support 32 or 64 bits property.
v4:
  + Geert's comments adressed.
  + Renamed symbols to r9a06g032 to match the rest of patchset
  + Rebased on base patch v8
v3:
  + Removed mentions of rz/?n1d?
  + Rebased on base patch v7
v2:
  + Added suggestions from Florian Fainelli
  + Use __pa_symbol()
  + Simplified logic in prepare_cpu()
  + Reordered the patches
  + Rebased on RZN1 Base patch v5

Michel Pollet (3):
  dt-bindings: cpu: Add Renesas R9A06G032 SMP enable method.
  arm: shmobile: Add the R9A06G032 SMP enabler driver
  ARM: dts: Renesas R9A06G032 SMP enable method

 Documentation/devicetree/bindings/arm/cpus.txt |  1 +
 arch/arm/boot/dts/r9a06g032.dtsi               |  2 +
 arch/arm/mach-shmobile/Makefile                |  1 +
 arch/arm/mach-shmobile/smp-r9a06g032.c         | 96 ++++++++++++++++++++++++++
 4 files changed, 100 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/smp-r9a06g032.c

-- 
2.7.4
