From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 16 Apr 2014 15:05:08 +0200
Subject: [RFC 0/3] ARM: ux500: Add support for power domains using DT
Message-ID: <1397653511-19226-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is based upon a patchset from Tomasz Figa for the generic power
domain. It is still being discussed on the linux-pm mailing list. In principle
it adds DT support to the generic power domain.

http://marc.info/?l=linux-pm&m=139386277422309&w=2

This patchset is therefore sent as an RFC and must not be merged as is.

Ulf Hansson (3):
  ARM: ux500: Initial support for power domains
  ARM: ux500: Add DT node for ux500 power domains
  ARM: ux500: Add sdi[n] devices to VAPE power domain

 .../devicetree/bindings/arm/ux500/power_domain.txt |   35 +++++++++
 arch/arm/boot/dts/ste-dbx5x0.dtsi                  |   11 +++
 arch/arm/mach-ux500/Kconfig                        |    5 ++
 arch/arm/mach-ux500/Makefile                       |    1 +
 arch/arm/mach-ux500/pm.c                           |    4 +
 arch/arm/mach-ux500/pm_domains.c                   |   77 ++++++++++++++++++++
 arch/arm/mach-ux500/pm_domains.h                   |   17 +++++
 include/dt-bindings/arm/ux500_pm_domains.h         |   15 ++++
 8 files changed, 165 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/ux500/power_domain.txt
 create mode 100644 arch/arm/mach-ux500/pm_domains.c
 create mode 100644 arch/arm/mach-ux500/pm_domains.h
 create mode 100644 include/dt-bindings/arm/ux500_pm_domains.h

-- 
1.7.9.5
