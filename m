From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Oct 2011 22:03:52 +0200
Subject: [PATCH 20/26] ARM: pxa: select FB_PXA on saar and tevorevb
In-Reply-To: <1317499438-14058-1-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
Message-ID: <1317499438-14058-21-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The saar and tevorevb platforms call pxafb_smart_flush from board
code, and that function is defined in the framebuffer code, so it
cannot be disabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/Kconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index bb310d0..cd94f2f 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -61,11 +61,15 @@ config MACH_TAVOREVB
 	bool "PXA930 Evaluation Board (aka TavorEVB)"
 	select PXA3xx
 	select CPU_PXA930
+	select FB_PXA
+	select FB
 
 config MACH_SAAR
 	bool "PXA930 Handheld Platform (aka SAAR)"
 	select PXA3xx
 	select CPU_PXA930
+	select FB_PXA
+	select FB
 
 comment "Third Party Dev Platforms (sorted by vendor name)"
 
-- 
1.7.5.4
