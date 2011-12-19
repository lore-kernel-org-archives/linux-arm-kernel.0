From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Dec 2011 04:47:45 -0500
Subject: [PATCH 16/20] ARM: mach-w90x900: properly disable CPU idle call
In-Reply-To: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
Message-ID: <1324288069-21940-17-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-w90x900/dev.c                 |    1 +
 arch/arm/mach-w90x900/include/mach/system.h |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-w90x900/dev.c b/arch/arm/mach-w90x900/dev.c
index 7a1fa6adb7..c30aeaaa93 100644
--- a/arch/arm/mach-w90x900/dev.c
+++ b/arch/arm/mach-w90x900/dev.c
@@ -530,6 +530,7 @@ static struct platform_device *nuc900_public_dev[] __initdata = {
 
 void __init nuc900_board_init(struct platform_device **device, int size)
 {
+	disable_hlt();
 	platform_add_devices(device, size);
 	platform_add_devices(nuc900_public_dev, ARRAY_SIZE(nuc900_public_dev));
 	spi_register_board_info(nuc900_spi_board_info,
diff --git a/arch/arm/mach-w90x900/include/mach/system.h b/arch/arm/mach-w90x900/include/mach/system.h
index 2aaeb93116..f713161ee5 100644
--- a/arch/arm/mach-w90x900/include/mach/system.h
+++ b/arch/arm/mach-w90x900/include/mach/system.h
@@ -16,4 +16,5 @@
  */
 static void arch_idle(void)
 {
+	cpu_do_idle();
 }
-- 
1.7.7.1.431.g10b2a
