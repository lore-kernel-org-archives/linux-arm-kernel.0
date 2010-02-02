From: matthias@kaehlcke.net (Matthias Kaehlcke)
Date: Tue, 2 Feb 2010 20:22:17 +0100
Subject: [PATCH] ARM: Fix warnings in corgi/spitz_defconfig
Message-ID: <20100202192217.GT8053@darwin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

corgi/spitz_defconfig select CONFIG_THRUSTMASTER_FF and
CONFIG_ZEROPLUS_FF as modules, but these are (now?) of boolean type,
in consequence Kconfig raises a warning. Further these settings
depend on CONFIG_HID_THRUSTMASTER / CONFIG_HID_ZEROPLUS, which aren't
selected by the defconfig. Therefore the selection is incorrect at all
and we remove it.

Signed-off-by: Matthias Kaehlcke <matthias@kaehlcke.net>
---
 arch/arm/configs/corgi_defconfig |    2 --
 arch/arm/configs/spitz_defconfig |    2 --
 2 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/corgi_defconfig b/arch/arm/configs/corgi_defconfig
index 5e4069f..dbfb437 100644
--- a/arch/arm/configs/corgi_defconfig
+++ b/arch/arm/configs/corgi_defconfig
@@ -1320,8 +1320,6 @@ CONFIG_HID_PETALYNX=m
 CONFIG_HID_SAMSUNG=m
 CONFIG_HID_SONY=m
 CONFIG_HID_SUNPLUS=m
-CONFIG_THRUSTMASTER_FF=m
-CONFIG_ZEROPLUS_FF=m
 CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 # CONFIG_USB_ARCH_HAS_OHCI is not set
diff --git a/arch/arm/configs/spitz_defconfig b/arch/arm/configs/spitz_defconfig
index 7d89489..dc2bff7 100644
--- a/arch/arm/configs/spitz_defconfig
+++ b/arch/arm/configs/spitz_defconfig
@@ -1239,8 +1239,6 @@ CONFIG_HID_PETALYNX=m
 CONFIG_HID_SAMSUNG=m
 CONFIG_HID_SONY=m
 CONFIG_HID_SUNPLUS=m
-CONFIG_THRUSTMASTER_FF=m
-CONFIG_ZEROPLUS_FF=m
 CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
-- 
1.6.5
