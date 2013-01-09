From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  9 Jan 2013 10:06:04 +0000
Subject: [PATCH 2/3] ARM: ux500: Turn on the 'heartbeat' LED trigger
In-Reply-To: <1357725965-27342-1-git-send-email-lee.jones@linaro.org>
References: <1357725965-27342-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1357725965-27342-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As Snowball is a community board it should have its default LED
trigger set in 'heartbeat' mode, meaning that it double flashes
~1HZ. This provides an excellent debugging tool when community
members are hacking.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 5dea906..0f25b07 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -43,6 +43,8 @@ config MACH_HREFV60
 config MACH_SNOWBALL
 	bool "U8500 Snowball platform"
 	select MACH_MOP500
+	select LEDS_TRIGGERS
+	select LEDS_TRIGGER_HEARTBEAT
 	help
 	  Include support for the snowball development platform.
 
-- 
1.7.9.5
