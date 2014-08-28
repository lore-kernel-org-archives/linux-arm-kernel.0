From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 28 Aug 2014 16:00:29 +0200
Subject: [PATCH 2/2] [RFC] ARM: Set CONFIG_LOCALVERSION in multi v5/v7
 defconfigs
In-Reply-To: <1409234429-1916-1-git-send-email-geert+renesas@glider.be>
References: <1409234429-1916-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1409234429-1916-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows to derive the kernel flavor from the kernel version, as
reported by "uname -r".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Do you like this? m68k has been using this for years.

 arch/arm/configs/multi_v5_defconfig | 1 +
 arch/arm/configs/multi_v7_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index 018bef9fa7e8..a4a2e8ee2536 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -1,3 +1,4 @@
+CONFIG_LOCALVERSION="-multi_v5"
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e36baadbacc7..7d7f49778b52 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1,3 +1,4 @@
+CONFIG_LOCALVERSION="-multi_v7"
 CONFIG_SYSVIPC=y
 CONFIG_FHANDLE=y
 CONFIG_IRQ_DOMAIN_DEBUG=y
-- 
1.9.1
