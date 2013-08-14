From: jonathan.austin@arm.com (Jonathan Austin)
Date: Wed, 14 Aug 2013 18:23:05 +0100
Subject: [PATCH Resend 1/3] PSCI: add missing dependency on CONFIG_OF for PSCI.
In-Reply-To: <1376500987-12797-1-git-send-email-jonathan.austin@arm.com>
References: <1376500987-12797-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <1376500987-12797-2-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PSCI initialisation depends on data found in the DT. Without this the
including PSCI support makes little sense, and furthermore the of_* stub
functions aren't broad enough to ensure that this builds without CONFIG_OF.

As there is little enthusiasm for extending these stubs without useful use-cases
(of which this is *not* an example) this patch prevents building of PSCI
without CONFIG_OF.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
---
 arch/arm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ba412e0..972ec25 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1577,6 +1577,7 @@ config HOTPLUG_CPU
 config ARM_PSCI
 	bool "Support for the ARM Power State Coordination Interface (PSCI)"
 	depends on CPU_V7
+	depends on CONFIG_OF
 	help
 	  Say Y here if you want Linux to communicate with system firmware
 	  implementing the PSCI specification for CPU-centric power
-- 
1.7.9.5
