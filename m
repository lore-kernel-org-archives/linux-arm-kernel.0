From: michel.pollet@bp.renesas.com (Michel Pollet)
Date: Tue, 17 Apr 2018 13:47:59 +0100
Subject: [PATCH v2 0/3] Renesas RZ/N1D SMP enabler
Message-ID: <1523969291-41756-1-git-send-email-michel.pollet@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

*WARNING -- this requires the base RZ/N1 base patches (v5) already posted

This patch series is for enabling the second CA7 of the RZ/N1D.
It's based on a spin_table method, and it reuses the same binding
property as that driver.

v2:
  + Added suggestions from Florian Fainelli
  + Use __pa_symbol()
  + Simplified logic in prepare_cpu()
  + Reordered the patches
  + Rebased on RZN1 Base patch v5

*** BLURB HERE ***

Michel Pollet (3):
  dt-bindings: cpu: Add Renesas RZ/N1D SMP enable method.
  arm: shmobile: Add the RZ/N1D SMP enabler driver
  ARM: dts: Renesas RZ/N1D SMP enable method

 Documentation/devicetree/bindings/arm/cpus.txt |  1 +
 arch/arm/boot/dts/r9a06g032.dtsi               |  2 +
 arch/arm/mach-shmobile/Makefile                |  1 +
 arch/arm/mach-shmobile/smp-r9a06g032.c         | 85 ++++++++++++++++++++++++++
 4 files changed, 89 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/smp-r9a06g032.c

-- 
2.7.4
