From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 14 Oct 2013 12:03:02 +0100
Subject: [PATCH v2 05/13] arm64: add CPU PM infrastructure selection
In-Reply-To: <1381748590-14279-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1381748590-14279-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1381748590-14279-6-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to rely on the CPU PM implementation for saving and restoring
of CPU subsystems like GIC and PMU, the arch Kconfig must be augmented
to select the CONFIG_CPU_PM option when SUSPEND or CPU_IDLE kernel
implementation are selected. This patch adds the appropriate selection
entry in the arm64 Kconfig file.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9d0c8dd..bcf88e4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -10,6 +10,7 @@ config ARM64
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select COMMON_CLK
+	select CPU_PM if (SUSPEND || CPU_IDLE)
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IOMAP
 	select GENERIC_IRQ_PROBE
-- 
1.8.4
