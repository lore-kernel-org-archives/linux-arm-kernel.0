From: hanetzer@startmail.com (Marty E. Plummer)
Date: Tue, 17 Oct 2017 17:38:53 -0500
Subject: [PATCH v2 2/3] arm: hisi: enable Hi3521A SoC
In-Reply-To: <20171017223854.6980-1-hanetzer@startmail.com>
References: <20171017223854.6980-1-hanetzer@startmail.com>
Message-ID: <20171017223854.6980-3-hanetzer@startmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable Hisilicon Hi3521A/Hi3520DCV300 SoC. This SoC series includes
hardware mutlimedia codec cores, commonly used in consumer cctv/dvr
security systems and ipcameras. The arm core is a Cortex A7.

Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
---
 arch/arm/mach-hisi/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index 65a048fa08ec..26755414f862 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -12,6 +12,12 @@ if ARCH_HISI
 
 menu "Hisilicon platform type"
 
+config ARCH_HI3521A
+	bool "Hisilicon Hi3521A/Hi3520DCV300 family"
+	depends on ARCH_MULTI_V7
+	help
+	  Support for Hisilicon Hi3521A/Hi3520DCV300 SoC family
+
 config ARCH_HI3xxx
 	bool "Hisilicon Hi36xx family"
 	depends on ARCH_MULTI_V7
-- 
2.14.2
