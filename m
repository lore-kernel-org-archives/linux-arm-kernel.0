From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 25 Oct 2009 15:53:26 +0300
Subject: [PATCH] SA1100: h3100/h3600: always build htc-egpio driver
Message-ID: <mailman.91.1256484975.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many features of h3100/h3600 (LCD, PCMCIA, Flash write, etc.)
depend on correct functioning of GPIO expander handled by htc-egpio
driver, so force its building in Kconfig.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-sa1100/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
index 854768f..03a7f38 100644
--- a/arch/arm/mach-sa1100/Kconfig
+++ b/arch/arm/mach-sa1100/Kconfig
@@ -53,6 +53,7 @@ config SA1100_COLLIE
 
 config SA1100_H3100
 	bool "Compaq iPAQ H3100"
+	select HTC_EGPIO
 	help
 	  Say Y here if you intend to run this kernel on the Compaq iPAQ
 	  H3100 handheld computer.  Information about this machine and the
@@ -62,6 +63,7 @@ config SA1100_H3100
 
 config SA1100_H3600
 	bool "Compaq iPAQ H3600/H3700"
+	select HTC_EGPIO
 	help
 	  Say Y here if you intend to run this kernel on the Compaq iPAQ
 	  H3600 handheld computer.  Information about this machine and the
-- 
1.6.3.4


--YiEDa0DAkWCtVeE4--
