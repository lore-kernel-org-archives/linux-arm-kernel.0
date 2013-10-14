From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 14 Oct 2013 12:03:10 +0100
Subject: [PATCH v2 13/13] arm64: add CPU power management menu/entries
In-Reply-To: <1381748590-14279-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1381748590-14279-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1381748590-14279-14-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides a menu for CPU power management options in the
arm64 Kconfig and adds an entry to enable the generic CPU idle configuration.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index be88acd..785132d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -288,6 +288,12 @@ config ARM64_CPU_SUSPEND
 
 endmenu
 
+menu "CPU Power Management"
+
+source "drivers/cpuidle/Kconfig"
+
+endmenu
+
 source "net/Kconfig"
 
 source "drivers/Kconfig"
-- 
1.8.4
