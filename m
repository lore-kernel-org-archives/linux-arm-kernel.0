From: saaguirre@ti.com (Sergio Aguirre)
Date: Mon, 15 Mar 2010 18:04:12 -0500
Subject: [PATCH 7/7] omap3: zoom2/3: Register only 1 8250 port
In-Reply-To: <1268694252-21985-1-git-send-email-saaguirre@ti.com>
References: <1268694252-21985-1-git-send-email-saaguirre@ti.com>
Message-ID: <1268694252-21985-8-git-send-email-saaguirre@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no more serial ports available, so, doesn't make sense
to create 4 device nodes.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/configs/omap_zoom2_defconfig |    2 +-
 arch/arm/configs/omap_zoom3_defconfig |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/omap_zoom2_defconfig b/arch/arm/configs/omap_zoom2_defconfig
index f5c6e11..881faea 100644
--- a/arch/arm/configs/omap_zoom2_defconfig
+++ b/arch/arm/configs/omap_zoom2_defconfig
@@ -661,7 +661,7 @@ CONFIG_DEVKMEM=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=32
-CONFIG_SERIAL_8250_RUNTIME_UARTS=4
+CONFIG_SERIAL_8250_RUNTIME_UARTS=1
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
diff --git a/arch/arm/configs/omap_zoom3_defconfig b/arch/arm/configs/omap_zoom3_defconfig
index ea9a501..5e55b55 100644
--- a/arch/arm/configs/omap_zoom3_defconfig
+++ b/arch/arm/configs/omap_zoom3_defconfig
@@ -680,7 +680,7 @@ CONFIG_DEVKMEM=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=32
-CONFIG_SERIAL_8250_RUNTIME_UARTS=4
+CONFIG_SERIAL_8250_RUNTIME_UARTS=1
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
-- 
1.6.3.3
