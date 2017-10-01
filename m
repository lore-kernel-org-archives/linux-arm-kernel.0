From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun,  1 Oct 2017 14:56:58 +0200
Subject: [PATCH 2/4] nvmem: meson-efuse: indicate that this driver is only for
 Meson GX SoCs
In-Reply-To: <20171001125700.1520-1-martin.blumenstingl@googlemail.com>
References: <20171001125700.1520-1-martin.blumenstingl@googlemail.com>
Message-ID: <20171001125700.1520-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current Amlogic Meson eFuse driver only supports the 64-bit SoCs
(GXBB and newer). Older SoCs cannot be supported by the same driver
because they do not use the meson secure monitor firmware to access the
hardware.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt | 2 +-
 drivers/nvmem/Kconfig                                     | 4 ++--
 drivers/nvmem/meson-efuse.c                               | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt b/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
index fafd85bd67a6..e3298e18de26 100644
--- a/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
+++ b/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
@@ -1,4 +1,4 @@
-= Amlogic eFuse device tree bindings =
+= Amlogic Meson GX eFuse device tree bindings =
 
 Required properties:
 - compatible: should be "amlogic,meson-gxbb-efuse"
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 101ced4c84be..a21a781f587d 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -135,11 +135,11 @@ config NVMEM_VF610_OCOTP
 	  be called nvmem-vf610-ocotp.
 
 config MESON_EFUSE
-	tristate "Amlogic eFuse Support"
+	tristate "Amlogic Meson GX eFuse Support"
 	depends on (ARCH_MESON || COMPILE_TEST) && MESON_SM
 	help
 	  This is a driver to retrieve specific values from the eFuse found on
-	  the Amlogic Meson SoCs.
+	  the Amlogic Meson GX SoCs.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem_meson_efuse.
diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index 70bfc9839bb2..1ea3cd24a508 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -1,5 +1,5 @@
 /*
- * Amlogic eFuse Driver
+ * Amlogic Meson GX eFuse Driver
  *
  * Copyright (c) 2016 Endless Computers, Inc.
  * Author: Carlo Caione <carlo@endlessm.com>
@@ -89,5 +89,5 @@ static struct platform_driver meson_efuse_driver = {
 module_platform_driver(meson_efuse_driver);
 
 MODULE_AUTHOR("Carlo Caione <carlo@endlessm.com>");
-MODULE_DESCRIPTION("Amlogic Meson NVMEM driver");
+MODULE_DESCRIPTION("Amlogic Meson GX NVMEM driver");
 MODULE_LICENSE("GPL v2");
-- 
2.14.2
