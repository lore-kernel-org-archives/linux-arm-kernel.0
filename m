From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 15:46:10 +0100
Subject: [PATCH 1/5] ARM: Kirkwood: Enable regulator and fixed regulators.
In-Reply-To: <1353163574-6362-1-git-send-email-andrew@lunn.ch>
References: <1353163574-6362-1-git-send-email-andrew@lunn.ch>
Message-ID: <1353163574-6362-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few boards use a GPIO line to enable power to subsystems, eg USB or
SATA devices. Pull in the regulator framework as the first step to
controlling these GPIO lines are regulators.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-kirkwood/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index e0d26fe..b8e96f3 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -49,8 +49,9 @@ config ARCH_KIRKWOOD_DT
 	select POWER_SUPPLY
 	select POWER_RESET
 	select POWER_RESET_GPIO
+	select REGULATOR
+	select REGULATOR_FIXED_VOLTAGE
 	select USE_OF
-
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell Kirkwood using flattened device tree.
-- 
1.7.10.4
