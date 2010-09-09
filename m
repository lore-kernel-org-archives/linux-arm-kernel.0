From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu,  9 Sep 2010 12:58:07 -0700
Subject: [PATCH 2/4] arm: dis-allow hotplug on MSM
In-Reply-To: <1284062289-10914-1-git-send-email-dwalker@codeaurora.org>
References: <1284062289-10914-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <1284062289-10914-3-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MSM doesn't support hotplug, so we prevent it from being
select with this added line.

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d2dfbc2..829dd67 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1211,6 +1211,7 @@ config NR_CPUS
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
 	depends on SMP && HOTPLUG && EXPERIMENTAL
+	depends on !ARCH_MSM
 	help
 	  Say Y here to experiment with turning CPUs off and on.  CPUs
 	  can be controlled through /sys/devices/system/cpu.
-- 
1.7.1
