From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 20 Apr 2018 15:28:31 +0200
Subject: [PATCH 5/8] staging: emxx_udc: Change platform dependency to
 ARCH_RENESAS
In-Reply-To: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1524230914-10175-6-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Emma Mobile is a Renesas ARM SoC.  Since commit 9b5ba0df4ea4f940 ("ARM:
shmobile: Introduce ARCH_RENESAS") is ARCH_RENESAS a more appropriate
platform dependency than the legacy ARCH_SHMOBILE, hence use the
former.

This will allow to drop ARCH_SHMOBILE on ARM in the near future.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/staging/emxx_udc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/emxx_udc/Kconfig b/drivers/staging/emxx_udc/Kconfig
index d7577096fb25ae7a..e50e722183648c55 100644
--- a/drivers/staging/emxx_udc/Kconfig
+++ b/drivers/staging/emxx_udc/Kconfig
@@ -1,6 +1,6 @@
 config USB_EMXX
 	tristate "EMXX USB Function Device Controller"
- 	depends on USB_GADGET && (ARCH_SHMOBILE || (ARM && COMPILE_TEST))
+	depends on USB_GADGET && (ARCH_RENESAS || (ARM && COMPILE_TEST))
 	help
 	   The Emma Mobile series of SoCs from Renesas Electronics and
 	   former NEC Electronics include USB Function hardware.
-- 
2.7.4
