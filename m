From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri,  9 May 2014 15:05:01 +0200
Subject: [PATCH 0/3] ARM: ux500: Add initial support for power domains
Message-ID: <1399640704-12289-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initial support for power domains for ux500. To enable this feature we require
to use DT, thus we need to add bindings for the ux500 specific parts as well.

The implementation of the ux500 power domains is based upon the generic power
domain.

An important note, this patchset depends on Tomasz Figa patchset, which is still
in the review phase:

[PATCH v4 0/3] Generic Device Tree based power domain look-up
http://www.spinics.net/lists/kernel/msg1738549.html

I assume that patchset will be queued through Rafael's linux pm tree. Let's see
what the prefer way is for how to deal with this patchset, after that point.


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
