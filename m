From: colin.tuckley@arm.com (Colin Tuckley)
Date: Tue, 12 Jan 2010 09:30:52 +0000
Subject: [PATCH] ARM: Tidy the use of REALVIEW_SYS_BASE with various
	OSCn_OFFSET defines
Message-ID: <20100112093051.11806.15962.stgit@ARM03585.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Colin Tuckley <colin.tuckley@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mach-realview/core.c                  |    6 +++---
 arch/arm/mach-realview/include/mach/platform.h |    6 +++++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 9f29343..27e2338 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -284,14 +284,14 @@ static const struct icst307_params realview_oscvco_params = {
 
 static void realview_oscvco_set(struct clk *clk, struct icst307_vco vco)
 {
-	void __iomem *sys_lock = __io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_LOCK_OFFSET;
+	void __iomem *sys_lock = __io_address(REALVIEW_SYS_LOCK);
 	void __iomem *sys_osc;
 	u32 val;
 
 	if (machine_is_realview_pb1176())
-		sys_osc = __io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_OSC0_OFFSET;
+		sys_osc = __io_address(REALVIEW_SYS_OSC0);
 	else
-		sys_osc = __io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_OSC4_OFFSET;
+		sys_osc = __io_address(REALVIEW_SYS_OSC4);
 
 	val = readl(sys_osc) & ~0x7ffff;
 	val |= vco.v | (vco.r << 9) | (vco.s << 16);
diff --git a/arch/arm/mach-realview/include/mach/platform.h b/arch/arm/mach-realview/include/mach/platform.h
index 86c0c44..22948cd 100644
--- a/arch/arm/mach-realview/include/mach/platform.h
+++ b/arch/arm/mach-realview/include/mach/platform.h
@@ -51,8 +51,8 @@
 #define REALVIEW_SYS_ID_OFFSET               0x00
 #define REALVIEW_SYS_SW_OFFSET               0x04
 #define REALVIEW_SYS_LED_OFFSET              0x08
-#define REALVIEW_SYS_OSC0_OFFSET             0x0C
 
+#define REALVIEW_SYS_OSC0_OFFSET             0x0C
 #define REALVIEW_SYS_OSC1_OFFSET             0x10
 #define REALVIEW_SYS_OSC2_OFFSET             0x14
 #define REALVIEW_SYS_OSC3_OFFSET             0x18
@@ -89,8 +89,12 @@
 #define REALVIEW_SYS_ID                      (REALVIEW_SYS_BASE + REALVIEW_SYS_ID_OFFSET)
 #define REALVIEW_SYS_SW                      (REALVIEW_SYS_BASE + REALVIEW_SYS_SW_OFFSET)
 #define REALVIEW_SYS_LED                     (REALVIEW_SYS_BASE + REALVIEW_SYS_LED_OFFSET)
+
 #define REALVIEW_SYS_OSC0                    (REALVIEW_SYS_BASE + REALVIEW_SYS_OSC0_OFFSET)
 #define REALVIEW_SYS_OSC1                    (REALVIEW_SYS_BASE + REALVIEW_SYS_OSC1_OFFSET)
+#define REALVIEW_SYS_OSC2                    (REALVIEW_SYS_BASE + REALVIEW_SYS_OSC2_OFFSET)
+#define REALVIEW_SYS_OSC3                    (REALVIEW_SYS_BASE + REALVIEW_SYS_OSC3_OFFSET)
+#define REALVIEW_SYS_OSC4                    (REALVIEW_SYS_BASE + REALVIEW_SYS_OSC4_OFFSET)
 
 #define REALVIEW_SYS_LOCK                    (REALVIEW_SYS_BASE + REALVIEW_SYS_LOCK_OFFSET)
 #define REALVIEW_SYS_100HZ                   (REALVIEW_SYS_BASE + REALVIEW_SYS_100HZ_OFFSET)
