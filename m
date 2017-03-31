From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 Mar 2017 12:33:14 +0200
Subject: [PATCH] multi_v7_defconfig: make Rockchip DRM drivers built-in
Message-ID: <20170331103314.1067264-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These cause warnings in linux-next, as the symbols have become 'bool' there:

arch/arm/configs/multi_v7_defconfig:600:warning: symbol value 'm' invalid for ROCKCHIP_INNO_HDMI
arch/arm/configs/multi_v7_defconfig:599:warning: symbol value 'm' invalid for ROCKCHIP_DW_MIPI_DSI
arch/arm/configs/multi_v7_defconfig:598:warning: symbol value 'm' invalid for ROCKCHIP_DW_HDMI
arch/arm/configs/multi_v7_defconfig:597:warning: symbol value 'm' invalid for ROCKCHIP_ANALOGIX_DP

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I've applied this patch to next/defconfig to avoid some warnings we see in
kernelci.

 arch/arm/configs/multi_v7_defconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 63b94d0e5503..ea54ef6f1f03 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -593,10 +593,10 @@ CONFIG_DRM_EXYNOS_DPI=y
 CONFIG_DRM_EXYNOS_DSI=y
 CONFIG_DRM_EXYNOS_HDMI=y
 CONFIG_DRM_ROCKCHIP=m
-CONFIG_ROCKCHIP_ANALOGIX_DP=m
-CONFIG_ROCKCHIP_DW_HDMI=m
-CONFIG_ROCKCHIP_DW_MIPI_DSI=m
-CONFIG_ROCKCHIP_INNO_HDMI=m
+CONFIG_ROCKCHIP_ANALOGIX_DP=y
+CONFIG_ROCKCHIP_DW_HDMI=y
+CONFIG_ROCKCHIP_DW_MIPI_DSI=y
+CONFIG_ROCKCHIP_INNO_HDMI=y
 CONFIG_DRM_ATMEL_HLCDC=m
 CONFIG_DRM_RCAR_DU=m
 CONFIG_DRM_RCAR_HDMI=y
-- 
2.9.0
