From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 15 May 2014 16:23:49 +0200
Subject: [PATCH RFC 04/11] cpuidle: kirkwood: Remove ARCH_KIRKWOOD dependency
In-Reply-To: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
References: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
Message-ID: <1400163836-9831-9-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach-kirkwood has been removed, now that kirkwood lives in mach-mvebu.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: linux-pm at vger.kernel.org
---
 drivers/cpuidle/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 5bb94780d377..a56c17928534 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -27,7 +27,7 @@ config ARM_HIGHBANK_CPUIDLE
 
 config ARM_KIRKWOOD_CPUIDLE
 	bool "CPU Idle Driver for Marvell Kirkwood SoCs"
-	depends on ARCH_KIRKWOOD || MACH_KIRKWOOD
+	depends on MACH_KIRKWOOD
 	help
 	  This adds the CPU Idle driver for Marvell Kirkwood SoCs.
 
-- 
2.0.0.rc2
