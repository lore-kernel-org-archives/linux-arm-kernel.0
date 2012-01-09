From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 9 Jan 2012 17:12:10 +0200
Subject: [PATCH v2 0/3] Tegra30 clockframework
Message-ID: <1326121937-32054-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset introduces the tegra30 clockframework. Clocks which require
voltage scaling are not included in this version. The implementation doesn't
use the generic clock code yet. It's the intention to move to it, once the
semantics are fully clarified.

---

Changes in v2:
 * Fix parent clocks for TWD. This makes the SMP configuration booting again.

Peter De Schrijver (3):
  ARM: tegra: add support for new clock framework features
  ARM: tegra: implement basic tegra30 clock framework
  ARM: tegra: enable tegra30 clock framework

 arch/arm/mach-tegra/Makefile           |    1 +
 arch/arm/mach-tegra/clock.c            |   22 +
 arch/arm/mach-tegra/clock.h            |   15 +
 arch/arm/mach-tegra/common.c           |    1 +
 arch/arm/mach-tegra/include/mach/clk.h |   10 +
 arch/arm/mach-tegra/tegra30_clocks.c   | 3099 ++++++++++++++++++++++++++++++++
 6 files changed, 3148 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/tegra30_clocks.c

-- 
1.7.7.rc0.72.g4b5ea.dirty
