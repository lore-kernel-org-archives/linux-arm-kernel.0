From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 28 Aug 2013 12:35:58 +0100
Subject: [RFC PATCH 06/14] arm64: add CPU PM infrastructure selection
In-Reply-To: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1377689766-17642-7-git-send-email-lorenzo.pieralisi@arm.com>
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
index 564cbe6..5855519 100644
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
1.8.3.4
