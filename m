From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  9 Dec 2015 15:58:07 +0000
Subject: [PATCH v6 00/10] cpufreq: Introduce ST's CPUFreq driver
Message-ID: <1449676697-25432-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a re-write of the original submission, hence why the
change-log is omitted.  Basically almost everything has changed.
We are now using the new OPP framework and generic bindings
written by Viresh.

There are 'ARM' patches in the set which are not necessarily
related to CPUFreq, but are required to get it to work. Anyone
who is not interested in general STi DT changes can safely
ignore these.

v5 => v6:
 - Converted Kconfig and header comment to describe new driver
 - Complete re-write, using new Generic OPP framework
 - Supply description for "suitable for ALL versions" DEFINE
 - Pedantically re-ordered the #include files
 - Removed platform device registration in arch/arm/mach-sti

v4 => v5:
 - Converted driver away from being a platform device

v1 => v2 => v3 => v4:
 - Moot

Lee Jones (10):
  ARM: multi_v7_defconfig: Enable ST's PWM driver
  ARM: multi_v7_defconfig: Enable ST's Power Reset driver
  ARM: multi_v7_defconfig: Enable support for PWM Regulators
  ARM: STi: STiH407: Provide generic (safe) DVFS configuration
  ARM: STi: STiH407: Provide CPU with clocking information
  ARM: STi: STiH407: Link CPU with its voltage supply
  ARM: STi: STiH407: Provide CPU with a means to look-up Major number
  cpufreq: st: Provide runtime initialised driver for ST's platforms
  dt: cpufreq: st: Provide bindings for ST's CPUFreq implementation
  MAINTAINERS: Add ST's CPUFreq driver to the STI file list

 .../devicetree/bindings/cpufreq/cpufreq-st.txt     |  91 +++++++
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/stih407-family.dtsi              |  20 ++
 arch/arm/configs/multi_v7_defconfig                |   5 +-
 drivers/cpufreq/Kconfig.arm                        |  10 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/sti-cpufreq.c                      | 293 +++++++++++++++++++++
 7 files changed, 419 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
 create mode 100644 drivers/cpufreq/sti-cpufreq.c

-- 
1.9.1
