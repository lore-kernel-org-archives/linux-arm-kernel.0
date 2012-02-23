From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 23 Feb 2012 18:21:52 +0200
Subject: [PATCH] ARM: tegra: Avoid compiling cpuidle code when not configured
Message-ID: <1330014112-26203-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No need to compile cpuidle.c and sleep.S if cpuidle isn't configured in the
kernel.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/mach-tegra/Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 82994c0..d4c1a6b 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -7,8 +7,8 @@ obj-y                                   += clock.o
 obj-y                                   += timer.o
 obj-y                                   += pinmux.o
 obj-y					+= fuse.o
-obj-y					+= cpuidle.o
-obj-y					+= sleep.o
+obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
+obj-$(CONFIG_CPU_IDLE)			+= sleep.o
 obj-y					+= pmc.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= powergate.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra2_clocks.o
-- 
1.7.7.rc0.72.g4b5ea.dirty
