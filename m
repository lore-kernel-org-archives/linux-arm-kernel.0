From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 16 Mar 2015 11:28:29 +0100
Subject: [PATCH 2/3] ARM: dts: Define stdout-path property for Snow board
In-Reply-To: <1426501710-24177-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1426501710-24177-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1426501710-24177-3-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel can use as the default console a serial port if is defined
as stdout device in the Device Tree.

This allows a board to be booted without the need of having a console
parameter in the kernel command line.

Currently the Snow DTS has a bootargs in the /chosen node and this is
kept since users that don't have a serial console on this board might
be using it to have the boot log shown in the display. This will have
more precedence than the stdout-path but it's fine since is only used
when CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND is enabled.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/exynos5250-snow.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 5be966df7603..2657e842e5a5 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -29,6 +29,7 @@
 
 	chosen {
 		bootargs = "console=tty1";
+		stdout-path = "serial3:115200n8";
 	};
 
 	gpio-keys {
-- 
2.1.4
