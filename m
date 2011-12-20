From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Tue, 20 Dec 2011 02:42:20 +0200
Subject: [PATCH 03/10] arm: omap2: fix omap3 touchbook kconfig warning
In-Reply-To: <1324341747-5922-1-git-send-email-felipe.contreras@gmail.com>
References: <1324341747-5922-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <1324341747-5922-4-git-send-email-felipe.contreras@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

warning: (MACH_OMAP3_TOUCHBOOK && DRM_RADEON_KMS && DRM_I915 && STUB_POULSBO && FB_BACKLIGHT && USB_APPLEDISPLAY && FB_OLPC_DCON && ASUS_LAPTOP && SONY_LAPTOP && THINKPAD_ACPI && EEEPC_LAPTOP && ACPI_ASUS && ACPI_CMPC && SAMSUNG_Q10) selects BACKLIGHT_CLASS_DEVICE which has unmet direct dependencies (HAS_IOMEM && BACKLIGHT_LCD_SUPPORT)

A lot of boards need BACKLIGHT_CLASS_DEVICE for the framebuffers to
work, but it's not *needed* for the device itself. It might be nice to
enable it by default somewhoe if graphics stuff is enabled, but that's
another story.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index eb7c3ac..dbecb9a 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -211,7 +211,6 @@ config MACH_OMAP3_TOUCHBOOK
 	bool "OMAP3 Touch Book"
 	depends on ARCH_OMAP3
 	default y
-	select BACKLIGHT_CLASS_DEVICE
 
 config MACH_OMAP_3430SDP
 	bool "OMAP 3430 SDP board"
-- 
1.7.8.rc1.14.g248db
