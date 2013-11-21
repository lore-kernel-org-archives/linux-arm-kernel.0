From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 21 Nov 2013 11:24:19 +0000
Subject: [PATCH RFC v3 12/12] arm64: add CPU power management menu/entries
In-Reply-To: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1385033059-25896-13-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides a menu for CPU power management options in the
arm64 Kconfig and adds an entry to enable the generic CPU idle configuration.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0d78e92..3e2c392 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -291,6 +291,12 @@ config ARM64_CPU_SUSPEND
 
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
