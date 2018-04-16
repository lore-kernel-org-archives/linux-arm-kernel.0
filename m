From: michel.pollet@bp.renesas.com (Michel Pollet)
Date: Mon, 16 Apr 2018 10:34:55 +0100
Subject: [RFC 0/3] Renesas RZ/N1D SMP enabler
Message-ID: <1523871304-48517-1-git-send-email-michel.pollet@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

*Warning -- this requires the base RZ/N1 support patches already posted *

This is a tentative patch series for enabling the second CA7 of the RZ/N1D.
It's based on a spin_table method, and it reuses the same binding property
as that driver.

One question is: Do i have to document it separately, or is it sufficiently
clear?

Michel Pollet (3):
  dt-bindings: cpu: Add Renesas RZ/N1D SMP enable method.
  ARM: dts: Renesas RZ/N1D SMP enable method
  arm: shmobile: Add the RZ/N1D SMP enabler driver.

 Documentation/devicetree/bindings/arm/cpus.txt |  1 +
 arch/arm/boot/dts/r9a06g032.dtsi               |  2 +
 arch/arm/mach-shmobile/Makefile                |  1 +
 arch/arm/mach-shmobile/smp-r9a06g032.c         | 87 ++++++++++++++++++++++++++
 4 files changed, 91 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/smp-r9a06g032.c

-- 
2.7.4
